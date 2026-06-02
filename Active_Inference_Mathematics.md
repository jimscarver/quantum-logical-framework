# Active-Inference Mathematics

**A mathematical system with active inference built into its foundation.** Not classical mathematics, not standard constructive mathematics — a third thing: the math that an agent inside a Markov blanket constructs by free-energy-minimizing pruning of its possibility tree, where every admissible step is a half-spin ZFA closure carrying exactly `log 2` nats of resolved information.

This document is the meta-level entry point to QLF's mathematical foundations. Specialized derivations live in their own docs; this one names the system, fixes its primitives, states its single rule, and inventories what's been done with honest scoping (derived / partial / open).

## 1. The framing

Classical mathematics (ZFC) takes propositions to be true or false in a static platonic universe. Standard constructive mathematics (Bishop, Martin-Löf, Coquand) takes propositions to be proved or unproved by terminating algorithms. QLF takes a third view:

**Propositions are admissible trajectories of a free-energy-minimizing agent.**

The agent is a Markov blanket (in the [Hadrons_Markov_Blankets.md](Hadrons_Markov_Blankets.md) sense). The trajectory is a sequence of ZFA closures. The free-energy minimization is the per-event `ΔF = −log 2` saturation derived in [MRE.md §2.1](MRE.md). The proposition is "the trajectory exists in the possibility tree the blanket can integrate."

This is mathematics with **active inference built in**.

| | Classical (ZFC) | Constructive (BISH/CIC) | **Active-inference (QLF)** |
|---|---|---|---|
| Truth value | Platonic | Provable by terminating algorithm | **Admissible trajectory in possibility tree** |
| Agent / observer | None | None | **Markov blanket inside every closure** |
| Selection principle | Logical consequence | Termination | **Per-event ΔF = −log 2 saturation** |
| Boundary | Universal | Universal | **Observer-relative; emerges with the math** |
| Math object | Set | Computable term | **Half-spin ZFA closure (Hermitian pair)** |
| Continuum | Postulated | Built from Cauchy/Dedekind | **Statistical shadow of finite closure ensembles** |
| Infinity | Completed | Approximable, never realised | **Emergent — only finite closures survive** |
| Probability | Added (measure theory) | Added | **Intrinsic — Born rule derived from path-counting** |
| Information | Added (Shannon/von Neumann) | Added | **Per-atom `log 2` quantum, built in** |
| Proof style | Often non-constructive | Constructive | **Mechanizable in Lean 4; RCA₀ floor** |

## 2. Primitives

Three primitives suffice:

1. **The 8-twist alphabet** `{^, v, <, >, /, \, +, -}` — generative kernel for all admissible structures ([eight-twists-sufficiency.md](eight-twists-sufficiency.md), [QuCalc.md](QuCalc.md)). Higher dimensions and richer geometries are not added; they emerge from parallel composition (`|`) of strings in this alphabet.

2. **ZFA closure** — count balance ∧ Pauli closure ([Experimental_Consistency.md §2.1](Experimental_Consistency.md)). The 8-twist algebra has a Pauli structure (the Σ₈ generators of [Lagrangian_Formulation.md](Lagrangian_Formulation.md)); ZFA selects sequences whose matrix product folds to a scalar (the Pauli group elements `{±I, ±iI}`) AND whose pos/neg counts balance.

3. **The Markov blanket** — topological boundary screening internal free-action deficits ([Hadrons_Markov_Blankets.md](Hadrons_Markov_Blankets.md)). Every agent in QLF is a Markov blanket at some scale; every Markov blanket is a closed ZFA loop with internal admissible compositions and external causal-frontier exposure.

No axiom of choice. No appeal to large-cardinal infinities. No assumed continuum. Just discrete sequences over a finite alphabet, a single closure rule, and the boundary that separates "internal admissible composition" from "external causal frontier."

## 3. The single rule

**Every event in QLF is a half-spin ZFA closure** — a Hermitian-conjugate-paired sequence whose Pauli matrix product folds to a scalar element of the Pauli group. The minimal such closure is a 4-twist loop (`^v`, `<>`, `/\`, `+-`, or their compositions like `^<v>`); larger structures are parallel compositions.

The closure event carries information `D_KL(q ‖ p) ≤ log 2`, saturated only at the 50/50 binary partition ([MRE.md §2.1](MRE.md)). Each closure therefore:

- Reduces the agent's free energy by exactly `−log 2` nats (the per-event quantum derived in [Hierarchical_Control.md §3](Hierarchical_Control.md))
- Selects one of two equally-weighted possibility-tree branches (the [Born_Rule.md](Born_Rule.md) probability assignment)
- Folds to `−I` in the Pauli group, contributing the −1 phase of a fermion 360° rotation (the spin-statistics origin per [Spin_Statistics.md](Spin_Statistics.md))
- Conserves information bit-for-bit across creation and annihilation ([MRE.md](MRE.md) ↔ [Annihilation.md](Annihilation.md), [Conservation.md §6](Conservation.md))

This is the math's selection principle. A trajectory is admissible iff every step is a half-spin ZFA closure. The 1/2-spin atom is the unique fixed point of three independent constraints — set-theoretic minimality, algebraic Pauli closure, information-theoretic optimality — that all coincide on the same object ([HALF-SPIN-ZFA-EMBEDDING.md §3a](HALF-SPIN-ZFA-EMBEDDING.md)).

## 4. Mathematical objects as admissible trajectories

A mathematical object in active-inference mathematics is **a sequence of admissible closures that the agent can integrate into its Markov-blanket record**.

- A **number** is a stable closure with a specific length and ZFA signature.
- A **function** is a transformation between admissible closure ensembles.
- A **geometry** is a class of admissible trajectories under a specific compositional constraint ([Holographic.md](Holographic.md) projects 2-component QuCalc logic into 3D observable structure; [Langlands.md §2](Langlands.md) argues QLF can generate any geometry).
- An **equation** is the assertion that two closure trajectories yield the same Markov-blanket record.
- A **proof** is the explicit trajectory the agent traverses; in Lean this becomes a mechanically checkable term in RCA₀ (or higher if the bridge axiom is invoked).

Continuum mathematics, set theory, and standard analytic objects appear as **statistical shadows** of admissible trajectory ensembles in the large-N limit. The real line is the limit of discrete admissible closure densities; ζ is the analytic image of the QLF generating function under the Mellin transform ([ReverseMathematics.md §4](ReverseMathematics.md)).

## 5. Scoreboard — what has been done

Honest derived / partial / open inventory, matching the standard in [Standard_Model.md](Standard_Model.md):

| Result | QLF anchor | Status |
|---|---|---|
| **1/2-spin algebra (Pauli, Dirac)** | `tau_xy_product` etc. machine-verified | ✓ Derived |
| **Spin-statistics theorem** | parallel-vs-sequence composition; per-atom `−I` fold | ✓ Derived |
| **Hermitian conjugacy as duality** | `E + E^† ≡ ZFA` Lean-verified | ✓ Derived |
| **Per-event `log 2` quantum** | binary-partition info-gain bound | ✓ Derived |
| **Born rule** | path-counting + uniform prior on possibility tree | ✓ Derived ([Born_Rule.md](Born_Rule.md)) |
| **Conservation laws (energy / momentum / charge / information / CPT)** | 8-twist symmetries → conserved currents | ✓ Derived ([Conservation.md](Conservation.md)) |
| **No magnetic monopoles** | ZFA closure forces ∇·B = 0 | ✓ Lean-verified (`no_magnetic_monopoles`) |
| **Friston free energy principle** | each ZFA closure minimizes F by `log 2` | ✓ Derived ([Hierarchical_Control.md §3](Hierarchical_Control.md)) |
| **Hydrogen spectrum** | Bohr derivation in ZFA language; 0.053 % NIST match | ✓ Derived ([Hydrogen.md](Hydrogen.md)) |
| **Maxwell field operators** | per-axis Pauli mapping; Lean-verified ∇·B = 0 | ✓ Derived ([Maxwell.md](Maxwell.md)) |
| **No decoherence (universal coherence)** | `decoherence_impossibility` Lean-verified | ✓ Derived ([Decoherence.md](Decoherence.md)) |
| **Atomic shells (s, p through Z = 10)** | Pauli-blocking + orthogonal-axis routing | ✓ Derived ([Atom.md](Atom.md)) |
| **Combinatorial closed form (5ⁿ+3ⁿ)/2 for resonant sum** | binomial expansion separation | ✓ Derived ([Riemann-Conjecture-Proof.md](Riemann-Conjecture-Proof.md)) |
| **Riemann Hypothesis** | conditional on the bridge axiom; MRE motivation now stated | ⚠ Conditional ([ReverseMathematics.md §4](ReverseMathematics.md)) |
| **Langlands correspondences** | bottom-up scaffolding; specific dictionary in §3 | ⚠ Scaffolding ([Langlands.md](Langlands.md)) |
| **Cosmological matter dominance** | residual-clustering of LH/RH topology | ⚠ Qualitative ([CP-Violation-and-Chirality.md](CP-Violation-and-Chirality.md), [Annihilation.md §5](Annihilation.md)) |
| **Cosmic expansion / age** | ZFA event rate as cosmic clock | ⚠ Order-of-magnitude ([AgeOfUniverse.md](AgeOfUniverse.md)) |
| **Standard Model gauge groups (SU(3), SU(2), U(1))** | structural sketch; U(1) derived, others open | ⚠ Partial ([Standard_Model.md](Standard_Model.md)) |
| **Quantitative mass spectrum** | gauge-fold depth → mass | ✗ Open |
| **CKM / PMNS mixing angles** | chirality rotation between generations | ✗ Open |
| **Lorentz covariance of EM at all scales** | τ_i = iσ_i algebra suggests path | ✗ Open |
| **Gravitational waves, Mercury perihelion, full GR** | discrete-to-continuum bridge | ✗ Open |
| **CKM/PMNS, sterile neutrino, dark sector** | no quantitative prediction | ✗ Open |

**Summary**: roughly 13 derived, 4 partial/conditional, 7 fully open. Same intellectual-honesty standard as [Experimental_Consistency.md](Experimental_Consistency.md). Results stated as "admissible trajectories the framework supports" rather than as "theorems of QLF" — RH conditional on the bridge axiom, Langlands as constructive scaffolding, Standard Model gauge identifications as open work.

## 6. What this is NOT

- **Not a Theory of Everything claim.** Active-inference mathematics is a foundational reframing; it doesn't bypass the open empirical work in physics (g-2, perihelion, etc., per [Experimental_Consistency.md](Experimental_Consistency.md)) or the open formal work in mathematics (bridge axiom, gauge-subgroup identification).
- **Not a replacement for ZFC or constructive mathematics.** Standard mathematics works fine for the questions it asks. Active-inference mathematics is the framework needed when the question is **what an agent inside a Markov blanket can compute** — physics, biology, observer-relative phenomena.
- **Not Wolfram-style "everything is computation."** QLF's selection principle is specific (ZFA + MRE saturation); it is not the assertion that anything computable is real. The pruning is structurally enforced, not stipulated by an external Ruliad.
- **Not a denial of Platonism.** It's a relocation: mathematical truth still has structure; that structure is the admissible-trajectory space under active-inference selection. Whether this space is "Platonic" is a separate philosophical question ([Philosophy.md](Philosophy.md), [possibilist-ontology.md](possibilist-ontology.md)).

## 7. Open work

- **Lean formalization** of `Active_Inference_Selection` as a unified principle: every admissible RhoProcess minimises a per-event free-energy functional. Connects to the existing `rho_process_always_zfa`, `bra_ket_always_balanced`, `decoherence_impossibility`.
- **Discharge the bridge axioms** flagged across [Riemann-Conjecture-Proof.md](Riemann-Conjecture-Proof.md), [Langlands.md](Langlands.md), [Standard_Model.md](Standard_Model.md), [Quantum_Gravity.md](Quantum_Gravity.md). Each is a specific WKL₀-level claim with an MRE-saturation motivation ([ReverseMathematics.md §4](ReverseMathematics.md)).
- **Quantitative match** against the open items in §5 — mass ratios, mixing matrices, dark sector, gravitational tests.
- **Categorical embedding** — express active-inference mathematics as a category whose objects are admissible trajectories and whose morphisms are ZFA-preserving compositions. Would tie the framework to homotopy type theory and to Friston's own category-theoretic FEP formulation.

## References

### Foundations (internal)

- [Philosophy.md](Philosophy.md) — possibilist ontology; ZFA as the sole selection principle
- [possibilist-ontology.md](possibilist-ontology.md) — explicit ontological framing
- [eight-twists-sufficiency.md](eight-twists-sufficiency.md) — universal generation from the 8-twist alphabet
- [HALF-SPIN-ZFA-EMBEDDING.md](HALF-SPIN-ZFA-EMBEDDING.md) — spin-1/2 set-theoretic embedding
- [MRE.md](MRE.md) — per-event `log 2` quantum
- [Hierarchical_Control.md](Hierarchical_Control.md) — Friston FEP derivation
- [Hadrons_Markov_Blankets.md](Hadrons_Markov_Blankets.md) — Markov blanket as topological boundary
- [active_inference.md](active_inference.md) + [BayesianMechanics.md](BayesianMechanics.md) — agent-side framing
- [ReverseMathematics.md](ReverseMathematics.md) — RCA₀ floor; bridge axioms at WKL₀
- [Lagrangian_Formulation.md](Lagrangian_Formulation.md) — Σ₈ algebra; ℒ = 0 variational principle
- [Hermitian_Conjugacy_Proof.md](Hermitian_Conjugacy_Proof.md) — `E + E^† ≡ ZFA`
- [Universality.md](Universality.md) — QLF generates all terminating finitely-encoded computations

### Specialized derivations (internal)

- [Born_Rule.md](Born_Rule.md), [Measurement_Problem.md](Measurement_Problem.md), [Decoherence.md](Decoherence.md), [Conservation.md](Conservation.md), [Spin_Statistics.md](Spin_Statistics.md), [Entanglement.md](Entanglement.md), [Annihilation.md](Annihilation.md), [Maxwell.md](Maxwell.md), [Hydrogen.md](Hydrogen.md), [Atom.md](Atom.md), [Quantum_Gravity.md](Quantum_Gravity.md), [Standard_Model.md](Standard_Model.md), [Riemann-Conjecture-Proof.md](Riemann-Conjecture-Proof.md), [Langlands.md](Langlands.md), [Experimental_Consistency.md](Experimental_Consistency.md)

### External

- Friston, K. (2010). *The free-energy principle: a unified brain theory?* Nature Reviews Neuroscience 11, 127–138.
- Friston, K. (2019). *A free energy principle for a particular physics.* arXiv:1906.10184.
- Bishop, E. (1967). *Foundations of Constructive Analysis.* McGraw-Hill — classical constructive math.
- Martin-Löf, P. (1984). *Intuitionistic Type Theory.* Bibliopolis.
- Coquand, T., Huet, G. (1988). *The Calculus of Constructions.* Inf. Comput. 76 — type theory foundation.
- Friedman, H. (1975). Reverse Mathematics program — RCA₀ / WKL₀ / ACA₀ hierarchy.
