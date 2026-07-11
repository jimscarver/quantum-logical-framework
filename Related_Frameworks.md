# Related Frameworks — where ZFA sits among information-theoretic and discrete-substrate theories

**Status:** Positioning, not priority claim. The term *Zero Free Action* is native to the [Quantum Logical Framework](README.md); nothing else in the literature uses it as a foundational principle. But the conceptual *neighborhood* is real and populated, and every neighbor validates one component of QLF while combining none of them. This document names the neighbors precisely — as citation obligations and as the differentiation a critic will (rightly) demand — ranked by closeness.

**The one-line placement.** QLF sits at an intersection nobody else occupies: **a discrete substrate** (shared with Fredkin / 't Hooft / Wolfram) **+ an information-theoretic action with zero as a selection criterion** (nearest: Friston, but statistical vs. ontological) **+ possibilist modality** (shared with constructor theory) **+ machine-verified derivation of physical constants** (shared with no one). Each neighbor validates one component; none combines them; and the parameter-free constants overdetermination ([`Completeness_Evidence.md`](Completeness_Evidence.md) §3) is an output no neighbor produces at all.

---

## The neighborhood, ranked by closeness

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
