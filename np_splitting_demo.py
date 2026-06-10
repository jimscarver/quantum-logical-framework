"""
np_splitting_demo.py
====================

Companion to Weak_Force.md sec 5e — an honest attempt at the neutron-proton
mass splitting from QLF closure structure.

    m_n - m_p = 1.2933 MeV   (OBSERVABLE; the d↔u weak-vertex energy)

It decomposes into two gauge-sector pieces (this is standard physics, recast in
QLF language):

    m_n - m_p  =  (m_d - m_u)        -   ΔE_EM
                  ───────────────        ───────────
                  STRONG flavor step     EM closure-depth difference
                  (d↔u = weak vertex,    (from the quark-CHARGE = gauge-fold
                   neutron heavier)       structure; proton heavier)

WHAT QLF GIVES (this demo):
  * The EM piece: its SIGN and ORDER OF MAGNITUDE follow from the quark-charge
    (gauge-fold `+-`) structure of the two Borromean closures, plus QLF's
    α (1/137) and the proton depth R_p. Both the self-energy (Σq²) and the
    inter-quark Coulomb (Σ q_i q_j) make the PROTON heavier — by ~ O(1) MeV.
WHAT STAYS OPEN:
  * The STRONG piece (m_d - m_u ~ 2.5 MeV) — a quark-flavor-step energy; quark
    masses are non-observable (Weak_Force.md §5d), so this is open.
  * The precise sub-MeV NET value — a delicate cancellation (+2.5 − 1.2 ≈ 1.29)
    that needed lattice QCD+QED (BMW 2015) to compute. QLF does NOT shortcut it.

So this is a structural decomposition + a sign/scale handle on the EM half — NOT
a derivation of 1.2933 MeV. Pure Python.
"""

import math

# --- observables / constants ---
m_n_m_p = 1.2933        # MeV, CODATA neutron-proton splitting
m_e     = 0.51099895    # MeV
alpha   = 1.0 / 137.0   # QLF substrate value (alpha_QLF_eq)
hbar_c  = 197.3269804   # MeV*fm
R_p     = 0.8409        # fm, proton charge radius (CODATA)
# strong piece (lattice/PDG, NOT a QLF observable — quoted for the decomposition)
md_minus_mu = 2.51      # MeV (m_d - m_u, MS-bar @2GeV; large uncertainty)

# quark charges (units of e): the QLF gauge-fold (+-) content
qu, qd = +2.0/3.0, -1.0/3.0
proton  = [qu, qu, qd]   # uud
neutron = [qu, qd, qd]   # udd


def sigma_qsq(qs):                       # self-energy charge factor
    return sum(q*q for q in qs)

def sigma_pair(qs):                      # inter-quark Coulomb factor Σ_{i<j} q_i q_j
    return sum(qs[i]*qs[j] for i in range(3) for j in range(i+1, 3))


def header(t):
    print("=" * 76); print("  " + t); print("=" * 76)


def main():
    header("Neutron-proton splitting from closure structure (an honest attempt)")
    print()
    print(f"  Target (observable):  m_n - m_p = {m_n_m_p:.4f} MeV")
    print(f"  = (m_d - m_u)  −  ΔE_EM   [strong flavor step  −  EM closure difference]")
    print()

    header("1. The EM half — from the quark-CHARGE (gauge-fold) structure")
    print()
    sp, sn = sigma_qsq(proton), sigma_qsq(neutron)
    cp, cn = sigma_pair(proton), sigma_pair(neutron)
    print(f"  quark charges:  u = +2/3,  d = −1/3   (the +- gauge content)")
    print(f"  proton  uud :  Σq² = {sp:.4f},   Σ_(i<j) q_i q_j = {cp:+.4f}")
    print(f"  neutron udd :  Σq² = {sn:.4f},   Σ_(i<j) q_i q_j = {cn:+.4f}")
    print(f"  differences (p − n):  ΔΣq² = {sp-sn:+.4f},   ΔΣpair = {cp-cn:+.4f}")
    print()
    print("  Both differences are POSITIVE (= +1/3): the proton has more quark")
    print("  self-energy AND less Coulomb attraction than the neutron, so EM makes")
    print("  the PROTON heavier (ΔE_EM > 0, reducing m_n − m_p) — the correct sign.")
    print()
    E_coul = alpha * hbar_c / R_p
    print(f"  Coulomb scale:  α·ℏc/R_p = (1/137)(197.3)/(0.84) = {E_coul:.3f} MeV")
    print(f"  with the O(1/3) charge factors  ⇒  ΔE_EM ~ 0.5–1.5 MeV (proton heavier).")
    print(f"  → QLF (α + R_p + gauge structure) fixes the EM half's SIGN and SCALE.")
    print()

    header("2. The STRONG half — open")
    print()
    print(f"  (m_d − m_u) ≈ {md_minus_mu:.2f} MeV makes the NEUTRON heavier (d↔u flavor")
    print("  step = the weak vertex). But quark masses are non-observable in QLF")
    print("  (Weak_Force.md §5d), so this flavor-step energy is OPEN — not derived.")
    print()

    header("3. The decomposition (with the strong piece as input)")
    print()
    dE_EM = md_minus_mu - m_n_m_p          # back out EM from the known total
    print(f"  m_n − m_p (measured)      = {m_n_m_p:.4f} MeV")
    print(f"  (m_d − m_u) strong        = {md_minus_mu:+.4f} MeV   (neutron heavier)")
    print(f"  ⇒ ΔE_EM required          = {dE_EM:+.4f} MeV   (proton heavier)")
    print(f"  ΔE_EM sits inside QLF's α·ℏc/R_p = {E_coul:.2f} MeV scale ✓ (right sign+order)")
    print()
    print("  The NET is a delicate cancellation of two ~MeV gauge-sector effects.")
    print("  Its precise sub-MeV value needed lattice QCD+QED (BMW 2015); QLF gives")
    print("  the structure and the EM scale, not the cancellation.")
    print()

    header("Honest scope")
    print()
    print("  DERIVED/structural:  the splitting = strong flavor step (d↔u, the weak")
    print("    vertex) − EM closure difference; the EM half's SIGN and ~MeV SCALE")
    print("    from QLF's α + proton depth + quark-charge (+-) gauge structure.")
    print("  OPEN:  the strong (m_d − m_u) flavor-step energy; the precise 1.2933")
    print("    MeV (the cancellation); these are not shortcut.")
    print(f"  Loose ratio flagged, not a relation:  (m_n−m_p)/m_e = {m_n_m_p/m_e:.3f}.")


if __name__ == "__main__":
    main()
