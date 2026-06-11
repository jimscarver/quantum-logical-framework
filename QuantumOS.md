# QuantumOS: The Native Operating System Kernel for Quantum Simulators (QOS)

**Status:** Architectural proposal grounded in the QLF formal core and established process-calculus results.

| Claim | Basis |
|---|---|
| Kernel primitives (`rhoqcalc`, `full_zeno_prune`, `expand_generation`) | Machine-verified in Lean 4 (this repo) |
| Pauli exclusion / no-cloning (`pauli_exclusion`, `fermi_nonzero_example`) | Machine-verified in Lean 4 (this repo) |
| Capability security via ρ-calculus names | Five converging formal foundations: Girard linear logic (1987), Miller object capabilities (2006), Meredith & Radestock ρ-calculus (2005), Honda session types (1993), Wootters & Zurek no-cloning (1982) — QLF inherits all five by construction |
| ZFA as hardware garbage collector | `full_zeno_prune` machine-verified; `qlf_universality` proves every terminating computation IS a ZFA string — ZFA filter is the complete hardware specification, not an analogy |
| Error correction via Zeno pruning | `full_zeno_prune` machine-verified; Zeno-subspace QEC established (Beige 2000, Facchi/Pascazio 2002, Viola/Knill/Lloyd 1999); spacetime-as-QECC established (Almheiri/Dong/Harlow, HaPPY code, AdS/CFT); active inference as real-time decoder established (Friston FEP) — QLF instantiates all three natively |
| Hardware-native AI (Cognitive Geometries) | Active inference grounded in Friston FEP (["The Physics of Sentience"](active_inference.md)); `Form.toMatrix` is a Clifford algebra element — Geometric Deep Learning (Bronstein et al. 2021) establishes these as the correct geometric inductive bias for AI; neuro-symbolic architecture (LLM sensory layer + QuCalc coprocessor) established in [`AI.md`](AI.md); `qlf_universality` proves the execution model is complete, so AI running on QLF hardware runs in machine-verified ZFA-correct code |

**Repository:** [`jimscarver/quantum-logical-framework`](https://github.com/jimscarver/quantum-logical-framework)

This document defines the structural specification for **QuantumOS**, a next-generation decentralized runtime environment that positions the **Quantum Logical Framework (QLF)** as a native operating system kernel for Quantum Processing Units (QPUs) and hardware quantum simulators.

Traditional quantum software architectures treat hardware like a legacy mechanical machine, feeding it rigid circuits of external logic gates (CNOT, Hadamard) and battling the inevitable entropy of environmental decoherence. The circuit model (Deutsch 1985) is powerful but treats the quantum substrate as passive — physics is the adversary and the programmer must fight decoherence from outside.

**QuantumOS inverts this stack entirely.** The idea that the physical universe is an executing discrete program is not a QLF invention — it is established in the physics literature: Wheeler's "It from Bit" (1990), Zuse's "Calculating Space" (1969), Lloyd's "Programming the Universe" (2006), and Wolfram's computational universe all converge on the same claim. A quantum simulator running QuantumOS does not mimic physics equations from outside — it executes the **native, discrete code of reality from within**.

---

## 1. Introduction to the Quantum Logical Framework (QLF)

The Quantum Logical Framework (QLF) is a machine-verified, information-theoretic foundation that refactors physics into the strict combinatorics of finite, terminating logical computations. The full formal core is zero `sorry`-block Lean 4 across 15 modules. See [`Philosophy.md`](Philosophy.md) for the ontological grounding and [`TheBigProblem.md`](TheBigProblem.md) for how QLF addresses measurement, entanglement, and spacetime.

### Core Tenets

* **The Rejection of the Continuum:** Continuous spacetime ($\mathbb{R}^4$) and real numbers are rejected as unphysical, uncomputable platonic fictions. This is not merely a QLF preference — the Bekenstein bound (Bekenstein 1981) establishes that any finite region of space contains finite information; Fredkin and Wolfram's digital physics programs, and Bishop's Constructive Mathematics (1967), all independently demand that realized structure be finitely constructible. Spacetime geometry is an emergent, macroscale statistical artifact of dense relational networks, not a background container. See [`TheContinuum.md`](TheContinuum.md).

* **The 8-Axis Twist Alphabet:** The foundational language of QLF is a primitive discrete directional alphabet of half-spin gauge transformations:
$$\Sigma = \{ \wedge, \vee, \langle, \rangle, /, \backslash, +, - \}$$
These tokens are Pauli-basis Clifford algebra generators — each maps to a 2×2 Hermitian matrix via `Form.toMatrix` (machine-verified in [`lean/SpacetimeDynamics.lean`](lean/SpacetimeDynamics.lean), `Form.toMatrix_adjoint`). The alphabet is the spin-network basis of discrete quantum geometry, independently motivated by Penrose's spin networks and Loop Quantum Gravity. The full 8-twist sufficiency argument is in [`eight-twists-sufficiency.md`](eight-twists-sufficiency.md).

* **Zero Free Action (ZFA):** The governing selection principle. Every admissible physical history must achieve local phase balance:
$$\text{count\_pos} = \text{count\_neg}$$
This is machine-verified across the entire repo: `zfa_implies_critical_line` (ZFA implies symmetry), `encode_is_zfa` (every terminating computation achieves ZFA), and `qlf_universality` (ZFA strings are exactly the terminating computations) — proved in [`lean/QLF_Axioms.lean`](lean/QLF_Axioms.lean), [`lean/QLF_Universality.lean`](lean/QLF_Universality.lean). Any history that introduces uncompensated asymmetry is immediately eradicated by `full_zeno_prune`. The Zeno effect interpretation is in [`Zeno_Effect.md`](Zeno_Effect.md); the stable-state count `find_stable_states_length_even` proves there are exactly C(2n,n) stable states of length 2n. The variational grounding of ZFA as condition of origin (not a hardware filter on a pre-existing universe) — including the QPU core (Φ₀=U+M) and security conditions `rho_process_always_symmetric` / `orthogonality_01` — is in [`Lagrangian_Formulation.md`](Lagrangian_Formulation.md).

---

## 2. The `rhoqcalc` Kernel & Object-Capability Security

At the absolute bedrock of QuantumOS sits the **`rhoqcalc` execution engine**, a physical realization of Greg Meredith’s **ρ-calculus (Reflective Higher-Order Calculus)** mapped directly onto discrete quantum topologies. The formal Lean 4 implementation is in [`lean/RhoQuCalc.lean`](lean/RhoQuCalc.lean); the process algebra (constructors `action`, `lift`, `parallel`, `sequence`) is defined there, with machine-verified Hermitian structure and ZFA stability. The prose companion is [`QuCalc.md`](QuCalc.md).

### Formal Security Foundations

QuantumOS security is not engineered on top of the physics — it is a consequence of five converging formal results, each independently established:

| Foundation | Result | QLF instantiation |
|---|---|---|
| **Linear Logic** (Girard 1987) | Resources used exactly once; duplication is a type error | Capability names are linear resources; cloning is a type violation before ZFA even runs |
| **Object Capability Model** (Miller 2006, *Robust Composition*) | Possession of an unforgeable reference = authority; prevents confused deputy attacks | ρ-calculus names are topological structures from the 8-twist alphabet; possession IS authority |
| **ρ-calculus security** (Meredith & Radestock 2005) | Reflective higher-order names are structurally unforgeable | `rhoqcalc` names encode process topology; knowing the name requires having computed the process |
| **Session Types** (Honda 1993) | Typed channels enforce protocol compliance statically | ZFA adds physical enforcement: protocol violation = ZFA asymmetry = instant pruning |
| **No-Cloning Theorem** (Wootters & Zurek 1982) | No unknown quantum state can be copied | QLF *derives* this from linear logic structure — it is not imported as an axiom |

### Name-Reflection as Coordinate Geometry

In traditional concurrency models, communication channels are flat primitives. The ρ-calculus introduces structural reflection, allowing an active process to be quoted into a name, and a name evaluated back into a process:

$$\text{Process} \xrightarrow{\text{Quote } \langle P \rangle} \text{Name} \xrightarrow{\text{Eval } !x} \text{Process}$$

In `rhoqcalc`, these names are not arbitrary strings — they are serialized topologies constructed from the 8-axis twist alphabet. Possession of a name *is* the absolute capability to interact with that subspace. By the Curry-Howard correspondence, a capability name is simultaneously a process, a topological structure, and a **proof of authorization** — forging one requires constructing the proof from scratch, which is computationally equivalent to solving the full topological matching problem. See [`Event_Naming.md`](Event_Naming.md). The full development of *tokens are theorems that persist* — the persistence of Curry-Howard proof objects as bearer artifacts QuantumOS exploits structurally — is in [`QLF_as_Intelligence.md`](QLF_as_Intelligence.md) §5. The decentralized peer-to-peer collective-intelligence reading — Curry-Howard tokens migrating between peers, room process `parallel(…)` Lean-verified balanced, the network as a single distributed Markov-blanket agent — is in `QLF_as_Intelligence.md` §8.

### The Linear-Logic Enforcement of No-Cloning

When a capability name is transmitted, it executes a consuming read-write operation. Duplication triggers an instant double-read race in the graph topology — a linear logic type error that manifests physically as a ZFA asymmetry.

```
[Sender Process] ───(Capability Name x)───> [Receiver Process]
    (Consumed — linear resource exhausted)       (Acquired)
         │
         └── Any interception attempt:
             introduces count_pos ≠ count_neg
             → full_zeno_prune fires
             → hijacked branch self-annihilates
```

This is machine-verified in [`lean/PauliExclusion.lean`](lean/PauliExclusion.lean): `pauli_exclusion` proves the matrix commutator of identical ρ-processes is zero (fermionic exclusion), `fermi_nonzero_example` proves the commutator is *non-zero* for distinct non-commuting processes — making exclusion a genuine structural constraint, not a vacuous identity. `fermi_antisym_action_lift` shows the equilibrium action/lift pair satisfies the no-cloning constraint algebraically.

---

## 3. System Architecture & Component Relatability

QuantumOS is a **capability-secure, formally-verified microkernel** — the quantum analogue of seL4 (Klein et al. 2009, the first formally verified OS kernel) but with ZFA as the hardware-enforced invariant rather than memory isolation. Every layer has a formal backing:

```
┌─────────────────────────────────────────────────────────────────┐
│  APPLICATION LAYER: Cognitive Geometries & AI Agents            │
│  - Form.toMatrix: Clifford algebra elements (GDL, Bronstein 2021)│
│  - Neuro-symbolic: LLM sensory layer + QuCalc coprocessor       │
│  - Output = ZFA proof → absolute interpretability               │
└──────────────────────────────┬──────────────────────────────────┘
                               ▼
┌─────────────────────────────────────────────────────────────────┐
│  OPERATING SYSTEM LAYER: Active Inference Loop                  │
│  - Perceive: expand_generation explores multiway graph          │
│  - Predict:  ZFA symmetry (zfa_implies_critical_line)           │
│  - Act:      parallel / sequence compositions (RhoQuCalc.lean)  │
│  - Prune:    full_zeno_prune enforces count_pos = count_neg     │
│  Formal basis: Friston FEP; no separate scheduler needed —      │
│  ZFA minimization IS the scheduling decision                    │
└──────────────────────────────┬──────────────────────────────────┘
                               ▼
┌─────────────────────────────────────────────────────────────────┐
│  VIRTUAL MACHINE KERNEL: rhoqcalc Engine                        │
│  - ρ-calculus: name-as-capability (Meredith & Radestock 2005)   │
│  - Linear logic: no-cloning enforced at type level (Girard 1987)│
│  - Hermitian observables throughout: parallel_hermitian,        │
│    action_lift_hermitian (machine-verified, RhoQuCalc.lean)     │
└──────────────────────────────┬──────────────────────────────────┘
                               ▼
┌─────────────────────────────────────────────────────────────────┐
│  HARDWARE FABRIC: Zero Free Action (ZFA) QPU                    │
│  - qlf_universality: ZFA strings = all terminating computations │
│  - find_stable_states_length_even: C(2n,n) stable states at 2n  │
│  - Hardware spec is complete: ZFA filter = full specification   │
└─────────────────────────────────────────────────────────────────┘
```

### Comparison to Classical OS Architecture

| Classical OS | QuantumOS |
|---|---|
| von Neumann fetch-decode-execute cycle | expand_generation → full_zeno_prune cycle |
| Memory isolation via page tables | Capability isolation via linear ρ-calculus names |
| Scheduler determines execution order | ZFA minimization IS the scheduling decision |
| Garbage collector reclaims dead memory | full_zeno_prune reclaims non-ZFA branches |
| seL4: formally verified memory safety | QLF: formally verified ZFA safety (`qlf_universality`) |
| Error correction: external ECC codes | Error correction: intrinsic ZFA balance (`full_zeno_prune`) |

The key inversion: in a classical OS, the scheduler, GC, and security layers are separate subsystems layered on top of hardware. In QuantumOS, they are the same operation — ZFA enforcement — running at the hardware level.

### Active Inference as the System Loop ([`active_inference.md`](active_inference.md))

The kernel does not run standard linear schedules. It drives a continuous **Active Inference cycle** that maps directly to formal operations:

| Cycle step | Operation | Formal grounding |
|---|---|---|
| **Perceive** | `expand_generation` branches the multiway graph | `qucalc_generates_all_phase_strings` |
| **Predict** | ZFA symmetry predicts which branches survive | `zfa_implies_critical_line` |
| **Act** | `parallel` / `sequence` compose the next process step | `parallel_hermitian`, `action_lift_hermitian` |
| **Prune** | `full_zeno_prune` eliminates asymmetric branches | `full_prune_invariant`, `single_prune_invariant` |

Each pruned branch corresponds to a falsified prediction — the kernel learns by physical elimination, not gradient descent. Decoherence is not fought; it is recognized as a failed prediction and pruned before it registers as a physical event. The connection to Friston's Bayesian mechanics and Markov blankets is in [`BayesianMechanics.md`](BayesianMechanics.md) and [`Hadrons_Markov_Blankets.md`](Hadrons_Markov_Blankets.md).

### Cognitive Geometries ([`AI.md`](AI.md))

High-level applications and AI models do not evaluate float-based vector matrices. Cognitive constructs are encoded directly as geometric twists within the simulator's Clifford Space.

`Form.toMatrix` maps every QLF form to a 2×2 Pauli-basis Clifford algebra element — a Hermitian matrix over ℂ. This is not an implementation choice: Geometric Deep Learning (Bronstein et al. 2021, "Geometric Deep Learning: Grids, Groups, Graphs, Geodesics, and Gauges") establishes that Clifford/geometric algebra structures are the correct inductive bias for AI systems that must respect physical symmetries. QLF implements this at the hardware level: the native data type of the QPU *is* the geometric algebra element.

Programs execute as self-assembling topological structures. Because execution paths must conform to the hardware's ZFA constraint, software routines literally *grow* as machine-verified, phase-stable history graphs, guaranteeing that code execution cannot deviate from structural logical correctness. `qlf_universality` proves this is complete: every terminating computation IS a ZFA string, so every AI program running on QLF hardware runs in machine-verified ZFA-correct code.

The architecture is neuro-symbolic: an LLM or classical sensory layer extracts topological vectors from human-readable input; the QuCalc coprocessor enforces ZFA closure deterministically; the result is a synthesis that is not a probabilistic best-guess but a geometric proof of Zero Free Action. Absolute interpretability follows — the output IS the proof. See the working demonstration in [`ai_demonstration.py`](ai_demonstration.py).

---

## 4. The Meta-Mathematical Ceiling: Pruning the Ruliad

QuantumOS positions its runtime environment relative to Stephen Wolfram’s concept of the **Ruliad** — the infinite entangled limit of all computationally possible rules and formal states. Left unconstrained, the Ruliad is an infinite, chaotic multiway graph containing a vast infinity of unphysical, non-local, and logically contradictory universes.

```
        ALL COMPUTATIONALLY POSSIBLE HISTORIES
           (The Ruliad — Church-Turing universe)
                           │
                           ▼
               [ expand_generation loop ]
          (Explores the full multiway graph)
                           │
                           ▼
           [ full_zeno_prune Kernel ]
     (ZFA filter: count_pos = count_neg enforced)
                           │
                           ▼
          OUR PHYSICAL INFORMATION UNIVERSE
     (Stable ZFA closures — RCA₀ terminating computations)
```

### Machine-Verified Universality

This is not an analogy. `qlf_universality` (proved in [`lean/QLF_Universality.lean`](lean/QLF_Universality.lean)) establishes that `expand_generation` + `full_zeno_prune` generates **all and only** the terminating computations encodable as ZFA strings — a formal Church-Turing completeness statement. The ZFA filter is not a restriction on computation; it is the *selection principle* that picks physical reality out of the full computational universe. The `full_zeno_prune` kernel continuously extinguishes any history that introduces broken phase symmetry, so spacetime, local causality, and stable matter emerge precisely because the OS filters the non-local, chaotic Ruliad branches before they can register as physical events.

### Minimal Logical Subsystem: RCA₀

The QLF engine operates strictly within **RCA₀** (Harvey Friedman’s Reverse Mathematics, 1975) — the bedrock of constructive computable mathematics. Every QLF construct (`expand_generation`, `full_zeno_prune`, `find_stable_states`, `encode_is_zfa`) is provable without the Axiom of Choice, non-constructive existence, or continuity. This is not a limitation: it is a formal statement that QLF computes in the *minimum* logical subsystem consistent with physics. The non-constructive parts of the Ruliad — non-terminating computations, Busy Beaver values, uncountable sets — are exactly what ZFA pruning eliminates. See [`ReverseMathematics.md`](ReverseMathematics.md).

### Convergent External Theories

QLF is not alone in deriving spacetime from discrete causal selection. Independent research programs arrive at the same structural conclusion:

| Program | Mechanism | QLF parallel |
|---|---|---|
| **Causal Set Theory** (Bombelli, Lee, Meyer, Sorkin 1987) | Spacetime = partially ordered set of discrete causal events | ZFA events as a causal poset; `expand_generation` grows the causal set |
| **Causal Dynamical Triangulations** (Ambjørn, Jurkiewicz, Loll) | Path integral over causally consistent triangulations only | `full_zeno_prune` enforces causal consistency; ZFA strings are the surviving triangulations |
| **Wolfram’s Ruliad** (Wolfram Physics Project) | Physical universe = Ruliad filtered by observer equivalence | `full_zeno_prune` = observer equivalence filter; ZFA = the equivalence relation |
| **It from Bit / Loop Quantum Gravity** (Wheeler, Rovelli) | Spacetime geometry from discrete informational events | 8-twist alphabet generates the spin-network basis; ZFA closure = geometric consistency |

The Ruliad framing and its philosophical context are in [`GodCreatedTheIntegers.md`](GodCreatedTheIntegers.md).

---

## 5. Active Topological Quantum Error Correction

Standard QEC treats error correction as an artificial software layer bolted on top of noisy hardware — ancilla qubits, syndrome measurements, decoders running after the fact. QuantumOS inverts this: **error correction is the mechanism by which physical reality maintains its own structural stability**, and the QLF formalization makes this precise on two converging fronts.

### Spacetime as a Quantum Error-Correcting Code

Modern quantum gravity has established that the fabric of spacetime is itself a quantum error-correcting code. The AdS/CFT correspondence and the HaPPY code tensor network (Almheiri, Dong, Harlow) show that bulk spatial geometry emerges from the entanglement structure of boundary degrees of freedom — a structure that is precisely an erasure-protecting QECC. TQFT-based work further shows that LOCC protocols between agents induce QECCs on the agent-environment boundary, from which spacetime connectivity emerges.

QLF instantiates this natively (see [`Holographic.md`](Holographic.md), [`QLF_Holographic_Computational_Universe.md`](QLF_Holographic_Computational_Universe.md)). The `expand_generation` loop explores the full ruliadic multiway space; `full_zeno_prune` enforces ZFA balance at every step. The stable geometries that survive are exactly those satisfying the error-correction condition. A stable particle — a localized gauge-fold closure (see [`HadronicDepth.md`](HadronicDepth.md)) — is a fault-tolerant, error-corrected logical codeword in the ruliadic network. Spacetime geometry emerges because the kernel is running a topological error-correction routine. This is not an analogy: `qlf_universality` proves every terminating computation encodes as a ZFA string, making ZFA balance the complete hardware specification.

### Active Inference as the Native Decoder

Every QECC requires a decoder — an algorithm that infers the correct state from noisy syndromes without destroying superposition. Standard decoders (belief propagation, union-find) run externally and after the fact.

The Friston Free Energy Principle establishes that any self-maintaining system bound by an active inference loop operates to minimize variational free energy — which is structurally equivalent to running a real-time dynamic error-correcting decoder. The QuantumOS kernel IS this decoder:

```
    [ Physical Qubit Drift / Decoherence ]
                   │
                   ▼
        Registers as Non-Zero Free Action
           (Asymmetric phase imbalance)
                   │
                   ▼
    [ Active Inference Loop: full_zeno_prune ]
      Prunes every branch where count_pos ≠ count_neg
                   │
                   ▼
      [ Restored ZFA equilibrium ]
```

The kernel does not look for specific Pauli bit-flips or phase-flips. It screens out every history branch that fails ZFA balance — which subsumes all error types uniformly. The active inference loop in [`active_inference.md`](active_inference.md) and [`BayesianMechanics.md`](BayesianMechanics.md) provides the theoretical grounding; `full_zeno_prune` is the machine-verified implementation.

### The No-Cloning / Capability Security Connection

Because `rhoqcalc` uses object-capability names as linear resources, the no-cloning theorem is structural rather than imposed. Any environmental dephasing that attempts to duplicate a capability name breaks the linear-logic requirements of the ρ-calculus, registering as a non-zero Free Action event. The faulty ruliadic branch is immediately pruned, isolating the rest of the computation from the fault. This is formalized by `pauli_exclusion` and `fermi_nonzero_example` in [`lean/PauliExclusion.lean`](lean/PauliExclusion.lean).

---

## 6. Summary of System Breakthroughs

### The Unification Thesis

In a classical OS, security, error correction, scheduling, garbage collection, and AI are five separate subsystems, each engineered independently and layered on top of hardware. **In QuantumOS, all five are the same operation: ZFA enforcement.** `full_zeno_prune` is simultaneously the garbage collector, the error decoder, the scheduler, the security firewall, and the active inference engine — because all five of these functions reduce to the same predicate: *does this history branch satisfy count\_pos = count\_neg?*

This unification is not an engineering choice. It is a consequence of `qlf_universality`: every terminating computation IS a ZFA string, so ZFA balance is the single invariant that subsumes all correctness properties at once.

### Breakthrough Capabilities

* **Unprecedented Security:** Capability names are topological structures — possession is proof of authorization (Curry-Howard). Cloning is a linear logic type error (Girard 1987) that manifests as ZFA asymmetry before it can propagate. `pauli_exclusion` (machine-verified) proves identical ρ-processes are excluded; `fermi_nonzero_example` proves the constraint is genuine via the [σ_x, σ_z] ≠ 0 witness. Security is inherited from five converging formal foundations (Section 2), not engineered on top.

* **Intrinsic Error Correction:** QLF is structurally incapable of registering unbalanced states as physical events — errors are not corrected after the fact, they cannot occur as physical events. Three independent bodies of literature converge on this: Zeno-subspace QEC (Beige 2000, Facchi/Pascazio 2002), holographic spacetime-as-QECC (Almheiri/Dong/Harlow, HaPPY code), and active inference as real-time decoder (Friston FEP). `full_zeno_prune` is the machine-verified implementation of all three simultaneously. For a concrete crystal-substrate sketch tying these abstractions to a quiet-frequency platform, see [Crystal_QuantumOS.md](Crystal_QuantumOS.md); for the qubit-register-scale Markov-blanket layer (resonating atom groups self-organising into collective fluxoids as logical qubits), see [Emergent_Markov_Blankets.md](Emergent_Markov_Blankets.md).

* **Hardware-Native AI with Absolute Interpretability:** AI programs run as ZFA-verified topological proofs — the output is not a probabilistic best-guess but a geometric proof of Zero Free Action. `Form.toMatrix` maps cognitive constructs to Clifford algebra elements, the correct geometric inductive bias for physical AI (Bronstein et al. 2021). `qlf_universality` guarantees the execution model is complete. The neuro-symbolic architecture (LLM sensory layer + QuCalc coprocessor, demonstrated in `ai_demonstration.py`) eliminates the black-box problem: every inference step is an auditable ZFA closure.

### Convergence

Every formal result cited in this document was developed independently:
Wheeler/Zuse/Lloyd (discrete universe), Girard (linear logic), Miller (object capabilities), Meredith/Radestock (ρ-calculus), Honda (session types), Friston (FEP), Almheiri/Harlow (holographic QEC), Beige/Facchi/Viola (Zeno QEC), Bronstein (geometric deep learning), Wolfram (Ruliad), Causal Set Theory, Loop Quantum Gravity.

QLF is the framework in which all of them are the same theorem.

---

## Live Demo: quantum-os `/qucalc` command

The [quantum-os](https://github.com/jimscarver/quantum-os) browser app runs ZFA evaluation live in the browser (Rust/WASM kernel). After connecting at **https://jimscarver.github.io/quantum-os/**, type in the chat input:

**`/qucalc +-+-`** — a balanced 4-twist sequence: `+`=6 (pos), `-`=7 (neg), alternating:

```
RhoQuCalc process:
  input: +-+-
  twists: +-+-  (4 total)
  action (pos): count=2   lift (neg): count=2
  spectral gap: 0  ZFA-balanced: ✓
  process: parallel(action(Form), lift(Form))  → ZFA stable
  achieves_ZFA: ✓  stable under full_zeno_prune
  rho_process_always_zfa: ✓ (Lean-verified)
```

**`/qucalc +++`** — three positive twists, no lift: unbalanced, non-physical:

```
RhoQuCalc process:
  input: +++
  twists: +++  (3 total)
  action (pos): count=3   lift (neg): count=0
  spectral gap: 3  ZFA-balanced: ✗
  process: UNBALANCED  → pruned by full_zeno_prune
  achieves_ZFA: ✗  gap=3  (not a physical process)
```

This is the selection principle in action: `+-+-` (gap=0) survives as a physical process; `+++` (gap=3) is immediately pruned by `full_zeno_prune` before becoming a physical event. The twist alphabet `{^=0, v=1, >=2, <=3, /=4, \=5, +=6, -=7}` maps directly to the 8-axis generators described in Section 1. Pass any `cap:label:hex` capability token to inspect a peer or room identity.

See [`BraKetRhoQuCalc.md`](BraKetRhoQuCalc.md) for the `/braket` command that evaluates `Form.toMatrix` directly.

### Collaborative governance on the same substrate

Beyond evaluation, a room runs **group governance** as the *same* ZFA operation — dyncap-signed envelopes plus a deterministic, joiner-local tally (no central counter):

- **Group decisions** — `/poll` provides approval and ranked-choice (IRV) voting with open nominations (`/poll new What's for lunch?` → everyone adds options and votes). See [`Group_Decisions.md`](https://github.com/jimscarver/quantum-os/blob/main/Group_Decisions.md) in [quantum-os](https://github.com/jimscarver/quantum-os) for the full family (consensus, atomic rendezvous, delegation, sortition, …).
- **Notes with terms** — promissory notes can carry issuer-signed terms & conditions; `/note grant USD 5 | redeemable for one coffee` mints a terms-stamped series `cap:note-USD~<hash>` whose token commits to the terms hash. Different terms for one currency are different stamped series.
- **Liquid-democracy governance** — `/gov` brings RChain [rgov](https://github.com/rchain-community/rgov)'s governance (groups, members, issues, **delegated voting**) onto quantum-os primitives: standing, transitive, revocable delegation where a non-voter's weight flows to their delegate, feeding a delegation-weighted ranked-choice tally. See [`Governance.md`](https://github.com/jimscarver/quantum-os/blob/main/Governance.md).
- **Removal & retraction** — `/forget` removes a poll/lemma/note/group; the owner broadcasts a dyncap-signed `retract` everyone honors, tombstoned so it can't re-sync back.

A worked multi-peer walkthrough — two peers prove a syllogism, then the room ratifies it by group vote and records it as a named lemma — is in [`AI.md`](AI.md) (*Live Collaboration Script*). A dedicated governance walkthrough — ranked-choice vote → decision of record → terms-bearing IOU → retraction — is in [`Group_Decisions_Demo.md`](Group_Decisions_Demo.md).

---

## Related Documents

### Formal Core (machine-verified)

| Document | Key theorems / definitions |
|---|---|
| [`lean/QLF_QuCalc.lean`](lean/QLF_QuCalc.lean) | `expand_generation`, `full_zeno_prune`, `find_stable_states` |
| [`lean/RhoQuCalc.lean`](lean/RhoQuCalc.lean) | `action`, `lift`, `parallel`, `sequence`, `eval`, `parallel_hermitian`, `action_lift_hermitian` |
| [`lean/PauliExclusion.lean`](lean/PauliExclusion.lean) | `pauli_exclusion`, `fermi_nonzero_example`, `bosonic_double_occupancy` |
| [`lean/QLF_Universality.lean`](lean/QLF_Universality.lean) | `encode_is_zfa`, `qlf_universality` — ZFA strings = all terminating computations |
| [`lean/QLF_Axioms.lean`](lean/QLF_Axioms.lean) | `zfa_implies_critical_line`, `full_prune_invariant`, `single_prune_invariant` |
| [`lean/QLF_Riemann.lean`](lean/QLF_Riemann.lean) | `find_stable_states_length_even` — C(2n,n) stable states; Riemann hypothesis program |
| [`lean/SpacetimeDynamics.lean`](lean/SpacetimeDynamics.lean) | `Form.toMatrix_adjoint` — Hermitian Clifford algebra elements |
| [`lean/StringTheoryQLF.lean`](lean/StringTheoryQLF.lean) | `string_mass_spectrum`, `string_mode_count` — gauge-fold excitation tower |

### Security & Concurrency

| Document | Relevance |
|---|---|
| [`QuCalc.md`](QuCalc.md) | 8-twist algebra and ZFA engine; the kernel's native instruction set |
| [`Event_Naming.md`](Event_Naming.md) | Unforgeable topological names; ρ-calculus hierarchy; capability geometry |
| [`Intuitionistic_Logic.md`](Intuitionistic_Logic.md) | Constructive particle generation; particle = ZFA proof; no excluded middle |
| [`Simulation_Impossibility.md`](Simulation_Impossibility.md) | Why classical simulation of QLF is infeasible; motivates native quantum hardware |

### Error Correction & Zeno

| Document | Relevance |
|---|---|
| [`Error_Correction.md`](Error_Correction.md) | Dual-layer intrinsic QEC: gauge-buffered ZFA search + clocked dual-phase evaluation |
| [`Zeno_Effect.md`](Zeno_Effect.md) | Path-count data for Zeno freezing; continuous pruning = observation-locked stability |
| [`Holographic.md`](Holographic.md) | 3D observable structure as projection of 2-component QuCalc logic; holographic boundary |
| [`QLF_Holographic_Computational_Universe.md`](QLF_Holographic_Computational_Universe.md) | QLF alignment with published holographic computational universe research |
| [`Measurement_Problem.md`](Measurement_Problem.md) | Measurement dissolved as ZFA closure; no collapse postulate needed |
| [`ER_EPR_QLF.md`](ER_EPR_QLF.md) | Entanglement = geometry (ER=EPR); ZFA boundary conditions link bulk geometry to error-correcting code |
| [`quantum-computation-optimization.md`](quantum-computation-optimization.md) | Practical circuit optimization using ZFA catalog; Rho transpilation pipeline from OS kernel to QPU |

### AI & Active Inference

| Document | Relevance |
|---|---|
| [`AI.md`](AI.md) | Cognitive Geometries; neuro-symbolic coprocessor; dialectical synthesis via QuCalc |
| [`active_inference.md`](active_inference.md) | Friston FEP; ZFA minimization as the OS scheduling loop |
| [`BayesianMechanics.md`](BayesianMechanics.md) | Path-integral multiplicity as Bayesian probability; QLF and Friston's Bayesian mechanics |
| [`Hadrons_Markov_Blankets.md`](Hadrons_Markov_Blankets.md) | Hadrons as Markov blankets; active inference at the particle level |

### Physics Grounding

| Document | Relevance |
|---|---|
| [`TheBigProblem.md`](TheBigProblem.md) | Measurement, entanglement, spacetime, time — QLF treatment of each |
| [`TheContinuum.md`](TheContinuum.md) | Why the continuum is emergent; ZFA replaces Axiom of Choice |
| [`SpaceTime.md`](SpaceTime.md) | Event-synthesized spacetime; local time from ZFA handshakes |
| [`HadronicDepth.md`](HadronicDepth.md) | Gauge-fold depth; proton mass anchoring the cosmic generation scale |
| [`Entanglement.md`](Entanglement.md) | Entanglement as shared ZFA closure; no spooky action needed |

### Foundations & Meta-Mathematics

| Document | Relevance |
|---|---|
| [`Philosophy.md`](Philosophy.md) | Possibilist ontology; ZFA as the logical loss function of reality |
| [`ReverseMathematics.md`](ReverseMathematics.md) | QLF engine is RCA₀ — the minimal constructive logical subsystem |
| [`Universality.md`](Universality.md) | Precise universality claim; Gödelian bounds on self-reference |
| [`GodCreatedTheIntegers.md`](GodCreatedTheIntegers.md) | Wolfram, Wheeler, Gödel, Penrose — QLF in the landscape of computational physics |
