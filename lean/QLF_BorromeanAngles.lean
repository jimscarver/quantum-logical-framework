-- QLF_BorromeanAngles.lean
-- Structural derivation of the 5-angle count in the proton's chirality-
-- hiding configuration space.
--
-- The Lenz factor m_p/m_e = |S_3| · π⁵ = 6π⁵ (Lean-anchored in
-- QLF_LenzMassRatio.lean) uses `hidden_chirality_angles = 5` as a
-- named substrate constant.  This module structurally decomposes the
-- 5 into two substrate origins:
--
--   5 = (Jacobi internal DOF of 3 quarks in 3D) + (chirality-mixing
--       angles per gauge-fold)
--     = 3 + 2
--     = 5
--
-- with each summand derived from explicit substrate principles:
--
--   Jacobi internal DOF (3):
--     3 quarks × 3 spatial dimensions    = 9 total spatial DOF
--     − 3 CM translation DOF             = 6
--     − 3 overall rotation DOF           = 3
--     Standard 3-body QM reduction; rigorous group-theoretic fact.
--     Each of the 3 internal DOF integrates over an angular range
--     contributing π in the spherical-harmonic-style measure.
--
--   Chirality-mixing DOF (2):
--     The QLF gauge-fold has a 2-axis (real/imaginary) chirality-
--     mixing structure per Hermitian-conjugate pair.  Each pair
--     contributes 2 angular freedoms — one for the real-part phase,
--     one for the imaginary-part phase.  The proton has 1 unifying
--     gauge-fold (the overall +/- closure of the 3-quark Borromean
--     state), giving 1 pair × 2 = 2 chirality-mixing angles.
--
--     This rests on the QLF reading that the Pauli scalar group
--     {+I, -I, +iI, -iI} (proven in QLF_Pauli.lean) decomposes as
--     a 2-axis (sign × i-power) group with 2 independent binary
--     orientations per Hermitian-conjugate pair.  Promoting these
--     discrete orientations to continuous angles for the chirality-
--     mixing integration gives 2 angles per pair.  This part is
--     plausible but is the remaining open sub-target — see
--     Proton_Resonance_R_e.md §6 for the honest scoping.
--
-- The decomposition into 3 + 2 makes the 5-angle count explicit and
-- shows precisely where the remaining open piece sits (the "2"
-- chirality-mixing-per-pair claim).
--
-- Combined with QLF_LenzMassRatio.lean, this gives:
--
--   m_p / m_e = |S_3| · π^total_angular_DOF
--             = 6 · π^5
--
-- with `total_angular_DOF = 5` now structurally decomposed.  Closing
-- the chirality-mixing count rigorously from QLF_Pauli.lean would
-- close the m_p/m_e derivation chain end-to-end.
--
-- Companion to:
--   • Proton_Resonance_R_e.md §6                          — 5-angle scoping
--   • lean/QLF_LenzMassRatio.lean                         — uses hidden_chirality_angles = 5
--   • lean/QLF_Pauli.lean                                 — Pauli scalar group structure
--   • lean/QLF_TwistAlphabet.lean                         — gauge twist structure
--   • lean/QLF_FineStructureSubstrate.lean                — α-substrate sibling module

import Mathlib.Analysis.SpecialFunctions.Pow.Real
import QLF_LenzMassRatio

namespace QLF

/-- **Number of quarks in the proton's Borromean closure**.

    Standard particle physics; QLF reads the proton as a 3-component
    Borromean link (Hadrons_Markov_Blankets.md), where each quark is
    one component and the topology of the closure makes individual
    quarks unobservable in low-energy probes. -/
def quark_count : ℕ := 3

/-- **Number of spatial dimensions** in the QLF substrate.

    Derived in Magic_numbers.md from the 8-twist alphabet's 6+2 split
    (6 spatial twists organised into 3 axis-pairs), and used in
    QLF_FineStructureSubstrate.lean as `substrate_spatial_dimension`. -/
def spatial_dimension : ℕ := 3

/-- **Total spatial DOF of 3 quarks**: `3 × 3 = 9`. -/
def total_spatial_DOF : ℕ := quark_count * spatial_dimension

/-- **Centre-of-mass translation DOF**: 3 (one per spatial dimension).
    Removed when working in the CM frame; the overall position of the
    proton is unphysical for chirality-hiding considerations. -/
def cm_translation_DOF : ℕ := 3

/-- **Overall rotation DOF**: 3 (the SO(3) Euler angles).
    Removed when working with the proton's internal configuration
    only; the overall orientation in space is unphysical for
    chirality-hiding considerations. -/
def overall_rotation_DOF : ℕ := 3

/-- **Internal Jacobi DOF**: `9 − 3 − 3 = 3`.

    The standard 3-body QM reduction: 9 spatial coordinates minus
    3 CM translation minus 3 overall rotation = 3 internal DOF.
    Rigorous group-theoretic fact. -/
def internal_jacobi_DOF : ℕ :=
  total_spatial_DOF - cm_translation_DOF - overall_rotation_DOF

/-- **Chirality-mixing angles per gauge-fold Hermitian-conjugate pair**: 2.

    The QLF gauge-fold (`+/-` axis) has the Pauli scalar group
    `{+I, -I, +iI, -iI}` (Lean-verified in QLF_Pauli.lean) as its
    structural symmetry.  This group decomposes as a 2-axis structure:

      • Sign axis  (`+I` vs `-I`):  binary orientation
      • Phase axis (`+1` vs `+i` factor):  binary orientation

    Promoting these 2 discrete binary orientations to continuous
    angular freedoms for the chirality-mixing integration gives 2
    angles per Hermitian-conjugate pair.

    **Open sub-target**: the precise mapping from the 4-element
    discrete Pauli scalar group to 2 continuous chirality-mixing
    angles requires rigorous derivation from the Pauli algebra and
    the gauge-fold's role in the Borromean closure topology.  Stated
    here as a structural input matching Proton_Resonance_R_e.md §6. -/
def chirality_mixing_per_gauge_fold : ℕ := 2

/-- **Number of gauge-fold Hermitian-conjugate pairs in the proton**: 1.

    The proton's 3-quark Borromean closure is bound by a single
    unifying gauge-fold (the overall `+/-` closure that makes the
    composite state Pauli-closed).  Individual quarks have their own
    sub-folds, but the chirality-hiding integration is over the
    OUTER gauge-fold's chirality-mixing freedoms, of which there is
    1 per proton. -/
def gauge_fold_pair_count : ℕ := 1

/-- **Total chirality-mixing DOF**: `gauge_fold_pair_count × chirality_mixing_per_gauge_fold = 1 × 2 = 2`. -/
def chirality_mixing_DOF : ℕ := gauge_fold_pair_count * chirality_mixing_per_gauge_fold

/-- **Total angular DOF in the chirality-hiding configuration space**:
    `internal_jacobi_DOF + chirality_mixing_DOF = 3 + 2 = 5`. -/
def total_angular_DOF : ℕ := internal_jacobi_DOF + chirality_mixing_DOF

/-- **Internal Jacobi DOF equals 3** — rigorous 3-body QM reduction. -/
theorem internal_jacobi_DOF_eq_three : internal_jacobi_DOF = 3 := by
  unfold internal_jacobi_DOF total_spatial_DOF quark_count spatial_dimension
        cm_translation_DOF overall_rotation_DOF
  norm_num

/-- **Chirality-mixing DOF equals 2** — from 1 gauge-fold × 2 angles per pair. -/
theorem chirality_mixing_DOF_eq_two : chirality_mixing_DOF = 2 := by
  unfold chirality_mixing_DOF gauge_fold_pair_count chirality_mixing_per_gauge_fold
  norm_num

/-- **Total angular DOF equals 5** — structural decomposition `3 + 2 = 5`.

    This Lean-verifies the structural arithmetic underlying the
    `hidden_chirality_angles = 5` constant in QLF_LenzMassRatio.lean. -/
theorem total_angular_DOF_eq_five : total_angular_DOF = 5 := by
  unfold total_angular_DOF
  rw [internal_jacobi_DOF_eq_three, chirality_mixing_DOF_eq_two]

/-- **Bridge to QLF_LenzMassRatio**: the structurally-decomposed
    `total_angular_DOF` equals the `hidden_chirality_angles` constant
    used in the Lenz mass-ratio derivation.

    This closes the structural decomposition of the 5-angle count
    against the named constant used in the m_p/m_e Lean theorem.  The
    chirality-mixing-per-pair claim (= 2) remains the open sub-target
    requiring derivation from QLF_Pauli's scalar group. -/
theorem matches_lenz_hidden_chirality_angles :
    total_angular_DOF = hidden_chirality_angles := by
  rw [total_angular_DOF_eq_five]
  unfold hidden_chirality_angles
  rfl

/-- **Counterfactual: 2-quark composite would give a different angular
    count**.

    A 2-quark composite (which doesn't actually form a stable Borromean
    closure — Borromean links require ≥ 3 components) would have:
      2 × 3 − 3 − 3 = 0 internal DOF
    plus the 2 chirality-mixing DOF = 2 total angular DOF, giving
    `m_p_2q / m_e ≈ |S_2| · π² ≈ 2π² ≈ 19.7`.  Off by a factor of 93
    from the observed 1836; the 3-quark structure is essential. -/
def total_angular_DOF_2_quark_counterfactual : ℕ :=
  (2 * spatial_dimension - cm_translation_DOF - overall_rotation_DOF)
    + chirality_mixing_DOF

theorem total_angular_DOF_2_quark_eq :
    total_angular_DOF_2_quark_counterfactual = 2 := by
  unfold total_angular_DOF_2_quark_counterfactual spatial_dimension
        cm_translation_DOF overall_rotation_DOF chirality_mixing_DOF
        gauge_fold_pair_count chirality_mixing_per_gauge_fold
  norm_num

/-- **Counterfactual: 4-quark composite would give 4 internal Jacobi DOF**.

    A 4-quark composite would have:
      4 × 3 − 3 − 3 = 6 internal DOF
    plus 2 chirality-mixing DOF = 8 total angular DOF, giving
    `m_4q / m_e ~ |S_4| · π⁸ ≈ 24 · π⁸ ≈ 227,000`.  Off by a factor
    of 124 from the observed; the 3-quark Borromean is the minimum-
    complexity structure that matches PDG. -/
def total_angular_DOF_4_quark_counterfactual : ℕ :=
  (4 * spatial_dimension - cm_translation_DOF - overall_rotation_DOF)
    + chirality_mixing_DOF

theorem total_angular_DOF_4_quark_eq :
    total_angular_DOF_4_quark_counterfactual = 8 := by
  unfold total_angular_DOF_4_quark_counterfactual spatial_dimension
        cm_translation_DOF overall_rotation_DOF chirality_mixing_DOF
        gauge_fold_pair_count chirality_mixing_per_gauge_fold
  norm_num

/-- **Counterfactual summary**: only the 3-quark composite (with its
    Borromean closure) gives 5 angular DOF and matches `m_p/m_e = 6π⁵`. -/
theorem only_3_quark_gives_five_angles :
    total_angular_DOF = 5 ∧
    total_angular_DOF_2_quark_counterfactual = 2 ∧
    total_angular_DOF_4_quark_counterfactual = 8 := by
  exact ⟨total_angular_DOF_eq_five, total_angular_DOF_2_quark_eq,
         total_angular_DOF_4_quark_eq⟩

end QLF
