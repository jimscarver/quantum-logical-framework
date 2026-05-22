# Lean 4 Formalization — Quantum Logical Framework

**Build:** `lake build` on Lean 4.30.0-rc2 + Mathlib  
**Status:** CI passing, zero `sorry` blocks across all active modules

## Active Modules

| Module | Description | Key theorems / definitions |
|---|---|---|
| [QLF_Axioms.lean](QLF_Axioms.lean) | Core types, counting, pruning, ZFA | `zfa_implies_critical_line`, `full_prune_invariant`, `single_prune_invariant` |
| [QLF_Combinatorics.lean](QLF_Combinatorics.lean) | Phase-string generation helpers | `expand_generation_list`, `find_stable_states_list` |
| [QLF_QuCalc.lean](QLF_QuCalc.lean) | Phase-generation engine, stable-state filter | `expand_generation`, `find_stable_states`, `qucalc_generates_all_phase_strings` |
| [QLF_Critical_Line.lean](QLF_Critical_Line.lean) | ZFA-to-symmetry bridge wrappers | `riemann_zfa_critical_line`, `riemann_zfa_critical_line_sym` |
| [QLF_Universality.lean](QLF_Universality.lean) | Every terminating computation encodes as a ZFA string | `encode_is_zfa`, `encode_is_generated`, `qlf_universality`, `encode_is_phase_only` |
| [QLF_Spectral.lean](QLF_Spectral.lean) | Spectral projector operators; Hermitian structure; Hilbert-Pólya bridge | `toSpectralMode_hermitian`, `spectral_symmetric_eq_scalar_id` |
| [QLF_Riemann.lean](QLF_Riemann.lean) | Riemann hypothesis program in QLF | `find_stable_states_iff`, `find_stable_states_length_odd`, `critical_line_forcing`, `riemann_hypothesis_in_qlf` |
| [SpacetimeDynamics.lean](SpacetimeDynamics.lean) | Pauli-basis Form matrices; spacetime synthesis | `Form.toMatrix_adjoint`, `Form.equal_and_opposite_self` |
| [RhoQuCalc.lean](RhoQuCalc.lean) | ρ-process algebra, Hermitian structure, ZFA stability | `parallel_hermitian`, `action_lift_hermitian`, `rho_process_always_zfa`, `rho_process_always_symmetric`, `phase_symmetric_achieves_zfa` |
| [ZFAEventDynamics.lean](ZFAEventDynamics.lean) | ZFA events, spacetime synthesis, acceleration | `spacetime_from_zfa_preserves_synthesis`, `zfa_dynamics_drive_acceleration` |
| [AgeOfUniverse.lean](AgeOfUniverse.lean) | Cosmological age from ZFA event rate | `age_is_finite_and_positive` |
| [ER_EPR_QLF.lean](ER_EPR_QLF.lean) | Entanglement-geometry axioms | philosophical axioms (speculative extension) |

## Axiom Inventory

The following axioms are irreducible assumptions — they represent the mathematical claims connecting QLF to physics that go beyond what is constructively provable from the combinatorial core:

| Axiom | Location | Meaning |
|---|---|---|
| `spectral_hilbert_polya` | `QLF_Riemann` | Scalar spectral mode forces a non-trivial zero to the critical line (QLF form of the Hilbert-Pólya conjecture) |
| `NonTrivialZero` | `QLF_Riemann` | Predicate identifying non-trivial zeros of ζ(s) |
| `resonant_computation_for` | `QLF_Riemann` | Associates a TerminatingComputation to each candidate zero |

`critical_line_forcing` is **derived** from `spectral_hilbert_polya` via `spectral_symmetric_eq_scalar_id` — it is a theorem, not an axiom.

## Proof Chain: Riemann Hypothesis in QLF

```
encode_is_phase_only      : encodeComputation c is pure-phase
encode_is_zfa             : encodeComputation c achieves ZFA
zfa_implies_critical_line : ZFA ⟹ is_symmetric
spectral_symmetric_eq_scalar_id : is_symmetric ⟹ toSpectralMode s = c • I
spectral_hilbert_polya    : (axiom) scalar mode ⟹ ρ.re = 1/2
──────────────────────────────────────────────────────────────
riemann_hypothesis_in_qlf : NonTrivialZero ρ ⟹ ρ.re = 1/2
```

## How to Build

```bash
lake exe cache get   # fetch prebuilt Mathlib (saves ~1 hour)
lake build
```

Requires [elan](https://github.com/leanprover/elan); Lean 4.30.0-rc2 is pinned via `lean-toolchain`.

## Empirical Verification Scripts

These Python scripts confirm the Lean theorems numerically:

| Script | What it checks |
|---|---|
| [`../qlf_spectral.py`](../qlf_spectral.py) | All pure-phase strings are Hermitian; symmetric strings give scalar × I |
| [`../qlf_dirichlet_search.py`](../qlf_dirichlet_search.py) | Stable-state counts vs. Dirichlet partial sums (asymptotic, not exact) |
| [`../qucalc_engine.py`](../qucalc_engine.py) | Phase-string generation and ZFA filtering |
