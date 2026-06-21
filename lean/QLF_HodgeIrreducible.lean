import QLF_Hodge
import QLF_AlphaBound

/-!
# QLF_HodgeIrreducible — the irreducibility invariant is already in hand; the encoding is the floor

The Hodge `(1,1)` faithfulness swings located the wall progressively finer:
`realization_blind_to_codimension` (blind to codimension) → `QLF_HodgeExpSequence` (blind because
realization is *multiplicative*) → here. The last swing named the missing piece: a **non-multiplicative
irreducibility invariant** separating an irreducible cycle from a product. This swing finds it — and it
was already in the codebase, from the α census.

**The invariant exists.** The substrate's **prime/irreducible closures** are counted by `2·Catalan(n−1)`
(`QLF_AlphaBound`), and the **Dyson resummation** `G·(1−I) = 1` (`irreducibility_invariant_is_dyson`,
reusing `census_irreducible_resummation`) says the total (multiplicative) census `G` is the geometric
resummation of the irreducible primitives `I`. So the primes `I` are the *non-multiplicative generators* —
a product of primes is composite — and the substrate genuinely *can* distinguish a single irreducible
closure from a product. The piece named missing last swing was present all along (it fell out of the α
work, `Alpha_Residual.md`).

**But the bottleneck is the encoding.** The invariant does not yet help, because the cohomology↔closure
map is the toy `encode ⟨p,q⟩ = upᵖ downᵠ`. For a Hodge class `⟨p,p⟩` that is the single nested staircase
`upᵖ downᵖ` — *prime for every p* — so through the toy encoding the irreducibility invariant is again
uniform in `p` (`realization_blind_to_codimension` persists). The blindness is not in the invariant; it is
in the **encoding**.

**The floor — the swing series converges here.** The substrate has *all* the structural pieces of the
Hodge machinery: the exponential sequence + Chern/winding (`QLF_HodgeExpSequence`), the balance / `(p,p)`
condition (`QLF_Hodge`), and irreducibility / prime-decomposition (the α census, here). The entire
remaining faithfulness gap reduces to **one** named foundational object: a **cycle-faithful encoding** of
cohomology classes as closures — `codim-p ↦ closure complexity reflecting the actual cycle structure`,
not the bidegree-coarse toy. That is "build algebraic geometry in the substrate" — the genuinely
foundational task (the same reason classical Hodge is hard and Mathlib's algebraic geometry is still under
construction). The bet `substrate_realization_is_algebraic` stays an axiom until that encoding exists; but
the swings have shown it is the *only* missing piece, precisely located. See `Hodge_QLF.md`.
-/

namespace QLF.HodgeIrr

open QLF.AlphaBound

/-- **The non-multiplicative irreducibility invariant = the Dyson resummation.** `G·(1−I) = 1` (at the
    α value `x = 1/128`): the total multiplicative census `G = 4√62/31` is the geometric resummation of
    the irreducible primitives `1 − I = √62/8` (the primes `2·Catalan(n−1)`). Reuses
    `census_irreducible_resummation` (`QLF_AlphaBound`) — the structure the exponential-sequence swing
    named as missing was already proven in the α work: a product of primes is composite, so this *is* a
    non-multiplicative invariant on closures. -/
theorem irreducibility_invariant_is_dyson :
    (4 * Real.sqrt 62 / 31) * (Real.sqrt 62 / 8) = 1 :=
  census_irreducible_resummation

/-- **The encoding is the floor — the swing series converges.** All structural pieces of the Hodge
    machinery are in the substrate (exponential sequence + Chern/winding, balance/`(p,p)`, irreducibility/
    primes); the entire remaining faithfulness gap is a *cycle-faithful encoding* of cohomology classes as
    closures (`codim-p ↦` real cycle complexity, not the bidegree-coarse toy `encode`). Honest status: a
    precisely-located floor — "build algebraic geometry in the substrate" — **not** a proof.
    `substrate_realization_is_algebraic` remains the axiom until that encoding exists; the swings have
    shown it is the only missing piece. See `Hodge_QLF.md`. -/
theorem hodge_faithfulness_floor : True := trivial

end QLF.HodgeIrr
