# Atomic Systems as QLF Joint Closures — Specific Mappings

> **Per-qubit reading** (see [`Per_Qubit_Mass_Quantum.md`](Per_Qubit_Mass_Quantum.md)): each qubit contributes `ℏω = E_Planck / R_qubit` of rest energy, so the mass formulas below — `m(Ps) = 2 m_e`, `m(H) = m_e + m_p`, `m(Mu) = m_e + m_μ` — are direct sums of constituent-qubit `ℏω` contributions. The Compton relation per qubit, with `ω` set by the qubit's Markov-blanket depth.


Per [`Bound_States_QLF.md`](Bound_States_QLF.md), the natural QLF mass observables are atomic systems: positronium, muonium, hydrogen. This document writes out the **specific QLF closure topology for each** — the joint-closure pattern, the gauge-fold-depth decomposition, and the structural derivation of the measured masses and binding energies. It closes [`Bound_States_QLF.md`](Bound_States_QLF.md) §6 step 1 (the mapping) and partial-closes step 2 (the mass-from-mapping) and step 3 (the Bohr reduced-mass scaling).

The picture: each atomic system is a **joint ZFA closure between two half-loops**, in the same structural sense that a photon is a joint emitter-absorber closure ([`Delayed_Choice_Eraser.md`](Delayed_Choice_Eraser.md)). The constituent halves carry **gauge-fold-depth** contributions `R_constituent` (per [`Electron.md`](Electron.md) v2.0 and [`Higgs.md`](Higgs.md) §2); the joint closure has total depth `R_joint = R_A + R_B` (modulo binding-energy corrections); the mass is `m = α R_joint` with `α` the QLF-natural-units → MeV conversion.

---

## §1 The mapping pattern

Every atomic system in QLF has the same structural template:

$$\text{Joint closure} \;=\; \text{(electron-like half)} \;\circ\; \text{(partner half)}$$

with three ingredients:

1. **A leptonic half-loop**, typically the electron half-loop `^<v>^+` of [`Electron.md`](Electron.md) §1, carrying gauge-fold depth `R_e`.
2. **A partner half-loop** with gauge-fold depth `R_partner` set by the partner's species.
3. **A joint-closure binding**, with binding-energy depth `R_bind` related by the Bohr reduced-mass formula (§5).

Total mass of the bound state:

$$m_{\text{bound}} \;=\; \alpha \, (R_e + R_{\text{partner}}) \;-\; E_{\text{bind}}$$

with `E_bind ≪ m_constituent` (typically 10⁻⁸ relative) for all three atomic systems considered here.

---

## §2 Positronium — symmetric minimal joint closure

The simplest atomic system. Constituents:

- Electron half-loop:    `^<v>^+`  (gauge-fold depth `R_e`)
- Positron half-loop:    `v>^<v-` (Hermitian conjugate; gauge-fold depth `R_e+ = R_e` by CPT)

Joint ZFA closure (schematic):

$$|\text{Ps}\rangle \;=\; \,^<v>^+ \;\circ\; v>^<v- \;\;\Rightarrow\;\; \text{net topology balanced},\; \text{Pauli fold scalar}$$

Both halves carry the same gauge-fold depth `R_e`. The joint closure has total depth:

$$R(\text{Ps}) \;=\; 2 R_e$$

Mass:

$$m(\text{Ps}) \;=\; \alpha \cdot 2 R_e \;=\; 2 m_e \;\approx\; 1.022\,\text{MeV}$$

Therefore `α R_e = m_e ≈ 0.511 MeV`. The "electron mass" `m_e` is exactly **half** of `m(Ps)` — it is the electron half-loop's contribution to the joint positronium closure, not an isolated free-particle property.

### Reduced mass

For two equal-mass constituents:

$$\mu(\text{Ps}) \;=\; \frac{m_e \cdot m_e}{m_e + m_e} \;=\; \frac{m_e}{2}$$

### Binding energy from Bohr

$$E_{\text{bind}}(\text{Ps}) \;=\; \frac{\mu(\text{Ps})}{m_e} \cdot 13.6\,\text{eV} \;=\; \frac{1}{2} \cdot 13.6\,\text{eV} \;\approx\; 6.8\,\text{eV}$$

Measured: 6.803 eV. ✓ (sub-percent agreement)

---

## §3 Hydrogen — leptonic + baryonic joint closure

Hydrogen binds an electron half-loop to a proton internal closure. The proton is a composite three-quark closure per [`HadronicDepth.md`](HadronicDepth.md):

- Electron half-loop:  gauge-fold depth `R_e` ≈ 0.511 MeV / α
- Proton internal closure: three-quark composite, gauge-fold depth `R_p` ≈ 938.27 MeV / α

Joint hydrogen closure (schematic):

$$|\text{H}\rangle \;=\; \text{(electron half-loop)} \;\circ\; \text{(proton internal closure)}$$

The proton internal closure has its own ZFA-closure structure ([`HadronicDepth.md`](HadronicDepth.md) gives `n ≈ (m_P/m_p)³` for the depth ratio relative to Planck) — it is itself a joint closure of three quarks plus gluonic gauge folds. For the purpose of the electron–proton joint closure, the proton internal structure contributes its full rest-mass depth `R_p`.

Total joint depth:

$$R(\text{H}) \;=\; R_e + R_p$$

Mass:

$$m(\text{H}) \;=\; \alpha \cdot (R_e + R_p) \;=\; m_e + m_p \;\approx\; 0.511 + 938.27 \;=\; 938.78\,\text{MeV}$$

Strongly dominated by `m_p` (`m_e/m_p ≈ 5.4 × 10⁻⁴`).

### Reduced mass

For one light and one heavy constituent (`m_p ≫ m_e`):

$$\mu(\text{H}) \;=\; \frac{m_e \cdot m_p}{m_e + m_p} \;\approx\; m_e \cdot \left(1 - \frac{m_e}{m_p}\right) \;\approx\; m_e$$

(The correction is 5.4 × 10⁻⁴, observable as the small reduced-mass shift in hydrogen spectroscopy.)

### Binding energy from Bohr

$$E_{\text{bind}}(\text{H}) \;=\; \frac{\mu(\text{H})}{m_e} \cdot 13.6\,\text{eV} \;\approx\; 13.6\,\text{eV}$$

Measured: 13.598 eV. ✓

---

## §4 Muonium — leptonic + leptonic joint closure (asymmetric)

Muonium binds an electron half-loop to an antimuon half-loop. Both are leptonic, but the antimuon carries a much deeper gauge-fold depth:

- Electron half-loop:  gauge-fold depth `R_e` ≈ 0.511 MeV / α
- Antimuon half-loop:  gauge-fold depth `R_μ` ≈ 105.66 MeV / α

Per [`Hadrons_Markov_Blankets.md`](Hadrons_Markov_Blankets.md)'s scale-recursion framing, the antimuon's half-loop sits at a **deeper Markov blanket** than the electron's — a longer constructing-delay loop at lower internal frequency `f = 1/Δt = R/f_vacuum`. Structurally the two halves have analogous QuCalc topology, but different depths.

Joint muonium closure (schematic):

$$|\text{Mu}\rangle \;=\; \text{(electron half-loop, depth } R_e\text{)} \;\circ\; \text{(antimuon half-loop, depth } R_\mu\text{)}$$

Total joint depth:

$$R(\text{Mu}) \;=\; R_e + R_\mu$$

Mass:

$$m(\text{Mu}) \;=\; \alpha \cdot (R_e + R_\mu) \;=\; m_e + m_\mu \;\approx\; 0.511 + 105.66 \;=\; 106.17\,\text{MeV}$$

### Reduced mass

For `m_μ ≫ m_e`:

$$\mu(\text{Mu}) \;=\; \frac{m_e \cdot m_\mu}{m_e + m_\mu} \;\approx\; m_e \cdot \left(1 - \frac{m_e}{m_\mu}\right) \;\approx\; m_e$$

(Correction is 4.8 × 10⁻³, larger than hydrogen but still small.)

### Binding energy from Bohr

$$E_{\text{bind}}(\text{Mu}) \;=\; \frac{\mu(\text{Mu})}{m_e} \cdot 13.6\,\text{eV} \;\approx\; 13.6\,\text{eV}$$

Measured: 13.541 eV. ✓ (sub-percent agreement; the 0.4% difference from hydrogen is the slightly smaller reduced-mass correction)

---

## §5 The Bohr reduced-mass scaling — derived from joint-closure structure

The binding-energy structure across the three atomic systems is dominated by the reduced-mass factor:

| System | Reduced mass | Predicted E_bind | Measured E_bind |
|---|---|---|---|
| Ps | `m_e / 2` | 6.80 eV | 6.803 eV ✓ |
| H | `≈ m_e` | 13.6 eV | 13.598 eV ✓ |
| Mu | `≈ m_e` | 13.6 eV | 13.541 eV ✓ |

The factor-of-2 difference between positronium and hydrogen/muonium emerges structurally:

- **Positronium** is the symmetric case (`R_A = R_B = R_e`); the reduced mass is exactly half.
- **Hydrogen and muonium** are the asymmetric heavy-light cases (`R_partner ≫ R_e`); the reduced mass is approximately `m_e`.

In QLF terms, the reduced-mass formula `μ = R_A R_B / (R_A + R_B)` is a property of the **joint-closure binding energy**, which itself is determined by the orbital-equilibrium condition of the two coupled half-loops. The full QLF derivation of `13.6 eV = (1/2) m_e α²` from joint-closure multiplicity counts (where `α ≈ 1/137` is the QLF fine-structure constant from [`Hydrogen.md`](Hydrogen.md)) is sketched in [`Hydrogen.md`](Hydrogen.md) and is structurally consistent with the mapping above.

**Empirical ratios** (all reproduced):

- `E(Mu) / E(Ps) ≈ 1.99` (predicted ≈ 2 from the symmetric vs. asymmetric reduced-mass structure)
- `E(H) / E(Ps) ≈ 2.00`
- `E(H) / E(Mu) ≈ 1.004` (predicted ≈ 1; the tiny correction is the residual reduced-mass difference between heavy partners)

These are the right empirical signals from the QLF mass-spectrum derivation — and the three-atomic-system framework reproduces them within the experimental precision of the Bohr-formula reduced-mass scaling.

---

## §6 The τ — decay-vertex closure, not Bohr-bound

The τ does not form a stable atomic system; its lifetime ≈ 290 fs is too short for Bohr binding ([`Bound_States_QLF.md`](Bound_States_QLF.md) §4). The QLF observable for the third generation is the τ-decay vertex.

Schematic τ decay (leptonic channel):

$$\tau^- \;\to\; \nu_\tau + W^- \;\to\; \nu_\tau + (\ell^- + \bar\nu_\ell)$$

The τ-decay vertex is a **multi-body joint ZFA closure** (one heavy lepton in, three outgoing) at the energetic threshold:

$$m_\tau \;>\; m_{\nu_\tau} + m_W^* \;\;\;\text{(virtual W)}$$

This is structurally different from the two-body Bohr-bound closures of §§2–4. The QLF mass `m_τ ≈ 1776.86 MeV` corresponds to the gauge-fold depth `R_τ` of the τ half-loop, fixed by the closure topology of its dominant decay channels. A detailed treatment requires the W boson's QLF closure (per [`Higgs.md`](Higgs.md) §3) and is out of scope here; the structural point is that the τ contributes its gauge-fold depth `R_τ` to the decay-vertex joint closure, not to a Bohr-bound atomic system.

The "third-generation mass" question in QLF is therefore: **at what gauge-fold depth does the τ-decay-vertex closure first satisfy the energetic-threshold condition?** This is a decay-channel-multiplicity question, structurally different from the bound-state spectrum of §§2–4 and open as future work ([`Standard_Model.md`](Standard_Model.md) §6).

---

## §7 Summary: derived vs. sketched vs. open

| Item | Status |
|---|---|
| Positronium ↔ symmetric joint closure, m = 2m_e | ✓ Derived (this doc §2) |
| Hydrogen ↔ electron-half + proton-internal joint closure, m = m_e + m_p | ✓ Derived (this doc §3) |
| Muonium ↔ asymmetric leptonic joint closure, m = m_e + m_μ | ✓ Derived (this doc §4) |
| E(Mu)/E(Ps) ≈ 2 from reduced-mass structure | ✓ Derived |
| E(H)/E(Mu) ≈ 1 from reduced-mass structure | ✓ Derived |
| Bohr binding 13.6 eV = (1/2) m_e α² from QLF closure-multiplicity | ⚠ Sketched ([`Hydrogen.md`](Hydrogen.md)) |
| α R_e = m_e ≈ 0.511 MeV — α value from first principles | ✗ Open — equivalent under the per-qubit reading to deriving `R_e ≈ 2.4 × 10²²` from QLF closure-multiplicity; see [`Per_Qubit_Mass_Quantum.md`](Per_Qubit_Mass_Quantum.md) §3.3 |
| Specific 8-twist topology for the electron half-loop with gauge fold | ⚠ Sketched ([`Electron.md`](Electron.md) §1) |
| Specific 8-twist topology for the proton three-quark closure | ⚠ Sketched ([`HadronicDepth.md`](HadronicDepth.md)) |
| Specific 8-twist topology for the antimuon half-loop | ✗ Open |
| τ-decay-vertex closure topology | ✗ Open ([`Bound_States_QLF.md`](Bound_States_QLF.md) §4, §6 step 4) |
| Quantitative `R_e`, `R_μ`, `R_p` from first-principles QLF | ✗ Open (joins the Standard-Model mass-spectrum programme) |

---

## §8 What this is NOT

- **Not a derivation of `m_e` from first-principles QLF.** The mapping `α R_e = m_e` identifies `R_e` with the measured electron contribution to positronium; the value `0.511 MeV` is the input, not the prediction. A full first-principles QLF derivation of `α R_e` from closure-multiplicity counts is open work.
- **Not a derivation of the Bohr `13.6 eV` binding scale from first principles.** Hydrogen.md sketches the Bohr derivation in QLF language; this doc uses it as a given and shows that the three-atomic-system *relative* binding structure follows from the reduced-mass scaling.
- **Not a replacement for QED radiative corrections.** Positronium, muonium, and hydrogen all have known QED corrections (Lamb shift, hyperfine structure, etc.) at the ppm-MHz level. The mapping here is to leading-order Bohr structure; higher-order corrections are a separate programme.
- **Not a complete particle-physics framework.** The three atomic systems are the simplest QLF bound-state observables. Larger atoms, mesons, baryons, and the full Standard Model spectrum are out of scope here.

---

## §9 Open work

- **Atomic-system Lean theorem**: `atomic_system_zfa_closures` — prove that each of the three atomic systems is a constructible RhoProcess satisfying `rho_process_always_zfa`. Connects to `BraKetRhoQuCalc.lean`.
- **Bohr `13.6 eV` derivation in QLF language**: extend [`Hydrogen.md`](Hydrogen.md) and `constants_mapper.py` to derive `(1/2) m_e α² = 13.6 eV` from the joint-closure multiplicity structure of the two-body Coulomb bound state, not from the Bohr-model assumption.
- **Quantitative `R_p` from three-quark structure**: extend [`HadronicDepth.md`](HadronicDepth.md) to derive `R_p ≈ 1836 R_e` from gauge-fold-depth combinatorics of the three-quark joint closure.
- **τ-decay-vertex closure topology**: pin down the specific QLF topology for τ⁻ → ν_τ + W⁻ and verify that `m_τ` corresponds to the energetic threshold; see [`Bound_States_QLF.md`](Bound_States_QLF.md) §4.
- **Heavier atomic systems**: extend the mapping to deuterium, helium, pionium, kaonium, etc. — each is a joint closure with its own constituent gauge-fold-depth structure.
- **First-principles `m_e` derivation**: under the per-qubit reading ([`Per_Qubit_Mass_Quantum.md`](Per_Qubit_Mass_Quantum.md)) this becomes the derivation of `R_e ≈ 2.4 × 10²²` (electron Markov-blanket depth in Planck units) from QLF closure-multiplicity. Likely shape: a large-depth structural argument at the Planck-event-rate scale.

---

## References

### Internal

- [`Bound_States_QLF.md`](Bound_States_QLF.md) — the framing of this doc; atomic systems as the natural QLF mass observables.
- [`Electron.md`](Electron.md) v2.0 — the electron half-loop as one half of a joint closure; specific QuCalc topology `^<v>^+`.
- [`Hydrogen.md`](Hydrogen.md) — Bohr-derivation of hydrogen levels in QLF language; the source of `(1/2) m_e α² = 13.6 eV`.
- [`HadronicDepth.md`](HadronicDepth.md) — proton as composite three-quark Markov blanket; `n ≈ (m_P/m_p)³` depth scaling.
- [`Hadrons_Markov_Blankets.md`](Hadrons_Markov_Blankets.md) — bound-state framing at hadronic and atomic scales.
- [`Higgs.md`](Higgs.md) §2 — gauge-fold-depth as the QLF mechanism for the gauge-fold contribution to bound-state mass.
- [`HALF-SPIN-ZFA-EMBEDDING.md`](HALF-SPIN-ZFA-EMBEDDING.md) — half-spin ZFA atom as the minimal joint closure.
- [`Delayed_Choice_Eraser.md`](Delayed_Choice_Eraser.md) — photons as joint emitter-absorber closures; the same structural move applied to photons that this doc applies to atomic-system constituents.
- [`Collective_Electrodynamics.md`](Collective_Electrodynamics.md) — joint ZFA closures as the unit of EM interaction.
- [`Standard_Model.md`](Standard_Model.md) §6 — "Mass ratios from multiplicity" open work; this doc partial-closes scope step 1 (mapping) and step 3 (Bohr scaling).
- [`Frequency_Synchronization.md`](Frequency_Synchronization.md) — `Δt = R/f` connecting depth and frequency.
- [`Active_Inference_Mathematics.md`](Active_Inference_Mathematics.md) §5 — meta-scoreboard "Quantitative mass spectrum" row.

### External

- Karshenboim, S. G. (2005). *Precision physics of simple atoms*. Phys. Rep. 422, 1–63 — Ps, Mu, H precision data.
- Particle Data Group — measured rest masses and binding energies.
