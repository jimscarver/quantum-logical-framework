#!/usr/bin/env python3
"""
lepton_mass_irreducible_test.py
Tests the refined hypothesis: stable particles correspond to TOTALLY
IRREDUCIBLE ZFA closures at prime qubit counts.

User intuition (rephrased): "stable particles pairs close together, not
separately. Prime numbers of qubits are needed for stability."

Interpretation:
  1. "Close together, not separately" = the closure is irreducible —
     no proper sub-sequence is itself ZFA-closed.
  2. "Prime number of qubits" = qubit count N/2 ∈ {2, 3, 5, 7, ...}.

The QuCalcEngine BFS already applies a "no adjacent Hermitian pair"
filter, which excludes length-2 sub-closures. But it does NOT exclude
embedded length-4, length-6, ... sub-closures. For example, the
length-6 sequence `^<v>><` is in the engine's M(6)=1200 count even
though `^<v>` (positions 1–4) is itself a length-4 ZFA-closure.

This script applies the STRONGER filter: no proper sub-sequence of any
even length is ZFA-closed. The resulting M_irr(N) is the count of
genuinely irreducible joint closures — "stable particles" under the
user's hypothesis.

Measured PDG ratios:
    m_μ / m_e = 206.768
    m_τ / m_μ =  16.817
"""

from __future__ import annotations
import time
from typing import Dict, List

from qucalc_engine import QuCalcEngine
from twist_core import is_zfa


# ── Measured PDG lepton masses (MeV) ──────────────────────────────────
M_E_MEV   = 0.51099895
M_MU_MEV  = 105.6583755
M_TAU_MEV = 1776.86

MEASURED_RATIOS = {
    "m_μ / m_e": M_MU_MEV  / M_E_MEV,
    "m_τ / m_μ": M_TAU_MEV / M_MU_MEV,
}


def is_totally_irreducible(seq: str) -> bool:
    """A sequence is totally irreducible if no proper sub-sequence
    (contiguous, of any even length from 2 to len(seq)-2) is itself
    ZFA-closed. Adjacent-pair sub-closures and embedded multi-twist
    sub-closures are both filtered."""
    N = len(seq)
    for L in range(2, N, 2):
        for start in range(N - L + 1):
            sub = seq[start:start + L]
            if is_zfa(sub):
                return False
    return True


def enumerate_irreducible(depth: int) -> List[str]:
    """All totally irreducible ZFA-closed sequences of exactly length `depth`."""
    engine = QuCalcEngine()
    all_closures = engine.find_all_zfa("", extra_depth=depth)
    exact_length = [c for c in all_closures if len(c) == depth]
    return [c for c in exact_length if is_totally_irreducible(c)]


def main() -> None:
    bar = "═" * 76
    print(bar)
    print("QLF Lepton-Mass Probe — Irreducible Stable Closures (Prime Qubit Count)")
    print(bar)
    print()
    print("Refined hypothesis (from user):")
    print("  • Stable particles correspond to TOTALLY IRREDUCIBLE closures.")
    print("  • A closure is irreducible if NO proper sub-sequence is ZFA-closed.")
    print("  • Prime number of qubits (N/2 ∈ {2, 3, 5, ...}) needed for stability.")
    print()
    print("Mapping: gen-1 ↔ N=4 (2 qubits), gen-2 ↔ N=6 (3 qubits)")
    print("         gen-3 ↔ N=10 (5 qubits, not enumerated — too expensive)")
    print()

    # Enumerate at each depth.
    print(bar)
    print("Step 1 — Enumerate totally irreducible ZFA closures M_irr(N)")
    print(bar)
    print()
    M     : Dict[int, int] = {}    # engine count (already filters adjacent pairs)
    M_irr : Dict[int, int] = {}    # totally irreducible count

    for N in [4, 6, 8]:
        t0 = time.time()
        engine = QuCalcEngine()
        all_at_depth = [c for c in engine.find_all_zfa("", extra_depth=N) if len(c) == N]
        t_bfs = time.time() - t0
        M[N] = len(all_at_depth)

        t0 = time.time()
        irr_at_depth = [c for c in all_at_depth if is_totally_irreducible(c)]
        t_filter = time.time() - t0
        M_irr[N] = len(irr_at_depth)

        frac = (M_irr[N] / M[N] * 100) if M[N] else 0.0
        print(f"  N={N:>2}  qubits={N//2:>2}  prime?={'Y' if N//2 in (2,3,5,7,11,13) else 'N'}  "
              f"M(N) = {M[N]:>6}   "
              f"M_irr(N) = {M_irr[N]:>6}  ({frac:>5.1f}% of M(N))  "
              f"[BFS {t_bfs:>5.1f}s  filter {t_filter:>5.1f}s]")
    print()

    # Inter-depth ratios.
    print(bar)
    print("Step 2 — Inter-depth ratios for the irreducible count M_irr(N)")
    print(bar)
    print()
    depths = sorted(M_irr.keys())
    for i in range(1, len(depths)):
        N1, N2 = depths[i - 1], depths[i]
        if M_irr[N1]:
            r_irr = M_irr[N2] / M_irr[N1]
            r_eng = M[N2] / M[N1] if M[N1] else float("inf")
            print(f"  M_irr({N2}) / M_irr({N1}) = {M_irr[N2]:>6} / {M_irr[N1]:>6} "
                  f"= {r_irr:>10.3f}    "
                  f"(engine ratio: {r_eng:>8.3f})")
    print()

    # Sample irreducible sequences at each depth.
    print(bar)
    print("Step 3 — Sample totally irreducible closures at each depth")
    print(bar)
    print()
    for N in [4, 6, 8]:
        engine = QuCalcEngine()
        all_at_depth = [c for c in engine.find_all_zfa("", extra_depth=N) if len(c) == N]
        irr = [c for c in all_at_depth if is_totally_irreducible(c)]
        print(f"  N={N}  (showing first 8 of {len(irr)}):")
        for c in irr[:8]:
            print(f"      {c}")
        print()

    # Apply mass formulas.
    print(bar)
    print("Step 4 — Test mass formulas using M_irr(N) at prime-qubit depths")
    print(bar)
    print()
    print("Hypothesis: m_gen ∝ f(M_irr(N_gen))")
    print("Mapping: gen-1 ↔ N=4 (2 qubits, prime), gen-2 ↔ N=6 (3 qubits, prime).")
    print("Gen-3 (tau) requires N=10 (5 qubits), too expensive to enumerate here.")
    print()

    if M_irr.get(4) and M_irr.get(6):
        M_e  = M_irr[4]
        M_mu = M_irr[6]

        # Tested formulas using only first two generations.
        candidates = [
            ("H1", "m ∝ M_irr(N)",            lambda M_: M_),
            ("H2", "m ∝ N · M_irr(N)",        None),  # will use (N, M_)
            ("H3", "m ∝ M_irr(N) / N",        None),
            ("H7", "m ∝ √M_irr(N) · N",       None),
        ]

        def proxy(label: str, N: int, M_: int) -> float:
            import math
            if label == "H1":  return float(M_)
            if label == "H2":  return float(N * M_)
            if label == "H3":  return float(M_) / N
            if label == "H7":  return math.sqrt(M_) * N
            raise ValueError(label)

        for label, expr, _ in candidates:
            m_e_proxy  = proxy(label, 4, M_e)
            m_mu_proxy = proxy(label, 6, M_mu)
            pred = m_mu_proxy / m_e_proxy if m_e_proxy else float("inf")
            measured = MEASURED_RATIOS["m_μ / m_e"]
            rel = (pred - measured) / measured
            flag = "✓" if abs(rel) < 0.10 else ("~" if abs(rel) < 1.0 else "✗")
            print(f"  {label}  {expr:<28}  "
                  f"predicted m_μ/m_e = {pred:>10.3f}  "
                  f"measured = {measured:>8.3f}  "
                  f"rel.err. = {rel*100:+7.1f}%  {flag}")
    print()

    # Honest analysis.
    print(bar)
    print("FINDINGS")
    print(bar)
    print(f"""
The QuCalcEngine BFS already applies a "no adjacent Hermitian pair"
filter, which excludes length-2 sub-closures. The engine's M(4) = 48
is much smaller than the brute-force length-4 count of 384 for this
reason. The engine filter is the WEAK irreducibility filter.

The STRONG irreducibility filter (this script): forbid embedded
sub-closures of ANY even length, not just length 2. The empirical
result:

  Engine M(N)     vs   Totally irreducible M_irr(N)   (irr fraction)

  N=4   {M.get(4, 0):>6}                  {M_irr.get(4, 0):>6}            100.0%
  N=6   {M.get(6, 0):>6}                  {M_irr.get(6, 0):>6}             {M_irr.get(6,0)/max(M.get(6,1),1)*100:>5.1f}%
  N=8   {M.get(8, 0):>6}                  {M_irr.get(8, 0):>6}             {M_irr.get(8,0)/max(M.get(8,1),1)*100:>5.1f}%

The irreducibility filter is meaningful — it prunes ~24% at N=6 and
~37% at N=8, identifying a structurally distinct subset of closures.

STRUCTURAL OBSERVATION: the totally irreducible closures fall into a
regular "nested" family. At N=4, examples are ^<v> and ^>v< (one
Hermitian pair sandwiched into another's middle). At N=6, the pattern
grows: ^^<vv>, ^^/vv\, ^^+vv- — three of one axis with another nested
between. At N=8, ^^^<vvv> continues the same growth pattern. This
strongly suggests a discrete family of irreducible solutions indexed
by depth — the candidate "stable closure" structures of QLF.

RATIO MISMATCH:
  M_irr(6) / M_irr(4) = 19.0  (engine ratio was 25.0)
  Measured m_μ / m_e  = 206.8

So the irreducibility filter brings the predicted ratio DOWN from 25
to 19. The measured 207 is in the opposite direction — irreducibility
makes the prediction WORSE for m_μ/m_e, not better.

Combined with the prime-qubit-count hypothesis (gen-1 ↔ N=4, gen-2 ↔
N=6, gen-3 ↔ N=10), the result remains falsified for the lepton mass
ratios in their strong form. The 207/17 non-monotonic structure of
measured lepton ratios cannot be reproduced by monotonic M_irr growth
at prime depths alone.

WHAT IS NOW ESTABLISHED:
  1. The "irreducibility = stability" reading of the user's hypothesis
     yields a well-defined, computable filter (this script).
  2. The filtered counts M_irr(4)=48, M_irr(6)=912, M_irr(8)=22944
     identify a nested structural family of candidate stable closures.
  3. The mass-ratio mismatch persists: M_irr ratios are still monotonic
     in N (~19-25x growth per step), inconsistent with the 207/17
     non-monotonic measured ratio structure.
  4. Whatever produces the actual lepton mass hierarchy must include
     at least one ingredient orthogonal to BOTH multiplicity AND
     irreducibility — most likely a generation-specific quantum
     number (chirality, flavour, Yukawa coupling), not a pure
     combinatorial-closure property.

CAVEATS:
  • Gen-3 (tau ↔ N=10, 5 qubits prime) is not enumerated. The BFS at
    depth 10 takes hours and the brute-force-then-filter approach used
    here doesn't scale that far without a smarter algorithm. The
    predicted M_irr(10) ≈ 22944 × 25 ≈ 574,000 is an extrapolation.
  • "Totally irreducible" is one specific reading of "stable". Other
    readings (e.g., minimum-entropy admissibility, distinct-axis
    coverage, or particular topology classes) might give different
    counts and different ratio structure.
""")


if __name__ == "__main__":
    main()
