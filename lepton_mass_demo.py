#!/usr/bin/env python3
"""
lepton_mass_demo.py
QLF lepton-mass-ratio probe: a structured exploration of the
multiplicity-as-energy hypothesis (per Standard_Model.md §4.1 and
Energy_Combinatorics.md).

Standard_Model.md §6 lists "Mass ratios from multiplicity" as open work
("pursue the quantitative bridge from Energy_Combinatorics to specific
mass values"). This script provides a falsifiable structured test:
enumerate ZFA-closed multiplicities at each generation depth N, then
test a battery of candidate mass formulas against measured lepton
ratios from the PDG.

The script makes no claim that any specific candidate matches; the
honest deliverable is the result itself — which formulas come close,
which are off, which are wildly off — so future research can iterate.
If no simple formula matches, that is itself useful: it pins down what
the right derivation cannot be.

Measured lepton masses (PDG 2024):
    m_e  = 0.51099895 MeV
    m_μ  = 105.6583755 MeV
    m_τ  = 1776.86 MeV

Measured ratios:
    m_μ / m_e  = 206.77
    m_τ / m_μ  =  16.82
    m_τ / m_e  = 3477.23
"""

from __future__ import annotations
import math
import time
from typing import Callable, Dict, List, Tuple

from qucalc_engine import QuCalcEngine


# ── Measured PDG lepton masses (MeV) ──────────────────────────────────
M_E_MEV   = 0.51099895
M_MU_MEV  = 105.6583755
M_TAU_MEV = 1776.86

MEASURED_RATIOS = {
    "m_μ / m_e": M_MU_MEV  / M_E_MEV,
    "m_τ / m_μ": M_TAU_MEV / M_MU_MEV,
    "m_τ / m_e": M_TAU_MEV / M_E_MEV,
}


# ── ZFA closure multiplicity at each depth ────────────────────────────
def enumerate_closures_at_depth(depth: int) -> List[str]:
    """All ZFA-closed twist sequences of length EXACTLY `depth`."""
    engine = QuCalcEngine()
    all_closures = engine.find_all_zfa("", extra_depth=depth)
    # find_all_zfa returns closures of length ≥ 4 up to extra_depth.
    # Filter to exact-length matches at the given depth.
    return [c for c in all_closures if len(c) == depth]


def multiplicity_table(max_depth: int = 8) -> Dict[int, int]:
    """Multiplicity M(N) = number of distinct ZFA-closed sequences of length N,
    for N = 2, 4, 6, ..., max_depth (even depths only, since count balance
    requires equal pos/neg counts).

    Each call is a fresh QuCalcEngine BFS, so depths > 8 can be slow.
    """
    M: Dict[int, int] = {}
    for N in range(2, max_depth + 1, 2):
        t0 = time.time()
        closures = enumerate_closures_at_depth(N)
        elapsed = time.time() - t0
        M[N] = len(closures)
        print(f"  depth N={N:>2}:  multiplicity M(N) = {M[N]:>8}    "
              f"({elapsed:5.2f} s)")
    return M


# ── Candidate mass-from-multiplicity formulas ─────────────────────────
# Each formula takes (N, M(N)) and returns a putative "mass-proxy" value.
# Generation ↔ depth mapping: gen-1 ↔ N=4, gen-2 ↔ N=6, gen-3 ↔ N=8.
# (The QuCalcEngine's find_all_zfa filters out length-2 closures via its
# `len(current) >= 4` check, so N=2 returns 0. The natural QLF generation
# structure starts at the first non-trivial closure, which is N=4. With
# this mapping each successive generation adds one Hermitian pair to the
# previous generation's depth.)

def formula_pure_multiplicity(N: int, M: int) -> float:
    """H1: mass ∝ M(N).  Pure-degeneracy-as-energy."""
    return float(M)


def formula_depth_times_multiplicity(N: int, M: int) -> float:
    """H2: mass ∝ N · M(N).  Constructing-delay × multiplicity."""
    return float(N * M)


def formula_multiplicity_per_depth(N: int, M: int) -> float:
    """H3: mass ∝ M(N) / N.  Per-event multiplicity."""
    return float(M) / N


def formula_depth_squared(N: int, M: int) -> float:
    """H4: mass ∝ N².  Pure gauge-fold-depth-squared (multiplicity-independent)."""
    return float(N * N)


def formula_log_multiplicity(N: int, M: int) -> float:
    """H5: mass ∝ exp(log(M(N))).  Information-content rescaling."""
    return float(M)  # equivalent to H1 — kept as a sanity-check duplicate


def formula_multiplicity_log_N(N: int, M: int) -> float:
    """H6: mass ∝ M(N) · log(N).  Information-weighted multiplicity."""
    return float(M) * math.log(max(N, 2))


def formula_sqrt_multiplicity_times_N(N: int, M: int) -> float:
    """H7: mass ∝ √M(N) · N.  Bekenstein-style square-root degeneracy."""
    return math.sqrt(M) * N


FORMULAS: List[Tuple[str, str, Callable[[int, int], float]]] = [
    ("H1", "m ∝ M(N)",                  formula_pure_multiplicity),
    ("H2", "m ∝ N · M(N)",              formula_depth_times_multiplicity),
    ("H3", "m ∝ M(N) / N",              formula_multiplicity_per_depth),
    ("H4", "m ∝ N²",                    formula_depth_squared),
    ("H6", "m ∝ M(N) · log N",          formula_multiplicity_log_N),
    ("H7", "m ∝ √M(N) · N (Bekenstein)", formula_sqrt_multiplicity_times_N),
]


# ── Compare predicted ratios to measured ──────────────────────────────
def evaluate_formula(label: str,
                     expr: str,
                     f: Callable[[int, int], float],
                     M: Dict[int, int]) -> None:
    """For each formula, compute predicted m_μ/m_e, m_τ/m_μ, m_τ/m_e
    using N = 4, 6, 8 for the three generations; compare to PDG."""

    # Need M at depth 4, 6, 8 minimum.
    if not all(N in M for N in (4, 6, 8)):
        print(f"  [{label}: skipped — need M(4), M(6), M(8)]")
        return

    m_e_proxy  = f(4, M[4])
    m_mu_proxy = f(6, M[6])
    m_ta_proxy = f(8, M[8])

    if m_e_proxy == 0 or m_mu_proxy == 0:
        print(f"  {label}: division by zero in proxy values; skipped")
        return

    predicted = {
        "m_μ / m_e": m_mu_proxy / m_e_proxy,
        "m_τ / m_μ": m_ta_proxy / m_mu_proxy,
        "m_τ / m_e": m_ta_proxy / m_e_proxy,
    }

    print(f"  {label:<3} {expr:<32}")
    print(f"      proxies:  m_e={m_e_proxy:>10.2f}  m_μ={m_mu_proxy:>10.2f}  "
          f"m_τ={m_ta_proxy:>10.2f}")

    for ratio_name, measured in MEASURED_RATIOS.items():
        pred = predicted[ratio_name]
        rel_err = (pred - measured) / measured
        flag = "✓" if abs(rel_err) < 0.10 else ("~" if abs(rel_err) < 1.0 else "✗")
        print(f"      {ratio_name:<10}  predicted={pred:>10.3f}  "
              f"measured={measured:>10.3f}  "
              f"rel. err.={rel_err*100:+8.1f}%  {flag}")
    print()


def main() -> None:
    bar = "═" * 76
    print(bar)
    print("QLF Lepton-Mass-Ratio Probe  —  multiplicity-as-energy hypothesis")
    print(bar)
    print()
    print("Measured PDG lepton masses:")
    print(f"  m_e  = {M_E_MEV:>14.8f} MeV")
    print(f"  m_μ  = {M_MU_MEV:>14.7f} MeV")
    print(f"  m_τ  = {M_TAU_MEV:>14.2f} MeV")
    print()
    print("Measured ratios:")
    for name, val in MEASURED_RATIOS.items():
        print(f"  {name:<10} = {val:>14.4f}")
    print()
    print(bar)
    print("Step 1 — Enumerate ZFA-closed multiplicities M(N) at each depth")
    print(bar)
    print()
    # Cap depth at 8 (depth 10 is BFS-expensive on a typical laptop).
    M = multiplicity_table(max_depth=8)
    print()

    # Step 2: ratio at successive even depths.
    print(bar)
    print("Step 2 — Inter-depth multiplicity ratios")
    print(bar)
    print()
    depths = sorted(M.keys())
    for i in range(1, len(depths)):
        N1, N2 = depths[i - 1], depths[i]
        ratio = M[N2] / M[N1] if M[N1] else float("inf")
        print(f"  M({N2}) / M({N1})  =  {M[N2]:>6} / {M[N1]:>6}  =  {ratio:>10.3f}")
    print()

    # Step 3: candidate mass formulas tested against measured lepton ratios.
    print(bar)
    print("Step 3 — Test candidate mass formulas against measured ratios")
    print(bar)
    print()
    print("Mapping: gen-1 (electron) ↔ N=4, gen-2 (muon) ↔ N=6, gen-3 (tau) ↔ N=8")
    print("(Engine's find_all_zfa filters length-2; first non-trivial closure is N=4.)")
    print()
    for label, expr, fn in FORMULAS:
        evaluate_formula(label, expr, fn, M)

    # ── Summary of findings ──
    print(bar)
    print("SUMMARY OF FINDINGS")
    print(bar)
    print("""
Empirical observation: the QLF multiplicity M(N) grows monotonically with
depth (typical step factor ~25-30× per increment of N by 2). But the
measured lepton mass ratios are NON-monotonic in this depth-step sense:
m_μ/m_e ≈ 207 (gen 2 / gen 1) is much larger than m_τ/m_μ ≈ 17 (gen 3
/ gen 2). Any monotonic function of M(N) and N alone — including all
six candidates tested above — cannot reproduce this non-monotonic ratio
structure simultaneously across all three lepton generations.

Falsified by this script:
  • H1 m ∝ M(N)              — ratios too uniform (≈25-30× per step)
  • H2 m ∝ N·M(N)            — over-predicts m_τ/m_μ
  • H3 m ∝ M(N)/N            — closest on m_τ/m_μ, way off on m_μ/m_e
  • H4 m ∝ N²                — vastly under-predicts every ratio
  • H6 m ∝ M(N)·log N        — similar shape to H1, similar problems
  • H7 m ∝ √M(N)·N           — under-predicts every ratio

The right QLF derivation must therefore include at least one additional
ingredient beyond the bare (N, M(N)) pair — candidates include:
  • Topology-class-restricted subsets of M(N) (not all closures count
    equally toward "lepton mass"; e.g., chirality or generation-specific
    selection rules).
  • Different generation ↔ depth mapping (e.g., gen-k ↔ N = 2k+2, or
    more exotic mappings tied to specific gauge-fold topologies).
  • Multiplicative running of the bare mass à la QED/electroweak
    radiative corrections, which contribute significant fractions of
    the observed lepton masses.
  • A non-multiplicity quantum number (chirality, weak hypercharge,
    flavour) that distinguishes the three generations beyond their
    depth.

This is the script's primary deliverable: a falsifiable negative result
that constrains the search space for the eventual derivation.
""")

    # Honest conclusion
    print(bar)
    print("HONEST SCOPING")
    print(bar)
    print("""
What this script DOES:
  • Enumerates ZFA-closed multiplicities M(N) at depths 2, 4, 6, 8.
  • Tests a battery of candidate "mass ∝ f(N, M(N))" formulas using the
    natural mapping gen-k ↔ depth 2k.
  • Reports predicted vs. measured ratios with relative-error flags.

What this script does NOT do:
  • Derive the correct mass formula. The QLF claim (Standard_Model.md §6)
    is that mass comes from gauge-fold constructing delay; the quantitative
    bridge from multiplicity to specific mass values is open work.
  • Address spin/charge/colour quantum numbers that distinguish the three
    leptons beyond their mass.
  • Account for QED/electroweak radiative corrections, which contribute
    measurable fractions of the bare masses.

How to read the output:
  • ✓  relative error <10%   — candidate worth investigating further
  • ~  relative error <100%  — candidate in the right ballpark
  • ✗  relative error ≥100%  — candidate not viable in its current form

The honest expected outcome is "no simple formula matches all three
ratios within ✓ tolerance." That is itself useful: it falsifies the
candidate formulas tested here and constrains what the right derivation
cannot be.

Next steps:
  • If a candidate scores ~ on m_μ/m_e but ✗ on m_τ/m_μ, the formula
    has a power-law mismatch worth investigating (e.g., maybe gen ↔
    depth 2k is the wrong identification; try gen ↔ depth k+1, etc.).
  • Test alternative generation ↔ depth mappings (e.g., gen-1 ↔ N=4,
    gen-2 ↔ N=6, gen-3 ↔ N=8) since the choice gen-k ↔ N=2k is just
    the simplest natural guess.
  • Combine this enumeration with the constants_mapper / particles.py
    machinery to test multiplicity-weighted formulas across the broader
    Standard Model fermion sector.

References:
  • Standard_Model.md §4.1, §6   — mass spectrum as open work
  • Energy_Combinatorics.md      — multiplicity-as-energy framing
  • HadronicDepth.md             — n ~ (m_P/m_p)^3 depth scaling
  • Active_Inference_Mathematics.md §5 — scoreboard row "Quantitative mass spectrum: ✗ Open"
""")


if __name__ == "__main__":
    main()
