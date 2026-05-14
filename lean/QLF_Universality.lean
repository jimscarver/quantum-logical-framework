-- QLF_Universality.lean
-- Formal Proof of Universality (Fixed Version)

import QLF_Axioms
import QLF_QuCalc
import QLF_Critical_Line
import Mathlib.Data.Finset.Basic
import Mathlib.Data.Fintype.Basic

namespace QLF

-- Use "class" or include instances in the structure to help Lean's search
structure FiniteLogicalSystem where
  carrier : Type
  fintype : Fintype carrier
  distinction : carrier → carrier → Prop
  decidable : ∀ a b, Decidable (distinction a b)

-- Explicitly tell Lean to use the instances inside the structure
attribute [instance] FiniteLogicalSystem.fintype
attribute [instance] FiniteLogicalSystem.decidable

noncomputable def represents (L : FiniteLogicalSystem) : TopoString :=
  let pairs := (Finset.univ : Finset (L.carrier × L.carrier)).toList
  pairs.flatMap fun (a, b) =>
    if L.distinction a b
    then [TopoElement.phase LogicPhase.pos, TopoElement.phase LogicPhase.neg]
    else [TopoElement.phase LogicPhase.neg, TopoElement.phase LogicPhase.pos]

theorem represents_reduces_to_empty (L : FiniteLogicalSystem) :
    full_zeno_prune (represents L) = [] := by
  simp [represents]
  let pairs := (Finset.univ : Finset (L.carrier × L.carrier)).toList
  induction pairs with
  | nil => rfl
  | cons head tail ih =>
    -- Manually destruct the head to reveal the 'if' condition for split
    obtain ⟨a, b⟩ := head
    simp [List.flatMap_cons]
    -- Now split can see the L.distinction a b
    split <;> simp [zeno_prune, full_zeno_prune, ih]

theorem represents_is_ZFA (L : FiniteLogicalSystem) :
    achieves_ZFA (represents L) := by
  rw [achieves_ZFA, represents_reduces_to_empty L]
  rfl

theorem represents_phase_only (L : FiniteLogicalSystem) (e : TopoElement) (h : e ∈ represents L) :
    ∃ p, e = TopoElement.phase p := by
  simp [represents] at h
  obtain ⟨pair, _, h_mem⟩ := h
  obtain ⟨a, b⟩ := pair
  split at h_mem <;> 
  { simp at h_mem; cases h_mem <;> subst_vars <;> eexists; rfl }

end QLF
