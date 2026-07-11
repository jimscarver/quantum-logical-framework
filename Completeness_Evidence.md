# Completeness Evidence — what supports "only ZFA is happening," and how strongly

**Status:** Evidence ledger, not a proof. This document assembles the case that ZFA closure is the sole substrate of the possibilist universe, **typed by evidential strength**, with the misses listed beside the hits and the defeaters named. It replaces the one-line completeness claim in [`Open_Problems.md`](Open_Problems.md) ("quantum computation is the standing experimental verdict...") with a version every clause of which survives a hostile reader.

**Companion documents:** [`Universality.md`](Universality.md) (the logical-sufficiency pillar), [`Open_Problems.md`](Open_Problems.md) (the gap registry this feeds).

---

## 0. Two claims, kept separate

- **Sufficiency** — ZFA + rational-interval rendering (§2a: measurement outcomes are counts, never reals) accounts for everything observed; no *missing* ingredient.
- **Exclusivity** — ZFA is the *only* thing happening; no *additional* ingredient, and no rival substrate fits equally well.

Evidence for one is not automatically evidence for the other. Most of what follows supports sufficiency directly; exclusivity is supported only by the exclusion results (§4) and would be *established* only by the reconstruction theorem (§6), which does not yet exist. Conflating the two is the single most common overclaim in completeness arguments, and this ledger is structured to make it impossible.

## 1. Evidence typology (strongest first)

| Type | What it establishes | Ceiling |
|---|---|---|
| **T1 — Uniqueness theorems** | Any substrate satisfying the postulates *is* ZFA | Exclusivity, conditional on postulates |
| **T2 — Parameter-free overdetermination** | One structure fixes many independent measured values | Sufficiency; exclusivity by coincidence-cost |
| **T3 — Confirmed exclusions** | Predicted absences searched for and not found | Exclusivity, one rival class at a time |
| **T4 — Inherited no-go theorems** | Whole rival classes experimentally dead | Exclusivity against *added-ingredient* rivals only |
| **T5 — Consistency / universality** | ZFA passes necessary conditions | Neither — shared with all serious rivals |

A completeness claim resting only on T5 is rhetoric. [QLF](README.md)'s current position: strong T2, real T3 and T4, fragments of T1. The program is to climb the table.

## 2. T5 — Necessary conditions passed (non-discriminating; listed first to get the weakest out of the way)

**`qlf_universality`** ([`Universality.md`](Universality.md), [`lean/QLF_Universality.lean`](lean/QLF_Universality.lean)): ZFA generates every terminating finitely-encoded computation. Machine-verified, and **shared with every Turing-complete substrate** — cellular automata pass it too. It proves ZFA is *a* universal generator, not *the* substrate. Weight accordingly: a condition whose failure would kill the theory, whose success discriminates nothing.

**Quantum-computational consistency** (weak half): all exact reconstructions of quantum logic — ZFA, Bohm, Everett — predict identical QC behavior. Perfect answers confirm the equivalence class, not the member. The strong half of the QC evidence is in §4.

**Sufficiency gap, stated plainly:** even the sufficiency direction is only half-theorem. `qlf_universality` proves every terminating computation has a surviving closure encoding; "every *physical event* is such a closure" currently rests on `full_zeno_prune` as posited structure. The connecting theorem is open.

## 2a. The rendering obligation is to ℚ-with-intervals, not to ℝ

A correction that makes the ledger *stronger*, not weaker. It is tempting to state QLF's burden as "render the substrate into the continuum-valued observables physics reports." That concedes far too much, because **no measurement has ever produced a real number.** Every outcome is a finite object — detector counts, cycle counts, a terminating decimal with an error interval. `α⁻¹ = 137.035999206(11)` is a *rational plus a rational interval*, nothing more. Since the 2019 SI redefinition this is explicit all the way down: the units are fixed by exact stipulated integer-valued constants and measurement is *counting against them* — frequency metrology, the most precise measurement humans perform, is literally integer cycle counting. Uncomputable reals are not merely never measured; they are **unmeasurable in principle**, since any measurement protocol is a finite procedure. This is not a QLF thesis but a fact about metrology, and it has a sharp consequence: **the continuum never appears at the measurement interface** — so measurement was never evidence for it at all.

So the rendering obligation shrinks to its true size: **substrate → ℚ-with-intervals, not substrate → ℝ.** QLF owes rational approximants to audited precision (which [`pi_precision_demo.py`](pi_precision_demo.py) already delivers, and whose substrate origin is machine-checked in [`QLF_PiRational`](lean/QLF_PiRational.lean) — the census approximant `returnDensity n : ℚ` is `Real`-free by construction, `returnDensity 1 = 1/4`, `2 = 9/64`, `3 = 25/256`) and nothing else. Reals in textbook notation are theorist shorthand; every *actual* computation ever run — QED loop integrals included — is finite arithmetic on rationals/floats, and measurement lives even lower, in counts. And counts are closure-receipt territory, which flips the burden:

> **Measurement is counting, and counting is what ZFA does natively — it is the continuum theories that owe a story for why every experiment terminates in an integer.**

This is the balanced-truth reading in miniature: the *balanced, finite, closing* object is the real one; the continuum-valued observable is the fantasy that never shows up when you actually look. Two things it does **not** touch, kept on the record so the concession is not overread: (i) the *translation* obligation for the Clay problem **statements** is about how those problems are written, not about measurement, and stays undischarged (§6, [`TheContinuum.md`](TheContinuum.md)); (ii) the guardrail holds — that measurement never touches the continuum shows ℝ is *empirically inert at the interface* (the fantasy charge), **not** that ℝ is inconsistent (consistency ≠ realizability, [`TheContinuum.md`](TheContinuum.md)).

## 3. T2 — Parameter-free overdetermination (the strongest existing evidence)

One structure — the 8-twist alphabet with its 6+2 split and the closure census — fixing many *independent* measured quantities with zero adjustable parameters:

| Quantity | Substrate origin | Agreement | Anchor |
|---|---|---|---|
| α⁻¹ leading value | 3² tensor, IR anchor; bounds 137 < α⁻¹ < 137.048 | measured 137.036 inside the verified bounds; **residual open** | `QLF_AlphaBound` |
| Ω_Λ | 2/8 of the alphabet | consistent | `electroweak_substrate_signature` |
| sin²θ_W (unification) | 3/8 spatial fraction | RG running to 0.231 **open** | `QLF_WeinbergAngle` |
| a₀ = cH₀/2π | closure-loop period, 2π derived | SPARC blind test, parameter-free, 0.133 dex floor | `QLF_MondScale`, `QLF_MondNu` |
| Koide Q = 2/3 | N=3 axes, A²=2 | m_τ to 0.006% (scale is input) | `QLF_Koide` |
| π | closure census, Wallis | derived by construction | `QLF_PhysicalPi` |
| ln R_p = 14π | b₀=7 from N_c=3, n_f=6 | 0.07% at the posit; **band ×15 in value** | `QLF_BetaFunction`, `QLF_AlphaS` |

**Why this bears on exclusivity at all:** each parameter-free hit multiplies the coincidence-cost of any rival substrate. No rival exact reconstruction of quantum logic (Bohm, Everett, bare Hilbert-space QM) delivers *any* of these numbers from its ontology. This is ZFA's positive discriminator within the surviving class of §4.

**The misses, at full weight (a selective ledger is how frameworks fool their authors):** the 137.036 residual; the entire value sector (couplings g₁,g₂,g₃, G_F, Higgs VEV, mixing angles, absolute masses); the hierarchy is a log-level reduction with a ×15 value band; H₀ is an input; the Hubble-tension residual is unexplained, not predicted. The overdetermination case is strong *because* it survives this column being written down.

## 4. T3 + T4 — Exclusions: how "only" gets evidence

Evidence that *only* ZFA is happening can only come from absences — extra ingredients leave traces, and the traces are searched for.

### 4a. Inherited no-go theorems (T4) — rival classes killed by others

There is no theorem "no hidden variables." There is a family, each killing a **named class**, premises stated:

- **Bell** — local hidden variables. Dead, loophole-free.
- **Kochen–Specker** — non-contextual value assignments. Dead.
- **PBR** — ψ-epistemic models (given preparation independence). Dead.

**What survives all three: Bohmian mechanics** (nonlocal, contextual). QLF documents must therefore never write "hidden variables are ruled out" without qualification — a referee reaches for Bohm immediately. The inherited result is precise: any rival that **adds** a local, non-contextual, or ψ-epistemic ingredient is experimentally dead.

**The objection QLF must pre-empt (write it before a critic does):** a substrate of definite twist histories superficially *looks like* a hidden-variable theory. The answer is that twist histories are not pre-assigned measurement values: only **closures** are receipts, and closure is **horizon-relative** (`closedAtHorizon`, [`QLF_HorizonClosure`](lean/QLF_HorizonClosure.lean)) — the same history reads open or closed depending on the observer's resolution. Measured values are receipt-relative, hence contextual; KS is satisfied *structurally*, not dodged. This paragraph is the doc's insurance policy.

### 4b. Quantum computation as an ongoing exclusion experiment (T3 — the strong half)

Error-corrected QC at increasing scale progressively falsifies the entire **deviation class** of rivals — objective-collapse dynamics (GRW/CSL), Penrose gravitational collapse — because those predict departures from unitarity growing with mass and complexity, and every verified large computation tightens their parameter bounds quantitatively. This is the defensible core of the old "standing experimental verdict" line, restated with its actual scope: **QC excludes rivals that deviate from quantum logic; it cannot distinguish among exact reconstructions** (§2).

The ZFA-specific bonus: certified answers (factoring — the factors multiply or they don't) demonstrate the substrate executing **exact discrete logic** through amplitude machinery — closure-as-integer-receipt behavior — and Clifford-circuit exactness lives on the ℤ[i] lattice ([`QLF_StateSpace`](lean/QLF_StateSpace.lean)) with no continuum invoked.

### 4c. ZFA's own exclusion predictions (T3) — each a named defeater

| Prediction of absence | Anchor | Defeater (what kills ZFA-only) |
|---|---|---|
| No cosmological α drift | `no_cosmological_drift_of_alpha` | Confirmed α drift |
| θ̄ = 0 with **no axion** | `theta_zero_on_closure` | Axion detection |
| Neutrino Majorana → 0νββ exists | `neutrino_majorana` | Exhaustive-sensitivity null (LEGEND/nEXO) |
| No exact global B−L | `QLF_BaryonWinding`, `QLF_Majorana` | Exact B−L conservation established |
| No blow-up in preparable NS flows | `realized_flow_is_stable` | Physically realized blow-up |
| QRNG streams match the ZFA-closure null | [`QRNG_Closure_Observatory.md`](QRNG_Closure_Observatory.md) | Predeclared-sieve deviation |
| No new-physics anomaly in muon g−2 | `QLF_MuonG2` | Confirmed anomaly surviving HVP settlement |

Every searched-and-absent row confirms exclusivity in the only way exclusivity can be confirmed. Every row is also a standing offer to lose. **A universality claim without this table is ideology; with it, it is science.**

## 5. The surviving rivals, and the second-stage argument

After §4, the survivors are exact reconstructions of quantum logic: **Bohm** (adds trajectories) and **Everett** (adds unrealized branches). No experiment inside quantum mechanics separates them from ZFA. The second stage is therefore argued on non-empirical but principled grounds:

1. **Uniform surplus-structure charge.** Bohmian trajectories and Everettian branches are empirically idle — no observation ever witnesses them — which is *exactly* the charge QLF levels at the continuum's impossible numbers ([`TheContinuum.md`](TheContinuum.md)). For the continuum that charge is now a **theorem**, not a slogan: the non-identifiable tail is a *defined uncountable set* of parameters no finite record can touch ([`Shannon_Overfit.md`](Shannon_Overfit.md) Theorem B, `tail_unconstrained`) — the fantasy tier as arithmetic. Applying the parsimony razor uniformly, ZFA carries no idle ontology: every closure is a receipt, every receipt is a closure. A framework that razors the continuum but tolerates idle trajectories would be inconsistent; QLF razors both.
2. **Constants overdetermination** (§3): the surviving rivals have no story for why α, a₀, sin²θ_W, Koide fall out of their ontology. ZFA does. Within an empirically tied class, explanatory yield is the tiebreaker.
3. **The reconstruction theorem** (§6): the only route to upgrading the tiebreaker into a theorem.

## 6. T1 — The missing keystone: the reconstruction theorem

The one result that would convert exclusivity from an argued position into mathematics:

> **Target.** State postulates, each characterized **without mentioning ZFA** — orthomodularity of the event lattice (Birkhoff–von Neumann), finite information capacity, closure-as-receipt, reversible logic with irreversible realization ([`QLF_Reversibility`](lean/QLF_Reversibility.lean)), no-disconnection — and prove: any event structure satisfying them is isomorphic to ZFA over the 8-twist alphabet.

Its contrapositive is the strongest honest form of "only ZFA": **anything other than ZFA breaks one of five named postulates.** Precedents set the shape and the standard: **Gleason** (the projection lattice forces the Born rule — the model for "the closure lattice forces ZFA realization"), **Solér** (orthomodularity + regularity forces Hilbert space over ℝ/ℂ/ℍ — the finite counterpart should force the ℤ[i] lattice, of which [`QLF_StateSpace`](lean/QLF_StateSpace.lean) is already a fragment), **Hardy/Chiribella** (operational axioms force QM), and **Bell** as the honor standard: few premises, each independently motivated, each experimentally attackable.

**Guardrails, non-negotiable:**
- *Non-circularity:* if "quantum logic" is defined as the logic of ZFA closures, the theorem is a tautology. Each postulate must be stated ZFA-free and must not be equivalent to the conclusion. (Von Neumann's no-go is the cautionary tale: valid, empty, one premise smuggled the conclusion.)
- *Attack surfaces:* each postulate ships with its violation signature — infinite-precision observable (capacity — its formal backing is [`Shannon_Overfit.md`](Shannon_Overfit.md): the negative of `no_real_received` *is* the capacity-violation signature, "an identifiable real exists"), unclosed-event residue (receipt — the QRNG target), non-orthomodular event lattice, etc.
- *The permanent ceiling:* that nature obeys the postulates is empirical, forever. The theorem can only ever be conditional. Its worth is the weakness and independence of its premises, not the grandeur of its conclusion.

**Existing fragments to build from:** `radialAccel_unique` (uniqueness of ν from the closure principle — the method in miniature), the ℤ[i] state-ring resolution, `disjunctive_closure`, the reversibility capstone.

## 7. What this ledger licenses QLF to say

- **Licensed now:** "ZFA is sufficient for all audited observations; overdetermines constants parameter-free; all added-ingredient and deviation-class rivals are experimentally excluded; among surviving exact reconstructions ZFA is uniquely parsimonious and uniquely predictive of constants; exclusivity is conjectured, its defeaters are published (§4c), and its proof target is specified (§6)."
- **Not licensed:** "hidden variables are ruled out" (unqualified); "quantum computation proves the ontology is complete"; "nothing else can happen" (unconditional); any claim of exclusivity that survives the loss of a §4c row.

**Registry patch** (replaces the completeness paragraph in `Open_Problems.md`): *"Sufficiency is supported by parameter-free overdetermination (§3 here) and confirmed exclusions (§4c); Bell/KS/PBR exclude added local, non-contextual, and ψ-epistemic ingredients; error-corrected QC at scale progressively excludes deviation-class dynamics; among surviving exact reconstructions ZFA is distinguished by parsimony and constants overdetermination. Exclusivity is conjectured pending the reconstruction theorem (Completeness_Evidence.md §6). Defeaters: axion detection, α drift, exhaustive 0νββ null, QRNG deviation."*
