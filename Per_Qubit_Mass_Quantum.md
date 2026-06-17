# Per-Qubit Mass Quantum: each qubit contributes ℏω to rest energy

**Each qubit contributes `ℏω` of rest energy to the particle or bound-state mass.** This is the [QLF](README.md) per-qubit mass-energy quantum, parallel to the per-event `log 2` information quantum of [`MRE.md`](MRE.md). Combined with the Markov-blanket depth relation `ω = f_vac / R` of [`Frequency_Synchronization.md`](Frequency_Synchronization.md), it gives the explicit formula

$$m_{\text{qubit}} \, c^2 \;=\; \hbar \omega_{\text{qubit}} \;=\; \frac{\hbar \, f_{\text{vac}}}{R_{\text{qubit}}} \;=\; \frac{E_{\text{Planck}}}{R_{\text{qubit}}}$$

where `R_qubit` is the qubit's Markov-blanket depth (in QLF natural units, where each "Planck event" is one unit of depth and `E_Planck = ℏ × f_vac` is the corresponding energy quantum).

Particles and bound states are then **sums over their constituent qubits**:

$$m_{\text{particle}} \, c^2 \;=\; \sum_{\text{qubits } i} \hbar \omega_i \;=\; \sum_i \frac{E_{\text{Planck}}}{R_i}$$

This principle unifies and clarifies several earlier QLF formulations:

- [`Higgs.md`](Higgs.md) §2 wrote `m = α R` with `α` a unit-conversion factor. The per-qubit reading clarifies: `α = ℏ ω_per_qubit / R_per_qubit = E_Planck / R²_per_qubit` in QLF natural units, so the implicit per-qubit structure is explicit.
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

The photon-side companion is in [`Photon_Energy_Bits.md`](Photon_Energy_Bits.md): a photon has `E = N_bits · ℏω` (bits of joint-closure information × per-bit energy), with `m_rel = E/c²` mass-equivalence but zero rest mass (no gauge fold → no constructing delay). Massive particles carry **gauge-folded qubits** with rest mass `ℏω` each; photons carry **gauge-free bits** with mass-equivalence `ℏω` each. Both follow the same accounting principle: energy = quanta count × per-quantum energy. The unifying `ℏω = 1 bit at frequency ω` principle is derived from QLF first principles in [`Information_Energy_Equivalence.md`](Information_Energy_Equivalence.md) (Wheeler-Fields equivalence).

### 3.3 The first-principles derivation question becomes sharper

The open question "derive `m_e` from QLF closure-multiplicity" is:

> **Derive `R_e`** (the electron qubit's Markov-blanket depth, `R_e ≈ 2.389 × 10²²` in Planck units) **from QLF closure-multiplicity counts** — i.e., from the combinatorial structure of the 8-twist alphabet, ZFA closure, and the per-event `log 2` quantum.

This is a cleaner statement of the open problem than "derive `α R_e = m_e`" because:
- `α` is `E_Planck` (Planck energy quantum), a defined unit rather than a fitted parameter.
- `R_e` is a single integer-valued depth, not a depth-times-conversion product.
- The target is a specific large number (`≈ 2.4 × 10²²`), constraining what kind of combinatorial argument could produce it.

The required depth `R_e ≈ 2.4 × 10²²` is far beyond any tractable BFS enumeration. A first-principles derivation will involve depth-as-mass scaling at the Planck-event scale plus a structural argument for why the electron's specific Markov-blanket sits at that depth.

### 3.3a The absolute spectrum is one scale, exponentially generated

Two honest results sharpen this further ([`lean/QLF_MassSpectrum.lean`](lean/QLF_MassSpectrum.lean)).

**The whole spectrum is one parameter.** Because every QLF mass *ratio* is a machine-verified
dimensionless number — `m_p/m_e = 6π⁵`, `m_p/m_π = 3π⁵/137`, Koide `Q=2/3`, the depth ratios —
**every mass is the single proton scale `m_p` times a verified ratio** (`spectrum_one_scale`;
`m_e = m_p/6π⁵`, `electron_mass_from_proton_eq`). The Standard Model's ~13 independent mass
parameters collapse to **one** absolute input. So the absolute-spectrum problem is exactly:
*derive one number* — `R_p ≈ 1.30×10¹⁹` (equivalently `R_e = 6π⁵ R_p ≈ 2.4×10²²`).

**That one number is exponentially generated — dimensional transmutation.** Why is `R_p ≈ 10¹⁹`
so huge? Not fine-tuning. The strong coupling runs *logarithmically* (asymptotic freedom,
[`QLF_RunningCouplings`](lean/QLF_RunningCouplings.lean)), so starting from a moderate
substrate-scale coupling `α`, it reaches strong coupling — confinement, the proton scale — only
after a depth **exponential in `1/α`**: `R ~ exp(2π/(b·α))`, with log linear in `1/α`,
`ln R = 2π/(b·α)` (`log_transmuted_hierarchy`). With the QCD one-loop coefficient `b = 7` and a
moderate `α_s ≈ 0.02`, `ln R ≈ 2π/(7·0.02) ≈ 44.9`, matching the measured
`ln(M_Planck/m_p) ≈ 44.0`. A moderate input, exponentially amplified — **the `10¹⁹` hierarchy
with no fine-tuning**; weaker coupling gives a larger hierarchy
(`weaker_coupling_larger_hierarchy`, the asymptotic-freedom amplification).

**Honest scope.** This reduces the spectrum to one scale and shows the scale is exponentially
*natural*, but does **not** derive its value: that needs the β-coefficient `b` (open in
`QLF_RunningCouplings`), the substrate coupling `α_s`, and the Planck→SI calibration — equivalently
the combinatorial `R_e` count above (`mass_spectrum_in_progress`).

### 3.3b The hierarchy from one integer: `b₀ = 7` fixes both inputs

The two inputs above — `b` and `α_s` — are both read off the substrate, and the result is
striking ([`lean/QLF_BetaFunction.lean`](lean/QLF_BetaFunction.lean), [`lean/QLF_AlphaS.lean`](lean/QLF_AlphaS.lean)).

- **`b₀ = 7`** is the QCD one-loop coefficient `11 N_c/3 − 2 n_f/3` with `N_c = 3` (the three
  spatial axes) and `n_f = 6` (two flavours × three generations) — `beta_coefficient_eq_seven`.
- **`α_s(substrate) = 1/b₀²`** (`substrate_alpha_s`) — *consistent with the measured running*: from
  `M_Z` to the Planck scale, `1/α_s(M_Planck) ≈ 52` (one-loop, `b₀=7`), and `b₀² = 49` (~7%).

With both, the dimensional-transmutation hierarchy **collapses to a pure integer**
(`log_hierarchy_pure_integer`):

```
ln R_p = 2π / (b₀ · α_s) = 2π / (b₀ · 1/b₀²) = 2π · b₀ = 14π ≈ 43.98,
```

matching the measured `ln(M_Planck/m_p) ≈ 44.01` to **0.07%** (`hierarchy_log_eq_fourteen_pi`). So
`R_p = e^{2π b₀} = e^{14π}`, and — via the one-parameter reduction of §3.3a — **the entire absolute
mass spectrum follows from the single integer `b₀ = 7`** (itself `N_c=3`, `n_f=6`). Honest residual:
`α_s = 1/b₀²` is a running-consistent *posit* (not yet a derivation), and the value-level match is
~3% (`e^{14π} = 1.26×10¹⁹` vs `1.30×10¹⁹` — the Planck-mass/SI calibration); the log match is 0.07%
(`alpha_s_substrate_in_progress`).

**Structural relation `Ry = (1/2) α² m_e c²`.** The QLF Bohr derivation in [`Hydrogen.md`](Hydrogen.md) §§2–4 produces this identity from Coulomb-via-gauge-twist-exchange (§2) + ZFA-depth quantization (§3). Equivalently in QLF Planck units:

```
α² = 2 · Ry / m_e c² = 2 · Ry · R_e / E_Planck = 2 · R_e / R_1
```

where `R_1 = E_Planck / Ry ≈ 8.97 × 10²⁶` is the hydrogen ground-state binding depth. Given any **two** of {α, Ry, m_e}, the third is **derived** to CODATA precision (10⁻¹⁰ relative error) via the QLF Bohr relation — see [`fine_structure_demo.py`](fine_structure_demo.py). The Rydberg formula itself is not an empirical input; it falls out of the QLF closure structure.

What remains open is to derive **at least one** of {α, Ry, m_e, R_e, R_1} from QLF closure-multiplicity at the Planck-event scale, independently of observation — for example, the structural argument for why `R_e ≈ 2.4 × 10²²` sits at exactly that depth. See [`Proton_Resonance_R_e.md`](Proton_Resonance_R_e.md) for the chirality-hiding-resonance scoping that decomposes this as `R_e = R_p · 6π⁵`, with the `6π⁵` Lenz factor coming from `|S_3|` quark permutation symmetry × 5-angle integration over the proton's hidden-chirality configuration space — both pieces still open in full quantitative form, but each a sharper sub-problem than direct R_e enumeration.

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

## §5 What is derived, what is still open

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

- **First-principles derivation of `R_e`** from QLF closure-multiplicity. The specific large number `R_e ≈ 2.389 × 10²²` is what the eventual derivation must produce. Likely shape: a large-depth structural argument tied to the Planck-event-rate scaling and/or an MRE-cost-weighted enumeration that intrinsically suppresses gauge contributions relative to spatial ones.
- **Zeta-bridge reading**: the per-qubit `ℏω = E_Planck / R` identification gives the Mellin variable `s` in [`ReverseMathematics.md`](ReverseMathematics.md) §4 a physical energy/frequency interpretation. See §4.8 there for the information-energy reading of the MRE bridge — `Re(s) = 1/2` becomes the joint information-energy saturation locus. Proof-theoretic status of `spectral_hilbert_polya` unchanged (WKL₀ axiom); content sharpened.
- **Lean theorem `qubit_mass_is_hbar_omega`.** Formalise the per-qubit mass quantum as a Lean theorem connecting half-spin ZFA atoms (in [`lean/QLF_Pauli.lean`](lean/QLF_Pauli.lean) and [`lean/QLF_TwistAlphabet.lean`](lean/QLF_TwistAlphabet.lean)) to a per-atom rest energy. The Compton-relation structure is well-known; the QLF Lean formalization would establish it as a consequence of `rho_process_always_zfa` and the per-event log-2 quantum.
- **Quark-qubit decomposition of the proton.** The proton mass-energy decomposes as three quark qubits + gluonic-gauge-fold contributions. Pinning the exact decomposition (current quark masses vs. QCD binding) requires connecting QLF to the gauge-fold-depth content of QCD.
- **τ-decay-vertex per-qubit accounting.** The τ has no stable atomic system; its mass-energy is the integrated `ℏω_τ` of the decay-vertex closure. A specific decay-channel topology that closes at `m_τ c² = ℏω_τ` is open work.
- **Heavier atomic systems.** Each heavier bound state (deuterium, helium, pionium, ...) adds constituent qubits — the per-qubit principle predicts their masses as sums of constituent `ℏω`'s.

---

## References

### Internal

- [`Bound_States_QLF.md`](Bound_States_QLF.md) — free leptons are not QLF observables; atomic systems are.
- [`Atomic_System_QLF_Closures.md`](Atomic_System_QLF_Closures.md) — joint-closure topologies for positronium, muonium, hydrogen; mass-additivity made explicit via the per-qubit principle.
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
