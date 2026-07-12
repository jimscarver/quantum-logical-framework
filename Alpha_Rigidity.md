# α-Rigidity — why 137 is the *only* reachable value, and the quantified look-elsewhere

**Status:** motivation-first design doc (Step 0). This document exists *before* the Lean enumeration
(`lean/QLF_AlphaRigidity.lean`, staged — not yet created) deliberately: every constraint on the
admissible-derivation grammar is motivated here **without reference to the value 137**, so the git
history itself shows motivation preceding enumeration. A constraint added because it excludes a rival
is the look-elsewhere effect moved up one level; a referee reads the commit order in exactly that way.

The target is **rigidity, not existence**: [QLF](README.md) already *derives* `α⁻¹ = 137`
([`Alpha.md`](Alpha.md), [`QLF_FineStructureSubstrate`](lean/QLF_FineStructureSubstrate.lean)); the
question here is whether, inside a frozen substrate-motivated grammar of derivations, **any other value
is reachable at all.** If not, the framework cannot chase a moving measurement — had the value come out
136, QLF would be *refuted*, not revised. That is the machine-checkable anti-Eddington statement.

---

## 1. The construction, operation by operation (each motivated 137-independently)

The derived inverse coupling is `α⁻¹ = 128 + 9 = 2⁷ + 3²`. Every operation traces to a substrate
principle stated without knowing the answer:

| Piece | Value | 137-independent motivation | Anchor |
|---|---|---|---|
| closure baseline | `1/16` | per-event probability of forming any of the 4 base half-spin closures from the 8-twist alphabet | `naive_closure_rate` |
| gauge selectivity | `1/4` | only `+−` of the 4 base closures is the U(1) gauge fold that mediates Coulomb binding | `gauge_selectivity` |
| phase coherence | `1/2` | binary in-phase/out-of-phase selectivity for advancing orbital phase | `phase_coherence` |
| co-location | `1` | guaranteed at the binding scale (`λ_binding/2 ≫ a₀`) — no penalty | `spatial_colocation` |
| **α_bare** | `1/128 = 2⁻⁷` | the **product** of the four selectivities | `alpha_bare` |
| directional modes | `9 = 3²` | the `d×d` input×output directional-coupling tensor at `d =` the minimal faithful spatial dimension `3` | `N_directional_modes` |
| resummation | `+N` | the self-energy / vacuum-polarization-like resummation `α_bare/(1+Nα_bare)` ⟹ `α⁻¹ = 1/α_bare + N` | `alpha_QLF` |

None of these rows mentions 137; the value is the output of running them. The `3` is the *minimal
faithful rendering dimension* ([`SpaceTime.md`](SpaceTime.md) §3a), not a fit — a 2-D substrate would
give `N=4` (`128+4`), a 4-D substrate `N=16` (`128+16`); only 3-D lands at the measured coupling.

## 2. The frozen derivation grammar (the corrected constructors)

The rigidity claim is only as strong as the grammar is honest: **every extra constructor inflates the
reachable set and weakens the census `N(d)`**, so the grammar must be *exactly* the operations §1 uses —
no more. Correcting the first-draft skeleton against the real construction:

- **Leaves:** the substrate primitives that actually appear as values — the selectivity factors
  (`16, 4, 2, 1`, i.e. powers of 2) and the axis count `3`. The alphabet cardinality `8` and the
  spatial-split `6` are *structural inputs* to the selectivities, **not** value-leaves of the α⁻¹
  expression — they were in the first-draft skeleton and are **dropped** (they would inflate the census
  without appearing in the real derivation).
- **Operations:** `prod` (the selectivity product → `128`), `pow` (`3²` for `N`; the selectivities as
  powers of 2), and `sum` (the resummation, `128 + 9`, at the inverse-coupling level). Nothing else.
- **Values are count-pairs (`ℚ` as two finite integers).** Approaching `1/3` or `π` costs no infinite
  bits anywhere — a ratio is two finite counts; the binary expansion is display, not ontology. The
  integer-layer α⁻¹ claim lives in numerators with denominator 1.

**Admissibility constraints** (each must earn its keep — §4 exhibits, per constraint, a rival it
excludes; a constraint with no such witness is gerrymandering):
- *uses the full alphabet* — the derivation consumes the whole 8-twist structure (not a sub-alphabet);
- *respects the 6+2 split* — the spatial/internal partition is honored;
- *is a dimension count* — the expression counts dimensions of the specified closure structure (the α
  object), not an unrelated quantity;
- *bounded depth* — justified from the construction's own length, **not** from what a larger bound would
  admit.

## 3. The realization postulate P1 — the single physical premise (an explicit `axiom`)

The elementarity half of the argument rests on one premise, and it is marked as an `axiom` at the Lean
level so the axiom-checker always reports it:

> **P1 (realization).** Every arithmetic factorization of the closure count of an **independently
> existing (ZFE-closed) system** is realized by an available decomposition into independent
> sub-receipts.

Three 137-independent motivations (prose here, never in the Lean):
- **Tensor factorization** of composite-dimension closure spaces — the isomorphism `ℂ^{ab} ≅ ℂ^a ⊗ ℂ^b`
  always exists. *Caveat that is exactly why P1 is a postulate, not a theorem:* physics need not respect
  any *particular* factorization (the isomorphism is non-canonical), so realization is a physical
  commitment, not a mathematical entailment.
- **MUB / stabilizer completeness** at prime(-power) dimension — the resource-theoretic sense in which
  prime dimension is indecomposable.
- **QLF-native — independent existence = ZFE closure.** What exists independently is what *closes*;
  closure is where atomicity is decided. **Unterminated ledgers (free charge) are not independent
  existents**, so P1 quantifies only over closed systems and free charges are outside its domain
  entirely. This is the resolution of the proton objection: a bare charge is non-ZFE-closed (only
  neutral composites like hydrogen fully close), so it is *reclassified out of P1's scope* rather than
  made a counterexample. **Recorded as motivation, not premise:** the observation that isolation
  improves stability feeds P1's plausibility but is not assumed — and the word "stable" appears
  **nowhere** in the Lean file; the formal claim routes through *elementarity* (ZFE-closed ∧ not
  decomposable) only. Dynamical stability is not counting-theoretic (proton vs neutron shows this) and
  is not claimed.

## 4. Proof architecture — invariants kill infinite families, enumeration mops the residue

| Step | Statement | Kind |
|---|---|---|
| **I1** `dyadic_closed` | admissible values lie on the dyadic lattice (the sub-grammar of powers-of-2 selectivities); Koide-style `/3` values live *outside* that sub-grammar and are not claimed dyadic | invariant (structural induction) |
| **I2** `prime_implies_atomic` | a prime count admits no factorization ⟹ no rereading as independent sub-receipts, in any decomposition | free arithmetic |
| **I3** `elementary_iff_prime` | *elementary* (ZFE-closed ∧ not decomposable) ⟺ *prime* count | corollary of I2 + P1 |
| **R1** `alpha_unique` | within the frozen admissible class (depth ≤ the construction bound), `val e = 137` — the reachable value is unique | bounded enumeration |
| **R2** `rival_excluded` | **the headline:** no admissible derivation reaches any other value — the anti-Eddington statement | corollary of R1 |
| **R3** minimality witnesses | each admissibility constraint is load-bearing: drop it, exhibit a rival-reaching witness | one witness per constraint |
| **N** `reachable_finite` | the reachable value set at depth ≤ `d` is a finite set on the dyadic lattice; its cardinality `N(d)` against the measured interval width gives the accidental-hit probability as a **number** | the quantified look-elsewhere |

**The payoff shape — 136 dies twice, independently:** as a *composite* count it is non-elementary (I3,
depth-unbounded), and it is *unreachable* in the frozen grammar (R1). That double death is the
anti-Eddington sentence in machine-checked form. And `N(d)` converts "you searched derivation-space
until you found 137" from an argument into a computed probability — the look-elsewhere objection
answered with arithmetic rather than rhetoric.

## 5. Land order & the two standing corrections

**Land order** (confidence-first): `prime_implies_atomic` (free arithmetic, validates the file) →
`dyadic_closed` (structural induction) → `reachable_finite` (the census). `alpha_unique` (R1) waits
until the `Admissible` holes are wired from the real construction; R3 instantiates last, one witness per
constraint. **The `Admissible` holes must not be filled until §2's constraints are motivated here** —
that is Step 0, and it is now satisfied by this document.

**Two corrections to make before any Lean push** (both flagged, one now resolved by §2):
1. **Trim the `Expr` constructors** to exactly §1's operations — done in §2 (drop `alphabetCard`,
   `splitSpatial` as value-leaves; keep powers-of-2 selectivities + `3` + `prod`/`pow`/`sum`). Extra
   constructors inflate `N(d)` and weaken the look-elsewhere number.
2. **Wire `DecomposableCount` to the repo's closure structures**, with *decomposable ⟹ arithmetic
   factorization* built **into the definition** (`DecomposableCount n := ∃ a b, 2 ≤ a ∧ 2 ≤ b ∧
   n = a·b ∧ (the closure space of count n factors as independent sub-closures of counts a, b)`), so the
   backward direction of `elementary_iff_prime` closes by construction. The *realization* of that
   factorization is exactly P1.

## 6. What this does not claim (for the record)

- **The identification "this closure structure IS the electromagnetic coupling"** — an interpretive
  premise stated in [`Alpha.md`](Alpha.md), uncertified here.
- **Anything about the `0.036` residual** — the registry open item ([`Alpha_Residual.md`](Alpha_Residual.md));
  the *measured* `137.036…` is dyadic-*approximable*, not dyadic, and the machine-checked object is the
  proven bound `137 < α⁻¹ < 137.048` ([`QLF_AlphaBound`](lean/QLF_AlphaBound.lean)), not a from-scratch
  `137.036`.
- **Prime bit-count** (`log₂` dimension) — a different claim, not made; `val` counts dimension-like
  closure counts.
- **Dynamical stability of anything** — see §3; the chain routes through elementarity only.

## References
- [`Alpha.md`](Alpha.md) · [`lean/QLF_FineStructureSubstrate.lean`](lean/QLF_FineStructureSubstrate.lean) — the derivation the rigidity is *about*.
- [`lean/QLF_AlphaBound.lean`](lean/QLF_AlphaBound.lean) — the proven interval `137 < α⁻¹ < 137.048`.
- [`SpaceTime.md`](SpaceTime.md) §3a — why `d = 3` (minimal faithful rendering), the source of `N = 3²`.
- [`Completeness_Evidence.md`](Completeness_Evidence.md) §3 — where the constants-overdetermination case lives; rigidity strengthens it.
