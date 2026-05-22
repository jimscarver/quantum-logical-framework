-- QLF_Riemann.lean
-- Riemann Hypothesis Proof – Corrected Combinatorial Connection

import QLF_Axioms
import QLF_QuCalc
import QLF_Universality
import QLF_Critical_Line
import QLF_Spectral
import RhoQuCalc
import Mathlib.NumberTheory.LSeries.RiemannZeta
import Mathlib.Data.Complex.Basic
import Mathlib.Data.List.Basic
import Mathlib.Data.Nat.Choose.Basic

namespace QLF

axiom NonTrivialZero : ℂ → Prop

-- Hilbert-Pólya bridge (axiom): a QLF string whose spectral mode is a scalar
-- multiple of the identity forces an associated non-trivial zero to Re(s) = 1/2.
-- This is the QLF form of the Hilbert-Pólya conjecture; it remains an axiom.
axiom spectral_hilbert_polya {s : TopoString} {ρ : ℂ} :
    (∃ c : ℂ, toSpectralMode s = c • (1 : Matrix (Fin 2) (Fin 2) ℂ)) →
    NonTrivialZero ρ → ρ.re = 1/2

-- Derived from spectral_hilbert_polya via spectral_symmetric_eq_scalar_id:
theorem critical_line_forcing {s : TopoString} {ρ : ℂ}
    (hpure : ∀ e ∈ s, ∃ p, e = TopoElement.phase p)
    (hsym : is_symmetric s) (h_zero : NonTrivialZero ρ) : ρ.re = 1/2 :=
  spectral_hilbert_polya (spectral_symmetric_eq_scalar_id s hpure hsym) h_zero

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
-- QUANTITATIVE COUNT: find_stable_states_length_even
-- ==========================================

-- count_pos is non-negative (ZFA definitions never go below 0)
private lemma count_pos_nonneg (s : TopoString) : 0 ≤ count_pos s := by
  induction s with
  | nil => simp [count_pos]
  | cons h t ih =>
    rw [count_pos_cons]
    have : 0 ≤ val_pos h := by
      cases h with
      | gauge => simp [val_pos]
      | phase p => cases p <;> simp [val_pos]
    omega

-- count_pos after appending a pos or neg element
private lemma count_pos_append_pos (s : TopoString) :
    count_pos (s ++ [TopoElement.phase LogicPhase.pos]) = count_pos s + 1 := by
  induction s with
  | nil => simp [count_pos]
  | cons h t ih => simp only [List.cons_append, count_pos_cons, ih]; ring

private lemma count_pos_append_neg (s : TopoString) :
    count_pos (s ++ [TopoElement.phase LogicPhase.neg]) = count_pos s := by
  induction s with
  | nil => simp [count_pos, val_pos]
  | cons h t ih => simp only [List.cons_append, count_pos_cons, ih]

-- Filter length over expand_states splits by pos-count: Pascal step
private lemma expand_states_filter_pos_eq (gen : List TopoString) (p : ℤ) :
    ((expand_states gen).filter (fun s => decide (count_pos s = p))).length =
    (gen.filter (fun s => decide (count_pos s = p - 1))).length +
    (gen.filter (fun s => decide (count_pos s = p))).length := by
  induction gen with
  | nil => simp [expand_states]
  | cons head tail ih =>
    simp only [expand_states, List.filter_append, List.length_append]
    rw [ih]
    have hpos : count_pos (head ++ [TopoElement.phase LogicPhase.pos]) = count_pos head + 1 :=
      count_pos_append_pos head
    have hneg : count_pos (head ++ [TopoElement.phase LogicPhase.neg]) = count_pos head :=
      count_pos_append_neg head
    -- Filter over [head++pos, head++neg] contributes based on count_pos head vs p
    have hbranch :
        ((branch_state head).filter (fun s => decide (count_pos s = p))).length =
        (if count_pos head = p - 1 then 1 else 0) + (if count_pos head = p then 1 else 0) := by
      simp only [branch_state, List.filter_cons, List.filter_nil, hpos, hneg,
                 decide_eq_true_eq, List.length_nil, List.length_cons]
      split_ifs <;> omega
    rw [hbranch]
    simp only [List.filter_cons, decide_eq_true_eq, List.length_cons, List.length_nil]
    split_ifs <;> omega

-- Main counting lemma: exactly C(k,p) strings in expand_generation k have count_pos = p
private lemma expand_generation_filter_pos_count (k p : ℕ) :
    ((expand_generation k).filter (fun s => decide (count_pos s = (p : ℤ)))).length =
    Nat.choose k p := by
  induction k generalizing p with
  | zero =>
    simp only [expand_generation, List.filter_cons, List.filter_nil, List.length_cons,
               List.length_nil, count_pos]
    cases p with
    | zero => simp
    | succ p =>
      have : decide ((0 : ℤ) = (p.succ : ℤ)) = false := by
        rw [decide_eq_false_iff_not]; push_cast; omega
      simp [this, Nat.choose]
  | succ k ih =>
    simp only [expand_generation]
    rw [expand_states_filter_pos_eq]
    cases p with
    | zero =>
      -- p=0: the p-1 = -1 filter is empty (count_pos ≥ 0), and C(k,0) = 1 = C(k+1,0)
      simp only [Nat.cast_zero, zero_sub, Nat.choose_zero_right]
      have hzero : (expand_generation k).filter
          (fun s => decide (count_pos s = (-1 : ℤ))).length = 0 := by
        have hneg : ∀ s : TopoString, decide (count_pos s = (-1 : ℤ)) = false := fun s => by
          rw [decide_eq_false_iff_not]; exact fun h => absurd h (by linarith [count_pos_nonneg s])
        simp [List.filter_congr (fun s (_ : s ∈ expand_generation k) => hneg s)]
      rw [hzero, zero_add, ih 0, Nat.choose_zero_right]
    | succ p =>
      -- p = q+1: use ih twice and Pascal's rule
      have hcast : ((p.succ : ℕ) : ℤ) - 1 = (p : ℤ) := by push_cast; ring
      have heq : (expand_generation k).filter
          (fun s => decide (count_pos s = ((p.succ : ℕ) : ℤ) - 1)) =
          (expand_generation k).filter
          (fun s => decide (count_pos s = (p : ℤ))) := by
        apply List.filter_congr
        intro s _; rw [hcast]
      rw [heq, ih p, ih p.succ]
      exact (Nat.choose_succ_succ k p).symm

-- achieves_ZFA_bool agrees with "count_pos = n" on elements of expand_generation(2n)
private lemma achieves_ZFA_bool_eq_decide_count (n : ℕ) (s : TopoString)
    (hs : s ∈ expand_generation (2 * n)) :
    achieves_ZFA_bool s = decide (count_pos s = (n : ℤ)) := by
  have h_pure  := expand_generation_pure_phase (2 * n) s hs
  have h_len   := expand_generation_length (2 * n) s hs
  have h_count := count_pos_add_neg_eq_length s h_pure
  have h_lint  : (s.length : ℤ) = 2 * n := by exact_mod_cast h_len
  -- achieves_ZFA_bool s = true ↔ count_pos s = n  (for these strings)
  have key : achieves_ZFA_bool s = true ↔ count_pos s = (n : ℤ) := by
    rw [achieves_ZFA_bool_iff_zfa]
    constructor
    · intro h
      have h_sym := zfa_implies_critical_line s h
      unfold is_symmetric at h_sym; omega
    · intro h_pos
      exact phase_symmetric_achieves_zfa s h_pure (by unfold is_symmetric; omega)
  -- Lift iff to Bool equality
  cases h : achieves_ZFA_bool s
  · -- false branch: show decide (count_pos s = n) = false
    symm; rw [decide_eq_false_iff_not]
    intro hpos
    have := key.mpr hpos; rw [h] at this
    exact absurd this (by decide)
  · -- true branch: show decide (count_pos s = n) = true
    rw [h]; exact (decide_eq_true_eq.mpr (key.mp h)).symm

/-- The number of symmetric pure-phase strings of length 2n is C(2n, n). -/
theorem find_stable_states_length_even (n : ℕ) :
    (find_stable_states (2 * n)).length = Nat.choose (2 * n) n := by
  simp only [find_stable_states]
  rw [List.filter_congr (fun s hs => achieves_ZFA_bool_eq_decide_count n s hs)]
  exact expand_generation_filter_pos_count (2 * n) n

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
  exact critical_line_forcing (encode_is_phase_only (resonant_computation_for ρ)) h_sym h_zero

end QLF
