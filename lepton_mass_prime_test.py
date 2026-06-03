#!/usr/bin/env python3
"""
lepton_mass_prime_test.py
Tests the hypothesis: "lepton masses correspond to closures at PRIME qubit
counts" — i.e., gen-k ↔ depth N = 2·p_k, where p_k is the k-th prime
(p_1=2, p_2=3, p_3=5, ...).

Companion to lepton_mass_demo.py. That script tested mass ∝ f(N, M(N))
formulas using every even depth; this one restricts to prime-qubit depths
and tests TWO classes of candidate formulas:

  Class A (multiplicity-based, from lepton_mass_demo.py):
    H1  m ∝ M(N)
    H2  m ∝ N · M(N)
    H3  m ∝ M(N) / N
    H7  m ∝ √M(N) · N

  Class B (prime-arithmetic, independent of M(N)):
    P1  m ∝ p_k
    P2  m ∝ p_k!     (factorial)
    P3  m ∝ p_k^p_k  (self-tower)
    P4  m ∝ p_k^2
    P5  m ∝ exp(p_k)
    P6  m ∝ k · p_k! / (p_k - 1)!

Honest framing throughout: the goal is to test the user's "prime qubit
count" hypothesis falsifiably. The expected outcome (based on hand
analysis) is that prime-restriction does not by itself fix the ratio
mismatch revealed by lepton_mass_demo.py — but specific prime-arithmetic
formulas may turn out to be closer than the monotonic-multiplicity
candidates. The script reports that comparison honestly.

Measured PDG ratios:
    m_μ / m_e =  206.768
    m_τ / m_μ =   16.817
"""

from __future__ import annotations
import math

# Measured PDG lepton masses (MeV).
M_E_MEV   = 0.51099895
M_MU_MEV  = 105.6583755
M_TAU_MEV = 1776.86

MEASURED_RATIOS = {
    "m_μ / m_e": M_MU_MEV  / M_E_MEV,
    "m_τ / m_μ": M_TAU_MEV / M_MU_MEV,
    "m_τ / m_e": M_TAU_MEV / M_E_MEV,
}

# Cached multiplicities from lepton_mass_demo.py (QuCalcEngine BFS).
# These are the deduplicated-by-engine-filter counts of ZFA-closed
# sequences of exactly that length, with the immediate-Hermitian-
# reversal filter applied.
M_CACHED = {
    4:  48,
    6:  1200,
    8:  36432,
    # 10: actual unknown without a multi-hour BFS run. We use a geometric
    # extrapolation: M(N+2)/M(N) trended 25.0 → 30.4 (relative step
    # increased by ~21%). Next ratio ≈ 30.4 × 1.21 ≈ 36.8. So:
    10: 1_340_676,   # M(8) × 36.8, estimated
}

PRIMES = [2, 3, 5, 7, 11, 13]  # First six primes for safety.


def factorial(n: int) -> int:
    return math.factorial(n)


def prime_qubit_depth(generation: int) -> int:
    """Generation k ↔ depth N = 2 · p_k where p_k is the k-th prime."""
    return 2 * PRIMES[generation - 1]


def evaluate_formula(label: str,
                     expr: str,
                     proxy_fn,
                     using: dict,
                     warn_estimated: bool) -> None:
    """Print predicted vs. measured ratios for one mass-proxy formula."""
    m_e_proxy  = proxy_fn(1, using["e"])
    m_mu_proxy = proxy_fn(2, using["mu"])
    m_ta_proxy = proxy_fn(3, using["tau"])

    note = "  [⚠ uses extrapolated M(10)]" if warn_estimated else ""
    print(f"  {label:<5} {expr:<35}{note}")
    print(f"        proxies:  m_e={m_e_proxy:>12.3f}  "
          f"m_μ={m_mu_proxy:>12.3f}  m_τ={m_ta_proxy:>14.3f}")

    if m_e_proxy == 0 or m_mu_proxy == 0:
        print("        [division by zero; skipped]")
        return

    pred = {
        "m_μ / m_e": m_mu_proxy / m_e_proxy,
        "m_τ / m_μ": m_ta_proxy / m_mu_proxy,
        "m_τ / m_e": m_ta_proxy / m_e_proxy,
    }

    for name, measured in MEASURED_RATIOS.items():
        rel = (pred[name] - measured) / measured
        flag = "✓" if abs(rel) < 0.10 else ("~" if abs(rel) < 1.0 else "✗")
        print(f"        {name:<10} pred={pred[name]:>11.3f}  "
              f"meas={measured:>10.3f}  rel.err.={rel*100:+8.1f}%  {flag}")
    print()


def main() -> None:
    bar = "═" * 76
    print(bar)
    print("QLF Lepton-Mass Probe — Prime-Qubit-Count Hypothesis")
    print(bar)
    print()
    print("Hypothesis: lepton generations correspond to closures whose qubit")
    print("count (= N/2 for a length-N sequence) is the k-th prime:")
    print()
    print("  gen-1 (electron) ↔ N = 2·p_1 = 4  (2 qubits)")
    print("  gen-2 (muon)     ↔ N = 2·p_2 = 6  (3 qubits)")
    print("  gen-3 (tau)      ↔ N = 2·p_3 = 10 (5 qubits)")
    print()
    print("Note: under this mapping, N=8 (4 qubits, NOT prime) is skipped,")
    print("which differs from the lepton_mass_demo.py mapping gen-k ↔ N=2(k+1).")
    print()

    print("Measured PDG ratios:")
    for name, val in MEASURED_RATIOS.items():
        print(f"  {name:<10} = {val:>11.4f}")
    print()

    # ── Section 1: prime-arithmetic formulas (no multiplicity) ──
    print(bar)
    print("Class B — Prime-arithmetic formulas (no multiplicity input)")
    print(bar)
    print()
    print("These formulas use only the prime values themselves, not M(N).")
    print()

    prime_args = {"e": 1, "mu": 2, "tau": 3}  # generation index
    p = lambda k: PRIMES[k - 1]

    evaluate_formula("P1", "m ∝ p_k",
                     lambda k, _: float(p(k)),
                     prime_args, False)
    evaluate_formula("P2", "m ∝ p_k!",
                     lambda k, _: float(factorial(p(k))),
                     prime_args, False)
    evaluate_formula("P3", "m ∝ p_k^p_k",
                     lambda k, _: float(p(k) ** p(k)),
                     prime_args, False)
    evaluate_formula("P4", "m ∝ p_k²",
                     lambda k, _: float(p(k) ** 2),
                     prime_args, False)
    evaluate_formula("P5", "m ∝ exp(p_k)",
                     lambda k, _: math.exp(p(k)),
                     prime_args, False)
    evaluate_formula("P6", "m ∝ p_k · p_k!",
                     lambda k, _: float(p(k) * factorial(p(k))),
                     prime_args, False)

    # ── Section 2: multiplicity-based at prime-qubit depths ──
    print(bar)
    print("Class A — Multiplicity formulas at prime-qubit depths")
    print(bar)
    print()
    print("These use M(N) from the QuCalcEngine BFS, but only at prime")
    print("qubit counts {2, 3, 5}. M(10) is geometrically extrapolated")
    print(f"from the M(N+2)/M(N) trend (25.0 → 30.4 → ~36.8) to ≈ {M_CACHED[10]:,}.")
    print()

    M_e   = M_CACHED[4]    # depth 4
    M_mu  = M_CACHED[6]    # depth 6
    M_tau = M_CACHED[10]   # depth 10 (estimated)
    N_e, N_mu, N_tau = 4, 6, 10

    mult_args = {
        "e":   (N_e,   M_e),
        "mu":  (N_mu,  M_mu),
        "tau": (N_tau, M_tau),
    }
    # proxy_fn signature here: (k, (N, M)) → float
    H_arg = lambda key: mult_args[{"1": "e", "2": "mu", "3": "tau"}[str(key)]]

    def H1(k, _): N, M = H_arg(k); return float(M)
    def H2(k, _): N, M = H_arg(k); return float(N * M)
    def H3(k, _): N, M = H_arg(k); return float(M) / N
    def H7(k, _): N, M = H_arg(k); return math.sqrt(M) * N

    evaluate_formula("H1", "m ∝ M(N)",         H1, prime_args, True)
    evaluate_formula("H2", "m ∝ N · M(N)",     H2, prime_args, True)
    evaluate_formula("H3", "m ∝ M(N) / N",     H3, prime_args, True)
    evaluate_formula("H7", "m ∝ √M(N) · N",    H7, prime_args, True)

    # ── Section 3: combined prime + multiplicity ──
    print(bar)
    print("Class C — Combined prime + multiplicity formulas")
    print(bar)
    print()
    print("Use both the prime p_k AND M(2·p_k) at prime-qubit depths.")
    print()

    def C1(k, _):
        N, M = H_arg(k)
        return float(p(k)) * float(M)

    def C2(k, _):
        N, M = H_arg(k)
        return math.sqrt(M) * float(p(k))

    def C3(k, _):
        N, M = H_arg(k)
        return float(factorial(p(k)))   # prime factorial alone
                                         # (M dropped — should match P2)

    def C4(k, _):
        N, M = H_arg(k)
        return float(M) / float(p(k))

    evaluate_formula("C1", "m ∝ p_k · M(N)",       C1, prime_args, True)
    evaluate_formula("C2", "m ∝ √M(N) · p_k",      C2, prime_args, True)
    evaluate_formula("C4", "m ∝ M(N) / p_k",       C4, prime_args, True)

    # ── Summary ──
    print(bar)
    print("SUMMARY OF FINDINGS")
    print(bar)
    print(f"""
Hand-comparison of the predicted ratios above against measured
m_μ/m_e = 206.77 and m_τ/m_μ = 16.82:

PRIME-ARITHMETIC (Class B) — independent of multiplicity:
  • P1 (p_k)         predicts 1.50 / 1.67 — way too small (factor ~138 / 10)
  • P2 (p_k!)        predicts 3.00 / 20.0 — m_τ/m_μ surprisingly close (~20% off!)
                                            m_μ/m_e still way off (factor ~69)
  • P3 (p_k^p_k)     predicts 6.75 / 115 — m_τ/m_μ off ~7x, m_μ/m_e off ~30x
  • P4 (p_k²)        predicts 2.25 / 2.78 — way too small
  • P5 (exp p_k)     predicts 2.72 / 7.39 — too small
  • P6 (p_k · p_k!)  predicts 4.50 / 33.3 — m_τ/m_μ close ~2x off

MULTIPLICITY @ PRIME DEPTHS (Class A):
  Using M(10) estimate ≈ 1.34M, predictions get WORSE for m_τ/m_μ
  (compounded by the extra-large extrapolated multiplicity at depth 10).
  This hypothesis is actively counterproductive — restricting to prime
  qubit counts amplifies the non-monotonicity mismatch revealed by
  lepton_mass_demo.py.

COMBINED (Class C): similar story to Class A — the multiplicity growth
swamps any prime modulation.

KEY OBSERVATION:
  P2 (mass ∝ p_k!) hits m_τ/m_μ within ~20% (20.0 vs measured 16.8) but
  is wildly wrong on m_μ/m_e (3.0 vs 207). This is an interesting partial
  hit — it suggests the m_τ/m_μ ratio MIGHT have a factorial-of-prime
  shape while m_μ/m_e has a completely different mechanism. Two possible
  readings:

    1. m_μ/m_e is dominated by some non-multiplicity, non-prime effect
       (e.g., a chirality flip, a Higgs-coupling factor), while m_τ/m_μ
       inherits a "prime factorial" combinatorial structure.
    2. The "prime qubit count" hypothesis as stated above is too crude;
       the right formula uses primes but with a more complex generation-
       to-prime mapping than gen-k ↔ p_k.

HONEST CONCLUSION:
  The prime-qubit-count hypothesis as posed does not by itself reproduce
  the lepton mass ratios. One partial hit (P2 on m_τ/m_μ) is worth
  noting but insufficient. The hypothesis is FALSIFIED in its strong
  form (predict both ratios), USEFUL as a constraint (rules out simple
  prime-power formulas), and LEAVES OPEN the possibility of a hybrid
  formula combining prime-arithmetic with at least one additional
  non-prime ingredient.

Caveat: M(10) is estimated, not computed. The Class A and C numbers at
depth 10 should be redone with the actual BFS value (~1-2 hour run).
""")


if __name__ == "__main__":
    main()
