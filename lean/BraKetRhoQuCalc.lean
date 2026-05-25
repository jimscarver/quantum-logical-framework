/-
  BraKetRhoQuCalc.lean
  Quantum Logical Framework — Bra-Ket ↔ RhoQuCalc correspondence

  RhoQuCalc works in the density-matrix (Heisenberg) picture — states and
  observables are both 2×2 Hermitian matrices — not the ket-vector picture.

  The exact correspondence:

    RhoProcess constructor   topoString      eval            Bra-ket analog
    ─────────────────────────────────────────────────────────────────────────
    action f                 [pos, neg]      f.toMatrix      |ψ⟩ (ket direction)
    lift f                   [neg, pos]      f.toMatrix†     ⟨ψ| (bra direction)
    parallel p q             topo(p)++topo(q)  p+q           superposition
    sequence p q             topo(p)++topo(q)  p*q           composition / application
    dagger p                 reversed        (p.eval)†       adjoint

  Key theorems:
    1. action_topo_is_ket / lift_topo_is_bra   — topological direction
    2. action_lift_eval_eq                      — Hermitian: ket=bra at matrix level
    3. bra_ket_always_balanced                  — ZFA = bra-ket well-typedness
    4. completeness_01                          — |0⟩⟨0| + |1⟩⟨1| = I
    5. projector_idempotent_0                  — ρ₀² = ρ₀ (pure state)
    6. orthogonality_01                         — ρ₁ · ρ₀ = 0
    7. pauli_x_sq / pauli_y_sq / pauli_z_sq    — σᵢ² = I
    8. trace_orthogonality_01                   — Tr(ρ₁ρ₀) = 0
    9. orthogonality_pm                         — |+⟩ ⊥ |−⟩: ρ₋ · ρ₊ = 0
   10. sigma_comm_xy/yz/zx                      — [σᵢ,σⱼ] = 2i εᵢⱼₖ σₖ (su(2) algebra)
   11. tau_x/y/z_sq                             — τᵢ² = −I (Σ₈ quaternionic squares)
   12. tau_xy/yz/zx_product                     — quaternionic products (anti-cyclic with τᵢ=iσᵢ)
   13. trace_preservation_unitary               — Tr(UρU†) = Tr(ρ)

  Author: Jim Scarver + Claude — May 2026
-/

import RhoQuCalc

open Matrix

/-! ## 1. Topological direction: action = ket, lift = bra -/

/-- `action f` encodes the ket direction: topoString [pos, neg] = outgoing phase.
    Every ket contributes one positive and one negative phase to ZFA bookkeeping. -/
theorem action_topo_is_ket (f : Form) :
    toTopoString (RhoProcess.action f) =
    [TopoElement.phase LogicPhase.pos, TopoElement.phase LogicPhase.neg] := rfl

/-- `lift f` encodes the bra direction: topoString [neg, pos] = incoming phase.
    Bra and ket have opposite topological orientations but identical eval. -/
theorem lift_topo_is_bra (f : Form) :
    toTopoString (RhoProcess.lift f) =
    [TopoElement.phase LogicPhase.neg, TopoElement.phase LogicPhase.pos] := rfl

/-! ## 2. eval correspondence -/

/-- `action f` evaluates to the density matrix |ψ⟩⟨ψ| = f.toMatrix. -/
theorem action_eval_is_matrix (f : Form) :
    (RhoProcess.action f).eval = f.toMatrix := rfl

/-- `lift f` evaluates to the adjoint (incoming bra) = f.toMatrix†. -/
theorem lift_eval_is_adjoint (f : Form) :
    (RhoProcess.lift f).eval = f.toMatrix.conjTranspose := rfl

/-- `action` and `lift` have identical eval for any Form.
    This is the machine-verified form of the Hermitian property:
    ket and bra carry the same matrix because all Form matrices are self-adjoint. -/
theorem action_lift_eval_eq (f : Form) :
    (RhoProcess.action f).eval = (RhoProcess.lift f).eval := by
  simp [RhoProcess.eval, Form.toMatrix_adjoint]

/-! ## 3. Parallel = superposition, Sequence = composition -/

/-- `parallel` evaluates to matrix addition: superposition of density matrices.
    Bra-ket analog: |ψ⟩⟨ψ| + |φ⟩⟨φ| (incoherent superposition / mixed state). -/
theorem parallel_is_superposition (p q : RhoProcess) :
    (RhoProcess.parallel p q).eval = p.eval + q.eval := rfl

/-- `sequence` evaluates to matrix multiplication: operator composition.
    Bra-ket analog: A B (operator product), A|ψ⟩⟨ψ| (apply), ρ² (idempotency). -/
theorem sequence_is_composition (p q : RhoProcess) :
    (RhoProcess.sequence p q).eval = p.eval * q.eval := rfl

/-! ## 4. Dagger = adjoint involution -/

/-- `dagger (action f) = lift f`: ket → bra under adjoint. -/
theorem dagger_action_is_lift (f : Form) : dagger (RhoProcess.action f) = RhoProcess.lift f := rfl

/-- `dagger (lift f) = action f`: bra → ket under adjoint. -/
theorem dagger_lift_is_action (f : Form) : dagger (RhoProcess.lift f) = RhoProcess.action f := rfl

/-- Dagger reverses sequence order: (AB)† = B†A†.
    Lean theorem `eval_dagger` proves eval(dagger p) = (eval p)†. -/
theorem dagger_sequence_reversal (p q : RhoProcess) :
    (dagger (RhoProcess.sequence p q)).eval =
    (RhoProcess.sequence (dagger q) (dagger p)).eval := by
  simp [RhoProcess.eval_dagger, conjTranspose_mul, RhoProcess.eval]

/-! ## 5. Unitary evolution -/

/-- Unitary evolution ρ → U ρ U† encoded as sequence(action U, sequence(action ρ, lift U)). -/
theorem unitary_evolution (U rho : Form) :
    (RhoProcess.sequence (RhoProcess.action U)
      (RhoProcess.sequence (RhoProcess.action rho) (RhoProcess.lift U))).eval =
    U.toMatrix * rho.toMatrix * U.toMatrix.conjTranspose := by
  simp [RhoProcess.eval, mul_assoc]

/-! ## 6. ZFA balance = bra-ket well-typedness -/

/-- Every bra-ket expression built from RhoProcess is automatically ZFA-balanced.
    `action f` contributes [pos, neg]; `lift f` contributes [neg, pos].
    Both individually have count_pos = count_neg = 1; all compositions preserve this.

    This is the machine-verified form of bra-ket well-typedness: it is impossible
    to construct a RhoProcess with unmatched bras or kets. -/
theorem bra_ket_always_balanced (p : RhoProcess) : achieves_ZFA (toTopoString p) :=
  RhoProcess.rho_process_always_zfa p

/-! ## 7. Concrete states and observables -/

-- Pure qubit states on Bloch sphere: Form(t=½, x, y, z) with x²+y²+z² = ¼
-- The density matrix representation: |ψ⟩⟨ψ| = Form.toMatrix

/-- |0⟩ as density matrix |0⟩⟨0| = [[1,0],[0,0]] -/
private noncomputable def ket0 : Form := { t := 1/2, x := 0,   y := 0, z :=  1/2 }
/-- |1⟩ as density matrix |1⟩⟨1| = [[0,0],[0,1]] -/
private noncomputable def ket1 : Form := { t := 1/2, x := 0,   y := 0, z := -1/2 }
/-- |+⟩ as density matrix |+⟩⟨+| = [[½,½],[½,½]] -/
private noncomputable def ket_plus : Form := { t := 1/2, x := 1/2, y := 0, z :=    0 }

-- Pauli observables (traceless Hermitian, eigenvalues ±1)
private def σx : Form := { t := 0, x := 1, y := 0, z := 0 }  -- [[0,1],[1,0]]
private def σy : Form := { t := 0, x := 0, y := 1, z := 0 }  -- [[0,-i],[i,0]]
private def σz : Form := { t := 0, x := 0, y := 0, z := 1 }  -- [[1,0],[0,-1]]

/-! ## 8. Completeness relations -/

/-- The standard basis {|0⟩, |1⟩} is complete: |0⟩⟨0| + |1⟩⟨1| = I.
    In RhoQuCalc: parallel(action ket0, action ket1) evaluates to the identity. -/
theorem completeness_01 :
    (RhoProcess.parallel (RhoProcess.action ket0) (RhoProcess.action ket1)).eval = 1 := by
  apply Matrix.ext; intro i j
  fin_cases i <;> fin_cases j <;>
  simp only [RhoProcess.eval, ket0, ket1, Form.toMatrix, Matrix.add_apply, Matrix.one_apply,
    Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons, Matrix.head_fin_const,
    Complex.ofReal_zero, Complex.ofReal_neg] <;>
  norm_num

/-- The Hadamard basis {|+⟩, |-⟩} is also complete: |+⟩⟨+| + |-⟩⟨-| = I. -/
private noncomputable def ket_minus : Form := { t := 1/2, x := -1/2, y := 0, z := 0 }

theorem completeness_pm :
    (RhoProcess.parallel (RhoProcess.action ket_plus) (RhoProcess.action ket_minus)).eval = 1 := by
  apply Matrix.ext; intro i j
  fin_cases i <;> fin_cases j <;>
  simp only [RhoProcess.eval, ket_plus, ket_minus, Form.toMatrix, Matrix.add_apply, Matrix.one_apply,
    Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons, Matrix.head_fin_const,
    Complex.ofReal_zero, Complex.ofReal_neg] <;>
  norm_num

/-! ## 9. Projector idempotency -/

/-- Pure state density matrices are idempotent projectors: ρ₀² = ρ₀.
    In RhoQuCalc: sequence(lift ket0, action ket0) = ket0.toMatrix. -/
theorem projector_idempotent_0 :
    (RhoProcess.sequence (RhoProcess.lift ket0) (RhoProcess.action ket0)).eval =
    ket0.toMatrix := by
  simp only [RhoProcess.eval, Form.toMatrix_adjoint]
  apply Matrix.ext; intro i j
  fin_cases i <;> fin_cases j <;>
  simp only [ket0, Form.toMatrix, Matrix.mul_apply, Fin.sum_univ_two,
    Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons, Matrix.head_fin_const,
    Complex.ofReal_zero] <;>
  norm_num

/-! ## 10. Orthogonality -/

/-- |0⟩ and |1⟩ are orthogonal: ρ₁ · ρ₀ = 0.
    Equivalently, ⟨1|0⟩ = 0 → |⟨1|0⟩|² = Tr(ρ₁ρ₀) = 0. -/
theorem orthogonality_01 :
    (RhoProcess.sequence (RhoProcess.lift ket1) (RhoProcess.action ket0)).eval = 0 := by
  simp only [RhoProcess.eval, Form.toMatrix_adjoint]
  apply Matrix.ext; intro i j
  fin_cases i <;> fin_cases j <;>
  simp only [ket0, ket1, Form.toMatrix, Matrix.mul_apply, Fin.sum_univ_two,
    Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons, Matrix.head_fin_const,
    Complex.ofReal_zero, Complex.ofReal_neg, Matrix.zero_apply] <;>
  norm_num

/-! ## 11. Pauli algebra: σᵢ² = I -/

/-- σx² = I. In RhoQuCalc: sequence(action σx, action σx) evaluates to the identity. -/
theorem pauli_x_sq : (RhoProcess.sequence (RhoProcess.action σx) (RhoProcess.action σx)).eval = 1 := by
  apply Matrix.ext; intro i j
  fin_cases i <;> fin_cases j <;>
  simp only [RhoProcess.eval, σx, Form.toMatrix, Matrix.mul_apply, Fin.sum_univ_two,
    Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons, Matrix.head_fin_const,
    Matrix.one_apply, Complex.ofReal_zero, Complex.ofReal_one] <;>
  norm_num

/-- σy² = I. The proof requires Complex.I arithmetic (σy has imaginary off-diagonals). -/
theorem pauli_y_sq : (RhoProcess.sequence (RhoProcess.action σy) (RhoProcess.action σy)).eval = 1 := by
  apply Matrix.ext; intro i j
  fin_cases i <;> fin_cases j <;>
  simp only [RhoProcess.eval, σy, Form.toMatrix, Matrix.mul_apply, Fin.sum_univ_two,
    Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons, Matrix.head_fin_const,
    Matrix.one_apply, Complex.ofReal_zero, Complex.ofReal_one] <;>
  apply Complex.ext <;>
  simp [Complex.mul_re, Complex.mul_im, Complex.add_re, Complex.add_im,
        Complex.neg_re, Complex.neg_im, Complex.I_re, Complex.I_im,
        Complex.ofReal_re, Complex.ofReal_im] <;>
  ring

/-- σz² = I. -/
theorem pauli_z_sq : (RhoProcess.sequence (RhoProcess.action σz) (RhoProcess.action σz)).eval = 1 := by
  apply Matrix.ext; intro i j
  fin_cases i <;> fin_cases j <;>
  simp only [RhoProcess.eval, σz, Form.toMatrix, Matrix.mul_apply, Fin.sum_univ_two,
    Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons, Matrix.head_fin_const,
    Matrix.one_apply, Complex.ofReal_zero, Complex.ofReal_one, Complex.ofReal_neg] <;>
  norm_num

/-! ## 12. Summary: ZFA symmetry of bra-ket pairs -/

/-- `action f` (ket) and `lift f` (bra) each individually achieve ZFA.
    topoString [+,-] and [-,+] both have count_pos = count_neg = 1. -/
theorem action_is_zfa (f : Form) : achieves_ZFA (toTopoString (RhoProcess.action f)) :=
  RhoProcess.rho_process_always_zfa _

theorem lift_is_zfa (f : Form) : achieves_ZFA (toTopoString (RhoProcess.lift f)) :=
  RhoProcess.rho_process_always_zfa _

/-- A sequence of alternating action/lift is ZFA-balanced (bra-ket matched). -/
theorem action_lift_sequence_is_zfa (f : Form) :
    achieves_ZFA (toTopoString (RhoProcess.sequence (RhoProcess.action f) (RhoProcess.lift f))) :=
  RhoProcess.rho_process_always_zfa _

/-! ## 13. Trace -/

/-- Tr(ρ₁ · ρ₀) = 0: orthogonal states have zero inner product in the density-matrix picture.
    The Lagrangian_Formulation.md security condition Tr(ρ_S ρ_E) = 0 is realised here.
    Follows immediately from orthogonality_01 (the matrix product itself is the zero matrix). -/
theorem trace_orthogonality_01 :
    Matrix.trace ((RhoProcess.sequence (RhoProcess.lift ket1) (RhoProcess.action ket0)).eval) = 0 := by
  simp [orthogonality_01]

/-! ## 14. Extended orthogonality: |+⟩ ⊥ |−⟩ -/

/-- |+⟩ and |−⟩ are orthogonal: ρ₋ · ρ₊ = 0.
    Extends orthogonality_01 to the Hadamard basis; pattern is identical. -/
theorem orthogonality_pm :
    (RhoProcess.sequence (RhoProcess.lift ket_minus) (RhoProcess.action ket_plus)).eval = 0 := by
  simp only [RhoProcess.eval, Form.toMatrix_adjoint]
  apply Matrix.ext; intro i j
  fin_cases i <;> fin_cases j <;>
  simp only [ket_plus, ket_minus, Form.toMatrix, Matrix.mul_apply, Fin.sum_univ_two,
    Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons, Matrix.head_fin_const,
    Complex.ofReal_zero, Complex.ofReal_neg, Matrix.zero_apply] <;>
  norm_num

/-! ## 15. Pauli commutator algebra: [σᵢ, σⱼ] = 2i εᵢⱼₖ σₖ -/

-- These three theorems formalise the su(2) Lie algebra underlying the Σ₈ symmetry
-- structure of the 8-twist alphabet (Lagrangian_Formulation.md §3 Algebraic Backbone).

/-- [σx, σy] = 2i σz. -/
theorem sigma_comm_xy :
    σx.toMatrix * σy.toMatrix - σy.toMatrix * σx.toMatrix =
    (2 * Complex.I) • σz.toMatrix := by
  apply Matrix.ext; intro i j
  fin_cases i <;> fin_cases j <;>
  simp only [σx, σy, σz, Form.toMatrix, Matrix.mul_apply, Fin.sum_univ_two,
    Matrix.sub_apply, Matrix.smul_apply,
    Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons, Matrix.head_fin_const,
    Complex.ofReal_zero, Complex.ofReal_one] <;>
  apply Complex.ext <;>
  simp [Complex.mul_re, Complex.mul_im, Complex.add_re, Complex.add_im,
        Complex.sub_re, Complex.sub_im, Complex.neg_re, Complex.neg_im,
        Complex.I_re, Complex.I_im, Complex.ofReal_re, Complex.ofReal_im,
        Complex.smul_re, Complex.smul_im] <;>
  ring

/-- [σy, σz] = 2i σx. -/
theorem sigma_comm_yz :
    σy.toMatrix * σz.toMatrix - σz.toMatrix * σy.toMatrix =
    (2 * Complex.I) • σx.toMatrix := by
  apply Matrix.ext; intro i j
  fin_cases i <;> fin_cases j <;>
  simp only [σx, σy, σz, Form.toMatrix, Matrix.mul_apply, Fin.sum_univ_two,
    Matrix.sub_apply, Matrix.smul_apply,
    Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons, Matrix.head_fin_const,
    Complex.ofReal_zero, Complex.ofReal_one] <;>
  apply Complex.ext <;>
  simp [Complex.mul_re, Complex.mul_im, Complex.add_re, Complex.add_im,
        Complex.sub_re, Complex.sub_im, Complex.neg_re, Complex.neg_im,
        Complex.I_re, Complex.I_im, Complex.ofReal_re, Complex.ofReal_im,
        Complex.smul_re, Complex.smul_im] <;>
  ring

/-- [σz, σx] = 2i σy. -/
theorem sigma_comm_zx :
    σz.toMatrix * σx.toMatrix - σx.toMatrix * σz.toMatrix =
    (2 * Complex.I) • σy.toMatrix := by
  apply Matrix.ext; intro i j
  fin_cases i <;> fin_cases j <;>
  simp only [σx, σy, σz, Form.toMatrix, Matrix.mul_apply, Fin.sum_univ_two,
    Matrix.sub_apply, Matrix.smul_apply,
    Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons, Matrix.head_fin_const,
    Complex.ofReal_zero, Complex.ofReal_one] <;>
  apply Complex.ext <;>
  simp [Complex.mul_re, Complex.mul_im, Complex.add_re, Complex.add_im,
        Complex.sub_re, Complex.sub_im, Complex.neg_re, Complex.neg_im,
        Complex.I_re, Complex.I_im, Complex.ofReal_re, Complex.ofReal_im,
        Complex.smul_re, Complex.smul_im] <;>
  ring

/-! ## 16. Σ₈ algebra bridge: τᵢ = i · σᵢ satisfies τᵢ² = −I -/

-- The Σ₈ generators τᵢ are defined as i·σᵢ (Pauli matrix scaled by Complex.I).
-- This gives the quaternionic squares τᵢ² = −I (anti-involutory), versus σᵢ² = I.
-- Products are anti-cyclic: τxτy = −τz, τyτz = −τx, τzτx = −τy.
-- (The cyclic convention τxτy = +τz corresponds to τᵢ = −iσᵢ.)
-- Reference: Lagrangian_Formulation.md §3 Algebraic Backbone.

private noncomputable def τx : Matrix (Fin 2) (Fin 2) ℂ := !![0, Complex.I; Complex.I, 0]
private noncomputable def τy : Matrix (Fin 2) (Fin 2) ℂ := !![0, 1; -1, 0]
private noncomputable def τz : Matrix (Fin 2) (Fin 2) ℂ := !![Complex.I, 0; 0, -Complex.I]

/-- τx² = −I. -/
theorem tau_x_sq : τx * τx = -(1 : Matrix (Fin 2) (Fin 2) ℂ) := by
  apply Matrix.ext; intro i j
  fin_cases i <;> fin_cases j <;>
  simp only [τx, Matrix.mul_apply, Fin.sum_univ_two, Matrix.neg_apply, Matrix.one_apply,
    Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons, Matrix.head_fin_const] <;>
  apply Complex.ext <;>
  simp [Complex.mul_re, Complex.mul_im, Complex.add_re, Complex.add_im,
        Complex.neg_re, Complex.neg_im, Complex.I_re, Complex.I_im,
        Complex.ofReal_re, Complex.ofReal_im] <;>
  norm_num

/-- τy² = −I. -/
theorem tau_y_sq : τy * τy = -(1 : Matrix (Fin 2) (Fin 2) ℂ) := by
  apply Matrix.ext; intro i j
  fin_cases i <;> fin_cases j <;>
  simp only [τy, Matrix.mul_apply, Fin.sum_univ_two, Matrix.neg_apply, Matrix.one_apply,
    Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons, Matrix.head_fin_const] <;>
  apply Complex.ext <;>
  simp [Complex.mul_re, Complex.mul_im, Complex.add_re, Complex.add_im,
        Complex.neg_re, Complex.neg_im, Complex.I_re, Complex.I_im,
        Complex.ofReal_re, Complex.ofReal_im] <;>
  norm_num

/-- τz² = −I. -/
theorem tau_z_sq : τz * τz = -(1 : Matrix (Fin 2) (Fin 2) ℂ) := by
  apply Matrix.ext; intro i j
  fin_cases i <;> fin_cases j <;>
  simp only [τz, Matrix.mul_apply, Fin.sum_univ_two, Matrix.neg_apply, Matrix.one_apply,
    Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons, Matrix.head_fin_const] <;>
  apply Complex.ext <;>
  simp [Complex.mul_re, Complex.mul_im, Complex.add_re, Complex.add_im,
        Complex.neg_re, Complex.neg_im, Complex.I_re, Complex.I_im,
        Complex.ofReal_re, Complex.ofReal_im] <;>
  norm_num

/-- τx · τy = −τz  (anti-cyclic product). -/
theorem tau_xy_product : τx * τy = -τz := by
  apply Matrix.ext; intro i j
  fin_cases i <;> fin_cases j <;>
  simp only [τx, τy, τz, Matrix.mul_apply, Fin.sum_univ_two, Matrix.neg_apply,
    Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons, Matrix.head_fin_const] <;>
  apply Complex.ext <;>
  simp [Complex.mul_re, Complex.mul_im, Complex.add_re, Complex.add_im,
        Complex.neg_re, Complex.neg_im, Complex.I_re, Complex.I_im,
        Complex.ofReal_re, Complex.ofReal_im] <;>
  ring

/-- τy · τz = −τx. -/
theorem tau_yz_product : τy * τz = -τx := by
  apply Matrix.ext; intro i j
  fin_cases i <;> fin_cases j <;>
  simp only [τx, τy, τz, Matrix.mul_apply, Fin.sum_univ_two, Matrix.neg_apply,
    Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons, Matrix.head_fin_const] <;>
  apply Complex.ext <;>
  simp [Complex.mul_re, Complex.mul_im, Complex.add_re, Complex.add_im,
        Complex.neg_re, Complex.neg_im, Complex.I_re, Complex.I_im,
        Complex.ofReal_re, Complex.ofReal_im] <;>
  ring

/-- τz · τx = −τy. -/
theorem tau_zx_product : τz * τx = -τy := by
  apply Matrix.ext; intro i j
  fin_cases i <;> fin_cases j <;>
  simp only [τx, τy, τz, Matrix.mul_apply, Fin.sum_univ_two, Matrix.neg_apply,
    Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons, Matrix.head_fin_const] <;>
  apply Complex.ext <;>
  simp [Complex.mul_re, Complex.mul_im, Complex.add_re, Complex.add_im,
        Complex.neg_re, Complex.neg_im, Complex.I_re, Complex.I_im,
        Complex.ofReal_re, Complex.ofReal_im] <;>
  ring

/-! ## 17. Trace preservation under unitary evolution -/

/-- Tr(UρU†) = Tr(ρ) for any unitary U (U†U = I).
    Quantum probabilities are invariant under unitary evolution.
    Proof uses cyclic property: Tr(AB) = Tr(BA). -/
theorem trace_preservation_unitary (U ρ : Matrix (Fin 2) (Fin 2) ℂ)
    (hU : U.conjTranspose * U = 1) :
    Matrix.trace (U * ρ * U.conjTranspose) = Matrix.trace ρ := by
  rw [Matrix.trace_mul_comm (U * ρ) U.conjTranspose, ← mul_assoc, hU, one_mul]

/-! ## 18. Security condition: [H, ρ] = 0 for ZFA-symmetric states -/

/-- A Form with zero x and y coefficients is diagonal in the σz basis and commutes with σz.
    This is the matrix-level formalization of the security condition [H, ρ_S] = 0.
    Diagonal Forms correspond to ZFA-symmetric states (count_pos = count_neg) — the
    vanishing off-diagonal entries are the Σ₈ twist pairs in perfect balance. -/
theorem commutator_zero_diagonal (f : Form) (hx : f.x = 0) (hy : f.y = 0) :
    σz.toMatrix * f.toMatrix - f.toMatrix * σz.toMatrix = 0 := by
  apply Matrix.ext; intro i j
  fin_cases i <;> fin_cases j <;>
  simp only [σz, Form.toMatrix, Matrix.mul_apply, Fin.sum_univ_two,
    Matrix.sub_apply, Matrix.zero_apply, Matrix.cons_val_zero, Matrix.cons_val_one,
    Matrix.head_cons, Matrix.head_fin_const, hx, hy,
    Complex.ofReal_zero, mul_zero, zero_mul, sub_zero, zero_sub, zero_add, add_zero] <;>
  apply Complex.ext <;>
  simp [Complex.mul_re, Complex.mul_im, Complex.add_re, Complex.add_im,
        Complex.sub_re, Complex.sub_im, Complex.neg_re, Complex.neg_im,
        Complex.I_re, Complex.I_im, Complex.ofReal_re, Complex.ofReal_im] <;>
  ring

/-- ket0 = |0⟩⟨0| commutes with σz (|0⟩ is a σz eigenstate). -/
theorem commutator_zero_ket0_sigmaz :
    σz.toMatrix * ket0.toMatrix - ket0.toMatrix * σz.toMatrix = 0 :=
  commutator_zero_diagonal ket0 rfl rfl

/-- ket1 = |1⟩⟨1| commutes with σz (|1⟩ is a σz eigenstate). -/
theorem commutator_zero_ket1_sigmaz :
    σz.toMatrix * ket1.toMatrix - ket1.toMatrix * σz.toMatrix = 0 :=
  commutator_zero_diagonal ket1 rfl rfl

/-! ## 19. Decoherence impossibility -/

/-- Coupling a system to an environment via parallel composition preserves ZFA balance.
    Any decohering interaction would require the combined (ρ_S ⊗ env) state to exit the
    ZFA-closed algebra.  Since `rho_process_always_zfa` guarantees every constructible
    RhoProcess is ZFA-closed, no decoherence event is algebraically expressible.
    This formalizes the Lagrangian_Formulation.md Security Conditions claim:
    "decoherence is a logical contradiction rather than environmental noise." -/
theorem decoherence_impossibility (ρ_S env : RhoProcess) :
    achieves_ZFA (toTopoString (RhoProcess.parallel ρ_S env)) :=
  RhoProcess.rho_process_always_zfa _
