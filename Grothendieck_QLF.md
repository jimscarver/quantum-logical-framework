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

> **Read this first — the frame.** *Contrast (once):* the **classical** Grothendieck conjectures (Hodge,
> B, C, D about complex-variety cycles) are different statements in the classical frame and are **not**
> proved here. *From here on this document is about the substrate **reformulation** and what it **proves**.*
> The reformulation has genuine theorems — e.g. **Hodge classes are exactly the substrate-realized closures**
> (`hodge_realized_on_substrate`, *no axiom*); the motive / Galois / anabelian **structures** as Lean
> objects; **`π` and `ζ(3)` from the census** (Wallis/Apéry). These are proofs *of the reformulated
> statements*. The one **gap** is *faithfulness* — whether a substrate-realized closure is a *classical*
> algebraic cycle (`substrate_realization_is_algebraic`). For Hodge that gap is now **built out to its honest
> floor**: the cohomology object is constructed on both sides — the **algebraic** side a graded ℚ-**subalgebra**
> (`QLF_GradedCohomology`→`QLF_CohomologyRing`→`QLF_CohomologyLinear`→`QLF_CohomologyAlgebra`, the image of a
> ℚ-algebra hom `cl` from the cycle ring) and the **transcendental** `(p,q)` side a genuine pure Hodge
> structure (`QLF_HodgeStructure`, whose conjugation *is* the substrate `H↔H†`) — so the gap is reduced to the
> single input of **geometric realization / polarization** (which Hodge structure a closure's cohomology
> carries). No further substrate scaffolding closes it (the swings `QLF_HodgeExpSequence`/`QLF_HodgeIrreducible`
> showed even codim-1 Lefschetz needs a real cohomology theory of varieties = the open program). So the honest
> reading is: *the reformulation is proven; both sides of the Hodge picture are built; its bridge to the
> classical statement is the one located gap, identified with geometric realization — the **thread closed at
> its honest floor**.* (Hodge is finite ℚ-linear algebra — an ordinary conjecture, not continuum/independence —
> so "ZFC's defect" does not apply.)

This began as the Lean program for the **Hodge conjecture** ([`Hodge_QLF.md`](Hodge_QLF.md) / `QLF_Hodge`)
and now spans all five rungs of the dream — the **standard conjectures** (Hodge, B, C, D), the **motive
object**, the **motivic Galois group**, **anabelian** recovery, and **periods** — each a substrate
*reformulation* through the *same* engine (`balanced ⟹ realized` / the scale-free census) and the *same*
single bridge axiom. It sits alongside the bottom-up **Langlands** scaffolding
([`Langlands.md`](Langlands.md)).

**Map of the five rungs** (each = verified discrete core + one conjectural bridge):

| Rung | Where | Module | Status |
|---|---|---|---|
| **Standard conjectures** (Hodge, B, C, D) | §1 | `QLF_Hodge`, `QLF_CohomologyAlgebra`, `QLF_HodgeStructure` | reformulation; both sides built; **Hodge thread closed at its honest floor** (gap = geometric realization) |
| **The motive object** (universal cohomology) | §5 | `QLF_Motives` | structure built; rests on the bridge |
| **The motivic Galois group** (Tannakian) | §5 | `QLF_MotivicGalois` | structure built (a real group) |
| **Anabelian** — geometry from the skeleton | §2 | `QLF_Anabelian` | a genuine theorem on the causal set |
| **Periods** from the census (`π`, `ζ(3)`) | §3 | `QLF_PhysicalPi`, `QLF_AperyPeriod` | genuine (Wallis/Apéry, classical) |

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

- **What is actually proven (the discrete core), and what is assumed (the bridge).** The standard
  conjectures are *algebraicity* statements: a class built the right way is realized by an actual
  algebraic cycle. QLF's **verified** part is the discrete engine `count_balanced_pauli_closed`: a
  count-balanced twist history folds to a Pauli scalar (closes) — a real theorem *about twist strings*.
  Then `hodge_class_is_algebraic` (`QLF_Hodge`) is **derived from the bridge axiom**
  `substrate_realization_is_algebraic` ("substrate closure = algebraic cycle"), which on Hodge classes
  *is* the Hodge conjecture (and `isAlgebraic` is itself abstract). So the algebraicity step is **assumed,
  not proven** — the Lean confirms the reformulation, not the conjecture. With that read in place: the
  **Hodge** case is the worked one (the `(p,p)` diagonal = fixed locus of `CohClass.conj`); **Künneth (C)**
  reduces each diagonal component to a `(d,d)` Hodge class on `X × X` (`diagonalComponent_isHodge`,
  `kunneth_diagonal_components_algebraic`); **D** reads numerical ≡ homological off the same `(d,d)`
  realization (`conjecture_D_numerical_eq_homological`); **B** uses that `L`/`Λ` preserve the Hodge balance
  (`lefschetzPow_isHodge`, `conjecture_B_lefschetz_algebraic`). All four route through the *one* bridge —
  which mirrors the real mathematics (B, C, D, Hodge are one coupled package), and is the honest content:
  **a single substrate-faithfulness principle equivalent in strength to the standard-conjectures package.**

**Honest scope (binding).** *Proven in the reformulation* (no axiom): the discrete keystone
`count_balanced_pauli_closed` and the encodings, hence **Hodge classes are exactly the substrate-realized
closures** (`hodge_realized_on_substrate`); the Künneth/D/B reductions on top of it. These are genuine
theorems. *The one gap is faithfulness*: the bridge `substrate_realization_is_algebraic` from a realized
closure to a *classical* algebraic cycle (full conjecture strength; `isAlgebraic` abstract). For Hodge this
gap is now **built out to its honest floor and the thread closed**: both sides of the Hodge picture are
concrete substrate objects — the **algebraic** side a graded ℚ-**subalgebra** (the cohomology build
`QLF_GradedCohomology`→`QLF_CohomologyRing`→`QLF_CohomologyLinear`→`QLF_CohomologyAlgebra`, the image of a
ℚ-algebra hom `cl` from the cycle ring) and the **transcendental** `(p,q)` side a genuine pure Hodge
structure (`QLF_HodgeStructure`, conjugation = the substrate `H↔H†`) — so the gap is reduced to one input,
**geometric realization / polarization**. The earlier faithfulness swings (`QLF_HodgeExpSequence`,
`QLF_HodgeIrreducible`) showed why no further substrate scaffolding closes it (even codim-1 Lefschetz needs a
real cohomology theory of varieties = the open program); the one non-scaffolding path is QLF's thesis as a
long research bet (emergent Kähler geometry + period map). *(Contrast, once: the **classical** standard
conjectures — finite ℚ-linear algebra, not continuum/independence, so "ZFC's defect" doesn't apply — are not
proved here; reformulation + faithfulness would give them.)* See
[`Hodge_QLF.md`](Hodge_QLF.md) for the full cohomology build and closure, and
[`Continuum_Choice_Fallacy.md`](Continuum_Choice_Fallacy.md) for where the continuum framing *does* apply.

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

**The profinite étale `π₁` now has its first non-abelian layer** (`QLF_EtalePi1`). The substrate is
finite/RCA₀, so its étale `π₁` is profinite *by construction* (an inverse limit of finite covers); and
its first non-abelian layer is the permutation group of the three spatial axes, **`S₃`** (the same `S₃`
of `m_p/m_e = 6π⁵`, colour SU(3), the three generations) — non-abelian (`etale_pi1_nonabelian`), strictly
richer than the order-2 mirror, with `weightConjAut`'s `Z/2` recovered as its **sign quotient**
(`etale_pi1_mirror_quotient`). So the anabelian sequence's arithmetic side now carries a genuine
non-abelian Galois quotient.

**Honest scope.** This anchors the geometry-from-skeleton reconstruction, the anabelian/Galois sequence,
and the first non-abelian étale-`π₁` layer on the discrete causal set; the **open** pieces are the
continuum order→metric step (the Causal-Set boundary, `light_cone_rendering_in_progress`) and the full
inverse-limit `Profinite` object over all cover depths (`etale_pi1_profinite_in_progress`).

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

> Each conjecture is **reformulated** on the substrate — a verified discrete core plus one explicit bridge
> asserting that the continuum rendering is *faithful* to the substrate. The discrete core is genuine; the
> faithfulness bridge is **assumed**.

**Two caveats keep this honest.** First, the bridge is **not** weaker than the conjecture: for the standard
conjectures it *is* the conjecture (of full strength), so "reformulated through one bridge" is a clean
restatement, not a proof. Second — and this is where the earlier framing erred — the **"ZFC's proven
defect"** label belongs only to genuine **uncomputability / independence** boundaries (halting, Busy
Beaver, the analytic residue). It does **not** belong to the finitary conjectures (Hodge, B, C, D, BSD, P
vs NP): those are ordinary hard statements, not known independent of ZFC, so relabeling their assumed
bridge as "ZFC's defect" is a category error. Grothendieck built the machinery (cycles, motives, anabelian
recovery, periods) that says *the finite algebraic skeleton suffices*; QLF conjectures that the skeleton is
the **ZFA substrate** and exhibits the reformulation — a synthesis to be argued, not a proof to be cited.

## 5. The dream — motives on the substrate

Grothendieck's dream was the theory of **motives**: a single universal cohomology underlying every
realization (Betti, de Rham, étale, crystalline), founded on the **standard conjectures**, with a
**motivic Galois group** unifying arithmetic and geometry. The standard conjectures are the gate — and QLF
**reformulates** that gate on the substrate: Hodge, **B** (Lefschetz), **C** (Künneth), and **D**
(numerical ≡ homological) all reduce, through the *same* discrete route (balanced ⟹ count-balanced ⟹
Pauli-closed, `count_balanced_pauli_closed`), to the *same* single bridge axiom
`substrate_realization_is_algebraic` (`standard_conjectures_on_substrate`, `QLF_Hodge`). That bridge is
**of full conjecture strength** — so this is one substrate-faithfulness principle *equivalent to* the
standard-conjectures package, not a proof of it. No per-conjecture axioms: one substrate, one balance
principle, one bridge.

**The method — Grothendieck's *rising sea*.** That four deep conjectures reduce to *one* principle is not
four tricks; it mirrors that they genuinely *are* one coupled package (Kleiman). Grothendieck's own image
was *la mer qui monte* — you do not crack the problem with a clever blow, you raise the foundation until
the result is submerged. QLF's bet is the same move read ontologically: build the ZFA substrate and the
*reformulations* fall out from the foundation up. The uniformity (one bridge, every conjecture) is
suggestive evidence *for the ontology* — it is **not** a proof of the conjectures, since the one bridge is
as strong as all of them together. (The period side, §3, is different: there the convergence is genuine,
carried by the substrate's **scale-free** scale-step recurrence — Wallis/Apéry, classical and true.)

That foundation supports five rungs; here is what each actually is (verified core vs. conjectural bridge):

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

The structures (motive, Galois group, anabelian, periods) are genuinely built; the standard-conjecture
*algebraicity* remains the assumed bridge. What's beyond that is **deepening** — e.g. a
profinite étale `π₁` carrying a non-trivial Galois quotient, wiring the (settled) Wallis / Apéry limits
in-module, and **unifying number-theoretic and geometric Langlands** ([`Langlands.md`](Langlands.md) §5.6)
from the same generators.

**The mission.** Fulfilling Grothendieck's dream, in QLF terms, is showing that the **discrete algebraic
substrate is the universal motive** and that everything analytic is its faithful rendering — offered as a
*lens*, a conjectural synthesis. The standard conjectures are **reformulated** (not discharged) as a
verified discrete core plus one full-strength bridge; **the motive object is built** as a Lean structure
(`QLF_Motives`) resting on that bridge; **the motivic Galois group is a genuine group** (`QLF_MotivicGalois`,
group axioms machine-checked); **the anabelian `π₁`↔closure functor is a genuine theorem** on the causal
set (`QLF_Anabelian`); and **`π` and `ζ(3)` genuinely fall out of the closure census** (`QLF_PhysicalPi`,
`QLF_AperyPeriod` — Wallis/Apéry, classical and true). So the *structures* and the *period results* are
real; the *standard-conjecture algebraicity* is the assumed bridge. None of this proves the conjectures —
they are finitary statements the substrate ontology does not resolve — and "ZFC's defect" is **not** the
right label for them (it is for genuine continuum/uncomputability boundaries, not these). The claim worth
making is the ontology and the reformulation, as a bet; the proof claim is conceded as the open bridge.

## Lean / doc anchors

| Claim | Anchor |
|---|---|
| **verified discrete core**: count-balanced ⟹ Pauli-closed (a theorem about twist strings) | `count_balanced_pauli_closed` (`QLF_Hodge`/`QLF_TwistAlphabet`) |
| **conjectural bridge** (full strength): substrate-realized ⟹ algebraic ⟹ `hodge_class_is_algebraic` *derived* | `substrate_realization_is_algebraic`, `hodge_class_is_algebraic` (`QLF_Hodge`, [`Hodge_QLF.md`](Hodge_QLF.md)) |
| **Künneth standard conjecture (C)** — each diagonal component is `(d,d)` on the product ⟹ algebraic | `diagonalComponent_isHodge`, `kunneth_component_algebraic`, `kunneth_diagonal_components_algebraic` (`QLF_Hodge`) |
| **Conjecture D** — numerical ≡ homological (pairing non-degeneracy = substrate `(d,d)`-realization) | `pairsToFundamental`, `poincareDual_pairs`, `pairing_realizes`, `conjecture_D_numerical_eq_homological` (`QLF_Hodge`) |
| **Conjecture B (Lefschetz)** — balance-preserving `L`/`Λ` ⟹ `(D,D)` correspondence ⟹ algebraic | `lefschetzPow_isHodge`, `balanceCorrespondence_isHodge`, `conjecture_B_lefschetz_algebraic` (`QLF_Hodge`) |
| **the standard conjectures reformulated** (one full-strength bridge; a package, not a proof) | `standard_conjectures_on_substrate` (`QLF_Hodge`) |
| **the motive object** — substrate closure = universal cohomology; realizations agree (universal property) | `Motive`, `Motive.realized`, `comparison_isomorphism`, `Motive.tensor`, `Motive.dual`, `dual_involutive` (`QLF_Motives`) |
| **the motivic Galois group** — tensor-automorphisms of the fiber functor form a group; non-trivial; Tate = trivial rep | `MotiveAut`, `comp`/`id`/`symm` + `comp_assoc`/`symm_comp`/`comp_symm`, `weightConjAut`, `weightConjAut_involutive`, `galois_fixes_unit_rank` (`QLF_MotivicGalois`) |
| the conjugation involution = the QLF adjoint `H ↔ H†` (Tannakian/motivic symmetry) | `CohClass.conj_involutive`, `conj_fixed_of_isHodge` (`QLF_Hodge`) |
| **the anabelian functor** — geometry recovered from the combinatorial closure (fully faithful) | `closurePi1`, `closurePi1_injective`, `reachable_iff_pi1_subset`, `anabelian_fully_faithful` (`QLF_Anabelian`) |
| **the anabelian exact sequence** — geometric `π₁` = kernel of the arithmetic Galois action; the Millennium `H↔H†` spine = one Galois element | `motive_closure_galois_invariant`, `anabelian_galois_equivariant`, `galois_fixed_iff_hodge` (`QLF_AnabelianGalois`) |
| **periods** from the closure census — *two* from one count (`π` and `ζ(3)`) | `returnDensity_eq_census` (`QLF_PhysicalPi`); `aperyTerm`, `apery_summand_census`, `aperyTerm_one` (`QLF_AperyPeriod`) |
| the single algebraic→analytic boundary axiom | `substrate_realization_is_algebraic` (`QLF_Hodge`); [`Continuum_Choice_Fallacy.md`](Continuum_Choice_Fallacy.md) |
| categorical settings (étale/motivic/…) generated from one set of generators | [`Langlands.md`](Langlands.md) §2–3 |

## Honest scope (binding)

**What is genuinely verified** (real Lean theorems, no hidden assumption):

- the **discrete engine** `count_balanced_pauli_closed` — count balance ⟹ Pauli closure, a theorem about
  twist strings (`QLF_TwistAlphabet`);
- the **motive / Galois / anabelian structures** as Lean objects — `Motive` and its tensor/dual, the
  motivic Galois **group** (group axioms checked, `QLF_MotivicGalois`), and the **anabelian** full-faithful
  reconstruction on the causal set (`QLF_Anabelian`, a genuine theorem);
- the **periods**: `π` and `ζ(3)` *do* fall out of the central-binomial closure census
  (`QLF_PhysicalPi`, `QLF_AperyPeriod`) — Wallis and Apéry, classical and true.

Also proven (no axiom): **Hodge classes are exactly the substrate-realized closures**
(`hodge_realized_on_substrate`, from the keystone above), and the Künneth/D/B reductions on top of it.

**The one gap — faithfulness — now built out to its honest floor (Hodge thread closed).** The step from a
*substrate-realized closure* to a *classical algebraic cycle* is the bridge axiom
`substrate_realization_is_algebraic` (full conjecture strength; `isAlgebraic` abstract).
`hodge_class_is_algebraic` and the standard-conjecture statements reach the classical predicate only through
it. For Hodge, the cohomology object that the faithfulness swings (`QLF_HodgeExpSequence`,
`QLF_HodgeIrreducible`) named as the missing piece is now **built on both sides**: the **algebraic** side a
graded ℚ-**subalgebra** (`QLF_GradedCohomology`→`QLF_CohomologyRing`→`QLF_CohomologyLinear`→`QLF_CohomologyAlgebra`,
the image of a ℚ-algebra hom `cl` from the cycle ring) and the **transcendental** `(p,q)` side a genuine pure
Hodge structure (`QLF_HodgeStructure`, conjugation = the substrate `H↔H†`). So the single open piece is now
reduced to one input — **geometric realization / polarization** (which Hodge structure a closure's cohomology
carries) — and no further substrate scaffolding closes it (even codim-1 Lefschetz needs a real cohomology
theory of varieties = the open program). The Hodge thread is thus **closed at its honest floor**: both sides
built, gap identified with the genuine open problem (see [`Hodge_QLF.md`](Hodge_QLF.md)).

**What QLF does *not* claim, and why the distinction is load-bearing.** QLF does **not** prove the Standard
Conjectures. They are *finite ℚ-linear-algebra* statements (is a vector in the ℚ-span of cycle classes?),
hard but **not** continuum or independence phenomena — so the "ZFC's proven defect" framing **does not
apply** to them (it applies to genuine uncomputability/independence boundaries — halting, Busy Beaver, the
analytic residue — not these). The substrate ontology (the continuum is a rendering of the computable
substrate; Brouwer/Bishop/Weyl/Gisin) is the real, defensible bet, and the reformulation is its worked
example. **Assert that; do not assert a proof.** A "QLF machine-verified the Standard Conjectures" claim is
false on inspection (open the file, see `axiom substrate_realization_is_algebraic`) and would discredit the
genuinely-earned work — so this document deliberately keeps the line bright between *reformulated* and
*proved*. See [`Continuum_Choice_Fallacy.md`](Continuum_Choice_Fallacy.md) for where the continuum framing
*does* hold.

**Open threads** (deepening): a profinite **étale `π₁`** with a non-trivial non-abelian Galois quotient
(first layer in `QLF_EtalePi1`); for Hodge, the cohomology object is now **built** (algebraic ℚ-subalgebra +
the `(p,q)` Hodge structure — `QLF_CohomologyAlgebra`, `QLF_HodgeStructure`), so the bridge no longer carries
everything and the remaining open input is **geometric realization / polarization** (a long research bet:
emergent Kähler geometry + period map, QLF's continuum-as-rendering thesis on the hardest case); wiring the
period limits in-module (`physical_pi_in_progress`, `apery_period_in_progress`); the continuum
**order→metric** step; and **Langlands** unification ([`Langlands.md`](Langlands.md) §5.6).
