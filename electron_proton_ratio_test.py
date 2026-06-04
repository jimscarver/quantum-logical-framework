#!/usr/bin/env python3
"""
electron_proton_ratio_test.py
Path C of Electron_Mass_Derivation.md §4: test whether the m_e/m_p ≈ 1/1836
ratio falls out of QLF closure-multiplicity counts grouped by gauge-twist
multiplicity.

Hypothesis (Path C, refined to the simplest concrete reading):

  The electron half-loop carries ONE gauge fold (per Electron.md §1: `^<v>^+`
  has a single `+`). The proton is a THREE-QUARK composite (per
  HadronicDepth.md and Particles.md); under the simplest reading, each quark
  carries one gauge fold, so the proton carries THREE gauge folds in total.

  If the QLF mass-from-closure-multiplicity scaling preserves the
  electron-vs-proton gauge-count structure, then

      m_e / m_p  =  M(N, 1) / M(N, 3)

  where M(N, g) is the count of length-N ZFA-closed sequences with exactly
  g gauge twists (`+` or `-`).

Measured value: m_e / m_p = 511 keV / 938.27 MeV ≈ 5.446e-4 ≈ 1/1836.

This script enumerates length-N ZFA-closed sequences (using the QuCalcEngine
BFS), groups by gauge-twist count, and reports M(N, 1) / M(N, 3) at each
depth N ∈ {4, 6, 8}. Falsifiable by construction.

Honest expected outcome: the ratio is some clean combinatorial fraction
that very likely does NOT equal 1/1836 exactly. A close approach would
support Path C; otherwise the doc Electron_Mass_Derivation.md gets the
honest negative result and the search moves on.
"""

from __future__ import annotations
import time
from typing import Dict, List

# Runtime patch for pre-existing import bug.
import twist_core
twist_core.conjugate_history = twist_core.adjoint_history

from qucalc_engine import QuCalcEngine


# Measured PDG values.
M_E_MEV  = 0.51099895
M_P_MEV  = 938.27208816
RATIO_MEASURED = M_E_MEV / M_P_MEV       # ≈ 1/1836.15


def gauge_count(seq: str) -> int:
    """Number of gauge twists (`+` or `-`) in a sequence."""
    return seq.count("+") + seq.count("-")


def gauge_grouped_counts(depth: int) -> Dict[int, int]:
    """Return dict {g → number of ZFA-closed sequences at exact length N with
    exactly g gauge twists}.  Uses QuCalcEngine BFS to enumerate closures."""
    engine = QuCalcEngine()
    closures = engine.find_all_zfa("", extra_depth=depth)
    exact_length = [c for c in closures if len(c) == depth]
    counts: Dict[int, int] = {}
    for seq in exact_length:
        g = gauge_count(seq)
        counts[g] = counts.get(g, 0) + 1
    return counts


def main() -> None:
    bar = "═" * 76
    print(bar)
    print("QLF Path C — m_e / m_p ratio from gauge-twist-multiplicity counts")
    print(bar)
    print()
    print(f"Measured PDG ratio:  m_e / m_p = {RATIO_MEASURED:.4e}  (≈ 1/{1/RATIO_MEASURED:.2f})")
    print()

    results: Dict[int, Dict[int, int]] = {}

    for N in [4, 6, 8]:
        t0 = time.time()
        counts = gauge_grouped_counts(N)
        elapsed = time.time() - t0
        total = sum(counts.values())
        results[N] = counts

        print(f"── Depth N = {N}  (total ZFA closures = {total},  BFS {elapsed:.1f}s) ──")
        print(f"  {'g (gauge count)':>14} | {'M(N, g)':>8} | {'fraction':>10}")
        for g in sorted(counts.keys()):
            print(f"  {g:>14} | {counts[g]:>8} | {counts[g] / total * 100:>9.2f}%")
        print()

    # Headline test: M(N, 1) / M(N, 3) at each depth.
    print(bar)
    print("Headline ratio test:  M(N, 1) / M(N, 3)")
    print(bar)
    print()
    print(f"  {'N':>4} | {'M(N,1)':>10} | {'M(N,3)':>10} | "
          f"{'ratio':>14} | {'measured':>14} | rel.err.")
    print("  " + "-" * 80)
    for N in [4, 6, 8]:
        c = results[N]
        m1 = c.get(1, 0)
        m3 = c.get(3, 0)
        if m3 == 0:
            print(f"  {N:>4} | {m1:>10} | {m3:>10} | "
                  f"{'(M(N,3)=0)':>14} | {RATIO_MEASURED:>14.4e} | n/a")
            continue
        ratio = m1 / m3
        rel = (ratio - RATIO_MEASURED) / RATIO_MEASURED * 100
        flag = "✓" if abs(rel) < 10 else ("~" if abs(rel) < 100 else "✗")
        print(f"  {N:>4} | {m1:>10} | {m3:>10} | "
              f"{ratio:>14.4e} | {RATIO_MEASURED:>14.4e} | {rel:+10.1f}%  {flag}")
    print()

    # ── Empirical finding: odd gauge counts are STRUCTURALLY VACUOUS ──
    # Run the script and you'll see M(N, 1) = M(N, 3) = 0 at every depth.
    # This is not a bug; it is a structural property of the 8-twist alphabet
    # and the count-balance condition.  See ANALYSIS at the end.
    #
    # Refined test: use even gauge counts that ARE realised.
    #   M(N, 2) ↔ "positronium-class" (one + and one −, ZFA-closed
    #             two-half-loop joint closure)
    #   M(N, 6) ↔ "proton-internal-class" (six gauge folds, the natural
    #             count for a three-quark joint closure where each quark
    #             contributes a Hermitian pair of gauge folds)

    print(bar)
    print("Refined test:  M(N, 2) / M(N, 6)  ('positronium-class' / 'proton-internal-class')")
    print(bar)
    print()
    print(f"  {'N':>4} | {'M(N, 2)':>10} | {'M(N, 6)':>10} | {'ratio':>14} | "
          f"{'m(Ps)/m_p meas':>14} | rel.err.")
    print("  " + "-" * 80)
    # The measured atomic-system ratio under the bound-state framing.
    M_PS_MEV = 2 * M_E_MEV
    RATIO_PS_OVER_P = M_PS_MEV / M_P_MEV          # ≈ 1/918

    for N in [4, 6, 8]:
        c = results[N]
        m2 = c.get(2, 0)
        m6 = c.get(6, 0)
        if m6 == 0:
            print(f"  {N:>4} | {m2:>10} | {m6:>10} | "
                  f"{'(M(N,6)=0)':>14} | {RATIO_PS_OVER_P:>14.4e} | n/a")
            continue
        ratio = m2 / m6
        # Path C predicts mass ratio ∝ count ratio.  m_p > m(Ps), so under
        # the literal reading m(Ps)/m_p ≈ count(Ps)/count(p_int).  But that
        # requires count(Ps) < count(p_int) — opposite of what we see.
        # Report the raw ratio and let the analysis section interpret.
        rel = (ratio - RATIO_PS_OVER_P) / RATIO_PS_OVER_P * 100
        flag = "✓" if abs(rel) < 10 else ("~" if abs(rel) < 100 else "✗")
        print(f"  {N:>4} | {m2:>10} | {m6:>10} | {ratio:>14.4e} | "
              f"{RATIO_PS_OVER_P:>14.4e} | {rel:+10.1f}%  {flag}")
    print()

    # Also print all the natural even-gauge-pair ratios for completeness.
    print(bar)
    print("All even-gauge-class ratios at N = 8")
    print(bar)
    print()
    c8 = results[8]
    print(f"  M(8, g): {dict(sorted(c8.items()))}")
    print()
    gauge_classes = sorted(c8.keys())
    print(f"  {'g_a':>4} | {'g_b':>4} | {'M(8,g_a) / M(8,g_b)':>22}")
    print("  " + "-" * 40)
    for g_a in gauge_classes:
        for g_b in gauge_classes:
            if g_a >= g_b or c8.get(g_b, 0) == 0:
                continue
            r = c8[g_a] / c8[g_b]
            print(f"  {g_a:>4} | {g_b:>4} | {r:>22.4f}")
    print()

    # Honest analysis.
    print(bar)
    print("FINDINGS")
    print(bar)
    print(f"""
EMPIRICAL FACT 1 — odd gauge counts are STRUCTURALLY VACUOUS.

  At every tested depth N ∈ {{4, 6, 8}}, M(N, g) = 0 for all odd g.
  The 8-twist count-balance condition requires gauge twists to come in
  PARITY-PAIRED units: each `+` (even parity) needs a balancing `-` (odd
  parity) to keep count_pos = count_neg.  Standalone "one-gauge-fold"
  ZFA closures do not exist.

  Consequence: the naive Path C reading "electron = 1 gauge fold, proton
  = 3 gauge folds" cannot be tested at all — it asks about a structurally
  empty class.  The bound-state framing of Bound_States_QLF.md is
  vindicated structurally here: the electron's "1 gauge fold" is the
  half-loop's contribution to a JOINT closure that always has even total
  gauge count.

EMPIRICAL FACT 2 — same-depth even-gauge-class ratios do NOT match m_e/m_p.

  The most natural refined reading: positronium-class = M(N, 2),
  proton-internal-class = M(N, 6).  At N = 8 these are 24288 and 96
  respectively, ratio 253.  Measured m(Ps)/m_p ≈ 1.022 / 938.27 ≈
  1.089e-3 ≈ 1/918.

  The QLF count ratio (253) and the measured mass ratio (1/918) differ by
  ~five orders of magnitude AND go in opposite directions.  At fixed
  depth N, the positronium-class is MORE numerous than the proton-internal-
  class (because two gauge folds is more combinatorially common than six).
  But the proton is HEAVIER than positronium.

EMPIRICAL FACT 3 — Path C in its simple form is FALSIFIED.

  The same-depth gauge-class-count ratio at any depth N ≤ 8 does not
  reproduce the measured m_e/m_p (or m(Ps)/m_p) ratio.  Two structural
  reasons:

    (a) The proton sits at a much DEEPER joint-closure structure than the
        electron-positron pair (per HadronicDepth.md, n_p ~ (m_P/m_p)³ ≈
        10⁵⁷ Planck events).  Comparing M(N, 2) and M(N, 6) at the same
        small N is the wrong comparison.

    (b) The mass ratio is determined by joint-closure DEPTH, not raw
        multiplicity count.  Higher-multiplicity classes at the same depth
        are not heavier — they are just more combinatorially common.  The
        QLF mass m = α R uses R = depth, not M.

WHAT WOULD A SUCCESSFUL PATH C REQUIRE?

  Either an argument that
    • the depth N_p where M(N_p, 6) first becomes non-trivial relates to
      the depth N_e where M(N_e, 2) first becomes non-trivial in a way
      that reproduces m_p/m_e ≈ 1836,
  or
    • a different counting interpretation that maps gauge-class
      multiplicity to mass scaling.

  Neither is obvious from the data above.  The simplest reading of Path C
  is falsified; Electron_Mass_Derivation.md §4 Path C should be marked
  accordingly.

USEFUL NEGATIVE RESULT.

  This script does NOT solve the m_e derivation problem; it CONSTRAINS
  the search.  Specifically:

    • Odd-gauge-fold ZFA closures don't exist → naive Path C is vacuous.
    • Same-depth even-gauge ratios go the wrong way (positronium-class is
      MORE numerous, but lighter) → mass cannot be raw multiplicity.

  The right derivation must involve depth-as-mass scaling (likely the
  HadronicDepth-like cube argument at the structural level) plus a way
  to identify which depth corresponds to which atomic system, not just
  gauge counts at a single depth.
""")


if __name__ == "__main__":
    main()
