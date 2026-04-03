# Quantum Logical Framework (QLF)

![Python Version](https://img.shields.io/badge/python-3.10%2B-blue)
![License](https://img.shields.io/badge/license-MIT-green)
![Status](https://img.shields.io/badge/status-Experimental-orange)

This project starts from a simple but radical claim: **physical reality is fundamentally quantum-logical**.

Nothing exists in isolation. The minimal creation event is a complementary entangled pair. All physical processes arise from local distinctions expressible via Pauli operations. Only events that achieve **Zero Free Action (ZFA)** persist as stable structure. Everything else is excluded by logical contradiction.

In this framework, spacetime, particles, and measurable physics are not presupposed — they **emerge** from recursively stable closures of quantum-logical relations.

**QuCalc** is the core engine: a discrete, topological quantum rho-calculus based on an 8-twist relational alphabet (`^ v < > / \ + -`). These symbols represent local directional distinctions relative to context, not absolute coordinates in a background space.

Unitarity and conservation laws are not imposed — they naturally emerge from the geometric requirement of Zero Free Action.

## Core Concepts

- **QuCalc Relational Alphabet** — Context-relative twists that build history strings.
- **Generative History Strings** — Sequences of folds whose net closure defines events.
- **Zero Free Action (ZFA)** — The stability condition: total logical action must balance to zero for an event to persist.
- **Hermitian Closure** — Events + their conjugate inverse annihilate perfectly, enforcing unitarity.
- **Emergent Spacetime** — Space and time arise from free vs. bound action in closed loops.

## Project Structure

### Core Simulation Scripts
- `SpaceTime.py` — Emergent spacetime from free/bound action
- `constants_mapper.py` — Translation layer from QuCalc twists to SI units (Planck-scale mapping)
- `MultiParticle.py` — Entanglement and joint ZFA resolution
- `environmental_context.py` — Hierarchical assembly and macroscopic contexts
- `particles.py` — Particle definitions and behaviors
- `hermitian.py` — Hermitian conjugacy and unitary proofs
- `QuCalc.py` / `qucalc_engine.py` / `qc_assembler.py` — Core QuCalc engine and assembler

### Additional Modules
- `quantum_simulator.py`, `path_integral.py`, `gravitational_tensor.py`
- `fermi_accelerator.py`, `doubler.py`, `topology_resolver.py`, `holographic.py`
- `tutorial_01_bell_state.py` — Educational example

### Documentation
- `QuCalc.md` — Deep dive into the relational alphabet
- `SpaceTime.md`, `Gravity.md`, `Hermitian_Conjugacy_Proof.md`
- `Particles.md`, `Entropy.md`, `YIN_YANG_LOGIC.md`, etc.

## Quick Start

**Requirements:**
- Python 3.10 or higher
- No external dependencies (uses only standard library: `math`, `cmath`, `hashlib`, `collections`, etc.)

```bash
git clone https://github.com/jimscarver/quantum-logical-framework.git
cd quantum-logical-framework
```

Run any core module to explore the framework:

```bash
python SpaceTime.py
python MultiParticle.py
python constants_mapper.py
```

## Key Examples

### 1. Emergent Spacetime (`SpaceTime.py`)

```bash
python SpaceTime.py
```

**Sample Output:**
```
--- Simulating Free Spatial Propagation (Photon) ---
History String: ^^^^<<<<////
Total Logical Action: 12
Free Action (E_free): 12.0
Bound Action (E_bound): 0.0
Generated Space (x = E_free / h): 3.000
Local Time Interval (t = h / E_bound): inf
...
```

This demonstrates that photons experience no proper time while massive particles act as high-frequency internal clocks.

### 2. Mapping to Standard Physics (`constants_mapper.py`)

Translates QuCalc's dimensionless twists into kilograms, meters, seconds, and energy units using Planck-scale anchors.

### 3. Entanglement (`MultiParticle.py`)

Geometric entanglement via overlapping causal horizons and joint Zero Free Action search — no tensor products required.

### 4. Macroscopic Assembly (`environmental_context.py`)

Shows how stable logical components are bound into higher-level named contexts (e.g., nucleons, protons).

## Philosophy & Motivation

This framework offers a discrete, computable alternative to traditional continuous quantum mechanics. It aims to show that the full richness of quantum physics — including spacetime emergence, entanglement, and conservation laws — can arise from pure relational logic and topological closure.

Supporting documents in the repository provide detailed proofs and explorations (Hermitian conjugacy, gravitational implications, Yin-Yang logic grounding, etc.).

## License

This project is licensed under the **MIT License** — see the [LICENSE](LICENSE) file for details.

## Contributing

Contributions, discussions, and issue reports are welcome. This is an experimental framework — feedback on clarity, consistency, and physical mapping is especially valuable.

---

**Ready to explore a universe built from pure quantum logic?**  
Start with `python SpaceTime.py`
```
