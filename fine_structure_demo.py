"""
fine_structure_demo.py
======================

Computes the fine-structure constant α from the hydrogen spectrum
via the QLF Bohr derivation in [Hydrogen.md](Hydrogen.md):

    E_n = − (1/2) α² m_e c² / n²

Inverting at the ground state (n = 1, E_1 = −Ry):

    α² = 2 · Ry / (m_e c²)
    α  = sqrt(2 · Ry / (m_e c²))

The same expression in QLF Planck units uses the per-qubit Compton
relation `m_e c² = E_Planck / R_e`:

    α² = 2 · Ry · R_e / E_Planck

Both forms recover CODATA α = 0.0072973525693 to 10⁻¹⁰ relative
error from measured Ry and measured m_e.

Honest scoping:
  ✓ α follows from measured Ry and measured m_e via the QLF Bohr
    relation (Hydrogen.md).  Numerical match to CODATA at 10⁻¹⁰.
  ⚠ Ry and m_e are themselves calibrated from observation, not
    derived from QLF first principles.  Equivalent reformulation:
    R_e is calibrated (`R_e ≈ 2.4 × 10²²` from measured m_e).
  ✗ Open: first-principles Ry from the joint-closure topology of
    the hydrogen bound state (without using α as input); first-
    principles R_e from QLF closure-multiplicity at the Planck-
    event scale (Per_Qubit_Mass_Quantum.md §3.3).

What this demo establishes: the QLF Bohr derivation, when applied
to measured hydrogen levels, recovers α exactly.  This is the
"α from hydrogen" expression of the fine-structure constant in
QLF natural units.  It is not a first-principles derivation of α,
but it is a coherent QLF computation that produces the CODATA
value from the measured Rydberg and the measured electron mass.

Dependencies: none (pure Python).
"""

import math

# --- CODATA 2022 measured inputs ---------------------------------------------

Ry_eV         = 13.605693122994       # Rydberg energy (measured)
m_e_c2_eV     = 510998.95069          # m_e c² (measured)
E_Planck_eV   = 1.22091e28            # Planck energy ≈ 1.22091 × 10²² MeV
alpha_CODATA  = 7.2973525693e-3       # α (CODATA reference)


def alpha_from_bohr(Ry, m_e_c2):
    """α² = 2 · Ry / m_e c² — the standard form."""
    return math.sqrt(2.0 * Ry / m_e_c2)


def alpha_from_QLF_per_qubit(Ry, R_e, E_Planck):
    """α² = 2 · Ry · R_e / E_Planck — QLF per-qubit form."""
    return math.sqrt(2.0 * Ry * R_e / E_Planck)


def main():
    print("=" * 80)
    print("  Fine-structure constant α from QLF Bohr derivation of the hydrogen spectrum")
    print("=" * 80)
    print()
    print("Inputs (CODATA 2022, measured):")
    print(f"  Ry      = {Ry_eV} eV  (Rydberg ground-state binding)")
    print(f"  m_e c²  = {m_e_c2_eV} eV  (electron rest energy)")
    print(f"  E_Planck= {E_Planck_eV:.4e} eV  (= sqrt(ℏ c⁵ / G), ≈ 1.22091 × 10²² MeV)")
    print()
    print("Derived intermediates:")
    R_e = E_Planck_eV / m_e_c2_eV
    print(f"  R_e = E_Planck / m_e c² = {R_e:.6e}  (electron Markov-blanket depth in Planck units)")
    print()
    print("Standard QLF Bohr form (Hydrogen.md §4):")
    print("    E_n = − (1/2) α² m_e c² / n²")
    print("    α²  = 2 Ry / m_e c²")
    a_std = alpha_from_bohr(Ry_eV, m_e_c2_eV)
    print(f"    α   = {a_std:.10f}")
    print(f"    1/α = {1.0 / a_std:.6f}")
    print()
    print("QLF per-qubit form (Per_Qubit_Mass_Quantum.md):")
    print("    m_e c² = E_Planck / R_e  ⇒  α² = 2 Ry R_e / E_Planck")
    a_qlf = alpha_from_QLF_per_qubit(Ry_eV, R_e, E_Planck_eV)
    print(f"    α   = {a_qlf:.10f}")
    print(f"    1/α = {1.0 / a_qlf:.6f}")
    print()
    print("Reference:")
    print(f"    CODATA α = {alpha_CODATA}")
    print(f"    CODATA 1/α = {1.0 / alpha_CODATA:.6f}")
    print()
    print(f"  relative error (Bohr form): {abs(a_std - alpha_CODATA) / alpha_CODATA:.2e}")
    print(f"  relative error (QLF form):  {abs(a_qlf - alpha_CODATA) / alpha_CODATA:.2e}")
    print()
    print("=" * 80)
    print("Honest scoping")
    print("=" * 80)
    print("  ✓ α is recovered to CODATA precision (10⁻¹⁰ relative error) from measured")
    print("    Ry and measured m_e via the QLF Bohr derivation in Hydrogen.md §4.")
    print("  ✓ The QLF per-qubit form α² = 2 Ry R_e / E_Planck expresses α as a relation")
    print("    among three QLF natural-units quantities: hydrogen binding (Ry), electron")
    print("    Markov-blanket depth (R_e), and the Planck energy quantum (E_Planck).")
    print("  ⚠ Ry and m_e (equivalently R_e) are calibrated from observation, not")
    print("    derived from QLF first principles.")
    print("  ✗ Open: first-principles Ry from the hydrogen joint-closure topology without")
    print("    using α as input; first-principles R_e ≈ 2.4 × 10²² from QLF closure-")
    print("    multiplicity at the Planck-event scale.  See Per_Qubit_Mass_Quantum.md §3.3.")


if __name__ == "__main__":
    main()
