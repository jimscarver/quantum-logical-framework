import Mathlib

/-!
# QLF_Reconstruction — the reconstruction theorem, entropy-uniqueness wing (finite lattice)

The **reconstruction theorem** ([`Completeness_Evidence.md`](../Completeness_Evidence.md) §6) is the
missing converse to `qlf_universality`: from ZFA-free postulates — orthomodularity of the event
lattice, finite information capacity, closure-as-receipt, reversibility, no-disconnection — prove any
event structure satisfying them is isomorphic to ZFA over the 8-twist alphabet. It is the **only**
route from "exclusivity conjectured" to "exclusivity conditionally proven," and every completeness
claim currently leans on its absence.

This module lands the **tractable entropy-uniqueness wing on the closure lattice**: a measure additive
over *orthogonal* decompositions of the finite event lattice is **determined by its atom values**
(`measure_eq_sum_atoms`), and two such measures agreeing on atoms agree everywhere (`measure_unique`) —
the consistent information measure on the lattice is unique. This is the lattice/orthogonality
counterpart of the free-monoid additive uniqueness ([`QLF_EntropyUniqueness`](QLF_EntropyUniqueness.lean));
together they are the reconstruction program's *uniqueness* half, now with a Lean object on the lattice.

**Honest scope.** Orthogonality here is *disjointness* — the finite **Boolean** shadow of Gleason.
The genuinely Gleason-hard content — a measure additive on a *non-distributive orthomodular* lattice
(the quantum case, dim ≥ 3) being *forced* to `Tr(ρ · )` — is the open target, as is the full
postulates→ZFA isomorphism. This is the first *assembled Lean* rung of the reconstruction's uniqueness
wing, not the theorem. Reuses only Mathlib; no axioms.
-/

namespace QLF.Reconstruction

variable {α : Type*} [DecidableEq α]

/-- A **measure** on the finite event lattice: additive over *orthogonal* (disjoint) events —
    `μ(s ∪ t) = μ s + μ t` when `s ⟂ t`. The finite Boolean orthogonality of the closure lattice. -/
def IsMeasure (μ : Finset α → ℝ) : Prop :=
  ∀ s t : Finset α, Disjoint s t → μ (s ∪ t) = μ s + μ t

/-- The empty event carries measure `0` — forced by additivity (`μ ∅ = μ ∅ + μ ∅`). -/
theorem measure_empty (μ : Finset α → ℝ) (h : IsMeasure μ) : μ ∅ = 0 := by
  have h0 := h ∅ ∅ (by simp)
  simp only [Finset.union_empty] at h0
  linarith

/-- **Atom-determination (the Gleason-style move, finite Boolean case).** A measure additive over
    orthogonal decompositions is fixed by its values on the atoms: `μ s = Σ_{a ∈ s} μ {a}`. -/
theorem measure_eq_sum_atoms (μ : Finset α → ℝ) (h : IsMeasure μ) (s : Finset α) :
    μ s = ∑ a ∈ s, μ {a} := by
  induction s using Finset.induction with
  | empty => simp [measure_empty μ h]
  | @insert a s ha ih =>
    rw [Finset.sum_insert ha, ← ih, Finset.insert_eq,
        h {a} s (Finset.disjoint_singleton_left.mpr ha)]

/-- **Uniqueness.** Two measures additive over orthogonal decompositions that agree on every atom
    agree on every event — the consistent information measure on the closure lattice is unique. -/
theorem measure_unique (μ ν : Finset α → ℝ) (hμ : IsMeasure μ) (hν : IsMeasure ν)
    (hatoms : ∀ a : α, μ {a} = ν {a}) (s : Finset α) : μ s = ν s := by
  rw [measure_eq_sum_atoms μ hμ, measure_eq_sum_atoms ν hν]
  exact Finset.sum_congr rfl (fun a _ => hatoms a)

/-- Summary: on the finite closure lattice, additivity over orthogonal decompositions forces the
    measure to be atom-determined (`measure_eq_sum_atoms`) and unique from its atom values
    (`measure_unique`) — the entropy-uniqueness wing of the reconstruction theorem, finite/Boolean
    case. Open: the non-distributive orthomodular (Gleason) case, and the postulates→ZFA isomorphism
    (`Completeness_Evidence.md` §6). -/
theorem reconstruction_entropy_wing : True := trivial

end QLF.Reconstruction
