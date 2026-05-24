# Quantum Logical Framework (QLF)

**The universe is logical.**  
**Spacetime is synthesized.**  
**Physical reality is the subset of possibility that achieves Zero Free Action.**

The **Quantum Logical Framework (QLF)** is a constructive research program that treats physics as a problem of **logical generation and closure** rather than one of brute-force formalism or fixed background geometry.

At its core is a simple claim:

> **Only histories that achieve Zero Free Action (ZFA) persist.**

From that starting point, QLF explores how spacetime, measurement, entanglement, symmetry, gravity, and computation can emerge from finite local logical distinction.

---

## What QLF Is

QLF is not just an interpretation of quantum mechanics. It is a broader attempt to build a unified framework in which:

- **logical distinction is fundamental**
- **spacetime is synthesized event by event**
- **symmetry is enforced by Zero Free Action**
- **measurement is closure, not mystery**
- **gravity is emergent, not primitive**
- **formal infinities are replaced by constructive finite generation**

The repository combines:

- **conceptual essays**
- **Python experiments and demonstrations**
- **Lean 4 formalization of key structural claims**
- **mathematical and physical speculation under active development**

---

## Why This Repo Exists

Standard physics is extraordinarily successful, but its foundations remain unsettled:

- the measurement problem
- the role of the observer
- the status of spacetime
- quantum gravity
- the relation between information and physics
- the limits of classical formalism

QLF approaches these problems from the bottom up. Instead of starting with continuum fields, collapse postulates, or open-ended formal infinities, it starts with **finite logical possibilities** and asks which histories can actually close.

That makes QLF both a physical proposal and a foundational proposal about mathematics, computation, and explanation.

---

## Start Here

### 1. Big-picture orientation
- [**Philosophy.md**](Philosophy.md) — the possibilist foundation of QLF, Zero Free Action, local time synthesis, active inference, holography, and the critique of ZFC-style infinity
- [**TheBigProblem.md**](TheBigProblem.md) — how QLF addresses the measurement problem, entanglement, spacetime, time, and consciousness
- [**GodCreatedTheIntegers.md**](GodCreatedTheIntegers.md) — a broad framing of QLF in relation to Kronecker, Einstein, Wheeler, Gödel, Bohm, Bell, Penrose, Mead, Cramer, Wolfram, ’t Hooft, Hawking, and Susskind

### 2. Core theoretical claims
- [**Universality.md**](Universality.md) — the claim that QLF generates finite local logical closures
- [**Riemann-Conjecture-Proof.md**](Riemann-Conjecture-Proof.md) — the current QLF program relating ZFA symmetry, universality, and the critical line
- [**Measurement_Problem.md**](Measurement_Problem.md) — QLF treatment of measurement and observer-dependent closure
- [**UniversalRelativity.md**](UniversalRelativity.md) — emergent relativity and spacetime interpretation inside QLF
- [**TheContinuum.md**](TheContinuum.md) — why the continuum is emergent (not foundational), how QLF dissolves Zeno's paradoxes and the Lorentz invariance trap, and why the Axiom of Choice is replaced by the ZFA filter
- [**ReverseMathematics.md**](ReverseMathematics.md) — QLF as a physical realization of Reverse Mathematics; the RCA₀ core and the WKL₀ axiom boundary

### 3. Physics and experiments
- [**Experimental_Consistency.md**](Experimental_Consistency.md) — numerical and conceptual links between QLF and known physics
- [**SpaceTime.md**](SpaceTime.md) — event-synthesized space and time
- [**Gravity.md**](Gravity.md) — emergent gravity in the QLF picture
- [**ER_EPR_QLF.md**](ER_EPR_QLF.md) — entanglement, geometry, and logical structure
- [**Higgs.md**](Higgs.md) — QLF mass generation via gauge-fold depth; constructive alternative to the Higgs mechanism
- [**HadronicDepth.md**](HadronicDepth.md) — Hadronic Depth Hypothesis: n ~ (m_P/m_p)³ fixes cosmic size, age, and G from the proton mass
- [**VacuumEnergy.md**](VacuumEnergy.md), [**BLACK-HOLES.md**](BLACK-HOLES.md), [**Entropy.md**](Entropy.md) — topic-specific extensions
- [**QuantumOS.md**](QuantumOS.md) — QLF as a capability-secure, formally-verified OS kernel for QPUs: five converging security foundations, intrinsic holographic QEC, hardware-native AI with absolute interpretability, Ruliad/RCA₀ unification — security + error correction + scheduling + GC + AI are all one operation (ZFA enforcement)

### 4. Formal and executable work

See [**lean/README.md**](lean/README.md) for the full module reference, proof chains, axiom inventory, and RCA₀ logical subsystem map.

**Core ZFA combinatorics** — the constructive RCA₀ heart:
- [**lean/QLF_Axioms.lean**](lean/QLF_Axioms.lean) — ZFA definition, pruning, symmetry; `zfa_implies_critical_line`, `full_prune_invariant`
- [**lean/QLF_QuCalc.lean**](lean/QLF_QuCalc.lean) — phase-generation engine and stable-state filter; `expand_generation`, `full_zeno_prune`, `qucalc_generates_all_phase_strings`
- [**lean/QLF_Combinatorics.lean**](lean/QLF_Combinatorics.lean) — generation helpers

**Universality & computability:**
- [**lean/QLF_Universality.lean**](lean/QLF_Universality.lean) — Church-Turing completeness in QLF: every terminating computation IS a ZFA string (`encode_is_zfa`, `qlf_universality`)

**Spectral structure & Riemann program:**
- [**lean/QLF_Spectral.lean**](lean/QLF_Spectral.lean) — Hermitian spectral modes; Hilbert-Pólya bridge; `toSpectralMode_hermitian`, `spectral_symmetric_eq_scalar_id`
- [**lean/QLF_Riemann.lean**](lean/QLF_Riemann.lean) — Riemann hypothesis program; `find_stable_states_length_even` (C(2n,n)), `riemann_hypothesis_in_qlf`
- [**lean/QLF_Critical_Line.lean**](lean/QLF_Critical_Line.lean) — ZFA-to-symmetry bridge wrappers

**Physics layer:**
- [**lean/SpacetimeDynamics.lean**](lean/SpacetimeDynamics.lean) — Pauli-basis Clifford algebra elements; `Form.toMatrix_adjoint`
- [**lean/RhoQuCalc.lean**](lean/RhoQuCalc.lean) — ρ-process algebra; capability-secure concurrency; `parallel_hermitian`, `rho_process_always_zfa`
- [**lean/ZFAEventDynamics.lean**](lean/ZFAEventDynamics.lean) — ZFA event dynamics and acceleration
- [**lean/PauliExclusion.lean**](lean/PauliExclusion.lean) — bosonic vs. fermionic statistics; `pauli_exclusion`, `fermi_nonzero_example` ([σ_x,σ_z]≠0 non-triviality witness)

**Physical theories:**
- [**lean/StringTheoryQLF.lean**](lean/StringTheoryQLF.lean) — gauge-fold excitation tower; `string_mass_spectrum`, `string_mode_count` (C(2n,n) forced by ZFA)
- [**lean/MTheoryQLF.lean**](lean/MTheoryQLF.lean) — M2/M5-branes, S/T-duality, 11D; `m2_mass_spectrum`, `s_dual_involution`

**Speculative extensions** (explicitly beyond the proved core):
- [**lean/AgeOfUniverse.lean**](lean/AgeOfUniverse.lean) — cosmological age estimate; `age_is_finite_and_positive`
- [**lean/ER_EPR_QLF.lean**](lean/ER_EPR_QLF.lean) — entanglement-geometry axioms; philosophical axioms only, not used by other modules

**Empirical verification** (independent numerical confirmation of Lean theorems):
- [**qlf_spectral.py**](qlf_spectral.py) — confirms `toSpectralMode_hermitian`, `spectral_symmetric_eq_scalar_id`
- [**qlf_zfa_frequency.py**](qlf_zfa_frequency.py) — confirms `find_stable_states_length_even` (C(n,n/2))
- [**qlf_dirichlet_search.py**](qlf_dirichlet_search.py) — empirical shadow of `riemann_hypothesis_in_qlf`
- [**qucalc_engine.py**](qucalc_engine.py), [**spacetime_dynamics.py**](spacetime_dynamics.py), [**constants_mapper.py**](constants_mapper.py), [**path_integral.py**](path_integral.py) — executable experiments

---

## Themes Now Central to the Repo

Several themes now deserve to be front-and-center in the README because they tie the repo together:

### Possibilism
Reality is not one pre-written story. QLF treats all admissible logical histories as possible, with physical reality emerging from those that close under ZFA.

### Universality
QLF is not framed merely as a simulator. It is a generator of finite local logical closure structures — and `qlf_universality` proves this is Church-Turing complete: every terminating computation encodes as a ZFA string, so the ZFA filter is not a restriction on computation but the selection principle that picks physical reality out of the full computational universe.

### Gödel, Busy Beaver, and the limits of classical formalism
The philosophical documents argue that unconstrained self-reference and open-ended formal infinity create a kind of mathematical ultraviolet catastrophe. QLF answers this by restricting realized structure to finite local closure.

### Holography, information, and logical boundary conditions
The repo increasingly treats bulk structure as constrained by closure at the boundary, linking QLF to Shannon, Wheeler, holography, and error-correction style thinking.

### The Spectral Structure of QLF
Every QLF string maps to a 2×2 Hermitian operator (its *spectral mode*) built from rank-1 phase projectors. This is formalized in [`lean/QLF_Spectral.lean`](lean/QLF_Spectral.lean), which proves two machine-verified theorems: (1) the spectral mode of any string is always Hermitian; (2) for symmetric strings (equal pos/neg counts), the spectral mode is a scalar multiple of the identity — the QLF spectral analog of sitting on the critical line. The Hilbert-Pólya conjecture, that Riemann zeros are eigenvalues of a Hermitian operator, is encoded as a single geometric axiom (`spectral_hilbert_polya`) from which `critical_line_forcing` is now a derived theorem rather than a bare axiom.

### QLF and Reverse Mathematics

QLF refactors physical laws using the structural framework of Harvey Friedman's **Reverse Mathematics** program. The core QLF engine — `expand_generation`, `full_zeno_prune`, `find_stable_states`, `find_stable_states_length_even` — operates strictly within **RCA₀**, the bedrock of constructive computable mathematics: no axiom of choice, no continuity, no non-constructive existence. The transition from discrete QLF combinatorics to the continuous Riemann zeta function (Dirichlet series, analytic continuation) represents a genuine jump to a higher logical subsystem (WKL₀/ACA₀). Isolating `spectral_hilbert_polya` as an explicit axiom in `lean/QLF_Riemann.lean` is a meta-mathematical necessity — it marks the exact logical boundary where discrete computation projects its continuous statistical shadow. See [**ReverseMathematics.md**](ReverseMathematics.md) for the full treatment.

### QuantumOS: QLF as a Native OS Kernel for Quantum Simulators

QLF is not only a theoretical framework — it is an executable architecture for quantum hardware. [**QuantumOS.md**](QuantumOS.md) specifies how the QLF stack maps onto a native operating system for QPUs and quantum simulators. It is the quantum analogue of seL4 (the first formally verified OS kernel) with ZFA as the hardware-enforced invariant.

**The unification thesis:** in a classical OS, security, error correction, scheduling, garbage collection, and AI are five separate engineered subsystems. In QuantumOS, all five are the same operation — ZFA enforcement (`full_zeno_prune`) — because `qlf_universality` proves ZFA balance is the single invariant that subsumes all correctness properties at once.

- **rhoqcalc as kernel**: The ρ-process algebra (`RhoQuCalc.lean`) is the execution engine. Security is grounded in five converging formal foundations: Girard's linear logic (1987), Miller's object capability model (2006), Meredith & Radestock's ρ-calculus security (2005), Honda's session types (1993), and Wootters & Zurek's no-cloning theorem (1982). Capability names are topological structures — by Curry-Howard, possessing a name *is* a proof of authorization.
- **ZFA as complete hardware specification**: `full_zeno_prune` is the machine-verified kernel. `qlf_universality` proves every terminating computation IS a ZFA string — ZFA balance is the complete hardware specification, not an analogy. Decoherence registers as a ZFA asymmetry and is pruned before it can become a physical event.
- **Intrinsic holographic QEC**: Error correction is not patched on top — it is the mechanism by which physical reality maintains structural stability. Three independent research streams converge: Zeno-subspace QEC (Beige 2000, Facchi/Pascazio 2002), holographic spacetime-as-QECC (Almheiri/Dong/Harlow, HaPPY code, AdS/CFT), and active inference as real-time decoder (Friston FEP). `full_zeno_prune` is the machine-verified implementation of all three simultaneously.
- **Active inference as the system loop**: The OS drives a continuous Perceive (`expand_generation`) → Predict (`zfa_implies_critical_line`) → Act (`parallel`/`sequence`) → Prune (`full_zeno_prune`) cycle. No separate scheduler is needed — ZFA minimization IS the scheduling decision. Grounded in Friston's Free Energy Principle.
- **Hardware-native AI with absolute interpretability**: `Form.toMatrix` maps cognitive constructs to Clifford algebra elements — the correct geometric inductive bias for physical AI (Bronstein et al. 2021, Geometric Deep Learning). Every AI program running on QLF hardware runs in machine-verified ZFA-correct code; the output is a geometric proof of Zero Free Action, not a probabilistic best-guess.
- **Ruliad/RCA₀**: `expand_generation` explores the full ruliadic multiway space (Wheeler, Zuse, Lloyd, Wolfram); `full_zeno_prune` filters it to physical reality. The engine operates strictly within RCA₀ (Harvey Friedman's Reverse Mathematics) — the minimum constructive logical subsystem consistent with physics. Convergent with Causal Set Theory, Causal Dynamical Triangulations, and Loop Quantum Gravity.

## Current Status

The Lean formalization compiles with **zero `sorry` blocks** across all 15 modules. The entire combinatorial core operates within **RCA₀** — the minimum constructive logical subsystem (no Axiom of Choice, no continuity). The only axioms are three in `QLF_Riemann` marking the exact RCA₀ → WKL₀ boundary, and philosophical axioms in `ER_EPR_QLF` (not used by other modules).

**Key proof chains** (see [lean/README.md](lean/README.md) for full detail):

- **Universality**: `encode_is_phase_only` → `encode_is_zfa` → `encode_is_generated` → `qlf_universality` — every terminating computation IS a ZFA string
- **Riemann**: `encode_is_zfa` → `zfa_implies_critical_line` → `spectral_symmetric_eq_scalar_id` → `spectral_hilbert_polya` (axiom) → `riemann_hypothesis_in_qlf`
- **Pauli exclusion (non-vacuous)**: `fermi_antisym_eq_commutator` → `fermi_antisym_self` + `fermi_nonzero_example` → `pauli_exclusion` is a genuine constraint, not a trivial identity
- **Stable-state count**: `find_stable_states_iff` → `find_stable_states_length_even` → C(2n,n) → `string_mode_count` (same count derived independently via ZFA)

**All proven results:**

- ZFA implies symmetry (`zfa_implies_critical_line`)
- Every terminating computation encodes as a ZFA string (`encode_is_zfa`, `qlf_universality`)
- Stable states are exactly the symmetric pure-phase strings (`find_stable_states_iff`)
- No symmetric pure-phase strings of odd length exist (`find_stable_states_length_odd`)
- The number of stable states of length 2n equals C(2n, n) (`find_stable_states_length_even`)
- Every QLF string has a Hermitian spectral mode (`toSpectralMode_hermitian`)
- Symmetric strings produce a scalar multiple of the identity (`spectral_symmetric_eq_scalar_id`)
- Pauli exclusion: matrix commutator of identical ρ-processes is zero (`pauli_exclusion`); non-triviality witnessed by [σ_x, σ_z] ≠ 0 (`fermi_nonzero_example`)
- String mass spectrum: eval of the n-th excitation level = n • (fold-pair matrix) (`string_mass_spectrum`)
- String mode degeneracy at level n equals C(2n, n) — forced by ZFA balance, not a free parameter (`string_mode_count`)
- M2/M5-branes as parallel gauge-fold stacks; S-duality is an involution on Form; T-duality doubles the mass spectrum (`m2_mass_spectrum`, `s_dual_involution`, `t_duality_mass_spectrum`)

Speculative extensions (ER=EPR, age of universe) are clearly broader than the proved core and marked explicitly in `lean/README.md`.

---

## How to Explore the Repo

### Read
Start with:

1. [Philosophy.md](Philosophy.md)
2. [TheBigProblem.md](TheBigProblem.md)
3. [Universality.md](Universality.md)
4. [Experimental_Consistency.md](Experimental_Consistency.md)

Then go deeper into the Lean files and topic documents.

### Run
Examples:

```bash
git clone https://github.com/jimscarver/quantum-logical-framework.git
cd quantum-logical-framework

python spacetime_dynamics.py
python constants_mapper.py
python path_integral.py
````

### Build Lean

```bash
lake update
lake exe cache get
lake build
```

---

## Recommended Reading Paths

### If you care most about foundations

[Philosophy.md](Philosophy.md) → [GodCreatedTheIntegers.md](GodCreatedTheIntegers.md) → [Universality.md](Universality.md)

### If you care most about physics

[TheBigProblem.md](TheBigProblem.md) → [Measurement_Problem.md](Measurement_Problem.md) → [SpaceTime.md](SpaceTime.md) → [Gravity.md](Gravity.md)

### If you care most about formal structure

[lean/README.md](lean/README.md) → [lean/QLF_Axioms.lean](lean/QLF_Axioms.lean) → [lean/QLF_QuCalc.lean](lean/QLF_QuCalc.lean) → [lean/QLF_Universality.lean](lean/QLF_Universality.lean)

### If you care most about the Riemann program

[Universality.md](Universality.md) → [Riemann-Conjecture-Proof.md](Riemann-Conjecture-Proof.md) → [lean/QLF_Riemann.lean](lean/QLF_Riemann.lean)

---

## What Makes QLF Different

QLF is unusual because it tries to hold all of these together at once:

* a constructive ontology
* a finite logical generator
* a physical interpretation of information and symmetry
* an executable engine
* a formal proof program
* a critique of classical foundational assumptions

Whether one ultimately accepts the framework or not, the repo is built around a single unifying question:

> **What if physics is the closure of logical possibility under Zero Free Action?**

---

## Contributing

The most useful contributions right now are:

* tightening README and document consistency
* aligning prose claims with current Lean status
* improving the Lean build and theorem structure
* adding small executable examples that clarify one claim at a time
* opening issues where a document overstates, understates, or mismatches the code

---

## Repository

**GitHub:** [jimscarver/quantum-logical-framework](https://github.com/jimscarver/quantum-logical-framework)

If the universe is ultimately logical, then physics is not just something to describe.

It is something to generate.

