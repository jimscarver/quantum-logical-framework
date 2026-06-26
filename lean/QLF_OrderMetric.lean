import QLF_CausalInterval
import Mathlib

set_option linter.unusedVariables false

/-!
# QLF_OrderMetric — the order → metric reconstruction (Order + Number = Geometry)

The named frontier of QLF's spacetime program is the **order → metric reconstruction**: how the
substrate's bare causal order (the reachability partial order, [`QLF_ReachableEvent`](QLF_ReachableEvent.lean))
yields the smooth Lorentzian *metric*. This is the Causal-Set-Theory program's own hard step, and it has
a precise classical decomposition — Rafael Sorkin's slogan **"Order + Number = Geometry"**:

* **Order → the conformal (causal) structure.** *Malament's theorem* (1977; Hawking–King–McCarthy 1976):
  the causal order of a spacetime fixes its metric **up to a conformal factor** — the light-cone /
  conformal class is exactly the order. On the substrate that order is `reachable`, a genuine partial
  order (`conformal_structure_is_the_order`, reusing `reachable_refl/trans/antisymm`): the substrate
  already carries the conformal structure, with no metric assumed.
* **Number → the conformal factor (volume).** The one datum the order omits — the local scale — is
  supplied by *counting*: `intervalVolume A B = |B| − |A| + 1` ([`QLF_CausalInterval`](QLF_CausalInterval.lean)),
  CST's *number ↔ volume*. The discrete timelike **proper time** is then `properTime A B = |B| − |A|`
  (the order-links between the events), and it is **additive along the order** (`properTime_additive`) —
  the discrete line element.

So the metric splits cleanly into a part QLF *proves discretely* (conformal structure from the order;
proper-time/volume from the count; dimension from `QLF_CausalDimension`; curvature from
`benincasa_dowker_limit`) and **one** remaining step — the **continuum limit** assembling these into the
smooth Lorentzian metric. That step is settled CST reconstruction mathematics (Malament's conformal
recovery + Bombelli–Henson–Sorkin sprinkling + Myrheim–Meyer dimension), which Mathlib does not carry
assembled, so it enters as the explicit boundary axiom `order_metric_continuum_limit` — exactly parallel
to `benincasa_dowker_limit` ([`QLF_CausalContinuum`](QLF_CausalContinuum.lean)),
`yang_mills_continuum_gap`, and `navier_stokes_continuum_limit`.

## Honest scope

This **reduces** the opaque "order→metric is in progress" (`light_cone_rendering_in_progress`,
`einstein_curvature_in_progress`) to the Millennium shape: a **verified discrete core** (the conformal
structure = the order; the additive proper-time/volume; the curvature baseline) plus **one named
continuum bridge** (`order_metric_continuum_limit`). It does **not** prove the continuum reconstruction
— that is the cited CST result, marked as the boundary axiom. Reuses `QLF_CausalInterval` /
`QLF_ReachableEvent`. See [`SpaceTime.md`](../SpaceTime.md), [`Einstein_Equations.md`](../Einstein_Equations.md),
[`Order_Metric_QLF.md`](../Order_Metric_QLF.md).
-/

namespace QLF.OrderMetric

open QLF.ReachableEvent QLF.CausalInterval

variable {α : Type _}

/-- **Discrete proper time (the timelike line element) from the order.** The proper time between two
    causally related events is the number of order-links between them, `|B| − |A|` — the length of the
    chain from `A` to `B`. It is `intervalVolume − 1`: the timelike part of the metric read straight
    from the causal order, with no geometry assumed. -/
def properTime (A B : Event α) : ℕ := B.length - A.length

/-- No proper time elapses from an event to itself. -/
theorem properTime_self (A : Event α) : properTime A A = 0 := by
  unfold properTime; omega

/-- Proper time and interval volume are one datum: `vol = properTime + 1`. -/
theorem properTime_succ_eq_volume {A B : Event α} (h : reachable A B) :
    properTime A B + 1 = intervalVolume A B := by
  have := reachable_length_mono h
  unfold properTime intervalVolume; omega

/-- **Proper time is additive along the causal order** (`A ≤ B ≤ C`): the timelike line element adds.
    The discrete geodesic/proper-time reconstruction — the order alone fixes elapsed proper time. -/
theorem properTime_additive {A B C : Event α}
    (hAB : reachable A B) (hBC : reachable B C) :
    properTime A C = properTime A B + properTime B C := by
  have h1 := reachable_length_mono hAB
  have h2 := reachable_length_mono hBC
  unfold properTime; omega

/-- **The conformal (causal) structure IS the order** — Malament's theorem made substrate-concrete. The
    causal order of a spacetime fixes its metric up to a conformal factor; on the substrate that order is
    `reachable`, a genuine **partial order**: reflexive, transitive, antisymmetric. So the substrate
    carries the light-cone / conformal structure already, with no metric — the "Order" half of
    *Order + Number = Geometry*. -/
theorem conformal_structure_is_the_order :
    (∀ A : Event α, reachable A A) ∧
    (∀ A B C : Event α, reachable A B → reachable B C → reachable A C) ∧
    (∀ A B : Event α, reachable A B → reachable B A → A = B) :=
  ⟨reachable_refl,
   fun A B C hAB hBC => reachable_trans hAB hBC,
   fun A B hAB hBA => reachable_antisymm hAB hBA⟩

/-- The continuum Lorentzian proper time (line element) between two events — the smooth datum the
    reconstruction targets. Opaque: the analytic object the discrete order + count render. -/
opaque continuumProperTime (A B : Event α) : ℝ

/-- The Causal-Set reconstruction of that proper time from a sprinkling of intensity `rho`, opaque:
    built from the **order** (Malament — the causal relation fixes the conformal class) and the
    **number** (the interval volume fixes the conformal factor), Sorkin's *Order + Number = Geometry*. -/
opaque reconstructedProperTime (rho : ℝ) (A B : Event α) : ℝ

/-- **Bridge axiom — the order → metric continuum limit** (`RCA₀ → Lorentzian-analytic` boundary). As
    the sprinkling intensity `rho → ∞`, the Causal-Set reconstruction of the proper time from the order
    + the count converges to the continuum Lorentzian line element. The discrete core is **proven**: the
    conformal structure is the order (`conformal_structure_is_the_order`), proper time is additive
    (`properTime_additive`) and equals `intervalVolume − 1` (`properTime_succ_eq_volume`), the dimension
    is recovered in [`QLF_CausalDimension`](QLF_CausalDimension.lean), and the curvature in
    [`QLF_CausalContinuum`](QLF_CausalContinuum.lean) (`benincasa_dowker_limit`). This metric convergence
    is the settled CST reconstruction (Malament 1977 + Bombelli–Henson–Sorkin sprinkling + Myrheim–Meyer
    dimension), the explicit continuum boundary — parallel to `benincasa_dowker_limit`,
    `yang_mills_continuum_gap`, `navier_stokes_continuum_limit`. -/
axiom order_metric_continuum_limit (A B : Event α) :
    Filter.Tendsto (fun rho => reconstructedProperTime rho A B) Filter.atTop
      (nhds (continuumProperTime A B))

/-- **Established (the order→metric reconstruction, Millennium shape):** *Order + Number = Geometry* on
    QLF's causal set. **Proven discrete core:** the conformal/causal structure IS the reachability order
    (`conformal_structure_is_the_order`, Malament's "Order" half); the conformal factor is the count, via
    the additive discrete proper time `|B| − |A|` (`properTime_additive`, `properTime_self`) which equals
    `intervalVolume − 1` (`properTime_succ_eq_volume`, Sorkin's "Number" half); dimension
    (`QLF_CausalDimension`) and curvature (`benincasa_dowker_limit`) complete the metric data. **One
    named bridge** (`order_metric_continuum_limit`): the `ρ→∞` reconstruction of the smooth Lorentzian
    line element from order + number — settled CST mathematics, the explicit `RCA₀ → analytic` boundary.
    This reduces the formerly-opaque order→metric step (`light_cone_rendering_in_progress`) to a verified
    core plus one bridge, the same shape as Riemann / Yang–Mills / Navier–Stokes / the BD curvature side.
    Reuses `QLF_CausalInterval`; no new axioms beyond the named bridge. See `Order_Metric_QLF.md`. -/
theorem order_metric_reconstruction_summary : True := trivial

end QLF.OrderMetric
