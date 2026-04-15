# Quantum Logical Framework

A Python-based exploratory repository for simulating a **quantum-logical** view of physics in which stable structure emerges from **zero-free-action distinctions** in Hilbert space. The codebase currently centers on small, self-contained demonstrations built with **NumPy** and **Matplotlib**, including a path-integral toy model, a frequency-doubling construction, and holographic-style projections. The repository also includes conceptual notes on entropy, particles, and yin-yang logic. 

The current repository contains the following top-level files: `README.md`, `Entropy.md`, `Particles.md`, `REVIEW.md`, `YIN_YANG_LOGIC.md`, `doubler.py`, `fermi_accelerator.py`, `holographic.py`, `particles.py`, `path_integral.py`, `quantum_simulator.py`, and `universal.py.`. Several Python modules are educational prototypes rather than production-grade simulation packages, and at least one file (`quantum_simulator.py`) is presently a placeholder. 

## Core Thesis

This framework explores the idea that:

- the deepest layer of reality can be modeled as a space of possible quantum-logical distinctions,
- persistent structures correspond to **balanced** or **zero-free-action** configurations,
- familiar physical regularities arise only after projection, coarse-graining, or loss of information,
- spin-1/2 structure is treated as more fundamental than emergent classical fields.

This is a conceptual and computational research project. It is not a conventional quantum-mechanics library, and it does not attempt to reproduce the full standard model or mainstream numerical quantum toolchains.

## What Is in the Repository

### Python modules

#### `path_integral.py`
A capstone-style demonstration of the repository's main interpretive claim: microscopic histories are modeled as zero-free-action folds, while an emergent least-action trajectory appears only after coarse-graining. The script samples many random fold histories, accumulates amplitudes, and plots several visual summaries.

#### `doubler.py`
A toy model of **frequency doubling** framed as controlled tunneling into an expanded Hilbert-space factor. It uses Pauli-style rotations and a controlled operation to illustrate how higher harmonics can emerge from non-commutative folding.

#### `holographic.py`
A visualization-oriented script showing how discrete qubit transitions can be mapped to polygonal trajectories in projected Bloch-space coordinates, together with a lower-dimensional “holographic” projection.

#### `quantum_simulator.py`
Currently a placeholder for a more general simulator.

#### Other Python files
The repository also includes `fermi_accelerator.py`, `particles.py`, and `universal.py.`. These appear intended to extend the framework, but the current README should treat them conservatively until they are fully documented and stabilized.

### Conceptual notes

#### `Entropy.md`
Defines entropy in this framework as logical information outside a local light-cone perspective rather than as a primitive quantity.

#### `Particles.md`
A conceptual note associated with the particle interpretation used in the framework.

#### `YIN_YANG_LOGIC.md`
A short conceptual document relating complementary structure to the broader logic of the framework.

#### `REVIEW.md`
Review and commentary material for the project.

## Conceptual Themes

The current code and notes revolve around a recurring set of ideas:

1. **Zero free action** as the primitive balancing principle.
2. **Pauli-generated folds** as the elementary transformation model.
3. **Hilbert-space dimensional growth** as a proxy for resolved distinctions.
4. **Emergence by coarse-graining**, where classical-looking behavior appears only after inaccessible distinctions are traced out.
5. **Holographic projection**, where richer underlying structure is represented by lower-dimensional observables.

## Installation

```bash
git clone https://github.com/jimscarver/quantum-logical-framework.git
cd quantum-logical-framework
python -m pip install numpy matplotlib
```

## Quick start

Run the path-integral demonstration:

```bash
python path_integral.py
```

Run the frequency-doubling demonstration:

```bash
python doubler.py
```

Run the holographic transition demonstration:

```bash
python holographic.py
```

## Project status

This repository is best understood as an **exploratory research prototype**. It combines conceptual documents with executable demonstrations. Some modules are more complete than others, and parts of the codebase still need consolidation, cleanup, and documentation.

Recommended next steps for the repository:

- document every Python file with its purpose, inputs, and outputs,
- remove or rename unfinished files that may confuse readers,
- add example images or sample output plots,
- separate established code from speculative roadmap items,
- add a license and repository topics,
- include a short mathematical glossary for non-specialist readers.

## Intended audience

This repository may be useful to readers interested in:

- quantum foundations,
- information-first interpretations of physics,
- Hilbert-space geometry,
- exploratory simulations of emergence,
- logic-centered metaphysical or mathematical models.

## Important scope note

The repository presents an original framework and associated simulations. It should be read as a speculative research program and computational thought experiment rather than as a validated physical theory.
