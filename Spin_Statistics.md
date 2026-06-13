# Spin–Statistics Theorem in QLF

**Fermions anticommute; bosons commute. The composition operator selects the statistics.**

Standard QM treats the spin-statistics theorem as a deep result of relativistic quantum field theory: half-integer-spin particles obey Fermi-Dirac statistics (Pauli exclusion); integer-spin particles obey Bose-Einstein statistics. The standard proof requires the Lorentz group representation theory, locality, and positive-energy assumptions; the connection to spin is mathematically intricate.

In QLF the theorem is **constructive and immediate**: it is a choice of composition operator on RhoProcesses. Bosonic statistics use `parallel` composition (matrix addition, commutative). Fermionic statistics use `sequence` composition (matrix multiplication, non-commutative). The Pauli exclusion principle is the special case $[A, A] = 0$, and it is non-vacuous because $[A, B] \neq 0$ in general.

This document collects the algebraic content of [PauliExclusion.lean](lean/PauliExclusion.lean), [MRE.md](MRE.md) §2.2's 1/2-spin atom structure, and [HALF-SPIN-ZFA-EMBEDDING.md](HALF-SPIN-ZFA-EMBEDDING.md)'s spin-1/2 embedding into one statement of the spin–statistics correspondence.

## 1. The composition operator selects statistics

From [PauliExclusion.lean](lean/PauliExclusion.lean) (machine-verified):

**Bosonic statistics** use the `parallel` composition operator:

```
(RhoProcess.parallel p q).eval = (RhoProcess.parallel q p).eval
```

(theorem `bosonic_parallel_symmetric`). Parallel = matrix addition, which is always commutative. Two identical bosonic processes in parallel are interchangeable; there is no exclusion.

**Fermionic statistics** use the `sequence` composition operator:

```
fermi_antisym p q := (RhoProcess.sequence p q).eval - (RhoProcess.sequence q p).eval
```

(definition `fermi_antisym`). Sequence = matrix multiplication, which is in general non-commutative. The antisymmetric combination `fermi_antisym p q` is the matrix commutator `[p.eval, q.eval] = p.eval * q.eval - q.eval * p.eval` (theorem `fermi_antisym_eq_commutator`).

**Pauli exclusion** is the theorem `pauli_exclusion`: `fermi_antisym p p = 0` for all `p`. This says two identical fermionic processes cannot coexist — their antisymmetric combination vanishes, so the joint state is zero (forbidden). Crucially, `fermi_antisym p q ≠ 0` in general (theorem `fermi_nonzero_example`: $[\sigma_x, \sigma_z] = [[0, -2], [2, 0]] \neq 0$), so the exclusion is **non-vacuous** — it forbids identical pairs but permits distinct pairs.

## 2. Why this matches the spin

The spin-1/2 atom is the smallest Hermitian closure under the ZFA algebra ([MRE.md](MRE.md), [HALF-SPIN-ZFA-EMBEDDING.md](HALF-SPIN-ZFA-EMBEDDING.md)). It folds to $-I$ under Pauli composition; a pair of identical 1/2-spin atoms in **sequence** folds to $(-I)^2 = +I$, but the antisymmetric combination vanishes.

A **boson** is a composite whose underlying spin contribution is an integer multiple of $\hbar$ — i.e., an **even** number of 1/2-spin atoms composed in parallel. The even count cancels the per-atom $-I$ phase, leaving $+I$; the parallel composition is commutative; two identical bosons stack with no exclusion (Bose-Einstein condensate, [BOSE-EINSTEIN-CONDENSATE.md](BOSE-EINSTEIN-CONDENSATE.md)).

A **fermion** is a composite whose underlying spin contribution is a half-integer multiple of $\hbar$ — an **odd** number of 1/2-spin atoms. The odd count leaves a residual $-I$ phase; sequential composition with another fermion is non-commutative; two identical fermions exclude (Pauli exclusion principle, [Atom.md](Atom.md) §2).

**The spin-statistics correspondence is therefore the arithmetic of the per-atom $-I$ Pauli fold:**

- Even atoms → even powers of $-I$ → $+I$ → commute → boson
- Odd atoms → odd powers of $-I$ → $-I$ → anticommute → fermion

This is the 720° fermion spinor signature read at the statistics level: a single 1/2-spin atom is the half-turn that gives fermions their $-1$ phase under $360°$ rotation; the same algebraic signature makes them anticommute under exchange.

## 3. Two angles on the same theorem

**Algebraic angle**. The spin-statistics correspondence is a direct consequence of:
1. The 8-twist alphabet's Pauli structure (`tau_xy_product` etc., [Lagrangian_Formulation.md](Lagrangian_Formulation.md))
2. The choice of `parallel` vs `sequence` as the composition operator (PauliExclusion.lean)
3. The per-atom $-I$ fold of the minimal Hermitian pair ([MRE.md §2.2](MRE.md))

No additional postulates are needed. The theorem is a corollary of the algebra.

**Topological angle**. The 720° double cover of SO(3) by SU(2) ([Hierarchical_Control.md §2](Hierarchical_Control.md), HALF-SPIN-ZFA-EMBEDDING.md, and now **machine-verified** in [`Spin_QLF.md`](Spin_QLF.md) / [`lean/QLF_Spin.lean`](lean/QLF_Spin.lean)) gives fermions a non-trivial $-1$ phase under $2\pi$ rotation. Concretely: one Hermitian twist pair (360°) folds to `−I` (`rotation_360_eq_negI`), two pairs (720°) to `+I` (`rotation_720_eq_id`); the twist axes close su(2) (`su2_comm_xy/yz/zx`) and the cover is genuine, `−I ≠ +I` (`spin_double_cover_nontrivial`). An odd number of half-spin pairs folds to `−I` (fermion, `fermion_odd_pairs`), an even number to `+I` (boson, `boson_even_pairs`). Exchange of two identical fermions is geometrically a $\pi$ rotation of one around the other in the worldline picture (Feynman–Wheeler); odd half-turn = $-1$ phase = antisymmetric exchange. Bosons (even half-turn count) pick up no phase = symmetric exchange.

Both angles arrive at the same conclusion: spin half-integer ↔ Fermi-Dirac statistics; spin integer ↔ Bose-Einstein statistics. QLF makes both derivations algebraically explicit at the same time.

## 4. Why this is the spin–statistics theorem

The standard relativistic spin–statistics theorem (Pauli 1940; Lüders & Zumino 1958; Streater & Wightman *PCT, Spin and Statistics, and All That* 1964) requires:

1. Lorentz invariance
2. Positive energy
3. Local commutativity (microcausality)
4. Uniqueness of the vacuum

These give, after substantial machinery, the result that half-integer spin ↔ anticommuting fields and integer spin ↔ commuting fields.

QLF's derivation in §1–3 above is the same theorem but obtained from the **8-twist algebra's structure** rather than from continuous-spacetime field theory. Each of the four standard assumptions has a QLF analog:

- Lorentz invariance → cross-frequency relativity ([Hierarchical_Control.md §2](Hierarchical_Control.md))
- Positive energy → ZFA closure as the selection principle ([Lagrangian_Formulation.md](Lagrangian_Formulation.md): $\mathcal{L} = 0$)
- Local commutativity → local ZFA closure ([Measurement_Problem.md](Measurement_Problem.md), [Entanglement.md §5](Entanglement.md))
- Uniqueness of vacuum → ZFA Identity (the Void) is the unique zero of the algebra

The QLF derivation is therefore both **more elementary** (works in a finite discrete algebra) and **constructive** (gives an explicit per-atom calculation). The continuum-spacetime spin-statistics theorem is the asymptotic limit of the QLF discrete one.

## 5. Worked examples

### 5.1 Electron–electron exclusion (atomic shells)

Two electrons in the same atomic orbital state would be identical fermions in sequence — their antisymmetric combination vanishes. Atomic shell filling ([Atom.md](Atom.md)) is the consequence: each orbital admits at most one spin-up + one spin-down electron, because those two states are NOT identical (different spin quantum number, so `fermi_antisym e_up e_down ≠ 0`). A third electron in the same orbital would be identical to one of them and would be forbidden by `pauli_exclusion`.

This is the QLF derivation of the Aufbau principle and the periodic table's shell structure (already developed in Atom.md without explicit spin-statistics framing).

### 5.2 Photon condensation (Bose-Einstein)

Photons are spin-1 bosons (an even number of 1/2-spin atoms composed in parallel). Identical photons commute under exchange; arbitrarily many can occupy the same mode. This is the basis of laser coherence and Bose-Einstein condensation ([BOSE-EINSTEIN-CONDENSATE.md](BOSE-EINSTEIN-CONDENSATE.md)).

### 5.3 Hadron statistics (quark composites)

A baryon is three quarks (each spin-1/2) in a Borromean topology ([Hadrons_Markov_Blankets.md](Hadrons_Markov_Blankets.md)). Total spin: three half-integers can combine to spin 1/2 (proton, neutron) or spin 3/2 (Δ baryons); both half-integer = fermion. A meson is two quarks (quark + antiquark) and has integer spin = boson. The statistics emerge automatically from the parallel composition of constituent atoms.

## 6. Open work

- **Lean theorem**: `spin_statistics_correspondence` formalizing §2's arithmetic — odd atom count → anticommute, even → commute.
- **Numerical demo**: simulate a Bose-Einstein condensate vs a Fermi sea using QLF compositions; verify the statistics empirically.
- **Anyonic statistics**: 2D systems allow fractional statistics (anyons) with arbitrary exchange phases. QLF's 8-twist alphabet is 3-spatial-dimensional; a reduction to a 2D subspace should give anyon statistics naturally — open derivation.
- **Pauli exclusion in Lean for arbitrary RhoProcess pairs**: extend `pauli_exclusion` from the matrix-commutator statement to the full algebraic claim that identical fermionic processes annihilate at every causal frontier.

## References

### Internal

- `lean/PauliExclusion.lean` — Lean-verified `bosonic_parallel_symmetric`, `pauli_exclusion`, `fermi_nonzero_example`, `fermi_antisym_eq_commutator`
- [MRE.md](MRE.md) — 1/2-spin atom as the smallest Hermitian-pair closure; per-event $\log 2$ quantum
- [HALF-SPIN-ZFA-EMBEDDING.md](HALF-SPIN-ZFA-EMBEDDING.md) — the spin-1/2 set-theoretic embedding; 720° double-cover signature
- [Lagrangian_Formulation.md](Lagrangian_Formulation.md) — Σ₈ algebra; `parallel` vs `sequence` composition operators
- [Atom.md](Atom.md) — shell-filling (Aufbau) as Pauli exclusion at work
- [BOSE-EINSTEIN-CONDENSATE.md](BOSE-EINSTEIN-CONDENSATE.md) — photon condensation as bosonic stacking
- [Hadrons_Markov_Blankets.md](Hadrons_Markov_Blankets.md) — baryon/meson composite statistics
- [Hierarchical_Control.md](Hierarchical_Control.md) — 720° double cover at the SU(2) level
- [Entanglement.md](Entanglement.md) — Bell violations from the non-commutative algebra
- [Born_Rule.md](Born_Rule.md) — exchange-symmetric vs antisymmetric probability structures

### External

- Pauli, W. (1940). *The connection between spin and statistics.* Phys. Rev. 58, 716 — original spin-statistics theorem.
- Streater, R. F., Wightman, A. S. (1964). *PCT, Spin and Statistics, and All That.* Benjamin — the canonical relativistic-field-theory treatment.
- Berry, M. V. (1984). *Quantal phase factors accompanying adiabatic changes.* Proc. R. Soc. Lond. A 392, 45 — geometric origin of the $-1$ fermion phase via SU(2) holonomy.
- Wilczek, F. (1982). *Quantum mechanics of fractional-spin particles.* Phys. Rev. Lett. 49, 957 — anyons in 2D, the case QLF should reduce to in a 2D subspace.
