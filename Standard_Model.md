# The Standard Model from QLF (honest synthesis)

**The Standard Model's particles, interactions, and conservation laws are claimed to follow from the 8-twist algebra plus ZFA closure plus Hermitian-pair structure.** This document is the **honest** version of that claim: what QLF actually derives today, what is a partial sketch with structural plausibility, and what is open work without even a clear path forward.

The structure follows [Conservation.md §8](Conservation.md) (the "what is NOT yet derived" list) but expands the positive content and provides a map of all the pieces.

## 1. The honest scoreboard

| Sector | What QLF says | Status |
|---|---|---|
| **Spin-1/2 algebra (Pauli, Dirac)** | Derived from 8-twist Pauli mapping ([HALF-SPIN-ZFA-EMBEDDING.md](HALF-SPIN-ZFA-EMBEDDING.md), [Lagrangian_Formulation.md](Lagrangian_Formulation.md)) | ✓ Derived; machine-verified `tau_xy_product` etc. |
| **Electron** (mass, charge, spin) | `^<` or `^<v>` chiral fluxoid; mass from gauge fold; charge from gauge-fold parity ([Electron.md](Electron.md), [Atom.md](Atom.md)) | ✓ Structurally derived; mass *ratio* to other leptons is open |
| **Photon** (massless, spin 1) | Pure spatial fold `^>` or `^v` with no gauge folds ([Electron.md §2](Electron.md), [Particles.md](Particles.md)) | ✓ Derived |
| **Neutrino** (left-handed, gauge-only) | `^-v+` (gauge-dominant, spatially non-chiral loop) — neutrino is **Dirac** (`ν ≠ ν̄`, distinguished by lepton count) per [Beta_Decay_Neutrino_Nature.md](Beta_Decay_Neutrino_Nature.md) | ✓ Structural derivation; predicts **no 0νββ** (`B−L` exact), experimentally tested (all null) |
| **Proton, neutron** (Borromean three-quark) | Three open quarks interlocked under Borromean topology ([Hadrons_Markov_Blankets.md](Hadrons_Markov_Blankets.md), [HadronicDepth.md](HadronicDepth.md)) | ✓ Structural derivation; mass quantitative match open |
| **Quark confinement** | Quarks are fractional ZFA (cannot exist as isolated unforgeable names) — must group in pairs/triples to form stable composite blankets | ✓ Qualitative derivation; quantitative confinement scale open |
| **U(1) electromagnetic** | `+` ↔ `−` gauge swap symmetry of the 8-twist algebra ([Conservation.md §4](Conservation.md), [Maxwell.md](Maxwell.md)) | ✓ Derived; charge conservation Lean-verified via `no_magnetic_monopoles` |
| **Higgs mechanism** | Gauge folds create constructing delay $\Delta t = R/f$ which manifests as rest mass ([Higgs.md](Higgs.md), [Frequency_Synchronization.md](Frequency_Synchronization.md), [E_mc2_derivation.md](E_mc2_derivation.md)) | ⚠ Partial — explains *why* mass exists, not specific Higgs particle mass |
| **CP violation** | Residual clustering of LH/RH topology in the early universe ([CP-Violation-and-Chirality.md](CP-Violation-and-Chirality.md), [Annihilation.md §5](Annihilation.md)) | ⚠ Partial — qualitative; CKM matrix angles open |
| **Generation structure (3 lepton families, 6 quarks)** | Higher-order resonant harmonics of primordial split ([Primordial_Entanglement.md §2](Primordial_Entanglement.md), [Particles.md §3](Particles.md)) | ⚠ Partial — structural reason for "more than one", specific generation count open |
| **Strong SU(3) confinement** | Borromean three-element topology is the unique stable three-body closure | ⚠ Partial — SU(3) gauge group identification open |
| **Weak SU(2) doublets** | Pair-grouping under chirality — left-handed particles in SU(2) doublets, right-handed in singlets ([Beta_Decay_Neutrino_Nature.md](Beta_Decay_Neutrino_Nature.md), [Weak_Force.md](Weak_Force.md)) | ⚠ Partial — **Lie-algebra identification machine-verified** (`weak_isospin_su2`: the Σ₈ τ-subalgebra carries `[τᵢ,τⱼ]=−2εᵢⱼₖτₖ`, su(2)≅so(3); `Q₈⊂SU(2)`); doublet representation, coupling `g`, and W/Z masses open |
| **Baryon number conservation** | Topological winding number of composite blankets | ⚠ Partial — Noether-style derivation open |
| **Lepton number conservation** | Chiral fluxoid count of electron-type structures | ⚠ Partial — same |
| **Sterile neutrino** | Would require pure-`+` or pure-`-` gauge sequence with no spatial twists | ✗ Open — experimental status unsettled; QLF predicts a specific topology if it exists |
| **Specific lepton mass ratios** ($m_\mu / m_e \approx 207$, $m_\tau / m_e \approx 3477$) | Would follow from the multiplicity ratios at successive resonant harmonics | ✗ Open — no quantitative prediction yet |
| **CKM matrix angles, neutrino mixing** | Would follow from the chirality-rotation structure between generations | ✗ Open |
| **Dark matter sector** | Possibly a class of stable ZFA closures with no `+`–`−` content (no EM coupling) — see [DarkMatter.md](DarkMatter.md) | ✗ Open — qualitative speculation |

**Summary**: roughly 8 derived, 6 partial, 4 fully open. The framework is structurally rich but most quantitative numbers remain to be extracted.

## 2. The derived sector

### 2.1 Spinor algebra and the spin-1/2 carriers

The 8-twist alphabet's quaternionic Σ₈ algebra (`τ_i τ_j = -δ_{ij} I - ε_{ijk} τ_k`, with `τ_i = i σ_i`) is machine-verified in `lean/BraKetRhoQuCalc.lean` via `tau_xy_product`, `tau_yz_product`, `tau_zx_product`. The Pauli algebra it generates is the algebra of spin-1/2, exactly. See [Lagrangian_Formulation.md](Lagrangian_Formulation.md) for the full statement.

The 1/2-spin atom of [MRE.md](MRE.md) is the smallest carrier of this algebra; every Standard Model fermion is built from parallel compositions of these atoms.

### 2.2 Electron, photon, neutrino

From [Electron.md](Electron.md) and [Particles.md](Particles.md):

- **Electron** `^<` (or compositely `^<v>`) — chiral fluxoid that gauge-folds; carries mass via the constructing delay and charge via the gauge parity.
- **Photon** `^>` (or `^v`) — pure spatial fold with no gauge folds; massless; carries no charge; the canonical massless quantum.
- **Neutrino** `^-v+` — gauge-dominant loop; no transverse spatial extent; nearly non-interacting; spatially non-chiral but **Dirac** — its conjugate antineutrino is distinguished by the opposite lepton count, so `B−L` is exactly conserved and QLF predicts **no 0νββ** (per [Beta_Decay_Neutrino_Nature.md](Beta_Decay_Neutrino_Nature.md) §1).

These three are the directly derived light particles. Positron, anti-photon, anti-neutrino follow by Hermitian conjugation ([Annihilation.md §2](Annihilation.md)).

### 2.3 Proton, neutron, and quark confinement

From [Hadrons_Markov_Blankets.md](Hadrons_Markov_Blankets.md): three quarks interlock via Borromean topology to form a closed Markov blanket — the proton. Each quark individually has fractional ZFA (it leaks free action) so cannot exist as an isolated unforgeable name; only the Borromean triple is stable.

This is the QLF derivation of quark confinement. The strong-force binding scale is open work but the structural reason for confinement is built into the algebra.

### 2.4 U(1) electromagnetism, charge conservation

From [Maxwell.md](Maxwell.md) and [Conservation.md §4](Conservation.md): the gauge pair `+` / `−` is the carrier of charge. The U(1) gauge symmetry is the `+` ↔ `−` swap symmetry of the 8-twist algebra; charge conservation is Lean-verified as `no_magnetic_monopoles` (ZFA closure forces net gauge count = 0 per closed event; for non-neutral systems the count is constant because gauge folds are created/destroyed only in Hermitian pairs).

## 3. The partial sector

### 3.1 Higgs mechanism

From [Higgs.md](Higgs.md): mass is the constructing delay accumulated inside a gauge-folded Markov blanket. The Higgs field, in QLF, is the vacuum's gauge-fold density — the property of the vacuum that determines how much delay each particle accumulates per ZFA closure.

**What's derived**: gauge folds → mass. Why some particles are massive (have gauge folds) and others (photon) are massless.

**What's open**: the specific Higgs particle (a separate boson) with the observed 125 GeV mass; the Yukawa coupling structure that gives different fermions different masses; the Higgs potential's vacuum expectation value.

### 3.2 CP violation and matter dominance

From [CP-Violation-and-Chirality.md](CP-Violation-and-Chirality.md) and [Annihilation.md §5](Annihilation.md): in a perfectly balanced universe all matter would annihilate. The residual matter dominance arises from slight clustering bias: clusters of one chirality (LH or RH) have thicker Markov-blanket boundaries that out-replicate the boundary annihilation rate, becoming topological attractors.

**What's derived**: why matter survives. The mechanism is consistent and demonstrated in `cp_violation_sim.py`.

**What's open**: the specific CP-violating phase angles in the CKM matrix; the matter/antimatter ratio quantitative match to the observed $\sim 10^{-9}$ baryon-to-photon ratio.

### 3.3 Generations of matter

From [Primordial_Entanglement.md §2](Primordial_Entanglement.md) and [Particles.md §3](Particles.md): if a primordial split doesn't immediately close at length $N=4$ due to environmental pressure, it is forced into higher-order resonance to achieve ZFA: $N=8$ (muon family), $N=12$ (tau family).

**What's derived**: why there are multiple generations; the structural reason for the resonant-harmonic hierarchy.

**What's open**: why exactly **three** generations and not two or four; the specific mass ratios $m_\mu / m_e \approx 207$, $m_\tau / m_\mu \approx 16.8$; the lepton-quark mass-ratio correlation across generations.

### 3.4 Strong SU(3) and weak SU(2) groups

From [Hadrons_Markov_Blankets.md](Hadrons_Markov_Blankets.md) and [Beta_Decay_Neutrino_Nature.md](Beta_Decay_Neutrino_Nature.md): the strong force is the Borromean three-quark binding; the weak force is the gauge-fold pair-flip that mediates beta decay.

**What's derived**: the structural reason for confinement (SU(3)-like three-element grouping) and for chirality-mediated weak interactions (SU(2)-like doublet structure). **Both gauge Lie algebras are now machine-verified** as the symmetry of the three spatial axes: the **weak SU(2)** is the Σ₈ τ-subalgebra (`[τᵢ,τⱼ] = −2εᵢⱼₖτₖ`, `Q₈ ⊂ SU(2)` — `weak_isospin_su2`), and the **strong SU(3)** is the traceless part of the 3×3 directional tensor (closed under the bracket and non-abelian — `trace_commutator_zero` + `gluon_commutator_nonzero` in [`lean/QLF_StrongAlgebra.lean`](lean/QLF_StrongAlgebra.lean)). With `U(1)` (`no_magnetic_monopoles`), all three SM gauge algebras are verified, with dimensions `1 + 3 + 8 = 12` (`1 + 8 = 9 = N`, the α tensor) — see [`Forces_From_Three_Axes.md`](Forces_From_Three_Axes.md).

**What's open**: the SU(2) **doublet representation** and coupling `g`; the `SU(3)` `finrank = 8` count (elementary codim-1, not yet a Lean theorem); matching the gauge-boson masses ($W^\pm$, $Z^0$, gluons); the running of the coupling constants (asymptotic freedom).

## 4. The fully open sector

### 4.1 Quantitative mass spectrum

Standard Model masses span 11 orders of magnitude (neutrino at <1 eV, electron at 511 keV, top quark at 173 GeV). QLF says mass comes from gauge-fold constructing delay; the specific delay values for each particle type are open.

Conjectured path: the multiplicity-as-energy framework of [Energy_Combinatorics.md](Energy_Combinatorics.md) plus the topological resonance counting of [HadronicDepth.md](HadronicDepth.md).

**One quantitative handle now exists (charged leptons).** The Koide relation `Q = (m_e+m_μ+m_τ)/(√m_e+√m_μ+√m_τ)² = 2/3` holds to 0.0009%, and its `2/3` is now **machine-verified** as forced by `N=3` (three spatial axes) ∧ `A²=2` (two transverse axes) — `koide_two_thirds` in [lean/QLF_Koide.lean](lean/QLF_Koide.lean), the same `2 transverse + 1 longitudinal` split as the transverse fraction. Given `Q=2/3`, `m_e, m_μ` **predict** `m_τ = 1776.97 MeV` (measured 1776.86, **0.006%**). What remains an input: the lepton-√mass↔axis-phase *identification*, the Koide angle, and the overall scale. See [Weak_Force.md](Weak_Force.md) §5a–5b and [koide_tau_demo.py](koide_tau_demo.py). The quark sector is still open.

### 4.2 Mixing matrices (CKM, PMNS)

The CKM matrix encodes quark mixing across generations; PMNS encodes neutrino mixing. Both have specific angle structures whose origin is unexplained in standard physics.

Conjectured path: chirality-rotation between generations under the resonant-harmonic hierarchy. Open.

### 4.3 Sterile neutrino, fourth generation, exotic particles

QLF makes no specific prediction for exotic-sector existence beyond the three known generations. Experiments would constrain QLF's resonance structure at higher $N$.

### 4.4 Dark matter, dark energy

From [DarkMatter.md](DarkMatter.md): dark matter may be a class of stable ZFA closures with no `+`–`−` gauge content (and hence no electromagnetic coupling). Speculative.

Dark energy = cosmological constant residual per [Quantum_Gravity.md §5](Quantum_Gravity.md). Qualitatively explained, quantitatively open.

## 5. Why the partials and opens matter

QLF claims to be a discrete substrate from which the Standard Model emerges. Until the partials become derivations and the opens become predictions, the claim is **structurally promising but quantitatively unverified**. The same standard that [Experimental_Consistency.md](Experimental_Consistency.md) applies to fundamental constants applies here: positive structural derivations (§2) are real progress; partial sketches (§3) are research targets; full opens (§4) are honest gaps.

The path forward is to:
1. Pick a single partial item and convert it to a derivation (e.g., the SU(3) confinement scale, which has the most-developed structural account).
2. Extend the numerical demos (`particles.py`, `path_integral.py`, `constants_mapper.py`) to enumerate the resonance hierarchy and check whether the multiplicity-counting reproduces lepton mass ratios.
3. Add a Lean theorem `standard_model_particles_are_zfa_closures` for the derived sector (§2) — even at this scope it would be a substantive formalization.

## 6. Open work

- **Lean theorem**: `standard_model_particles_are_zfa_closures` formalizing the §2 derivations.
- **Numerical demo**: enumerate atomic-system closures via `path_integral.py` (per [`Bound_States_QLF.md`](Bound_States_QLF.md), free-lepton ratios are not the natural QLF observables — atomic-system masses are). Targets: positronium, muonium, hydrogen.
- **Gauge-group identification**: identify the specific SU(3), SU(2), U(1) subgroups of the 8-twist algebra in Lean. The U(1) is done (`no_magnetic_monopoles` already encodes it); SU(2) and SU(3) are open.
- **Mass ratios from multiplicity**: scoped per [`Bound_States_QLF.md`](Bound_States_QLF.md) to atomic-system masses (positronium 1.022 MeV, muonium 106.17 MeV, hydrogen 938.78 MeV). [`Atomic_System_QLF_Closures.md`](Atomic_System_QLF_Closures.md) writes out the joint-closure mapping for each atomic system and derives the Bohr reduced-mass scaling `E(Mu)/E(Ps) ≈ 2`, `E(H)/E(Mu) ≈ 1`. The per-qubit reading [`Per_Qubit_Mass_Quantum.md`](Per_Qubit_Mass_Quantum.md) gives `m_qubit c² = ℏω = E_Planck / R_qubit` and reproduces all measured mass ratios via `m_X/m_Y = R_Y/R_X` exactly. α is now numerically anchored at 10⁻¹⁰ via the QLF Bohr inversion `α = sqrt(2 R_e / R_1)` ([`Hydrogen.md`](Hydrogen.md) §4.1, [`fine_structure_demo.py`](fine_structure_demo.py)). The open piece is the first-principles derivation of the depth `R_e ≈ 2.4 × 10²²` from QLF closure-multiplicity, which under the unit identification would derive `α R_e = m_e` independently of the measured Ry and m_e inputs.
- **Mixing angles from chirality rotation**: develop the structural account into a quantitative prediction.
- **Higgs particle**: distinguish the Higgs *field* (vacuum gauge-fold density, qualitatively derived) from the Higgs *boson* (excitation of that field, observed at 125 GeV); derive the boson mass.

## References

### Internal

- [Particles.md](Particles.md) — particle-as-unforgeable-name framing; electron/neutrino derivations
- [Electron.md](Electron.md) — electron and photon worked examples
- [Higgs.md](Higgs.md) — mass-generation via gauge folds
- [Beta_Decay_Neutrino_Nature.md](Beta_Decay_Neutrino_Nature.md) — chirality, the Dirac neutrino (no 0νββ), beta decay
- [Hadrons_Markov_Blankets.md](Hadrons_Markov_Blankets.md) — Borromean three-quark topology for hadrons
- [HadronicDepth.md](HadronicDepth.md) — hadronic resonance hierarchy
- [CP-Violation-and-Chirality.md](CP-Violation-and-Chirality.md) — CP violation and matter dominance
- [HALF-SPIN-ZFA-EMBEDDING.md](HALF-SPIN-ZFA-EMBEDDING.md) — spin-1/2 set-theoretic embedding
- [Lagrangian_Formulation.md](Lagrangian_Formulation.md) — Σ₈ algebra; Lean-verified spinor structure
- [MRE.md](MRE.md) — 1/2-spin atom as the smallest carrier of the algebra
- [Atom.md](Atom.md) — LH proton / RH electron assignment
- [Maxwell.md](Maxwell.md) — U(1) electromagnetism; charge conservation
- [Conservation.md](Conservation.md) — Noether-style derivations; §8 what is NOT yet derived
- [Frequency_Synchronization.md](Frequency_Synchronization.md) — gauge folds create mass
- [E_mc2_derivation.md](E_mc2_derivation.md) — mass-energy equivalence
- [Energy_Combinatorics.md](Energy_Combinatorics.md) — multiplicity as energy
- [Annihilation.md](Annihilation.md) — Hermitian-pair structure; CP residual
- [DarkMatter.md](DarkMatter.md) — speculative dark-matter framing
- [Quantum_Gravity.md](Quantum_Gravity.md) — dark energy as cosmological-constant residual
- [Primordial_Entanglement.md](Primordial_Entanglement.md) — primordial split → generations of matter
- [eight-twists-sufficiency.md](eight-twists-sufficiency.md) — 8 twists as complete generative kernel
- [Experimental_Consistency.md](Experimental_Consistency.md) — falsifiability framework

### External

- Glashow, S. L. (1961). *Partial-symmetries of weak interactions.* Nucl. Phys. 22, 579 — electroweak unification.
- Weinberg, S. (1967). *A model of leptons.* Phys. Rev. Lett. 19, 1264 — Standard Model.
- Salam, A. (1968). *Weak and electromagnetic interactions.* In *Elementary Particle Theory* (Almqvist).
- 't Hooft, G. (1971). *Renormalizable Lagrangians for massive Yang-Mills fields.* Nucl. Phys. B 35, 167 — renormalization of gauge theories.
- Peskin, M. E., Schroeder, D. V. (1995). *An Introduction to Quantum Field Theory.* Westview Press — canonical reference.
- Workman, R. L. et al. (Particle Data Group) (2024). *Review of Particle Physics.* Prog. Theor. Exp. Phys. 2024, 083C01 — current experimental status.
