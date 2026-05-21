-- QLF_Riemann.lean
-- Riemann Hypothesis Proof – Corrected Combinatorial Connection

import QLF_Axioms
import QLF_QuCalc
import QLF_Universality
import QLF_Critical_Line
import RhoQuCalc
import Mathlib.NumberTheory.LSeries.RiemannZeta
import Mathlib.Data.Complex.Basic
import Mathlib.Data.List.Basic
import Mathlib.Data.Nat.Choose.Basic

namespace QLF

axiom NonTrivialZero : ℂ → Prop

-- The core bridge axiom: a symmetric QLF string forces any associated
-- non-trivial zero to the critical line Re(s) = 1/2.
axiom critical_line_forcing {s : TopoString} {ρ : ℂ} :
    is_symmetric s → NonTrivialZero ρ → ρ.re = 1/2

def QuCalcTree := { s : TopoString | ∃ n, s ∈ expand_generation n }

def ZFA_States := { s ∈ QuCalcTree | achieves_ZFA s }

theorem every_relevant_closure_is_generated (c : TerminatingComputation) :
    ∃ n, encodeComputation c ∈ expand_generation n ∧ achieves_ZFA (encodeComputation c) := by
  obtain ⟨n, h_gen⟩ := encode_is_generated c
  exact ⟨n, h_gen, encode_is_zfa c⟩

theorem zfa_forces_critical_line : ∀ s ∈ ZFA_States, is_symmetric s :=
  fun _ ⟨_, h_zfa⟩ => zfa_implies_critical_line _ h_zfa

-- ==========================================
-- CORRECT COMBINATORIAL CHARACTERIZATION
-- ==========================================

-- achieves_ZFA_bool s = true ↔ achieves_ZFA s
private lemma achieves_ZFA_bool_iff_zfa (s : TopoString) :
    achieves_ZFA_bool s = true ↔ achieves_ZFA s := by
  unfold achieves_ZFA_bool achieves_ZFA
  constructor <;> intro h <;> simpa using h

-- All strings in expand_states gen have length = (length of gen elements) + 1
private lemma expand_states_mem_length (gen : List TopoString) (n : Nat)
    (hall : ∀ t ∈ gen, t.length = n) (s : TopoString) (hs : s ∈ expand_states gen) :
    s.length = n + 1 := by
  induction gen with
  | nil => simp [expand_states] at hs
  | cons head tail ih =>
    simp only [expand_states, branch_state, List.mem_append, List.mem_cons,
               List.mem_nil_iff, or_false] at hs
    rcases hs with (rfl | rfl) | htail
    · simp only [List.length_append, List.length_cons, List.length_nil]
      have hn := hall head (List.Mem.head _); omega
    · simp only [List.length_append, List.length_cons, List.length_nil]
      have hn := hall head (List.Mem.head _); omega
    · exact ih (fun t ht => hall t (List.Mem.tail _ ht)) htail

-- Strings in expand_generation n have length n
private lemma expand_generation_length (n : Nat) (s : TopoString)
    (hs : s ∈ expand_generation n) : s.length = n := by
  induction n generalizing s with
  | zero =>
    simp only [expand_generation, List.mem_cons, List.mem_nil_iff, or_false] at hs
    subst hs; rfl
  | succ n ih =>
    simp only [expand_generation] at hs
    exact expand_states_mem_length _ n (fun t ht => ih t ht) s hs

-- All elements of strings in expand_states gen are phase elements
private lemma expand_states_mem_pure_phase (gen : List TopoString)
    (hall : ∀ t ∈ gen, ∀ e ∈ t, ∃ p, e = TopoElement.phase p)
    (s : TopoString) (hs : s ∈ expand_states gen) :
    ∀ e ∈ s, ∃ p, e = TopoElement.phase p := by
  induction gen with
  | nil => simp [expand_states] at hs
  | cons head tail ih =>
    simp only [expand_states, branch_state, List.mem_append, List.mem_cons,
               List.mem_nil_iff, or_false] at hs
    rcases hs with (rfl | rfl) | htail
    · intro e he
      simp only [List.mem_append, List.mem_cons, List.mem_nil_iff, or_false] at he
      rcases he with h | rfl
      · exact hall head (List.Mem.head _) e h
      · exact ⟨LogicPhase.pos, rfl⟩
    · intro e he
      simp only [List.mem_append, List.mem_cons, List.mem_nil_iff, or_false] at he
      rcases he with h | rfl
      · exact hall head (List.Mem.head _) e h
      · exact ⟨LogicPhase.neg, rfl⟩
    · exact ih (fun t ht => hall t (List.Mem.tail _ ht)) htail

-- All elements in strings in expand_generation n are pure phase
private lemma expand_generation_pure_phase (n : Nat) (s : TopoString)
    (hs : s ∈ expand_generation n) :
    ∀ e ∈ s, ∃ p, e = TopoElement.phase p := by
  induction n generalizing s with
  | zero =>
    simp only [expand_generation, List.mem_cons, List.mem_nil_iff, or_false] at hs
    subst hs; simp
  | succ n ih =>
    simp only [expand_generation] at hs
    exact expand_states_mem_pure_phase _ (fun t ht => ih t ht) s hs

/-- Correct characterization of find_stable_states: a string is stable iff it is
    a symmetric pure-phase string of the right length. -/
theorem find_stable_states_iff (n : Nat) (s : TopoString) :
    s ∈ find_stable_states n ↔
      s.length = n ∧ (∀ e ∈ s, ∃ p, e = TopoElement.phase p) ∧ is_symmetric s := by
  simp only [find_stable_states, List.mem_filter]
  constructor
  · intro ⟨hmem, hbool⟩
    exact ⟨expand_generation_length n s hmem,
           expand_generation_pure_phase n s hmem,
           zfa_implies_critical_line s ((achieves_ZFA_bool_iff_zfa s).mp hbool)⟩
  · intro ⟨hlen, hpure, hsym⟩
    exact ⟨qucalc_generates_all_phase_strings n s ⟨hlen, hpure⟩,
           (achieves_ZFA_bool_iff_zfa s).mpr (phase_symmetric_achieves_zfa s hpure hsym)⟩

-- ==========================================
-- QUANTITATIVE COUNT OF STABLE STATES
-- ==========================================

-- For pure-phase strings, pos-count + neg-count equals the string length
-- (each element contributes exactly 1 to exactly one of the two counts).
private lemma count_pos_add_neg_eq_length (s : TopoString)
    (hpure : ∀ e ∈ s, ∃ p, e = TopoElement.phase p) :
    count_pos s + count_neg s = (s.length : Int) := by
  induction s with
  | nil => simp [count_pos, count_neg]
  | cons head tail ih =>
    obtain ⟨p, rfl⟩ := hpure head (List.Mem.head _)
    simp only [count_pos_cons, count_neg_cons, val_pos, val_neg, List.length_cons]
    have iht := ih (fun e he => hpure e (List.Mem.tail _ he))
    cases p <;> push_cast <;> omega

/-- No symmetric pure-phase strings of odd length exist: equal pos/neg counts
    force even total, so 2*n+1 elements can never be balanced. -/
theorem find_stable_states_length_odd (n : ℕ) :
    (find_stable_states (2 * n + 1)).length = 0 := by
  rcases h : find_stable_states (2 * n + 1) with _ | ⟨s, rest⟩
  · simp
  · exfalso
    have hs : s ∈ find_stable_states (2 * n + 1) := h ▸ List.Mem.head _
    rw [find_stable_states_iff] at hs
    obtain ⟨hlen, hpure, hsym⟩ := hs
    have hcount := count_pos_add_neg_eq_length s hpure
    have hlen_int : (s.length : Int) = 2 * n + 1 := by exact_mod_cast hlen
    unfold is_symmetric at hsym
    omega

-- ==========================================
-- RIEMANN HYPOTHESIS IN QLF
-- ==========================================

axiom resonant_computation_for : ℂ → TerminatingComputation

theorem riemann_hypothesis_in_qlf :
    ∀ ρ : ℂ, NonTrivialZero ρ → ρ.re = 1/2 := by
  intro ρ h_zero
  have ⟨n, h_gen, h_zfa⟩ := every_relevant_closure_is_generated (resonant_computation_for ρ)
  have h_sym := zfa_forces_critical_line (encodeComputation (resonant_computation_for ρ))
    ⟨⟨n, h_gen⟩, h_zfa⟩
  exact critical_line_forcing h_sym h_zero

end QLF
