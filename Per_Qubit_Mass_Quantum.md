# Per-Qubit Mass Quantum: each qubit contributes ℏω to rest energy

**Each qubit contributes `ℏω` of rest energy to the particle or bound-state mass.** This is the QLF per-qubit mass-energy quantum, parallel to the per-event `log 2` information quantum of [`MRE.md`](MRE.md). Combined with the Markov-blanket depth relation `ω = f_vac / R` of [`Frequency_Synchronization.md`](Frequency_Synchronization.md), it gives the explicit formula

$$m_{\text{qubit}} \, c^2 \;=\; \hbar \omega_{\text{qubit}} \;=\; \frac{\hbar \, f_{\text{vac}}}{R_{\text{qubit}}} \;=\; \frac{E_{\text{Planck}}}{R_{\text{qubit}}}$$

where `R_qubit` is the qubit's Markov-blanket depth (in QLF natural units, where each "Planck event" is one unit of depth and `E_Planck = ℏ × f_vac` is the corresponding energy quantum).

Particles and bound states are then **sums over their constituent qubits**:

$$m_{\text{particle}} \, c^2 \;=\; \sum_{\text{qubits } i} \hbar \omega_i \;=\; \sum_i \frac{E_{\text{Planck}}}{R_i}$$

This principle unifies and clarifies several earlier QLF formulations:

- [`Higgs.md`](Higgs.md) §2 wrote `m = α R` with `α` a unit-conversion factor. The per-qubit reading clarifies: `α = ℏ ω_per_qubit / R_per_qubit = E_Planck / R²_per_qubit` in QLF natural units, so the implicit per-qubit structure is now explicit.
- [`Atomic_System_QLF_Closures.md`](Atomic_System_QLF_Closures.md) §1 wrote `m_bound = α (R_A + R_B)` for joint closures. Under the per-qubit reading this becomes `m_bound = ℏω_A + ℏω_B` — masses add directly, each constituent contributing its own ℏω.
- [`Frequency_Synchronization.md`](Frequency_Synchronization.md) wrote `Δt = R / f`. The per-qubit reading identifies `ω = 1/Δt = f/R` as the qubit's internal clock frequency, with mass = ℏω.

---

## §1 Numerical check across measured particles

Computing the implied Markov-blanket depth `R = E_Planck / (m c²)` from measured masses:

| Particle | Measured mass | Implied `R` |
|---|---|---|
| Electron | 0.5110 MeV | `2.389 × 10²²` |
| Muon | 105.66 MeV | `1.155 × 10²⁰` |
| Proton | 938.27 MeV | `1.301 × 10¹⁹` |
| Tau | 1776.86 MeV | `6.871 × 10¹⁸` |

Mass ratios from depth ratios (the per-qubit formula `m_X/m_Y = R_Y/R_X`):

| Ratio | Predicted from R | Measured | Match |
|---|---|---|---|
| `m_p / m_e` | `R_e / R_p = 1836.15` | 1836.15 | ✓ exact |
| `m_μ / m_e` | `R_e / R_μ = 206.77` | 206.77 | ✓ exact |
| `m_τ / m_μ` | `R_μ / R_τ = 16.82` | 16.82 | ✓ exact |

These are not derivations of `m_e` from QLF — the depths `R_X` are themselves identified from measured masses. The match is structural: the per-qubit formula `m = ℏω` is mathematically equivalent to the Compton relation. What QLF adds is the interpretation: each ω is the inverse Markov-blanket-depth of one constituent qubit, and total mass adds over constituent qubits.

---

## §2 Atomic-system masses as constituent-qubit sums

Under the per-qubit reading, the atomic-system mappings of [`Atomic_System_QLF_Closures.md`](Atomic_System_QLF_Closures.md) become explicit qubit sums:

### Positronium (2 qubits, both electron-class)

$$m(\text{Ps}) \, c^2 \;=\; \hbar\omega_e + \hbar\omega_{e^+} \;=\; 2 \hbar\omega_e \;=\; 2 m_e c^2 \;=\; 1.022\,\text{MeV} \quad \checkmark$$

The two constituents have identical Markov-blanket depths (`R_e = R_{e^+}` by CPT), each contributing `ℏω_e = m_e c²` to the bound-state mass.

### Muonium (1 electron qubit + 1 muon qubit, asymmetric)

$$m(\text{Mu}) \, c^2 \;=\; \hbar\omega_e + \hbar\omega_\mu \;=\; m_e c^2 + m_\mu c^2 \;=\; 106.17\,\text{MeV} \quad \checkmark$$

The two qubits have different Markov-blanket depths (`R_μ = R_e / 206.77`), each contributing its own `ℏω` to the total.

### Hydrogen (1 electron qubit + proton-internal qubits)

$$m(\text{H}) \, c^2 \;=\; \hbar\omega_e + \hbar\omega_{\text{p-internal}} \;=\; m_e c^2 + m_p c^2 \;=\; 938.78\,\text{MeV} \quad \checkmark$$

The proton is a composite of three quarks plus their QCD-like gluonic gauge folds; under the per-qubit reading the proton contributes one effective "proton qubit" at depth `R_p ≈ 1.30 × 10¹⁹`, or equivalently three quark qubits at sub-proton depths whose sum is the proton mass. The bound-state mass is the electron-qubit plus proton-qubit contributions.

### General atomic system

For any atomic system with constituent qubits `{i}`:

$$m_{\text{atomic system}} \, c^2 \;=\; \sum_{i \in \text{constituents}} \hbar \omega_i \;-\; E_{\text{bind}}$$

where the binding energy `E_bind` is the joint-closure correction (typically `≪ m c²`, e.g., `≈ 10⁻⁸` for hydrogen).

---

## §3 Why this is a useful structural step

The per-qubit reading does not constitute a first-principles derivation of `m_e` (the `R_e` value is still identified from measured `m_e`). But it **clarifies the framework** in three ways:

### 3.1 The mass-additivity structure becomes explicit

Under `m = αR` with R interpreted as "total gauge-fold depth," the addition of masses in bound states is hidden: positronium's `R(Ps) = 2 R_e` looks like it could be a derivation. Under the per-qubit reading, `m(Ps) = m_e + m_e` is **manifestly** a sum of two qubit contributions, each with `m_{\text{qubit}} = ℏω_e`. The combinatorial structure of bound states is exposed.

### 3.2 The Compton relation is recovered

Each qubit's mass `m_{\text{qubit}} = ℏω_{\text{qubit}}` is the Compton relation `E = ℏω`. This is the standard quantum-mechanical mass-frequency identity, recovered here with the additional QLF interpretation: `ω` is the inverse of the qubit's Markov-blanket depth.

### 3.3 The first-principles derivation question becomes sharper

The open question "derive `m_e` from QLF closure-multiplicity" is now:

> **Derive `R_e`** (the electron qubit's Markov-blanket depth, `R_e ≈ 2.389 × 10²²` in Planck units) **from QLF closure-multiplicity counts** — i.e., from the combinatorial structure of the 8-twist alphabet, ZFA closure, and the per-event `log 2` quantum.

This is a cleaner statement of the open problem than "derive `α R_e = m_e`" because:
- `α` is now `E_Planck` (Planck energy quantum), a defined unit rather than a fitted parameter.
- `R_e` is a single integer-valued depth, not a depth-times-conversion product.
- The target is a specific large number (`≈ 2.4 × 10²²`), constraining what kind of combinatorial argument could produce it.

The empirical results of [`Electron_Mass_Derivation.md`](Electron_Mass_Derivation.md) §4 (Path A and Path C falsifications) constrain the search further: neither a same-depth weighted-multiplicity ratio nor a fixed-depth gauge-class ratio yields the right scaling. The right derivation must involve depth-as-mass scaling (depth `≈ 10²²` is far beyond any tractable BFS enumeration) plus a structural argument for why the electron's specific Markov-blanket sits at that depth.

---

## §4 Connection to per-event log-2 quantum

The per-qubit mass quantum and the per-event information quantum of [`MRE.md`](MRE.md) §2.1 are dual sides of the same QLF accounting:

| Per event (information) | Per qubit (mass-energy) |
|---|---|
| `ΔI = log 2` nats | `m c² = ℏω` |
| Per ZFA closure event | Per Hermitian-pair (half-spin) qubit |
| Binary-partition saturation | Compton-relation mass-frequency |
| Lean-anchored: `zfa_closure_minimizes_free_energy` | Open: `qubit_mass_is_hbar_omega` (proposed) |

Each ZFA closure event reduces free energy by exactly `log 2` nats; each constituent qubit contributes exactly `ℏω` of rest energy. Together they constitute the QLF natural-units accounting: information in nats per event, energy in Planck units per qubit.

---

## §5 What is now derived, what is still open

| Item | Status |
|---|---|
| Per-qubit mass quantum `m_qubit c² = ℏω` | ✓ Derived structurally (Compton relation, re-interpreted as per-qubit in QLF) |
| Atomic-system mass additivity `m_bound = Σ ℏω_i` | ✓ Derived (this doc §2) |
| Mass ratios `m_p/m_e = 1836`, etc. from `R_e/R_p` | ✓ Consistent (this doc §1) — but R values are identified from measured masses, not derived |
| First-principles derivation of `R_e` from QLF closure-multiplicity | ✗ Open (this doc §3.3) — natural reformulation of `α R_e = m_e` problem |
| τ as decay-vertex closure | ⚠ Sketched ([`Atomic_System_QLF_Closures.md`](Atomic_System_QLF_Closures.md) §6, [`Bound_States_QLF.md`](Bound_States_QLF.md) §4) |
| Lean theorem `qubit_mass_is_hbar_omega` | ✗ Open |
| Connection to Bohr binding energies via reduced-mass formula | ✓ Derived ([`Atomic_System_QLF_Closures.md`](Atomic_System_QLF_Closures.md) §5) |

---

## §6 What this is NOT

- **Not a first-principles derivation of `m_e`.** The depth `R_e ≈ 2.4 × 10²²` is identified from measured `m_e`, not derived. The per-qubit principle gives the *form* of the relation `m = ℏω`; it does not derive the specific `ω_e`.
- **Not a new physics claim.** `m = ℏω` is the standard Compton relation. The QLF contribution is the interpretation: each "qubit" is a half-spin Hermitian pair with its own Markov-blanket depth determining its ω.
- **Not a replacement for the Higgs mechanism.** Per [`Higgs.md`](Higgs.md), the gauge-fold-depth `R` is the QLF analog of the Higgs Yukawa coupling. The per-qubit reading is consistent with this; it just makes the per-qubit decomposition explicit.
- **Not a unification of all mass.** Pure-spatial closures (photons) have `R → ∞` (or zero gauge-fold depth) and contribute no `ℏω` to mass — consistent with `m_photon = 0`. The principle applies to massive qubits with finite gauge-fold-depth, not to massless closures.

---

## §7 Open work

- **First-principles derivation of `R_e`** from QLF closure-multiplicity. The specific large number `R_e ≈ 2.389 × 10²²` is what the eventual derivation must produce. Combined with [`Electron_Mass_Derivation.md`](Electron_Mass_Derivation.md) §4 Path A and Path C falsifications, the search is now substantially constrained — no fixed-depth-multiplicity argument can produce a number this large; the right derivation must involve large-depth structural arguments or MRE-cost-weighted enumeration.
- **Lean theorem `qubit_mass_is_hbar_omega`.** Formalise the per-qubit mass quantum as a Lean theorem connecting half-spin ZFA atoms (in [`lean/QLF_Pauli.lean`](lean/QLF_Pauli.lean) and [`lean/QLF_TwistAlphabet.lean`](lean/QLF_TwistAlphabet.lean)) to a per-atom rest energy. The Compton-relation structure is well-known; the QLF Lean formalization would establish it as a consequence of `rho_process_always_zfa` and the per-event log-2 quantum.
- **Quark-qubit decomposition of the proton.** The proton mass-energy decomposes as three quark qubits + gluonic-gauge-fold contributions. Pinning the exact decomposition (current quark masses vs. QCD binding) requires connecting QLF to the gauge-fold-depth content of QCD.
- **τ-decay-vertex per-qubit accounting.** The τ has no stable atomic system; its mass-energy is the integrated `ℏω_τ` of the decay-vertex closure. A specific decay-channel topology that closes at `m_τ c² = ℏω_τ` is open work.
- **Heavier atomic systems.** Each heavier bound state (deuterium, helium, pionium, ...) adds constituent qubits — the per-qubit principle predicts their masses as sums of constituent `ℏω`'s.

---

## References

### Internal

- [`Bound_States_QLF.md`](Bound_States_QLF.md) — free leptons are not QLF observables; atomic systems are.
- [`Atomic_System_QLF_Closures.md`](Atomic_System_QLF_Closures.md) — joint-closure topologies for positronium, muonium, hydrogen; mass-additivity now made explicit via the per-qubit principle.
- [`Electron_Mass_Derivation.md`](Electron_Mass_Derivation.md) — scope and gaps for the first-principles derivation of `R_e`. Paths A and C falsified in their simple forms.
- [`Frequency_Synchronization.md`](Frequency_Synchronization.md) — `Δt = R/f`; the per-qubit reading identifies `ω = 1/Δt` as the qubit's internal frequency.
- [`Higgs.md`](Higgs.md) — `m = αR` framework; the per-qubit reading clarifies the implicit per-qubit structure.
- [`MRE.md`](MRE.md) — per-event `log 2` quantum; dual to the per-qubit `ℏω` mass quantum.
- [`HALF-SPIN-ZFA-EMBEDDING.md`](HALF-SPIN-ZFA-EMBEDDING.md) — each qubit is a half-spin ZFA atom (Hermitian pair); the unit of mass-energy accounting.
- [`Electron.md`](Electron.md) — electron half-loop as one qubit's contribution to a joint bound state.
- [`Hadrons_Markov_Blankets.md`](Hadrons_Markov_Blankets.md) — Markov-blanket depth as the inverse internal-clock frequency.
- [`HadronicDepth.md`](HadronicDepth.md) — proton depth `n_p ~ (m_P/m_p)^3`; consistent in scaling sense with `R_p = E_Planck / m_p c²`.
- [`Active_Inference_Mathematics.md`](Active_Inference_Mathematics.md) §5 — meta-scoreboard "Quantitative mass spectrum" row.

### External

- de Broglie, L. (1924). *Recherches sur la théorie des Quanta*. PhD thesis, Sorbonne — mass-frequency relation `m c² = ℏω`.
- Compton, A. H. (1923). *A quantum theory of the scattering of X-rays by light elements*. Phys. Rev. 21, 483 — Compton wavelength.
- Particle Data Group — measured rest masses and Planck-scale unit values.
