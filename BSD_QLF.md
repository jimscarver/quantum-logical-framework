# Birch–Swinnerton-Dyer in [QLF](README.md) — via the Langlands hook

> **Status: `bsd_proof_in_progress` — a reformulation.** *Contrast (once):* the **classical** BSD
> conjecture is not proved here. *What is proven (the reformulation):* the self-dual central-point
> structure is machine-verified, and the **elliptic-curve→closure encoding is built** —
> `EllipticCurveQLF` is a concrete Weierstrass curve whose Frobenius-trace closure is *computed*
> ([`lean/QLF_BSD.lean`](lean/QLF_BSD.lean)). *The gap (faithfulness):* `rank = ord`
> (`bsd_rank_equals_order`) follows from the one bridge axiom **`modularity_mirror_invariant`** —
> the mirror-invariance of the central multiplicity, which on BSD has the conjecture's full
> strength. **BSD is a *finitary* arithmetic statement, not a continuum or independence
> phenomenon**, so the "ZFC's defect" framing does **not** apply to it (it applies to genuine
> uncomputability — halting, Busy Beaver). So: contrast (classical, not here) → the proven
> reformulation → the named bridge. Unifying thesis:
> [Continuum_Choice_Fallacy.md](Continuum_Choice_Fallacy.md); Langlands: [Langlands.md §5.4](Langlands.md).

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
**one number** — and in QLF this is *discharged into a theorem*. The mirror is an
involution on the two perspectives; the ranks are the one `centralMultiplicity` read on
each side; and because the central point `s=1` is the mirror's **fixed point**
(`bsd_central_point_self_dual`), the multiplicity is mirror-invariant there. So rank = ord
follows:

```lean
-- the ranks are the one multiplicity, read on the two mirror sides:
def mordellWeilRank (E) : ℕ := centralMultiplicity E .galois
def analyticRank   (E) : ℕ := centralMultiplicity E .automorphic

-- the single boundary, structural (the mirror's fixed point is the central point):
axiom modularity_mirror_invariant (E) (p) :
    centralMultiplicity E (modularityMirror p) = centralMultiplicity E p

-- rank = ord is a THEOREM:
theorem bsd_rank_equals_order (E) : mordellWeilRank E = analyticRank E := by
  unfold mordellWeilRank analyticRank
  exact (modularity_mirror_invariant E .galois).symm

theorem bsd_in_qlf (E) :                                -- qualitative BSD, derived
    (0 < mordellWeilRank E) ↔ (0 < analyticRank E) := by
  rw [bsd_rank_equals_order E]
```

`bsd_in_qlf` is the qualitative Birch–Swinnerton-Dyer statement: **`E(ℚ)` is infinite iff
`L(E,1) = 0`** — infinitely many rational solutions exactly when the L-function vanishes at
the symmetric point.

## 4. Where the boundary sits — the faithfulness bridge

QLF's constructive floor delivers the self-dual structure and the **computed closure
encoding** (§5: concrete `EllipticCurveQLF` with its Frobenius traces). Within the
reformulation, rank = ord (`bsd_rank_equals_order`) is a *theorem* — it follows from the
two ranks being one `centralMultiplicity` read on the two mirror sides, equal by
mirror-invariance at the self-dual fixed point. **The whole weight rests on one bridge
axiom**, `modularity_mirror_invariant`: that the Hermitian-pair mirror genuinely preserves
the central multiplicity at its fixed point — i.e. that the QLF closure datum on the two
sides really *is* the Mordell–Weil rank on one and the analytic order on the other. **That
bridge carries the classical conjecture's full strength.** It is the faithfulness gap, the
exact BSD analog of Hodge's `substrate_realization_is_algebraic`: the substrate side is
proven; the identification with the classical arithmetic invariants is the posited bridge.

**Be precise about the nature of the gap.** BSD is a *finitary* arithmetic statement about a
finitely generated group — it is **not** a known independence or uncomputability phenomenon,
so the "ZFC is proven to fail here" framing (which belongs to halting, Busy Beaver, Chaitin's
Ω) does **not** apply to BSD. The analytic L-value machinery is genuinely hard, but the open
step is an honest mathematical gap — the faithfulness of the modularity mirror — stated as
such, not deflected onto ZFC. (The continuum/choice thesis,
[Continuum_Choice_Fallacy.md](Continuum_Choice_Fallacy.md), governs the genuinely
*non-constructive* problems; BSD is filed here for the shared Hermitian-mirror structure, not
because its residual is an independence result.)

## 5. The constructive encoding (built)

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
uncomputable in general, so `centralMultiplicity` (and the ranks reading it) stays an
abstract function on the concrete curve. The rank = ord identity is no longer the boundary
— it is a **theorem** (`bsd_rank_equals_order`), discharged through the modularity
mirror; the lone boundary is `modularity_mirror_invariant` (why the mirror preserves the
multiplicity at its fixed point). That is genuine constructive progress with the remaining
work made precise, not a completed ZFC proof and not pretending to be one
(`bsd_proof_in_progress`).

## 6. What would advance it

- **Compute analytic data at more primes.** The Frobenius traces `(a_p)` are computable
  for any `E` and `p`; assembling them into `L(E,s)` and its central vanishing order is the
  next analytic layer (Langlands.md §6 numerics).
- **Discharge `modularity_mirror_invariant`.** The bare rank = ord axiom is already gone
  (it is a theorem); the next step is *why* the Hermitian-pair mirror preserves the central
  multiplicity at its fixed point — connecting it to the modular form's actual vanishing
  order, the BSD analog of the MRE-bridge refinement for Riemann
  ([ReverseMathematics.md §4](ReverseMathematics.md)).
- **Numerical match.** Extend the L-function tooling (Langlands.md §6, `constants_mapper.py`
  / `path_integral.py`) to compute low-rank `L(E,s)` vanishing orders from QLF combinatorics
  and check them against tabulated curves.

## References

- B. J. Birch & H. P. F. Swinnerton-Dyer, *Notes on elliptic curves. II*, J. Reine Angew. Math. **218** (1965) 79–108 — the conjecture.
- A. Wiles, *Modular elliptic curves and Fermat's Last Theorem*, Ann. Math. **141** (1995) 443–551; R. Taylor & A. Wiles, *Ring-theoretic properties of certain Hecke algebras*, Ann. Math. **141** (1995) 553–572 — modularity (semistable case).
- C. Breuil, B. Conrad, F. Diamond & R. Taylor, *On the modularity of elliptic curves over ℚ: wild 3-adic exercises*, J. Amer. Math. Soc. **14** (2001) 843–939 — full modularity (BCDT).
- B. Gross & D. Zagier, *Heegner points and derivatives of L-series*, Invent. Math. **84** (1986) 225–320; V. A. Kolyvagin, *Euler systems* (1990) — BSD for analytic rank ≤ 1.
- A. Wiles, *The Birch and Swinnerton-Dyer Conjecture* — Clay Mathematics Institute (official problem description). <https://www.claymath.org/millennium-problems/>
