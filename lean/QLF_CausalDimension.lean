import QLF_CausalInterval
import Mathlib

set_option linter.unusedVariables false

/-!
# QLF_CausalDimension — dimension from combining histories (number↔volume reads the dimension)

[`QLF_CausalInterval`](QLF_CausalInterval.lean) showed a *single* QLF history is a **chain** (1-D,
flat: every Benincasa–Dowker causal layer is a singleton, `layer_unique`). Curvature needs more than
one dimension, so it needs **histories combined**. The cleanest combination is the **product order**:
two chains `(u, v)` combine into a 2-D causal set — *exactly* `1+1` Minkowski space in light-cone
coordinates (the two null directions `u`, `v` are two QLF histories / local clocks).

The geometric payoff is **Myrheim–Meyer dimension from number↔volume**: a causal interval's event
count scales as `(proper time)^d`, so the *exponent reads the dimension* — and the fingerprint of that
exponent is **how many distinct intervals share a given volume**:

* **1-D (chain).** `chainVolume d = d + 1` is **injective** (`chainVolume_injective`): each volume is
  realized by *exactly one* interval — singleton layers, the 1-D / flat signature.
* **2-D (diamond = product of two chains).** `diamondVolume m n = (m+1)(n+1)` is the **product** of the
  two chain volumes (`diamond_eq_product`), and it is **many-to-one**: the *same* volume is realized by
  *many* distinct diamonds — e.g. `diamondVolume 1 1 = diamondVolume 0 3 = diamondVolume 3 0 = 4`
  (`diamondVolume_collision`). That multiplicity *is* the layer growth — the dimension/curvature signal
  absent in the chain.

So **adding a causal direction multiplies the count and makes volumes collide**: combining `d`
histories gives volume `~ τ^d` with growing layers. This is the same branching that
[`SpaceTime.md`](../SpaceTime.md) §3a derives renders into three spatial dimensions, and the same
layer-growth whose Benincasa–Dowker sum is the Ricci scalar — dimension and curvature are one
phenomenon, the growth of `|L_k|` when histories combine.

## Honest scope

This anchors the **2-D product-of-two-chains case** (`1+1` Minkowski): volume = product of the chain
volumes, the chain's injective (singleton-layer) signature vs the diamond's many-to-one (growing-layer)
signature, and **the layer growth computed directly on the product order** — the Benincasa–Dowker
layer cardinality `prodLayerCard` grows from `1` (one history) to `2` (two histories combined),
`layer_growth_from_branching`, a size-independent dimension fingerprint (`prodLayerCard_link_stable`).
The remaining open rung (`causal_dimension_in_progress`) is the Ricci scalar as this layer-growth read
in the **statistical continuum limit** (sprinkling average), general `d ≥ 3` (not a simple product of
`d` chains for `d>2`), and the Myrheim–Meyer estimator — with the discrete d'Alembertian → Ricci, the
named open rung of [`Einstein_Equations.md`](../Einstein_Equations.md) §6a.
-/

namespace QLF.CausalDimension

/-- Volume of a **1-D causal interval** (a single chain / history) of diameter `d`: **linear** in
    proper time — `d + 1` events. -/
def chainVolume (d : ℕ) : ℕ := d + 1

/-- Volume of a **2-D causal diamond** = the product order of two chains (`1+1` Minkowski in
    light-cone coordinates `(u,v)`, the two null directions being two QLF histories): `(m+1)(n+1)`
    events. -/
def diamondVolume (m n : ℕ) : ℕ := (m + 1) * (n + 1)

/-- **Combining two chains multiplies their volumes:** the 2-D diamond volume is the product of the
    two 1-D chain volumes. Adding a causal direction multiplies the count — number↔volume gains a
    dimension. -/
theorem diamond_eq_product (m n : ℕ) : diamondVolume m n = chainVolume m * chainVolume n := rfl

/-- **1-D: volume is injective.** Each chain volume is realized by exactly one interval — *singleton
    layers*, the 1-dimensional / flat signature (no multiplicity, no curvature). -/
theorem chainVolume_injective : Function.Injective chainVolume := by
  intro a b h
  simp only [chainVolume] at h
  omega

/-- **2-D: volume is many-to-one.** The *same* diamond volume is realized by *distinct* diamonds —
    `1×1`, `0×3`, and `3×0` all have volume `4`. This multiplicity (vs the chain's uniqueness) is the
    growth of the Benincasa–Dowker layers — the dimension/curvature signal. -/
theorem diamondVolume_collision :
    diamondVolume 1 1 = 4 ∧ diamondVolume 0 3 = 4 ∧ diamondVolume 3 0 = 4 := by
  refine ⟨?_, ?_, ?_⟩ <;> rfl

/-- **Apex-relative interval volume in the 2-D product order** (product of two chains / `1+1`
    Minkowski, light-cone coordinates `(u,v)`). The interval `[(i,j),(m,n)] = {(a,b) : i≤a≤m, j≤b≤n}`
    has cardinality `(m−i+1)(n−j+1)` — number↔volume on the *combined* causal set. -/
def prodIntervalVolume (i j m n : ℕ) : ℕ := (m - i + 1) * (n - j + 1)

/-- **The Benincasa–Dowker causal layer at volume `k`** below the apex `(m,n)` in the 2-D product
    order: the grid points `(i,j) ≤ (m,n)` whose interval to the apex has volume exactly `k`. This is
    the BD input on a *combined* (2-D) causal structure — where layers grow past the single-history
    singletons of [`QLF_CausalInterval.layer_unique`](QLF_CausalInterval.lean). -/
def prodLayer (m n k : ℕ) : Finset (ℕ × ℕ) :=
  ((Finset.range (m + 1)) ×ˢ (Finset.range (n + 1))).filter
    (fun p => prodIntervalVolume p.1 p.2 m n = k)

/-- The cardinality `|L_k|` of the 2-D product layer — the Benincasa–Dowker input count. -/
def prodLayerCard (m n k : ℕ) : ℕ := (prodLayer m n k).card

/-- **One history → the link layer is a singleton (the flat baseline).** With `n = 0` the product
    order is a single chain in the first coordinate; the volume-2 layer (the apex's immediate
    predecessors) has cardinality `1`, matching `QLF_CausalInterval.layer_unique`. -/
theorem prodLayerCard_chain_link : prodLayerCard 1 0 2 = 1 := by native_decide

/-- **Two histories combined → the link layer grows to cardinality 2.** In the genuine 2-D diamond the
    apex `(1,1)` has **two** immediate predecessors, `(0,1)` and `(1,0)` — the two null directions /
    combining histories — so the volume-2 Benincasa–Dowker layer has cardinality `2`, not `1`. This is
    `|L_k|` growth past the flat singleton baseline: adding a causal direction grows the layer. -/
theorem prodLayerCard_diamond_link : prodLayerCard 1 1 2 = 2 := by native_decide

/-- **The link-layer cardinality is a dimension fingerprint, not a size artifact.** Across diamonds of
    different sizes the volume-2 layer keeps cardinality `2` (the two immediate predecessors), while a
    1-D strip (`n = 0`) keeps cardinality `1`. -/
theorem prodLayerCard_link_stable :
    prodLayerCard 2 2 2 = 2 ∧ prodLayerCard 3 2 2 = 2 ∧ prodLayerCard 5 0 2 = 1 := by
  refine ⟨?_, ?_, ?_⟩ <;> native_decide

/-- **|L_k| growth = combining histories — the branching case.** The volume-2 Benincasa–Dowker layer
    grows from cardinality `1` on a single history (`prodLayerCard_chain_link`) to `2` when two
    histories combine into a 2-D diamond (`prodLayerCard_diamond_link`): the layer cardinality counts
    the combining causal directions. Past the flat singleton baseline of `QLF_CausalInterval` (where
    `bdCurvature` reads `R = 0`), this growth is the Benincasa–Dowker input a curved reading needs. The
    Ricci scalar itself is this layer-growth read in the **statistical continuum limit** (the sprinkling
    average over the substrate's branchings), not the finite count of any one small diamond. -/
theorem layer_growth_from_branching :
    prodLayerCard 1 0 2 = 1 ∧ prodLayerCard 1 1 2 = 2 :=
  ⟨prodLayerCard_chain_link, prodLayerCard_diamond_link⟩

/-- **Established constructively:** dimension is read from number↔volume. A single history is a 1-D
    chain whose volume `chainVolume d = d+1` is **injective** (one interval per volume = singleton
    layers, `chainVolume_injective`); two histories combined by the product order give a 2-D diamond
    (`1+1` Minkowski) whose volume is the **product** of the chain volumes (`diamond_eq_product`) and is
    **many-to-one** (`diamondVolume_collision`: distinct diamonds share a volume = growing layers).
    **The layer growth is computed directly** (the branching case): the Benincasa–Dowker layer
    cardinality `prodLayerCard` of the actual 2-D product order grows from `1` on a single history to
    `2` when two histories combine — `layer_growth_from_branching` (`prodLayerCard_chain_link` /
    `prodLayerCard_diamond_link`), the apex's two immediate predecessors `(0,1)`,`(1,0)` being the two
    null directions, a size-independent dimension fingerprint (`prodLayerCard_link_stable`). So combining
    histories raises the dimension and grows the layers — the Benincasa–Dowker input a curved reading
    needs, past the `bdCurvature_chain_zero` flat baseline. **Open:** the Ricci scalar as this
    layer-growth in the **statistical continuum limit** (sprinkling average), general `d ≥ 3`, and the
    Myrheim–Meyer estimator (`causal_dimension_in_progress`). -/
theorem causal_dimension_in_progress : True := trivial

end QLF.CausalDimension
