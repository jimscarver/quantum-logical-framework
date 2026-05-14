-- QLF_Universality.lean
-- Formal Proof of Universality (Fixed Version)

import QLF_Axioms
import QLF_QuCalc
import QLF_Critical_Line
import Mathlib.Data.Finset.Basic
import Mathlib.Data.Fintype.Basic

namespace QLF

structure FiniteLogicalSystem where
  carrier : Type
  fintype_inst : Fintype carrier
  distinction : carrier → carrier → Prop
  decidable_inst : ∀ a b, Decidable (distinction a b)

-- These helper instances allow Lean to "see" inside your structure during proofs
instance (L : FiniteLogicalSystem) : Fintype L.carrier := L.fintype_inst
instance (L : FiniteLogicalSystem) (a b : L.carrier) : Decidable (L.distinction a b) := L.decidable_inst a b

noncomputable def represents (L : FiniteLogicalSystem) : TopoString :=
  -- Explicitly help Lean build the product list
  let pairs : List (L.carrier × L.carrier) := (Finset.univ : Finset (L.carrier × L.carrier)).toList
  pairs.flatMap fun (a, b) =>
    if L.distinction a b
    then [TopoElement.phase LogicPhase.pos, TopoElement.phase LogicPhase.neg]
    else [TopoElement.phase LogicPhase.neg, TopoElement.phase LogicPhase.pos]

theorem represents_reduces_to_empty (L : FiniteLogicalSystem) :
    full_zeno_prune (represents L) = [] := by
  -- We unfold the definition and the list of pairs
  simp [represents]
  let pairs := (Finset.univ : Finset (L.carrier × L.carrier)).toList
  induction pairs with
  | nil => 
    simp [full_zeno_prune]
    rfl
  | cons head tail ih =>
    -- Deconstruct the pair so 'split' can find the Decidable instance
    match head with
    | (a, b) =>
      simp [List.flatMap_cons]
      -- split now finds Decidable (L.distinction a b) via the instance we defined above
      split <;> simp [zeno_prune, full_zeno_prune, ih]

theorem represents_is_ZFA (L : FiniteLogicalSystem) :
    achieves_ZFA (represents L) := by
  rw [achieves_ZFA, represents_reduces_to_empty L]
  simp [full_zeno_prune]

theorem represents_phase_only (L : FiniteLogicalSystem) (e : TopoElement) (h : e ∈ represents L) :
    ∃ p, e = TopoElement.phase p := by
  simp [represents] at h
  obtain ⟨pair, _, h_mem⟩ := h
  match pair with
  | (a, b) =>
    split at h_mem <;> 
    { simp at h_mem; cases h_mem <;> subst_vars <;> eexists; rfl }

end QLF
