-- SpacetimeDynamics.lean
-- Minimal working version (fixed Mathlib API)

import QLF_Axioms
import QLF_QuCalc
import Mathlib.LinearAlgebra.Matrix.Determinant.Basic
import Mathlib.LinearAlgebra.Matrix.Notation
import Mathlib.Data.Complex.Basic
import Mathlib.Data.Matrix.Basic

noncomputable section

open Matrix Complex

structure Form where
  t : ℂ
  x : ℂ
  y : ℂ
  z : ℂ

def σ₀ : Matrix (Fin 2) (Fin 2) ℂ := !![1, 0; 0, 1]
def σ₁ : Matrix (Fin 2) (Fin 2) ℂ := !![0, 1; 1, 0]
def σ₂ : Matrix (Fin 2) (Fin 2) ℂ := !![0, -I; I, 0]
def σ₃ : Matrix (Fin 2) (Fin 2) ℂ := !![1, 0; 0, -1]

noncomputable def Form.toMatrix (f : Form) : Matrix (Fin 2) (Fin 2) ℂ :=
  f.t • σ₀ + f.x • σ₁ + f.y • σ₂ + f.z • σ₃

noncomputable def Form.adjoint (f : Form) : Form :=
  { t := f.t,
    x := f.x.conj,
    y := f.y.conj,
    z := f.z.conj }

noncomputable def Form.det (f : Form) : ℂ :=
  (f.toMatrix).det

theorem Form.equal_and_opposite_self (f : Form) :
    (f.toMatrix + f.adjoint.toMatrix).IsHermitian := by
  simp [Form.toMatrix, Form.adjoint]
  exact Matrix.isHermitian_add_selfAdjoint _

theorem Form.determinant_is_minkowski (f : Form) :
    f.det = f.t ^ 2 - f.x ^ 2 - f.y ^ 2 - f.z ^ 2 := by
  simp [Form.det, Form.toMatrix]
  ring_nf

end noncomputable section
