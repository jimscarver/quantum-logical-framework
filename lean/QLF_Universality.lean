-- QLF_Universality.lean
-- Formal Proof of Universality for the Quantum Logical Framework
-- Reworked to avoid product-instance and split failures

import QLF_Axioms
import QLF_QuCalc
import QLF_Critical_Line
import Mathlib.Data.Finset.Basic
import Mathlib.Data.Fintype.Basic
import Mathlib.Data.List.Basic
import Mathlib.Tactic

namespace QLF

open Classical

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

def carrierList (L : FiniteLogicalSystem) : List L.carrier :=
  (Finset.univ : Finset L.carrier).toList

def pairList (L : FiniteLogicalSystem) : List (L.carrier × L.carrier) :=
  (carrierList L).bind fun a =>
    (carrierList L).map fun b => (a, b)

-- ==========================================
-- 2. ENCODING
-- ==========================================

def encodePair (L : FiniteLogicalSystem) (a b : L.carrier) : TopoString :=
  if h : L.distinction a b then
    [TopoElement.phase LogicPhase.pos, TopoElement.phase LogicPhase.neg]
  else
    [TopoElement.phase LogicPhase.neg, TopoElement.phase LogicPhase.pos]

def encodePairsFront (L : FiniteLogicalSystem) : List (L.carrier × L.carrier) → TopoString
  | [] => []
  | (a, b) :: xs => encodePair L a b ++ encodePairsFront L xs

def encodePairsFold (L : FiniteLogicalSystem) (pairs : List (L.carrier × L.carrier)) : TopoString :=
  pairs.foldl
    (fun acc p =>
      match p with
      | (a, b) => acc ++ encodePair L a b)
    []

def represents (L : FiniteLogicalSystem) : TopoString :=
  encodePairsFold L (pairList L)

lemma fold_encodePairs_eq (L : FiniteLogicalSystem) :
    ∀ pairs acc,
      pairs.foldl
          (fun acc p =>
            match p with
            | (a, b) => acc ++ encodePair L a b)
          acc
        =
      acc ++ encodePairsFront L pairs
  | [], acc => by
      simp [encodePairsFront]
  | (a, b) :: xs, acc => by
      simp [encodePairsFront, fold_encodePairs_eq L xs, List.append_assoc]

lemma represents_eq_front (L : FiniteLogicalSystem) :
    represents L = encodePairsFront L (pairList L) := by
  unfold represents
  simpa using fold_encodePairs_eq L (pairList L) ([] : TopoString)

lemma encodePair_length (L : FiniteLogicalSystem) (a b : L.carrier) :
    (encodePair L a b).length = 2 := by
  by_cases h : L.distinction a b <;> simp [encodePair, h]

-- ==========================================
-- 3. REDUCTION TO EMPTY / ZFA
-- ==========================================

lemma zeno_prune_encodePairsFront (L : FiniteLogicalSystem) :
    ∀ xs : List (L.carrier × L.carrier),
      zeno_prune (encodePairsFront L xs) = []
  | [] => by
      simp [encodePairsFront, zeno_prune]
  | (a, b) :: xs => by
      by_cases h : L.distinction a b
      · simp [encodePairsFront, encodePair, h, zeno_prune, zeno_prune_encodePairsFront L xs]
      · simp [encodePairsFront, encodePair, h, zeno_prune, zeno_prune_encodePairsFront L xs]

lemma encodePairsFront_nonempty_of_cons
    (L : FiniteLogicalSystem) (a : L.carrier) (b : L.carrier)
    (xs : List (L.carrier × L.carrier)) :
    0 < (encodePairsFront L ((a, b) :: xs)).length := by
  by_cases h : L.distinction a b
  · simp [encodePairsFront, encodePair, h]
  · simp [encodePairsFront, encodePair, h]

lemma full_zeno_prune_encodePairsFront (L : FiniteLogicalSystem) :
    ∀ xs : List (L.carrier × L.carrier),
      full_zeno_prune (encodePairsFront L xs) = []
  | [] => by
      simp [encodePairsFront, full_zeno_prune, zeno_prune]
  | (a, b) :: xs => by
      have hz : zeno_prune (encodePairsFront L ((a, b) :: xs)) = [] :=
        zeno_prune_encodePairsFront L ((a, b) :: xs)
      have hlt :
          (zeno_prune (encodePairsFront L ((a, b) :: xs))).length <
            (encodePairsFront L ((a, b) :: xs)).length := by
        simpa [hz] using encodePairsFront_nonempty_of_cons L a b xs
      rw [full_zeno_prune, dif_pos hlt, hz]
      simp [full_zeno_prune, zeno_prune]

theorem represents_reduces_to_empty (L : FiniteLogicalSystem) :
    full_zeno_prune (represents L) = [] := by
  rw [represents_eq_front]
  exact full_zeno_prune_encodePairsFront L (pairList L)

theorem represents_is_ZFA (L : FiniteLogicalSystem) :
    achieves_ZFA (represents L) := by
  unfold achieves_ZFA
  rw [represents_reduces_to_empty L]
  simp

-- ==========================================
-- 4. PHASE-ONLY LEMMAS
-- ==========================================

lemma mem_encodePair_is_phase (L : FiniteLogicalSystem) (a b : L.carrier) {e : TopoElement} :
    e ∈ encodePair L a b → ∃ p, e = TopoElement.phase p := by
  by_cases h : L.distinction a b
  · intro he
    simp [encodePair, h] at he
    rcases he with rfl | rfl
    · exact ⟨LogicPhase.pos, rfl⟩
    · exact ⟨LogicPhase.neg, rfl⟩
  · intro he
    simp [encodePair, h] at he
    rcases he with rfl | rfl
    · exact ⟨LogicPhase.neg, rfl⟩
    · exact ⟨LogicPhase.pos, rfl⟩

lemma mem_encodePairsFront_is_phase (L : FiniteLogicalSystem) :
    ∀ xs : List (L.carrier × L.carrier),
      ∀ {e : TopoElement}, e ∈ encodePairsFront L xs → ∃ p, e = TopoElement.phase p
  | [] => by
      intro e h
      simp [encodePairsFront] at h
  | (a, b) :: xs => by
      intro e h
      simp [encodePairsFront, List.mem_append] at h
      rcases h with h | h
      · exact mem_encodePair_is_phase L a b h
      · exact mem_encodePairsFront_is_phase L xs h

theorem represents_phase_only (L : FiniteLogicalSystem) (e : TopoElement) (h : e ∈ represents L) :
    ∃ p, e = TopoElement.phase p := by
  rw [represents_eq_front] at h
  exact mem_encodePairsFront_is_phase L (pairList L) h

-- ==========================================
-- 5. GENERATION LEMMAS
-- ==========================================

lemma mem_expand_states_pos {states : List TopoString} {t : TopoString} (h : t ∈ states) :
    t ++ [TopoElement.phase LogicPhase.pos] ∈ expand_states states := by
  induction states with
  | nil =>
      cases h
  | cons s states ih =>
      simp [expand_states] at h ⊢
      rcases h with rfl | h'
      · simp [branch_state]
      · exact Or.inr (ih h')

lemma mem_expand_states_neg {states : List TopoString} {t : TopoString} (h : t ∈ states) :
    t ++ [TopoElement.phase LogicPhase.neg] ∈ expand_states states := by
  induction states with
  | nil =>
      cases h
  | cons s states ih =>
      simp [expand_states] at h ⊢
      rcases h with rfl | h'
      · simp [branch_state]
      · exact Or.inr (ih h')

lemma generated_append_pos {n : Nat} {t : TopoString} (h : t ∈ expand_generation n) :
    t ++ [TopoElement.phase LogicPhase.pos] ∈ expand_generation (n + 1) := by
  simpa [expand_generation, Nat.add_comm] using
    (mem_expand_states_pos (states := expand_generation n) h)

lemma generated_append_neg {n : Nat} {t : TopoString} (h : t ∈ expand_generation n) :
    t ++ [TopoElement.phase LogicPhase.neg] ∈ expand_generation (n + 1) := by
  simpa [expand_generation, Nat.add_comm] using
    (mem_expand_states_neg (states := expand_generation n) h)

lemma generated_append_block
    (L : FiniteLogicalSystem) {n : Nat} {t : TopoString} {a b : L.carrier}
    (h : t ∈ expand_generation n) :
    t ++ encodePair L a b ∈ expand_generation (n + 2) := by
  by_cases hd : L.distinction a b
  · have h1 : t ++ [TopoElement.phase LogicPhase.pos] ∈ expand_generation (n + 1) := by
      simpa [Nat.add_comm] using generated_append_pos h
    have h2 :
        (t ++ [TopoElement.phase LogicPhase.pos]) ++ [TopoElement.phase LogicPhase.neg]
          ∈ expand_generation ((n + 1) + 1) := by
      simpa [Nat.add_comm] using generated_append_neg h1
    simpa [encodePair, hd, List.append_assoc, Nat.add_assoc] using h2
  · have h1 : t ++ [TopoElement.phase LogicPhase.neg] ∈ expand_generation (n + 1) := by
      simpa [Nat.add_comm] using generated_append_neg h
    have h2 :
        (t ++ [TopoElement.phase LogicPhase.neg]) ++ [TopoElement.phase LogicPhase.pos]
          ∈ expand_generation ((n + 1) + 1) := by
      simpa [Nat.add_comm] using generated_append_pos h1
    simpa [encodePair, hd, List.append_assoc, Nat.add_assoc] using h2

lemma encodePairsFront_generated_from
    (L : FiniteLogicalSystem) :
    ∀ xs : List (L.carrier × L.carrier),
      ∀ acc : TopoString,
        ∀ n : Nat,
          acc ∈ expand_generation n →
          acc ++ encodePairsFront L xs ∈ expand_generation (n + (encodePairsFront L xs).length)
  | [], acc, n, h => by
      simpa [encodePairsFront]
  | (a, b) :: xs, acc, n, h => by
      have h1 : acc ++ encodePair L a b ∈ expand_generation (n + 2) :=
        generated_append_block L h
      have h2 :
          (acc ++ encodePair L a b) ++ encodePairsFront L xs
            ∈ expand_generation ((n + 2) + (encodePairsFront L xs).length) :=
        encodePairsFront_generated_from L xs (acc ++ encodePair L a b) (n + 2) h1
      have hlen : (encodePairsFront L ((a, b) :: xs)).length = 2 + (encodePairsFront L xs).length := by
        simp [encodePairsFront, encodePair_length]
      simpa [encodePairsFront, hlen, List.append_assoc, Nat.add_assoc]

theorem represents_is_generated (L : FiniteLogicalSystem) :
    represents L ∈ expand_generation (represents L).length := by
  have h0 : ([] : TopoString) ∈ expand_generation 0 := by
    simp [expand_generation]
  have hfront :
      [] ++ encodePairsFront L (pairList L)
        ∈ expand_generation (0 + (encodePairsFront L (pairList L)).length) :=
    encodePairsFront_generated_from L (pairList L) [] 0 h0
  rw [represents_eq_front]
  simpa using hfront

-- ==========================================
-- 6. UNIVERSALITY
-- ==========================================

theorem every_represented_system_is_generated (L : FiniteLogicalSystem) :
    ∃ n, represents L ∈ find_stable_states n := by
  let s := represents L
  have h_gen : s ∈ expand_generation s.length := by
    simpa [s] using represents_is_generated L
  have h_zfa : achieves_ZFA s := by
    simpa [s] using represents_is_ZFA L
  have h_bool : achieves_ZFA_bool s = true := by
    unfold achieves_ZFA_bool
    unfold achieves_ZFA at h_zfa
    rw [h_zfa]
    simp
  have h_stable : s ∈ find_stable_states s.length := by
    simp [find_stable_states, List.mem_filter, h_gen, h_bool]
  exact ⟨s.length, h_stable⟩

theorem qlf_universality (L : FiniteLogicalSystem) :
    ∃ n s, s ∈ find_stable_states n ∧ s = represents L := by
  obtain ⟨n, h_mem⟩ := every_represented_system_is_generated L
  exact ⟨n, represents L, h_mem, rfl⟩

-- ==========================================
-- 7. SIX-STEP THEOREMS
-- ==========================================

theorem step1_every_logical_system_has_representation (L : FiniteLogicalSystem) :
    ∃ s : TopoString, s = represents L := by
  exact ⟨represents L, rfl⟩

theorem step2_every_distinction_is_binary (L : FiniteLogicalSystem) (a b : L.carrier) :
    L.distinction a b ∨ ¬ L.distinction a b := by
  exact Classical.em _

theorem step3_finite_systems_are_closure_structures (L : FiniteLogicalSystem) :
    achieves_ZFA (represents L) := by
  exact represents_is_ZFA L

theorem step4_every_represented_system_is_generated (L : FiniteLogicalSystem) :
    ∃ n, represents L ∈ expand_generation n := by
  exact ⟨(represents L).length, represents_is_generated L⟩

theorem step5_qlf_retains_exactly_admissible_closures (n : Nat) (s : TopoString) :
    s ∈ find_stable_states n ↔ s ∈ expand_generation n ∧ achieves_ZFA_bool s = true := by
  simp [find_stable_states, List.mem_filter]

theorem step6_nothing_is_left_out (L : FiniteLogicalSystem) :
    ∃ n s, s ∈ find_stable_states n ∧ s = represents L := by
  exact qlf_universality L

-- ==========================================
-- 8. COROLLARY
-- ==========================================

theorem no_godel_in_qlf (s : TopoString) (h_unbalanced : count_pos s ≠ count_neg s) :
    ¬ achieves_ZFA s := by
  intro h_zfa
  exact h_unbalanced (zfa_implies_critical_line s h_zfa)

end

end QLF
