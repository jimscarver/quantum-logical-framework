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
    print("Derived intermediates (Markov-blanket depths in Planck units):")
    R_e = E_Planck_eV / m_e_c2_eV
    R_1 = E_Planck_eV / Ry_eV
    print(f"  R_e = E_Planck / m_e c² = {R_e:.4e}  (electron Compton depth)")
    print(f"  R_1 = E_Planck / Ry     = {R_1:.4e}  (hydrogen ground-state binding depth)")
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
    print("Depth-ratio form (ionization energy is the ground-shell frequency):")
    print("    α² = 2 R_e / R_1  ⇒  α = sqrt(2 R_e / R_1)")
    a_depth = math.sqrt(2.0 * R_e / R_1)
    print(f"    R_e / R_1 = {R_e/R_1:.6e}  (= α²/2 = {alpha_CODATA**2/2:.6e})")
    print(f"    α   = {a_depth:.10f}")
    print(f"    1/α = {1.0 / a_depth:.6f}")
    print()
    print("Reference:")
    print(f"    CODATA α = {alpha_CODATA}")
    print(f"    CODATA 1/α = {1.0 / alpha_CODATA:.6f}")
    print()
    print(f"  relative error (Bohr form):       {abs(a_std - alpha_CODATA) / alpha_CODATA:.2e}")
    print(f"  relative error (QLF per-qubit):   {abs(a_qlf - alpha_CODATA) / alpha_CODATA:.2e}")
    print(f"  relative error (depth-ratio):     {abs(a_depth - alpha_CODATA) / alpha_CODATA:.2e}")
    print()
    print("Bohr shell spectrum — each shell n is a vacuum-resonance mode at depth R_n:")
    print()
    print(f"  {'n':>2}  {'binding (eV)':>14}  {'shell frequency':>18}  {'R_n / R_1':>10}  {'R_n':>12}")
    print(f"  {'-'*2}  {'-'*14}  {'-'*18}  {'-'*10}  {'-'*12}")
    for n in range(1, 7):
        binding = Ry_eV / n**2
        R_n = R_1 * n**2
        omega_n_label = f"Ry / (ℏ n²)"
        print(f"  {n:>2}  {binding:>14.4f}  {'ω_1 / n²':>18}  {n**2:>10}  {R_n:.3e}")
    print()
    print("  Each Bohr shell n has its own Markov-blanket depth R_n = R_1 · n².  The")
    print("  Rydberg series is therefore a discrete frequency spectrum of vacuum-")
    print("  resonance modes of the hydrogen joint-closure topology — analogous to")
    print("  the nuclear-shell vacuum resonances in Magic_numbers.md.  The ionization")
    print("  energy from shell n is the shell frequency E_Planck / R_n.")
    print()
    print("=" * 80)
    print("Honest scoping")
    print("=" * 80)
    print("  ✓ QLF derives the STRUCTURAL RELATION Ry = (1/2) α² m_e c² from Coulomb-")
    print("    via-gauge-twist-exchange (Hydrogen.md §2) + ZFA-depth quantization (§3).")
    print("    Equivalently in QLF Planck units: α² = 2 Ry R_e / E_Planck.")
    print("  ✓ Given any TWO of {α, Ry, m_e}, the third is derived (not measured) to")
    print("    CODATA precision (10⁻¹⁰ relative error).  This demo uses measured Ry and")
    print("    measured m_e and derives α; we could equivalently use measured α and m_e")
    print("    to derive Ry, or measured α and Ry to derive m_e.")
    print("  ✓ Three equivalent forms (Bohr, QLF per-qubit, depth-ratio) all give the")
    print("    same numerical α to 10⁻¹⁰ relative error.")
    print("  ✗ Open: derive at least ONE of {α, Ry, m_e, R_e, R_1} from QLF closure-")
    print("    multiplicity at the Planck-event scale, independently of observation.")
    print("    Currently any one is the calibration anchor and the others follow.  See")
    print("    Per_Qubit_Mass_Quantum.md §3.3 for the structural argument framing.")


if __name__ == "__main__":
    main()
