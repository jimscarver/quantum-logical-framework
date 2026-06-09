"""
bethe_log_demo.py
=================

Companion to Lamb_Shift.md sec 6 — the Bethe constant k(n,0).

The Lamb shift's effective log is  L_eff(n) = 2 log(1/alpha) - k(n,0) + small,
where k(n,0) is the Bethe LOGARITHM:  k(n,0) = ln( I_n / Ry ), with I_n the
oscillator-strength-weighted geometric-mean *excitation* energy of the shell.

  Published (standard QED):  k(1,0) = 2.984128556   ->  I_1S = 19.77 Ry
                             k(2,0) = 2.811769893   ->  I_2S = 16.64 Ry

This demo's purpose is NOT to "derive 2.984 from substrate" — it is to show,
with exact bound-state numbers, WHY that derivation is not a combinatoric
exercise:

  * Every BOUND transition 1s->np has excitation energy  dE = 1 - 1/n^2 < 1 Ry.
  * Yet the Bethe mean excitation energy is I_1S = 19.77 Ry  (~269 eV).
  * A geometric mean of 19.77 Ry therefore CANNOT come from bound shells at all
    (all of which sit below 1 Ry).  It is set by the high-energy CONTINUUM —
    virtual photoelectron states at tens of Ry.

QLF reading.  QLF's bound-shell closure-counting (the C(2n,n) topology census)
captures the discrete part of the spectrum.  The Bethe logarithm is dominated
by the *free-electron continuum* sector, which is above the RCA_0 combinatoric
floor the substrate operates in.  So k(n,0) is best classified as a PRINCIPLED
BOUNDARY (cf. the spectral_hilbert_polya axiom), not a closeable Tier-3 gap:
the substrate fixes the structural form (alpha^5, log(alpha^-2) range, the
4/(3 pi n^3) prefactor) and the IR cutoff; the continuum-weighting NUMBER is
inherited as a boundary input.

Pure Python, no dependencies.  CODATA where it matters.
"""

import math

Ry_eV = 13.605693122      # Rydberg energy
k_1S  = 2.984128556       # Bethe logarithm, 1S  (standard QED)
k_2S  = 2.811769893       # Bethe logarithm, 2S
k_2P  = -0.030016709      # Bethe logarithm, 2P  (tiny -> 2S dominates the shift)


def f_1s_np(n):
    """Exact 1s->np dipole oscillator strength (closed form).

        f = 2^8 n^5 (n-1)^(2n-4) / ( 3 (n+1)^(2n+4) )
    """
    return (2**8 * n**5 * (n - 1)**(2*n - 4)) / (3 * (n + 1)**(2*n + 4))


def dE_1s_np_Ry(n):
    """Excitation energy 1s->np in Ry:  dE = 1 - 1/n^2  (< 1 Ry always)."""
    return 1.0 - 1.0 / n**2


def header(t):
    print("=" * 78)
    print("  " + t)
    print("=" * 78)


def main():
    header("Bethe logarithm k(n,0): the continuum-dominated piece of the Lamb shift")
    print()
    print("  k(n,0) = ln( I_n / Ry ),  I_n = mean excitation energy of shell n.")
    print(f"  Published:  k(1,0) = {k_1S:.9f}  ->  I_1S = exp(k) Ry = {math.exp(k_1S):7.3f} Ry"
          f" = {math.exp(k_1S)*Ry_eV:7.2f} eV")
    print(f"              k(2,0) = {k_2S:.9f}  ->  I_2S = exp(k) Ry = {math.exp(k_2S):7.3f} Ry"
          f" = {math.exp(k_2S)*Ry_eV:7.2f} eV")
    print()

    header("Bound transitions 1s -> np  (exact closed-form oscillator strengths)")
    print()
    print(f"  {'n':>3}  {'f(1s->np)':>12}  {'dE [Ry]':>10}  {'dE [eV]':>10}  {'ln(dE/Ry)':>11}")
    print(f"  {'-'*3}  {'-'*12}  {'-'*10}  {'-'*10}  {'-'*11}")
    f_sum = 0.0
    fln_sum = 0.0
    w_sum = 0.0          # (dE^2 f) weight  -- the Bethe high-energy-emphasizing weight
    wln_sum = 0.0
    for n in range(2, 41):
        f = f_1s_np(n)
        dE = dE_1s_np_Ry(n)
        f_sum += f
        fln_sum += f * math.log(dE)
        w = dE**2 * f
        w_sum += w
        wln_sum += w * math.log(dE)
        if n <= 7:
            print(f"  {n:>3}  {f:>12.6f}  {dE:>10.6f}  {dE*Ry_eV:>10.4f}  {math.log(dE):>11.5f}")
    print(f"  ...  (summed through n=40)")
    print()
    print(f"  Sum of bound oscillator strengths      sum f_bound = {f_sum:.4f}")
    print(f"  Thomas-Reiche-Kuhn total (bound+cont)  sum f_all   = 1.0000  (exact sum rule)")
    print(f"  => continuum oscillator strength       sum f_cont  = {1 - f_sum:.4f}")
    print()
    print("  KEY FACT: every bound dE = 1 - 1/n^2 lies in [0.75, 1.0) Ry.")
    print(f"  Largest possible bound excitation energy (threshold)  = 1.000 Ry = {Ry_eV:.2f} eV.")
    print()

    header("Why k(n,0) is continuum-dominated (the honest classification)")
    print()
    I_1S = math.exp(k_1S)
    print(f"  Bethe mean excitation energy  I_1S = {I_1S:.2f} Ry = {I_1S*Ry_eV:.1f} eV.")
    print(f"  But ALL bound transitions sit below 1 Ry.  A geometric mean of {I_1S:.1f} Ry")
    print("  is therefore impossible from bound shells alone -- it is set by the")
    print("  high-energy CONTINUUM (virtual photoelectron states at tens of Ry).")
    print()
    print("  Two distinct 'mean excitation energies' make the weighting visible:")
    print(f"    - stopping-power I_0 (plain f-weighting):   ~1.1 Ry  (~15 eV)")
    print(f"    - Lamb-shift Bethe I (dE^2 f-weighting):    {I_1S:.1f} Ry  (~269 eV)")
    print("    The Bethe weight dE^2 f emphasizes high energies -> continuum wins.")
    print()
    bound_meanln = wln_sum / w_sum
    print(f"  Bound-only (dE^2 f)-weighted mean of ln(dE/Ry) = {bound_meanln:+.4f}")
    print(f"  (i.e. bound states alone would give I < Ry; the observed k = +{k_1S:.3f}")
    print("   is supplied entirely by the continuum.  Bound shells contribute a")
    print("   small NEGATIVE amount -- the continuum flips the sign and dominates.)")
    print()

    header("A coincidence worth flagging (NOT a derivation)")
    print()
    print(f"  2 pi^2 = {2*math.pi**2:.4f}  vs  I_1S = {I_1S:.4f} Ry   (agree to {abs(2*math.pi**2-I_1S)/I_1S*100:.2f}%)")
    print(f"  log(2 pi^2) = {math.log(2*math.pi**2):.5f}  vs  k(1,0) = {k_1S:.5f}")
    print("  Tempting, but it is a 1S-only coincidence: a single n-independent")
    print(f"  constant cannot also match k(2,0) = {k_2S:.4f} (I_2S = {math.exp(k_2S):.2f} Ry).")
    print("  The Bethe logarithm has no closed form; we do not claim one.")
    print()

    header("QLF classification of k(n,0)")
    print()
    print("  Substrate-derived (Tier 1, Lamb_Shift.md secs 3-5, QLF_LambShift.lean):")
    print("    - alpha^5 m_e c^2 scaling (two-vertex loop on Bohr)")
    print("    - log(alpha^-2) Bethe-log RANGE from the [R_e, R_n] depth ratio")
    print("    - 4/(3 pi n^3) prefactor (mostly decomposed)")
    print("    - the IR cutoff R_e (electron Compton depth) and UV cutoff R_n")
    print()
    print("  Boundary input (NOT a closeable Tier-3 gap):")
    print("    - k(n,0) itself: the continuum-weighted geometric mean excitation")
    print("      energy.  Dominated by free-electron virtual states, which live")
    print("      ABOVE the RCA_0 combinatoric floor of bound-shell closure counts.")
    print("      Classify like spectral_hilbert_polya: a principled logical")
    print("      boundary, with the structural form fixed and the number inherited.")


if __name__ == "__main__":
    main()
