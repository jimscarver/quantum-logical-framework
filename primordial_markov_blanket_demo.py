"""
primordial_markov_blanket_demo.py
==================================

Numerical companion to Primordial_Markov_Blankets.md.  Demonstrates
the Fuller frequency-v geodesic-sphere accounting that underlies
QLF's substrate-event-counting program at every scale.

For each frequency v:
    V_v = 10 v^2 + 2   vertices
    E_v = 30 v^2       edges
    F_v = 20 v^2       triangular faces (= substrate holographic events)
    Euler  V - E + F = 2  (topological 2-sphere invariant)
    12 pentamons       (universal substrate curvature signature)

The headline connection: the holographic event count 4 pi R^2 / L_P^2
used in v1.3.0 Newton's law, v1.4.0 Mercury perihelion, and v1.5.0
cosmological constant IS the face count F_v of a primordial Markov
blanket at frequency v(R) = sqrt(pi/5) x R/L_P.

McKay correspondence anchor: binary icosahedral group 2I (the
substrate's primordial-blanket closure group) is McKay-dual to E_8
(largest exceptional Lie group, dim = 248).

Dependencies: none (pure Python).
"""

import math

# --- Substrate primitives (CODATA 2022) -------------------------------------

L_Planck   = 1.616255e-35   # Planck length (m)
c_light    = 2.99792458e8   # speed of light (m/s)
hbar       = 1.054571817e-34
H_0_kmsMpc = 67.4
H_0_SI     = H_0_kmsMpc * 1000 / 3.0857e22   # Hubble (1/s)
R_H        = c_light / H_0_SI                # Hubble radius

# --- Fuller subdivision formulas -------------------------------------------

def vertices(v):
    """V_v = 10 v^2 + 2."""
    return 10 * v**2 + 2

def edges(v):
    """E_v = 30 v^2."""
    return 30 * v**2

def faces(v):
    """F_v = 20 v^2."""
    return 20 * v**2

def euler_characteristic(v):
    """V - E + F = 2 for any v (topological 2-sphere)."""
    return vertices(v) - edges(v) + faces(v)

def pentamon_count(v):
    """Exactly 12 pentamons at every frequency."""
    return 12

def hexamon_count(v):
    """h_v = V_v - 12 = 10(v^2 - 1)."""
    return vertices(v) - 12

def holographic_event_count(v):
    """N_events(v) = F_v = 20 v^2."""
    return faces(v)

def information_capacity_nats(v):
    """S(v) = F_v * log 2 nats (substrate area law)."""
    return faces(v) * math.log(2)

# --- Connection to physical radius ------------------------------------------

def fuller_frequency_from_radius(R, L_P=L_Planck):
    """v(R) = sqrt(pi/5) * R / L_Planck.

    Derived from 4 pi R^2 / L_P^2 = 20 v^2 (holographic event count
    equality).  Solving: v = sqrt(pi/5) * R/L_P ~= 0.793 * R/L_P.
    """
    return math.sqrt(math.pi / 5) * R / L_P

def radius_from_fuller_frequency(v, L_P=L_Planck):
    """R(v) = sqrt(5/pi) * v * L_Planck."""
    return math.sqrt(5 / math.pi) * v * L_P

# --- McKay correspondence constants ----------------------------------------

BINARY_ICOSAHEDRAL_ORDER = 120
E8_DIMENSION = 248

# --- Output helpers ---------------------------------------------------------

def header(title):
    print("=" * 80)
    print("  " + title)
    print("=" * 80)


def main():
    header("Primordial Markov blanket: Fuller frequency-v geodesic sphere")
    print()
    print("Substrate identification (Primordial_Markov_Blankets.md):")
    print("  Every Markov blanket in QLF is a Fuller frequency-v geodesic")
    print("  sphere of ZFA-balanced 1/2-spin closures with icosahedral")
    print("  symmetry.  The holographic event count 4 pi R^2 / L_P^2 used")
    print("  in v1.3.0-1.5.0 IS the face count F_v = 20 v^2 of this blanket.")
    print()

    header("Fuller subdivision: V_v, E_v, F_v at small frequencies")
    print()
    print(f"  {'v':>4}  {'V_v':>8}  {'E_v':>8}  {'F_v':>8}  "
          f"{'V-E+F':>6}  {'pent':>5}  {'hexa':>8}")
    print(f"  {'-'*4}  {'-'*8}  {'-'*8}  {'-'*8}  {'-'*6}  {'-'*5}  {'-'*8}")
    for v in range(1, 11):
        V = vertices(v)
        E = edges(v)
        F = faces(v)
        chi = euler_characteristic(v)
        p = pentamon_count(v)
        h = hexamon_count(v)
        print(f"  {v:>4}  {V:>8}  {E:>8}  {F:>8}  {chi:>6}  {p:>5}  {h:>8}")
    print()
    print("  Euler V - E + F = 2 at every frequency (topological 2-sphere).")
    print("  Pentamon count = 12 at every frequency (universal curvature signature).")
    print("  Hexamon count = 10(v^2 - 1) grows with v while pentamons stay fixed.")
    print()

    header("Information capacity (substrate area law)")
    print()
    print(f"  {'v':>4}  {'F_v':>10}  {'S(v) = F_v * log 2':>22}  {'(nats)':>8}")
    print(f"  {'-'*4}  {'-'*10}  {'-'*22}  {'-'*8}")
    for v in [1, 10, 100, 1000, 10000]:
        F = faces(v)
        S = information_capacity_nats(v)
        print(f"  {v:>4}  {F:>10}  {S:>22.2e}  nats")
    print()
    print("  Information scales as v^2 (face count), not v^3 (volume).")
    print("  This is the Bekenstein-Hawking area law at substrate granularity.")
    print()

    header("Connection to v1.3.0-1.5.0: substrate-event-counting at every scale")
    print()
    print("  Holographic event count equality:")
    print("    4 pi R^2 / L_Planck^2 = 20 v^2 = F_v")
    print("  =>")
    print("    v(R) = sqrt(pi/5) * R / L_Planck  ~=  0.793 * R / L_Planck")
    print()
    print("  Substrate Markov blankets at QLF v1.3.0-1.5.0 scales:")
    print()
    print(f"  {'object':<30}  {'R (m)':>12}  {'R / L_P':>12}  {'v(R)':>12}")
    print(f"  {'-'*30}  {'-'*12}  {'-'*12}  {'-'*12}")
    scales = [
        ("base icosahedron (v=1)",              radius_from_fuller_frequency(1)),
        ("hydrogen 1s (a_0)",                   5.29e-11),
        ("electron Compton (lambda_C)",         2.43e-12),
        ("proton (R_p ~ 0.83e-15 m)",           0.83e-15),
        ("Sun's Schwarzschild radius",          2.95e3),
        ("Earth orbit semi-major axis",         1.50e11),
        ("Milky Way radius (~25 kpc)",          7.72e20),
        ("Cosmic horizon (R_H)",                R_H),
    ]
    for name, R in scales:
        ratio = R / L_Planck
        v = fuller_frequency_from_radius(R)
        print(f"  {name:<30}  {R:>12.3e}  {ratio:>12.3e}  {v:>12.3e}")
    print()
    print("  The cosmic Markov blanket has Fuller frequency v_cosmic ~ 6.7e60.")
    print("  Its F_v = 20 v^2 ~ 9e122 substrate events drive the cosmological")
    print("  constant Lambda + Omega_Lambda = log 2 derivation of v1.5.0.")
    print("  All v1.3.0-1.5.0 substrate-event counts are face counts of")
    print("  primordial Markov blankets at the appropriate frequency.")
    print()

    header("McKay correspondence: E_8 hidden in the substrate")
    print()
    print("  Theorem (McKay 1980): finite subgroups of SU(2) correspond")
    print("  bijectively to simply-laced Dynkin diagrams.")
    print()
    print(f"  {'finite subgroup of SU(2)':<32}  {'McKay-dual':>16}")
    print(f"  {'-'*32}  {'-'*16}")
    print(f"  {'cyclic Z_n':<32}  {'A_(n-1)':>16}")
    print(f"  {'binary dihedral 2D_n':<32}  {'D_(n+2)':>16}")
    print(f"  {'binary tetrahedral 2T':<32}  {'E_6':>16}")
    print(f"  {'binary octahedral 2O':<32}  {'E_7':>16}")
    print(f"  {'BINARY ICOSAHEDRAL 2I':<32}  {'E_8':>16}  <-- substrate")
    print()
    print(f"  |2I| = {BINARY_ICOSAHEDRAL_ORDER} (order of binary icosahedral group)")
    print(f"  dim E_8 = {E8_DIMENSION} (largest exceptional Lie group)")
    print()
    print("  QLF substrate's primordial-blanket symmetry is 2I.  Therefore")
    print("  E_8 symmetry is structurally encoded in the substrate via McKay.")
    print("  This is a substrate-level Langlands-adjacent identification:")
    print("  the same pattern that classifies finite SU(2) subgroups also")
    print("  classifies QLF's substrate-event-counting structure.")
    print()

    header("Honest scoping")
    print()
    print("  Tier 1 (structural, Lean-anchored in QLF_PrimordialMarkovBlanket.lean):")
    print("    - Fuller V_v / E_v / F_v formulas")
    print("    - Euler V - E + F = 2 at every frequency")
    print("    - 12 pentamons invariant under subdivision")
    print("    - Holographic event count = F_v = 20 v^2")
    print("    - Binary icosahedral order = 120, E_8 dimension = 248")
    print("    - McKay correspondence 2I <-> E_8 (anchored as structural identity)")
    print()
    print("  Tier 2 (numerical):")
    print("    - All v1.3.0-1.5.0 substrate-event counts are F_v of primordial")
    print("      blankets at the appropriate frequency v(R).")
    print("    - Cosmic blanket frequency v_cosmic ~ 6.7e60.")
    print()
    print("  Tier 3 (open):")
    print("    - Structural derivation that exactly 12 pentamons is forced by")
    print("      Euler chi = 2 + triangulation from substrate-event accounting")
    print("    - Specific E_8 unification phenomenology (mass spectra, couplings)")
    print("    - Bridge to StringTheoryQLF / MTheoryQLF E_8 constructions")
    print("    - Higher-genus Markov blankets (torus, multi-handle) at the")
    print("      substrate level")
    print("    - Full geometric Langlands bridge (perverse sheaves, D-modules)")


if __name__ == "__main__":
    main()
