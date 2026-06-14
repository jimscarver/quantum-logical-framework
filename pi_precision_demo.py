"""
pi_precision_demo.py
====================

Answers QLF issue #37 ("how much finite phase precision is required?") and supports the
"find the machine, not the notation" series (#36/#44/#50): **no observable in physics needs
pi to infinite precision.** Each formula that contains a loop-closure constant (the thing we
write as 2*pi) only needs as many significant digits of that constant as the observable is
actually *measured* to.

For an observable O depending on the closure constant K (= 2*pi in continuum notation) as a
power, O ~ K^n, a relative error d_pi in K gives a relative error |n| * d_pi in O.  So to
reproduce O at its measured relative precision eps_O, it suffices to know the closure constant
to about

    required_digits ~ ceil( -log10(eps_O / |n|) )

The point: a finite closure *register* with this many ticks reproduces the physics.  There is
no decimal point in the machine.

Pure Python, no dependencies.  Companion to TheContinuum.md and Open_Problems.md
(Foundational reframings).
"""

import math
from dataclasses import dataclass


@dataclass
class Observable:
    name: str
    formula: str          # where the closure constant appears
    power: int            # |n| in O ~ (2pi)^n
    meas_rel_prec: float  # measured relative precision of the observable
    note: str = ""


# Each observable, its dependence on the 2*pi closure constant, and how precisely it is MEASURED.
OBSERVABLES = [
    Observable("electron g-2  (a_e)",      "a_e = alpha/(2*pi)",            1, 1.3e-10,
               "Fan et al. 2023, ~0.13 ppb"),
    Observable("fine structure alpha",     "alpha from a_e (g-2)",          1, 8.1e-11,
               "CODATA, via g-2"),
    Observable("H 1S-2S (optical clock)",  "spectroscopy via alpha, loops", 1, 1.0e-15,
               "the most demanding case in physics"),
    Observable("Lamb shift prefactor",     "4/(3*pi*n^3)",                  1, 2.5e-2,
               "QLF match ~2.5%"),
    Observable("muon g-2  (a_mu)",         "a_mu = alpha/(2*pi) + ...",     1, 5.0e-7,
               "Fermilab 2023, ~0.2 ppm"),
    Observable("dark-matter a_0",          "a_0 = c*H_0/(2*pi)",            1, 2.0e-1,
               "McGaugh RAR, ~20% systematic"),
    Observable("Hawking/de Sitter T",      "T = hbar*a/(2*pi*c*k_B)",       1, 1.0e-2,
               "structural; no precise direct measurement"),
]


def required_digits(o: Observable) -> int:
    """Significant digits of the 2*pi closure constant needed to reproduce O at its
    measured precision."""
    eps_per_digit = o.meas_rel_prec / o.power
    return max(1, math.ceil(-math.log10(eps_per_digit)))


def header(title: str) -> None:
    print("=" * 80)
    print("  " + title)
    print("=" * 80)


def main() -> None:
    header("How many digits of the loop-closure constant (2*pi) does physics need?")
    print()
    print("  No observable needs pi to infinite precision.  Each needs only as many digits of")
    print("  the closure constant as it is actually MEASURED to:")
    print()
    print(f"  {'observable':<26}{'measured prec.':<16}{'pi-digits needed':<18}note")
    print("  " + "-" * 88)
    worst = 0
    for o in OBSERVABLES:
        d = required_digits(o)
        worst = max(worst, d)
        print(f"  {o.name:<26}{o.meas_rel_prec:<16.1e}{d:<18}{o.note}")
    print()
    print(f"  => The MOST demanding observable in physics needs about {worst} significant digits")
    print("     of the loop-closure constant.  Everything else needs far fewer (the dark-matter")
    print("     scale needs ~1).  NONE needs infinite precision.")
    print()

    header("The point (issues #36, #37, #44, #50)")
    print()
    print("  pi is not the furniture of reality; it is the continuum *reporting format* for a")
    print("  finite loop-closure register.  A machine with ~15 ticks of closure precision")
    print("  reproduces all of measured physics.  There is no decimal point in the machine —")
    print("  it is a register; it is a closure machine.")
    print()
    print("  In QLF the closure constant is the loop-phase primitive that appears as 2*pi in")
    print("  g-2 = alpha/2pi, the horizon temperature, and a_0 = cH_0/2pi.  Replacing the")
    print("  symbol 2*pi by zfa_loop_closure() changes notation, not value (Open_Problems.md ->")
    print("  Foundational reframings).")
    print()


if __name__ == "__main__":
    main()
