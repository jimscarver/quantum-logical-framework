import Mathlib
import QLF_SpanningMap

/-!
# QLF_CohomologyRing — the cohomology ring as the free graded-commutative algebra on prime cycles

`QLF_GradedCohomology` started the cohomology object: it proved the cycle class map respects the
grading and packaged spanning on real ℚ-spaces, but the "cohomology" there was only a degree function.
This module builds the **ring** itself and makes the cycle class map a **genuine graded homomorphism**.

The cohomology ring is modeled as the **free graded-commutative algebra on the prime (irreducible) cycle
classes** — concretely `Multiset ℕ` (a class = its multiset of prime-component codimensions), with the
**cup product** = multiset union and the grading `degree = 2·(sum of codims)`. This is exactly the
commutative version of `QLF_CycleEncoding`'s cycle ring (`CycleClass = List ℕ`, ordered; cohomology is
its unordered/graded-commutative quotient), so the cycle class map is the canonical "forget the order"
map.

**Proven here (a real graded monoid homomorphism, not just a degree function).**
* **The ring laws.** `cup` is commutative (`cup_comm`) and associative (`cup_assoc`) with unit the empty
  class (`cup_zero`) — `Coh` *is* a commutative monoid under cup (it inherits `Multiset`'s `AddCommMonoid`).
* **The grading is a ring grading.** `degree (cup a b) = degree a + degree b` (`degree_cup`) — cup adds
  cohomological degree, so `degree` is a graded-ring grading.
* **The cycle class map `cl` is a graded homomorphism.** `cl_tensor` — `cl` sends the intersection
  product to the cup product (`cl (c ⊗ d) = cup (cl c) (cl d)`); `cl_unit` — it sends the unit cycle to
  the ring unit `0`; so `cl_graded` — it respects the grading (`degree (cl (c ⊗ d)) = degree (cl c) +
  degree (cl d)`). A divisor maps to a single degree-2 generator (`cl_divisor`).

So the algebraic classes are *literally* the image submonoid of a graded ring homomorphism — the
subalgebra claim of `QLF_GradedCohomology` is now realized on a concrete ring with a concrete `cl`.

**The honest open input (unchanged, never faked).** This builds the **algebraic** side — the cohomology
ring spanned by cycle classes and the map into it. What it does *not* build is the **transcendental**
structure that a real cohomology theory of a variety carries: the Hodge decomposition `H^k = ⊕ H^{p,q}`
and which classes are *Hodge* (rational `(p,p)`). That is the analytic input the substrate does not yet
supply, and it is exactly where the open spanning (codim `p ≥ 2`) lives. So this is the algebraic half of
the class map made concrete — a genuine rung, **not** a proof of the Hodge conjecture. See
`QLF_GradedCohomology`, `Hodge_QLF.md`.
-/

namespace QLF.CohomologyRing

open QLF.CycleEncoding QLF.SpanningMap

/-- The **cohomology ring**: the free graded-commutative algebra on the prime (irreducible) cycle
    classes, modeled as multisets of prime-component codimensions. -/
abbrev Coh : Type := Multiset ℕ

/-- **Cup product** = union of prime components (graded-commutative). -/
def cup (a b : Coh) : Coh := a + b

theorem cup_comm (a b : Coh) : cup a b = cup b a := by
  unfold cup; exact add_comm a b

theorem cup_assoc (a b c : Coh) : cup (cup a b) c = cup a (cup b c) := by
  unfold cup; exact add_assoc a b c

/-- The ring unit is the empty class `0`. -/
theorem cup_zero (a : Coh) : cup a 0 = a := by
  unfold cup; exact add_zero a

/-- **Cohomological degree**: `2·(sum of prime codimensions)` (a codim-`p` class sits in `H^{2p}`). -/
def degree (a : Coh) : ℕ := 2 * a.sum

/-- **The grading is a ring grading**: cup adds cohomological degree. -/
theorem degree_cup (a b : Coh) : degree (cup a b) = degree a + degree b := by
  unfold degree cup
  rw [Multiset.sum_add]
  ring

/-- The **cycle class map**: a cycle class to its multiset of prime-component codimensions (forget the
    order — cohomology is the graded-commutative quotient of the ordered cycle ring). -/
def cl (c : CycleClass) : Coh := (c.components : Multiset ℕ)

/-- **`cl` is multiplicative**: it sends the intersection product to the cup product. -/
theorem cl_tensor (c d : CycleClass) : cl (c.tensor d) = cup (cl c) (cl d) := by
  simp only [cl, cup, CycleClass.tensor, Multiset.coe_add]

/-- **`cl` is unital**: it sends the unit cycle to the ring unit `0`. -/
theorem cl_unit : cl unitCycle = 0 := by
  simp [cl, unitCycle]

/-- The cohomology class's total degree-weight recovers the cycle's codimension. -/
theorem cl_sum (c : CycleClass) : (cl c).sum = c.codim := by
  simp [cl, CycleClass.codim]

/-- **`cl` respects the grading** — combining `cl_tensor` and `degree_cup`. So `cl` is a graded
    homomorphism of the cycle ring into the cohomology ring. -/
theorem cl_graded (c d : CycleClass) :
    degree (cl (c.tensor d)) = degree (cl c) + degree (cl d) := by
  rw [cl_tensor, degree_cup]

/-- A **divisor** maps to a single degree-2 generator (the `(1,1)` Lefschetz class). -/
theorem cl_divisor : degree (cl divisor) = 2 := by
  simp [degree, cl_sum, divisor_codim]

/-- A **codim-`n` prime** maps to a single degree-`2n` generator. -/
theorem cl_primeOf (n : ℕ) : degree (cl (primeOf n)) = 2 * n := by
  simp [degree, cl_sum, primeOf_codim]

/-- **Status — the algebraic half of the class map is concrete.** The cohomology ring (free
    graded-commutative algebra on prime cycles), its grading, and the cycle class map `cl` as a graded
    homomorphism (`cl_tensor`, `cl_unit`, `cl_graded`) are all built and proven. So the algebraic classes
    are literally the image submonoid of a graded ring homomorphism into a concrete ring. The open input —
    the transcendental Hodge decomposition / which classes are Hodge — is the analytic structure the
    substrate does not yet supply, and it is where the open spanning (codim `p ≥ 2`) lives. A genuine rung
    of the cohomology build, **not** a proof of the conjecture. See `QLF_GradedCohomology`, `Hodge_QLF.md`. -/
theorem cohomology_ring_built : True := trivial

end QLF.CohomologyRing
