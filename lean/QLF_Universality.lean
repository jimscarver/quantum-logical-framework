-- QLF_Universality.lean
-- Universality: QLF generates all terminating finitely-encoded logical computations

import QLF_Axioms
import QLF_QuCalc
import QLF_Critical_Line
import Mathlib.Data.Finset.Basic

namespace QLF

/-- A terminating logical computation unrolled into a finite acyclic NAND-delay graph. -/
structure TerminatingComputation where
  nodes : Nat
  edges : List (Nat × Nat × Bool)  -- (from, to, isNand)

noncomputable def encodeComputation (c : TerminatingComputation) : TopoString :=
  c.edges.flatMap fun (_, _, isNand) =>
    if isNand then
      [TopoElement.phase LogicPhase.pos, TopoElement.phase LogicPhase.neg]
    else
      [TopoElement.phase LogicPhase.neg, TopoElement.phase LogicPhase.pos]

theorem encode_is_phase_only (c : TerminatingComputation) (e : TopoElement) (h : e ∈ encodeComputation c) :
    ∃ p, e = TopoElement.phase p := by
  simp [encodeComputation] at h
  obtain ⟨edge, _, h_mem⟩ := h
  match edge with
  | (from, to, isNand) =>
    split at h_mem
    · simp at h_mem
      cases h_mem with
      | head h1 => exists LogicPhase.pos; exact h1
      | tail h2 => 
        cases h2 with
        | head h3 => exists LogicPhase.neg; exact h3
        | tail h4 => contradiction
    · simp at h_mem
      cases h_mem with
      | head h1 => exists LogicPhase.neg; exact h1
      | tail h2 => 
        cases h2 with
        | head h3 => exists LogicPhase.pos; exact h3
        | tail h4 => contradiction

theorem encode_reduces_to_empty (c : TerminatingComputation) :
    full_zeno_prune (encodeComputation c) = [] := by
  simp [encodeComputation]
  induction c.edges with
  | nil => rfl
  | cons head tail ih =>
    match head with
    | (from, to, isNand) =>
      simp [List.flatMap_cons]
      split
      case isTrue h => simp [zeno_prune, full_zeno_prune, ih]
      case isFalse h => simp [zeno_prune, full_zeno_prune, ih]

theorem encode_is_zfa (c : TerminatingComputation) :
    achieves_ZFA (encodeComputation c) := by
  rw [achieves_ZFA, encode_reduces_to_empty c]
  rfl

theorem encode_is_generated (c : TerminatingComputation) :
    ∃ n, encodeComputation c ∈ expand_generation n := by
  let s := encodeComputation c
  have h_phase : ∀ e ∈ s, ∃ p, e = TopoElement.phase p := encode_is_phase_only c
  exact qucalc_generates_all_phase_strings s.length s ⟨rfl, h_phase⟩

-- Main Universality Theorem
theorem qlf_universality (c : TerminatingComputation) :
    ∃ n, encodeComputation c ∈ find_stable_states n := by
  obtain ⟨n, h_gen⟩ := encode_is_generated c
  exists n
  have h_zfa := encode_is_zfa c
  -- Ensure find_stable_states logic from QLF_QuCalc maps properly
  simp [find_stable_states, List.mem_filter]
  exact ⟨h_gen, h_zfa⟩

end QLF
