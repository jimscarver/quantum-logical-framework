-- SpacetimeDynamics.lean
-- Pauli-matrix representation of spacetime forms + Minkowski metric
-- Updated for current Mathlib (May 2026)

import QLF_Axioms
import Mathlib.LinearAlgebra.Matrix.Determinant.Basic
import Mathlib.LinearAlgebra.Matrix.Notation   -- correct import for !! notation
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

/-- The Pauli matrices. -/
def σ₀ : Matrix (Fin 2) (Fin 2) ℂ := !![1, 0; 0, 1]
def σ₁ : Matrix (Fin 2) (Fin 2) ℂ := !![0, 1; 1, 0]
def σ₂ : Matrix (Fin 2) (Fin 2) ℂ := !![0, -I; I, 0]
def σ₃ : Matrix (Fin 2) (Fin 2) ℂ := !![1, 0; 0, -1]

/-- Convert Form to 2×2 Hermitian matrix. -/
noncomputable def Form.toMatrix (f : Form) : Matrix (Fin 2) (Fin 2) ℂ :=
  f.t • σ₀ + f.x • σ₁ + f.y • σ₂ + f.z • σ₃

/-- Adjoint (Hermitian conjugate) of a Form. -/
noncomputable def Form.adjoint (f : Form) : Form :=
  { t := f.t,
    x := f.x.conj,
    y := f.y.conj,
    z := f.z.conj }

/-- Minkowski determinant. -/
noncomputable def Form.det (f : Form) : ℂ :=
  (f.toMatrix).det

/-- Zero-Free Action: action + adjoint is Hermitian. -/
theorem Form.equal_and_opposite_self (f : Form) :
    (f.toMatrix + f.adjoint.toMatrix).IsHermitian := by
  simp [Form.toMatrix, Form.adjoint]
  exact Matrix.isHermitian_add_adjoint _

/-- Determinant equals the Minkowski interval. -/
theorem Form.determinant_is_minkowski (f : Form) :
    f.det = f.t ^ 2 - f.x ^ 2 - f.y ^ 2 - f.z ^ 2 := by
  simp [Form.det, Form.toMatrix]
  ring_nf

end noncomputable section
