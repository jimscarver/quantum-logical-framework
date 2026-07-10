#!/usr/bin/env python3
"""
turbulence_intermittency.py — the falsifiable check for
"Derive Kolmogorov -5/3 and intermittency from self-similar ZFA closure statistics".

Two claims are tested here, in increasing ambition:

  (A) -5/3 from closure-flux scale invariance.  If the energy passed per octave
      (log 2 per closure x closure rate) is octave-INDEPENDENT across the
      inertial range, dimensional analysis gives E(k) ~ eps^{2/3} k^{-5/3}.
      This is K41; QLF's only job is to ground "scale-invariant flux" in
      "log 2 per closure, f-independent" (reusing cascade_frequency_increases).
      Nothing to compute -- it is exact once the premise holds.  ZETA_3 = 1
      always (the 4/5 law), a hard check any model must pass.

  (B) intermittency exponents zeta_p.  Real turbulence deviates from the K41
      monofractal zeta_p = p/3 because the cascade is MULTIfractal.  In the
      random-multiplier framework (Kolmogorov refined similarity):

          delta_v_r ~ (eps_r * r)^{1/3},   eps_r = eps_L * prod(W_i) over octaves
          S_p(r) = <delta_v_r^p> ~ r^{zeta_p},
          zeta_p = p/3 - log2< W^{p/3} >          (W = per-octave flux multiplier, <W>=1)

      zeta_3 = 1 - log2<W> = 1 exactly (flux conservation), for ANY W.  So the
      whole content is the distribution of W -- which QLF must supply from
      closure statistics.  Two candidate closure-statistics models:

        * log-normal  (Kolmogorov-Obukhov 1962): zeta_p = p/3 - (mu/18) p (p-3).
          One parameter mu = intermittency exponent; QLF target = derive mu from
          the census variance of closures per octave.  Measured mu ~ 0.25.

        * log-Poisson (She-Leveque 1994): zeta_p = p/3*(1-C0*(1-beta)/... ) ->
          zeta_p = p/9 + 2(1 - (2/3)^{p/3})  with C0=2, beta=2/3.
          PARAMETER-FREE, and C0 = codim of the most singular structures =
          codim of 1D vortex FILAMENTS in 3D = 3-1 = 2 -- which QLF HAS as its
          quantized vortex lines (vortex_quantum / circulation_integer_quantized,
          Onsager-Feynman).  So C0=2 is grounded, not fitted; beta=2/3 is the
          open hook.

This script prints zeta_p for K41, log-normal(mu), She-Leveque, and the measured
values, so the reader can see which the closure statistics must reproduce.
"""

import math

# Measured longitudinal structure-function exponents (representative consensus
# values; e.g. Anselmet et al. 1984, Benzi et al. ESS). Uncertainties ~+-0.02-0.05.
MEASURED = {1: 0.37, 2: 0.70, 3: 1.00, 4: 1.28, 5: 1.54, 6: 1.78, 7: 2.00, 8: 2.13}


def k41(p):
    return p / 3.0


def lognormal(p, mu):
    # Kolmogorov-Obukhov 1962: zeta_p = p/3 - (mu/18) p (p-3)
    return p / 3.0 - (mu / 18.0) * p * (p - 3.0)


def she_leveque(p):
    # zeta_p = p/9 + 2(1 - (2/3)^{p/3}); C0=2, beta=2/3, parameter-free
    return p / 9.0 + 2.0 * (1.0 - (2.0 / 3.0) ** (p / 3.0))


def best_fit_mu():
    # least-squares mu over p=1..8 against MEASURED (excluding p=3, pinned to 1)
    ps = [p for p in MEASURED if p != 3]
    # minimize sum (lognormal(p,mu) - measured)^2 ; closed form (linear in mu)
    # lognormal = p/3 - mu * a_p, a_p = p(p-3)/18 ; residual r = (p/3 - meas) - mu a_p
    num = den = 0.0
    for p in ps:
        a = p * (p - 3.0) / 18.0
        c = p / 3.0 - MEASURED[p]
        num += a * c
        den += a * a
    return num / den if den else float("nan")


def rms(model, *args):
    return math.sqrt(sum((model(p, *args) - MEASURED[p]) ** 2 for p in MEASURED) / len(MEASURED))


def large_p_monotonicity(mu):
    """At high p, log-normal zeta_p turns over and DECREASES (unphysical:
    zeta_p must be non-decreasing). log-Poisson/She-Leveque stays monotone with
    asymptotic slope 1/9 (the minimum Holder exponent). This is the realizability
    argument that SELECTS log-Poisson over log-normal -- and QLF's closure
    statistics are Poisson (poissonOccupation, QLF_CausalContinuum), so a
    Poisson-multiplier cascade is log-Poisson = She-Leveque, not log-normal."""
    turnover = 1.5 + 3.0 / mu  # dzeta/dp = 0 for the log-normal parabola
    return turnover


if __name__ == "__main__":
    print(__doc__)
    mu = best_fit_mu()
    print("=" * 74)
    print("STRUCTURE-FUNCTION EXPONENTS  zeta_p")
    print("=" * 74)
    print(f"{'p':>2} | {'K41 (p/3)':>10} | {'log-normal':>11} | {'She-Leveque':>12} | {'measured':>9}")
    print(f"{'':>2} | {'monofractal':>10} | {'mu='+format(mu,'.3f'):>11} | {'C0=2,b=2/3':>12} | {'':>9}")
    print("-" * 74)
    for p in range(1, 9):
        print(f"{p:>2} | {k41(p):>10.3f} | {lognormal(p, mu):>11.3f} | "
              f"{she_leveque(p):>12.3f} | {MEASURED[p]:>9.3f}")
    print("-" * 74)
    print(f"RMS error vs measured:  K41={rms(k41):.3f}   "
          f"log-normal(mu={mu:.3f})={rms(lognormal, mu):.3f}   "
          f"She-Leveque={rms(she_leveque):.3f}")
    print()
    print("=" * 74)
    print("WHICH CLASS?  large-p realizability  (log-normal vs log-Poisson)")
    print("=" * 74)
    turnover = large_p_monotonicity(mu)
    print(f"{'p':>3} | {'log-normal':>11} | {'She-Leveque':>12}")
    print("-" * 34)
    for p in (6, 12, 15, 18, 24):
        flag = "  <- DECREASING (unphysical)" if p > turnover else ""
        print(f"{p:>3} | {lognormal(p, mu):>11.3f} | {she_leveque(p):>12.3f}{flag}")
    print(f"\n  log-normal zeta_p turns over at p={turnover:.1f} and DECREASES beyond "
          f"-- unphysical\n  (zeta_p must be non-decreasing). She-Leveque stays monotone, "
          f"slope -> 1/9\n  (the minimum Holder exponent of the most-singular structures). So "
          f"log-Poisson\n  is SELECTED on realizability, not just fit -- and QLF closure "
          f"statistics are\n  Poisson (poissonOccupation), giving a log-Poisson cascade = "
          f"She-Leveque.")
    print()
    print("=" * 74)
    print("READING")
    print("=" * 74)
    print(f"""\
* zeta_3 = 1 for K41, log-normal, AND She-Leveque -- the 4/5 law, exact for any
  flux-conserving cascade.  Any QLF closure model MUST reproduce it; it does,
  because <W>=1 is flux conservation (log 2 per closure, conserved down the
  cascade).  This is the -5/3 premise's hard invariant.

* K41 (monofractal) misses the data at high p (RMS {rms(k41):.3f}): the deficit at
  large p IS intermittency -- exactly the QLF 'multifractal, not monofractal'
  reading (the cascade is fractal closures at many frequencies, not one).

* She-Leveque (RMS {rms(she_leveque):.3f}) fits with NO free parameters, and its one
  structural input C0=2 = codimension of 1D vortex filaments in 3D -- an object
  QLF already has (quantized vortex lines, vortex_quantum).  So the parameter
  QLF must ground is grounded; beta=2/3 is the remaining open hook.

* The log-normal route needs mu={mu:.3f} (measured ~0.25); the QLF target there is
  to DERIVE mu from the census variance of realized closures per octave
  (C(2n,n)/4^n fluctuations).  That single-number computation is the cleanest
  falsifiable check: derive mu, compare to {mu:.3f}.

FALSIFIABLE OUTCOME: the fractal-closure reading of intermittency lives or dies
by whether closure statistics yield (a) C0=2 [grounded: vortex-filament codim]
and beta=2/3, or equivalently (b) mu ~ 0.25.  One is grounded; the rest is the
named open computation.  It can fail cleanly -- which is the point.""")
