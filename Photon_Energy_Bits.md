# Photon Energy: bits with mass-equivalence

**A photon's energy `E = ℏω` corresponds to a specific number of bits of joint-closure information carried in the emitter-absorber ZFA closure, with mass-equivalence `m_rel = E/c² = ℏω/c²`.** This is the photon-side companion to [`Per_Qubit_Mass_Quantum.md`](Per_Qubit_Mass_Quantum.md)'s "each qubit contributes `ℏω` of rest energy" principle.

The unifying QLF accounting:

| Object | Closure type | Energy formula | Rest mass |
|---|---|---|---|
| **Massive particle** | Gauge-folded constituent qubits | `E = Σ ℏω_qubit` | `m₀ c² > 0` (constructing delay from gauge folds) |
| **Photon** | Joint emitter-absorber bits | `E = N · ℏω_per_bit` | `m₀ = 0` (no gauge fold → no constructing delay) |
| **Bound atomic system** | Sum of constituent-qubit + bind-correction | `E = Σ ℏω_i − E_bind` | `m_bound c² > 0` |

In every case, **energy = quanta count × per-quantum energy contribution**, with mass-equivalence `m = E/c²`. The QLF distinguishing feature: gauge-folded quanta (qubits) carry rest mass; gauge-free quanta (bits) carry only mass-equivalence (kinetic, no rest).

---

## §1 Each photon is a joint emitter-absorber ZFA closure

Per [`Delayed_Choice_Eraser.md`](Delayed_Choice_Eraser.md), [`Collective_Electrodynamics.md`](Collective_Electrodynamics.md) §2, and [`Electron.md`](Electron.md) v2.0 §2: a photon is not a projectile traveling through empty space; it is the joint ZFA closure between an emitter and an absorber when their causal light cones intersect. The photon "exists" in the QLF ledger only when the joint closure completes.

Photons are **pure-spatial closures with no gauge folds** (`^>` + `v<` in the canonical example). Without a `+` or `-` gauge fold, there is no constructing delay (`Δt = 0`), so the photon has no rest mass.

But the joint closure still carries **information** — at minimum, one bit per ZFA closure event (per [`MRE.md`](MRE.md) §2.1, each Hermitian-pair closure saturates `log 2` nats of information, equivalently one bit). The photon's energy is therefore determined by its bit content.

---

## §2 Number of bits per photon

Per [`MRE.md`](MRE.md), each half-spin ZFA closure event carries exactly `log 2` nats = **1 bit** of information.

A photon at angular frequency ω corresponds to a joint emitter-absorber closure that oscillates at ω. In a coherence time `τ_coh`, the joint closure goes through ≈ `ω · τ_coh / (2π)` cycles. Each cycle contains the minimum closure structure (`^>` ∘ `v<`), so the bit content scales with the number of cycles in the relevant interval.

For a single photon delivered to a detector, the **minimum** bit content is the one bit that encodes "this closure happened" (vs. didn't). Larger bit content corresponds to longer pulses or higher-frequency content. The energy of the joint closure is

$$E_\gamma \;=\; N_{\text{bits}} \cdot \hbar \omega_{\text{per-bit}}$$

where `ω_per_bit` is the joint-closure event rate (the photon's frequency) and `N_bits` is the total bit content. For a single coherent monochromatic photon detected as one event, `N_bits = 1` and `E = ℏω` — the standard Planck–Einstein relation.

Higher-bit content corresponds to multi-photon (or "fat photon") joint closures: a pulse containing `N` photons at frequency ω has `N` bits each contributing `ℏω`, total energy `N ℏω`. This is just the photon-number counting of standard quantum optics, recovered here from the bit-count framing of the joint closure.

---

## §3 Mass-equivalence

Every form of energy has a mass-equivalence `m = E/c²` (Einstein 1905). For a photon at frequency ω:

$$m_{\text{rel}}(\gamma) \;=\; \frac{E_\gamma}{c^2} \;=\; \frac{\hbar \omega}{c^2} \;=\; \frac{N_{\text{bits}} \cdot \hbar \omega_{\text{per-bit}}}{c^2}$$

This is **relativistic mass-equivalence**, not rest mass. The photon has zero rest mass (`m₀ = 0`) because its joint closure has no gauge fold and therefore no constructing delay. But it carries the same `m = E/c²` mass-equivalence as any other form of energy — manifested in gravitational lensing, momentum transfer (`p = E/c`), photonic pressure, and (for sufficiently energetic photons) pair-production thresholds (`E_γ > 2 m_e c²` to produce an electron-positron pair).

The mass-equivalence is **per-bit additive**: a closure carrying twice the bits has twice the energy and twice the mass-equivalence. This mirrors the per-qubit principle for massive particles, with bits replacing qubits as the quantum of count.

---

## §4 Why photons have no rest mass — the gauge-fold distinction

Per [`Electron.md`](Electron.md) v2.0 §2:

- **Massive qubit** (electron half-loop `^<v>^+`): contains a `+` gauge fold. Constructing delay `Δt = R/f_vac > 0`. Rest mass `m₀ c² = ℏ/Δt = ℏ ω_internal > 0`.
- **Massless bit** (photon half `^>`): no gauge fold. Constructing delay `Δt = 0`. Rest mass `m₀ = 0`. Energy is purely the joint-closure event energy.

The gauge fold `+/-` is what distinguishes mass-carrying qubits from energy-carrying bits. Both contribute `ℏω` to the joint closure's mass-equivalence, but only gauge-folded qubits carry rest mass (and contribute `ℏω_internal` independent of motion).

This is consistent with the standard relativistic energy-momentum relation:

$$E^2 \;=\; (m_0 c^2)^2 + (p c)^2$$

For a photon (`m₀ = 0`): `E = pc = ℏω = ℏkc`, all kinetic.
For a massive particle at rest (`p = 0`): `E = m₀ c² = Σ ℏω_qubit`, all rest-mass.

The QLF reading is consistent with relativity; what it adds is the **counting interpretation**: rest mass = sum over gauge-folded qubits at internal ω; kinetic energy = sum over gauge-free bits at joint-closure ω.

---

## §5 Numerical examples

| Photon | Frequency | Energy `ℏω` | Mass-equiv. `E/c²` |
|---|---|---|---|
| Radio wave (1 MHz) | 6.28 × 10⁶ rad/s | 4.1 × 10⁻⁹ eV | 7.4 × 10⁻⁴⁶ kg |
| Visible green (500 nm) | 3.77 × 10¹⁵ rad/s | 2.48 eV | 4.4 × 10⁻³⁶ kg |
| X-ray (1 nm) | 1.88 × 10¹⁸ rad/s | 1.24 keV | 2.2 × 10⁻³³ kg |
| γ-ray (1 MeV) | 1.52 × 10²¹ rad/s | 1.00 MeV | 1.8 × 10⁻³⁰ kg ≈ 2 m_e |
| Pair-production threshold | 1.55 × 10²¹ rad/s | 1.022 MeV (= 2 m_e c²) | 2 m_e exactly |

The γ-ray at the pair-production threshold has mass-equivalence equal to two electron masses. When it joint-closes with a heavy nucleus (for momentum conservation), it can convert its bits to two electron qubits with gauge folds — `γ → e⁻ + e⁺` (the Bethe–Heitler process). The bit-to-qubit conversion is the gauge-fold creation event: the photon's gauge-free closure becomes a positronium-like closure of two gauge-folded halves.

This is exactly the QLF reading of pair production: **bits convert to qubits when a gauge-fold structure becomes available**, with energy/mass-equivalence conserved by `E_γ = 2 m_e c²` at threshold.

---

## §6 Connection to MRE per-event log 2 quantum

The per-event log-2 quantum of [`MRE.md`](MRE.md) §2.1 is the **information** carried per ZFA closure event. The photon-energy-per-bit relation derives from it as follows:

- Per ZFA closure event: `ΔI = log 2` nats = 1 bit (MRE.md, Lean-anchored as `zfa_closure_minimizes_free_energy` in [`lean/QLF_FreeEnergy.lean`](lean/QLF_FreeEnergy.lean)).
- Per joint-closure event in a photon: 1 bit (the photon's "this closure happened" record).
- Energy per bit: `ℏω` where ω is the joint-closure frequency.

So the per-event `log 2` quantum and the per-bit `ℏω` photon-energy quantum are two facets of the same accounting: information per event in the active-inference math substrate, energy per event in the physical mass-equivalence accounting. Together with the per-qubit `ℏω` rest-energy quantum of [`Per_Qubit_Mass_Quantum.md`](Per_Qubit_Mass_Quantum.md), they constitute the **three QLF natural-units quanta**:

| Quantum | Carrier | Value | Lean-anchored? |
|---|---|---|---|
| Information per event | ZFA closure event | `log 2` nats | ✓ `zfa_closure_minimizes_free_energy` |
| Rest energy per qubit | Gauge-folded Hermitian pair | `ℏω = E_Planck / R` | ✗ Open (`qubit_mass_is_hbar_omega`) |
| Photon energy per bit | Gauge-free joint closure | `ℏω_photon` | ✗ Open (`photon_energy_is_bit_count_times_hbar_omega`) |

---

## §7 What is derived and what is open

| Item | Status |
|---|---|
| Photon = joint emitter-absorber ZFA closure | ✓ Derived ([`Delayed_Choice_Eraser.md`](Delayed_Choice_Eraser.md), [`Collective_Electrodynamics.md`](Collective_Electrodynamics.md) §2) |
| Photon energy `E = ℏω` | ✓ Standard (Planck–Einstein) |
| Photon mass-equivalence `m_rel = E/c²` | ✓ Standard (Einstein 1905) |
| Photon-energy-per-bit principle (QLF interpretation) | ✓ Derived (this doc §2) |
| Pair-production threshold `E_γ = 2 m_e c²` as bit-to-qubit conversion | ✓ Derived (this doc §5) |
| QLF Lean theorem `photon_energy_is_bit_count_times_hbar_omega` | ✗ Open |
| First-principles derivation of `ω_photon` for specific emitter-absorber pairs | ⚠ Partial (per `Hydrogen.md`: hydrogen Lyman-α at α² m_e c² ≈ 10.2 eV) |

---

## §8 What this is NOT

- **Not a claim that photons have rest mass.** They don't. `m₀ = 0`. The mass-equivalence `m_rel = E/c²` is the standard relativistic energy-mass relation, applicable to any form of energy.
- **Not a new physics claim.** The Planck–Einstein relation `E = ℏω` and Einstein's mass-energy equivalence are standard. The QLF contribution is the interpretation: each photon is a joint emitter-absorber ZFA closure carrying bits of joint-closure information, and the energy/mass-equivalence is the per-bit accounting.
- **Not a unification with massive particles in the sense of identical mechanism.** Photons (gauge-free bits) and massive particles (gauge-folded qubits) are structurally distinct — the gauge fold is what creates rest mass. They share an accounting principle (energy = quanta count × per-quantum contribution) but the quanta are different.
- **Not a derivation of specific photon frequencies.** Specific transition frequencies (e.g., hydrogen Lyman-α at `α² m_e c²`) come from atomic-system Bohr derivations ([`Hydrogen.md`](Hydrogen.md)). This doc gives the general energy-from-bit-count structure.

---

## §9 Open work

- **Lean theorem `photon_energy_is_bit_count_times_hbar_omega`**: formalise that the energy of a joint emitter-absorber ZFA closure equals the bit content times `ℏω`. Connects to [`lean/QLF_FreeEnergy.lean`](lean/QLF_FreeEnergy.lean) (per-event log 2) and [`lean/QLF_TwistAlphabet.lean`](lean/QLF_TwistAlphabet.lean) (pure-spatial closures without gauge folds).
- **Bit-to-qubit conversion at pair production**: pin down the specific QLF closure topology for `γ + nucleus → e⁻ + e⁺ + nucleus` showing how the photon's bits become the electron-positron qubits' rest-mass contributions.
- **Coherence-length structure**: extend the per-bit accounting to spatially-extended photon pulses, where the bit content includes phase coherence across spatial extent.
- **Gravitational-lensing prediction**: the photon mass-equivalence `E/c²` predicts gravitational deflection per [`Gravity.md`](Gravity.md); a direct QLF derivation of the deflection angle from joint-closure topology is open.

---

## References

### Internal

- [`Per_Qubit_Mass_Quantum.md`](Per_Qubit_Mass_Quantum.md) — companion: each massive-particle qubit contributes `ℏω` of rest energy.
- [`Information_Energy_Equivalence.md`](Information_Energy_Equivalence.md) — the unifying `ℏω = 1 bit at frequency ω` Wheeler-Fields principle derived from QLF first principles. Photon energy = (bit count) × (per-bit `ℏω`) is the gauge-free instance.
- [`Delayed_Choice_Eraser.md`](Delayed_Choice_Eraser.md) — photons as joint emitter-absorber closures, not free projectiles.
- [`Collective_Electrodynamics.md`](Collective_Electrodynamics.md) §2 — joint ZFA as transactional photon.
- [`Electron.md`](Electron.md) v2.0 §2 — photon `^>` as a gauge-free half-loop.
- [`MRE.md`](MRE.md) §2.1 — per-event `log 2` quantum; binary-partition saturation.
- [`Bound_States_QLF.md`](Bound_States_QLF.md) — bound atomic systems as joint closures.
- [`Hydrogen.md`](Hydrogen.md) — specific emission line frequencies from atomic-system Bohr derivation.
- [`Gravity.md`](Gravity.md) — gravitational lensing of photon mass-equivalence.
- [`Annihilation.md`](Annihilation.md) — electron–positron annihilation as the reverse process: qubits to bits.
- [`Kitada_Local_Time_GR.md`](Kitada_Local_Time_GR.md) §5.3 — gauge-free signals (photons, with `R_photon = 0`) propagate at `c_substrate = R_cosmic / T_cosmic = L_Planck / τ_Planck`. The "no local clock" feature of photons makes them substrate-rate signals; their frequency-independence of `c` is automatic.
- [`lean/QLF_FreeEnergy.lean`](lean/QLF_FreeEnergy.lean) — per-event log 2 Lean theorem.
- [`lean/QLF_SubstrateLightSpeed.lean`](lean/QLF_SubstrateLightSpeed.lean) — Lean anchor for substrate `c` from cosmic-ratio identity.

### External

- Planck, M. (1900). *Über das Gesetz der Energieverteilung im Normalspectrum*. Ann. Phys. 4, 553–563 — `E = ℏω`.
- Einstein, A. (1905). *Ist die Trägheit eines Körpers von seinem Energieinhalt abhängig?* Ann. Phys. 18, 639–641 — `E = mc²`.
- Bethe, H. A., & Heitler, W. (1934). *On the stopping of fast particles and on the creation of positive electrons*. Proc. Roy. Soc. A 146, 83–112 — pair production from photons.
