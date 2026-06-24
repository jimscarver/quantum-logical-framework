import QLF_ReachableEvent
import Mathlib.Data.Set.Card

set_option linter.unusedVariables false

/-!
# QLF_CausalInterval — number ↔ volume: the curvature side of the Einstein equations begins here

[`QLF_EinsteinEquations`](QLF_EinsteinEquations.lean) anchored the Einstein **equation of state** —
the coefficient `8πG = 2π/η` (Jacobson) and `Λ = log 2` — leaving the *tensor/curvature* side
(`G_μν = R_μν − ½ g_μν R`) as the named open step. That step is **not** generic missing
differential geometry: [`QLF_ReachableEvent`](QLF_ReachableEvent.lean) made QLF's **causal set** (the
reachability partial order) a Lean object, and the causal set is exactly the structure **Causal Set
Theory** (Bombelli–Sorkin) and the **Benincasa–Dowker** program use to recover curvature and the
Einstein–Hilbert action `∫R` from *pure causal order*. So the curvature side is the concrete
**order → metric** program on QLF's own substrate graph — and its first rung is here.

The basic geometric object is the **causal (Alexandrov) interval** `[A,B] = {C : A ≤ C ≤ B}`, built
from the order alone. Its **number ↔ volume** content — CST's foundational principle that *counting
events measures spacetime volume / proper time* — appears as `intervalVolume A B = |B| − |A| + 1`, the
Markov-blanket **depth difference** (so the interval volume IS the Kitada local-clock tick count
between the two events, [`Kitada_Local_Time_GR.md`](../Kitada_Local_Time_GR.md)). The key geometric
fact anchored here is that **proper time is additive along a causal chain** (`intervalVolume_additive`)
— the discrete seed of the line element from which the d'Alembertian, the Ricci scalar, and the
Einstein–Hilbert action are built in the continuum limit.

## Honest scope

This anchors the **causal interval and its number↔volume (proper-time) structure** on QLF's causal
set, plus the **Benincasa–Dowker curvature operator at its flat baseline** — the balanced layer
stencil (`bdCoeff_sum_zero`) reads `R = 0` on a single-history chain (`bdCurvature_chain_zero`, via the
singleton layers of `layerCard_chain`), so curvature is the *growth* of the layer cardinalities once
the closure graph branches. Reuses `QLF_ReachableEvent` with no new axioms. The named open step
(`einstein_curvature_in_progress`) is the rest of that concrete CST/Benincasa–Dowker program: `|L_k|`
on the **branching** graph through the BD sum → the Ricci scalar, and the **continuum limit** to
`G_μν = 8πG T_μν`. See
[`Einstein_Equations.md`](../Einstein_Equations.md), [`TheContinuum.md`](../TheContinuum.md) §on
causal-path statistics.
-/

namespace QLF.CausalInterval

open QLF.ReachableEvent

variable {α : Type _}

/-- **The causal (Alexandrov) interval** `[A,B]` — the events causally *between* `A` and `B`
    (`A ≤ C ≤ B`), defined from the reachability order alone: no metric, no coordinates. The basic
    geometric object of Causal Set Theory. -/
def causalInterval (A B : Event α) : Set (Event α) := { C | reachable A C ∧ reachable C B }

/-- **Discrete proper time / volume** of the causal interval — the Markov-blanket *depth difference*
    `|B| − |A| + 1`. This is CST's *number ↔ volume*: counting events measures volume; here it is the
    Kitada local-clock tick count between the two events. -/
def intervalVolume (A B : Event α) : ℕ := B.length - A.length + 1

/-- Reachability is length-monotone: `A ≤ B ⇒ |A| ≤ |B|` (depth grows along the causal order). -/
theorem reachable_length_mono {A B : Event α} (h : reachable A B) : A.length ≤ B.length :=
  h.sublist.length_le

/-- The past endpoint lies in its own interval. -/
theorem left_mem_interval {A B : Event α} (hAB : reachable A B) : A ∈ causalInterval A B :=
  ⟨reachable_refl A, hAB⟩

/-- The future endpoint lies in its own interval. -/
theorem right_mem_interval {A B : Event α} (hAB : reachable A B) : B ∈ causalInterval A B :=
  ⟨hAB, reachable_refl B⟩

/-- A self-interval has unit volume — one tick (the irreducible event). -/
theorem intervalVolume_self (A : Event α) : intervalVolume A A = 1 := by
  unfold intervalVolume; omega

/-- **Proper time is additive along a causal chain** `A ≤ B ≤ C`: the interval volumes compose,
    sharing the one endpoint `B` (`vol A C = vol A B + vol B C − 1`). This additivity of discrete
    proper time along the order is the seed of the spacetime line element. -/
theorem intervalVolume_additive {A B C : Event α}
    (hAB : reachable A B) (hBC : reachable B C) :
    intervalVolume A C = intervalVolume A B + intervalVolume B C - 1 := by
  have h1 := reachable_length_mono hAB
  have h2 := reachable_length_mono hBC
  unfold intervalVolume
  omega

/-- **The causal interval is exactly the prefixes of `B` no shorter than `A`** (given `A ≤ B`):
    `C ∈ [A,B] ↔ C ≤ B ∧ |A| ≤ |C|`. Both `A` and `C` are prefixes of `B`, so their order is fixed by
    length — the interval is the "tail" of `B`'s prefix chain from depth `|A|` to `|B|`. -/
theorem causalInterval_eq {A B : Event α} (hAB : reachable A B) :
    causalInterval A B = {C | reachable C B ∧ A.length ≤ C.length} := by
  ext C
  constructor
  · rintro ⟨hAC, hCB⟩
    exact ⟨hCB, reachable_length_mono hAC⟩
  · rintro ⟨hCB, hlen⟩
    exact ⟨List.prefix_of_prefix_length_le hAB hCB hlen, hCB⟩

/-- **Every causal interval in the prefix order is a chain** (totally ordered): any two events in
    `[A,B]` are causally comparable. This is a *sharpening*, not a curvature claim: the prefix
    substrate is a single **history line**, which is flat (1-dimensional) — so curvature does **not**
    live here. It lives in the *branching* of the full closure graph (incomparable histories /
    antichains, the `expand_generation` QuCalc tree), which is where the discrete d'Alembertian
    samples it. This theorem tells the next rung exactly where to look. -/
theorem interval_isChain {A B C D : Event α}
    (hC : C ∈ causalInterval A B) (hD : D ∈ causalInterval A B) :
    reachable C D ∨ reachable D C := by
  rcases le_total C.length D.length with h | h
  · exact Or.inl (List.prefix_of_prefix_length_le hC.2 hD.2 h)
  · exact Or.inr (List.prefix_of_prefix_length_le hD.2 hC.2 h)

/-- **The `k`-th causal layer below `x`** (Benincasa–Dowker): the events `y ≤ x` whose order interval
    `[y,x]` has volume exactly `k`. The BD discrete d'Alembertian reads curvature from how the
    *cardinalities* of these layers grow with `k`; the layers are its input. -/
def layer (x : Event α) (k : ℕ) : Set (Event α) := { y | reachable y x ∧ intervalVolume y x = k }

/-- **In the flat single-history (chain) substrate every causal layer is a singleton.** For each valid
    depth `1 ≤ k ≤ |x|+1` there is a *unique* event at interval-volume `k` below `x` — the prefix
    `x.take (|x|+1−k)`. Singleton layers are the Benincasa–Dowker signature of a **1-dimensional, flat**
    causal order (pure time, no space): spatial dimensions and curvature appear only when the closure
    graph *branches*, making layer cardinalities grow. -/
theorem layer_unique (x : Event α) {k : ℕ} (hk : 1 ≤ k) (hk2 : k ≤ x.length + 1) :
    ∃! y, y ∈ layer x k := by
  have hm : (x.take (x.length + 1 - k)).length = x.length + 1 - k := by
    rw [List.length_take]; omega
  refine ⟨x.take (x.length + 1 - k), ⟨List.take_prefix _ x, ?_⟩, ?_⟩
  · show intervalVolume (x.take (x.length + 1 - k)) x = k
    unfold intervalVolume; rw [hm]; omega
  · rintro y ⟨hyx, hvy⟩
    have hyl : y.length ≤ x.length := reachable_length_mono hyx
    have hyeq : y.length = x.length + 1 - k := by unfold intervalVolume at hvy; omega
    have hw : reachable (x.take (x.length + 1 - k)) x := List.take_prefix _ x
    have h1 : reachable y (x.take (x.length + 1 - k)) :=
      List.prefix_of_prefix_length_le hyx hw (by omega)
    have h2 : reachable (x.take (x.length + 1 - k)) y :=
      List.prefix_of_prefix_length_le hw hyx (by omega)
    exact reachable_antisymm h1 h2

/-- The cardinality of the `k`-th causal layer below `x` — the **Benincasa–Dowker input**. -/
noncomputable def layerCard (x : Event α) (k : ℕ) : ℕ := (layer x k).ncard

/-- **Each in-range causal layer of a chain is a singleton, so its cardinality is `1`** (`layer_unique`):
    on the flat single-history substrate exactly one event sits at each interval-depth
    `1 ≤ k ≤ |x|+1` below `x`. -/
theorem layerCard_chain (x : Event α) {k : ℕ} (hk : 1 ≤ k) (hk2 : k ≤ x.length + 1) :
    layerCard x k = 1 := by
  obtain ⟨y, hy, huniq⟩ := layer_unique x hk hk2
  have hs : layer x k = {y} := Set.eq_singleton_iff_unique_mem.mpr ⟨hy, huniq⟩
  show (layer x k).ncard = 1
  rw [hs, Set.ncard_singleton]

/-- **Benincasa–Dowker layer coefficients** — the 1+1-dimensional / second-difference stencil: the
    curvature reading weights the nearest three causal layers by `+1, −2, +1`. -/
def bdCoeff : ℕ → ℤ
  | 1 => 1
  | 2 => -2
  | 3 => 1
  | _ => 0

/-- **The BD coefficients are balanced — they sum to zero.** This is the defining property of a
    *curvature* stencil: it reads the *second difference* of the layer occupations, not their bare
    count, so a uniform layer profile reads zero (`+1 − 2 + 1 = 0`, the discrete d'Alembertian of a
    constant). -/
theorem bdCoeff_sum_zero : bdCoeff 1 + bdCoeff 2 + bdCoeff 3 = 0 := by decide

/-- **The Benincasa–Dowker curvature reading at `x`** — the balanced alternating sum of the first three
    causal-layer cardinalities. CST's central result is that, averaged over a sprinkling, this returns
    `−½ R` (the discrete d'Alembertian of a constant field); here it is evaluated on the bare order. -/
noncomputable def bdCurvature (x : Event α) : ℤ :=
  bdCoeff 1 * (layerCard x 1 : ℤ) + bdCoeff 2 * (layerCard x 2 : ℤ) + bdCoeff 3 * (layerCard x 3 : ℤ)

/-- **The flat baseline, in the curvature operator: a chain reads zero.** On a single QLF history of
    depth `≥ 2` the first three causal layers are singletons (`layerCard_chain`), so the
    Benincasa–Dowker reading collapses to the bare coefficient sum `+1 − 2 + 1 = 0`
    (`bdCoeff_sum_zero`): one history line is **flat**, `R = 0`. Equivalently the chain's BD operator is
    the 1-D discrete second difference, which annihilates a constant. This anchors the `R = 0` baseline
    in the *actual* curvature operator (not only in the singleton-layer structure) — the point past
    which curvature is the *growth* of `|L_k|` once the closure graph branches. -/
theorem bdCurvature_chain_zero (x : Event α) (hx : 2 ≤ x.length) : bdCurvature x = 0 := by
  have h1 : layerCard x 1 = 1 := layerCard_chain x (k := 1) (by omega) (by omega)
  have h2 : layerCard x 2 = 1 := layerCard_chain x (k := 2) (by omega) (by omega)
  have h3 : layerCard x 3 = 1 := layerCard_chain x (k := 3) (by omega) (by omega)
  unfold bdCurvature
  rw [h1, h2, h3]
  norm_num [bdCoeff]

/-- **Established constructively:** the causal (Alexandrov) interval and its **number↔volume**
    proper-time structure on QLF's causal set — endpoints lie in the interval
    (`left_mem_interval`/`right_mem_interval`), self-volume is one tick (`intervalVolume_self`),
    **proper time is additive along the causal order** (`intervalVolume_additive`), the interval is
    exactly the prefixes of `B` no shorter than `A` (`causalInterval_eq`), and it is a **chain**
    (`interval_isChain`) — a single history line, which is flat. **The Benincasa–Dowker curvature
    operator is anchored at its flat baseline:** the BD layer coefficients are balanced
    (`bdCoeff_sum_zero`, `+1 − 2 + 1 = 0`), each in-range layer of a chain is a singleton
    (`layerCard_chain`, from `layer_unique`), and so the BD curvature reading on a single history of
    depth `≥ 2` is exactly zero (`bdCurvature_chain_zero`): `R = 0` in the actual operator, the chain's
    BD reading being the 1-D discrete second difference annihilating a constant. **Where curvature
    lives:** past this baseline, the Ricci scalar is the *growth* of the layer cardinalities `|L_k|`
    once the closure graph **branches** — incomparable histories / antichains, the `expand_generation`
    QuCalc tree. **Open (`einstein_curvature_in_progress`):** `|L_k|` on the branching graph fed through
    the Benincasa–Dowker sum → Ricci scalar, and the continuum limit to `G_μν = 8πG T_μν` — a concrete
    CST program on the substrate's own closure graph. -/
theorem einstein_curvature_in_progress : True := trivial

end QLF.CausalInterval
