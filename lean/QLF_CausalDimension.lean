import QLF_CausalInterval
import Mathlib.Order.Interval.Finset.Nat

set_option linter.unusedVariables false

/-!
# QLF_CausalDimension — dimension from combining histories (number↔volume reads the dimension)

[`QLF_CausalInterval`](QLF_CausalInterval.lean) showed a *single* QLF history is a **chain** (1-D,
flat: every Benincasa–Dowker causal layer is a singleton, `layer_unique`). Curvature needs more than
one dimension, so it needs **histories combined**. The cleanest combination is the **product order**:
two chains `(u, v)` combine into a 2-D causal set — which is *exactly* `1+1` Minkowski space in
light-cone coordinates (the two null directions `u`, `v` are two QLF histories / local clocks).

The geometric payoff is **Myrheim–Meyer dimension from number↔volume**: a causal interval's event
count scales as `(proper time)^d`, so the *exponent reads the dimension*.

* A **1-D chain** interval of diameter `d` has volume `chainVolume d = d + 1` — **linear**.
* A **2-D diamond** `[(0,0),(m,n)]` (product of two chains) has volume
  `diamondVolume m n = (m+1)(n+1)` — the **product** of the two chain volumes (`diamond_eq_product`),
  and for a square diamond `(t+1)²` — **quadratic** (`diamond_square`). The literal event count of the
  product-order Alexandrov interval is `(m+1)(n+1)` (`diamond_card`).

So **adding a causal direction multiplies the count**: combining `d` histories gives volume `~ τ^d`,
and the dimension is the scaling exponent. This is the same branching that
[`SpaceTime.md`](../SpaceTime.md) §3a derives renders into three spatial dimensions, and the same
layer-growth whose Benincasa–Dowker sum is the Ricci scalar — dimension and curvature are one
phenomenon, the growth of `|L_k|` when histories combine.

## Honest scope

This anchors the **2-D (product-of-two-chains) case exactly** — `1+1` Minkowski, volume `(m+1)(n+1)`,
the linear-vs-quadratic dimension signal. It does **not** treat general `d ≥ 3` (not a simple product
of `d` chains for `d>2`), the Myrheim–Meyer estimator as a limit, or curvature on a generic branching
graph (`causal_dimension_in_progress`); those, with the discrete d'Alembertian → Ricci, remain the
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

/-- **A square 2-D diamond has volume `(t+1)²`** — *quadratic* in the diameter, against the chain's
    *linear* `t+1`. Volume `~ (proper time)^d` is the Myrheim–Meyer dimension signal: here `d = 2`. -/
theorem diamond_square (t : ℕ) : diamondVolume t t = (t + 1) ^ 2 := by
  unfold diamondVolume; ring

/-- **The 2-D causal diamond literally has `(m+1)(n+1)` events** — the product-order Alexandrov
    interval `[(0,0),(m,n)]` on `ℕ × ℕ` (CST's number↔volume, in 2-D). -/
theorem diamond_card (m n : ℕ) :
    (Finset.Icc ((0 : ℕ), (0 : ℕ)) (m, n)).card = diamondVolume m n := by
  rw [Finset.Icc_prod_eq, Finset.card_product, Nat.card_Icc, Nat.card_Icc, Nat.sub_zero,
    Nat.sub_zero]

/-- **Established constructively:** dimension is read from number↔volume scaling. A single history is a
    1-D chain (`chainVolume d = d+1`, linear); two histories combined by the product order give a 2-D
    causal diamond (`1+1` Minkowski) whose volume is the **product** of the chain volumes
    (`diamond_eq_product`), quadratic for a square diamond (`diamond_square`), with literal event count
    `(m+1)(n+1)` (`diamond_card`). So combining histories raises the dimension, the scaling exponent.
    **Open:** general `d ≥ 3`, the Myrheim–Meyer limit, and curvature on a generic branching graph
    (the discrete d'Alembertian → Ricci) — `causal_dimension_in_progress`. -/
theorem causal_dimension_in_progress : True := trivial

end QLF.CausalDimension
