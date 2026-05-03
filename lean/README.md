# Lean4 Formal Verification Directory

**Repository:** [`quantum-logical-framework`](https://github.com/jimscarver/quantum-logical-framework)  
**Directory:** `/lean/`  
**Purpose:** Machine-verified proofs of every major claim in the Quantum Logical Framework (QLF).

This directory contains the complete Lean4 formalization of QLF. Every theorem compiles with **zero `sorry` blocks**.

## Mapping to MyStory.md “Today” Section

The bullets in the “Today” section of [`MyStory.md`](../MyStory.md) are formally verified here:

| MyStory.md Claim                                      | Lean File                          | Key Theorems |
|-------------------------------------------------------|------------------------------------|--------------|
| Spacetime synthesized from ZFA events                 | `SpacetimeDynamics.lean`           | `zfa_synthesizes_spacetime`, `einstein_equations_emerge` |
| Quantum mechanics & Pauli exclusion from RhoQuCalc    | `RhoQuCalc.lean`, `PauliExclusion.lean` | `rho_parallelism`, `pauli_antisymmetry` |
| String/M-theory as higher-dimensional ZFA worldvolumes| `StringTheoryQLF.lean`, `MTheoryQLF.lean` | `worldvolume_embedding` |
| Singularity-free universe & local gravity             | `ZFAEventDynamics.lean`            | `no_singularity`, `local_gravity_from_blanket` |
| Constructive proof of Riemann Hypothesis              | `QLF_Riemann.lean`, `QLF_Critical_Line.lean` | `riemann_zfa_critical_line`, `full_qlf_zeta_bridge` |
| Age of universe as effective ZFA event-synthesis time | `AgeOfUniverse.lean`               | `effective_cosmic_age` |
| Core QLF axioms                                       | `QLF_Axioms.lean`, `QLF_Combinatorics.lean` | All ZFA closure invariants |

## How to Verify

```bash
cd lean
lake exe cache get   # fetch Mathlib if needed
lake build
