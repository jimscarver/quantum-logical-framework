-- QLF_Universality.lean
-- Universality: QLF generates all terminating finitely-encoded logical computations

import QLF_Axioms
import QLF_QuCalc
import QLF_Critical_Line

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

theorem encode_is_phase_only (c : TerminatingComputation) :
    ∀ e ∈ encodeComputation c, ∃ p, e = TopoElement.phase p := by
  intro e h
  simp [encodeComputation] at h
  obtain ⟨edge, _, h_mem⟩ := h
  simp [List.flatMap] at h_mem
  split at h_mem <;> simp_all [h_mem]

theorem encode_reduces_to_empty (c : TerminatingComputation) :
    full_zeno_prune (encodeComputation c) = [] := by
  simp [encodeComputation]
  induction c.edges with
  | nil => rfl
  | cons _ tail ih =>
    simp [List.flatMap_cons]
    split <;> simp [zeno_prune, full_zeno_prune]; rw [ih]

theorem encode_is_zfa (c : TerminatingComputation) :
    achieves_ZFA (encodeComputation c) := by
  rw [achieves_ZFA, encode_reduces_to_empty c]; simp

theorem encode_is_generated (c : TerminatingComputation) :
    ∃ n, encodeComputation c ∈ expand_generation n := by
  let s := encodeComputation c
  have h_phase := encode_is_phase_only c
  exact qucalc_generates_all_phase_strings s.length s ⟨rfl, h_phase⟩

theorem qlf_universality (c : TerminatingComputation) :
    ∃ n, encodeComputation c ∈ find_stable_states n := by
  have ⟨n, h_gen⟩ := encode_is_generated c
  have h_zfa := encode_is_zfa c
  have h_bool : achieves_ZFA_bool (encodeComputation c) = true := by simp [achieves_ZFA_bool, h_zfa]
  simp [find_stable_states, List.mem_filter, h_gen, h_bool]
  exact h_zfa

end QLF
