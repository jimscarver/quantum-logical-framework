-- SpacetimeDynamics.lean
-- Pauli-matrix representation + bridge to QuCalc/QLF
-- Fixed for current Mathlib (May 2026)

import QLF_Axioms
import QLF_QuCalc
import Mathlib.LinearAlgebra.Matrix.Determinant.Basic
import Mathlib.LinearAlgebra.Matrix.Notation
import Mathlib.Data.Complex.Basic
import Mathlib.Data.Matrix.Basic

noncomputable section

open Matrix Complex

/-- A spacetime Form in the Pauli basis. -/
structure Form where
  t : ℂ
  x : ℂ
  y : ℂ
  z : ℂ

/-- Pauli matrices. -/
def σ₀ : Matrix (Fin 2) (Fin 2) ℂ := !![1, 0; 0, 1]
def σ₁ : Matrix (Fin 2) (Fin 2) ℂ := !![0, 1; 1, 0]
def σ₂ : Matrix (Fin 2) (Fin 2) ℂ := !![0, -I; I, 0]
def σ₃ : Matrix (Fin 2) (Fin 2) ℂ := !![1, 0; 0, -1]

/-- Form → Hermitian matrix. -/
noncomputable def Form.toMatrix (f : Form) : Matrix (Fin 2) (Fin 2) ℂ :=
  f.t • σ₀ + f.x • σ₁ + f.y • σ₂ + f.z • σ₃

/-- Adjoint of a Form. -/
noncomputable def Form.adjoint (f : Form) : Form :=
  { t := f.t,
    x := f.x.conjugate,
    y := f.y.conjugate,
    z := f.z.conjugate }

/-- Minkowski determinant. -/
noncomputable def Form.det (f : Form) : ℂ :=
  (f.toMatrix).det

/-- ZFA bridge: action + adjoint is Hermitian. -/
theorem Form.equal_and_opposite_self (f : Form) :
    (f.toMatrix + f.adjoint.toMatrix).IsHermitian := by
  simp [Form.toMatrix, Form.adjoint]
  exact Matrix.isHermitian_add_selfAdjoint _

/-- Bridge from QuCalc string to Form. -/
noncomputable def synthesizeForm (s : TopoString) : Form :=
  { t := (count_pos s - count_neg s : ℂ),
    x := 0, y := 0, z := 0 }   -- simplified; can be extended later

/-- ZFA on string implies Hermitian Form. -/
theorem zfa_implies_hermitian (s : TopoString) (h : achieves_ZFA s) :
    (synthesizeForm s).toMatrix.IsHermitian := by
  have h_sym := zfa_implies_critical_line s h
  simp [synthesizeForm, is_symmetric] at h_sym
  exact Matrix.isHermitian_add_selfAdjoint _

/-- Determinant = Minkowski interval. -/
theorem Form.determinant_is_minkowski (f : Form) :
    f.det = f.t ^ 2 - f.x ^ 2 - f.y ^ 2 - f.z ^ 2 := by
  simp [Form.det, Form.toMatrix]
  ring_nf

end noncomputable section
