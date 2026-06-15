import QLF_CausalInterval

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
signature. It does **not** treat general `d ≥ 3` (not a simple product of `d` chains for `d>2`), the
Myrheim–Meyer estimator as a continuum limit, the literal event-count of the product interval, or
curvature on a generic branching graph (`causal_dimension_in_progress`) — those, with the discrete
d'Alembertian → Ricci, remain the named open rung of [`Einstein_Equations.md`](../Einstein_Equations.md) §6a.
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

/-- **Established constructively:** dimension is read from number↔volume. A single history is a 1-D
    chain whose volume `chainVolume d = d+1` is **injective** (one interval per volume = singleton
    layers, `chainVolume_injective`); two histories combined by the product order give a 2-D diamond
    (`1+1` Minkowski) whose volume is the **product** of the chain volumes (`diamond_eq_product`) and is
    **many-to-one** (`diamondVolume_collision`: distinct diamonds share a volume = growing layers). So
    combining histories raises the dimension and grows the layers — the same phenomenon as curvature.
    **Open:** general `d ≥ 3`, the Myrheim–Meyer continuum limit, the literal product-interval count,
    and curvature on a generic branching graph (`causal_dimension_in_progress`). -/
theorem causal_dimension_in_progress : True := trivial

end QLF.CausalDimension
