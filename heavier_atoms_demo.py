"""
heavier_atoms_demo.py
=====================

Compute QLF Markov-blanket depths `R_X = E_Planck / (M_X c²)` for a panel
of atomic systems from ¹H to ²³⁸U, under the per-qubit Compton accounting
of `Per_Qubit_Mass_Quantum.md`.  Frames the resulting spectrum under the
vacuum-alignment principle (`VacuumEnergy.md` §6.1): observed atomic
systems are the vacuum-resonance projection of admissible Markov-blanket
depths, with shell-model magic numbers visible as binding-energy peaks.

The script prints (a) the depth `R_X` for each system, (b) the residual
from the `R ∝ 1/A` baseline, and (c) the per-nucleon binding energy
BE/A — the standard empirical signature of shell structure.  No fit, no
prediction; this is the structural panel that `Atomic_System_QLF_Closures.md`
§7 documents.

Honest scoping (matches `Atomic_System_QLF_Closures.md` §7.4):
  - ✓ derived: depth `R_X` from each measured mass; the `R ∝ 1/A` baseline.
  - ⚠ reframed: magic-number features = vacuum-resonance peaks under §6.1.
  - ✗ open: first-principles QLF derivation of the magic-number sequence.

Dependencies: numpy only.
"""

import numpy as np

# Planck energy in MeV.  E_Planck = sqrt(ℏ c⁵ / G) ≈ 1.22091 × 10^19 GeV.
E_PLANCK_MEV = 1.22091e22

# Atomic mass unit u = 931.494 MeV/c².
AMU_MEV = 931.494

# (A, system name, total atomic mass in MeV, per-nucleon binding energy
# BE/A in MeV).  Atomic masses from CODATA 2022 (electrons + binding
# included).  BE/A from standard nuclear data tables.
ATOMS = [
    (  1,   "H1",       938.7831,  0.000),
    (  2,   "H2 (D)",  1876.124,   1.112),
    (  3,   "H3 (T)",  2809.432,   2.827),
    (  3,   "He3",     2809.413,   2.573),
    (  4,   "He4",     3728.401,   7.074),
    (  6,   "Li6",     5603.052,   5.332),
    (  7,   "Li7",     6535.366,   5.606),
    ( 12,   "C12",    11177.929,   7.680),
    ( 16,   "O16",    14899.169,   7.976),
    ( 28,   "Si28",   26060.339,   8.448),
    ( 40,   "Ca40",   37224.911,   8.551),
    ( 56,   "Fe56",   52102.713,   8.790),
    ( 58,   "Ni58",   53965.916,   8.732),
    ( 90,   "Zr90",   83755.461,   8.710),
    (140,   "Ce140", 130358.62,    8.376),
    (208,   "Pb208", 193687.100,   7.867),
    (238,   "U238",  221695.510,   7.570),
]

# Standard magic numbers (Mayer-Jensen):  2, 8, 20, 28, 50, 82, 126.

def main():
    print("Heavier atoms — depth panel under per-qubit Compton + vacuum-alignment §6.1")
    print("=" * 88)
    print(f"  E_Planck = {E_PLANCK_MEV:.3e} MeV   m_amu = {AMU_MEV:.3f} MeV")
    print(f"  Per-qubit Compton: M c² = ℏω = E_Planck / R,  so  R = E_Planck / M c²")
    print()
    print(f"  {'A':>4}  {'system':<8}  {'M (MeV)':>11}    {'R = E_P / M':>11}    "
          f"{'R · A / E_P':>11}    {'BE/A (MeV)':>10}")
    print(f"  {'-'*4}  {'-'*8}  {'-'*11}    {'-'*11}    {'-'*11}    {'-'*10}")
    A_arr = np.array([a[0] for a in ATOMS])
    M_arr = np.array([a[2] for a in ATOMS])
    R_arr = E_PLANCK_MEV / M_arr
    # Residual from R ∝ 1/A baseline: R · A / E_P should be ≈ 1/m_amu
    # (i.e. ≈ 1.0735 × 10⁻³ MeV⁻¹) if M ≈ A · m_amu exactly.  Deviations
    # are due to binding-energy (mass-defect) variation across the panel.
    residual_arr = R_arr * A_arr / E_PLANCK_MEV  # = 1 / (M / A)
    for (A, name, M, BEA), R, res in zip(ATOMS, R_arr, residual_arr):
        print(f"  {A:>4}  {name:<8}  {M:>11.3f}    {R:>11.4e}    {res:>11.4e}    {BEA:>10.3f}")

    print()
    print("Baseline check (R · A / E_P ≈ 1 / m_amu):")
    inv_amu = 1.0 / AMU_MEV
    mean_res = float(np.mean(residual_arr))
    print(f"  1 / m_amu     = {inv_amu:.4e}  MeV⁻¹")
    print(f"  mean residual = {mean_res:.4e}  MeV⁻¹")
    print(f"  fractional difference: {(mean_res - inv_amu) / inv_amu * 100:.3f} %")
    print()
    print("Interpretation (Atomic_System_QLF_Closures.md §7.2):")
    print("  R_X ≈ E_Planck / (A · m_amu).  Deviations from R ∝ 1/A are the")
    print("  per-nucleon binding-energy (mass-defect) variation.  Magic-number")
    print("  enhancements at A = 4, 16, 40, 56, 90, 140, 208 are the same shell-")
    print("  model features seen in BE/A.  Under VacuumEnergy.md §6.1 these are")
    print("  vacuum-resonance peaks: depths the vacuum's spectral structure most")
    print("  strongly supports as stable nuclear ZFA closures.  ⁵⁶Fe maximum is")
    print("  the cosmological terminator of stellar nucleosynthesis.")
    print()
    # Locate BE/A peak
    BEA_arr = np.array([a[3] for a in ATOMS])
    idx_peak = int(np.argmax(BEA_arr))
    print(f"  BE/A maximum: {ATOMS[idx_peak][1]} at BE/A = {ATOMS[idx_peak][3]:.3f} MeV.")
    print(f"               R = {R_arr[idx_peak]:.4e};  A = {ATOMS[idx_peak][0]}.")
    print()
    print("  This script is a structural panel, not a fit.  First-principles QLF")
    print("  derivation of the magic-number sequence from vacuum-coupling topology")
    print("  is flagged as open work in §10.")

if __name__ == "__main__":
    main()
