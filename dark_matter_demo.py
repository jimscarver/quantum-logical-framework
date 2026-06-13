"""
dark_matter_demo.py
===================

Numerical companion to DarkMatter.md (§5-§7) and lean/QLF_DarkMatter.lean.

QLF reads dark matter not as a particle but as the excess *logical density*
the substrate piles up around baryonic matter.  The organizing quantity is an
**acceleration**, not a mass: the crossover between the regime where the local
logic is dense (Newton + GR -- the Mercury / quantum-black-hole regime) and
where it thins to the cosmological floor (apparent dark matter).  That scale is
the de Sitter horizon acceleration on the SAME Hubble radius R_H = c/H_0 that
fixes Omega_Lambda = log 2, reduced by the substrate loop phase 2 pi:

  a_0 = c H_0 / (2 pi) = c^2 / (2 pi R_H)

So the dark sector closes on a single horizon:
  - Omega_Lambda = log 2     governs the sparse exterior  (dark energy)
  - a_0 = c H_0 / (2 pi)      governs the crossover inward (dark matter)

This script computes a_0 for both the Planck-CMB and the local (SH0ES) Hubble
constant, compares to Milgrom's empirically measured acceleration scale
(McGaugh-Lelli-Schombert Radial Acceleration Relation, g_dagger = 1.20e-10
m/s^2), and works the transition radius sigma = sqrt(GM/a_0) and the baryonic
Tully-Fisher relation v^4 = GM a_0 for the Milky Way.

Lean anchors (lean/QLF_DarkMatter.lean):
  mond_acceleration_horizon_form  : a_0 = c^2 / (2 pi R_H)
  mond_radius_accel               : GM / sigma^2 = a_0
  newtonian_dominates_iff         : a_0 < GM/r^2  <->  r^2 < GM/a_0
  tully_fisher_flat               : (GM/r^2 * a_0) * r^2 = GM a_0

Honest scope: the cH_0 *scale* is principled (the de Sitter horizon
acceleration); the exact O(1) prefactor (1/2 pi here, the ~13% residual at
Planck H_0) and a full rotation-curve profile are open
(dark_matter_acceleration_scale_in_progress).  The Gaussian congestion bump is
the transition-zone shape, NOT the flat 1/r^2 tail.

Dependencies: none (pure Python).
"""

import math

# --- Physical constants (CODATA 2022) ---------------------------------------

c_light  = 2.99792458e8       # speed of light (m/s)
G_grav   = 6.67430e-11        # Newton's constant (m^3 kg^-1 s^-2)
Mpc      = 3.0856775814913673e22  # metres per megaparsec
M_sun    = 1.98892e30         # solar mass (kg)

# --- Cosmological observable: Hubble constant (the only input) --------------

H0_PLANCK = 67.4              # km/s/Mpc, Planck 2018 (CMB)
H0_LOCAL  = 73.0              # km/s/Mpc, SH0ES (local distance ladder)

# --- Measured dark-matter acceleration scale --------------------------------
#   McGaugh, Lelli & Schombert (2016), Radial Acceleration Relation:
#   g_dagger = 1.20 +/- 0.02 (random) +/- 0.24 (systematic) x 1e-10 m/s^2
A0_MEASURED      = 1.20e-10   # m/s^2
A0_MEAS_SYST     = 0.24e-10   # m/s^2 (systematic; ~20%)

LOG2 = math.log(2)


def H0_SI(H0_kmsMpc):
    """Convert H_0 from km/s/Mpc to SI (1/s)."""
    return H0_kmsMpc * 1.0e3 / Mpc


def hubble_radius(H0_kmsMpc):
    """R_H = c / H_0 (the same Hubble radius used for Omega_Lambda = log 2)."""
    return c_light / H0_SI(H0_kmsMpc)


def mond_acceleration(H0_kmsMpc):
    """a_0 = c H_0 / (2 pi) = c^2 / (2 pi R_H)."""
    return c_light * H0_SI(H0_kmsMpc) / (2 * math.pi)


def transition_radius(M, a0):
    """sigma = sqrt(GM/a_0): where the Newtonian acceleration equals a_0."""
    return math.sqrt(G_grav * M / a0)


def tully_fisher_v4(M, a0):
    """Deep-regime flat circular speed: v^4 = G M a_0 (independent of r)."""
    return G_grav * M * a0


def gaussian_logic_density(rho0, sigma, r):
    """MRE congestion bump: rho(r) = rho0 exp(-r^2 / 2 sigma^2)."""
    return rho0 * math.exp(-(r ** 2) / (2 * sigma ** 2))


def header(title):
    print("=" * 78)
    print("  " + title)
    print("=" * 78)


def main():
    header("Dark matter as denser logic near masses -- the acceleration scale")
    print()
    print("QLF prediction:  a_0 = c H_0 / (2 pi) = c^2 / (2 pi R_H)")
    print("  (same Hubble radius R_H = c/H_0 that fixes Omega_Lambda = log 2)")
    print()
    print(f"Measured (McGaugh RAR 2016):  g_dagger = {A0_MEASURED:.3e} m/s^2"
          f"  (+/- {A0_MEAS_SYST:.2e} systematic, ~20%)")
    print()

    header("a_0 from the substrate, for both Hubble constants")
    print()
    print(f"  {'H_0 source':<26}{'R_H (m)':>13}{'a_0 (m/s^2)':>15}"
          f"{'dev vs RAR':>13}{'within syst?':>14}")
    print("  " + "-" * 79)
    for label, H0 in [("Planck 2018 CMB (67.4)", H0_PLANCK),
                      ("SH0ES local   (73.0)", H0_LOCAL)]:
        R_H = hubble_radius(H0)
        a0 = mond_acceleration(H0)
        dev = (a0 / A0_MEASURED - 1.0) * 100.0
        n_syst = abs(a0 - A0_MEASURED) / A0_MEAS_SYST
        ok = "yes" if abs(a0 - A0_MEASURED) <= A0_MEAS_SYST else "no"
        print(f"  {label:<26}{R_H:>13.3e}{a0:>15.3e}{dev:>12.1f}%"
              f"{ok + f' ({n_syst:.2f}σ)':>14}")
    print()
    print("  => a_0 = cH_0/(2 pi) matches the measured scale to -13% (Planck H_0)")
    print("     / -6% (local H_0), both inside the RAR ~20% systematic band.")
    print("     The Hubble tension shifts a_0 toward the measured value.")
    print()

    header("Transition radius and Tully-Fisher for the Milky Way")
    print()
    M_MW = 6.0e10 * M_sun     # ~ baryonic mass of the Milky Way (kg)
    a0 = mond_acceleration(H0_PLANCK)
    sigma = transition_radius(M_MW, a0)
    print(f"  Baryonic mass        M  = {M_MW:.3e} kg  (~6e10 M_sun)")
    print(f"  a_0 (Planck H_0)        = {a0:.3e} m/s^2")
    print(f"  Transition radius   sigma = sqrt(GM/a_0) = {sigma:.3e} m"
          f" = {sigma / (3.086e19):.1f} kpc")
    print(f"     (inside sigma: Newton/GR -- dense logic; outside: apparent dark matter)")
    print()
    v4 = tully_fisher_v4(M_MW, a0)
    v_flat = v4 ** 0.25
    print(f"  Baryonic Tully-Fisher: v_flat = (G M a_0)^(1/4) = {v_flat/1e3:.1f} km/s")
    print(f"     (flat, r-independent -- v^4 = G M a_0; observed MW ~ 180-200 km/s)")
    print()

    header("The crossover inequality (newtonian_dominates_iff)")
    print()
    print("  a_0 < GM/r^2   <=>   r < sigma   (dense interior, Newton/GR)")
    print("  a_0 > GM/r^2   <=>   r > sigma   (sparse exterior, apparent dark matter)")
    print()
    for frac, name in [(0.3, "inside (0.3 sigma)"), (1.0, "at sigma"),
                       (3.0, "outside (3 sigma)")]:
        r = frac * sigma
        a_newton = G_grav * M_MW / r ** 2
        regime = "dense  (Newton/GR)" if a_newton > a0 else "sparse (dark matter)"
        print(f"  r = {name:<20} g_N = GM/r^2 = {a_newton:.3e} m/s^2"
              f"   {regime}")
    print()

    header("Summary")
    print()
    print("  a_0 = c H_0 / (2 pi):  -13% (Planck) / -6% (local) vs measured")
    print("                         g_dagger, both inside the ~20% RAR systematic.")
    print("  Same Hubble horizon R_H as Omega_Lambda = log 2 -> one dark sector.")
    print("  Scale principled; 1/2pi prefactor + full rotation curve open")
    print("  (dark_matter_acceleration_scale_in_progress).")
    print()


if __name__ == "__main__":
    main()
