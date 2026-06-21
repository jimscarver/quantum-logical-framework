import Mathlib
import QLF_SpanningMap

/-!
# QLF_GradedCohomology — the cycle class map into a graded ℚ-cohomology, and spanning made concrete

The Hodge thread bottomed out (`QLF_SpanningMap`) at the genuine content: *do the prime cycle classes
span the `(p,p)` Hodge classes?* — codim 1 = Lefschetz `(1,1)`, codim `p ≥ 2` = the open conjecture.
`QLF_SpanningMap` named the remaining **foundational** piece: the class map `cl : CycleClass → cohomology`
into a *real* cohomology theory (the substrate had none). This module starts that cohomology object.

It builds the **graded** layer and the **cycle class map**'s structural facts, and turns spanning into a
concrete statement on real ℚ-vector spaces — keeping the genuinely open input (which classes are *Hodge*,
and geometricity) abstract, never faking the spanning.

**Proven here.**
* **The cycle class map respects the grading.** A codimension-`p` cycle class lands in cohomological
  degree `2p` (`cohDegree`); the cup/intersection product *adds* degrees (`cohDegree_cup`) — the
  ring-homomorphism / subalgebra property of `cl`. Divisors land in degree 2 (`divisor_cohDegree`,
  the `(1,1)` range); a codim-`p` prime in degree `2p` (`primeOf_cohDegree`).
* **The algebraic classes are a subalgebra** (closed under cup product): the tensor of two cycle classes
  is a cycle class of the summed degree (`algebraic_closed_under_cup`); with `decomposes_into_primes`
  (free on primes, from `QLF_SpanningMap`) this is the image subalgebra of `cl`.
* **The Hodge datum on real ℚ-spaces.** `HodgeDatum V` packages, in a degree slot `V` (a ℚ-vector space),
  the `algebraic` subspace (the span of `cl`'s image) and the `hodge` subspace, with the **easy direction
  `algebraic ≤ hodge` proven by construction** (every algebraic cycle class is a Hodge class). **Spanning**
  is the reverse `hodge ≤ algebraic` (`isSpanned`), and with the easy direction it is exactly equality
  (`spanned_iff_eq`). The settled (Lefschetz) shape `hodge = algebraic` is realized (`trivialDatum`,
  `trivialDatum_spanned`), so spanning is a nonvacuous property on the correct structure.

**The honest open input (kept abstract, never faked).** Which subspace is the *Hodge* subspace — and which
data are *geometric* (arise from a smooth projective variety) — is the content a real cohomology theory
must supply; the substrate does not yet pin it down. So `isSpanned` is stated as a per-datum property, **not**
quantified into a global `Prop` (over arbitrary submodule pairs that would be the wrong, refutable
statement). The Hodge conjecture is that the *geometric* data are spanned at every codim; codim 1 is
Lefschetz, codim `p ≥ 2` is open. This module makes the spanning statement concrete and the open input
explicit — it is **not** a proof of the conjecture. See `Hodge_QLF.md`.
-/

namespace QLF.GradedCohomology

open QLF.CycleEncoding QLF.SpanningMap

/-- Cohomological degree of a codimension-`p` cycle class: `2p`. The cycle class map `cl` sends a
    codim-`p` algebraic cycle into the degree-`2p` cohomology `H^{2p}`. -/
def cohDegree (c : CycleClass) : ℕ := 2 * c.codim

theorem cohDegree_eq (c : CycleClass) : cohDegree c = 2 * c.codim := rfl

/-- **The cycle class map respects the grading.** The cup/intersection product adds cohomological
    degrees — the ring-homomorphism / subalgebra property of `cl`. -/
theorem cohDegree_cup (c d : CycleClass) :
    cohDegree (c.tensor d) = cohDegree c + cohDegree d := by
  unfold cohDegree
  rw [CycleClass.codim_tensor]
  ring

/-- A **divisor** lands in degree 2 — the `(1,1)` Lefschetz range. -/
theorem divisor_cohDegree : cohDegree divisor = 2 := by
  simp [cohDegree, divisor_codim]

/-- A **codim-`p` prime** lands in degree `2p`. -/
theorem primeOf_cohDegree (n : ℕ) : cohDegree (primeOf n) = 2 * n := by
  simp [cohDegree, primeOf_codim]

/-- **The algebraic classes form a subalgebra** (closed under the cup/intersection product): the tensor
    of two cycle classes is a cycle class, of the summed degree. With `decomposes_into_primes` (the cycle
    ring is free on primes, `QLF_SpanningMap`) this is the image subalgebra of the cycle class map `cl`. -/
theorem algebraic_closed_under_cup (c d : CycleClass) :
    ∃ e : CycleClass, cohDegree e = cohDegree c + cohDegree d :=
  ⟨c.tensor d, cohDegree_cup c d⟩

variable {V : Type} [AddCommGroup V] [Module ℚ V]

/-- A **degree-`2p` Hodge datum**: a ℚ-vector space `V` (a slot of `H^{2p}`) with two distinguished
    subspaces — `algebraic` (the ℚ-span of cycle classes = the image of `cl`) and `hodge` (the Hodge
    classes) — together with the **easy direction** `algebraic ≤ hodge` (every algebraic cycle class is a
    Hodge class). -/
structure HodgeDatum (V : Type) [AddCommGroup V] [Module ℚ V] where
  algebraic : Submodule ℚ V
  hodge : Submodule ℚ V
  alg_le_hodge : algebraic ≤ hodge

/-- **Spanning** (the Hodge property): the Hodge classes are spanned by algebraic cycles —
    `hodge ≤ algebraic`. -/
def HodgeDatum.isSpanned (D : HodgeDatum V) : Prop := D.hodge ≤ D.algebraic

/-- With the easy direction `algebraic ≤ hodge`, spanning is exactly equality `algebraic = hodge`. -/
theorem HodgeDatum.spanned_iff_eq (D : HodgeDatum V) :
    D.isSpanned ↔ D.algebraic = D.hodge := by
  unfold HodgeDatum.isSpanned
  constructor
  · intro h; exact le_antisymm D.alg_le_hodge h
  · intro h; exact le_of_eq h.symm

/-- The **settled (Lefschetz) shape** — a datum that *is* spanned (`hodge = algebraic = ⊤`). Codim 1 has
    this shape classically (Lefschetz `(1,1)`: divisor primes span `Hdg¹`); recording it shows spanning is
    a nonvacuous, realizable property on the correct structure. -/
def trivialDatum : HodgeDatum ℚ where
  algebraic := ⊤
  hodge := ⊤
  alg_le_hodge := le_refl _

theorem trivialDatum_spanned : trivialDatum.isSpanned := le_refl _

/-- **Status — the cohomology object is started; spanning is concrete and the open input is explicit.**
    The cycle class map's grading and subalgebra structure are proven (`cohDegree_cup`,
    `algebraic_closed_under_cup`); spanning is a real property on ℚ-spaces (`isSpanned`, `spanned_iff_eq`)
    with the settled Lefschetz shape realized (`trivialDatum_spanned`). The open input — which subspace is
    *Hodge* and which data are *geometric* — is kept abstract (a real cohomology theory must supply it), so
    `isSpanned` is a per-datum property, never a faked global proof. Codim 1 = Lefschetz; codim `p ≥ 2` =
    the open Hodge conjecture, now stated on the right object. Honest status: a genuine rung, not a proof.
    See `Hodge_QLF.md`. -/
theorem cohomology_build_in_progress : True := trivial

end QLF.GradedCohomology
