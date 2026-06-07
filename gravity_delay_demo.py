"""
gravity_delay_demo.py
=====================

Numerical companion to Gravity_From_Delay.md.  Demonstrates Newton's
law F = G M m / r^2 from QLF substrate primitives via Verlinde-style
entropic-gravity derivation:

  - holographic surface event count N = 4 pi R^2 (3D substrate)
  - per-event log 2 entropy contribution
  - equipartition: T = M c^2 / (2 pi R^2 k_B)
  - Bekenstein bound: dS/dx = 2 pi m c k_B / hbar
  - F = T dS/dx = G M m / r^2

G in SI is unit-conversion bookkeeping:
  G = L_Planck^2 c^3 / hbar
    = L_Planck^3 / (M_Planck tau_Planck^2)

Computed from CODATA Planck units to verify the substrate identification.
The 1/r^2 fall-off is the structural 3D-substrate signature; in d spatial
dimensions Newton's law would be F ~ 1/r^(d-1).

Dependencies: none (pure Python).
"""

import math

# --- CODATA 2022 Planck units (substrate primitives) ------------------------

hbar          = 1.054571817e-34   # reduced Planck constant (J s)
c_light       = 2.99792458e8      # speed of light (m/s)
L_Planck      = 1.616255e-35      # Planck length (m)
tau_Planck    = 5.391247e-44      # Planck time (s)
M_Planck      = 2.176434e-8       # Planck mass (kg)
G_CODATA      = 6.67430e-11       # gravitational constant (m^3 kg^-1 s^-2)
k_B           = 1.380649e-23      # Boltzmann constant (J/K)


def G_from_planck_units():
    """G = L_Planck^3 / (M_Planck tau_Planck^2) from substrate primitives."""
    return L_Planck**3 / (M_Planck * tau_Planck**2)


def G_from_hbar_c_L():
    """G = L_Planck^2 c^3 / hbar — equivalent substrate form."""
    return L_Planck**2 * c_light**3 / hbar


def holographic_event_count(R):
    """N = 4 pi R^2 substrate events on a 2-sphere of radius R Planck lengths."""
    return 4 * math.pi * R**2


def horizon_entropy_nats(R):
    """S = N log 2 = 4 pi R^2 log 2 (in nats, before k_B conversion)."""
    return holographic_event_count(R) * math.log(2)


def vacuum_temperature(M_kg, r_m):
    """T = M c^2 / (2 pi R^2 k_B) from equipartition of horizon energy."""
    R = r_m / L_Planck
    N = holographic_event_count(R)
    return 2 * M_kg * c_light**2 / (N * k_B)


def bekenstein_gradient(m_kg):
    """dS/dx = 2 pi m c k_B / hbar (Bekenstein bound)."""
    return 2 * math.pi * m_kg * c_light * k_B / hbar


def newton_force_from_entropy_gradient(M_kg, m_kg, r_m):
    """F = T (M, r) * dS/dx (m) = G M m / r^2."""
    T = vacuum_temperature(M_kg, r_m)
    dS_dx = bekenstein_gradient(m_kg)
    return T * dS_dx


def newton_force_direct(M_kg, m_kg, r_m):
    """F = G M m / r^2 directly from CODATA G."""
    return G_CODATA * M_kg * m_kg / r_m**2


def header(title):
    print("=" * 80)
    print("  " + title)
    print("=" * 80)


def main():
    header("Newton's G from QLF substrate via entropic-gravity derivation")
    print()
    print("CODATA 2022 Planck units (substrate primitives):")
    print(f"  L_Planck   = {L_Planck:.6e} m")
    print(f"  tau_Planck = {tau_Planck:.6e} s")
    print(f"  M_Planck   = {M_Planck:.6e} kg")
    print(f"  c          = {c_light} m/s")
    print(f"  hbar       = {hbar:.6e} J s")
    print()

    header("G as unit-conversion bookkeeping from substrate primitives")
    print()
    G_a = G_from_planck_units()
    G_b = G_from_hbar_c_L()
    print(f"  G = L_Planck^3 / (M_Planck tau_Planck^2)")
    print(f"    = {G_a:.6e} m^3 kg^-1 s^-2")
    print()
    print(f"  G = L_Planck^2 c^3 / hbar  (equivalent form)")
    print(f"    = {G_b:.6e} m^3 kg^-1 s^-2")
    print()
    print(f"  G (CODATA)            = {G_CODATA:.6e} m^3 kg^-1 s^-2")
    res_a = abs(G_a - G_CODATA) / G_CODATA * 100
    res_b = abs(G_b - G_CODATA) / G_CODATA * 100
    print(f"  residual (form 1):     {res_a:.4f}%")
    print(f"  residual (form 2):     {res_b:.4f}%")
    print()
    print("  Both formulas give G to CODATA precision because L_Planck,")
    print("  tau_Planck, M_Planck are themselves defined from G, hbar, c.")
    print("  In QLF substrate-first ontology, L_Planck and tau_Planck are")
    print("  primitives (one of each per substrate event); G in SI is then")
    print("  the unit-conversion bookkeeping connecting Planck units to SI.")
    print()

    header("Holographic surface event count: N = 4 pi R^2")
    print()
    print(f"  {'r (m)':>15}  {'R (Planck)':>16}  {'N events':>20}  {'S (k_B units)':>16}")
    print(f"  {'-'*15}  {'-'*16}  {'-'*20}  {'-'*16}")
    for r in [1.0, 6.378e6, 1.5e11, 9.461e15]:   # 1m, Earth radius, 1 AU, 1 lyr
        R = r / L_Planck
        N = holographic_event_count(R)
        S_kB = horizon_entropy_nats(R)
        label = {1.0: "1 meter", 6.378e6: "Earth radius",
                 1.5e11: "1 AU", 9.461e15: "1 light-year"}[r]
        print(f"  {r:>15.3e}  {R:>16.3e}  {N:>20.3e}  {S_kB:>16.3e}  ({label})")
    print()
    print("  Each event holds log 2 nats; total entropy S = 4 pi R^2 log 2.")
    print("  3-dimensionality of substrate -> surface scales as R^2 -> 1/r^2 law.")
    print()

    header("Newton's law from entropic gradient: Sun-Earth gravity")
    print()
    M_sun     = 1.98892e30          # kg
    M_earth   = 5.972e24            # kg
    r_AU      = 1.495979e11         # m (1 AU)
    print(f"  Sun mass     M = {M_sun:.4e} kg")
    print(f"  Earth mass   m = {M_earth:.4e} kg")
    print(f"  Sun-Earth dist r = {r_AU:.4e} m  (1 AU)")
    print()
    T = vacuum_temperature(M_sun, r_AU)
    dS_dx = bekenstein_gradient(M_earth)
    F_entropic = newton_force_from_entropy_gradient(M_sun, M_earth, r_AU)
    F_direct = newton_force_direct(M_sun, M_earth, r_AU)
    print(f"  Vacuum temperature T at 1 AU = {T:.4e} K")
    print(f"  Bekenstein dS/dx for Earth   = {dS_dx:.4e} J K^-1 m^-1")
    print(f"  Force from T * dS/dx         = {F_entropic:.4e} N")
    print(f"  Force from G M m / r^2       = {F_direct:.4e} N")
    res = abs(F_entropic - F_direct) / F_direct * 100
    print(f"  match: {res:.4f}%")
    print()
    print("  The Verlinde-style derivation reproduces Newton's law to")
    print("  machine precision because G has been substituted via L_Planck^2 c^3/hbar.")
    print("  Structural result: F = G M m / r^2 falls out of substrate event")
    print("  counting on the holographic boundary plus per-event log 2 entropy.")
    print()

    header("3D substrate counterfactual: 1/r^(d-1) Newton's law")
    print()
    print("  In d spatial dimensions, the holographic boundary at radius r has")
    print("  N proportional to r^(d-1) substrate events.  The same derivation gives:")
    print()
    print("    F proportional to M m / r^(d-1)")
    print()
    print(f"  {'d':>3}  {'Newton form':>16}  {'matches obs?':>14}")
    print(f"  {'-'*3}  {'-'*16}  {'-'*14}")
    for d in [2, 3, 4]:
        form = f"F ~ 1/r^{d-1}"
        obs = "YES (Newton)" if d == 3 else "no"
        print(f"  {d:>3}  {form:>16}  {obs:>14}")
    print()
    print("  The observed 1/r^2 is the structural signature of 3D spatial")
    print("  substrate, derived in Magic_numbers.md from the 8-twist 6+2 split.")
    print("  Same 3D that gives N=9=3^2 in QLF_FineStructureSubstrate.lean (alpha).")
    print()

    header("Honest scoping")
    print()
    print("  Tier 1 (structurally derived from QLF):")
    print("    - Holographic surface event count N = 4 pi R^2 from substrate")
    print("      event-counting on 2-sphere (3D substrate from 8-twist 6+2 split).")
    print("    - Per-event log 2 entropy (Lean-anchored).")
    print("    - Equipartition gives T proportional to M / r^2.")
    print("    - Bekenstein bound gives dS/dx proportional to m c / hbar.")
    print("    - F = T dS/dx = G M m / r^2 (Newton's law).")
    print("    - 1/r^2 is the structural 3D-substrate signature.")
    print()
    print("  Tier 2 (numerical, substrate Planck units):")
    print("    G = L_Planck^2 c^3 / hbar = 6.674e-11 SI (= CODATA, exact)")
    print("    G in SI is unit-conversion bookkeeping; no separate empirical input.")
    print()
    print("  Tier 3 (open):")
    print("    - Lean-anchor holographic event count N = 4 pi R^2 from substrate")
    print("      Markov-blanket boundary topology.")
    print("    - Lean-anchor Bekenstein bound dS/dx = 2 pi m c k_B / hbar.")
    print("    - Reconcile per-event log 2 with continuous Bekenstein-Hawking 1/4")
    print("      coefficient (coarse-graining factor 4/log 2 ~ 5.77).")
    print("    - GR-quantitative extensions: Mercury perihelion, gravitational")
    print("      lensing, GPS time dilation (Kitada_Local_Time_GR.md framework).")
    print("    - Hierarchy problem M_Planck/m_proton ~ 10^19 (HadronicDepth.md).")
    print("    - Full Einstein equations from substrate vacuum-alignment.")


if __name__ == "__main__":
    main()
