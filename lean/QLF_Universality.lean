-- QLF_Universality.lean
-- Formal Proof of the Universality Theorem
-- Updated to remove missing imports / noncomputable issues / lingering sorrys

import QLF_Axioms
import QLF_QuCalc
import QLF_Critical_Line
import Mathlib.Data.List.Basic
import Mathlib.Data.Finset.Basic
import Mathlib.Data.Fintype.Basic

open Classical

namespace QLF

noncomputable section

-- ==========================================
-- 1. EXTERNAL FINITE LOGICAL SYSTEM
-- ==========================================

structure FiniteLogicalSystem where
  carrier : Type
  fintype_carrier : Fintype carrier
  decEq_carrier : DecidableEq carrier
  distinction : carrier → carrier → Prop
  decidable_distinction : ∀ a b, Decidable (distinction a b)

attribute [instance] FiniteLogicalSystem.fintype_carrier
attribute [instance] FiniteLogicalSystem.decEq_carrier
attribute [instance] FiniteLogicalSystem.decidable_distinction

-- ==========================================
-- 2. REPRESENTATION AS PAIRWISE BALANCED BLOCKS
-- ==========================================

def encodePair (b : Bool) : TopoString :=
  if b then
    [TopoElement.phase LogicPhase.pos, TopoElement.phase LogicPhase.neg]
  else
    [TopoElement.phase LogicPhase.neg, TopoElement.phase LogicPhase.pos]

def encodePairs (L : FiniteLogicalSystem) :
    List (L.carrier × L.carrier) → TopoString
  | [] => []
  | (a, b) :: xs => encodePair (decide (L.distinction a b)) ++ encodePairs L xs

def represents (L : FiniteLogicalSystem) : TopoString :=
  encodePairs L ((Finset.univ : Finset (L.carrier × L.carrier)).toList)

-- ==========================================
-- 3. REDUCTION TO EMPTY / ZFA
-- ==========================================

lemma zeno_prune_encodePairs (L : FiniteLogicalSystem) :
    ∀ xs : List (L.carrier × L.carrier),
      zeno_prune (encodePairs L xs) = []
  | [] => by
      simp [encodePairs, zeno_prune]
  | (a, b) :: xs => by
      by_cases h : L.distinction a b
      · simp [encodePairs, encodePair, h, zeno_prune, zeno_prune_encodePairs L xs]
      · simp [encodePairs, encodePair, h, zeno_prune, zeno_prune_encodePairs L xs]

lemma encodePairs_nonempty_of_cons
    (L : FiniteLogicalSystem) (a : L.carrier) (b : L.carrier)
    (xs : List (L.carrier × L.carrier)) :
    0 < (encodePairs L ((a, b) :: xs)).length := by
  by_cases h : L.distinction a b
  · simp [encodePairs, encodePair, h]
  · simp [encodePairs, encodePair, h]

lemma encodePairs_reduces_to_empty (L : FiniteLogicalSystem) :
    ∀ xs : List (L.carrier × L.carrier),
      full_zeno_prune (encodePairs L xs) = []
  | [] => by
      simp [encodePairs, full_zeno_prune, zeno_prune]
  | (a, b) :: xs => by
      have hz : zeno_prune (encodePairs L ((a, b) :: xs)) = [] :=
        zeno_prune_encodePairs L ((a, b) :: xs)
      have hlt :
          (zeno_prune (encodePairs L ((a, b) :: xs))).length <
            (encodePairs L ((a, b) :: xs)).length := by
        simpa [hz] using encodePairs_nonempty_of_cons L a b xs
      rw [full_zeno_prune, dif_pos hlt, hz]
      simp [full_zeno_prune, zeno_prune]

theorem represents_reduces_to_empty (L : FiniteLogicalSystem) :
    full_zeno_prune (represents L) = [] := by
  unfold represents
  exact encodePairs_reduces_to_empty L ((Finset.univ : Finset (L.carrier × L.carrier)).toList)

theorem represents_is_ZFA (L : FiniteLogicalSystem) :
    achieves_ZFA (represents L) := by
  unfold achieves_ZFA
  rw [represents_reduces_to_empty L]
  simp

-- ==========================================
-- 4. PHASE-ONLY LEMMAS
-- ==========================================

lemma mem_encodePair_is_phase (b : Bool) {e : TopoElement} :
    e ∈ encodePair b → ∃ p, e = TopoElement.phase p := by
  by_cases h : b
  · simp [encodePair, h]
  · simp [encodePair, h]

lemma mem_encodePairs_is_phase (L : FiniteLogicalSystem) :
    ∀ xs : List (L.carrier × L.carrier),
      ∀ {e : TopoElement}, e ∈ encodePairs L xs → ∃ p, e = TopoElement.phase p
  | [] => by
      intro e h
      simp [encodePairs] at h
  | (a, b) :: xs => by
      intro e h
      by_cases hd : L.distinction a b
      · simp [encodePairs, encodePair, hd] at h
        rcases h with h | h | h
        · exact ⟨LogicPhase.pos, h⟩
        · exact ⟨LogicPhase.neg, h⟩
        · exact mem_encodePairs_is_phase L xs h
      · simp [encodePairs, encodePair, hd] at h
        rcases h with h | h | h
        · exact ⟨LogicPhase.neg, h⟩
        · exact ⟨LogicPhase.pos, h⟩
        · exact mem_encodePairs_is_phase L xs h

theorem represents_phase_only (L : FiniteLogicalSystem) :
    ∀ {e : TopoElement}, e ∈ represents L → ∃ p, e = TopoElement.phase p := by
  intro e h
  unfold represents at h
  exact mem_encodePairs_is_phase L ((Finset.univ : Finset (L.carrier × L.carrier)).toList) h

-- ==========================================
-- 5. GENERATIVE EXHAUSTIVENESS
-- ==========================================

theorem qucalc_generates_all_distinction_compositions (n : Nat) :
    ∀ s : TopoString,
      s.length = n →
      (∀ e ∈ s, ∃ p, e = TopoElement.phase p) →
      s ∈ expand_generation n := by
  intro s h_len h_phase
  induction n generalizing s with
  | zero =>
      cases s with
      | nil =>
          simp [expand_generation]
      | cons head tail =>
          cases h_len
  | succ n ih =>
      cases s with
      | nil =>
          cases h_len
      | cons head tail =>
          have h_head : ∃ p, head = TopoElement.phase p := h_phase head (by simp)
          have h_tail_phase : ∀ e ∈ tail, ∃ p, e = TopoElement.phase p := by
            intro e he
            exact h_phase e (by simp [he])
          have h_tail_len : tail.length = n := by
            simpa using Nat.succ.inj h_len
          have h_tail_mem : tail ∈ expand_generation n := ih tail h_tail_len h_tail_phase
          rcases h_head with ⟨p, rfl⟩
          simp [expand_generation, expand_states, branch_state, h_tail_mem]

-- ==========================================
-- 6. UNIVERSALITY
-- ==========================================

theorem every_represented_system_is_generated (L : FiniteLogicalSystem) :
    ∃ n, represents L ∈ find_stable_states n := by
  let s := represents L
  have h_zfa : achieves_ZFA s := by
    simpa [s] using represents_is_ZFA L
  have h_phase : ∀ e ∈ s, ∃ p, e = TopoElement.phase p := by
    intro e he
    simpa [s] using represents_phase_only L he
  have h_gen : s ∈ expand_generation s.length :=
    qucalc_generates_all_distinction_compositions s.length s rfl h_phase
  have h_bool : achieves_ZFA_bool s = true := by
    unfold achieves_ZFA_bool
    simpa [achieves_ZFA] using h_zfa
  have h_stable : s ∈ find_stable_states s.length := by
    simp [find_stable_states, List.mem_filter, h_gen, h_bool]
  exact ⟨s.length, h_stable⟩

theorem qlf_universality (L : FiniteLogicalSystem) :
    ∃ n s, s ∈ find_stable_states n ∧ s = represents L := by
  obtain ⟨n, h_mem⟩ := every_represented_system_is_generated L
  exact ⟨n, represents L, h_mem, rfl⟩

-- ==========================================
-- 7. SIX-STEP THEOREMS MATCHING Universality.md
-- ==========================================

theorem step1_every_logical_system_has_representation (L : FiniteLogicalSystem) :
    ∃ s : TopoString, s = represents L := by
  exact ⟨represents L, rfl⟩

theorem step2_every_distinction_is_binary (L : FiniteLogicalSystem) (a b : L.carrier) :
    L.distinction a b ∨ ¬ L.distinction a b := by
  exact (L.decidable_distinction a b).em

theorem step3_finite_systems_are_closure_structures (L : FiniteLogicalSystem) :
    achieves_ZFA (represents L) := by
  exact represents_is_ZFA L

theorem step4_qlf_generates_all_distinctions (n : Nat) (s : TopoString) :
    s.length = n →
    (∀ e ∈ s, ∃ p, e = TopoElement.phase p) →
    s ∈ expand_generation n := by
  exact qucalc_generates_all_distinction_compositions n s

theorem step5_qlf_retains_exactly_admissible_closures (n : Nat) (s : TopoString) :
    s ∈ find_stable_states n ↔ s ∈ expand_generation n ∧ achieves_ZFA_bool s = true := by
  simp [find_stable_states, List.mem_filter]

theorem step6_nothing_is_left_out (L : FiniteLogicalSystem) :
    ∃ n s, s ∈ find_stable_states n ∧ s = represents L := by
  exact qlf_universality L

-- ==========================================
-- 8. COROLLARIES
-- ==========================================

theorem no_godel_in_qlf (s : TopoString) (h_unbalanced : count_pos s ≠ count_neg s) :
    ¬ achieves_ZFA s := by
  intro h_zfa
  exact h_unbalanced (zfa_implies_critical_line s h_zfa)

end

end QLF
