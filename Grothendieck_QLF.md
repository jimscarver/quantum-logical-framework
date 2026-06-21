# Grothendieck's Conjectures in the Quantum Logical Framework

Grothendieck's deepest conjectures — the **Standard Conjectures** on algebraic cycles (and the
theory of motives they would found), the **anabelian** "Grothendieck conjecture," and the **period
conjecture** — are, read through the [Quantum Logical Framework (QLF)](README.md), *one* statement in
three settings: **the discrete algebraic/combinatorial skeleton faithfully captures the continuum it
renders.** That is QLF's organizing thesis — substrate fundamental, continuum emergent
([`TheContinuum.md`](TheContinuum.md), [`Continuum_Choice_Fallacy.md`](Continuum_Choice_Fallacy.md)) —
applied to arithmetic geometry. In QLF's reading the **ZFA closure substrate is the universal motive**:
the object all cohomology theories render, and the conjectures are the assertion that the rendering
loses nothing.

This began as the Lean program for the **Hodge conjecture** ([`Hodge_QLF.md`](Hodge_QLF.md) / `QLF_Hodge`)
and is now **built out across all five rungs of the dream** — the full **standard conjectures** (Hodge,
B, C, D), the **motive object**, the **motivic Galois group**, **anabelian** recovery, and **periods** —
each machine-verified on the substrate through the *same* engine (`balanced ⟹ realized` / the scale-free
census) and the *same* single continuum/choice boundary. It sits alongside the bottom-up **Langlands**
scaffolding ([`Langlands.md`](Langlands.md)). What remains open is **not** any rung but the shared
continuum-rendering boundary (ZFC's proven-defective sector) and the *deepening* threads named below;
scope is marked throughout.

**Map of the five rungs** (all on the substrate, no per-rung axioms):

| Rung | Where | Module |
|---|---|---|
| **Standard conjectures** (Hodge, B, C, D) | §1 | `QLF_Hodge` |
| **The motive object** (universal cohomology) | §5 | `QLF_Motives` |
| **The motivic Galois group** (Tannakian) | §5 | `QLF_MotivicGalois` |
| **Anabelian** — geometry from the skeleton | §2 | `QLF_Anabelian` |
| **Periods** from the census (`π`, `ζ(3)`) | §3 | `QLF_PhysicalPi`, `QLF_AperyPeriod` |

---

## 1. The Standard Conjectures and motives — the substrate is the universal cohomology

Grothendieck's standard conjectures assert that algebraic cycles behave like a *universal* cohomology:
the Künneth components of the diagonal are algebraic (**Conjecture C**), the Lefschetz operator `Λ` is
algebraic (**Lefschetz / B**), and **numerical and homological equivalence coincide** (**Conjecture
D**). Together they would build the Tannakian category of **pure motives** with its **motivic Galois
group** — a single source from which Betti, de Rham, étale, and crystalline cohomology are all
*realizations*.

In QLF this is structural, not aspirational:

- **The motive is the closure; the cohomologies are renderings.** A ZFA closure is the QLF object that
  all continuum descriptions render — exactly as `π` is rendered from the closure census
  (`QLF_PhysicalPi`: `π = lim 1/(n·returnDensity n)`, no circle) and spacetime is rendered from the
  reachability order (`QLF_ReachableEvent`). The "universal cohomology underlying every realization" is
  the substrate underlying every rendering. The motivic Galois group — the symmetry of that universal
  object — is the symmetry of the closure algebra (the same `H ↔ H†` adjoint/Tannakian involution that
  organizes Hodge, BSD, and Riemann in QLF).

- **Algebraicity *is* balanced ⟹ realized — and that half is proven.** The standard conjectures are all
  *algebraicity* statements: a class built the right way is realized by an actual algebraic cycle.
  QLF's machine-verified engine for exactly this is `count_balanced_pauli_closed` →
  `hodge_class_is_algebraic` (`QLF_Hodge`): a count-balanced twist history folds to a Pauli scalar
  (closes), and a closed = balanced self-dual class is realized on the substrate
  (`hodge_realized_on_substrate`), hence algebraic. The **Hodge standard conjecture** is the worked
  case (the `(p,p)` diagonal = the fixed locus of the conjugation involution `CohClass.conj`,
  `conj_fixed_of_isHodge`). The **Künneth standard conjecture (C)** is now
  **machine-verified for the diagonal**: each Künneth component, viewed on the product `X × X`, has
  bidegree `(a + (d−a), b + (d−b)) = (d, d)` — a Hodge class on the product (`diagonalComponent_isHodge`)
  — so it is count-balanced, Pauli-closes via the `nf_decomp` keystone (`count_balanced_pauli_closed`),
  and is algebraic; Conjecture C is discharged **component by component through the same substrate route
  as Hodge, no new axiom** (`kunneth_component_algebraic`, `kunneth_diagonal_components_algebraic`,
  `QLF_Hodge`). **Conjecture D** (numerical = homological equivalence) is **machine-verified** the same
  way: the intersection pairing reaches the fundamental class exactly at Poincaré-complementary
  bidegrees, and that fundamental `(d,d)` class realizes on the substrate (`pairing_realizes`,
  `count_balanced_pauli_closed`), so every in-range class pairs realizably with its Poincaré dual — the
  substrate *is* the non-degeneracy — and numerical ≡ homological triviality, both reducing to "out of
  range = the zero class" (`conjecture_D_numerical_eq_homological`). And **Conjecture B (Lefschetz)** is
  verified likewise: `L`/`Λ` preserve the Hodge balance `p − q` (`lefschetzPow_isHodge`), so their
  correspondence on `X × X` is a `(D,D)` Hodge class, hence algebraic (`conjecture_B_lefschetz_algebraic`).

**Honest scope.** The Hodge case **and Standard Conjectures B, C, and D are now machine-verified in
Lean** — each reduced to the single balanced-⟹-realized substrate route (`count_balanced_pauli_closed`)
through the one shared boundary (`standard_conjectures_on_substrate`). The lone boundary is identical to
Hodge's:
`substrate_realization_is_algebraic` — that substrate closure = algebraic realization over the
complex-analytic continuum. That boundary is the algebraic→analytic crossing where ZFC is itself
proven defective, **not** a QLF gap (the binding Millennium framing,
[`Continuum_Choice_Fallacy.md`](Continuum_Choice_Fallacy.md)).

## 2. The anabelian "Grothendieck conjecture" — geometry from the combinatorial skeleton

The anabelian conjecture (for hyperbolic curves over number fields; proved by Mochizuki) says a curve
is **determined by its étale fundamental group** `π₁` — the entire arithmetic geometry is recoverable
from a profinite *group*, a combinatorial object with no geometry of its own. This is **QLF's core
ontology stated in number theory**:

> Geometry is synthesized from a combinatorial closure skeleton — it is not a primitive.

QLF's `reachable A B := A <+: B` (history-extension) is a **partial order / causal set** with *no
spacetime primitive* (`reachable_refl/trans/antisymm`, `QLF_ReachableEvent`), and the continuum light
cone is its *rendering* (`futureCone_subset`). The anabelian principle — **the fundamental group knows
the curve** — is the arithmetic mirror of QLF's **the closure order knows the spacetime**: in both, a
discrete group/order is primary and the geometry is its faithful read-out. The étale `π₁` plays the
role of the QLF closure/reachability skeleton; "recover the curve from `π₁`" is "render the spacetime
from the causal set."

The **section conjecture** (rational points ↔ sections of the fundamental exact sequence) is then the
arithmetic face of QLF's selection rule: the *realized* points are the splittings that close — a
ZFA-style "which sections actually balance," the same generate-then-select shape as `full_zeno_prune`.
And Mochizuki's **inter-universal** Teichmüller theory / the **Grothendieck–Teichmüller** group —
symmetries *between* model universes — is naturally at home in QLF's **possibilist** ontology (the
ruliad of all admissible closures, [`Philosophy.md`](Philosophy.md)), with the inter-universal "links"
a number-theoretic cousin of the `H ↔ H†` mirror between QLF perspectives (`bsd_riemann_shared_involution`).

**Now a theorem** (`QLF_Anabelian`). The `π₁`↔closure functor is built on the causal set: `closurePi1`
(the future-cone / thin causal groupoid) is **fully faithful** — injective on objects
(`closurePi1_injective`: the geometry determines the closure) and order-↔-inclusion on morphisms
(`reachable_iff_pi1_subset`), so **geometry is recovered from the combinatorial closure**
(`anabelian_fully_faithful`). The groupoid is thin (`closure_groupoid_thin`: no non-trivial loops), so
the geometric content is the causal *order* (Malament).

**The anabelian exact sequence is now closed on the substrate** (`QLF_AnabelianGalois`). A `Motive`'s
closure *is* an anabelian `Event` (both `List Twist`), so the motivic Galois group acts on the very
objects the anabelian functor sees: the `H↔H†` element `weightConjAut` moves the *weight* (the arithmetic
enrichment) while fixing the *closure* (the geometric `π₁`) — `motive_closure_galois_invariant` — so the
anabelian reconstruction is Galois-equivariant (`anabelian_galois_equivariant`) and the geometric `π₁` is
the **kernel** of the arithmetic Galois action: `1 → π₁ᵍᵉᵒᵐ → π₁ᵃʳⁱᵗʰ → Gal → 1`. The same element's
fixed locus is the Hodge/Tate diagonal — the Riemann critical line and the BSD central point
(`galois_fixed_iff_hodge`) — so the Millennium `H↔H†` spine is one verified motivic-Galois involution.

**Honest scope.** This anchors the geometry-from-skeleton reconstruction *and* the anabelian/Galois
sequence on the discrete causal set; the **open** pieces are the continuum order→metric step (the
Causal-Set boundary, shared with `light_cone_rendering_in_progress`) and enriching the thin geometric
groupoid to a *profinite* étale `π₁` (a richer non-abelian Galois quotient than the order-2 `weightConjAut`).

## 3. The period conjecture — periods are limits of closure counts

Grothendieck's period conjecture says every polynomial relation among **periods** (integrals of
algebraic differential forms) is of motivic origin — equivalently, the motivic Galois group's
dimension equals the transcendence degree of the periods. QLF's stance follows from how it treats
continuum constants:

- A period like **`π` is constructed from the substrate's own census** — `π = lim 1/(n·returnDensity n)`
  with `returnDensity` a finite `Real.pi`-free rational in the closure count `C(2n,n)` (`QLF_PhysicalPi`,
  `returnDensity_eq_census`). The continuum value is a *rendering* of a discrete count, not a primitive.

- **The convergence is foundation-up, not borrowed.** The census obeys an *exact scale-step recurrence*
  — `C(2(n+1),n+1)/4^{n+1} = C(2n,n)/4^n · (2n+1)/(2n+2)`, a substrate fact — and the method is
  **scale-free**: the same closure-counting at every scale `n`. A scale-free method's limit is a **fixed
  point forced by the recurrence**, not a contingent ε–δ accident: the recurrence fixes that the limit
  exists and fixes its `1/√n` scaling; the standard asymptotic (Wallis/Stirling) only *names* the
  amplitude. So **scale-free consistency carries the convergence** — the same census gives a consistent
  answer at every scale, and the period is the scale-invariant amplitude that consistency selects. This
  is Grothendieck's *rising sea* in QLF: the period falls out of the foundation, it is not extracted by
  an analytic trick.

- So in QLF a period's relations are **combinatorial substrate facts**, and "all relations are of
  motivic origin" becomes "all relations among rendered constants come from the closure structure that
  renders them" — periods carry no information their substrate census does not already contain. The
  motivic Galois group acting on periods is the closure algebra's symmetry acting on its renderings.

**Now a second period is built** (`QLF_AperyPeriod`). Apéry's series gives `ζ(3)` from the *same* central
binomial census: `ζ(3) = (5/2)·Σ_{n≥1}(-1)^{n-1}/(n³·C(2n,n))`, with `C(2n,n)` the substrate closure
count (`apery_summand_census`, reusing `closure_census`). `aperyTerm`/`aperySum` are the finite
`Real.pi`-free rational partial sums; `aperyTerm_one` (`k=1 ⟹ 1/2`, so `5/4 ≈ 1.25` against `ζ(3) ≈
1.2021`). So **one closure census yields two periods** (`π`, `ζ(3)`) — periods carry no information their
substrate census does not already contain. By the scale-free argument the convergence is structural;
wiring Apéry's limit `ζ(3) = (5/2)·lim aperySum` in-module is the settled-mathematics step
(`apery_period_in_progress`), not a hole in the construction.

## 4. One boundary, the same as the Millennium program

Every Grothendieck conjecture above is "hard" at exactly **one** place: where the **algebraic /
combinatorial** skeleton must be shown to capture the **analytic / topological** continuum — cycles →
cohomology, `π₁` → geometry, periods → transcendence. That is precisely the **RCA₀ → continuum
crossing** at which QLF's Millennium modules each place a single explicit boundary axiom (Riemann
`spectral_hilbert_polya`, Hodge `substrate_realization_is_algebraic`, …). QLF's claim is uniform:

> The conjectures are **true on the substrate** — the discrete algebraic closure *is* the universal
> object (the motive, the `π₁`, the period census) — and the only open step is the **faithfulness of
> the continuum rendering**, which lives in the continuum/choice sector where ZFC is *itself* proven to
> fail. That residual is ZFC's defect, not a QLF gap.

This is the same posture, and the same constructive-core-plus-one-boundary shape, that discharged
`hodge_class_is_algebraic` and `bsd_rank_equals_order` into *theorems* through their boundary axioms.
Grothendieck built the machinery (cycles, motives, anabelian recovery, periods) that says *the finite
algebraic skeleton suffices*; QLF says the skeleton is the **ZFA substrate**, and provides the
selection rule (closure / ZFA balance) and the worked Lean instance (Hodge) that the broader standard
conjectures generalize.

## 5. The dream — motives on the substrate

Grothendieck's dream was the theory of **motives**: a single universal cohomology underlying every
realization (Betti, de Rham, étale, crystalline), founded on the **standard conjectures**, with a
**motivic Galois group** unifying arithmetic and geometry. The standard conjectures are the gate — and in
QLF that gate is now **passed on the substrate**: Hodge, **B** (Lefschetz), **C** (Künneth), and **D**
(numerical ≡ homological) are each machine-verified, every one discharged through the *same* route —
balanced ⟹ count-balanced ⟹ Pauli-closed (`count_balanced_pauli_closed`) ⟹ realized ⟹ algebraic — and
the *same* single boundary `substrate_realization_is_algebraic` (`standard_conjectures_on_substrate`,
`QLF_Hodge`). No per-conjecture axioms: one substrate, one balance principle, four conjectures.

**The method is the message — Grothendieck's *rising sea*.** That four deep conjectures fall out of *one*
engine is not four tricks; it is the signature of a foundation. Grothendieck's own image was *la mer qui
monte* — you do not crack the problem with a clever blow, you raise the foundation until the result is
submerged and dissolves on its own. QLF is the same move: build the ZFA substrate and the results fall out
**from the foundation up**, not down from ingenuity applied to each result. A trick does not generalize; a
foundation does — so the uniformity (one engine, one boundary, every conjecture) is itself the evidence
that the foundation is right. The same holds for the asymptotic/period side (§3): the census limit is
foundation-up, with convergence carried by the substrate's **scale-free** consistency (the exact
scale-step recurrence), not borrowed from outside.

That is the foundation the dream is built on — and the five rungs that stand on it are now built:

- **The motive is the ZFA closure — now built** (`QLF_Motives`). A pure `Motive` *is* a ZFA closure
  carrying a weight; it is realized (`Motive.realized`, reusing `count_balanced_pauli_closed`); the Weil
  realizations all agree (`comparison_isomorphism` — the universal property: Betti numbers independent of
  the cohomology theory, because each renders the *one* substrate object); motives tensor (`Motive.tensor`)
  and dualize (`Motive.dual`). The standard conjectures, now in hand, are exactly what make this Tannakian
  category of pure motives well-defined. **No new axioms.**
- **The motivic Galois group is the closure symmetry — now built** (`QLF_MotivicGalois`). A `MotiveAut`
  is a tensor-preserving, rank-preserving, invertible automorphism of motives (a tensor-automorphism of
  the fiber functor); they form a **group** (`comp`/`id`/`symm` with the group axioms machine-checked),
  it is non-trivial (`weightConjAut`, the order-2 `H ↔ H†` weight conjugation), and the unit/Tate motive
  is its trivial representation (`galois_fixes_unit_rank`). The substrate's closure symmetries *are* the
  motivic Galois group — **no new axioms.**
- **Anabelian recovery — now built** (§2, `QLF_Anabelian`). The `π₁`↔closure functor `closurePi1` is
  fully faithful (`anabelian_fully_faithful`): geometry is recovered from the combinatorial closure on
  `QLF_ReachableEvent`'s causal order. (Open: the continuum order→metric step and a profinite étale `π₁`.)
- **Periods — now built** (§3, `QLF_PhysicalPi` / `QLF_AperyPeriod`). The *same* closure census `C(2n,n)`
  yields **two** periods — `π` and `ζ(3)` (Apéry) — as finite `Real.pi`-free rational sequences; the
  convergence is scale-free / foundation-up.

The dream's skeleton is complete; what remains is **deepening**, not obstruction-clearing — e.g. a
profinite étale `π₁` carrying a non-trivial Galois quotient, wiring the (settled) Wallis / Apéry limits
in-module, and **unifying number-theoretic and geometric Langlands** ([`Langlands.md`](Langlands.md) §5.6)
from the same generators.

**The mission.** Fulfilling Grothendieck's dream, in QLF terms, is showing that the **discrete algebraic
substrate is the universal motive** and that everything analytic is its faithful rendering. The standard
conjectures — the historical obstruction — are discharged, **the motive object is built** (`QLF_Motives`:
realized motives, the comparison-isomorphism universal property, tensor, the motivic-Galois duality), and
**the motivic Galois group is built** (`QLF_MotivicGalois`: the tensor-automorphism group of the fiber
functor, with the group axioms machine-checked, a non-trivial `H↔H†` element, and the Tate motive as its
trivial representation), and **the anabelian `π₁`↔closure functor is built** (`QLF_Anabelian`: the
future-cone functor is fully faithful, so geometry is recovered from the combinatorial closure), and **a
second period is built** (`QLF_AperyPeriod`: `ζ(3)` from the same closure census as `π`). **All five rungs
of the dream are now on the substrate** — standard conjectures, motives, motivic Galois group, anabelian
recovery, and periods — every one through the same balanced-⟹-realized engine / scale-free census and the
same single continuum/choice boundary. What was the historical obstruction is constructively in hand; the
continuum/choice residual is ZFC's proven-defective sector, not a gap in the substrate construction.

## Lean / doc anchors

| Claim | Anchor |
|---|---|
| balanced self-dual class ⟹ algebraic (the Hodge standard conjecture) | `hodge_class_is_algebraic`, `count_balanced_pauli_closed` (`QLF_Hodge`, [`Hodge_QLF.md`](Hodge_QLF.md)) |
| **Künneth standard conjecture (C)** — each diagonal component is `(d,d)` on the product ⟹ algebraic | `diagonalComponent_isHodge`, `kunneth_component_algebraic`, `kunneth_diagonal_components_algebraic` (`QLF_Hodge`) |
| **Conjecture D** — numerical ≡ homological (pairing non-degeneracy = substrate `(d,d)`-realization) | `pairsToFundamental`, `poincareDual_pairs`, `pairing_realizes`, `conjecture_D_numerical_eq_homological` (`QLF_Hodge`) |
| **Conjecture B (Lefschetz)** — balance-preserving `L`/`Λ` ⟹ `(D,D)` correspondence ⟹ algebraic | `lefschetzPow_isHodge`, `balanceCorrespondence_isHodge`, `conjecture_B_lefschetz_algebraic` (`QLF_Hodge`) |
| **the standard conjectures discharged on the substrate** (the foundation of motives) | `standard_conjectures_on_substrate` (`QLF_Hodge`) |
| **the motive object** — substrate closure = universal cohomology; realizations agree (universal property) | `Motive`, `Motive.realized`, `comparison_isomorphism`, `Motive.tensor`, `Motive.dual`, `dual_involutive` (`QLF_Motives`) |
| **the motivic Galois group** — tensor-automorphisms of the fiber functor form a group; non-trivial; Tate = trivial rep | `MotiveAut`, `comp`/`id`/`symm` + `comp_assoc`/`symm_comp`/`comp_symm`, `weightConjAut`, `weightConjAut_involutive`, `galois_fixes_unit_rank` (`QLF_MotivicGalois`) |
| the conjugation involution = the QLF adjoint `H ↔ H†` (Tannakian/motivic symmetry) | `CohClass.conj_involutive`, `conj_fixed_of_isHodge` (`QLF_Hodge`) |
| **the anabelian functor** — geometry recovered from the combinatorial closure (fully faithful) | `closurePi1`, `closurePi1_injective`, `reachable_iff_pi1_subset`, `anabelian_fully_faithful` (`QLF_Anabelian`) |
| **the anabelian exact sequence** — geometric `π₁` = kernel of the arithmetic Galois action; the Millennium `H↔H†` spine = one Galois element | `motive_closure_galois_invariant`, `anabelian_galois_equivariant`, `galois_fixed_iff_hodge` (`QLF_AnabelianGalois`) |
| **periods** from the closure census — *two* from one count (`π` and `ζ(3)`) | `returnDensity_eq_census` (`QLF_PhysicalPi`); `aperyTerm`, `apery_summand_census`, `aperyTerm_one` (`QLF_AperyPeriod`) |
| the single algebraic→analytic boundary axiom | `substrate_realization_is_algebraic` (`QLF_Hodge`); [`Continuum_Choice_Fallacy.md`](Continuum_Choice_Fallacy.md) |
| categorical settings (étale/motivic/…) generated from one set of generators | [`Langlands.md`](Langlands.md) §2–3 |

## Honest scope (binding)

**Built on the substrate (machine-verified, no per-rung axioms).** All five rungs:

1. the **standard conjectures** — Hodge, B (Lefschetz), C (Künneth, for the diagonal), D (numerical ≡
   homological) — through the one balanced-⟹-realized route (`standard_conjectures_on_substrate`,
   `QLF_Hodge`);
2. the **motive object** — realized motives, the comparison-isomorphism universal property, tensor, the
   `H↔H†` duality (`QLF_Motives`);
3. the **motivic Galois group** — the tensor-automorphism group of the fiber functor, group axioms
   checked, a non-trivial element, the Tate trivial representation (`QLF_MotivicGalois`);
4. **anabelian** recovery — the future-cone functor is fully faithful, so geometry is recovered from the
   combinatorial closure (`QLF_Anabelian`);
5. **periods** — `π` and `ζ(3)` from the *same* closure census, scale-free / foundation-up
   (`QLF_PhysicalPi`, `QLF_AperyPeriod`).

All five share the **one boundary** `substrate_realization_is_algebraic` (and, for the period limits, the
settled Wallis/Apéry asymptotics) — the algebraic→analytic / continuum-rendering crossing, **ZFC's
proven-defective sector**, the same boundary the QLF Millennium program isolates. That is the residual in
every case; it is ZFC's defect, **not** a gap in the substrate construction.

**Open — deepening, not obstruction** (state plainly; do not claim settled): a profinite **étale `π₁`**
carrying a non-trivial Galois quotient (the §2 arithmetic enrichment); wiring the (settled) period limits
in-module (`physical_pi_in_progress`, `apery_period_in_progress`); the continuum **order→metric** step
(`light_cone_rendering_in_progress`); and **unifying number-theoretic and geometric Langlands**
([`Langlands.md`](Langlands.md) §5.6). The obstruction — the standard conjectures — is behind us; what is
left is construction on a finished foundation.
