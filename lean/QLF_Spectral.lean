-- QLF_Spectral.lean
-- Spectral structure of QLF strings: projector operators, Hermitian structure,
-- and the Hilbert-Pólya bridge connecting symmetric QLF strings to the critical line.

import QLF_Axioms
import Mathlib.LinearAlgebra.Matrix.Hermitian
import Mathlib.Data.Complex.Basic

namespace QLF

open Matrix

-- ==========================================
-- PROJECTOR MATRICES
-- ==========================================

-- Rank-1 spectral projectors: pos → |+⟩⟨+|, neg → |−⟩⟨−|
noncomputable def phaseMatrix : LogicPhase → Matrix (Fin 2) (Fin 2) ℂ
  | LogicPhase.pos => !![1, 0; 0, 0]
  | LogicPhase.neg => !![0, 0; 0, 1]

-- Non-phase elements contribute zero to the spectral mode
noncomputable def elementMatrix : TopoElement → Matrix (Fin 2) (Fin 2) ℂ
  | TopoElement.phase p => phaseMatrix p
  | TopoElement.gauge   => 0

-- Spectral mode of a string = sum of projectors over all elements
noncomputable def toSpectralMode (s : TopoString) : Matrix (Fin 2) (Fin 2) ℂ :=
  (s.map elementMatrix).sum

-- ==========================================
-- HERMITIAN STRUCTURE
-- ==========================================

private lemma phaseMatrix_hermitian (p : LogicPhase) :
    (phaseMatrix p).IsHermitian := by
  unfold Matrix.IsHermitian
  cases p <;> apply Matrix.ext <;> intro i j <;> fin_cases i <;> fin_cases j <;>
  simp [Matrix.conjTranspose_apply, phaseMatrix,
        Matrix.cons_val_zero, Matrix.cons_val_one,
        Matrix.head_cons, Matrix.head_fin_const,
        Complex.star_def, Complex.conj_re, Complex.conj_im]

private lemma elementMatrix_hermitian (e : TopoElement) :
    (elementMatrix e).IsHermitian := by
  cases e with
  | gauge =>
    simp only [elementMatrix, Matrix.IsHermitian, Matrix.conjTranspose_zero]
  | phase p => exact phaseMatrix_hermitian p

-- All QLF strings (not just pure-phase) have a Hermitian spectral mode
theorem toSpectralMode_hermitian (s : TopoString) :
    (toSpectralMode s).IsHermitian := by
  induction s with
  | nil =>
    simp only [toSpectralMode, List.map_nil, List.sum_nil, Matrix.IsHermitian,
               Matrix.conjTranspose_zero]
  | cons head tail ih =>
    simp only [toSpectralMode, List.map_cons, List.sum_cons]
    exact (elementMatrix_hermitian head).add ih

-- ==========================================
-- DIAGONAL DECOMPOSITION (pure-phase strings)
-- ==========================================

-- For pure-phase strings, the spectral mode is a diagonal matrix with
-- count_pos on the (0,0) entry and count_neg on the (1,1) entry.
private lemma toSpectralMode_diag (s : TopoString)
    (hpure : ∀ e ∈ s, ∃ p, e = TopoElement.phase p) :
    toSpectralMode s =
      (count_pos s : ℂ) • !![1, 0; 0, 0] + (count_neg s : ℂ) • !![0, 0; 0, 1] := by
  induction s with
  | nil => simp [toSpectralMode, count_pos, count_neg]
  | cons head tail ih =>
    obtain ⟨p, rfl⟩ := hpure head (List.Mem.head _)
    have iht := ih (fun e he => hpure e (List.Mem.tail _ he))
    simp only [toSpectralMode, List.map_cons, List.sum_cons,
               elementMatrix, phaseMatrix, count_pos_cons, count_neg_cons,
               val_pos, val_neg]
    rw [show (List.map elementMatrix tail).sum = toSpectralMode tail from rfl, iht]
    cases p <;> push_cast <;>
    simp only [add_smul, one_smul, zero_smul, zero_add, add_zero] <;>
    abel

-- ==========================================
-- SCALAR IDENTITY THEOREM
-- ==========================================

-- Key geometric fact: equal pos/neg counts ⟹ spectral mode = c · I
-- This is the QLF spectral analog of sitting on the critical line.
theorem spectral_symmetric_eq_scalar_id (s : TopoString)
    (hpure : ∀ e ∈ s, ∃ p, e = TopoElement.phase p)
    (hsym : is_symmetric s) :
    ∃ c : ℂ, toSpectralMode s = c • (1 : Matrix (Fin 2) (Fin 2) ℂ) := by
  refine ⟨(count_pos s : ℂ), ?_⟩
  rw [toSpectralMode_diag s hpure]
  have heq : (count_neg s : ℂ) = (count_pos s : ℂ) := by exact_mod_cast hsym.symm
  rw [heq, ← smul_add]
  congr 1
  ext i j
  fin_cases i <;> fin_cases j <;>
  simp [Matrix.add_apply, Matrix.one_apply, phaseMatrix,
        Matrix.cons_val_zero, Matrix.cons_val_one,
        Matrix.head_cons, Matrix.head_fin_const]

-- ==========================================
-- SPECTRAL GAP
-- ==========================================

/-- The spectral gap: absolute imbalance between the two diagonal eigenvalues
    of `toSpectralMode`. For a pure-phase string these are `count_pos s` and
    `count_neg s`; the gap measures how far the string is from the critical line. -/
def spectral_gap (s : TopoString) : ℤ := |count_pos s - count_neg s|

/-- The spectral gap vanishes iff the string is ZFA-symmetric (on the critical line).
    Eigenvalue-level counterpart of `spectral_symmetric_eq_scalar_id`:
    scalar × I ↔ equal eigenvalues ↔ gap = 0 ↔ is_symmetric. -/
theorem spectral_gap_zero_iff_symmetric (s : TopoString) :
    spectral_gap s = 0 ↔ is_symmetric s := by
  simp [spectral_gap, abs_eq_zero, sub_eq_zero, is_symmetric]

end QLF
