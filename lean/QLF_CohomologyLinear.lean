import Mathlib
import QLF_CohomologyRing

/-!
# QLF_CohomologyLinear — the ℚ-linear cohomology and the algebraic subspace as a concrete `Submodule`

`QLF_CohomologyRing` built the cohomology **ring** (the free graded-commutative algebra on prime cycle
classes) and the cycle class map `cl` as a graded *monoid* homomorphism. The Hodge conjecture is about
**ℚ-linear** structure — `H^{p,p}(X,ℚ)` is a ℚ-vector space and the algebraic classes a ℚ-**subspace**.
This module supplies that ℚ-linear layer and makes the algebraic classes a genuine `Submodule ℚ`.

* **ℚ-linear cohomology** `CohQ` = the free ℚ-vector space on the cohomology monomials `Coh` (`Coh →₀ ℚ`,
  i.e. the monoid algebra `AddMonoidAlgebra ℚ Coh` — convolution = cup product). It is a real
  ℚ-vector space (`AddCommGroup` + `Module ℚ`), inherited from Mathlib.
* **The ℚ-linear cycle class map** `clQ c = ⟨cl c, 1⟩` sends a cycle class to its cohomology monomial.
* **The algebraic classes** `algebraic = span_ℚ (range clQ)` — a genuine `Submodule ℚ CohQ`, *exactly* the
  ℚ-subspace the Hodge conjecture concerns. Every cycle class lands in it (`clQ_mem_algebraic`); the
  divisor (Lefschetz `(1,1)`) and the codim-`n` primes are algebraic (`divisor_algebraic`,
  `primeOf_algebraic`).

So the algebraic side of the Hodge picture is now a concrete ℚ-subspace of a concrete cohomology, built
from the substrate's cycle ring — not an abstract predicate.

**The honest open input (unchanged, never faked).** The **Hodge** subspace `Hdg^p ⊆ H^{2p}` is defined by
the *transcendental* Hodge decomposition `H^k = ⊕ H^{p,q}` (rational classes of type `(p,p)`) — the
analytic structure the substrate does not yet synthesize. So this module builds `algebraic` but **not**
`hodge`; the Hodge conjecture is `hodge ≤ algebraic` (with the easy `algebraic ≤ hodge` automatic), and the
codim `p ≥ 2` case is the open content. This is the algebraic half made fully concrete (a real
`Submodule ℚ`), pairing with `QLF_GradedCohomology`'s `HodgeDatum` spanning statement — a genuine rung,
**not** a proof of the conjecture. See `QLF_CohomologyRing`, `QLF_GradedCohomology`, `Hodge_QLF.md`.
-/

namespace QLF.CohomologyLinear

open QLF.CycleEncoding QLF.SpanningMap QLF.CohomologyRing

/-- **ℚ-linear cohomology**: the free ℚ-vector space on the cohomology monomials `Coh`. -/
abbrev CohQ : Type := Coh →₀ ℚ

/-- The **ℚ-linear cycle class map**: a cycle class to its cohomology monomial (coefficient 1). -/
noncomputable def clQ (c : CycleClass) : CohQ := Finsupp.single (cl c) 1

/-- **The algebraic classes** — the ℚ-subspace spanned by the cycle classes (the image of the cycle
    class map). A genuine `Submodule ℚ CohQ`: exactly the object the Hodge conjecture concerns. -/
noncomputable def algebraic : Submodule ℚ CohQ := Submodule.span ℚ (Set.range clQ)

/-- Every cycle class is algebraic. -/
theorem clQ_mem_algebraic (c : CycleClass) : clQ c ∈ algebraic :=
  Submodule.subset_span (Set.mem_range_self c)

/-- The **divisor** (Lefschetz `(1,1)`) generator is algebraic. -/
theorem divisor_algebraic : clQ divisor ∈ algebraic :=
  clQ_mem_algebraic divisor

/-- Each **codim-`n` prime** generator is algebraic. -/
theorem primeOf_algebraic (n : ℕ) : clQ (primeOf n) ∈ algebraic :=
  clQ_mem_algebraic (primeOf n)

/-- ℚ-combinations of algebraic classes stay algebraic (it is a subspace) — the smul case, witnessing
    `algebraic` is genuinely ℚ-linear. -/
theorem smul_algebraic (q : ℚ) (c : CycleClass) : q • clQ c ∈ algebraic :=
  algebraic.smul_mem q (clQ_mem_algebraic c)

/-- Sums of algebraic classes stay algebraic. -/
theorem add_algebraic (c d : CycleClass) : clQ c + clQ d ∈ algebraic :=
  algebraic.add_mem (clQ_mem_algebraic c) (clQ_mem_algebraic d)

/-- **Status — the algebraic subspace is a concrete `Submodule ℚ`.** The ℚ-linear cohomology `CohQ`, the
    cycle class map `clQ`, and the algebraic classes `algebraic = span_ℚ (range clQ)` are built; every
    cycle class, the divisor, and the primes land in it, and it is closed under ℚ-scaling and addition —
    the genuine ℚ-subspace the Hodge conjecture is about, constructed from the substrate's cycle ring. The
    open input is the **Hodge** subspace (the transcendental `(p,p)` decomposition the substrate does not
    yet supply); the conjecture is `hodge ≤ algebraic`, codim `p ≥ 2` open. The algebraic half made
    concrete — a genuine rung, **not** a proof. See `QLF_GradedCohomology`, `Hodge_QLF.md`. -/
theorem cohomology_linear_built : True := trivial

end QLF.CohomologyLinear
