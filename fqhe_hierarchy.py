#!/usr/bin/env python3
"""
fqhe_hierarchy.py — the falsifiable check for
"FQHE filling fractions as a closures-within-closures tower (closure-parity rule)".

The composite-fermion picture (Jain 1989) reads each fractional-quantum-Hall
state as an electron with an EVEN number 2s of flux quanta attached, filling an
integer number p of composite-fermion Landau levels:

        nu = p / (2 s p +- 1)          (Jain sequence)

QLF reading of the SAME move as a closures-within-closures tower:

  * attaching one flux quantum = binding one even-pair fold = a BOSON closure
    (QLF_Spin.boson_even_pairs).  Attaching 2s of them is s boson-closures nested
    inside the electron closure -- a closure-of-closures (the `bind` fold).
  * the composite must stay a FERMION (it is still an electron): fermion x boson
    = fermion, and fermion parity is odd (QLF_Spin.fermion_odd_pairs).  This is
    why the attached flux count 2s is EVEN, not odd -- an odd attachment would
    flip the statistics to bosonic and the state would not close as an electron.
  * therefore the denominator 2sp +- 1 is ODD (2sp is even).  The odd-denominator
    rule of Abelian FQHE = the fermionic-closure parity, full stop.

Predictions that make it falsifiable:
  (1) every Abelian FQHE fraction has an ODD denominator  [closure parity];
  (2) EVEN-denominator states (5/2, 7/2) are NOT in the Jain fermion tower --
      QLF reads them as a different closure: a PAIRED (boson-paired) closure
      (Moore-Read Pfaffian, non-Abelian).  So even denominator <=> paired/
      non-Abelian, odd <=> unpaired fermionic.  Both are observed exactly so.

This script enumerates the Jain tower, checks the parity rule against the
experimentally observed principal fractions, and lists the even-denominator
exceptions with their QLF (paired-closure) reading.
"""

from fractions import Fraction
from math import gcd


def jain_sequence(s, pmax=6):
    """nu = p/(2sp+-1) for p=1..pmax, both branches."""
    out = []
    for p in range(1, pmax + 1):
        for sign in (+1, -1):
            denom = 2 * s * p + sign
            if denom > 0:
                out.append(Fraction(p, denom))
    return out


# Experimentally well-established principal FQHE fractions in 0<nu<1
# (Abelian, odd-denominator) -- consensus set.
OBSERVED_ODD = {
    Fraction(1, 3), Fraction(2, 5), Fraction(3, 7), Fraction(4, 9),
    Fraction(2, 3), Fraction(3, 5), Fraction(4, 7), Fraction(5, 9),
    Fraction(1, 5), Fraction(2, 7),
}
# Observed EVEN-denominator states: paired / non-Abelian (different closure).
OBSERVED_EVEN = {Fraction(5, 2), Fraction(7, 2)}


if __name__ == "__main__":
    print(__doc__)
    print("=" * 72)
    print("JAIN TOWER (closures-within-closures)  nu = p/(2sp +- 1)")
    print("=" * 72)
    generated = set()
    for s in (1, 2):
        seq = jain_sequence(s)
        generated |= set(seq)
        label = f"s={s} ({2*s} flux quanta attached, {s} nested boson closures)"
        print(f"\n{label}:")
        print("  " + "  ".join(str(f) for f in seq))
        bad = [f for f in seq if f.denominator % 2 == 0]
        print(f"  all denominators odd? {'YES' if not bad else 'NO: '+str(bad)}")

    print("\n" + "=" * 72)
    print("CHECK 1 — parity rule: every generated fraction has ODD denominator")
    print("=" * 72)
    odd_all = all(f.denominator % 2 == 1 for f in generated)
    print(f"  {len(generated)} fractions generated; all odd-denominator? "
          f"{'YES' if odd_all else 'NO'}")
    print("  (forced: denominator = 2sp +- 1, and 2sp is even => odd. This IS")
    print("   fermion_odd_pairs -- the composite stays a fermion.)")

    print("\n" + "=" * 72)
    print("CHECK 2 — the tower reproduces the observed principal fractions")
    print("=" * 72)
    hit = sorted(OBSERVED_ODD & generated)
    miss = sorted(OBSERVED_ODD - generated)
    print(f"  observed odd-denominator fractions reproduced: {len(hit)}/{len(OBSERVED_ODD)}")
    print("    " + "  ".join(str(f) for f in hit))
    if miss:
        print(f"  not in s=1,2 tower (higher s / hierarchy daughters): "
              + "  ".join(str(f) for f in miss))

    print("\n" + "=" * 72)
    print("CHECK 3 — even-denominator states are OUTSIDE the fermion tower")
    print("=" * 72)
    for f in sorted(OBSERVED_EVEN):
        in_tower = f in generated
        print(f"  nu={f}: in Jain fermion tower? {'YES' if in_tower else 'NO'} "
              f"-> QLF reads as a PAIRED (boson-paired) closure = non-Abelian "
              f"(Moore-Read), a DIFFERENT closure, not a parity violation.")

    print("\n" + "=" * 72)
    print("READING")
    print("=" * 72)
    print("""\
* The ODD-DENOMINATOR RULE is derived, not assumed: denominator = 2sp+-1 is odd
  because the attached flux count 2s is even, and 2s is even because the
  composite must remain a FERMION (fermion_odd_pairs) after nesting s boson
  flux-closures (boson_even_pairs). Closure parity => odd denominators.

* The tower is literally closures-within-closures: s boson flux-closures bound
  inside the electron closure, then p of those composite closures stacked (the
  composite-fermion integer QHE). This is the Haldane/Jain hierarchy as the QLF
  `bind` fold (closure-of-closures).

* GROUNDED: the parity rule + the odd/even <=> unpaired/paired dichotomy (both
  observed). OPEN (the falsifiable target, fqhe_hierarchy_in_progress): deriving
  WHICH p,s are stable (the gap hierarchy / relative stability of 1/3 vs 2/5 vs
  ...) and the Laughlin/Jain many-body wavefunction -- the 2D many-body dynamics
  QLF's Lean does not yet carry (same boundary as QLF_Anyons). Speculative until
  the stability ordering falls out; the parity rule itself is solid.""")
