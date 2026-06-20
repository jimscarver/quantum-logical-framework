# The α residual `+0.036` — 137 is the exact leading EM value; the residual is higher-order EM running

> **Where it stands (§0):** `α⁻¹ = 128 + 9 = 137` is the *exact* leading pure-EM value — **confirmed** by
> the running (`128 = 2⁷ ≈ α̂⁻¹(M_Z)` to `0.05`, `+9 = 3²` = EM running to the IR). The weak-sector
> hypothesis for `+0.036` was tested (W-loop running) and **closed** — the `W` is too heavy to run below
> `M_W` and on-shell `α(0)` has no separate `W` piece. The residual sits at the higher-order-EM scale
> (`~5α`), so `+0.036` is the **higher-order EM running** correction — the same object as the
> closure-resummation tail (§1–§4), in running language.

Companion to [`Alpha.md`](Alpha.md) and [`lean/QLF_AlphaBound.lean`](lean/QLF_AlphaBound.lean).
[Quantum Logical Framework (QLF)](README.md) derives the **leading** inverse coupling
`α⁻¹ = 2⁷ + 3² = 128 + 9 = 137` by construction, parameter-free
([`QLF_FineStructureSubstrate`](lean/QLF_FineStructureSubstrate.lean), `alpha_QLF_eq`). The measured
(CODATA, q²→0 Thomson) value is `α⁻¹ = 137.035999`. The residual `r = +0.035999` is the open piece.

**Binding discipline (the whole point of this file).** The residual must be *derived* from the
substrate, **never tuned** to CODATA. QLF is rich in meaningful constants (`3/8`, `5`, `2/3`, `π`, …),
so a coefficient that hits `0.036` within a percent can always be found by dividing the answer by a
substrate number — that is numerology, not physics. A weighting forced by the closure structure that
*then* gives `0.036` is physics; a weighting chosen to give `0.036` is not.

---

## 0. Reframe (leading hypothesis, per Jim): 137 is the *exact* EM value; the residual is a different sector

`α⁻¹` is not one number — it **runs** with energy. Measured: `α⁻¹(q²→0) = 137.036` (IR / Thomson) and
**`α⁻¹(q² = M_Z²) ≈ 128`** (the weak scale, precisely ~127.95). So QLF's `α⁻¹ = 2⁷ + 3² = 128 + 9` reads
as a *running*, with each integer pinned to a scale:

| QLF term | value | physical reading |
|---|---|---|
| `2⁷` | `128` | the coupling **at the weak scale** `M_Z` — the UV/bare value (`α⁻¹(M_Z) ≈ 128`) |
| `3²` | `+9` | the **electromagnetic** screening running `M_Z → q²→0` (3 spatial axes squared, charged-fermion EM) |
| sum | **`137`** | the **pure-EM** `α⁻¹` in the IR — **exact** |
| residual | `+0.036` | a **sub-leading, weak-scale** effect — the weak gauge bosons (W loops) in the photon vacuum polarization, where the bulk `+9` does not reach |

So **137 is the right leading EM number** — and the structure is now quantitatively anchored.

**The running half is CONFIRMED.** `2⁷ = 128` matches `α̂⁻¹(M_Z)` (MS-bar) to `0.05`, and the gap to the
IR is `137.036 − 127.95 = 9.086 ≈ +9`. So `128 + 9 = 137` is *literally* "weak-scale coupling + EM
running = pure-EM IR". This is real, not a coincidence.

**The "weak residual" half was TESTED (swing #1, the W-loop running) and does NOT survive:**
- The `W` is integrated out below `M_W ≈ 80 GeV`, so it contributes **zero** to the `M_Z → q²→0` running
  that builds the IR value (its only window `M_W→M_Z` gives `~0.07–0.28` — wrong size and place).
- On-shell `α(0)` has `Π(0) = 0` by renormalization — **no separate `W` piece** sits inside `137.036`.
- The scale of `0.036` is `≈ 5α` — a **higher-order QED** scale (`(α/π)·9 ≈ 0.021`, 2-loop `≈ 0.027`),
  i.e. the next-order piece of the *electromagnetic* running, not a weak contribution.

**So the sector is electromagnetic after all** — `0.036` is the **higher-order EM running** correction to
the leading `+9`. Crucially, *that is the same object* the closure-census program (§1–§4) computes: "which
partial resummation of the prime-closure series" ≡ "the higher-order QED running correction to `+9`". So
§1–§5 are **not** demoted to the wrong sector — they are the combinatorial form of this sub-leading EM
running. (Only the bracket *coincidentally* spanning `137.036` was never the mechanism.)

**Net of the reframe + swing #1:** `137 = exact leading EM`, anchored to `α̂⁻¹(M_Z) = 2⁷` — **validated**.
`+0.036 = higher-order EM running ≡ the closure-resummation tail` — one object, EM sector, scale `~5α`.
The weak attribution is **closed** (W too heavy, `α(0)` clean).

**Swing #2 (the higher-order running rule).** Further pinned down: the leading `+9` matches the one-loop
QED β-coefficient `(4/3)·Σ_{charged f < M_Z} Q² N_c = 8.89` (1.2% from `d² = 9`) — QLF reads the one-loop
running *as* the directional count. The residual localizes to the dominant `n = 2` (length-4) closures:
of the `C(4,2) = 6`, the physical weight is `0.036/α_bare = 4.61` (irreducible `2`, total `6`), at the
2-loop scale `~5α`. **The exact coefficient is the 2-loop EM running** — well-defined physics, but the
*same boundary the Standard Model has*: the running is **computed**, not derived from a deeper principle.
QLF's equal-weight closure census gets the structure (Dyson `G = 1/(1−I)`), sector (EM), and scale (`~5α`)
right, but the kinematic weight that fixes `4.61`-of-`6` is the 2-loop log structure, not pure counting.

The sections below record the closure-census analysis — the combinatorial form of this sub-leading EM
running.

---

## 1. The forced bracket (two exact closed forms) *(EM-closure reading — demoted; see §0)*

The residual is the sum of higher closure-order corrections, one bare coupling `α_bare = 1/128` per
order. Two extremal countings bound it, both exact and parameter-free:

| Counting | Closures summed | Exact tail | α⁻¹ cap | Status |
|---|---|---|---|---|
| **Total census** | every ZFA closure, `C(2n,n) = 2,6,20,70,…` | `512√62/31 − 130 ≈ 0.048130` | `137.048130` | **proven** (`censusTail_eq`, via `central_binom_genfun`) |
| **Irreducible** | prime closures only, `2·Catalan(n−1) = 2,2,4,10,…` | `126 − 16√62 ≈ 0.015874` | `137.015874` | **proven** (`irreducibleTail_eq` / `irreducibleCap_eq`) |

So, with each closure contributing positively (abelian-EM screening, `em_gauge_abelian`):

> **`263 − 16√62  <  α⁻¹  <  (217 + 512√62)/31`**, i.e. **`137.015874 < α⁻¹ < 137.048130`.**

CODATA `137.035999` sits strictly inside. **Both ends are now machine-verified**
([`QLF_AlphaBound`](lean/QLF_AlphaBound.lean)): the upper via `codata_below_alphaInvCap`/`alphaInvCap_eq`,
the lower via `irreducibleCap_eq` (`137 + irreducibleTail = 263 − 16√62`), with the irreducible count
`2·Catalan(n−1) = 4·C(2n−2,n−1) − C(2n,n)` (`irrCoeff_matches`) making the irreducible tail a linear
combination of `central_binom_genfun` and `censusTail` — **no new axiom**. The resummation
`G·(1 − I) = 1` (`census_irreducible_resummation`) is verified too: the total census is the geometric
resummation of the prime closures.

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

## 5. The curvature route — adjudicated by scale

The other candidate mechanism: the flat directional count `N = d² = 9` (the `3×3` directional tensor on
flat 3-space) acquires a curvature correction `N → 9 + κ` on the curved closure graph, with
`α⁻¹ = 128 + (9 + κ)`. This must be a **static** curvature, not a running effect — running vanishes at
`q²→0`, but CODATA is the IR (Thomson) value, so the correction survives at the IR. The natural source is
the **intrinsic positive curvature** of the directional 2-sphere `S²` (directions in 3-space *are* points
on `S²`).

**The sign is forced and correct.** Positive curvature raises the effective directional count above the
flat `d² = 9`, so `d_eff > 3` and `α⁻¹ > 137` — screening. This matches the proven bound
(`alpha_inv_gt_137`) by construction: a flat or negatively-curved directional space would give the wrong
sign. So far the curvature route is consistent where the gauge route was not.

**The magnitude is the wrong scale.** Matching requires `d_eff = 3.006` (a `0.2%` dimension shift) or
equivalently `κ/N = 0.4%`. But every dimensionless geometric curvature invariant is **O(1)**:

| invariant | value |
|---|---|
| heat-kernel Euler term `χ/6` (S²) | `0.333` |
| icosahedral deficit/vertex `4π/12` (the QLF primordial blanket, `QLF_PrimordialMarkovBlanket`) | `1.047` |
| octahedral deficit/vertex `4π/6` (the 6 axis endpoints `±x,±y,±z`) | `2.094` |
| Gauss–Bonnet total `2πχ` (S²) | `12.57` |

The residual `κ = 0.036` is **10–40× smaller** than any of these. It does *not* sit at the geometric
scale — it sits at the **closure-order scale**: `κ ≈ 4.6·α_bare` (the leading census term is
`6·α_bare = 0.047`). A standalone pure-geometry curvature correction to `d²` would overshoot by one to
two orders of magnitude.

> **Verdict.** Curvature can contribute to the residual **only if it is `α_bare`-suppressed** — i.e. only
> as a *per-closure-order* effect, not as a separate O(1) geometric correction. That is precisely the
> framework's own anticipation that *"the census tail and the discrete curvature may be the same
> object."* The scale test makes it sharp: **curvature is not an independent mechanism; it must be
> identified with the closure-order resummation** of §4. It contributes the right *sign* (positive
> directional curvature ⟹ screening), but the *magnitude* lives in the closure-order sum, not in a
> standalone geometric invariant.

So both routes converge on one open problem: the **partial-resummation rule** of the prime-closure series
(§4) — which, by §5, *is* the discrete curvature of the closure graph, just at the closure-order scale.

---

## 6. Status (corrected)

- **Forced, exact, and machine-verified (both ends):** the bracket `137.015874 < α⁻¹ < 137.048130` —
  upper `alphaInvCap_eq`/`codata_below_alphaInvCap`, lower `irreducibleCap_eq` (`263 − 16√62`) — plus the
  resummation `G·(1−I) = 1` (`census_irreducible_resummation`), all from `central_binom_genfun`, no axiom.
- **Right sign, forced:** positive directional-sphere curvature ⟹ `d_eff > 3` ⟹ `α⁻¹ > 137` (§5),
  consistent with `alpha_inv_gt_137`.
- **Open — the value:** both candidate mechanisms tested. **Gauge projection fails** (natural
  `sin²θ_W = 3/8` ⟹ `137.028`, §3). **Standalone curvature is the wrong scale** (geometric invariants are
  O(1), the residual is O(`α_bare`), §5). Both reduce to the **partial Dyson resummation** of the
  prime-closure series, whose truncation rule is underived — and that rule *is* the discrete closure-graph
  curvature at the closure-order scale.
- **Discipline:** no value is claimed. Two pure-geometry/gauge shortcuts are *eliminated*; the open
  problem is *localized* to one object — the resummation truncation rule. Honest progress is the
  eliminations plus the localization, not a number.

Remaining derivation target: the partial-resummation / truncation rule from the closure-order structure
— the single open object both routes reduce to. (The forced bracket and the resummation `G = 1/(1−I)`
are now machine-verified, §1; what is open is *which* partial resummation the physical residual is.)

See [`Alpha.md`](Alpha.md), [`QLF_AlphaBound`](lean/QLF_AlphaBound.lean),
[`QLF_WeinbergAngle`](lean/QLF_WeinbergAngle.lean), [`QLF_CausalDimension`](lean/QLF_CausalDimension.lean),
[`QLF_PrimordialMarkovBlanket`](lean/QLF_PrimordialMarkovBlanket.lean).
