# Conservation Laws: Noether's Theorem in QLF

**Every ZFA-preserving symmetry of the 8-twist algebra corresponds to a conservation law.** Noether's theorem in standard physics relates continuous symmetries of the action to conserved quantities; in QLF the same structure is discrete and constructive — the algebra's symmetries are the conservation laws.

This document collects threads scattered across [Energy_Combinatorics.md](Energy_Combinatorics.md), [E_mc2_derivation.md](E_mc2_derivation.md), [Hermitian_Conjugacy_Proof.md](Hermitian_Conjugacy_Proof.md) (conservation as unitarity), [Annihilation.md](Annihilation.md) (per-atom information bookkeeping), [Maxwell.md](Maxwell.md) (charge conservation), and the Lean theorem corpus (`rho_process_always_zfa`, `bra_ket_always_balanced`, `decoherence_impossibility`) into a single statement.

## 1. The principle

In standard physics, **Noether's theorem (1918)** states: every continuous symmetry of the action gives rise to a conserved current. Translation in time → energy. Translation in space → momentum. Rotation → angular momentum. U(1) gauge → electric charge. SU(2) isospin → weak isospin. Etc.

In QLF, the 8-twist algebra has a finite set of **discrete symmetries**, each of which corresponds to a conservation law at the level of ZFA-closed histories:

| 8-twist symmetry | Conserved quantity | Lean / Numerical anchor |
|---|---|---|
| Time-translation (cyclic shift of history) | **Energy** | `rho_process_always_zfa`, [E_mc2_derivation.md](E_mc2_derivation.md) |
| Spatial translation (cyclic shift in axis-orbit) | **Momentum** | `path_integral.py` phase invariance |
| Rotation (axis permutation Y↔X↔Z) | **Angular momentum** | `tau_xy_product`, `tau_yz_product`, `tau_zx_product` in `BraKetRhoQuCalc.lean` |
| Gauge swap (+ ↔ −) | **Electric charge** | `no_magnetic_monopoles`, [Maxwell.md](Maxwell.md) |
| Hermitian conjugation (E ↔ E†) | **Unitary norm / probability** | `bra_ket_always_balanced`, [Hermitian_Conjugacy_Proof.md](Hermitian_Conjugacy_Proof.md) |
| Pauli-fold invariance (identity-mod-phase) | **Information** (per-event $\log 2$ bookkeeping) | [MRE.md](MRE.md), [Annihilation.md](Annihilation.md) |
| Global chirality reflection (LH ↔ RH) | **CPT** (combined) | [CP-Violation-and-Chirality.md](CP-Violation-and-Chirality.md) |

The conservation law is not a separate axiom; it is a **direct consequence** of the symmetry holding at every ZFA closure. Because every constructible RhoProcess is ZFA (`rho_process_always_zfa`, [RhoQuCalc.lean:382](lean/RhoQuCalc.lean)), every constructible process preserves all of these quantities by construction. They cannot be violated because there is no admissible history in which they are.

## 2. Energy

From [Energy_Combinatorics.md](Energy_Combinatorics.md): the energy of a QLF system is the **multiplicity** of valid histories at a given length — the number of topological permutations achieving the same ZFA closure. From [E_mc2_derivation.md](E_mc2_derivation.md): mass is the constructing-delay contribution of gauge folds, and $E = mc^2$ recovers the energy in those gauge folds.

The **conservation** follows from the time-translation symmetry of the QuCalc engine: the rewrite rules are time-homogeneous (the same rule applies at every clock tick of [Frequency_Synchronization.md](Frequency_Synchronization.md)). A history $h_1$ at time $t_1$ has the same admissible-extension multiplicity as the same history $h_1$ at time $t_2$; therefore the energy $E(h_1)$ does not depend on absolute time. Across any ZFA-closed process, energy in must equal energy out.

Per-event bookkeeping ([Annihilation.md §3](Annihilation.md), [MRE.md §2.1](MRE.md)): each 1/2-spin atom carries $\log 2$ nats of information; energy is $E = h \cdot \text{bits} = h \nu$ when bits flow at frequency $\nu$. **Energy conservation = information bookkeeping conservation = ZFA constraint preservation.**

## 3. Momentum and angular momentum

**Momentum** follows from spatial translation symmetry: cyclic shifts of an axis-orbit history don't change its ZFA-closure status. The conserved current is the net axis-orbit count along each spatial axis — the per-axis B-field component in [Maxwell.md §1](Maxwell.md): $B_x = \text{count}(>) - \text{count}(<)$, etc. A free particle's momentum is the net spatial-axis bias of its history string.

**Angular momentum** follows from rotation symmetry: the τ-algebra $\tau_i \tau_j = -\delta_{ij} I - \varepsilon_{ijk} \tau_k$ (machine-verified `tau_xy_product` etc. in `BraKetRhoQuCalc.lean`) is invariant under cyclic axis permutations. The conserved current is the total spin contribution from each ZFA atom — exactly the spinor structure of [HALF-SPIN-ZFA-EMBEDDING.md](HALF-SPIN-ZFA-EMBEDDING.md).

The discreteness of angular momentum (quantized in $\hbar/2$ units) follows from the discreteness of the 1/2-spin atom: each atom contributes exactly one spin quantum. Higher angular momentum = parallel composition of more atoms.

## 4. Charge

From [Maxwell.md §4.1](Maxwell.md) and the Lean-verified `no_magnetic_monopoles`: ZFA closure forces every individual twist count to zero, so the net gauge count $\text{charge}(h) = \text{count}(+) - \text{count}(-)$ is zero for any ZFA-closed event. For non-charge-neutral processes (an electron in isolation), the count is non-zero but constant — gauge folds can only be created or destroyed in Hermitian pairs `+−`, so total charge is conserved.

The U(1) gauge symmetry of QED is here the discrete `+` ↔ `−` swap symmetry: any history with the gauge-fold counts exchanged remains ZFA-closed (the global sign of the charge is conventional). The conserved current = the net gauge fold count, which is exactly the QED electric charge in units of $e$.

## 5. Unitarity / probability

From [Hermitian_Conjugacy_Proof.md](Hermitian_Conjugacy_Proof.md): the sequential composition of an event with its Hermitian conjugate yields ZFA (the Void/Identity). This is the QLF realization of $U U^\dagger = I$ — unitary evolution preserves the norm of the state vector.

Equivalently from [Born_Rule.md](Born_Rule.md): the squared-modulus probability assignment $|A|^2$ is the unique bilinear form consistent with the Hermitian-conjugate symmetry. Probability is conserved because the underlying algebra is Hermitian, and the Hermitian symmetry is preserved at every ZFA closure.

`bra_ket_always_balanced` ([BraKetRhoQuCalc.lean:109](lean/BraKetRhoQuCalc.lean)) is the Lean-verified statement: it is algebraically impossible to construct a ZFA-unbalanced RhoProcess, so unitarity violation is not in the space of constructible objects.

## 6. Information (the per-atom ledger)

A novel addition that standard Noether does not have: in QLF, **information itself is a conserved quantity** at the per-event level.

Each ZFA closure releases $\log 2$ nats to the local possibility tree ([MRE.md §2.1](MRE.md)), and each annihilation event releases the same $\log 2$ nats back to the vacuum as massless quanta ([Annihilation.md §3](Annihilation.md)). The total information ledger across creation + annihilation is exactly zero per atom — created and released bits cancel.

The conserved current is the **per-event log-2 bookkeeping**: the difference between information gained and released, summed over all closures in a process, is zero for any ZFA-balanced trajectory. This is the QLF answer to the **black hole information paradox**: Hawking radiation is the topological release of the gauge-fold information that was held inside the constructing delay, returned bit-for-bit to the environment ([Entropy.md §1a](Entropy.md), [Annihilation.md §4.4](Annihilation.md)).

## 7. CPT (combined chirality + parity + time reversal)

[CP-Violation-and-Chirality.md](CP-Violation-and-Chirality.md) develops the partial-symmetry story: individual C, P, T symmetries are violated by the residual-clustering dynamics that gave matter its dominance. The **combined CPT symmetry**, however, is exact in QLF: the full chirality reflection (swap LH ↔ RH globally, reverse time, conjugate every twist) maps any admissible history to its Hermitian conjugate, which is also admissible.

CPT conservation is the global statement of unitarity (§5): every QLF event has a CPT-conjugate that is also a valid event, with exactly the symmetric branching probabilities. The Sakharov conditions for matter dominance (CP violation + baryon number violation + departure from equilibrium) are satisfied by the residual-clustering dynamics without requiring CPT violation.

## 8. What is NOT (yet) derived

QLF does not yet provide constructive derivations of:

- **Baryon number conservation** — partially derived: composite hadron blankets ([Hadrons_Markov_Blankets.md](Hadrons_Markov_Blankets.md)) have a quantized topological-winding number. A clean Noether-style derivation tying this to a specific 8-twist symmetry is open work.
- **Lepton number conservation** — similar; tied to the electron's RH fluxoid structure ([Atom.md](Atom.md), [Majorana_Beta_Decay.md](Majorana_Beta_Decay.md)). Open.
- **Color SU(3) confinement** — requires the Borromean three-quark topology to be derived as the unique stable closure under a specific symmetry. Open.
- **Weak SU(2) doublet structure** — requires a specific 8-twist subgroup to be identified as the weak gauge group. Open.

These are the standard-model gauge-group identifications. The QLF claim is that each will follow from a specific 8-twist symmetry once the identification is worked out; the current document establishes the **methodology** (every ZFA-preserving symmetry → conservation law) without committing to specific identifications for the weak/strong sectors.

## 9. Open work

- **Lean theorem**: `noether_zfa_symmetry_yields_conservation` formalizing the §1 statement.
- **Numerical demo**: extend `path_integral.py` to log conserved quantities (energy, momentum, charge, information) along ZFA-closure trajectories and verify constancy.
- **Standard-model identifications**: complete the gauge-group derivations listed in §8.
- **Discrete Noether vs continuous Noether**: formalize the bridge between QLF's discrete symmetries and standard Lie-group continuous symmetries in the continuum limit.

## References

### Internal

- [Energy_Combinatorics.md](Energy_Combinatorics.md) — energy as multiplicity of histories
- [E_mc2_derivation.md](E_mc2_derivation.md) — mass-energy equivalence via gauge-fold constructing delay
- [Hermitian_Conjugacy_Proof.md](Hermitian_Conjugacy_Proof.md) — unitarity as `E + E† ≡ ZFA`
- [Annihilation.md](Annihilation.md) — per-atom information bookkeeping (creation + annihilation cancel)
- [MRE.md](MRE.md) — per-event $\log 2$ quantum, the information ledger
- [Maxwell.md](Maxwell.md) — charge conservation; `no_magnetic_monopoles`
- [Lagrangian_Formulation.md](Lagrangian_Formulation.md) — Σ₈ algebra, `tau_xy_product` etc.
- [HALF-SPIN-ZFA-EMBEDDING.md](HALF-SPIN-ZFA-EMBEDDING.md) — angular momentum from spinor structure
- [CP-Violation-and-Chirality.md](CP-Violation-and-Chirality.md) — partial-symmetry violations; CPT exactness
- [Entropy.md](Entropy.md) — information conservation across Hawking radiation
- [Born_Rule.md](Born_Rule.md) — probability conservation as Hermitian-symmetry consequence
- [Frequency_Synchronization.md](Frequency_Synchronization.md) — time-translation symmetry at the algebra level

### External

- Noether, E. (1918). *Invariante Variationsprobleme.* Nachr. d. König. Gesellsch. d. Wiss. zu Göttingen — original symmetry/conservation theorem.
- Wigner, E. P. (1939). *On unitary representations of the inhomogeneous Lorentz group.* Ann. Math. 40, 149 — symmetry classification of particles.
- Sakharov, A. D. (1967). *Violation of CP invariance, C asymmetry, and baryon asymmetry of the universe.* JETP Letters 5, 24 — conditions for matter dominance under approximate symmetries.
- 't Hooft, G. (1971). *Renormalizable Lagrangians for massive Yang-Mills fields.* Nucl. Phys. B 35, 167 — gauge-symmetry approach to the standard model.
