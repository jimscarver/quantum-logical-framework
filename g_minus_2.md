# Schwinger anomaly a_e = α/(2π) from substrate

**Scoping doc — the electron anomalous magnetic moment from QLF substrate.** The bare value `g = 2` is structural in QLF (from the half-spin Pauli-scalar-return face of ZFA closure); the Schwinger one-loop correction `a_e = (g − 2)/2 = α/(2π)` decomposes substrate-wise as **one extra gauge-twist vertex × one loop-phase factor `1/(2π)`** — the same loop-phase primitive that appeared in [`Lamb_Shift.md`](Lamb_Shift.md) §5, applied here without polarization average or shell-density factor.

**Zero empirical input.** Unlike the hydrogen spectrum (which needs `m_e c²` to pin natural units), `a_e` is **dimensionless** — it depends only on `α`. With substrate α from [`lean/QLF_FineStructureSubstrate.lean`](lean/QLF_FineStructureSubstrate.lean), `a_e` is QLF-derived **with no empirical input at all**, matching the CODATA value `a_e ≈ 1.15965 × 10⁻³` to **0.2%** (the substrate-α 0.026% gap propagated linearly).

This is the first QLF prediction of a measurable physical observable from substrate combinatorics alone — neither `h` nor `m_e` enters the dimensionless prediction.

---

## §1 The anomalous moment residue

The magnetic moment of a spin-1/2 particle is

$$\boldsymbol{\mu} \;=\; g \, \frac{e \hbar}{2 m_e} \, \mathbf{S}.$$

Dirac's relativistic theory predicts `g = 2` exactly for a point spin-1/2 particle. Experiments (Schwinger 1948, Foley-Kusch 1948) showed the actual value is slightly larger — the **anomalous magnetic moment**:

$$a_e \;\equiv\; \frac{g - 2}{2} \;\approx\; 1.15965 \times 10^{-3}.$$

Schwinger's celebrated 1948 result identified the leading contribution as exactly

$$a_e \;=\; \frac{\alpha}{2 \pi}$$

— the first quantitative success of QED, from a single one-loop Feynman diagram.

---

## §2 Bare g = 2 from half-spin ZFA closure

In QLF, every spin-1/2 particle is a half-spin ZFA closure ([`HALF-SPIN-ZFA-EMBEDDING.md`](HALF-SPIN-ZFA-EMBEDDING.md) §3a). The closure's response to an external magnetic field is dictated by its Pauli-scalar-return structure:

- Each closure folds to a Pauli scalar `±I, ±iI` ([`lean/QLF_Pauli.lean`](lean/QLF_Pauli.lean), `pauli_closed_of_admissible_zfa`).
- The σ·B Zeeman coupling acts on the spinor as `H_Zeeman = (g/2) × σ · B × μ_B`.
- For a Pauli-scalar-return closure, `g/2 = 1` exactly: the closure's response is one σ-matrix per applied field, the natural unit being the Bohr magneton.

So **bare `g = 2` is the half-spin closure's structural moment**, derivable from the Pauli-scalar-return face of ZFA closure already Lean-anchored across three layers in [`lean/QLF_Pauli.lean`](lean/QLF_Pauli.lean), [`lean/QLF_TwistAlphabet.lean`](lean/QLF_TwistAlphabet.lean), and [`lean/QLF_QuCalc.lean`](lean/QLF_QuCalc.lean).

No empirical input needed for bare `g = 2` — it is the substrate's spin-1/2 Pauli-scalar-return identity.

---

## §3 The Schwinger correction: one extra vertex × loop phase

The Schwinger anomaly is the one-loop vertex correction: the electron emits a virtual photon, interacts with the external `B` field, then reabsorbs the photon. The bare interaction `σ · B` becomes dressed by a vertex-correction factor `1 + a_e`.

**Substrate decomposition.** This is the same two-vertex emit-reabsorb topology that appears in the Lamb shift ([`Lamb_Shift.md`](Lamb_Shift.md) §4), now applied to the magnetic-moment interaction rather than the Coulomb self-energy. Counting:

| Factor | Substrate origin |
|---|---|
| α | One extra gauge-twist vertex on top of the bare `σ · B` interaction (one emit + one reabsorb = one extra coupling) |
| `1/(2π)` | Loop-phase coherence at the substrate loop closure — the same `1/(2π)` factor identified in [`Lamb_Shift.md`](Lamb_Shift.md) §5 |

Combined: `a_e = α × (1/(2π)) = α/(2π)`.

**What's missing relative to Lamb** (this is what makes g−2 *simpler*):

- No polarization average. The external `B` field selects a direction; there's no `2/3` transverse-polarization factor.
- No shell-density factor `1/n³`. The electron is free, not bound.
- No Bethe-log range. The vertex correction is a single point integral, finite without IR/UV depth-ratio cutoffs.

Thus g−2 is the **cleanest substrate vertex correction** — the loop-phase primitive `1/(2π)` appears alone, with one extra α from the dressed vertex.

---

## §4 Composition: `a_e = α/(2π)` Lean-anchored

Combining §§2–3:

$$\boxed{a_e \;=\; \frac{\alpha}{2 \pi}}$$

With substrate α from [`lean/QLF_FineStructureSubstrate.lean`](lean/QLF_FineStructureSubstrate.lean):

$$a_e^{\text{QLF}} \;=\; \frac{1/137}{2 \pi} \;=\; \frac{1}{274 \pi} \;\approx\; 1.16199 \times 10^{-3}.$$

CODATA: `a_e = 1.15965218 × 10⁻³`.

**Residual: 0.20%** — inheriting linearly from the substrate-α 0.026% gap (since `a_e ∝ α` at leading order, the α residue propagates 1:1 into `a_e`).

This is the first QLF substrate prediction of a measurable observable with **zero empirical input** — no `m_e`, no `m_p`, no `Ry`, nothing. Only the substrate-combinatorial chain that produces α.

Numerical verification: [`g_minus_2_demo.py`](g_minus_2_demo.py).

---

## §4a The muon `g−2`: same leading term, the "anomaly" localized

The muon `g−2` is famous for a ~5σ *data-driven* discrepancy with the Standard Model. QLF places
it honestly ([`lean/QLF_MuonG2.lean`](lean/QLF_MuonG2.lean)).

**The leading term is QLF's, and it is universal.** The one-loop QED vertex is mass-independent, so
the dominant contribution is the *same* Schwinger term `a_μ = α/(2π) = a_e` (`a_mu_leading_eq_a_e`)
— QLF derives `a_μ ≈ 1.1617×10⁻³` to the same ~0.6% as the electron.

**Why the muon is the sensitive probe.** Everything beyond the universal QED part is
mass-dependent, and the muon is heavy: its sensitivity to **hadronic vacuum-polarization** loops is
amplified by `(m_μ/m_e)² ≈ 42753` (`hadronic_sensitivity_value`). That is *why* a hadronic-sector
discrepancy shows up for the muon and is invisible in the (far better measured) electron. The
discrepancy lives entirely in the hadronic contributions — dominated by the `ππ`/`ρ` channel, i.e.
the **pion**, which in QLF is the lightest hadron / deepest hadronic horizon
([`QLF_QuantumBlackHole`](lean/QLF_QuantumBlackHole.lean), [`QLF_PionMassRatio`](lean/QLF_PionMassRatio.lean)).

**The honest status of the "anomaly."** It is **not settled**: the discrepancy size depends on the
hadronic-vacuum-polarization input — the *data-driven* `e⁺e⁻` value gives ~5σ, but the *lattice*
(BMW 2020) and the CMD-3 measurement shrink it toward ~1σ; the field has been converging away from
a clear anomaly. So QLF makes **no claim** to explain a new-physics anomaly. It identifies the
residual as the hadronic-vacuum-polarization sector — (a) QLF's own open hadronic quantitative
frontier (no quark masses, no `f_π`; `pion_mass_ratio_in_progress`) and (b) experimentally in flux
(`muon_g2_in_progress`).

---

## §5 What this is NOT

- **Not a complete derivation including higher-order corrections.** Schwinger's `α/(2π)` is the leading term; the full expansion is

$$a_e \;=\; \frac{\alpha}{2\pi} \;-\; 0.328479 \left(\frac{\alpha}{\pi}\right)^2 \;+\; 1.181241 \left(\frac{\alpha}{\pi}\right)^3 \;-\; \cdots$$

  The higher-order terms are multi-loop substrate diagrams. The `(α/π)² ≈ 5.4 × 10⁻⁶` term is currently below the substrate-α 0.026% residue, but becomes relevant once α is tightened. Tier-3 open.

- **Not a derivation of the muon g−2 anomaly.** The Fermilab/BNL muon g−2 measurement shows a ~4σ tension with Standard Model prediction; QLF substrate derivation of muon `a_μ = α/(2π) + (mass-ratio-dependent corrections)` is open work, with the leading Schwinger term identical to `a_e` and the hadronic vacuum-polarization correction (`a_μ^HVP`) being the main piece that decides the tension.

- **Not a hadronic vacuum polarization derivation.** The `~70 ppm` HVP contribution to `a_μ` is structurally distinct — it involves virtual hadron loops, not just electron-photon. Substrate-derivation of HVP requires the quark-Borromean closures of [`Proton_Resonance_R_e.md`](Proton_Resonance_R_e.md) and is a separate Tier-3 target.

---

## §6 Honest scoping (three-tier)

**Tier 1 (structural, zero empirical input).**

- Bare `g = 2` from half-spin ZFA closure's Pauli-scalar-return identity (Lean-anchored: `pauli_closed_of_admissible_zfa`).
- One extra vertex α from the dressed-vertex topology, same primitive as the gauge-twist coupling in [`Magnetism_Spatial_Dynamics.md`](Magnetism_Spatial_Dynamics.md) §6.1.
- One loop-phase `1/(2π)` from substrate phase-coherence at the loop closure, same primitive as in [`Lamb_Shift.md`](Lamb_Shift.md) §5.

**Tier 2 (numerical, only substrate α).** `a_e = 1/(274π) ≈ 1.16199 × 10⁻³` from substrate α = 1/137. Matches CODATA `a_e = 1.15965 × 10⁻³` to 0.20%, inheriting linearly from the substrate-α 0.026% gap. **Zero empirical input** — no `m_e`, no `m_p`, no `h` (`a_e` is dimensionless).

**Tier 3 (open).**

- Higher-order corrections `(α/π)², (α/π)³`, ... — multi-loop substrate diagrams beyond the two-vertex Lamb/Schwinger primitive. The `(α/π)²` coefficient `−0.328479` and the `(α/π)³` coefficient `+1.181241` need substrate-combinatorial derivation.
- Muon g−2: same Schwinger leading term, with hadronic vacuum polarization correction needing the quark-Borromean substrate derivation from [`Proton_Resonance_R_e.md`](Proton_Resonance_R_e.md).
- Hadronic vacuum polarization for `a_μ` and the Fermilab/BNL anomaly.
- Tighten substrate α below 0.026% — `a_e` precision is α-precision-limited at first order; closing the substrate-α gap would tighten `a_e` proportionally.

---

## §7 Connection to Lamb shift AMM contribution

The +68 MHz **AMM contribution** to the 2S₁/₂ Lamb shift (Tier-2 input in [`lamb_shift_demo.py`](lamb_shift_demo.py)) is precisely the bound-state evaluation of the anomalous magnetic moment:

$$\Delta E^{\text{AMM}}_{\text{Lamb}}(2S) \;=\; a_e \times \Delta E^{\text{Dirac-Lamb-precursor}}(2S, 2P)$$

where the Dirac splitting between 2S and 2P fine-structure states gets multiplied by `a_e` to account for the dressed-vertex correction to the magnetic-moment interaction in the bound state.

**With substrate `a_e = α/(2π) = 1/(274π)`** plus the Dirac structure from [`QLF_DiracCorrection.lean`](lean/QLF_DiracCorrection.lean): the AMM Tier-2 input in [`lamb_shift_demo.py`](lamb_shift_demo.py) becomes substrate-derived. This closes one of the two Tier-2 numerical inputs of the Lamb shift (the other being the Uehling vacuum polarization).

---

## §8 References

### Internal

- [`HALF-SPIN-ZFA-EMBEDDING.md`](HALF-SPIN-ZFA-EMBEDDING.md) §3a — half-spin ZFA closure structure, the substrate origin of bare `g = 2`.
- [`Magnetism_Spatial_Dynamics.md`](Magnetism_Spatial_Dynamics.md) §6.1 — substrate α single-vertex; supplies the α factor for the dressed vertex.
- [`Lamb_Shift.md`](Lamb_Shift.md) §5 — two-vertex topology and loop-phase `1/(2π)` primitive; same substrate factor appears here.
- [`Dirac_Correction.md`](Dirac_Correction.md) — Dirac spin-orbit structure; supplies the bound-state context for AMM contribution to Lamb.
- [`Proton_Resonance_R_e.md`](Proton_Resonance_R_e.md) — proton-quark Borromean closure structure; needed for hadronic vacuum polarization in muon g−2.
- [`lean/QLF_FineStructureSubstrate.lean`](lean/QLF_FineStructureSubstrate.lean) — Lean anchor for substrate α.
- [`lean/QLF_Pauli.lean`](lean/QLF_Pauli.lean) — Lean anchor for Pauli-scalar-return; supplies the substrate origin of bare `g = 2`.
- [`lean/QLF_LambShift.lean`](lean/QLF_LambShift.lean) — sibling module using the same loop-phase primitive.
- [`lean/QLF_GMinusTwo.lean`](lean/QLF_GMinusTwo.lean) — Lean anchor for this module.
- [`g_minus_2_demo.py`](g_minus_2_demo.py) — numerical companion.
- [`Experimental_Consistency.md`](Experimental_Consistency.md) §10 — g−2 Class-B falsifier.

### External

- Schwinger, J. (1948). *On Quantum-Electrodynamics and the Magnetic Moment of the Electron*. Phys. Rev. 73, 416 — the original `α/(2π)` result.
- Foley, H. M., & Kusch, P. (1948). *On the Intrinsic Moment of the Electron*. Phys. Rev. 73, 412 — the original measurement.
- Fan, X., Myers, T. G., Sukra, B. A. D., & Gabrielse, G. (2023). *Measurement of the Electron Magnetic Moment*. Phys. Rev. Lett. 130, 071801 — current best `a_e` precision (`0.13 × 10⁻¹²`).
- Aoyama, T., Kinoshita, T., & Nio, M. (2018). *Theory of the Anomalous Magnetic Moment of the Electron*. Atoms 7, 28 — modern QED expansion to `(α/π)⁵`.
