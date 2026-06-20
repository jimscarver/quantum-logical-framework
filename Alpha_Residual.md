# The α residual `+0.036` — forced bracket, and the one open weighting

Companion to [`Alpha.md`](Alpha.md) and [`lean/QLF_AlphaBound.lean`](lean/QLF_AlphaBound.lean).
[Quantum Logical Framework (QLF)](README.md) derives the **leading** inverse coupling
`α⁻¹ = 2⁷ + 3² = 128 + 9 = 137` by construction, parameter-free
([`QLF_FineStructureSubstrate`](lean/QLF_FineStructureSubstrate.lean), `alpha_QLF_eq`). The measured
(CODATA, q²→0 Thomson) value is `α⁻¹ = 137.035999`. The residual `r = +0.035999` is the open piece.

**Binding discipline (the whole point of this file).** The residual must be *derived* from the
substrate, **never tuned** to CODATA. QLF is rich in meaningful constants (`3/8`, `5`, `2/3`, `π`, …),
so a coefficient that hits `0.036` within a percent can always be found by dividing the answer by a
substrate number — that is numerology, not physics. A weighting forced by the closure structure that
*then* gives `0.036` is physics; a weighting chosen to give `0.036` is not. This file separates what is
**forced** (a two-sided bracket, exact) from what is **open** (a single weighting rule), and is explicit
about which candidates are leads versus derivations.

---

## 1. The forced bracket (two exact closed forms)

The residual is the sum of higher closure-order corrections, one bare coupling `α_bare = 1/128` per
order. Two extremal countings bound it, both exact and parameter-free:

| Counting | Closures summed | Exact tail | α⁻¹ cap | Status |
|---|---|---|---|---|
| **Total census** | every ZFA closure, `C(2n,n) = 2,6,20,70,…` | `512√62/31 − 130 ≈ 0.048130` | `137.048130` | **proven** (`censusTail_eq`, via `central_binom_genfun`) |
| **Irreducible** | prime closures only, `2·Catalan(n−1) = 2,2,4,10,…` | `126 − 16√62 ≈ 0.015874` | `137.015874` | closed form (GF `1−√(1−4x)`); formalization is a follow-on |

So, with each closure contributing positively (abelian-EM screening, `em_gauge_abelian`):

> **`263 − 16√62  <  α⁻¹  <  (217 + 512√62)/31`**, i.e. **`137.015874 < α⁻¹ < 137.048130`.**

CODATA `137.035999` sits strictly inside. The **upper** end is machine-verified
([`QLF_AlphaBound`](lean/QLF_AlphaBound.lean), `codata_below_alphaInvCap`); the **lower** exact form
`263 − 16√62` follows from the same binomial-series machinery — the value `√(31/32) = √62/8` already
falls out of `central_binom_genfun` (`(31/32)·(4√62/31) = √62/8`), so formalizing the irreducible cap is
a tractable next step.

The total counting **overshoots** (`0.0481`); the irreducible counting **undershoots** (`0.0159`). The
true residual lies between — it is neither "every closure once" nor "primes only".

---

## 2. The single open rule

Everything above is forced. The one unforced quantity is **the weighting between irreducible and total
census** — equivalently, *how strongly the composite (reducible) closures contribute*. Writing the
residual as a mix,

```
r = (1 − w)·irreducibleTail + w·totalCensusTail ,
```

the measured value fixes `w = (r − 0.015874)/(0.048130 − 0.015874) = 0.6239`.

That is the whole problem, reduced to one number: **why `w ≈ 0.624`?**

---

## 3. The gauge-projection test — and why it does *not* derive the residual

The natural mechanism: irreducible closures are abelian (pure photon — EM is the abelian sector,
`em_gauge_abelian`) and contribute fully; composite closures carry the non-abelian electroweak structure
and project onto the physical photon. The photon is the `sinθ_W` projection of the neutral SU(2) boson
(`A = cosθ_W·B + sinθ_W·W³`, so `α_em = sin²θ_W·α₂`). So the **forced** prediction of this mechanism is
composite closures screened by `sin²θ_W = 3/8`:

| composite screening | mechanism | α⁻¹ | err vs CODATA |
|---|---|---|---|
| `sin²θ_W = 3/8` | photon = `sinθ_W·W³` projection — **the natural one** | `137.027970` | **`−0.0080` (misses)** |
| `cos²θ_W = 5/8` | hypercharge/`B` projection | `137.036034` | `+0.0000` |
| gauge `2/8` | `Ω_Λ` fraction | `137.023938` | `−0.0121` |
| spatial `6/8` | 6+2 alphabet | `137.040066` | `+0.0041` |

**The natural projection (`3/8`) misses by `0.008`.** The fraction the data wants is the *complementary*
`5/8 = cos²θ_W` — which is **not** the natural photon projection (it would require composites to be
hypercharge-like, contradicting "composite = non-abelian"). And the 8-twist alphabet admits several
sub-fractions (`2/8, 3/8, 5/8, 6/8`), each giving a different answer. Without an independent rule
selecting *which* fraction and *why* it screens composite (vs irreducible) closures, the `5/8` match is a
**choice, not a derivation**.

> **Honest reversal.** The `3/8` "lead" of the previous draft does not survive. The gauge fractions do
> appear, but the gauge *projection* — taken at its natural value `sin²θ_W = 3/8` — gives `137.028`, not
> `137.036`. The earlier framing also mislabeled the data weight: the data wants composites at `5/8`, not
> `3/8`. **The gauge projection does not derive the residual.**

---

## 4. What the test *did* establish (a forced structural fact)

Working out the test surfaced an exact, parameter-free relation between the two census generating
functions:

> **`G(x) = 1 / (1 − I(x))`**, where `G(x) = ∑ C(2n,n) xⁿ = (1−4x)^(−1/2)` (total) and
> `I(x) = ∑ 2·Catalan(n−1) xⁿ = 1 − √(1−4x)` (irreducible).

This is exact (`1/√(1−4x) = 1/(1−(1−√(1−4x)))`) and it is the **Dyson / 1PI structure**: the total set of
closures is the *geometric resummation* of the prime (irreducible) closures, exactly as the full
propagator is `1/(1−Π)` of the 1PI self-energy. Combinatorially it says **every ZFA closure is uniquely
an ordered sequence of irreducible (prime) closures** — closure prime-factorization, and a *sequence*
(order matters, as twist histories are ordered) hence geometric, not exponential.

So the open rule is **not** a free "weighting between `I` and `G`" (that framing was itself
numerology-prone). It is sharper: the residual is a **partial Dyson resummation** of the prime-closure
series, and the physical truncation/regularization is what must be derived. The full resummation (`G`,
one `α_bare` per order) overshoots; one prime term (`I`) undershoots; the physical value is a specific
partial resummation whose rule is the genuine open problem.

---

## 5. Status (corrected)

- **Forced and exact:** the bracket `137.015874 < α⁻¹ < 137.048130` (upper end proven; lower end the
  closed form `263 − 16√62`, formalization pending) — and the resummation identity `G = 1/(1−I)`
  (closures = ordered sequences of primes; the value `√(31/32)=√62/8` already falls out of
  `central_binom_genfun`, so this is a tractable formalization).
- **Open:** the value. The gauge-projection derivation was **tested and fails** (natural `sin²θ_W=3/8`
  ⟹ `137.028`); the `5/8` the data wants is not forced by any gauge mechanism. The residual is a partial
  Dyson resummation whose truncation rule is underived.
- **Discipline:** no weighting is claimed. This pass *removes* a candidate (gauge projection) and
  *replaces* the loose "weighting" framing with the forced resummation structure. Honest progress is the
  reversal plus the structural fact, not a number.

Remaining derivation targets: (1) the partial-resummation / truncation rule from the closure-order
structure; (2) the curvature correction `N = d² → d² + κ` from the discrete closure-graph curvature
([`QLF_CausalDimension`](lean/QLF_CausalDimension.lean), the effective-dimension flow `3→2`), `κ` fixed by
geometry *before* comparison; (3) formalize `irreducibleTail = 126 − 16√62` and `G = 1/(1−I)` in Lean.

See [`Alpha.md`](Alpha.md), [`QLF_AlphaBound`](lean/QLF_AlphaBound.lean),
[`QLF_WeinbergAngle`](lean/QLF_WeinbergAngle.lean), [`QLF_CausalDimension`](lean/QLF_CausalDimension.lean).
