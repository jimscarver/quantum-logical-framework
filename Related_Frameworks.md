# Related Frameworks — where ZFA sits among information-theoretic and discrete-substrate theories

**Status:** Positioning, not priority claim. The term *Zero Free Action* is native to the [Quantum Logical Framework](README.md); nothing else in the literature uses it as a foundational principle. But the conceptual *neighborhood* is real and populated, and every neighbor validates one component of QLF while combining none of them. This document names the neighbors precisely — as citation obligations and as the differentiation a critic will (rightly) demand — ranked by closeness.

**The one-line placement.** QLF sits at an intersection nobody else occupies: **a discrete substrate** (shared with Fredkin / 't Hooft / Wolfram) **+ an information-theoretic action with zero as a selection criterion** (nearest: Friston, but statistical vs. ontological) **+ possibilist modality** (shared with constructor theory) **+ machine-verified derivation of physical constants** (shared with no one). Each neighbor validates one component; none combines them; and the parameter-free constants overdetermination ([`Completeness_Evidence.md`](Completeness_Evidence.md) §3) is an output no neighbor produces at all.

**Two relationships, kept apart.** The neighborhood splits cleanly, and the split matters: **Part I** is the *selection-principle rivals* — frameworks that make a foundational claim ZFA must differentiate from (a competing substrate, action principle, or modality). **Part II** is the *mathematics of information* — measure theories QLF **sits on**, not against. The relationship inverts between the two: Part I is differentiation, Part II is inheritance. The honest headline for Part II: every existing mathematics of information answers *"how much information?"*, none answers *"what is information, physically, and when has a distinction happened?"* — and that gap is exactly the slot ZFA claims.

---

## Part I — Selection-principle neighbors (rivals to differentiate from)

| Framework | Shared component | What it lacks vs. ZFA (the differentiation) | Anchor |
|---|---|---|---|
| **Friston — Free Energy Principle** | information-theoretic action, zero *variation* | *statistical & dynamical* (tendency of trajectories), continuous; ZFA is *ontological & exact* (closure or nothing), integer | Friston 2019 |
| **"Minimal Free Action" (Markov chains)** | the *name*, action minimization | statistical physics only; *minimization* not zero; continuum | Ao / Qian lineage |
| **Frieden — Extreme Physical Information** | an information quantity that *is* the action | continuum; *extremal* not zero; no discrete substrate, no verification | Frieden 1998 |
| **Caticha — Entropic Dynamics** | inference-first derivation of QM | probabilistic-continuous, not closure-exact | Caticha 2011 |
| **It-from-bit / finite capacity** | information is physical & finite | supplies *premises*, not a selection rule | Wheeler, Zeilinger–Brukner, Landauer, Bekenstein |
| **Fredkin / 't Hooft / Wolfram** | reality is discrete computation | *no action-zero admissibility criterion* — everything runs, nothing is selected | Fredkin 1990, 't Hooft 2016, Wolfram 2020 |
| **Deutsch–Marletto — Constructor Theory** | possibilist modality (possible vs. impossible) | no counting, no action, no constants | Deutsch–Marletto 2015 |

### 1. Friston's Free Energy Principle — the nearest relative (already linked in the repo)

The FEP's physics formulation is explicitly action-based: the most likely path minimises action, so its variation with respect to the path is zero, with path contributions expressed via surprisal and its gradients. So "**zero variation of an information-theoretic action**" literally appears in Friston 2019. The differences are exactly the ones that define QLF: **FEP is statistical and dynamical** — a claim about which trajectories persisting systems *tend* to follow, over continuous states; **ZFA is ontological and exact** — zero is an *existence criterion* (closure or nothing), integer-valued, no gradients, no tendency. FEP says survivors minimize; ZFA says only closures happen. QLF *derives* the FEP as a consequence — each ZFA closure minimizes free energy by `log 2` ([`Active_Inference_Mathematics.md`](Active_Inference_Mathematics.md) §5, [`Hierarchical_Control.md`](Hierarchical_Control.md) §3, `zfa_closure_minimizes_free_energy`) — so the relationship is *containment*, not rivalry: FEP is the statistical shadow of the exact closure rule. **Read QLF as "Friston rebranded" and you have the direction backwards.**

### 2. "Minimal Free Action" for Markov chains — the name collision

The closest *name*: a principle where minimizing a Boltzmann free action yields equilibrium states and selects stable non-equilibrium steady states, proposed as a basic principle for equilibrium and non-equilibrium statistical physics. Scope is statistical physics only; **minimization, not zero**; continuum throughout. Worth citing precisely *because* the name is one word away — the differentiation (exact-zero existence criterion vs. minimized statistical functional) must be stated so the collision is not mistaken for identity.

### 3. Frieden's Extreme Physical Information — the most developed prior "information = action"

EPI derives Lagrangians and field equations by extremizing Fisher information — the most developed prior attempt to make an information quantity *be* the action. Continuum-based, **extremal rather than zero**, no discrete substrate, no verification layer. QLF's advance over EPI is the discreteness (which removes the continuum pathologies EPI inherits) and the zero-as-existence reading (not extremize-to-find-equations but close-or-nothing).

### 4. Caticha's Entropic Dynamics — inference-first, but continuous

QM reconstructed as entropic inference, with time built so the future is independent of the past given the present. **Inference-first like QLF**, but probabilistic-continuous rather than closure-exact. Where Caticha updates a probability distribution, QLF latches a discrete receipt; where Caticha's dynamics is a diffusion, QLF's is a prune.

### 5. The finite-capacity lineage — ancestors, not rivals

Wheeler's *it-from-bit*, Zeilinger–Brukner's *an elementary system carries one bit*, Landauer's *information is physical*, the Bekenstein bound. These are the **ancestors of the finite-capacity postulate** ([`Shannon_Overfit.md`](Shannon_Overfit.md), [`Completeness_Evidence.md`](Completeness_Evidence.md) §6) — they supply *premises* (finiteness, the bit, the bound), not a *selection rule*. ZFA is what you add to the finite-capacity lineage to decide *which* finite configurations exist.

### 6. Discrete-substrate rivals *without* a selection principle — the embarrassment of riches

Fredkin's reversible cellular automata (with an explicit information-conservation law), 't Hooft's cellular-automaton interpretation of QM, Wolfram's hypergraph rewriting. All share "**reality is discrete computation**" — QLF's substrate ontology. None has an **action-zero admissibility criterion** deciding what exists: everything runs, nothing is selected. That is the cleanest one-line differentiation available — *their* problem (everything computes) is exactly the gap ZFA fills (only closures are receipted). QLF's `full_zeno_prune` is the selection these frameworks lack. (Reversibility caveat: Fredkin/'t Hooft are *reversible* by construction; QLF's arrow is the many-to-one closure, [`Reversibility.md`](Reversibility.md).)

### 7. Constructor Theory (Deutsch–Marletto) — the possibilist cousin

A fundamental ontology of *possible vs. impossible transformations*. This is the **possibilist cousin**: it shares QLF's modal framing (physics as what can and cannot happen — the possibilism of [`Philosophy.md`](Philosophy.md) §3) but has **no counting, no action, no constants**. Constructor theory says what is possible; ZFA says which possibilities close, and how many, and what values fall out.

### 8. Hegelian dialectic — a formal semantics, one direction only

The dialectical intuition (truth as a completed process; *Aufhebung* as cancel/preserve/lift) has a real structural correspondence to ZFA closure — but stated in **one direction only**: *ZFA offers a formal semantics for the dialectical intuition; Hegel provides zero evidential support for ZFA.* Developed, with the anti-dialetheist thesis and the Lawvere/Heraclitus lineage, in [`Philosophy.md`](Philosophy.md) §9 ("Dialectical closure: cancel, preserve, lift"). Prior art that keeps the genre respectable: **Lawvere's** decades formalizing Hegel's "unity of opposites" as adjoint functors in category theory.

---

## What no neighbor produces

Each row above validates one component. **None combines them**, and — the decisive point — **none derives a physical constant.** The parameter-free overdetermination (α, `a₀`, `sin²θ_W`, Koide `Q`, `π`, the `14π` hierarchy — [`Completeness_Evidence.md`](Completeness_Evidence.md) §3) is the output that distinguishes ZFA from the entire neighborhood: FEP, EPI, entropic dynamics, the CA programs, and constructor theory produce *frameworks*; none produces `137`. That is the empirical discriminator, and it is why the intersection QLF occupies is not merely unoccupied but *productive* where the neighbors are not.

---

## Part II — The mathematics of information (infrastructure QLF builds on)

Here the relationship inverts: these are not rivals but the **measure stack** QLF sits on. Each answers *how much* information; none answers *what* information *is*, physically, or *when* a distinction has *happened*. ZFA claims exactly that missing bottom layer.

| Body of theory | QLF's relationship | The one line |
|---|---|---|
| **Shannon** (1948) | inheritance | the census *is* Shannon counting on the substrate (`log 2`/closure) |
| **Kolmogorov–Chaitin (AIT)** | the deepest tie (was uncited) | the non-identifiable tail = reals of infinite `K`; `Ω` = the named fantasy-tier object |
| **Fisher / information geometry** (Amari) | rendering layer | Fisher structure should *emerge* from census statistics in the limit, not be postulated |
| **Quantum information** | the load-bearing floor | stabilizer/Clifford = integer arithmetic on `ℤ[i]`; resource theories = ledger accounting |
| **Semantic information** | the open frontier QLF *contributes to* | meaning = position in the admissibility graph; the #65 closure-token basis is a candidate |

### 1. Shannon — inheritance, nothing to fight

Information as reduction of uncertainty over distinguishable alternatives — and Shannon *explicitly disclaims semantics* (1948: meaning is "irrelevant to the engineering problem"). QLF's relationship is pure inheritance: the closure census is Shannon counting on the substrate (`log 2` per closure, `ΔF = −log 2`, the Landauer bridge, [`Shannon_And_Phase.md`](Shannon_And_Phase.md)/`QLF_FreeEnergy`), and the finite-capacity premise of the overfit theorems is Shannon–Hartley plus Bekenstein ([`Shannon_Overfit.md`](Shannon_Overfit.md) Theorem C). Everything to cite, nothing to fight.

### 2. Kolmogorov–Chaitin (algorithmic information theory) — the deepest connection

AIT makes the fantasy tier **quantitative**, and it is the connection the repo was missing. A real is *lawful* iff it has a finite program; the **non-identifiable tail** of `Shannon_Overfit.md` Theorem B (`tail_unconstrained`) is precisely the reals of **infinite Kolmogorov complexity**, and **Chaitin's `Ω`** (the halting probability) sits exactly on the boundary — definable, uncomputable: the canonical fantasy-tier object *with a name*. Two things handled honestly: (i) `K` itself is **uncomputable** — the measure of computability can't be computed — which is why QLF's **RCA₀ / below-Busy-Beaver** discipline is the right response, not a dodge ([`ReverseMathematics.md`](ReverseMathematics.md) already speaks this language); and (ii) **Chaitin's incompleteness** is the strongest independent support in mathematics for *"finite systems certify only finitely much"* — the exact content of the finite-capacity postulate. AIT prices descriptions; ZFA says which descriptions get receipted.

### 3. Fisher information / information geometry (Amari) — a rendering-layer object

Continuum through and through (Frieden's EPI, Part I §3, is the neighbor who built physics *on* it). For QLF it is a **rendering-layer** object: whatever Fisher-geometric structure physics uses should **emerge from census statistics in the limit**, not be postulated — the same "continuum as completion of the discrete" move as `π` from the census ([`QLF_PhysicalPi`](lean/QLF_PhysicalPi.lean)) and Hilbert space as the completion of the `ℤ[i]` lattice ([`The_QLF_State_Space.md`](The_QLF_State_Space.md)).

### 4. Quantum information — the load-bearing floor

Not a competitor — the floor QLF stands on. The **stabilizer/Clifford** formalism is *exactly integer arithmetic on the `ℤ[i]` lattice* ([`The_QLF_State_Space.md`](The_QLF_State_Space.md), `QLF_StateSpace`); **resource theories** (entanglement as an unspeakable currency, majorization, distillation) are ledger accounting in all but name. QLF's claim is that this **integer skeleton is the ontology and the amplitudes are rendering** — a *reading* of quantum information, not a rival to it. The Gottesman–Knill boundary (Clifford vs. `T`-gate / `ζ₈`) *is* the substrate↔continuum boundary.

### 5. Semantic information — the open frontier where QLF has a proposal

This is the one region where QLF **contributes to** the mathematics of information rather than drawing on it. Carnap–Bar-Hillel semantic information **collapses on contradiction** (the notorious paradox: a contradiction carries *maximal* information); Floridi patched it by requiring **truthfulness**; nobody has a settled mathematics of *meaning*. QLF's entry is **closure-as-receipt**: meaning = position in the admissibility graph, semantic content = what closes with what — the closure-token basis of [`Closure_Token_Basis.md`](Closure_Token_Basis.md) (issue [#65](https://github.com/jimscarver/quantum-logical-framework/issues/65)) **is** a candidate mathematics of semantic information, with the grounding map its named open problem. (And it resolves the Carnap–Bar-Hillel paradox — now as a **theorem**: a contradiction is an *unbalanced ledger* which admits no closure, so it carries *no* receipt, not maximal information — [`QLF_ContradictionReceipt`](lean/QLF_ContradictionReceipt.lean), `contradiction_no_receipt`.)

### Method-precedents — QLF's genre done respectably

- **Knuth** derives probability and information measures from **lattice / order structure alone** — the same "structure forces the measure" move as the Gleason-style reconstruction target ([`Completeness_Evidence.md`](Completeness_Evidence.md) §6).
- **Baez–Fritz–Leinster** characterize **Shannon entropy category-theoretically** as the *unique* functor with given properties — uniqueness-theorem discipline applied to information itself, the shape a QLF reconstruction of the census measure would take. **First executed fragment:** the finite/counting wing is now machine-checked — additivity on independent ledgers *forces* the census measure to be `|s| · c` and pins it uniquely from its generator value ([`QLF_EntropyUniqueness`](lean/QLF_EntropyUniqueness.lean); the full distributional `−Σ p log p` uniqueness is the analytic residual, [#115](https://github.com/jimscarver/quantum-logical-framework/issues/115) item 6).

### The synthesis line

Existing mathematics of information is a stack of **measure theories over an unspecified ontology**: Shannon counts distinctions, AIT prices descriptions, Fisher measures sensitivity, quantum information ledgers resources — **none says what a distinction *is* or when it has *happened*.** ZFA supplies the missing bottom layer: **information = realized distinction = closure receipt.** Shannon counting, AIT bounds, Fisher geometry, and stabilizer arithmetic then live *on top* as the measure stack over a now-specified ontology. QLF is the **foundation under the stack, not a rival to it** — which is simultaneously the most accurate and the most defensible framing.

## References

### Internal
- [`Completeness_Evidence.md`](Completeness_Evidence.md) — the exclusivity ledger; §3 constants overdetermination, §6 the finite-capacity postulate.
- [`Shannon_Overfit.md`](Shannon_Overfit.md) — the finite-capacity lineage made into a theorem (non-identifiability).
- [`Active_Inference_Mathematics.md`](Active_Inference_Mathematics.md) — the FEP derivation and adjacency.
- [`Philosophy.md`](Philosophy.md) §3 (possibilism), §9 (dialectical closure).
- [`Reversibility.md`](Reversibility.md) — the arrow vs. the reversible-CA rivals.

### External
- Friston, K. (2019). *A free energy principle for a particular physics.* arXiv:1906.10184.
- Ao, P. (2008). *Emerging of stochastic dynamical equalities and steady state thermodynamics.* Commun. Theor. Phys. 49, 1073 — "minimal free action" lineage.
- Frieden, B. R. (1998). *Physics from Fisher Information.* Cambridge University Press.
- Caticha, A. (2011). *Entropic Dynamics.* AIP Conf. Proc. 1305, 20.
- Wheeler, J. A. (1990). *Information, physics, quantum: the search for links.*
- Brukner, Č. & Zeilinger, A. (2003). *Information and fundamental elements of the structure of quantum theory.*
- Landauer, R. (1961). *Irreversibility and heat generation in the computing process.* IBM J. Res. Dev. 5, 183.
- Bekenstein, J. D. (1981). *Universal upper bound on the entropy-to-energy ratio.* Phys. Rev. D 23, 287.
- Fredkin, E. (1990). *Digital mechanics.* Physica D 45, 254.
- 't Hooft, G. (2016). *The Cellular Automaton Interpretation of Quantum Mechanics.* Springer.
- Wolfram, S. (2020). *A Project to Find the Fundamental Theory of Physics.*
- Deutsch, D. & Marletto, C. (2015). *Constructor theory of information.* Proc. R. Soc. A 471, 20140540.

### External — the mathematics of information (Part II)
- Shannon, C. E. (1948). *A Mathematical Theory of Communication.* Bell Syst. Tech. J. 27, 379–423, 623–656.
- Kolmogorov, A. N. (1965). *Three approaches to the quantitative definition of information.* Problems Inform. Transmission 1, 1–7.
- Chaitin, G. J. (1975). *A theory of program size formally identical to information theory.* J. ACM 22, 329 — and *Ω*, the halting probability.
- Li, M. & Vitányi, P. (2019). *An Introduction to Kolmogorov Complexity and Its Applications* (4th ed.). Springer — the AIT standard reference.
- Amari, S. (2016). *Information Geometry and Its Applications.* Springer.
- Carnap, R. & Bar-Hillel, Y. (1952). *An Outline of a Theory of Semantic Information.* MIT RLE Tech. Rep. 247 — the contradiction-carries-maximal-information paradox.
- Floridi, L. (2004). *Outline of a theory of strongly semantic information.* Minds and Machines 14, 197 — the truthfulness patch.
- Knuth, K. H. (2005). *Lattice duality: the origin of probability and entropy.* Neurocomputing 67, 245 — measures from order structure.
- Baez, J., Fritz, T. & Leinster, T. (2011). *A characterization of entropy in terms of information loss.* Entropy 13, 1945 — Shannon entropy as the unique functor.
- Gottesman, D. (1998). *The Heisenberg representation of quantum computers* — the stabilizer/Clifford (Gottesman–Knill) fragment.
