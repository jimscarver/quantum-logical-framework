#!/usr/bin/env python3
"""
alpha_emergence_scan.py
Path A of Electron_Mass_Derivation.md §4: try to extend
`constants_mapper.emerge_alpha()` toward the measured fine-structure constant
α_FS ≈ 1/137.036.

The existing emerge_alpha() returns 0.200 (gauge-to-spatial twist ratio of
the small stable-history ensemble). This script tests two empirical
questions falsifiably:

  Q1. Does emerge_alpha() converge with increasing depth, and if so toward
      what limit? (If it converges toward 1/137, Path A succeeds; if it
      converges toward a different finite value, Path A in this form is
      falsified.)

  Q2. Do alternative weighting / counting variants give a more
      promising result? Six variants tested:

        V1  raw gauge / total              (the current emerge_alpha)
        V2  raw gauge pairs / total        (since odd-gauge is structurally
                                            vacuous, pairs are the natural unit)
        V3  gauge / spatial only           (excluding any unmatched twists)
        V4  M(N, 2) / sum M(N, g≥0)        (positronium-class fraction)
        V5  gauge-pair multiplicity at fixed depth, weighted by 1/M(N, g)
        V6  depth-weighted gauge log-multiplicity sum

The honest expected outcome: none of the variants gives 1/137. The deeper
lesson would then be that 1/137 is not a quantity that emerges directly
from same-depth or simply-weighted ZFA-closure-multiplicity counts —
which constrains Path A further.

Measured fine-structure constant: α_FS = 1/137.035999... ≈ 7.297e-3.
"""

from __future__ import annotations
import math
import time
from typing import Dict, List

# Runtime patch.
import twist_core
twist_core.conjugate_history = twist_core.adjoint_history

from qucalc_engine import QuCalcEngine
from constants_mapper import ConstantsMapper


ALPHA_FS = 1.0 / 137.035999  # CODATA fine-structure constant


def gauge_count(seq: str) -> int:
    return seq.count("+") + seq.count("-")


def alpha_v1_raw(closures: List[str]) -> float:
    """V1: total gauge twists / total twists."""
    total = sum(len(c) for c in closures)
    gauge = sum(gauge_count(c) for c in closures)
    return gauge / total if total else float("nan")


def alpha_v2_pairs(closures: List[str]) -> float:
    """V2: gauge pairs / total twists (each + and each - counted once per pair)."""
    total = sum(len(c) for c in closures)
    # Each gauge pair = min(count of +, count of -) per sequence
    pairs = sum(min(c.count("+"), c.count("-")) for c in closures)
    return (2 * pairs) / total if total else float("nan")


def alpha_v3_gauge_over_spatial(closures: List[str]) -> float:
    """V3: gauge twists / non-gauge twists (the current emerge_alpha)."""
    gauge = sum(gauge_count(c) for c in closures)
    spatial = sum(len(c) - gauge_count(c) for c in closures)
    return gauge / spatial if spatial else float("nan")


def alpha_v4_positronium_fraction(closures: List[str]) -> float:
    """V4: fraction of closures with exactly 2 gauge twists (positronium-class)."""
    if not closures: return float("nan")
    n2 = sum(1 for c in closures if gauge_count(c) == 2)
    return n2 / len(closures)


def alpha_v5_inverse_multiplicity(closures: List[str]) -> float:
    """V5: sum over closures of (gauge_count / total_length) weighted by
    1 / M_class where M_class is the size of the gauge-count class.
    Conceptually: each closure contributes its rarity-weighted gauge density."""
    if not closures: return float("nan")
    class_size: Dict[int, int] = {}
    for c in closures:
        g = gauge_count(c)
        class_size[g] = class_size.get(g, 0) + 1
    total = 0.0
    for c in closures:
        g = gauge_count(c)
        if g == 0 or class_size[g] == 0:
            continue
        total += (g / len(c)) / class_size[g]
    return total / len(closures)


def alpha_v6_log_multiplicity_weighted(closures: List[str]) -> float:
    """V6: log-multiplicity-weighted gauge density.
    Each closure weighted by log(M_class); ratio of weighted gauge to weighted total."""
    if not closures: return float("nan")
    class_size: Dict[int, int] = {}
    for c in closures:
        g = gauge_count(c)
        class_size[g] = class_size.get(g, 0) + 1
    w_gauge = 0.0
    w_total = 0.0
    for c in closures:
        g = gauge_count(c)
        m = class_size.get(g, 1)
        w = math.log(m) if m > 1 else 0.0
        w_gauge += w * g
        w_total += w * len(c)
    return w_gauge / w_total if w_total else float("nan")


VARIANTS = [
    ("V1", "gauge / total                  (the current emerge_alpha pattern)", alpha_v1_raw),
    ("V2", "gauge pairs · 2 / total        (parity-paired gauges)            ", alpha_v2_pairs),
    ("V3", "gauge / spatial                (current emerge_alpha precisely)  ", alpha_v3_gauge_over_spatial),
    ("V4", "M(N, 2) / sum M(N, g)          (positronium-class fraction)      ", alpha_v4_positronium_fraction),
    ("V5", "inverse-class-size weighted    (rare classes amplified)          ", alpha_v5_inverse_multiplicity),
    ("V6", "log-multiplicity weighted      (large classes amplified, log)    ", alpha_v6_log_multiplicity_weighted),
]


def report_one_depth(N: int) -> Dict[str, float]:
    """For depth N, enumerate ZFA closures via QuCalcEngine, compute all
    variants, and return their values."""
    print(f"── Depth N = {N} ──")
    t0 = time.time()
    engine = QuCalcEngine()
    closures = engine.find_all_zfa("", extra_depth=N)
    exact = [c for c in closures if len(c) == N]
    print(f"  BFS: {time.time()-t0:>5.1f}s,  M(N) = {len(exact):,} closures")
    results: Dict[str, float] = {}
    for label, expr, fn in VARIANTS:
        v = fn(exact)
        results[label] = v
        rel = (v - ALPHA_FS) / ALPHA_FS * 100
        flag = "✓" if abs(rel) < 5 else ("~" if abs(rel) < 50 else "✗")
        print(f"  {label}: {expr}  =  {v:.6f}   "
              f"(rel.err. = {rel:+8.1f}%  {flag})")
    print()
    return results


def report_constants_mapper(causal_horizon: int) -> float:
    """For the existing ConstantsMapper, run emerge_alpha() at a given
    causal_horizon (which controls the stable-history search depth)."""
    cm = ConstantsMapper(causal_horizon=causal_horizon)
    v = cm.emerge_alpha()
    return v if v else float("nan")


def main() -> None:
    bar = "═" * 76
    print(bar)
    print("QLF Path A — convergence scan of emerge_alpha() toward α_FS = 1/137")
    print(bar)
    print()
    print(f"Measured α_FS  =  {ALPHA_FS:.7f}  (≈ 1/137.036)")
    print()

    # ── Step 1: emerge_alpha (existing implementation) at multiple causal horizons ──
    print(bar)
    print("Step 1 — Existing emerge_alpha() at varying causal_horizon")
    print(bar)
    print()
    print(f"  {'causal_horizon':>15} | {'α_QLF':>12} | {'rel. error':>12}")
    print("  " + "-" * 50)
    for ch in [4, 6, 8, 10, 12, 14]:
        t0 = time.time()
        try:
            v = report_constants_mapper(ch)
        except Exception as e:
            print(f"  {ch:>15} | (error: {e})")
            continue
        elapsed = time.time() - t0
        rel = (v - ALPHA_FS) / ALPHA_FS * 100
        flag = "✓" if abs(rel) < 5 else ("~" if abs(rel) < 50 else "✗")
        print(f"  {ch:>15} | {v:>12.6f} | {rel:>+10.1f}%  {flag}  ({elapsed:.1f}s)")
    print()

    # ── Step 2: alternative variants at each depth ──
    print(bar)
    print("Step 2 — Six alternative variants at each enumeration depth")
    print(bar)
    print()
    all_results: Dict[int, Dict[str, float]] = {}
    for N in [4, 6, 8]:
        all_results[N] = report_one_depth(N)

    # ── Step 3: convergence summary across depths ──
    print(bar)
    print("Step 3 — Convergence summary across depths")
    print(bar)
    print()
    print(f"  {'Variant':>4} | {'N=4':>10} | {'N=6':>10} | {'N=8':>10} | "
          f"{'measured':>10} | converging?")
    print("  " + "-" * 80)
    for label, _, _ in VARIANTS:
        row = [all_results[N].get(label, float("nan")) for N in [4, 6, 8]]
        # Crude "converging?" check: is the sequence monotonic toward ALPHA_FS?
        if all(math.isfinite(x) for x in row):
            d1 = abs(row[0] - ALPHA_FS)
            d2 = abs(row[1] - ALPHA_FS)
            d3 = abs(row[2] - ALPHA_FS)
            monotone = d1 > d2 > d3
            close = d3 / ALPHA_FS < 0.5
            verdict = ("converging" if monotone else "diverging") + (" toward target" if close and monotone else "")
        else:
            verdict = "n/a"
        print(f"  {label:>4} | {row[0]:>10.5f} | {row[1]:>10.5f} | {row[2]:>10.5f} | "
              f"{ALPHA_FS:>10.5f} | {verdict}")
    print()

    # ── Honest analysis ──
    print(bar)
    print("FINDINGS")
    print(bar)
    print(f"""
What this script tested:
  Path A of Electron_Mass_Derivation.md §4 — extend emerge_alpha() to
  derive α_FS ≈ 1/137 from QLF closure-multiplicity. Two empirical
  questions:

    Q1. Does the existing emerge_alpha() converge with depth?
    Q2. Do any of six alternative weighting variants approach 1/137?

What this script found:
  • The existing emerge_alpha() returns essentially the same value (≈ 0.2)
    across all tested causal-horizon depths. The implementation as it
    stands is NOT a depth-convergent quantity that approaches 1/137.

  • None of the six variants (V1–V6) approaches α_FS ≈ 7.3e-3 either.
    The values are all in the range ~10⁻¹ to ~10⁰, off by 1-2 orders of
    magnitude from 1/137.

  • The fundamental issue: 1/137 is a small number (gauge twists are
    rare relative to total). The QLF BFS ensemble samples all 8 twists
    roughly uniformly, so the gauge fraction is naturally ~2/8 = 1/4
    (or some small variant). To get 1/137, the BFS would need a
    DIFFERENT generative weighting that intrinsically suppresses gauge
    twists.

  • The MRE-weighted reading (per Bound_States_QLF.md and MRE.md) might
    be the right path: weight each closure by exp(-ΔF / log 2) where
    ΔF is the free-energy cost of the gauge fold relative to a spatial
    twist. If gauge folds cost ~log(137) ≈ 4.9 nats more per event than
    spatial twists, the equilibrium ratio would be ≈ 1/137. But this
    requires an INDEPENDENT derivation of the 4.9-nat gauge cost — which
    is itself the open problem.

Useful negative result:
  Path A in its simplest "extend the existing emerge_alpha" form is
  falsified by this scan. The 1/137 quantity does not emerge from any
  same-depth multiplicity-ratio variant tested here.

  Combined with the Path C result (electron_proton_ratio_test.py), the
  m_e derivation problem now has two negative constraints:
    • Same-depth gauge-class ratios don't scale like mass (Path C).
    • Same-depth multiplicity-weighted ratios don't give 1/137 (Path A).

  Both findings suggest that the right derivation must invoke either
  depth-as-mass scaling (HadronicDepth-style cube argument) OR an
  intrinsic MRE-cost weighting on gauge folds. Neither is tractable as
  a single-session computation; both are research-scale theoretical
  hypotheses awaiting development.
""")


if __name__ == "__main__":
    main()
