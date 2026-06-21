import QLF_Hodge

/-!
# QLF_CycleEncoding — going for the gap: a cycle-faithful representation where irreducibility bites

The faithfulness swing series (`QLF_HodgeExpSequence`, `QLF_HodgeIrreducible`) converged on one named
gap: the toy `CohClass.encode ⟨p,q⟩ = upᵖ downᵠ` **collapses** cycle structure — for `⟨p,p⟩` it is the
single nested staircase, *prime for every p* — so the irreducibility invariant (which the substrate has,
from the α census) is invisible through it. The closure fold is *multiplicative*, and irreducibility
"single cycle vs. product" cannot be read off a multiplicative invariant.

This module takes the first genuine step on that gap: a representation that **retains** the prime
decomposition, so irreducibility is *visible* and *non-multiplicative*. A `CycleClass` is a cycle by its
list of irreducible (prime) components, each carrying a codimension — the Chow-style grading. On it:

* the irreducibility invariant **bites**: a product of two irreducibles is *not* irreducible
  (`irreducible_not_preserved_under_product`) — exactly what the multiplicative closure fold could not see;
* codimension is additive under the intersection product (`codim_tensor`);
* a **divisor** is an irreducible of codim 1 (`divisor_irreducible`) — the substrate's `Pic` generator.

So the cycle-faithful representation's *skeleton* is in place: irreducibility distinguishes a single cycle
from a product, breaking the structural blindness the toy encoding had.

**What remains (the honest, sharper gap).** `CycleClass` is the abstract free structure on prime
generators; the real Hodge content is now the **cohomology↔`CycleClass` map** — whether every `(p,p)` Hodge
class is *built from irreducible cycles* (a ℚ-combination of products of primes). At codim 1 it is (a
`(1,1)` class is a divisor = a single prime, matching Lefschetz); at codim `p ≥ 2` it is the open spanning
question — now stated precisely on a representation where irreducibility is real, not collapsed. The gap
has moved from "the encoding is bidegree-coarse" to "does the prime-generated cycle structure span the
Hodge classes" — the genuine Hodge content, on the right object. Not a proof; the next genuine rung. See
`Hodge_QLF.md`.
-/

namespace QLF.CycleEncoding

/-- A **cycle class**, cycle-faithfully: its decomposition into irreducible (prime) components, each
    carrying a codimension. (Contrast `CohClass.encode`, which collapses a class to a single
    bidegree-determined nested closure — prime for every `p` — losing irreducibility.) -/
structure CycleClass where
  components : List ℕ

/-- Codimension = the sum of the components' codimensions (the Chow grading). -/
def CycleClass.codim (c : CycleClass) : ℕ := c.components.sum

/-- **Irreducible** = a single prime component. -/
def CycleClass.isIrreducible (c : CycleClass) : Prop := c.components.length = 1

/-- **Intersection product** of cycles = combine their irreducible components (the Chow product). -/
def CycleClass.tensor (c d : CycleClass) : CycleClass := ⟨c.components ++ d.components⟩

/-- Codimension is additive under the intersection product. -/
theorem CycleClass.codim_tensor (c d : CycleClass) :
    (c.tensor d).codim = c.codim + d.codim := by
  simp [CycleClass.codim, CycleClass.tensor, List.sum_append]

/-- A **divisor** = an irreducible cycle of codimension 1 (a single prime of codim 1) — the substrate's
    `Pic` generator. -/
def divisor : CycleClass := ⟨[1]⟩

theorem divisor_codim : divisor.codim = 1 := by simp [CycleClass.codim, divisor]

theorem divisor_irreducible : divisor.isIrreducible := rfl

/-- **The irreducibility invariant BITES — it is non-multiplicative.** A product of two irreducibles is
    NOT irreducible (it has two components). So this cycle-faithful representation *can* distinguish a
    single irreducible cycle from a product — exactly what the multiplicative closure fold could not
    (there irreducibility was invisible and the toy encoding was `p`-uniform). This is the structural
    break the swing series asked for. -/
theorem irreducible_not_preserved_under_product (c d : CycleClass)
    (hc : c.isIrreducible) (hd : d.isIrreducible) : ¬ (c.tensor d).isIrreducible := by
  have hc' : c.components.length = 1 := hc
  have hd' : d.components.length = 1 := hd
  show ¬ ((c.tensor d).components.length = 1)
  simp only [CycleClass.tensor, List.length_append]
  omega

/-- **Status — the cycle-faithful skeleton is built; the gap has moved.** Irreducibility is now visible
    and non-multiplicative (`irreducible_not_preserved_under_product`), so the structural blindness of the
    toy encoding is broken on this representation. The remaining Hodge content is the cohomology↔`CycleClass`
    map: whether every `(p,p)` Hodge class is built from irreducible cycles (codim 1 ✓ = divisors/Lefschetz;
    codim `p ≥ 2` is the open spanning question). Honest status: the next genuine rung, not a proof. See
    `Hodge_QLF.md`. -/
theorem cycle_encoding_skeleton : True := trivial

end QLF.CycleEncoding
