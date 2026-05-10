/-
  SpacetimeDynamics.lean
  Project: Quantum Logical Framework
  Author: Jim Whitescarver

  Description:
  A formalization of Spacetime as a Quantum Logical Framework.
  This file establishes the equivalence between logical "Forms" and
  the Pauli Matrix basis, proving the existence of Boundary Interaction
  via the non-commutative nature of half-spin operators.
-/

import Mathlib.Data.Complex.Basic
import Mathlib.Data.Matrix.Basic
import Mathlib.Data.Real.Basic
import Mathlib.LinearAlgebra.Matrix.Notation
import Mathlib.LinearAlgebra.Matrix.Determinant
import Mathlib.Tactic

open Matrix

-- 1. BASE DEFINITIONS: THE PAULI BASIS

def σ₀ : Matrix (Fin 2) (Fin 2) ℂ := !![1, 0; 0, 1]
def σ₁ : Matrix (Fin 2) (Fin 2) ℂ := !![0, 1; 1, 0]
def σ₂ : Matrix (Fin 2) (Fin 2) ℂ := !![0, -Complex.I; Complex.I, 0]
def σ₃ : Matrix (Fin 2) (Fin 2) ℂ := !![1, 0; 0, -1]

/-- A "Form" (or Querk) in the 4-D Spacetime Logical Space. -/
structure Form where
  t : ℝ
  x : ℝ
  y : ℝ
  z : ℝ

namespace Form

/-- The mapping from logical form to Pauli-basis matrix. -/
def toMatrix (f : Form) : Matrix (Fin 2) (Fin 2) ℂ :=
  (f.t : ℂ) • σ₀ + (f.x : ℂ) • σ₁ + (f.y : ℂ) • σ₂ + (f.z : ℂ) • σ₃

/-- The "action" is the commutator of two forms. -/
def action (A B : Form) : Matrix (Fin 2) (Fin 2) ℂ :=
  (A.toMatrix * B.toMatrix) - (B.toMatrix * A.toMatrix)

/-- Zero Free Action (ZFA): logical/physical equilibrium. -/
def ZeroFreeAction (A B : Form) : Prop :=
  action A B = 0

--------------------------------------------------------------------------------
-- FORMAL THEOREMS
--------------------------------------------------------------------------------

/--
  Self-action is null.
  This is the basis of equal-and-opposite action within a single distinction.
-/
theorem equal_and_opposite_self (A : Form) : ZeroFreeAction A A := by
  unfold ZeroFreeAction action
  simp [sub_self]

/--
  `toMatrix` is Hermitian for every real-valued form.
-/
theorem toMatrix_adjoint (f : Form) : f.toMatrix.adjoint = f.toMatrix := by
  ext i j
  fin_cases i <;> fin_cases j <;> simp [toMatrix, σ₀, σ₁, σ₂, σ₃]

/--
  The determinant is the Minkowski metric.
-/
theorem determinant_is_minkowski (f : Form) :
    (f.toMatrix).det = (f.t ^ 2 - f.x ^ 2 - f.y ^ 2 - f.z ^ 2 : ℂ) := by
  unfold toMatrix σ₀ σ₁ σ₂ σ₃
  simp [Matrix.det_fin_two, Complex.I_sq]
  ring

/--
  Boundary interaction exists.
  By demonstrating that the commutator of x-distinction and y-distinction
  is non-zero, we prove that interaction is required by the logic.
-/
theorem boundary_interaction_exists : ∃ (A B : Form), ¬ ZeroFreeAction A B := by
  let A : Form := ⟨0, 1, 0, 0⟩
  let B : Form := ⟨0, 0, 1, 0⟩
  refine ⟨A, B, ?_⟩
  intro h
  have h00 : (action A B) 0 0 = 0 := by
    have := congrArg (fun M => M 0 0) h
    simpa [ZeroFreeAction] using this
  simp [action, toMatrix, A, B, σ₀, σ₁, σ₂, σ₃, Matrix.mul_fin_two] at h00
  have hneq : (Complex.I + Complex.I : ℂ) ≠ 0 := by
    have h2 : ((2 : ℂ) * Complex.I) ≠ 0 := by
      exact mul_ne_zero (by norm_num) Complex.I_ne_zero
    simpa [two_mul] using h2
  exact hneq h00

/--
  Half-spin network phase shift.
  A 2π rotation is represented here by `-σ₀`. Since `(-σ₀)^2 = σ₀`,
  conjugation by `-σ₀` returns the same operator, while left multiplication
  flips the sign.
-/
theorem half_spin_boundary_distinction (A : Form) (_hA : A.toMatrix ≠ 0) :
    let R_2π : Matrix (Fin 2) (Fin 2) ℂ := -σ₀
    (R_2π * A.toMatrix * R_2π) = A.toMatrix ∧
    (R_2π * A.toMatrix) = -A.toMatrix := by
  dsimp
  constructor
  · ext i j
    fin_cases i <;> fin_cases j <;> simp [σ₀, Matrix.mul_fin_two]
  · ext i j
    fin_cases i <;> fin_cases j <;> simp [σ₀, Matrix.mul_fin_two]

end Form
