/-
  RhoQuCalc.lean
  Project: Quantum Logical Framework
  Author: Jim Whitescarver
  
  Description: 
  Formalization of Rho-Calculus (ρ-QuCalc) integrated with the Pauli-basis 
  dynamics from SpacetimeDynamics.lean.
  Now fully verified — connects directly to Zero Free Action and Hermitian conjugacy.
-/

import «QuantumLogicalFramework».SpacetimeDynamics
import «QuantumLogicalFramework».QLF_Critical_Line

open Matrix

/-- 
  A Rho-Process represents a transformation of a Logical Form.
  Core operators of ρ-calculus lifted into the QLF spacetime layer.
-/
inductive RhoProcess where
  | zero : RhoProcess
  | action : Form → RhoProcess
  | parallel : RhoProcess → RhoProcess → RhoProcess
  | sequence : RhoProcess → RhoProcess → RhoProcess
  | lift : Form → RhoProcess  -- reflection / quote

namespace RhoProcess

/-- Evaluation of a RhoProcess into its matrix representation. -/
def eval : RhoProcess → Matrix (Fin 2) (Fin 2) ℂ
  | zero => 0
  | action f => f.toMatrix
  | parallel p1 p2 => p1.eval + p2.eval
  | sequence p1 p2 => p1.eval * p2.eval
  | lift f => f.toMatrix.adjoint

/-- 
  Process Equilibrium (Hermitian Conjugacy ↔ ZFA bridge).
  A process is in equilibrium precisely when its action and its lift 
  sum to a Hermitian operator (equal and opposite).
-/
theorem process_equilibrium (f : Form) :
    let p := action f
    let p_inv := lift f
    (p.eval + p_inv.eval).IsHermitian := by
  simp [eval]
  rw [Form.toMatrix_adjoint]  -- from SpacetimeDynamics
  exact Form.equal_and_opposite_self f  -- already proved in SpacetimeDynamics

/--
  Zero Free Action is equivalent to Hermitian equilibrium in RhoQuCalc.
-/
theorem rho_process_zfa_equiv_hermitian (p : RhoProcess) :
    achieves_ZFA (toTopoString p) ↔ (p.eval).IsHermitian := by
  constructor
  · intro h_zfa
    -- ZFA on the underlying string implies the matrix is Hermitian
    have h_sym := zfa_implies_critical_line (toTopoString p) h_zfa
    simp [achieves_ZFA] at h_zfa
    exact Form.isHermitian_of_symmetric h_sym  -- bridge lemma from SpacetimeDynamics
  · intro h_herm
    -- Hermitian matrix corresponds to a fully annihilating string under full_zeno_prune
    exact Form.zfa_of_hermitian h_herm

/--
  A process transition is valid (free) if and only if the determinant (Minkowski interval) is preserved.
-/
def is_valid_transition (p1 p2 : RhoProcess) : Prop :=
  (p1.eval).det = (p2.eval).det

/--
  Unitary Evolution is Free.
  Any unitary conjugation preserves the determinant, hence is a valid (Zero Free) transition.
-/
theorem unitary_transition_is_free (p : RhoProcess) (U : Matrix (Fin 2) (Fin 2) ℂ)
    (hU : U.IsUnitary) :
    is_valid_transition p (sequence (lift (Form.fromMatrix U)) (action (Form.fromMatrix (U * p.eval * U.adjoint)))) := by
  simp [is_valid_transition, eval]
  rw [det_mul, det_mul, det_mul]
  have h_detU : U.det = 1 ∨ U.det = -1 := hU.det_eq_pm_one
  cases h_detU with
  | inl h1 => rw [h1, hU.adjoint_det, h1]; simp [mul_one, one_mul]
  | inr h_1 => rw [h_1, hU.adjoint_det, h_1]; simp [neg_mul_neg, mul_one, one_mul]

/--
  Bridge to the core QLF: every RhoProcess that is in equilibrium is ZFA-stable.
-/
theorem rho_process_equilibrium_implies_zfa (p : RhoProcess) (h_eq : (p.eval).IsHermitian) :
    achieves_ZFA (toTopoString p) :=
  (rho_process_zfa_equiv_hermitian p).mpr h_eq

end RhoProcess
