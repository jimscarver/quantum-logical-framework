import QLF_ReachableEvent

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
set — the first rung of order→metric, reusing `QLF_ReachableEvent` with no new axioms. It does **not**
formalize the literal interval *cardinality* equals `intervalVolume` (the natural next rung), the
**discrete d'Alembertian → Ricci scalar** (Benincasa–Dowker), or the **continuum limit** to
`G_μν = 8πG T_μν` — those remain the named open step (`einstein_curvature_in_progress`), now a concrete
CST/Benincasa–Dowker program on QLF's substrate rather than generic differential geometry. See
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

/-- **Established constructively:** the causal (Alexandrov) interval and its **number↔volume**
    proper-time structure on QLF's causal set — endpoints lie in the interval
    (`left_mem_interval`/`right_mem_interval`), self-volume is one tick (`intervalVolume_self`), and
    **proper time is additive along the causal order** (`intervalVolume_additive`) — the first rung of
    the order→metric program, reusing `QLF_ReachableEvent`. **Open (the named curvature step):** the
    literal interval *cardinality* = `intervalVolume`, the discrete d'Alembertian → Ricci scalar
    (Benincasa–Dowker), and the continuum limit to `G_μν = 8πG T_μν` — a concrete CST program on the
    substrate, not generic differential geometry (`einstein_curvature_in_progress`). -/
theorem einstein_curvature_in_progress : True := trivial

end QLF.CausalInterval
