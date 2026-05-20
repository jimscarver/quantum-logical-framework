/-
  RhoQuCalc.lean
  Project: Quantum Logical Framework
  Author: Jim Scarver

  Formalization of Rho-Calculus (ρ-QuCalc) integrated with the Pauli-basis
  dynamics from SpacetimeDynamics.lean.
-/

import SpacetimeDynamics
import QLF_Critical_Line

open Matrix

instance (s : TopoString) : Decidable (achieves_ZFA s) := by
  unfold achieves_ZFA; exact inferInstance

/--
  A Rho-Process represents a transformation of a Logical Form.
  Core operators of ρ-calculus lifted into the QLF spacetime layer.
-/
inductive RhoProcess where
  | zero : RhoProcess
  | action : Form → RhoProcess
  | parallel : RhoProcess → RhoProcess → RhoProcess
  | sequence : RhoProcess → RhoProcess → RhoProcess
  | lift : Form → RhoProcess

/-- Convert a RhoProcess to a TopoString for ZFA analysis. -/
def toTopoString : RhoProcess → TopoString
  | .zero => []
  | .action _ => [TopoElement.phase LogicPhase.pos, TopoElement.phase LogicPhase.neg]
  | .parallel p q => toTopoString p ++ toTopoString q
  | .sequence p q => toTopoString p ++ toTopoString q
  | .lift _ => [TopoElement.phase LogicPhase.neg, TopoElement.phase LogicPhase.pos]

/-- Dagger involution: swaps action↔lift and reverses sequence order. -/
def dagger : RhoProcess → RhoProcess
  | .zero         => .zero
  | .action f     => .lift f
  | .lift f       => .action f
  | .parallel p q => .parallel (dagger p) (dagger q)
  | .sequence p q => .sequence (dagger q) (dagger p)

-- Helper infrastructure for toTopoString_always_zfa

private lemma achieves_ZFA_iff_empty (s : TopoString) :
    achieves_ZFA s ↔ full_zeno_prune s = [] := by
  unfold achieves_ZFA
  constructor
  · intro h
    by_contra hne
    obtain ⟨head, _tail, hcons⟩ := List.exists_cons_of_ne_nil hne
    rw [hcons] at h
    cases head <;> simp [is_gauge] at h
  · intro h; simp [h]

private lemma count_pos_append (s1 s2 : TopoString) :
    count_pos (s1 ++ s2) = count_pos s1 + count_pos s2 := by
  induction s1 with
  | nil => simp [count_pos]
  | cons head tail ih => simp only [List.cons_append, count_pos_cons]; omega

private lemma count_neg_append (s1 s2 : TopoString) :
    count_neg (s1 ++ s2) = count_neg s1 + count_neg s2 := by
  induction s1 with
  | nil => simp [count_neg]
  | cons head tail ih => simp only [List.cons_append, count_neg_cons]; omega

private lemma zeno_prune_length_le (s : TopoString) :
    (zeno_prune s).length ≤ s.length := by
  induction s using zeno_prune.induct
  · simp [zeno_prune]
  · next tail ih => simp [zeno_prune]; omega
  · next tail ih => simp [zeno_prune]; omega
  · next head tail ih => simp [zeno_prune]; omega

private lemma zeno_prune_preserves_pure_phase (s : TopoString)
    (hpure : ∀ e ∈ s, ∃ p, e = TopoElement.phase p) :
    ∀ e ∈ zeno_prune s, ∃ p, e = TopoElement.phase p := by
  induction s using zeno_prune.induct
  · simp [zeno_prune]
  · next tail ih =>
    intro e he
    simp only [zeno_prune] at he
    exact ih (fun e' he' => hpure e' (List.Mem.tail _ (List.Mem.tail _ he'))) e he
  · next tail ih =>
    intro e he
    simp only [zeno_prune] at he
    exact ih (fun e' he' => hpure e' (List.Mem.tail _ (List.Mem.tail _ he'))) e he
  · next head tail ih =>
    intro e he
    simp only [zeno_prune] at he
    rcases List.mem_cons.mp he with rfl | hmem
    · exact hpure e (List.Mem.head _)
    · exact ih (fun e' he' => hpure e' (List.Mem.tail _ he')) e hmem

private lemma zeno_preserves_symmetric (s : TopoString) (h : is_symmetric s) :
    is_symmetric (zeno_prune s) := by
  unfold is_symmetric at *
  have := single_prune_invariant s
  omega

private lemma zeno_prune_eq_self_of_no_reduce (s : TopoString)
    (hlen : (zeno_prune s).length = s.length) :
    zeno_prune s = s := by
  induction s using zeno_prune.induct
  · rfl
  · next tail ih =>
    simp only [zeno_prune, List.length_cons] at hlen
    have := zeno_prune_length_le tail; omega
  · next tail ih =>
    simp only [zeno_prune, List.length_cons] at hlen
    have := zeno_prune_length_le tail; omega
  · next head tail ih =>
    simp only [zeno_prune, List.length_cons] at hlen
    simp only [zeno_prune, ih (by omega)]

private lemma zeno_prune_fixed_implies_const (s : TopoString)
    (hpure : ∀ e ∈ s, ∃ p, e = TopoElement.phase p)
    (hfix : zeno_prune s = s) :
    ∃ p, ∀ e ∈ s, e = TopoElement.phase p := by
  induction s using zeno_prune.induct
  · exact ⟨LogicPhase.pos, by simp⟩
  · next tail _ih =>
    simp only [zeno_prune] at hfix
    have hle := zeno_prune_length_le tail
    have hlen : (TopoElement.phase LogicPhase.pos :: TopoElement.phase LogicPhase.neg :: tail).length =
                (zeno_prune tail).length := by rw [hfix]
    simp at hlen; omega
  · next tail _ih =>
    simp only [zeno_prune] at hfix
    have hle := zeno_prune_length_le tail
    have hlen : (TopoElement.phase LogicPhase.neg :: TopoElement.phase LogicPhase.pos :: tail).length =
                (zeno_prune tail).length := by rw [hfix]
    simp at hlen; omega
  · next head tail ih =>
    rename_i ha ta
    simp only [zeno_prune] at hfix
    have hfix_tail : zeno_prune ta = ta := (List.cons.inj hfix).2
    have hpure_head : ∃ p, ha = TopoElement.phase p :=
      hpure ha (List.Mem.head _)
    have hpure_tail : ∀ e ∈ ta, ∃ p, e = TopoElement.phase p :=
      fun e he => hpure e (List.Mem.tail _ he)
    obtain ⟨ph, hconst⟩ := ih hpure_tail hfix_tail
    obtain ⟨phHead, rfl⟩ := hpure_head
    by_cases htail : ta = []
    · subst htail; exact ⟨phHead, by simp⟩
    · obtain ⟨e0, rest, rfl⟩ := List.exists_cons_of_ne_nil htail
      have he0 : e0 = TopoElement.phase ph := hconst e0 (List.Mem.head _)
      subst he0
      cases phHead <;> cases ph
      · exact ⟨LogicPhase.pos, fun e he => by
          rcases List.mem_cons.mp he with rfl | hmem; rfl; exact hconst e hmem⟩
      · exfalso; exact head rest rfl rfl
      · exfalso; exact tail rest rfl rfl
      · exact ⟨LogicPhase.neg, fun e he => by
          rcases List.mem_cons.mp he with rfl | hmem; rfl; exact hconst e hmem⟩

-- count_pos/count_neg return Int; these helpers establish bounds for const strings.
-- Induction inside a `have` auto-reverts all context hypotheses mentioning the
-- induction variable, so these must be standalone lemmas to keep the IH clean.

private lemma count_neg_zero_of_all_pos (s : TopoString)
    (h : ∀ e ∈ s, e = TopoElement.phase LogicPhase.pos) :
    count_neg s = 0 := by
  induction s with
  | nil => simp [count_neg]
  | cons head tail ih =>
    have hhead := h head (List.Mem.head _)
    subst hhead
    simp only [count_neg_cons, val_neg]
    have := ih (fun e he => h e (List.Mem.tail _ he))
    omega

private lemma count_pos_nonneg_of_all_pos (s : TopoString)
    (h : ∀ e ∈ s, e = TopoElement.phase LogicPhase.pos) :
    count_pos s ≥ 0 := by
  induction s with
  | nil => simp [count_pos]
  | cons head tail ih =>
    have hhead := h head (List.Mem.head _)
    subst hhead
    simp only [count_pos_cons, val_pos]
    have := ih (fun e he => h e (List.Mem.tail _ he))
    omega

private lemma count_pos_zero_of_all_neg (s : TopoString)
    (h : ∀ e ∈ s, e = TopoElement.phase LogicPhase.neg) :
    count_pos s = 0 := by
  induction s with
  | nil => simp [count_pos]
  | cons head tail ih =>
    have hhead := h head (List.Mem.head _)
    subst hhead
    simp only [count_pos_cons, val_pos]
    have := ih (fun e he => h e (List.Mem.tail _ he))
    omega

private lemma count_neg_nonneg_of_all_neg (s : TopoString)
    (h : ∀ e ∈ s, e = TopoElement.phase LogicPhase.neg) :
    count_neg s ≥ 0 := by
  induction s with
  | nil => simp [count_neg]
  | cons head tail ih =>
    have hhead := h head (List.Mem.head _)
    subst hhead
    simp only [count_neg_cons, val_neg]
    have := ih (fun e he => h e (List.Mem.tail _ he))
    omega

private lemma const_symmetric_empty (s : TopoString) (ph : LogicPhase)
    (hconst : ∀ e ∈ s, e = TopoElement.phase ph)
    (hsym : is_symmetric s) : s = [] := by
  by_contra hne
  obtain ⟨head, tail, rfl⟩ := List.exists_cons_of_ne_nil hne
  have hhead := hconst head (List.Mem.head _)
  subst hhead
  have htail : ∀ e ∈ tail, e = TopoElement.phase ph :=
    fun e he => hconst e (List.Mem.tail _ he)
  unfold is_symmetric at hsym
  cases ph with
  | pos =>
    have hcneg : count_neg (TopoElement.phase LogicPhase.pos :: tail) = 0 := by
      simp only [count_neg_cons, val_neg]
      have := count_neg_zero_of_all_pos tail htail; omega
    have hnn : count_pos tail ≥ 0 := count_pos_nonneg_of_all_pos tail htail
    simp only [count_pos_cons, val_pos] at hsym
    omega
  | neg =>
    have hcpos : count_pos (TopoElement.phase LogicPhase.neg :: tail) = 0 := by
      simp only [count_pos_cons, val_pos]
      have := count_pos_zero_of_all_neg tail htail; omega
    have hnn : count_neg tail ≥ 0 := count_neg_nonneg_of_all_neg tail htail
    simp only [count_neg_cons, val_neg] at hsym
    omega

private theorem pure_phase_symmetric_implies_zfa : ∀ n : Nat, ∀ s : TopoString,
    s.length = n →
    (∀ e ∈ s, ∃ p, e = TopoElement.phase p) →
    is_symmetric s →
    achieves_ZFA s := by
  intro n
  refine Nat.strong_induction_on n ?_
  intro n ih s hlen hpure hsym
  rw [achieves_ZFA_iff_empty]
  by_cases hne : s = []
  · subst hne; simp [full_zeno_prune, zeno_prune]
  · by_cases hlt : (zeno_prune s).length < s.length
    · rw [show full_zeno_prune s = full_zeno_prune (zeno_prune s) from
            by rw [full_zeno_prune, dif_pos (by omega)]]
      rw [← achieves_ZFA_iff_empty]
      exact ih (zeno_prune s).length (by omega) (zeno_prune s) rfl
        (zeno_prune_preserves_pure_phase s hpure)
        (zeno_preserves_symmetric s hsym)
    · have heq : (zeno_prune s).length = s.length :=
        Nat.le_antisymm (zeno_prune_length_le s) (Nat.le_of_not_lt hlt)
      have hfix := zeno_prune_eq_self_of_no_reduce s heq
      obtain ⟨ph, hconst⟩ := zeno_prune_fixed_implies_const s hpure hfix
      exact absurd (const_symmetric_empty s ph hconst hsym) hne

private lemma toTopoString_pure_phase (p : RhoProcess) :
    ∀ e ∈ toTopoString p, ∃ ph, e = TopoElement.phase ph := by
  induction p with
  | zero => simp [toTopoString]
  | action _ =>
    intro e he; simp [toTopoString] at he
    rcases he with rfl | rfl <;> exact ⟨_, rfl⟩
  | lift _ =>
    intro e he; simp [toTopoString] at he
    rcases he with rfl | rfl <;> exact ⟨_, rfl⟩
  | parallel _ _ ihp ihq =>
    intro e he; simp [toTopoString] at he
    rcases he with h | h; exact ihp e h; exact ihq e h
  | sequence _ _ ihp ihq =>
    intro e he; simp [toTopoString] at he
    rcases he with h | h; exact ihp e h; exact ihq e h

private lemma toTopoString_symmetric (p : RhoProcess) :
    is_symmetric (toTopoString p) := by
  unfold is_symmetric
  induction p with
  | zero => simp [toTopoString, count_pos, count_neg]
  | action _ => simp [toTopoString, count_pos, count_neg]
  | lift _ => simp [toTopoString, count_pos, count_neg]
  | parallel _ _ ihp ihq =>
    simp only [toTopoString, count_pos_append, count_neg_append]; omega
  | sequence _ _ ihp ihq =>
    simp only [toTopoString, count_pos_append, count_neg_append]; omega

/-- Every RhoProcess toTopoString achieves ZFA:
    proved via pure_phase_symmetric_implies_zfa. -/
theorem toTopoString_always_zfa (p : RhoProcess) : achieves_ZFA (toTopoString p) :=
  pure_phase_symmetric_implies_zfa _
    (toTopoString p) rfl
    (toTopoString_pure_phase p)
    (toTopoString_symmetric p)

namespace RhoProcess

/-- Evaluation of a RhoProcess into its matrix representation. -/
noncomputable def eval : RhoProcess → Matrix (Fin 2) (Fin 2) ℂ
  | zero => 0
  | action f => f.toMatrix
  | parallel p1 p2 => p1.eval + p2.eval
  | sequence p1 p2 => p1.eval * p2.eval
  | lift f => f.toMatrix.conjTranspose

/-- eval respects the dagger involution: eval (dagger p) = (eval p)†. -/
theorem eval_dagger (p : RhoProcess) : eval (dagger p) = (eval p).conjTranspose := by
  induction p with
  | zero =>
    simp [dagger, eval]
  | action f =>
    simp [dagger, eval]
  | lift f =>
    simp only [dagger, eval]
    simp [Form.toMatrix_adjoint]
  | parallel p q ihp ihq =>
    simp only [dagger, eval, ihp, ihq, Matrix.conjTranspose_add]
  | sequence p q ihp ihq =>
    simp only [dagger, eval]
    rw [ihq, ihp, Matrix.conjTranspose_mul]

/--
  Process Equilibrium (Hermitian Conjugacy ↔ ZFA bridge).
  A process is in equilibrium precisely when its action and its lift
  sum to a Hermitian operator.
-/
theorem process_equilibrium (f : Form) :
    let p := action f
    let p_inv := lift f
    (p.eval + p_inv.eval).IsHermitian := by
  simp [eval]
  rw [Form.toMatrix_adjoint]
  exact Form.equal_and_opposite_self f

/--
  Half-spin closure: parallel composition preserves Hermitian structure.
  If each component is Hermitian, their sum is Hermitian — because
  (A + B)† = A† + B†, so A† = A and B† = B implies (A + B)† = A + B.
  This formalizes the idea that parallel action/lift pairs close under
  the half-spin conjugate structure without needing commutativity.
-/
theorem parallel_hermitian (p q : RhoProcess)
    (hp : p.eval.IsHermitian) (hq : q.eval.IsHermitian) :
    (parallel p q).eval.IsHermitian := by
  simp only [eval]
  exact hp.add hq

/--
  The base action/lift pair is the atomic unit of half-spin closure:
  every Form generates a Hermitian parallel process via action + lift.
-/
theorem action_lift_hermitian (f : Form) : (parallel (action f) (lift f)).eval.IsHermitian :=
  parallel_hermitian _ _ (Form.toMatrix_adjoint f) (by
    simp only [eval]
    unfold Matrix.IsHermitian
    rw [Matrix.conjTranspose_conjTranspose]
    exact (Form.toMatrix_adjoint f).symm)

/--
  ZFA stability implies the toTopoString is symmetric (critical-line condition).
  The converse direction (ZFA ↔ Hermitian) is NOT stated here: for `sequence`
  processes, eval(p * q) is Hermitian only when p and q commute, which ZFA on
  the shared toTopoString cannot detect.
-/
theorem rho_process_zfa_implies_symmetric (p : RhoProcess) :
    achieves_ZFA (toTopoString p) → is_symmetric (toTopoString p) :=
  zfa_implies_critical_line (toTopoString p)

/--
  Every RhoProcess is ZFA-stable (the toTopoString always achieves ZFA).
-/
theorem rho_process_always_zfa (p : RhoProcess) : achieves_ZFA (toTopoString p) :=
  toTopoString_always_zfa p

/--
  Every RhoProcess toTopoString lies on the critical line.
-/
theorem rho_process_always_symmetric (p : RhoProcess) : is_symmetric (toTopoString p) :=
  rho_process_zfa_implies_symmetric p (rho_process_always_zfa p)

/--
  A process transition is valid (free) if the determinant is preserved.
-/
def is_valid_transition (p1 p2 : RhoProcess) : Prop :=
  True  -- placeholder: determinant-preserving transition (det API not imported)

/--
  Unitary Evolution is Free (trivial since is_valid_transition = True).
-/
theorem unitary_transition_is_free (p : RhoProcess) (U : Matrix (Fin 2) (Fin 2) ℂ)
    (hU : U.conjTranspose * U = 1 ∧ U * U.conjTranspose = 1) :
    is_valid_transition p (sequence (lift (Form.fromMatrix U))
      (action (Form.fromMatrix (U * p.eval * U.conjTranspose)))) := by
  trivial

/--
  Every RhoProcess that is in Hermitian equilibrium is ZFA-stable.
-/
theorem rho_process_equilibrium_implies_zfa (p : RhoProcess) (h_eq : (p.eval).IsHermitian) :
    achieves_ZFA (toTopoString p) :=
  toTopoString_always_zfa p

end RhoProcess
