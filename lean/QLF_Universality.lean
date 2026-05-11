-- QLF_Universality.lean
-- Formal Proof of Universality (fixed Fintype + noncomputable + reduction)

import QLF_Axioms
import QLF_QuCalc
import QLF_Critical_Line
import Mathlib.Data.Finset.Basic
import Mathlib.Data.Fintype.Basic

namespace QLF

structure FiniteLogicalSystem where
  carrier : Type
  [fintype : Fintype carrier]
  distinction : carrier → carrier → Prop
  [decidable : ∀ a b, Decidable (distinction a b)]

-- Explicit Fintype instance for the product (this fixes the type mismatch)
instance (L : FiniteLogicalSystem) : Fintype (L.carrier × L.carrier) :=
  Fintype.prod L.fintype L.fintype

noncomputable def represents (L : FiniteLogicalSystem) : TopoString :=
  (Finset.univ : Finset (L.carrier × L.carrier)).toList.flatMap fun (a, b) =>
    if L.distinction a b
    then [TopoElement.phase LogicPhase.pos, TopoElement.phase LogicPhase.neg]
    else [TopoElement.phase LogicPhase.neg, TopoElement.phase LogicPhase.pos]

theorem represents_reduces_to_empty (L : FiniteLogicalSystem) :
    full_zeno_prune (represents L) = [] := by
  simp [represents]
  induction (Finset.univ : Finset (L.carrier × L.carrier)).toList with
  | nil => rfl
  | cons _ tail ih =>
    simp [List.flatMap_cons]
    split <;> simp [zeno_prune, full_zeno_prune]; rw [ih]

theorem represents_is_ZFA (L : FiniteLogicalSystem) :
    achieves_ZFA (represents L) := by
  rw [achieves_ZFA, represents_reduces_to_empty L]; simp

theorem represents_phase_only (L : FiniteLogicalSystem) (e : TopoElement) (h : e ∈ represents L) :
    ∃ p, e = TopoElement.phase p := by
  simp [represents] at h
  obtain ⟨pair, _, h_mem⟩ := h
  simp [List.flatMap] at h_mem
  split at h_mem <;> simp_all [h_mem]

-- (the rest of your original theorems can stay unchanged from here)

end QLF
