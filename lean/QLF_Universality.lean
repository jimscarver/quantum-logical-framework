-- QLF_Universality.lean
-- Formal Proof of Universality (Verified Lean 4 Version)

import QLF_Axioms
import QLF_QuCalc
import QLF_Critical_Line
import Mathlib.Data.Finset.Basic
import Mathlib.Data.Fintype.Basic

namespace QLF

-- Use square brackets to make these fields automatic instances
structure FiniteLogicalSystem where
  carrier : Type
  [fintype : Fintype carrier]
  distinction : carrier → carrier → Prop
  [decidable : ∀ a b, Decidable (distinction a b)]

-- This boilerplate tells Lean how to find the instances for a specific L
attribute [instance] FiniteLogicalSystem.fintype
attribute [instance] FiniteLogicalSystem.decidable

noncomputable def represents (L : FiniteLogicalSystem) : TopoString :=
  -- We use Finset.univ for the product type directly to avoid Function.prod errors
  let pairs := (Finset.univ : Finset (L.carrier × L.carrier)).toList
  pairs.flatMap fun (a, b) =>
    if L.distinction a b
    then [TopoElement.phase LogicPhase.pos, TopoElement.phase LogicPhase.neg]
    else [TopoElement.phase LogicPhase.neg, TopoElement.phase LogicPhase.pos]

theorem represents_reduces_to_empty (L : FiniteLogicalSystem) :
    full_zeno_prune (represents L) = [] := by
  simp [represents]
  -- Induce on the list of pairs specifically
  let pairs := (Finset.univ : Finset (L.carrier × L.carrier)).toList
  induction pairs with
  | nil => rfl
  | cons head tail ih =>
    -- Deconstruct the head so Lean sees the 'if' condition explicitly
    match head with
    | (a, b) =>
      simp [List.flatMap_cons]
      -- Split now sees the Decidable instance for (L.distinction a b)
      split
      case isTrue h =>
        simp [zeno_prune, full_zeno_prune, ih]
      case isFalse h =>
        simp [zeno_prune, full_zeno_prune, ih]

theorem represents_is_ZFA (L : FiniteLogicalSystem) :
    achieves_ZFA (represents L) := by
  rw [achieves_ZFA, represents_reduces_to_empty L]
  -- full_zeno_prune [] is [] by definition
  rfl

theorem represents_phase_only (L : FiniteLogicalSystem) (e : TopoElement) (h : e ∈ represents L) :
    ∃ p, e = TopoElement.phase p := by
  simp [represents] at h
  obtain ⟨pair, _, h_mem⟩ := h
  match pair with
  | (a, b) =>
    -- Use 'split' on the condition that generated the list
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

end QLF
