import Mathlib.Data.List.Infix

set_option linter.unusedVariables false

/-!
# QLF_ReachableEvent — closure-reachability as a pre-geometric Lean object (issues #63, #72)

The desired stack (issue #46) is `possibilities → ZFA pruning → closure-reachable relations →
observer availability → continuum rendering as light cone / causal diamond`. The missing piece was a
**substrate-level reachable-event object that does not depend on spacetime geometry** (no light
cone, no metric, no causal diamond as a primitive). This module supplies it.

* **An event is a finite ZFA history** — `Event α = List α`, a list of closure steps. No coordinates,
  no manifold: an event *before* any geometric rendering.
* **Closure-reachability is history-extension.** `reachable A B` iff `B`'s history extends `A`'s
  (`A <+: B`, `A` is a prefix of `B`) — i.e. `A` lies in `B`'s past. This is defined purely
  combinatorially: nothing geometric is assumed.
* **It is a partial order** — reflexive (`reachable_refl`), transitive (`reachable_trans`),
  antisymmetric (`reachable_antisymm`). That is exactly a **causal set** (Bombelli–Sorkin, in QLF's
  convergence table): the causal order with no metric.
* **The light cone is the rendering.** The future of `A` is its reachable set `futureCone A =
  {B | reachable A B}`, defined with no geometry; the continuum **light cone / causal diamond is the
  spacetime rendering** of this set, not a primitive.

**Answering #72 ("what drives closure-event succession *before* time?").** The driver is exactly
`reachable` — the history-extension partial order — which exists with **no time coordinate**. A
closure `B` succeeds `A` iff `B` is reachable from `A`; *time* is the rendered total-order read-out of
this pre-geometric partial order (the same "everything is a clock, time is local" picture as
[`Time.md`](../Time.md), [`Kitada_Local_Time_GR.md`](../Kitada_Local_Time_GR.md)). Succession does not
need time; time needs succession.

## Honest scope

This anchors the **pre-geometric reachable-event relation and its partial-order (causal-set)
structure**, and names the light cone as its rendering — reusing nothing geometric. It does **not**
construct the continuum light-cone metric from the discrete order (the order→metric reconstruction is
the Causal-Set-Theory program's own hard step, the continuum-rendering boundary,
`light_cone_rendering_in_progress`), nor does it tie `reachable` to the full ZFA pruning dynamics
(here reachability is the clean history-extension model; binding it to `full_zeno_prune` step-rules is
the next refinement). See [`SpaceTime.md`](../SpaceTime.md), [`TheContinuum.md`](../TheContinuum.md),
[`Open_Problems.md`](../Open_Problems.md) (#46).
-/

namespace QLF.ReachableEvent

/-- A **substrate event** is a finite ZFA history — a list of closure steps. No spacetime, no
    coordinates: an event before any geometric rendering. -/
abbrev Event (α : Type _) := List α

/-- **Closure-reachability** (pre-geometric). `B` is reachable from `A` iff `B`'s history *extends*
    `A`'s — `A` is a prefix of `B`. Defined purely by history-extension: no light cone, no metric,
    no causal diamond as a primitive. -/
def reachable {α : Type _} (A B : Event α) : Prop := A <+: B

/-- An event is reachable from itself (reflexive). -/
theorem reachable_refl {α : Type _} (A : Event α) : reachable A A :=
  List.prefix_refl A

/-- Reachability composes (transitive) — the order that drives event succession. -/
theorem reachable_trans {α : Type _} {A B C : Event α}
    (hAB : reachable A B) (hBC : reachable B C) : reachable A C :=
  List.IsPrefix.trans hAB hBC

/-- Reachability is antisymmetric ⇒ a genuine **partial order** (a causal set, Bombelli–Sorkin):
    the causal order, pre-temporal — it exists with no time coordinate. -/
theorem reachable_antisymm {α : Type _} {A B : Event α}
    (hAB : reachable A B) (hBA : reachable B A) : A = B := by
  have h1 : A.length ≤ B.length := hAB.sublist.length_le
  have h2 : B.length ≤ A.length := hBA.sublist.length_le
  exact hAB.eq_of_length (le_antisymm h1 h2)

/-- **The future cone is the rendering target.** The future of an event `A` is its reachable set;
    the continuum light cone / causal diamond is the spacetime *rendering* of this set. -/
def futureCone {α : Type _} (A : Event α) : Set (Event α) := { B | reachable A B }

/-- An event sits at the apex of its own future cone. -/
theorem mem_futureCone_self {α : Type _} (A : Event α) : A ∈ futureCone A :=
  reachable_refl A

/-- Future cones nest along reachability: if `B` is reachable from `A`, then everything in `B`'s
    future is in `A`'s future — the cones compose exactly as causal order requires. -/
theorem futureCone_subset {α : Type _} {A B : Event α} (hAB : reachable A B) :
    futureCone B ⊆ futureCone A :=
  fun _ hC => reachable_trans hAB hC

/-- **Established constructively (#63, #72):** closure-reachability is a *pre-geometric* relation —
    `reachable A B := A <+: B`, defined with no spacetime — and it is a **partial order / causal set**
    (`reachable_refl`, `reachable_trans`, `reachable_antisymm`), with the light cone named as its
    rendering (`futureCone`, `futureCone_subset`). This *is* the driver of closure-event succession
    "before time" (#72): the order exists with no time coordinate; time is its rendered read-out.
    **Open:** reconstructing the continuum light-cone *metric* from the discrete order (the
    Causal-Set order→metric step, the continuum boundary) and binding `reachable` to the full
    `full_zeno_prune` dynamics (`light_cone_rendering_in_progress`). -/
theorem light_cone_rendering_in_progress : True := trivial

end QLF.ReachableEvent
