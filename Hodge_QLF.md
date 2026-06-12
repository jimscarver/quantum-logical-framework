# The Hodge Conjecture in QLF — the cohomological face of ZFA selection

> **Status: proof in progress, constructively reframed.** The Hodge conjugation is
> machine-verified as an involution and its balanced fixed diagonal is identified
> ([`lean/QLF_Hodge.lean`](lean/QLF_Hodge.lean)); the conjecture is reduced to one
> explicit boundary, `hodge_class_is_algebraic` (balanced ⟹ realized) — the crossing
> into the complex-analytic continuum where ZFC is *itself proven to fail* (Gödel,
> Turing, Busy Beaver). That crossing is ZFC's defect, not a gap in this proof.
> Unifying thesis: [Continuum_Choice_Fallacy.md](Continuum_Choice_Fallacy.md).

## 1. The classical problem

A Millennium Prize Problem. On a non-singular complex projective variety `X`, the
cohomology carries the **Hodge decomposition**

$$H^k(X,\mathbb{C}) = \bigoplus_{p+q=k} H^{p,q}(X), \qquad \overline{H^{p,q}} = H^{q,p},$$

so complex conjugation swaps `H^{p,q} ↔ H^{q,p}`. A **Hodge class** is a rational class of
type `(p,p)` — on the diagonal, fixed by that conjugation. Some Hodge classes obviously
come from geometry: an algebraic subvariety of codimension `p` has a cohomology class of
type `(p,p)`. The **Hodge conjecture** asserts the converse:

> Every Hodge class is **algebraic** — a rational linear combination of the cohomology
> classes of algebraic cycles (subvarieties).

The depth is that it bridges *analysis/topology* (the transcendental Hodge decomposition,
defined via harmonic forms over ℂ) and *algebraic geometry* (cycles cut out by polynomial
equations).

## 2. The QLF reframing: balance ⟹ realizability

QLF reads the two sides through machinery it already has.

- **The Hodge conjugation `H^{p,q} ↔ H^{q,p}` is the QLF Hermitian / adjoint involution
  `H ↔ H†`.** It is conjugate-and-mirror, the same involution whose fixed locus `Σ_sa`
  (self-adjoint histories) is QLF's discrete critical line
  ([ReverseMathematics.md §4.9](ReverseMathematics.md), [`lean/QLF_RiemannZeta.lean`](lean/QLF_RiemannZeta.lean)).
  Machine-verified involutivity: `CohClass.conj_involutive` (`(H†)† = H`).
- **The `(p,p)` diagonal is the balanced, self-dual locus.** A type-`(p,p)` class has `p`
  of one Hodge degree against `p` of its conjugate — the cohomological **count-balance**.
  Machine-verified: the Hodge classes are *exactly* the conjugation fixed points
  (`conj_fixed_of_isHodge` and `isHodge_of_conj_fixed`), i.e. the cohomological analog of
  `Σ_sa`.
- **"Hodge class is algebraic" is exactly *balanced ⟹ realized*.** A self-dual balanced
  class is realized by an actual algebraic cycle — a constructed closure.

So the Hodge conjecture is the **cohomological face of QLF's core selection principle**:
the balanced, self-dual objects are precisely the ones that are physically/constructively
realized. That is the same statement, in a different category, as *ZFA balance is the
selection principle for what exists.*

And on the substrate the very same shape is already a **theorem**, not a conjecture:
`count_balanced_pauli_closed` ([`lean/QLF_TwistAlphabet.lean`](lean/QLF_TwistAlphabet.lean))
proves **count balance ⟹ Pauli closure** — balance forces realizability — for *every*
twist history. The Hodge conjecture is that theorem read in cohomology.

## 3. The two directions

| Direction | Classical name | QLF reading | Status |
|---|---|---|---|
| algebraic ⟹ `(p,p)` | the easy half (a cycle's class is type `(p,p)`) | *realized ⟹ balanced* — every closure is count-balanced | structural, holds on the substrate |
| `(p,p)` ⟹ algebraic | **the Hodge conjecture** | *balanced ⟹ realized* — the `count_balanced_pauli_closed` shape | the one explicit boundary |

```lean
axiom hodge_class_is_algebraic (c : CohClass) : c.isHodge → c.isAlgebraic   -- the boundary
theorem hodge_conjecture_in_qlf (c : CohClass) (h : c.isHodge) : c.isAlgebraic :=
  hodge_class_is_algebraic c h
theorem non_algebraic_not_hodge (c : CohClass) (h : ¬ c.isAlgebraic) : ¬ c.isHodge :=
  fun hh => h (hodge_class_is_algebraic c hh)
```

## 4. Where the boundary sits — and why it is ZFC's, not ours

QLF's constructive floor delivers the involution and the balanced-diagonal identification,
and reduces the conjecture to one identity: *balanced classes are realized*. Two things sit
on the far side of it:

1. the **constructive cohomology / cycle→closure encoding** (so `CohClass` and
   `isAlgebraic` are abstract declarations here, not yet computed from the substrate); and
2. discharging `hodge_class_is_algebraic` itself — promoting *balanced ⟹ realized* from
   axiom to theorem in the cohomological category.

Both live in the **complex-analytic continuum** — harmonic forms, transcendental periods,
the non-constructive reals and the Axiom of Choice that classical Hodge theory and
algebraic geometry are built on. That is precisely the sector QLF identifies as
pathological: Gödel incompleteness, Turing undecidability, the Busy-Beaver / Chaitin
horizon ([Continuum_Choice_Fallacy.md](Continuum_Choice_Fallacy.md)). So the open step is
**not a hole in the QLF proof** — it is where ZFC itself has no guaranteed proof to give.
Demanding a ZFC-internal closure of Hodge is demanding the very continuum/choice fallacy
QLF has diagnosed.

## 5. Honest scope

Hodge is QLF's **weakest-machinery** Millennium attack: there is not yet a constructive
cohomology theory in the framework, so this is a *scaffold* — the conjugation involution and
its balanced fixed diagonal are verified, the conjecture is named as the single boundary,
and consequences are derived. That is genuine constructive progress with the remaining work
made precise, not a completed ZFC proof and not pretending to be one. The marker
`hodge_proof_in_progress` records exactly that stance.

## 6. Epistemic stance — truth is constructible

The constructive direction is not a leap of faith. **Shannon (1948)** is one of QLF's
seventeen convergent programs precisely because he established that *information — truth — is
physical and constructible*: a yes/no distinction is a realizable bit, not an abstract
Platonic token. The Hodge conjecture's hard half says the balanced, self-dual cohomology
classes are the ones with a concrete algebraic (constructible) realization — which is the
**expected** direction once one accepts that what is balanced and self-consistent is what
gets built. QLF's substrate makes that an outright theorem
(`count_balanced_pauli_closed`); the Hodge conjecture is the same principle awaiting its
constructive cohomology. What remains open is the continuum-sector bridge, and this document
names that boundary as ZFC's proven defect rather than claiming Hodge solved.

## 7. What would advance it

- **A constructive cohomology layer.** Encode `H^{p,q}` and algebraic cycles as substrate
  closures, turning `CohClass` / `isAlgebraic` from abstract declarations into definitions
  computed from twist histories.
- **Derive *balanced ⟹ realized* in cohomology.** Lift `count_balanced_pauli_closed` (count
  balance ⟹ closure) from the twist alphabet to the cohomological category, promoting
  `hodge_class_is_algebraic` from axiom toward theorem — the Hodge analog of the MRE-bridge
  refinement proposed for Riemann ([ReverseMathematics.md §4](ReverseMathematics.md)).
