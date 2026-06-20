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

## 3. Candidate rules (leads, not derivations)

| Candidate weighting | mechanism | α⁻¹ | err vs CODATA | honest status |
|---|---|---|---|---|
| **gauge fraction** `w = 5/8` (reducibles screened by `3/8`) | composite closures enter at the alphabet/gauge fraction `3/8 = sin²θ_W` — **α's own `3+2`-of-`8` split** | `137.036034` | `+3.5×10⁻⁵` | **lead**: the coefficient is not arbitrary — it is the same `3/8` behind `α`, `Ω_Λ`, `sin²θ_W`; but `3/8`-screens-reducibles is *matched*, not derived |
| self-consistent `α⁻¹ = 137 + m/α⁻¹`, `m = 5` | screening multiplicity = angular DOF (`total_angular_DOF_eq_five`) | `137.036487` | `+4.9×10⁻⁴` | weaker: `m=5` is the nearest integer to `4.93`; the link to the angle count is suggestive only |
| flat midpoint `w = 1/2` | none | `137.032002` | `−4.0×10⁻³` | rejected: no mechanism, and outside data |

The **gauge-fraction** rule is the lead worth pursuing: `3/8` is α's structural constant, so "composite
closures contribute at the gauge fraction" is *of a piece* with the rest of the framework, not a free
parameter — and it lands within `3.5×10⁻⁵` of CODATA. **But it is a lead, not a result.** The bracket
(§1) is forced; the `3/8` weighting is read off the data. The residual-of-the-residual `+3.5×10⁻⁵` is
itself unexplained (a further order). Stated plainly: the value is **not yet derived**.

---

## 4. What turns a lead into physics

A candidate counts only once its weighting is **forced** from the closure-order structure, before
comparison to CODATA. Concrete derivation targets:

1. **Gauge projection.** Derive that reducible (composite) closures are screened by `3/8` directly from
   [`QLF_GaugeUnification`](lean/QLF_GaugeUnification.lean) / [`QLF_WeinbergAngle`](lean/QLF_WeinbergAngle.lean)
   — the same `3+2`-of-`8` projection that fixes `sin²θ_W`. If the composite-closure screening *is* the
   gauge projection, `w = 5/8` is forced and the lead becomes a derivation.
2. **Curvature.** The flat directional count `N = d² = 9` acquires a curvature correction on the closure
   graph ([`QLF_CausalDimension`](lean/QLF_CausalDimension.lean), the effective-dimension flow `3→2`).
   Derive the correction `9 → 9 + κ` from the discrete curvature and read off `κ` — no comparison to the
   target until `κ` is fixed by geometry.
3. **Irreducible-cap formalization.** Prove `irreducibleTail = 126 − 16√62` (the GF `1−√(1−4x)` at
   `x = 1/128`) in Lean, making the **lower** bracket end rigorous and the forced bracket fully
   machine-verified end-to-end.

---

## 5. Status

- **Forced and exact:** the bracket `137.015874 < α⁻¹ < 137.048130` (upper end proven; lower end a
  closed form, formalization pending). The residual is bracketed by two parameter-free √62 expressions.
- **Open:** the value — equivalently the one weighting `w ≈ 0.624`. The leading candidate (`w = 5/8`,
  composite closures at the gauge fraction `3/8`) lands at `137.036034`, but is matched, not derived.
- **Discipline:** no weighting is claimed as the answer. The deliverable here is the *reduction* —
  `+0.036` is now one forced bracket plus one open rule, and that rule points at α's own gauge fraction.

See [`Alpha.md`](Alpha.md), [`QLF_AlphaBound`](lean/QLF_AlphaBound.lean),
[`QLF_WeinbergAngle`](lean/QLF_WeinbergAngle.lean), [`QLF_CausalDimension`](lean/QLF_CausalDimension.lean).
