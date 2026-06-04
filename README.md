# Quantum Logical Framework (QLF)

**The universe is logical.**  
**Spacetime is synthesized.**  
**Physical reality is the subset of possibility that achieves Zero Free Action.**

The **Quantum Logical Framework (QLF)** is a constructive research program that treats physics as a problem of **logical generation and closure** rather than one of brute-force formalism or fixed background geometry. Its core claims are **machine-verified in Lean 4** across 16 modules with zero `sorry` blocks — the combinatorial heart operates strictly within RCA₀, the minimum constructive logical subsystem, with no Axiom of Choice and no continuity assumptions.

At its core is a simple claim, now formally proved:

> **Only histories that achieve Zero Free Action (ZFA) persist.  
> Every terminating computation IS a ZFA string — and ZFA-balanced strings are exactly physical reality.**

From that starting point, QLF derives spacetime, measurement, entanglement, symmetry, gravity, Pauli exclusion, and the Riemann zeta function's critical line — all from finite local logical distinction.

The deepest result is `qlf_universality`: the ZFA filter is not a restriction on what can be computed. It is Church-Turing complete. The filter is a selection principle — it picks physical reality out of the full ruliadic computational universe (Wheeler 1990, Wolfram 2020). The variational physics expression of this principle is S = ∫ℒ dΩ with ℒ = 0 — a null Lagrangian that is the condition of origin, not a cutting rule. See [**Lagrangian_Formulation.md**](Lagrangian_Formulation.md) for the full treatment with machine-verified Lean theorem anchors.

---

## What QLF Is

QLF is not just an interpretation of quantum mechanics. It is a broader attempt to build a unified framework in which:

- **logical distinction is fundamental** — following Wheeler's "it from bit" (1990) and Zuse's digital physics (1969): the universe is computation, not a manifold
- **spacetime is synthesized event by event** — following Causal Set Theory (Bombelli, Lee, Meyer, Sorkin 1987) and Regge calculus: no background geometry is assumed
- **symmetry is enforced by Zero Free Action** — the ZFA filter (`full_zeno_prune`) is the machine-verified selection principle, proved in RCA₀ with no non-constructive existence
- **measurement is closure, not mystery** — closure under ZFA is the physical event; no separate collapse postulate is needed (compare Zurek decoherence 2003, Everett 1957)
- **gravity is emergent, not primitive** — following Jacobson (1995), Verlinde (2011), Padmanabhan: gravity is a thermodynamic consequence of information geometry, derived rather than postulated
- **formal infinities are replaced by constructive finite generation** — following Kronecker, Brouwer intuitionism, and Harvey Friedman's Reverse Mathematics: RCA₀ is the logical floor; everything else is stratified above it

The repository combines:

- **conceptual essays** grounding QLF in the external literature
- **Python experiments and demonstrations** that numerically confirm the Lean theorems
- **Lean 4 machine-verified formalization** of all key structural claims — zero `sorry` blocks
- **physical theory extensions** (strings, M-theory, holographic QEC, QuantumOS) built on the proved core

---

## Why This Repo Exists

Standard physics is extraordinarily successful, but its foundations remain unsettled:

| Problem | QLF's specific response |
|---|---|
| The measurement problem | ZFA closure IS the measurement event — no separate collapse, no observer-dependence beyond what the logical structure demands |
| The role of the observer | `qlf_universality` grounds the observer: every terminating computation (including observation) is a ZFA string |
| The status of spacetime | Synthesized from ZFA events (`ZFAEventDynamics.lean`) — spacetime is the output, not the input |
| Quantum gravity | Emergent from ZFA event rate and gauge-fold depth — no separate quantization procedure needed |
| Information and physics | ZFA is a Bekenstein-style information bound, machine-verified to be the selection principle for physical reality |
| The limits of classical formalism | The QLF core operates in RCA₀ — below ZFC, below Choice, below the Busy Beaver horizon — so the limits of classical formalism are provably outside the physical universe |

QLF approaches these problems from the bottom up. Instead of starting with continuum fields, collapse postulates, or open-ended formal infinities, it starts with **finite logical possibilities** and asks which histories can actually close.

That makes QLF both a physical proposal and a foundational proposal about mathematics, computation, and explanation — and uniquely, one with machine-verified formal proofs at its core.

---

## Start Here

### 0. Foundations — what kind of mathematics is this?

QLF is the mathematics that has **active inference built into its foundation**. Mathematical objects are admissible trajectories of a free-energy-minimizing agent (a Markov blanket); the single rule is per-event ΔF = −log 2 saturation by half-spin ZFA closure. Not classical mathematics (ZFC), not standard constructive mathematics (no agent), a third thing.

- [**Active_Inference_Mathematics.md**](Active_Inference_Mathematics.md) — meta-doc framing the QLF program as active-inference mathematics: primitives, single rule, classical/constructive/active-inference comparison table, honest derived/partial/open scoreboard. Names the system as a candidate TOE and ZFC-replacement for the part of mathematics that is not mathematical fantasy (with the Gödel + Busy Beaver scope marker)
- [**Hierarchical_Control.md**](Hierarchical_Control.md) — the bottom-up/top-down architecture; §3 derives Friston's free energy principle from ZFA
- [**MRE.md**](MRE.md) — the per-event log 2 quantum that is the math's selection principle

### 1. Big-picture orientation
- [**Philosophy.md**](Philosophy.md) — the possibilist foundation of QLF, Zero Free Action, local time synthesis, active inference, holography, and the critique of ZFC-style infinity
- [**TheBigProblem.md**](TheBigProblem.md) — how QLF addresses the measurement problem, entanglement, spacetime, time, and consciousness
- [**GodCreatedTheIntegers.md**](GodCreatedTheIntegers.md) — a broad framing of QLF in relation to Kronecker, Einstein, Wheeler, Gödel, Bohm, Bell, Penrose, Mead, Cramer, Wolfram, ’t Hooft, Hawking, and Susskind

### 2. Core theoretical claims
- [**BraKetRhoQuCalc.md**](BraKetRhoQuCalc.md) — how bra-ket notation maps onto RhoQuCalc: action=ket, lift=bra, parallel=superposition, sequence=composition, ZFA=bra-ket balance (numerical demos in `braket_rho.py`; live evaluation via `/braket` in [quantum-os](https://github.com/jimscarver/quantum-os))
- [**Universality.md**](Universality.md) — the claim that QLF generates finite local logical closures
- [**Riemann-Conjecture-Proof.md**](Riemann-Conjecture-Proof.md) — the current QLF program relating ZFA symmetry, universality, and the critical line
- [**Measurement_Problem.md**](Measurement_Problem.md) — QLF treatment of measurement and observer-dependent closure
- [**UniversalRelativity.md**](UniversalRelativity.md) — emergent relativity and spacetime interpretation inside QLF
- [**Cross_Frequency_Lorentz.md**](Cross_Frequency_Lorentz.md) — Lorentz boost between Markov-blanket frames as a change of basis on internal ZFA event rates; identifies γ = f_A/f_B (the relativistic Doppler factor) and recovers time dilation, length contraction, and interval invariance as direct consequences
- [**TheContinuum.md**](TheContinuum.md) — why the continuum is emergent (not foundational), how QLF dissolves Zeno's paradoxes and the Lorentz invariance trap, and why the Axiom of Choice is replaced by the ZFA filter
- [**ReverseMathematics.md**](ReverseMathematics.md) — QLF as a physical realization of Reverse Mathematics; the RCA₀ core and the WKL₀ axiom boundary
- [**Lagrangian_Formulation.md**](Lagrangian_Formulation.md) — variational formulation of QLF: ℒ=0 as condition of origin, Zeno stationarity, Σ₈ symmetry algebra, decoherence impossibility, and QPU core (Φ₀=U+M); all claims anchored in machine-verified Lean theorems

### 3. Physics and experiments
- [**Experimental_Consistency.md**](Experimental_Consistency.md) — numerical and conceptual links between QLF and known physics
- [**SpectralGap.md**](SpectralGap.md) — the spectral gap `|count_pos − count_neg|` vanishes iff ZFA-symmetric; unifies Riemann zero spacing (Wigner-Dyson ~ √(πn)), Maxwell Gauss duality (`divB + charge = 0`), and quantum stability (`decoherence_impossibility`)
- [**Maxwell.md**](Maxwell.md) — all four Maxwell equations derived from ZFA: ∇·B=0 machine-verified (`no_magnetic_monopoles`), Gauss duality identity `divB=−charge`, Faraday and Ampère-Maxwell confirmed numerically in `maxwell_qlf.py`
- [**Collective_Electrodynamics.md**](Collective_Electrodynamics.md) — Mead's collective EM in QLF: photon as joint emitter-absorber ZFA handshake (relational, not projectile), fluxoid as ZFA loop, vector potential as unresolved free action, Aharonov-Bohm explained
- [**Delayed_Choice_Eraser.md**](Delayed_Choice_Eraser.md) — applies the joint-ZFA reading to the canonical "retrocausality" experiment (Kim 1999, Walborn 2002); the eraser dissolves once the photon is a Hermitian-pair handshake with no preferred temporal direction, not a projectile
- [**Bound_States_QLF.md**](Bound_States_QLF.md) — free leptons are not QLF observables; the natural QLF observables are atomic systems (positronium, muonium, hydrogen) — bound, balanced, joint-ZFA closures. Same structural move as `Delayed_Choice_Eraser.md` for photons, `Hadrons_Markov_Blankets.md` for quarks: the physical object is the joint closure, not the asymptotic free constituent
- [**Atomic_System_QLF_Closures.md**](Atomic_System_QLF_Closures.md) — specific joint-closure topology for each atomic system: positronium (symmetric two-electron-half-loops, mass 2 m_e), hydrogen (electron half-loop + proton internal closure, mass dominated by m_p), muonium (asymmetric electron + antimuon half-loops). Derives the Bohr reduced-mass scaling `E(Mu)/E(Ps) ≈ 2`, `E(H)/E(Mu) ≈ 1` from the joint-closure structure. §7 extends to the heavier-atomic-systems panel (¹H through ²³⁸U) with `R ∝ 1/A` baseline and magic-number BE/A peaks (including the ⁵⁶Fe stellar-nucleosynthesis terminator) reframed as vacuum-resonance peaks. First quantitative QLF derivation on the right atomic-system targets
- [**Magic_numbers.md**](Magic_numbers.md) — nuclear magic-number sequence `2, 8, 20, 28, 50, 82, 126` derived end-to-end from QLF substrate. Dimensional growth of half-spin closures in d = 2, 3, 4 gives 2, 8, 20 directly; for ℓ_max ≥ 3 the **vacuum itself is the intruder**, coupling in at each frequency to select the `j = ℓ_max + 1/2` orbital at the highest ℓ available. The ℓ = 3 threshold is derived algebraically: `rest > vacuum-selected ⇔ k > 2`, with the "3" coming from the d = 3 of the 3D-SHO degeneracy `(k+1)(k+2)` — exactly the 3 spatial dimensions encoded by the 8-twist alphabet's 6 spatial twists. Counterfactual dimensional shifts (d = 4 → ℓ ≥ 2, d = 2 → no threshold) make the empirical ℓ = 3 a structural prediction of the alphabet's 6+2 split. Companion script: [`magic_numbers_demo.py`](magic_numbers_demo.py)
- [**Per_Qubit_Mass_Quantum.md**](Per_Qubit_Mass_Quantum.md) — **each qubit contributes `ℏω = E_Planck / R_qubit` of rest energy**. Unifying principle that makes the bound-state mass-additivity explicit: `m(Ps) = 2 m_e`, `m(H) = m_e + m_p`, `m(Mu) = m_e + m_μ` as direct sums of constituent-qubit Compton energies. Reproduces every measured mass ratio (`m_p/m_e = 1836.15`, `m_μ/m_e = 206.77`, `m_τ/m_μ = 16.82`) exactly via `m_X/m_Y = R_Y/R_X`. Reformulates the first-principles question: derive `R_e ≈ 2.4 × 10²²` (in Planck units) from QLF closure-multiplicity
- [**Photon_Energy_Bits.md**](Photon_Energy_Bits.md) — photon-side companion: a photon's energy `E = N_bits · ℏω` (bits of joint-closure information × per-bit energy), with mass-equivalence `m_rel = E/c²` but zero rest mass. Photons carry **gauge-free bits**; massive particles carry **gauge-folded qubits**. Same accounting principle: energy = quanta × per-quantum contribution. Pair-production threshold `E_γ = 2 m_e c²` is the bit-to-qubit conversion
- [**Information_Energy_Equivalence.md**](Information_Energy_Equivalence.md) — **`ℏω = 1 bit at frequency ω`** derived from QLF first principles as the conjunction of the per-event `log 2` information quantum (Lean-anchored in `QLF_FreeEnergy.lean`) and the per-event `ℏω` energy quantum. Formalizes Wheeler's "it from bit" and Chris Fields's information-theoretic physics; recovers Margolus-Levitin (`ℏ` per bit-flip) and Landauer (`kT log 2` per bit erasure) as natural consequences. Unifies the three QLF natural-units quanta: information per event, rest energy per qubit, photon energy per bit
- [**Hydrogen.md**](Hydrogen.md) — hydrogen energy levels E_n = −13.6 eV/n² derived from ZFA (Bohr model): Coulomb from gauge-twist exchange, quantization from ZFA generation depth n; numerically verified to 0.05% in `hydrogen_qlf.py`. §4.1 reads the Rydberg series as a discrete vacuum-resonance shell spectrum at Markov-blanket depths R_n = R_1 · n², and recovers α to 10⁻¹⁰ via the Bohr-inversion form `α = sqrt(2 Ry / m_e c²)` = `sqrt(2 R_e / R_1)` ([`fine_structure_demo.py`](fine_structure_demo.py))
- [**SpaceTime.md**](SpaceTime.md) — event-synthesized space and time
- [**Gravity.md**](Gravity.md) — emergent gravity in the QLF picture
- [**ER_EPR_QLF.md**](ER_EPR_QLF.md) — entanglement, geometry, and logical structure
- [**Higgs.md**](Higgs.md) — QLF mass generation via gauge-fold depth; constructive alternative to the Higgs mechanism
- [**HadronicDepth.md**](HadronicDepth.md) — Hadronic Depth Hypothesis: n ~ (m_P/m_p)³ fixes cosmic size, age, and G from the proton mass
- [**VacuumEnergy.md**](VacuumEnergy.md), [**BLACK-HOLES.md**](BLACK-HOLES.md), [**Entropy.md**](Entropy.md) — topic-specific extensions
- [**QuantumOS.md**](QuantumOS.md) — QLF as a capability-secure, formally-verified OS kernel for QPUs: five converging security foundations, intrinsic holographic QEC, hardware-native AI with absolute interpretability, Ruliad/RCA₀ unification — security + error correction + scheduling + GC + AI are all one operation (ZFA enforcement); live demo via `/qucalc` in [quantum-os](https://github.com/jimscarver/quantum-os)
- [**Crystal_QuantumOS.md**](Crystal_QuantumOS.md) — concrete platform sketch: a QuantumOS-controlled QPU on a quiet-frequency crystal substrate (Eu:YSO worked example; rare-earth and defect-centre platforms). Maps 8-twist primitives to Rabi cycles, slash commands to control pulses, and `decoherence_impossibility` to the intrinsic-EC layer. Inspirational tooling: Kazansky 5D optical storage in fused silica
- [**Emergent_Markov_Blankets.md**](Emergent_Markov_Blankets.md) — qubit-register-scale Markov-blanket layer for the crystal-QPU substrate: resonating atom groups at quiet frequencies self-organising into collective fluxoids that act as protected logical qubits. Fills the mid-scale layer between single-defect qubits and macroscopic-collective registers; honest scoping on physical-density vs. logical-qubit-count distinction

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
- [**lean/ZFAEventDynamics.lean**](lean/ZFAEventDynamics.lean) — ZFA event dynamics, acceleration, and `no_magnetic_monopoles` (∇·B=0, Maxwell eq. 2)
- [**lean/PauliExclusion.lean**](lean/PauliExclusion.lean) — bosonic vs. fermionic statistics; `pauli_exclusion`, `fermi_nonzero_example` ([σ_x,σ_z]≠0 non-triviality witness)
- [**lean/BraKetRhoQuCalc.lean**](lean/BraKetRhoQuCalc.lean) — formal correspondence of Dirac bra-ket notation to RhoQuCalc: `action_topo_is_ket`, `lift_topo_is_bra`, `action_lift_eval_eq`, `bra_ket_always_balanced`, completeness relations, Pauli algebra σᵢ²=I (see [BraKetRhoQuCalc.md](BraKetRhoQuCalc.md))

**Physical theories:**
- [**lean/StringTheoryQLF.lean**](lean/StringTheoryQLF.lean) — gauge-fold excitation tower; `string_mass_spectrum`, `string_mode_count` (C(2n,n) forced by ZFA)
- [**lean/MTheoryQLF.lean**](lean/MTheoryQLF.lean) — M2/M5-branes, S/T-duality, 11D; `m2_mass_spectrum`, `s_dual_involution`

**Speculative extensions** (explicitly beyond the proved core):
- [**lean/AgeOfUniverse.lean**](lean/AgeOfUniverse.lean) — cosmological age estimate; `age_is_finite_and_positive`
- [**lean/ER_EPR_QLF.lean**](lean/ER_EPR_QLF.lean) — entanglement-geometry axioms; philosophical axioms only, not used by other modules

**Empirical verification** (independent numerical confirmation of Lean theorems):
- [**qlf_spectral.py**](qlf_spectral.py) — confirms `toSpectralMode_hermitian`, `spectral_symmetric_eq_scalar_id`
- [**qlf_zfa_frequency.py**](qlf_zfa_frequency.py) — confirms `find_stable_states_length_even` (C(n,n/2))
- [**qlf_dirichlet_search.py**](qlf_dirichlet_search.py) — confirms C(2k,k)/4^k ~ (1/√π)k^{-1/2} is asymptotic only (Stirling); the gap-zero state density 1/√(πn) implies spacing ~ √(πn) (Wigner-Dyson), ruling out a combinatorial bypass of `spectral_hilbert_polya`
- [**maxwell_qlf.py**](maxwell_qlf.py) — numerically derives all four Maxwell equations from ZFA: Gauss duality `divB=−charge`, ∇·B=0 for neutral events, Faraday curl, wave speed c
- [**hydrogen_qlf.py**](hydrogen_qlf.py) — E_n = −½ α² m_e c² / n² from ZFA parameters; Lyman/Balmer/Paschen spectral lines; Bohr radius; 0.05% agreement with NIST
- [**braket_rho.py**](braket_rho.py) — bra-ket ↔ RhoQuCalc correspondence: all 8 identities checked numerically
- [**qucalc_engine.py**](qucalc_engine.py), [**spacetime_dynamics.py**](spacetime_dynamics.py), [**constants_mapper.py**](constants_mapper.py), [**path_integral.py**](path_integral.py) — executable experiments

---

## Themes Now Central to the Repo

Several themes now deserve to be front-and-center in the README because they tie the repo together:

### Possibilism
Reality is not one pre-written story. QLF treats all admissible logical histories as possible, with physical reality emerging from those that close under ZFA. This is a computable form of modal realism (David Lewis 1986) — but with a selection rule. Lewis said all logically possible worlds are real; QLF says all *computationally generable* histories are real, and ZFA identifies the ones that persist. The connection to Everett (1957) is direct: the many-worlds interpretation says all branches exist, but provides no decoherence cutoff from first principles. `full_zeno_prune` is the cutoff — it eliminates histories that cannot achieve ZFA closure before they become physical events. QLF is also a computable version of Tegmark's Mathematical Universe Hypothesis (Level IV multiverse) — the difference is that QLF's computable filter is now machine-verified.

### Universality
QLF is not framed merely as a simulator. It is a generator of finite local logical closure structures — and `qlf_universality` proves this is Church-Turing complete: every terminating computation encodes as a ZFA string, so the ZFA filter is not a restriction on computation but the selection principle that picks physical reality out of the full computational universe. The variational form of this principle — ℒ = 0 as the condition of origin — is developed in [**Lagrangian_Formulation.md**](Lagrangian_Formulation.md), where `qlf_universality` anchors the pruning-as-selection argument.

### Gödel, Busy Beaver, and the limits of classical formalism
Classical formalism has three overlapping failure modes: Gödelian incompleteness (unprovable truths in sufficiently strong systems), Turing undecidability (functions that cannot be computed in finite time), and Chaitin complexity (Kolmogorov complexity grows without bound as you climb the Busy Beaver hierarchy). These are not separate curiosities — they are all shadows of the same problem: a logic that can construct objects with no finite closure.

QLF's answer is `full_zeno_prune`. Non-terminating computations — exactly the Busy Beaver-class, exactly the Turing-undecidable computations — are the ones that fail to achieve ZFA closure. They are pruned before they can become physical events. This is not a restriction: `qlf_universality` proves the ZFA filter is Church-Turing complete — every *terminating* computation IS a ZFA string. What is pruned is not computation; it is the physically unrealizable tail.

The Gödel sentences of ZFC — the ones that are true but unprovable — correspond precisely to the configurations with no finite ZFA closure. The Axiom of Choice exists to assert the existence of sets with no constructive selection procedure; the ZFA filter replaces it with a computable one. Chaitin's Ω (the halting probability) is the information content of the pruning boundary — physically realized as the ZFA filter itself.

This is why the QLF core operates in RCA₀, below the Busy Beaver horizon, with no Axiom of Choice and no continuity: Gödel's theorem cannot bite where unprovability has been physically excised. See [**Lagrangian_Formulation.md**](Lagrangian_Formulation.md) for how this pruning mechanism maps to the Lagrangian condition ℒ = 0 and is machine-verified via `encode_is_zfa` and `qlf_universality`.

### Holography, information, and logical boundary conditions
The holographic principle (Bekenstein 1972, Hawking 1975, 't Hooft 1993, Susskind 1995) says the information content of a bulk region is bounded by its surface area, not its volume — implying that bulk physics is reconstructable from boundary data. The modern sharpening of this insight is Almheiri, Dong, and Harlow (2015): **spacetime bulk geometry is a quantum error-correcting code on the boundary**. The HaPPY code (Pastawski, Yoshida, Harlow, Preskill 2015) constructs an explicit QECC (a perfect tensor network) that reproduces bulk-boundary entanglement structure.

In QLF, the ZFA boundary conditions on the logical event stream are precisely this selection principle. A ZFA string is a phase string whose boundary information content is zero-sum — all free action has been cancelled. The bulk structure (spacetime, matter, gravity) is the interior structure of a ZFA-closed event. `full_zeno_prune` is the boundary decoder: it filters the stream to those events whose boundary information is logically self-consistent.

The AdS/CFT analog is exact: a conformal field theory on the boundary ↔ gravity in the bulk becomes, in QLF, a ZFA phase string on the boundary ↔ synthesized spacetime event in the bulk. This is now formalized in `QuantumOS.md` (holographic QEC section) and grounded in three independent convergent streams: Zeno-subspace QEC (Beige 2000), holographic QECC (Almheiri/Dong/Harlow, HaPPY code), and active inference as boundary decoder (Friston Free Energy Principle).

### The Spectral Structure of QLF
Every QLF string maps to a 2×2 Hermitian operator (its *spectral mode*) built from rank-1 phase projectors. This is formalized in [`lean/QLF_Spectral.lean`](lean/QLF_Spectral.lean), which proves two machine-verified theorems: (1) the spectral mode of any string is always Hermitian; (2) for symmetric strings (equal pos/neg counts), the spectral mode is a scalar multiple of the identity — the QLF spectral analog of sitting on the critical line. The Hilbert-Pólya conjecture, that Riemann zeros are eigenvalues of a Hermitian operator, is encoded as a single geometric axiom (`spectral_hilbert_polya`) from which `critical_line_forcing` is now a derived theorem rather than a bare axiom.

### QLF and Reverse Mathematics

QLF refactors physical laws using the structural framework of Harvey Friedman's **Reverse Mathematics** program. The core QLF engine — `expand_generation`, `full_zeno_prune`, `find_stable_states`, `find_stable_states_length_even` — operates strictly within **RCA₀**, the bedrock of constructive computable mathematics: no axiom of choice, no continuity, no non-constructive existence. The transition from discrete QLF combinatorics to the continuous Riemann zeta function (Dirichlet series, analytic continuation) represents a genuine jump to a higher logical subsystem (WKL₀/ACA₀). Isolating `spectral_hilbert_polya` as an explicit axiom in `lean/QLF_Riemann.lean` is a meta-mathematical necessity — it marks the exact logical boundary where discrete computation projects its continuous statistical shadow. See [**ReverseMathematics.md**](ReverseMathematics.md) for the full treatment.

### QuantumOS: QLF as a Native OS Kernel for Quantum Simulators

QLF is not only a theoretical framework — it is an executable architecture for quantum hardware. [**QuantumOS.md**](QuantumOS.md) specifies how the QLF stack maps onto a native operating system for QPUs and quantum simulators. It is the quantum analogue of seL4 (the first formally verified OS kernel) with ZFA as the hardware-enforced invariant.

**The unification thesis:** in a classical OS, security, error correction, scheduling, garbage collection, and AI are five separate engineered subsystems. In QuantumOS, all five are the same operation — ZFA enforcement (`full_zeno_prune`) — because `qlf_universality` proves ZFA balance is the single invariant that subsumes all correctness properties at once.

- **rhoqcalc as kernel**: The ρ-process algebra (`RhoQuCalc.lean`) is the execution engine. Security is grounded in five converging formal foundations: Girard's linear logic (1987), Miller's object capability model (2006), Meredith & Radestock's ρ-calculus security (2005), Honda's session types (1993), and Wootters & Zurek's no-cloning theorem (1982). Capability names are topological structures — by Curry-Howard, possessing a name *is* a proof of authorization.
- **ZFA as complete hardware specification**: `full_zeno_prune` is the machine-verified kernel. `qlf_universality` proves every terminating computation IS a ZFA string — ZFA balance is the complete hardware specification, not an analogy. Decoherence registers as a ZFA asymmetry and is pruned before it can become a physical event. The formal QPU core is Φ₀ = U + M (ZFA condition + Σ₈ algebra) — see [**Lagrangian_Formulation.md**](Lagrangian_Formulation.md) for the variational derivation and the security conditions `[H, ρ_S] = 0`, Tr(ρ_S ρ_E) = 0 proved there.
- **Intrinsic holographic QEC**: Error correction is not patched on top — it is the mechanism by which physical reality maintains structural stability. Three independent research streams converge: Zeno-subspace QEC (Beige 2000, Facchi/Pascazio 2002), holographic spacetime-as-QECC (Almheiri/Dong/Harlow, HaPPY code, AdS/CFT), and active inference as real-time decoder (Friston FEP). `full_zeno_prune` is the machine-verified implementation of all three simultaneously.
- **Active inference as the system loop**: The OS drives a continuous Perceive (`expand_generation`) → Predict (`zfa_implies_critical_line`) → Act (`parallel`/`sequence`) → Prune (`full_zeno_prune`) cycle. No separate scheduler is needed — ZFA minimization IS the scheduling decision. Grounded in Friston's Free Energy Principle.
- **Hardware-native AI with absolute interpretability**: `Form.toMatrix` maps cognitive constructs to Clifford algebra elements — the correct geometric inductive bias for physical AI (Bronstein et al. 2021, Geometric Deep Learning). Every AI program running on QLF hardware runs in machine-verified ZFA-correct code; the output is a geometric proof of Zero Free Action, not a probabilistic best-guess.
- **Ruliad/RCA₀**: `expand_generation` explores the full ruliadic multiway space (Wheeler, Zuse, Lloyd, Wolfram); `full_zeno_prune` filters it to physical reality. The engine operates strictly within RCA₀ (Harvey Friedman's Reverse Mathematics) — the minimum constructive logical subsystem consistent with physics. Convergent with Causal Set Theory, Causal Dynamical Triangulations, and Loop Quantum Gravity.

### Convergence: twelve independent programs arriving at the same place

The most striking feature of QLF is not any single proof — it is that twelve or more independent research programs, with no coordination, have each arrived at the same core picture: **reality is informational, computable, and bounded by a logical closure condition**. QLF is the intersection point.

| Program | Key figure(s) | Convergent claim |
|---|---|---|
| Digital physics | Konrad Zuse (1969) | The universe is a computation |
| It from bit | John Wheeler (1990) | Every physical quantity derives from binary yes/no questions |
| Holographic principle | Bekenstein, Hawking, 't Hooft, Susskind (1972–1995) | Bulk physics is bounded by boundary information |
| Causal Set Theory | Bombelli, Sorkin, Henson (1987–present) | Spacetime is a discrete partial order of causal events |
| Girard linear logic | Jean-Yves Girard (1987) | Resource-sensitive reasoning; proof = process; use-once tokens |
| Reverse Mathematics | Harvey Friedman (1975–present) | Physical laws can be stratified by minimum logical strength; RCA₀ is the computable floor |
| Session types | Kohei Honda (1993) | Communication protocols have types; safety = type-checking |
| Holographic QEC | Almheiri, Dong, Harlow; HaPPY code (2015) | Spacetime bulk = quantum error-correcting code on boundary |
| Object capability model | Mark Miller (2006) | Security from first principles: unforgeable names = capability tokens |
| ρ-calculus | Meredith & Radestock (2005) | Programs as processes; names as reflective proof terms |
| Free Energy Principle | Karl Friston (2010) | All adaptive systems minimize variational free energy — perception = inference |
| Geometric Deep Learning | Bronstein, Bruna, LeCun, Szlam, Vandergheynst (2021) | Correct geometric inductive bias for physical AI = Clifford algebra elements |
| Ruliad | Stephen Wolfram (2020) | The entangled limit of all possible computations; physical reality = observer slice |
| No-cloning theorem | Wootters & Zurek (1982) | Quantum information cannot be copied — the physical foundation of capability security |

Each row independently supports a central QLF claim. None of these programs cites any of the others as its primary foundation. Their simultaneous convergence on the same logical structure is the main evidence that QLF is pointing at something real.

---

## Current Status

The Lean formalization compiles with **zero `sorry` blocks** across all 16 modules. The entire combinatorial core operates within **RCA₀** — the minimum constructive logical subsystem (no Axiom of Choice, no continuity). The only axioms are three in `QLF_Riemann` marking the exact RCA₀ → WKL₀ boundary, and philosophical axioms in `ER_EPR_QLF` (not used by other modules).

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
```

### Try in the browser

The [**quantum-os**](https://github.com/jimscarver/quantum-os) P2P app runs the ZFA kernel (Rust/WASM) live. Open **https://jimscarver.github.io/quantum-os/**, click Connect, then type in the chat input:

**`/braket +`** — evaluates `action(Form_+)`, the `|+⟩` density matrix:
```
ket: |+⟩
  RhoProcess: action(Form_+)
  eval = Form.toMatrix:
  ⎡ 0.5  0.5 ⎤
  ⎣ 0.5  0.5 ⎦
bra: ⟨+|  (eval = ket†  =  ket  [Hermitian: Form.toMatrix_adjoint ✓])
  ZFA: action [+,−]  lift [−,+]  both balanced: ✓
  bra_ket_always_balanced: ✓ (BraKetRhoQuCalc.lean)
```

**`/braket 0 1`** — completeness relation `|0⟩⟨0| + |1⟩⟨1| = I`:
```
eval = Form.toMatrix:
  ⎡ 1  0 ⎤
  ⎣ 0  1 ⎦
```

**`/qucalc +-+-`** — ZFA-balanced 4-twist sequence, stable under `full_zeno_prune`:
```
twists: +-+-  (4 total)
action (pos): count=2   lift (neg): count=2
spectral gap: 0  ZFA-balanced: ✓
process: parallel(action(Form), lift(Form))  → ZFA stable
achieves_ZFA: ✓  rho_process_always_zfa: ✓ (Lean-verified)
```

**`/qucalc +++`** — unbalanced, pruned before it can become a physical event:
```
twists: +++  (3 total)
action (pos): count=3   lift (neg): count=0
spectral gap: 3  ZFA-balanced: ✗
process: UNBALANCED  → pruned by full_zeno_prune
achieves_ZFA: ✗  gap=3  (not a physical process)
```

States supported by `/braket`: `0`, `1`, `+`, `-`, `i`, `-i`. Twist alphabet for `/qucalc`: `^v<>/\+-` or hex `0-7` or any `cap:label:hex` capability token. Type `/help` for the full list.

### Build Lean

```bash
lake update
lake exe cache get
lake build
```

---

## Recommended Reading Paths

### If you care most about foundations

[Philosophy.md](Philosophy.md) → [GodCreatedTheIntegers.md](GodCreatedTheIntegers.md) → [Universality.md](Universality.md) → [Lagrangian_Formulation.md](Lagrangian_Formulation.md)

### If you care most about physics

[TheBigProblem.md](TheBigProblem.md) → [Measurement_Problem.md](Measurement_Problem.md) → [SpaceTime.md](SpaceTime.md) → [Gravity.md](Gravity.md) → [Lagrangian_Formulation.md](Lagrangian_Formulation.md)

### If you care most about the variational / Lagrangian formulation

[Lagrangian_Formulation.md](Lagrangian_Formulation.md) → [Philosophy.md](Philosophy.md) → [lean/RhoQuCalc.lean](lean/RhoQuCalc.lean) → [lean/BraKetRhoQuCalc.lean](lean/BraKetRhoQuCalc.lean)

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

