"""
koide_tau_demo.py
=================

Companion to Weak_Force.md sec 5 — an attempt at the τ-decay-vertex / third-
generation lepton-mass blocker via the Koide relation.

The empirical Koide relation is the near-exact identity

    Q = (m_e + m_μ + m_τ) / (√m_e + √m_μ + √m_τ)²  =  2/3

QLF angle: that 2/3 is the **transverse-axis fraction** — 2 of the 3 spatial
axes carry the closure (the 6-twist alphabet = 2 transverse + 1 longitudinal
per axis), the same 2/3 that appears in the Lamb prefactor and the polarization
sum. If QLF supplies Q = 2/3 structurally, then m_e and m_μ alone PREDICT m_τ.

This demo shows:
  1. Q from the measured masses (how close to 2/3 it really is).
  2. The m_τ prediction from m_e, m_μ, Q=2/3.
  3. The exact equivalence  Q=2/3  ⟺  √m_k = M(1 + √2 cos(δ + 2πk/3)):
     three generations as three 120°-spaced phases of amplitude √2·M.

HONEST SCOPE (see Weak_Force.md sec 5/7):
  - Q = 2/3 as the transverse-axis fraction is a structural IDENTIFICATION /
    conjecture, not yet derived from the τ-decay closure.
  - m_e and m_μ are INPUTS; the prediction is m_τ. This is a parameter-light
    relation, not a from-nothing derivation of all three lepton masses.
  - The overall phase offset δ (the "Koide angle", ≈ 2/9 rad) and the scale M
    are not explained here — they are the remaining open pieces.
  - This is the charged LEPTON sector only (quark generations / CKM separate).

Pure Python (stdlib math). PDG / CODATA masses.
"""

import math

# PDG / CODATA charged-lepton masses (MeV)
m_e   = 0.51099895000
m_mu  = 105.6583755
m_tau = 1776.86

TWO_THIRDS = 2.0 / 3.0


def koide_Q(me, mmu, mtau):
    s = math.sqrt(me) + math.sqrt(mmu) + math.sqrt(mtau)
    return (me + mmu + mtau) / s**2


def predict_m_tau(me, mmu):
    """Solve Q=2/3 for m_τ given m_e, m_μ (the larger root).

    With sₖ=√mₖ, a=s_e+s_μ, b=m_e+m_μ:
        2/3 = (b + s_τ²)/(a + s_τ)²  →  s_τ² − 4a s_τ + (3b − 2a²) = 0
        s_τ = 2a + √(6a² − 3b)        (larger root)
    """
    a = math.sqrt(me) + math.sqrt(mmu)
    b = me + mmu
    s_tau = 2 * a + math.sqrt(6 * a * a - 3 * b)
    return s_tau**2


def header(t):
    print("=" * 76)
    print("  " + t)
    print("=" * 76)


def main():
    header("τ mass via the Koide relation — QLF reading: Q = 2/3 = transverse fraction")
    print()

    header("1. Koide Q from the measured masses")
    Q = koide_Q(m_e, m_mu, m_tau)
    print(f"  Q = (Σ m) / (Σ √m)²  = {Q:.8f}")
    print(f"  2/3                  = {TWO_THIRDS:.8f}")
    print(f"  relative gap         = {abs(Q - TWO_THIRDS)/TWO_THIRDS*100:.4f} %")
    print()
    print("  QLF claim: the 2/3 is the transverse-axis fraction (2 of 3 spatial")
    print("  axes carry the closure) — the same 2/3 as the Lamb prefactor and the")
    print("  photon polarization sum.  [structural identification, see sec 7]")
    print()

    header("2. Predict m_τ from m_e, m_μ, and Q = 2/3")
    m_pred = predict_m_tau(m_e, m_mu)
    print(f"  inputs:  m_e = {m_e} MeV,  m_μ = {m_mu} MeV   (measured)")
    print(f"  predicted m_τ (Q=2/3) = {m_pred:.3f} MeV")
    print(f"  measured  m_τ         = {m_tau} MeV")
    print(f"  relative error        = {abs(m_pred - m_tau)/m_tau*100:.4f} %")
    print()
    print("  Only Q=2/3 is supplied structurally; m_e, m_μ are inputs. So this is")
    print("  a parameter-light PREDICTION of the third-generation mass, not a")
    print("  from-nothing derivation of all three lepton masses.")
    print()

    header("3. Q = 2/3  ⟺  three 120°-spaced phases of amplitude √2·M")
    M = (math.sqrt(m_e) + math.sqrt(m_mu) + math.sqrt(m_tau)) / 3.0
    print(f"  √m_k = M (1 + √2 cos(δ + 2πk/3)),  k = 0,1,2   ⇒   Q = 2/3 identically")
    print(f"  (Σcos = 0 ⇒ Σ√m = 3M;  Σcos² = 3/2 ⇒ Σm = 6M²;  6M²/9M² = 2/3)")
    print()
    print(f"  mean √-mass  M = (Σ√m)/3 = {M:.5f} MeV^½")
    print(f"  √m_k / M  for (e, μ, τ) = "
          f"{math.sqrt(m_e)/M:.4f}, {math.sqrt(m_mu)/M:.4f}, {math.sqrt(m_tau)/M:.4f}")
    print(f"  amplitude √2 = {math.sqrt(2):.4f}  (the radius ratio of the three phases)")
    print()
    print("  The three lepton generations are three phases 2π/3 apart — QLF's")
    print("  recurring 'three' (three spatial axes).  The overall offset δ (the")
    print("  Koide angle ≈ 2/9 rad) and the scale M are the remaining open inputs.")
    print()

    header("3b. WHY Q = 2/3 — the derivation, with counterfactuals")
    print()
    print("  For N balanced phases of amplitude A:  √m_k = M(1 + A·cos(δ + 2πk/N)),")
    print("    Σcos = 0  ⇒  Σ√m = N·M;   Σcos² = N/2  ⇒  Σm = M²·N·(1 + A²/2)")
    print("    ⇒  Q = Σm / (Σ√m)²  =  (1 + A²/2) / N      [machine-verified: QLF_Koide.lean]")
    print()
    print(f"  {'N':>3}  {'A²':>4}  {'Q = (1+A²/2)/N':>16}   reading")
    print(f"  {'-'*3}  {'-'*4}  {'-'*16}   {'-'*40}")
    for N, A2, note in [(3, 2, "QLF: 3 axes, 2 transverse  →  EXACTLY 2/3"),
                        (2, 2, "2 generations"),
                        (4, 2, "4 generations"),
                        (3, 1, "only 1 transverse axis"),
                        (3, 3, "3 transverse (no longitudinal baseline)")]:
        q = (1 + A2 / 2) / N
        star = "  ←" if (N, A2) == (3, 2) else ""
        print(f"  {N:>3}  {A2:>4}  {q:>16.5f}   {note}{star}")
    print()
    print("  Q = 2/3 is forced by exactly two structural facts:")
    print("    N  = 3   — three generations = the three spatial axes")
    print("    A² = 2   — amplitude √2 = the TWO transverse axes")
    print("               (the one longitudinal axis is the common '1' baseline)")
    print("  i.e. the 2-transverse + 1-longitudinal split over 3 axes — the same")
    print("  split as the transverse fraction 2/3 (Lamb prefactor, polarization sum).")
    print()

    header("4. The τ-decay vertex, in this reading")
    print()
    print("  The τ is the deepest generation phase (largest √m).  Per Weak_Force")
    print("  sec 4a it is the lepton variety whose completion is too short-lived")
    print("  to bind into a neutral atom — so instead of a bound state it appears")
    print("  as the weak DECAY VERTEX τ⁻ → ν_τ + W⁻, un-spooling the deepest phase")
    print("  into lighter generations + neutrino.  Its threshold IS m_τ, which the")
    print("  Koide/transverse-fraction structure now pins to ~0.006%.")
    print()
    print("  OPEN: the 2/3 identification proven from the closure; the Koide angle")
    print("  δ; the scale M; why exactly three generations.  See Weak_Force.md.")


if __name__ == "__main__":
    main()
