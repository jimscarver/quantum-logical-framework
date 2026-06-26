# The order → metric reconstruction — *Order + Number = Geometry*

In the [Quantum Logical Framework](README.md) (QLF), spacetime is **synthesized**: the substrate is a
bare **causal order** (the reachability partial order on closure histories,
[`QLF_ReachableEvent`](lean/QLF_ReachableEvent.lean)), with no metric, no coordinates, no light cone as a
primitive. The named frontier — the one open step behind "3-D space is the shadow of the substrate"
([`Geometry_Of_Space.md`](Geometry_Of_Space.md) §7) and the Einstein curvature side
([`Einstein_Equations.md`](Einstein_Equations.md) §6a) — is the **order → metric reconstruction**: how
that bare order yields the smooth Lorentzian metric.

It is not a vague gap. It is the Causal-Set-Theory program's own hard step, and it has a precise classical
decomposition — Rafael Sorkin's slogan:

> **Order + Number = Geometry.**

The metric splits into two halves, and QLF supplies both at the discrete level, leaving exactly **one**
continuum bridge. The Lean anchor is [`lean/QLF_OrderMetric.lean`](lean/QLF_OrderMetric.lean) (reuse-only;
one named bridge axiom).

## Order → the conformal (causal) structure

**Malament's theorem** (David Malament 1977; Hawking–King–McCarthy 1976): the causal order of a spacetime
determines its metric **up to a conformal factor**. The light-cone structure — *which* events can
influence which — *is* the order; all the metric leaves undetermined, given the order, is a single local
scale.

On the substrate that order is `reachable` (history-extension), and it is a genuine **partial order** —
reflexive, transitive, antisymmetric (`conformal_structure_is_the_order`, reusing `reachable_refl` /
`reachable_trans` / `reachable_antisymm`). So the substrate carries the conformal / light-cone structure
*already*, with no metric assumed. This is the **"Order" half**, machine-verified.

## Number → the conformal factor (volume / proper time)

The one thing the order omits — the local scale — is supplied by **counting**, CST's *number ↔ volume*
principle: the number of events in a causal interval measures its spacetime volume. On the substrate
`intervalVolume A B = |B| − |A| + 1` ([`QLF_CausalInterval`](lean/QLF_CausalInterval.lean)), and the
timelike **proper time** is the order-link count `properTime A B = |B| − |A|` — equal to
`intervalVolume − 1` (`properTime_succ_eq_volume`) and **additive along the order**
(`properTime_additive`: `A ≤ B ≤ C ⟹ τ(A,C) = τ(A,B) + τ(B,C)`). That additivity is the discrete **line
element** — proper time read straight from the order + count. This is the **"Number" half**,
machine-verified.

## The rest of the metric data — also anchored

- **Dimension** — recovered from how histories combine (1-D chain → 2-D causal diamond, the Myrheim–Meyer
  ordering fraction), [`QLF_CausalDimension`](lean/QLF_CausalDimension.lean).
- **Curvature** — the Benincasa–Dowker operator: flat baseline `R = 0` on a chain
  (`bdCurvature_chain_zero`), curvature as the growth of causal layers, with its own continuum bridge
  `benincasa_dowker_limit` ([`QLF_CausalContinuum`](lean/QLF_CausalContinuum.lean)).

## The one continuum bridge

What remains is the **continuum limit**: assembling conformal structure + volume + dimension + curvature
into the smooth Lorentzian metric as the causal set is refined (Bombelli–Henson–Sorkin *sprinkling*,
intensity `ρ → ∞`). This is settled CST reconstruction mathematics that Mathlib does not carry assembled,
so it enters as the explicit boundary axiom **`order_metric_continuum_limit`**: the `ρ → ∞` reconstruction
of the proper-time line element from order + number converges to the continuum value. It is exactly
parallel to the curvature-side `benincasa_dowker_limit`, and to `yang_mills_continuum_gap` /
`navier_stokes_continuum_limit` — QLF's standard *RCA₀ → analytic* boundary marker.

## The Millennium shape

So the order → metric reconstruction now has the same shape as every other hard problem in QLF: a
**verified discrete core** + **one named continuum bridge**.

| Piece | Status |
|---|---|
| Conformal/causal structure = the order (Malament's "Order") | ✅ Lean (`conformal_structure_is_the_order`) |
| Proper time / volume from the count, additive (Sorkin's "Number") | ✅ Lean (`properTime_additive`, `properTime_succ_eq_volume`) |
| Dimension from combining histories (Myrheim–Meyer) | ✅ Lean (`QLF_CausalDimension`) |
| Curvature: flat baseline + layer growth | ✅ Lean (`bdCurvature_chain_zero`, `layer_growth_from_branching`) |
| Curvature continuum limit (`□ − ½R`) | bridge axiom `benincasa_dowker_limit` |
| **Metric continuum limit (order + number → line element)** | **bridge axiom `order_metric_continuum_limit`** |

## Honest scope

This **reduces** the formerly-opaque "order→metric is in progress" (`light_cone_rendering_in_progress`,
`einstein_curvature_in_progress`) to the verified-core-plus-one-bridge shape; it does **not** prove the
continuum reconstruction — that is the cited CST result (Malament + Bombelli–Henson–Sorkin +
Myrheim–Meyer), held as the explicit boundary axiom. The substrate's `reachable` is the clean
history-extension (prefix) order; binding it to the full `full_zeno_prune` branching dynamics, and
carrying the reconstruction through the *branching* graph (where curvature and the spatial dimensions
live), are the continuing CST program on QLF's own closure graph. No new axioms beyond the one named
bridge.

## See also

- [`Geometry_Of_Space.md`](Geometry_Of_Space.md) §7 — the geometry external to 3-D (this is the open step
  it names).
- [`Einstein_Equations.md`](Einstein_Equations.md) §6a — the Einstein curvature side (the BD program).
- [`SpaceTime.md`](SpaceTime.md), [`TheContinuum.md`](TheContinuum.md) — synthesized spacetime; the
  continuum as rendering.
- [`lean/QLF_ReachableEvent.lean`](lean/QLF_ReachableEvent.lean),
  [`lean/QLF_CausalInterval.lean`](lean/QLF_CausalInterval.lean),
  [`lean/QLF_CausalDimension.lean`](lean/QLF_CausalDimension.lean),
  [`lean/QLF_CausalContinuum.lean`](lean/QLF_CausalContinuum.lean).
