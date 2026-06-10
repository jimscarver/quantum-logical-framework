"""
winding_invariant_demo.py
=========================

Companion to the B−L thread (Beta_Decay_Neutrino_Nature.md §1, Conservation.md §8,
lean/QLF_BMinusL.lean). We proved B−L cannot be a *weight dictionary* (any conserved
signed count is zero on closures; B−L is not — the deuteron has B−L=1; a baryon and
antibaryon share a twist multiset yet carry B−L=±1). So B−L must be a *winding /
orientation* invariant. This script PROPOSES a concrete candidate and TESTS it.

CANDIDATE  W = oriented turning number: sum over consecutive spatial-twist pairs of
a cyclic-handedness h(axis_i, axis_j) (+1 cyclic x→y→z→x, −1 anti-cyclic, 0 same
axis / gauge). This is the natural discrete winding: a sum over ADJACENT PAIRS, so
it is NOT additive under concatenation (it has a boundary term) — which is exactly
why it escapes the weight-dictionary obstruction.

RESULT (see output):
  STRUCTURAL properties — all hold (the right SHAPE for B−L):
    * NOT additive under concatenation (boundary term) — not a weight dictionary.
    * dagger-odd: W(antiparticle) = −W  (Hermitian conj = reverse∘C) — the
      baryon/antibaryon behaviour B−L=±1 demands.
    * nonzero on count-balanced closures (the electron loop has W=−1).
  CALIBRATION to physical B−L — FAILS:
    * electron W=−1 = B−L(e), positron W=+1 = B−L(e+)   ✓  (a real hit)
    * neutrino ^v (and ^-v+)  W=0  but  B−L(ν)=−1        ✗  MISMATCH

EPILOGUE: the neutrino's W=0 turned out not to be a candidate failure to fix but a
*result*: the neutrino has no topological handle to carry B−L, i.e. it is its own
antiparticle = MAJORANA. This is now machine-verified (lean/QLF_Majorana.lean:
the `^v` loop is a fixed point of the Hermitian conjugate). See Beta_Decay_Neutrino_Nature.md.

DIAGNOSIS: W tracks *spatial handedness*, and it vanishes on the neutrino — which
is exactly the *spatially non-chiral* lepton. But lepton number is NOT spatial
chirality (the Dirac argument already said the neutrino is spatially non-chiral yet
carries lepton count). So a planar turning number CANNOT be B−L; it misses the
neutrino. The correct B−L winding must be a genuine 3-strand (Borromean) LINKING
number, not a 2D turning number — or the neutrino's lepton number lives in structure
absent from its current twist string. The candidate is rejected; the right object is
sharper than "turning number". Pure Python.
"""

AX = {'^': ('y', +1), 'v': ('y', -1), '>': ('x', +1), '<': ('x', -1),
      '/': ('z', +1), '\\': ('z', -1), '+': (None, +1), '-': (None, -1)}
CONJ = {'^': 'v', 'v': '^', '<': '>', '>': '<', '/': '\\', '\\': '/', '+': '-', '-': '+'}
idx = {'x': 0, 'y': 1, 'z': 2}


def h(i, j):                       # oriented turn, cyclic x->y->z->x
    if i is None or j is None or i == j:
        return 0
    return +1 if (idx[j] - idx[i]) % 3 == 1 else -1


def spatial(ts):
    return [AX[t][0] for t in ts if AX[t][0] is not None]


def W(ts):                         # sum of turns over consecutive spatial pairs
    a = spatial(ts)
    return sum(h(a[k], a[k + 1]) for k in range(len(a) - 1))


def conj(ts):
    return [CONJ[t] for t in ts]


def dagger(ts):                    # Hermitian conjugate = reverse o C  (QLF antiparticle)
    return list(reversed(conj(ts)))


def count_balanced(ts):
    c = ts.count
    return (c('^') == c('v') and c('<') == c('>')
            and c('/') == c('\\') and c('+') == c('-'))


def header(t):
    print("=" * 74); print("  " + t); print("=" * 74)


def main():
    header("Candidate winding invariant W = oriented turning number")
    print()
    print(f"  {'particle':24}{'twists':10}{'W':>4}{'countBal':>10}{'W(dagger)':>11}")
    for name, s in [("electron ^<v>", "^<v>"),
                    ("positron (dagger e)", "".join(dagger(list("^<v>")))),
                    ("RH electron ^>v<", "^>v<"),
                    ("neutrino ^v", "^v"),
                    ("neutrino ^-v+", "^-v+"),
                    ("photon ^v (massless)", "^v")]:
        s = list(s)
        print(f"  {name:24}{''.join(s):10}{W(s):>+4}{str(count_balanced(s)):>10}"
              f"{W(dagger(s)):>+11}")

    print()
    header("Structural properties (the right SHAPE — escapes the obstruction)")
    print()
    e = list("^<v>")
    s1, s2 = list("^<"), list("v>")
    print(f"  dagger-odd      : W(e)={W(e):+d}, W(e†)={W(dagger(e)):+d}"
          f"   -> {W(dagger(e)) == -W(e)}")
    print(f"  NOT additive    : W(s1++s2)={W(s1 + s2):+d} vs W(s1)+W(s2)={W(s1) + W(s2):+d}"
          f"  (boundary {W(s1 + s2) - W(s1) - W(s2):+d}) -> not a weight dictionary")
    print(f"  nonzero on closure: ^<v> countBal={count_balanced(e)}, W={W(e):+d}"
          f"  -> {W(e) != 0}")

    print()
    header("Calibration to physical B−L  (FAILS at the neutrino)")
    print()
    rows = [("electron", -1, W(list("^<v>"))),
            ("positron", +1, W(dagger(list("^<v>")))),
            ("neutrino", -1, W(list("^v")))]
    for name, bl, w in rows:
        print(f"  {name:10} B−L={bl:+d}  W={w:+d}  {'MATCH' if w == bl else 'MISMATCH <--'}")
    print()
    print("  W tracks spatial handedness, which vanishes on the (non-chiral) neutrino.")
    print("  Lepton number is NOT spatial chirality -> a turning number cannot be B−L.")
    print("  The correct object is a 3-strand (Borromean) LINKING number. REJECTED.")


if __name__ == "__main__":
    main()
