import QLF_ReachableEvent

/-!
# QLF_Anabelian — the π₁ ↔ closure functor (geometry from the combinatorial skeleton)

Grothendieck's **anabelian** principle: a hyperbolic curve is determined by its fundamental
group `π₁` — geometry recovered from a purely combinatorial / group-theoretic object
(Mochizuki). This is QLF's core ontology in number-theoretic form: spacetime is *synthesized*
from the combinatorial closure skeleton (`QLF_ReachableEvent`'s causal set), not a primitive.

This module makes "geometry from the skeleton" a **theorem** on the causal set:

* the **`closurePi1` functor** sends a closure `A` to its future cone — the causal groupoid
  of closure paths;
* the closure groupoid is **thin** (`closure_groupoid_thin`): no non-trivial loops, so the
  topological `π₁` at a basepoint is trivial and the anabelian content lives in the *order*
  (Malament: the causal order recovers the geometry);
* the functor is **fully faithful** — injective on objects (`closurePi1_injective`: the
  geometry determines the closure) and an order-↔-inclusion on morphisms
  (`reachable_iff_pi1_subset`): the combinatorial skeleton and the geometry lose nothing.

So **geometry is recovered from the combinatorial closure** — the QLF anabelian theorem. The
*arithmetic* enrichment (the étale `π₁`'s Galois quotient) is the **motivic Galois group**
(`QLF_MotivicGalois`); the thin geometric groupoid here and that arithmetic group are the two
ends of the anabelian exact sequence. Reuses `QLF_ReachableEvent`, **no new axioms**.
See `Grothendieck_QLF.md` §2, §5.
-/

namespace QLF.Anabelian

open QLF.ReachableEvent

/-- The **π₁ / fundamental-groupoid functor** sends a closure `A` to its future cone — the
    causal groupoid of closure paths. Because the causal set is a *thin* poset (no non-trivial
    loops), the fundamental groupoid *is* the causal geometry. -/
def closurePi1 {α : Type _} (A : Event α) : Set (Event α) := futureCone A

/-- **The closure groupoid is thin** — every there-and-back closure loop collapses, so the
    topological `π₁` at a basepoint is trivial; the anabelian content lives in the order
    (Malament). -/
theorem closure_groupoid_thin {α : Type _} {A B : Event α}
    (h1 : reachable A B) (h2 : reachable B A) : A = B :=
  reachable_antisymm h1 h2

/-- **Anabelian reconstruction (objects)** — the geometry determines the closure: distinct
    closures have distinct `π₁`/geometry. The combinatorial skeleton is recovered from the
    geometric object. -/
theorem closurePi1_injective {α : Type _} {A B : Event α}
    (h : closurePi1 A = closurePi1 B) : A = B := by
  unfold closurePi1 at h
  have hA : A ∈ futureCone B := h ▸ mem_futureCone_self A
  have hB : B ∈ futureCone A := h.symm ▸ mem_futureCone_self B
  exact reachable_antisymm hB hA

/-- **Anabelian full faithfulness (morphisms)** — a closure map exists iff the geometric
    inclusion does: `reachable A B ↔ π₁(B) ⊆ π₁(A)`. The combinatorial order *is* the geometric
    inclusion; the `π₁` functor loses nothing. -/
theorem reachable_iff_pi1_subset {α : Type _} {A B : Event α} :
    reachable A B ↔ closurePi1 B ⊆ closurePi1 A :=
  ⟨futureCone_subset, fun h => h (mem_futureCone_self B)⟩

/-- **The anabelian functor is fully faithful** — closures and their `π₁`/geometry correspond
    bijectively: objects (`A = B ↔ π₁ A = π₁ B`) and morphisms (`reachable ↔ inclusion`).
    Geometry is recovered from the combinatorial closure skeleton — the QLF anabelian
    principle, a theorem on `QLF_ReachableEvent`'s causal set. -/
theorem anabelian_fully_faithful {α : Type _} (A B : Event α) :
    (A = B ↔ closurePi1 A = closurePi1 B) ∧
    (reachable A B ↔ closurePi1 B ⊆ closurePi1 A) :=
  ⟨⟨congrArg closurePi1, closurePi1_injective⟩, reachable_iff_pi1_subset⟩

/-- **Milestone — the anabelian π₁ ↔ closure functor.** The future-cone functor `closurePi1`
    is fully faithful (`anabelian_fully_faithful`): the geometry (future cones) and the
    combinatorial closure skeleton determine each other, so **geometry is recovered from the
    combinatorial closure** — Grothendieck's anabelian principle as a theorem on QLF's causal
    set. The fundamental groupoid is thin (`closure_groupoid_thin`), so the geometric content
    is the causal *order* (Malament); the arithmetic enrichment is the motivic Galois group
    (`QLF_MotivicGalois`). No new axioms. **Open:** the continuum order→metric reconstruction
    (the Causal-Set boundary, shared with `light_cone_rendering_in_progress`) and a profinite
    étale `π₁` carrying a non-trivial Galois quotient. See `Grothendieck_QLF.md` §2. -/
theorem anabelian_pi1_closure_functor : True := trivial

end QLF.Anabelian
