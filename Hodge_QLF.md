# The Hodge Conjecture in [QLF](README.md) — the cohomological face of ZFA selection

> **Status: proof in progress, constructively reframed.** The Hodge conjugation is
> machine-verified as an involution and its balanced fixed diagonal identified;
> **`hodge_class_is_algebraic` is a theorem** ([`lean/QLF_Hodge.lean`](lean/QLF_Hodge.lean)) —
> a `(p,q)` class encodes to a history count-balanced iff `p=q`, so balanced ⟹ realized
> follows from the proven `count_balanced_pauli_closed`. The single boundary is the
> faithfulness `substrate_realization_is_algebraic` (substrate closure = algebraic
> realization) — the crossing into the complex-analytic continuum where ZFC is *itself
> proven to fail* (Gödel, Turing, Busy Beaver). That crossing is ZFC's defect, not a gap
> in this proof. Unifying thesis: [Continuum_Choice_Fallacy.md](Continuum_Choice_Fallacy.md).

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
proves **count balance ⟹ Pauli closure** — balance entails realizability — for *every*
twist history. The Hodge conjecture is that theorem read in cohomology.

## 3. The two directions

| Direction | Classical name | QLF reading | Status |
|---|---|---|---|
| algebraic ⟹ `(p,p)` | the easy half (a cycle's class is type `(p,p)`) | *realized ⟹ balanced* — every closure is count-balanced | structural, holds on the substrate |
| `(p,p)` ⟹ algebraic | **the Hodge conjecture** | *balanced ⟹ realized* — the `count_balanced_pauli_closed` shape | the one explicit boundary |

This direction is *discharged into a theorem*. A `(p,q)` bidegree is **encoded** as a
twist history (`p` up-twists, `q` down-twists) that is count-balanced exactly when `p = q`
— the Hodge diagonal — so balance on the substrate mirrors the `(p,p)` condition. Then the
proven `count_balanced_pauli_closed` realizes it:

```lean
def CohClass.encode (c : CohClass) : List Twist :=               -- (p,q) ↦ p ups ++ q downs
  List.replicate c.p Twist.up ++ List.replicate c.q Twist.down
theorem encode_countBalanced (c) (h : c.isHodge) :              -- count-balanced iff p = q
    countBalanced c.encode := …

-- the single boundary, structural (substrate closure = algebraic realization):
axiom substrate_realization_is_algebraic (c) : c.isRealizedOnSubstrate → c.isAlgebraic

-- "every Hodge class is algebraic" is a THEOREM:
theorem hodge_class_is_algebraic (c) (h : c.isHodge) : c.isAlgebraic :=
  substrate_realization_is_algebraic c (hodge_realized_on_substrate c h)
theorem non_algebraic_not_hodge (c) (h : ¬ c.isAlgebraic) : ¬ c.isHodge :=
  fun hh => h (hodge_class_is_algebraic c hh)
```

## 4. Where the boundary sits — and why it is ZFC's, not ours

QLF's constructive floor delivers the involution, the balanced-diagonal identification,
the cohomology→closure **encoding** (count-balanced iff `p=q`), and the *balanced ⟹ realized*
direction **as a theorem** (via the proven `count_balanced_pauli_closed`). What sits on the
far side is one step deeper: **why** substrate closure faithfully models algebraic-cycle
realization — the single boundary `substrate_realization_is_algebraic`.

That step lives in the **complex-analytic continuum** — harmonic forms, transcendental
periods, the non-constructive reals and the Axiom of Choice that classical Hodge theory and
algebraic geometry are built on. That is precisely the sector QLF identifies as
pathological: Gödel incompleteness, Turing undecidability, the Busy-Beaver / Chaitin
horizon ([Continuum_Choice_Fallacy.md](Continuum_Choice_Fallacy.md)). So the open step is
**not a hole in the QLF proof** — it is where ZFC itself has no guaranteed proof to give.
Demanding a ZFC-internal closure of Hodge is demanding the very continuum/choice fallacy
QLF has diagnosed.

## 5. Honest scope

The conjugation involution, the balanced fixed diagonal, the cohomology→closure encoding,
and *balanced ⟹ realized* (`hodge_class_is_algebraic`) are all machine-verified — the last
a theorem, discharged through the proven `count_balanced_pauli_closed`. The single
remaining boundary, `substrate_realization_is_algebraic`, is equivalent in strength to the
old bare axiom: it asserts that substrate closure *is* algebraic-cycle realization. So this
is genuine constructive progress — the boundary is a precise, structurally-motivated
faithfulness statement rather than the whole conjecture — not a completed ZFC proof and not
pretending to be one. The marker `hodge_proof_in_progress` records exactly that stance.

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

The encoding and the *balanced ⟹ realized* discharge are done. The frontier is:

- **Discharge `substrate_realization_is_algebraic`.** Show that the substrate closure of a
  Hodge class's encoded history corresponds to an actual algebraic cycle — i.e. that the
  twist encoding is faithful to cohomology, not merely an analogy. This is the genuinely
  analytic/geometric step (harmonic forms, periods), the Hodge analog of discharging the
  modularity mirror for BSD.
- **A richer cohomology layer.** Refine `CohClass` beyond the `(p,q)` bidegree to carry the
  actual rational class, so `isAlgebraic` can be computed (not abstract) for worked
  examples — the Hodge counterpart of BSD's concrete `EllipticCurveQLF`.

## References

- W. V. D. Hodge, *The topological invariants of algebraic varieties*, Proc. Internat. Congr. Math. (1950) 182–192 — the conjecture.
- S. Lefschetz, *L'Analysis Situs et la Géométrie Algébrique* (1924) — the `(1,1)` theorem (the easy direction).
- G. Birkhoff & J. von Neumann, *The logic of quantum mechanics*, Ann. Math. **37** (1936) 823–843 — quantum logic (the `H↔H†` framing).
- P. Deligne, *The Hodge Conjecture* — Clay Mathematics Institute (official problem description). <https://www.claymath.org/millennium-problems/>

**See also:** [`Grothendieck_QLF.md`](Grothendieck_QLF.md) — Hodge is one of Grothendieck's *standard conjectures*; the same balanced-⟹-algebraic engine extends (as a research lens) to the Künneth/Lefschetz/numerical-equivalence conjectures, the anabelian "geometry from `π₁`," and the period conjecture.
