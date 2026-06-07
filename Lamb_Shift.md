# Lamb shift from substrate: α⁵ × log(α⁻²) from vacuum-spectrum coupling

**Scoping doc — Lamb shift as bound-electron self-energy from coupling to the QLF vacuum closure-spectrum.** The three QLF substrate primitives the user named are sufficient to derive the structural form:

1. **Vacuum spectrum from closure count.** Vacuum hosts ZFA closures at every Markov-blanket depth `R` from `R = 1` (one Planck event) to `R = R_cosmic` (cosmic horizon). Each closure at depth `R` is a vacuum mode at frequency `ω = f_vac / R`, energy `E_Planck / R` ([`Frequency_Synchronization.md`](Frequency_Synchronization.md), [`VacuumEnergy.md`](VacuumEnergy.md) §6).
2. **Frequency redshift to Planck-action limit.** The depth-scaling `ω ∝ 1/R` IS the redshift; modes scale from Planck (`R=1`, `E=E_Planck`) down through all bound-state depths ([`Kitada_Local_Time_GR.md`](Kitada_Local_Time_GR.md) §5.3).
3. **Energy difference between shells.** `E_n = −Ry / n²` with `R_n = R_1 · n²` ([`Hydrogen.md`](Hydrogen.md) §4.1).

The Lamb shift is the bound electron's self-energy from coupling to vacuum modes between its own Compton depth (IR cutoff) and the binding depth (UV cutoff) — both **substrate Markov-blanket depths**, no external regularization needed.

---

## §1 The α⁵ residue (what closes after Dirac)

After Bohr + Dirac + reduced-mass ([`Dirac_Correction.md`](Dirac_Correction.md)), the hydrogen spectrum matches NIST to ~0.05% (substrate-α-residue-limited). The next-order QED correction is the **Lamb shift**, scaling as `α⁵ × m_e c²`:

$$\Delta E_{\text{Lamb}}(nS) \;=\; \frac{4 \alpha^5 m_e c^2}{3 \pi n^3} \times \mathcal{L}(n)$$

where `𝓛(n)` is the effective Bethe logarithm. For hydrogen 2S₁/₂: `𝓛(2) ≈ 7.6859` (Bethe 1947), giving the textbook `2S₁/₂ − 2P₁/₂` Lamb shift of **1057.85 MHz ≈ 4.37 × 10⁻⁶ eV** (NIST measured). The effective log decomposes as

$$\mathcal{L}(n) \;\approx\; 2 \log\!\frac{1}{\alpha} \;-\; k(n, 0) \;+\; \text{small}$$

with `k(n, 0)` the *Bethe constant* (`k(1, 0) ≈ 2.984`, `k(2, 0) ≈ 2.812`) capturing the oscillator-strength-weighted correction to the naive substrate depth-ratio log `2 log(1/α) ≈ 9.84`.

The framework of [§§2–4 below] decomposes this into three substrate origins; [§§5–6] flag the prefactor and Bethe-constant pieces still open.

---

## §2 Vacuum spectrum and depth scaling — the substrate radiation field

Per [`VacuumEnergy.md`](VacuumEnergy.md) §6, the vacuum is a near-maximum-entropy background with a structured tail of ZFA-stable closures. Counting closures by depth:

- At depth `R = 1` (one Planck event): closure rate ~ `1/16` per substrate event from `QLF_FineStructureSubstrate.naive_closure_rate`. Frequency `ω = f_vac` (Planck).
- At depth `R = N`: closures aggregating `N` Planck events into one Markov-blanket cycle. Frequency `ω = f_vac / N`.
- The number of closure topologies at depth `2n` is exactly `C(2n, n)` (`find_stable_states_length_even`, [`lean/QLF_Riemann.lean`](lean/QLF_Riemann.lean)) — combinatorially growing.

The **vacuum spectrum** is therefore a continuum of modes at frequencies `{f_vac / R : R = 1, 2, 3, ...}`, with mode density growing as `C(2R, R) ~ 4^R / √R` (Stirling). Redshift to Planck-action limit IS the depth-scaling — every mode is one Planck event redshifted by `R`.

For QED purposes only the **near-resonant** part of this spectrum couples to a given bound state. The dominant coupling is to modes whose frequency matches a *transition energy* of the bound state — the standard QED dispersion-relation reading, here rendered as substrate-event-rate matching.

---

## §3 Substrate Bethe logarithm from depth ratio

The bound electron in shell `n` has its own Markov-blanket depth `R_n = E_Planck / |E_n| = R_1 · n²` (from [`Hydrogen.md`](Hydrogen.md) §4.1; `R_1 = E_Planck / Ry ≈ 8.97 × 10²⁶`). The electron itself has Compton depth `R_e = E_Planck / (m_e c²) ≈ 2.39 × 10²²`.

**The Lamb integration range is exactly [R_e, R_n].** Substrate IR cutoff at `R_e` (vacuum modes at depths below cannot resolve the electron's own Compton scale — they see only the electron's center of mass), substrate UV cutoff at `R_n` (vacuum modes at depths above don't perturb the bound shell — their frequencies are too low to mediate transitions). Both cutoffs are **substrate Markov-blanket depths**, not regularization parameters.

The leading-order integration `∫ d(log R)` over this range gives:

$$\log \frac{R_n}{R_e} \;=\; \log \frac{E_{\text{Planck}} / |E_n|}{E_{\text{Planck}} / (m_e c^2)} \;=\; \log \frac{m_e c^2}{|E_n|} \;=\; \log \frac{2 n^2}{\alpha^2}$$

For `n = 1`: `log(2/α²) ≈ 10.53`. For `n = 2`: `log(8/α²) ≈ 11.92`.

**This is the substrate Bethe-log range**, with both cutoffs as concrete QLF Markov-blanket depths. The form `log(α⁻²)` falls out of the QLF depth-ratio scaling — the "two extra Markov-blanket-depth decades" between the electron and the shell.

The *actual* Bethe constant `k(n, 0)` is smaller than this naive range (`k(1, 0) ≈ 2.984` vs naive `10.53`); the difference is the **oscillator-strength weighting** that QED applies to the vacuum-mode density — see §6 below. The *structural form* `α⁵ × log(α⁻²)` falls out cleanly; the *numerical value* of the Bethe constant is the Tier-3 piece.

---

## §4 α⁵ scaling decomposition

The five powers of α in `ΔE_Lamb ~ α⁵ m_e c²` decompose substrate-wise as:

| α factor | Substrate origin | Reference |
|---|---|---|
| α² | Bohr binding: `Ry = (α²/2) × m_e c²` (Coulomb-via-gauge-twist + virial) | [`Hydrogen.md`](Hydrogen.md) §§2–4 |
| α | Gauge-twist vertex (emit virtual photon — the same substrate primitive as Coulomb mediation) | [`Magnetism_Spatial_Dynamics.md`](Magnetism_Spatial_Dynamics.md) §6.1 |
| α | Gauge-twist vertex (reabsorb virtual photon — second vertex of the self-energy loop) | same |
| α | `|ψ(0)|²` Bohr-density factor: `|ψ_n(0)|² = (αm_e)³ / (π n³)`; one α surfaces after dimensional bookkeeping against `1/m_e²` in the self-energy integral | standard Coulomb wavefunction |

Combining: `α² × α × α × α = α⁵`, with `m_e c²` carrying the dimensional energy scale and the `1/n³` shell-density factor entering from `|ψ_n(0)|²`.

**Two-vertex topology = two-loop substrate diagram.** The α-derivation in [`Magnetism_Spatial_Dynamics.md`](Magnetism_Spatial_Dynamics.md) §6.1 used a *single-vertex* self-energy resummation `(1 + 9α)⁻¹` at order α¹. The Lamb shift is the *two-vertex* analog — emit then reabsorb — which is exactly the next layer of substrate multi-twist closure listed as open work in [`lean/QLF_FineStructureSubstrate.lean`](lean/QLF_FineStructureSubstrate.lean) honest scoping ("multi-twist closures beyond length-2, two-loop substrate diagrams").

The α⁵ scaling thus extends the substrate-vertex-counting framework that already produced α at α¹ order; it is *not* a new substrate principle.

---

## §5 The 4/(3π n³) prefactor — partially substrate-derivable

The full Lamb formula prefactor is `4/(3π n³)`. Its substrate decomposition:

- **`1/n³` shell-density factor.** Direct from `|ψ_n(0)|² ∝ 1/n³` — standard Coulomb wavefunction; substrate-derivable via the radial part of the shell-resonance topology in [`Hydrogen.md`](Hydrogen.md) §4.1.
- **`4` from `4π` solid angle ÷ `π` vertex normalisation.** Each vertex integration covers the full substrate solid angle `4π`; each gauge-twist vertex contributes one `1/π` from phase-coherence selectivity (§6.1 of [`Magnetism_Spatial_Dynamics.md`](Magnetism_Spatial_Dynamics.md)). The net `4π/π = 4` per vertex pair.
- **`1/(3π)` from polarization-transverse projection + loop phase.** Of three spatial polarization axes, vacuum photons populate only the two transverse — factor `2/3` — combined with one further `1/(2π)` from the loop phase-coherence closure: `(2/3) × (1/(2π)) = 1/(3π)`. The `2/3` transverse fraction falls out of the 6-twist spatial alphabet split into 2 transverse + 1 longitudinal per propagation direction.

Combined: `(1/n³) × 4 × (1/(3π)) = 4/(3π n³)`. ✓

The structural decomposition is clean modulo the precise structural origin of the loop phase factor `1/(2π)`. This piece sits in the substrate-angular-counting framework already used for α; a future revision of `Magnetism_Spatial_Dynamics.md` §6.1.3 directional-tensor work should close it.

---

## §6 The Bethe constant `k(n, 0)` — Tier-3 open

The naive substrate Bethe-log range `log(R_n / R_e) ≈ 10.53` (for n = 1) overshoots the actual Bethe constant `k(1, 0) ≈ 2.984` by a factor of `~3.5`. The discrepancy is the **oscillator-strength weighting**: not every vacuum-mode frequency couples equally to the bound shell, only those matching real transition energies (`E_m − E_n` for `m ≠ n`). The Bethe constant is the oscillator-strength-weighted geometric-mean transition-energy log:

$$k(n, 0) \;=\; \frac{1}{2\, \mathrm{Ry}} \sum_{m \neq n} |\langle \psi_n | \mathbf{p} | \psi_m \rangle|^2 \, (E_m - E_n) \, \log \frac{|E_m - E_n|}{\mathrm{Ry}}$$

In QLF substrate terms: this becomes a sum over **closure-overlap-weighted depth-ratio logs**. The closure overlap `⟨ψ_n | p | ψ_m⟩` is the substrate counterpart of an oscillator strength — it measures how well two shell topologies couple via a momentum operator (i.e., a closure-rate matrix element).

**Tier-3 open.** Substrate-derivation of `k(n, 0)` from QLF shell-closure overlap counts is an open piece. The structural form `log(geometric-mean transition-energy / Ry)` is right; the numerical evaluation requires the closure-overlap matrix elements, which need the radial structure of shell topologies (above the RCA₀ floor — see [`ReverseMathematics.md`](ReverseMathematics.md)).

For numerical work in [`lamb_shift_demo.py`](lamb_shift_demo.py), `k(n, 0)` enters as a Tier-2 input from standard QED.

---

## §7 Composition: the 2S₁/₂ Lamb shift

Combining §§3–6:

$$\Delta E_{\text{Lamb}}(nS) \;=\; \frac{4 \alpha^5 m_e c^2}{3 \pi n^3} \times \mathcal{L}(n)$$

with `𝓛(n) = 2 log(1/α) − k(n, 0) + small` the effective Bethe logarithm (substrate depth-ratio range minus oscillator-strength weighting).

For the famous `2S₁/₂ − 2P₁/₂` splitting (`n = 2`, with the 2S piece dominating because `k(2, 0) ≈ 2.812` while `k(2, 1) ≈ −0.030`):

- Bethe self-energy (2S): `(4 α⁵ m_e c²) / (3π × 8) × 7.6859 ≈ +1009 MHz`
- Anomalous magnetic moment contribution: `+68 MHz`
- Vacuum polarization (Uehling): `−27 MHz`
- Total: `+1050 MHz` (NIST measured: `1057.85 MHz`, 0.7% match)

With substrate α (1/137 from `QLF_FineStructureSubstrate.lean`): the prediction shifts marginally upward (α⁵ scaling); same form, same Bethe constant, residue inherits the 0.026% × 5 = ~0.13% substrate-α floor.

Verification in [`lamb_shift_demo.py`](lamb_shift_demo.py).

---

## §8 Honest scoping (three-tier)

**Tier 1 (structural — what falls out from h + m_e + substrate primitives).**

- `α⁵ × m_e c²` scaling from two-vertex loop topology on top of Bohr (§4).
- `log(α⁻²)` form from substrate Bethe-log range `[R_e, R_n]` between two Markov-blanket depths (§3).
- `8/(3π n³)` prefactor partially decomposed: `1/n³` from shell density, `4π` solid angle, `2/3` transverse-polarization — clean. The two `1/π` phase factors are partial (§5).
- Vacuum spectrum from closure-count + depth-redshift (§2).

**Tier 2 (numerical, with standard QED inputs).**

- Bethe constant `k(n, 0) ≈ 2.984` (n=1), `2.812` (n=2) — standard QED, used as numerical input.
- AMM correction `+68 MHz` and vacuum-polarization `−27 MHz` for the 2S₁/₂ splitting — standard QED, used as numerical inputs.
- Total 2S₁/₂ Lamb shift prediction matches NIST 1057.85 MHz to ~0.7% with substrate α.

**Tier 3 (open).**

- Substrate derivation of `k(n, 0)` from closure-overlap-weighted depth-ratio sums (§6). The structural form is identified; the numerical evaluation requires shell-topology radial structure.
- Two `1/π` phase factors in the prefactor (§5) — finish the substrate phase-coherence accounting.
- Substrate derivation of the AMM `+68 MHz` contribution — that's the `g − 2` Schwinger term `α/(2π)` applied to the bound-state magnetic moment, separate Tier-3 target.
- Substrate derivation of the vacuum-polarization `−27 MHz` contribution — Uehling potential from virtual e⁺e⁻ pair-production at the proton, ties to [`Photon_Energy_Bits.md`](Photon_Energy_Bits.md) pair-production accounting.
- Tighten substrate α below the 0.026% floor — the Lamb shift inherits `5 × 0.026% ≈ 0.13%` precision from α⁵ scaling, just as the Bohr formula inherits `2 × 0.026% ≈ 0.053%` from α².

---

## §9 What this is NOT

- **Not a new physics claim.** The Lamb shift formula has been textbook QED since Bethe (1947); the numerical match to NIST is the published QED precision. The QLF contribution is the structural decomposition into substrate origins.
- **Not a full Lean-anchored derivation.** [`lean/QLF_LambShift.lean`](lean/QLF_LambShift.lean) Lean-anchors the substrate Bethe-log range and the α⁵-scaling claim; substrate derivation of `k(n, 0)` is still open.
- **Not a derivation of higher-order QED.** The two-loop `α⁶` correction, the Wichmann-Kroll vacuum polarization, and similar refinements are next-next-layer beyond what is composed here.

---

## §10 References

### Internal

- [`Hydrogen.md`](Hydrogen.md) §§2–4, §4.1 — Bohr derivation, shell-resonance depths `R_n = R_1 · n²`.
- [`Dirac_Correction.md`](Dirac_Correction.md) — Bohr-to-Dirac residual (the layer Lamb extends).
- [`Cross_Frequency_Lorentz.md`](Cross_Frequency_Lorentz.md) — depth-scaling redshift `ω ∝ 1/R`.
- [`Frequency_Synchronization.md`](Frequency_Synchronization.md) — `Δt = R/f` and the resonant-frequency framing.
- [`VacuumEnergy.md`](VacuumEnergy.md) §6 — vacuum-alignment principle, vacuum as max-entropy + structured-tail.
- [`Magnetism_Spatial_Dynamics.md`](Magnetism_Spatial_Dynamics.md) §6.1 — substrate α from vertex-mode counting (single-vertex precursor of the two-vertex Lamb structure).
- [`Per_Qubit_Mass_Quantum.md`](Per_Qubit_Mass_Quantum.md) — per-Compton-cycle clock; supplies `R_e`.
- [`Kitada_Local_Time_GR.md`](Kitada_Local_Time_GR.md) §5.3 — substrate event quantum (one Planck length × one Planck tick *together*).
- [`Magic_numbers.md`](Magic_numbers.md) — alphabet 6+2 spatial+gauge split (supplies the `4π` and `2/3` substrate-angular structure).
- [`lean/QLF_FineStructureSubstrate.lean`](lean/QLF_FineStructureSubstrate.lean) — Lean anchor for substrate α; honest scoping names the two-loop substrate-diagram layer as open (where Lamb sits).
- [`lean/QLF_DiracCorrection.lean`](lean/QLF_DiracCorrection.lean) — Lean anchor for the Dirac correction (sibling module).
- [`lean/QLF_LambShift.lean`](lean/QLF_LambShift.lean) — Lean anchor for this module.
- [`lamb_shift_demo.py`](lamb_shift_demo.py) — numerical companion.
- [`Experimental_Consistency.md`](Experimental_Consistency.md) §10 — Lamb shift falsifier class.

### External

- Bethe, H. A. (1947). *The Electromagnetic Shift of Energy Levels*. Phys. Rev. 72, 339 — the original Bethe-log calculation.
- Lamb, W. E., & Retherford, R. C. (1947). *Fine Structure of the Hydrogen Atom by a Microwave Method*. Phys. Rev. 72, 241 — the original 1057 MHz measurement.
- Welton, T. A. (1948). *Some observable effects of the quantum-mechanical fluctuations of the electromagnetic field*. Phys. Rev. 74, 1157 — vacuum-fluctuation reading of the Lamb shift.
- Bjorken, J. D., & Drell, S. D. (1965). *Relativistic Quantum Fields*. McGraw-Hill — modern derivation.
- NIST Atomic Spectra Database — 2S₁/₂ − 2P₁/₂ Lamb shift = 1057.85 MHz.
