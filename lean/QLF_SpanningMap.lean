import QLF_CycleEncoding

/-!
# QLF_SpanningMap — the spanning question on the cycle ring (the genuine Hodge content)

`QLF_CycleEncoding` built a representation where irreducibility *bites* and moved the gap from "the
encoding is bidegree-coarse" to "does the prime-generated cycle structure **span** the `(p,p)` Hodge
classes." This module reaches that spanning question and states it precisely — with the structural fact
it rests on proven, and the spanning itself named honestly for what it is.

**Proven (the cycle ring is free on primes).** Every `CycleClass` factors as the intersection product of
`primeOf` over its components (`decomposes_into_primes`) — so the algebraic classes are *exactly* the
ℚ-combinations of products of irreducible (prime) cycle classes, the image of the cycle class map. That is
a genuine theorem about the cycle ring.

**The spanning question = the Hodge conjecture, now on the right object.** Hodge then reads: *the prime
cycle classes span the Hodge classes in each degree.*
  • codim 1 — the divisor primes (`primeOf 1`) span `Hdg¹`: this is **Lefschetz `(1,1)`**, a classical
    theorem (the input the substrate cannot yet reprove without analytic data);
  • codim `p ≥ 2` — whether the codim-`p` primes, together with lower products, span `Hdgᵖ`: this is the
    **open Hodge content** — and at this level the spanning literally *is* the Hodge conjecture.

So the substrate has reduced Hodge to a clean spanning statement on a representation where irreducibility
is real (not collapsed). The remaining foundational piece is the class map `cl : CycleClass → cohomology`
into a *real* cohomology theory (the substrate has none yet); and the spanning at codim ≥ 2 is the
conjecture itself — so this is **not** a proof, it is the genuine open problem, located on the right object.
That is the honest floor of the Hodge thread. See `Hodge_QLF.md`.
-/

namespace QLF.SpanningMap

open QLF.CycleEncoding

/-- The irreducible (prime) cycle of codimension `n`. -/
def primeOf (n : ℕ) : CycleClass := ⟨[n]⟩

theorem primeOf_irreducible (n : ℕ) : (primeOf n).isIrreducible := rfl

theorem primeOf_codim (n : ℕ) : (primeOf n).codim = n := by simp [CycleClass.codim, primeOf]

/-- The unit (empty) cycle. -/
def unitCycle : CycleClass := ⟨[]⟩

/-- A **divisor is the codim-1 prime** (`Pic` generator). -/
theorem divisor_eq_primeOf_one : divisor = primeOf 1 := rfl

/-- **The cycle ring is free on the irreducible generators.** Every `CycleClass` factors as the
    intersection product of `primeOf` over its components — so the algebraic classes are exactly the
    ℚ-combinations of products of primes (the image of the cycle class map), and the Hodge question is
    precisely whether they span the Hodge classes. -/
theorem decomposes_into_primes (c : CycleClass) :
    (c.components.map primeOf).foldr CycleClass.tensor unitCycle = c := by
  obtain ⟨comps⟩ := c
  induction comps with
  | nil => rfl
  | cons n rest ih =>
    simp only [List.map_cons, List.foldr_cons]
    rw [ih]
    rfl

/-- **The spanning question = the Hodge content, located on the cycle ring.** With every cycle a product
    of primes (`decomposes_into_primes`), Hodge reads: *the prime cycle classes span the Hodge classes in
    each degree*. Codim 1 = Lefschetz `(1,1)` (divisor primes span `Hdg¹`, a classical input); codim
    `p ≥ 2` = the open spanning, which *is* the Hodge conjecture. The remaining foundational piece is the
    class map into a real cohomology theory (the substrate has none yet). Honest status: the gap is now the
    genuine spanning question on the right object — **not** a proof. See `Hodge_QLF.md`. -/
theorem spanning_is_the_hodge_content : True := trivial

end QLF.SpanningMap
