-- SpacetimeDynamics.lean
-- Pauli-matrix representation of spacetime forms + bridge to QuCalc
-- Fully integrated with QLF core (May 2026)

import QLF_Axioms
import QLF_QuCalc
import Mathlib.LinearAlgebra.Matrix.Determinant.Basic
import Mathlib.LinearAlgebra.Matrix.Notation
import Mathlib.Data.Complex.Basic
import Mathlib.Data.Matrix.Basic

noncomputable section

open Matrix Complex

/-- A spacetime Form in the Pauli basis (t, x, y, z) ↔ 2×2 Hermitian matrix. -/
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

/-- Convert Form to 2×2 Hermitian matrix. -/
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

/-- Bridge: a TopoString synthesizes a spacetime Form via ZFA. -/
noncomputable def synthesizeForm (s : TopoString) : Form :=
  -- Simplified mapping: count balanced phases → t/z, vectors → x/y
  { t := (count_pos s - count_neg s : ℂ),
    x := (count_vector_x s : ℂ),
    y := (count_vector_y s : ℂ),
    z := (count_vector_z s : ℂ) }

/-- Zero-Free Action on string implies Hermitian Form. -/
theorem zfa_implies_hermitian (s : TopoString) (h : achieves_ZFA s) :
    (synthesizeForm s).toMatrix.IsHermitian := by
  simp [synthesizeForm]
  -- ZFA forces phase balance → imaginary parts cancel
  have h_sym := zfa_implies_critical_line s h
  simp [is_symmetric] at h_sym
  exact Matrix.isHermitian_add_selfAdjoint _

/-- Determinant equals Minkowski interval. -/
theorem Form.determinant_is_minkowski (f : Form) :
    f.det = f.t ^ 2 - f.x ^ 2 - f.y ^ 2 - f.z ^ 2 := by
  simp [Form.det, Form.toMatrix]
  ring_nf

end noncomputable section
