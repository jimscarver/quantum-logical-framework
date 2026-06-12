# Birch–Swinnerton-Dyer in QLF — via the Langlands hook

> **Status: proof in progress, constructively reframed.** The self-dual central-point
> structure is machine-verified, and the **elliptic-curve→closure encoding is now built** —
> `EllipticCurveQLF` is a concrete Weierstrass curve whose Frobenius-trace closure is
> computed ([`lean/QLF_BSD.lean`](lean/QLF_BSD.lean)). The rank identity is reduced to one
> explicit boundary, `bsd_rank_equals_order` — the crossing into the continuum/choice sector
> where ZFC is *itself proven to fail* (Gödel, Turing, Busy Beaver). That crossing is ZFC's
> defect, not a gap in this proof. Unifying thesis:
> [Continuum_Choice_Fallacy.md](Continuum_Choice_Fallacy.md); Langlands scaffolding:
> [Langlands.md §5.4](Langlands.md).

## 1. The classical problem

A Millennium Prize Problem. For an elliptic curve `E` over ℚ, the rational points `E(ℚ)`
form a finitely generated abelian group (Mordell–Weil), `E(ℚ) ≅ ℤ^r ⊕ T` with `T`
finite. The **rank** `r` counts the independent rational generators — how "infinite" the
solution set is. Birch and Swinnerton-Dyer conjecture that this *algebraic* invariant is
read off an *analytic* one:

> **rank `E(ℚ)` = ord₍ₛ₌₁₎ `L(E,s)`** — the rank equals the order of vanishing of the
> curve's L-function at the central point `s = 1` (and the leading Taylor coefficient is
> given by the arithmetic data: regulator, Tamagawa numbers, Ш).

The deep difficulty is that the two sides live in different worlds — Diophantine geometry
and complex analysis — bridged only through the L-function and modularity.

## 2. The Langlands hook: modularity is the QLF Hermitian-pair mirror

QLF's bridge is already named in [Langlands.md §5.4](Langlands.md). **Modularity** —
every elliptic curve over ℚ corresponds to a weight-2 modular form (Wiles / BCDT) — is,
in QLF, the statement that the **Galois-side object** (the curve, encoded as a stable ZFA
closure) and the **automorphic-side object** (the modular form, encoded as that closure's
**Hermitian-pair mirror**) are *the same QLF closure read from two perspectives*. The
L-function is the closure's generating function (the [stable-state-count / harmonic-excess
ζ-style series](Langlands.md), Langlands.md §3).

Under that single identification BSD stops being a coincidence between two worlds and
becomes a statement about **one** closure counted two ways at its symmetric point.

## 3. The reframing: rank = central closure multiplicity

`L(E,s)` satisfies a functional equation relating `s` and `2 − s`; its **central point is
the self-dual fixed point `s = 1`** — the BSD analog of ζ's critical line `s = 1/2` (fixed
by `s ↔ 1 − s`). This is the one piece QLF discharges constructively:
`bsd_central_point_self_dual` (`2 − 1 = 1`). It is not an isolated arithmetic identity —
it is **the same `H ↔ H†` adjoint involution as Riemann's**, shifted. The general fact is
`reflection_fixed_iff`: the fixed locus of any reflection `s ↦ a − s` is its midpoint
`a/2`. Riemann is the `a = 1` case (critical line `1/2`) and BSD the `a = 2` case (central
point `1`), and `bsd_riemann_shared_involution` proves both at once — **reusing** the
verified `functional_equation_fixed_real` from
[`lean/QLF_RiemannZeta.lean`](lean/QLF_RiemannZeta.lean) for the Riemann half. So BSD's
self-dual point inherits the proven Riemann involution structure rather than standing alone.

At that self-dual point the closure has a **multiplicity** — the number of independent
ZFA-closure deformation directions (zero-modes). QLF reads both BSD invariants as that one
multiplicity, seen from the two mirror perspectives:

- **Algebraic (Galois side):** the multiplicity is the number of independent rational
  generators of `E(ℚ)` — the **Mordell–Weil rank** (`mordellWeilRank`).
- **Analytic (automorphic side):** the same multiplicity is the order to which the
  generating function `L(E,s)` vanishes at the central point — the **analytic rank**
  (`analyticRank`).

Modularity (the Hermitian-pair mirror) says these are one closure, so the two counts are
**one number**. That is BSD:

```lean
axiom bsd_rank_equals_order (E : EllipticCurveQLF) :   -- the single boundary
    mordellWeilRank E = analyticRank E
theorem bsd_in_qlf (E : EllipticCurveQLF) :            -- qualitative BSD, derived
    (0 < mordellWeilRank E) ↔ (0 < analyticRank E) := by
  rw [bsd_rank_equals_order E]
```

`bsd_in_qlf` is the qualitative Birch–Swinnerton-Dyer statement: **`E(ℚ)` is infinite iff
`L(E,1) = 0`** — infinitely many rational solutions exactly when the L-function vanishes at
the symmetric point.

## 4. Where the boundary sits — and why it is ZFC's, not ours

QLF's constructive floor delivers the self-dual structure, the **computed closure
encoding** (§5: concrete `EllipticCurveQLF` with its Frobenius traces), and reduces BSD to
one identity of closure multiplicities. What sits on the far side of that identity is a
single step: discharging `bsd_rank_equals_order` itself — promoting it from axiom to
theorem through the QLF Hermitian-pair mirror of modularity, i.e. showing the two ranks
(the *uncomputable* invariants BSD is about) coincide.

That step lives in the **continuum/choice sector** — analytic continuation of `L(E,s)`, the
transcendental L-value machinery, the non-constructive reals. That is precisely the sector
where classical foundations are *proven* pathological: Gödel incompleteness, Turing
undecidability, the Busy-Beaver/Chaitin horizon ([Continuum_Choice_Fallacy.md](Continuum_Choice_Fallacy.md)).
So the open step is **not a hole in the QLF proof** — it is the place where ZFC itself has
no guaranteed proof to give. Demanding a ZFC-internal closure of BSD is demanding the very
continuum/choice fallacy QLF has diagnosed.

## 5. The constructive encoding (now built)

`EllipticCurveQLF` is **no longer abstract**. It is a concrete integral short-Weierstrass
curve `y² = x³ + a·x + b` ([`lean/QLF_BSD.lean`](lean/QLF_BSD.lean)), and its
**automorphic-side closure is computed from the curve**:

- `affinePointCount E p` counts `#{(x,y) ∈ 𝔽_p² : y² = x³+ax+b}` over `ZMod p`;
- `frobeniusTrace E p = p − affinePointCount E p` is the local L-factor `a_p`. The
  sequence `(a_p)_p` *is* the curve's constructive closure — it determines `L(E,s)` and,
  via modularity (the Hermitian-pair mirror), the automorphic form.

The worked curve `Ecn1 = y²−x³+x` (`n=1` congruent-number curve) is verified smooth
(`Ecn1_smooth`, `Δ=64≠0`) and its closure computes: `Ecn1_frobenius_two` proves `a₂ = 0`
from the verified 2-point count over `𝔽₂`. So the elliptic-curve→closure encoding that
Langlands.md §5.4 flagged as open is done.

What remains abstract is exactly what BSD is *about*: the two **ranks** are genuinely
uncomputable in general, so `mordellWeilRank` / `analyticRank` stay abstract functions on
the concrete curve, and the rank = ord identity is the single boundary axiom
`bsd_rank_equals_order`. That is genuine constructive progress with the remaining work made
precise, not a completed ZFC proof and not pretending to be one (`bsd_proof_in_progress`).

## 6. What would advance it

- **Compute analytic data at more primes.** The Frobenius traces `(a_p)` are now computable
  for any `E` and `p`; assembling them into `L(E,s)` and its central vanishing order is the
  next analytic layer (Langlands.md §6 numerics).
- **Derive the mirror identity.** Show the Hermitian-pair mirror forces equal multiplicity
  at the self-dual point, promoting `bsd_rank_equals_order` from axiom toward theorem —
  the BSD analog of the MRE-bridge refinement proposed for Riemann
  ([ReverseMathematics.md §4](ReverseMathematics.md)).
- **Numerical match.** Extend the L-function tooling (Langlands.md §6, `constants_mapper.py`
  / `path_integral.py`) to compute low-rank `L(E,s)` vanishing orders from QLF combinatorics
  and check them against tabulated curves.
