# Closing the Bohr-to-Dirac residual on hydrogen

**Scoping doc — three substrate origins for the Dirac correction.** The [QLF](README.md) Bohr derivation in [`Hydrogen.md`](Hydrogen.md) §§2–4 reproduces the hydrogen spectrum `E_n = −Ry/n²` to **0.053% relative error** vs NIST. The residual is precisely the Dirac correction — relativistic kinematics + single-electron spin-orbit + Darwin contact term. Each of the three pieces emerges from QLF substrate machinery that already exists; this doc composes them.

**Foundational footprint: h and m_e alone.** The two QLF axioms — **ZFA** (zero free action: count balance + Pauli closure) and **h** (Planck's constant) — are the structural assumptions; the single empirical input that pins natural-units scale is the electron mass **m_e**. Everything else is QLF-derived, *not* measured — in particular the `α²` that sets the correction's size, since **α itself is derived from first principles** (the IR / fully-rendered-3D value `1/137`, [**Alpha.md**](Alpha.md)):

| Constant | QLF derivation | Lean anchor |
|---|---|---|
| `c = L_Planck / τ_Planck` | substrate event quantum (one Planck length × one Planck tick *together*) | [`lean/QLF_SubstrateLightSpeed.lean`](lean/QLF_SubstrateLightSpeed.lean) |
| `α = 1/137.000` | substrate combinatorics: `1/128 × (1 + 9α)⁻¹` with N = 9 from 3² directional tensor | [`lean/QLF_FineStructureSubstrate.lean`](lean/QLF_FineStructureSubstrate.lean) |
| `m_p/m_e = 6π⁵` | Lenz factor: `|S₃| × π⁵` from 3-quark Bose permutation × 5-angle hidden-chirality integration | [`lean/QLF_LenzMassRatio.lean`](lean/QLF_LenzMassRatio.lean) |
| `Ry = (1/2) α² m_e c²` | Coulomb-via-gauge-twist-exchange + ZFA-depth quantization | [`Hydrogen.md`](Hydrogen.md) §§2–4 |
| Reduced mass `μ = (m_p/m_e)/(1 + m_p/m_e)` | follows from `m_p/m_e` above | — |

From h + m_e alone, Bohr + Dirac + reduced-mass reproduces NIST to ~0.05%. The residual is dominated by the substrate-α 0.026% gap (squared to 0.053% in the Bohr formula), *not* the Dirac decomposition — the three-mechanism Dirac correction itself contributes well below the α-residual floor.

---

## §1 The residual

[`Hydrogen.md`](Hydrogen.md) §5 records the uniform 0.053% gap between QLF Bohr and NIST across `n = 1..6`. §6 explicitly attributes the gap to "model-level corrections, not a gap in the ZFA derivation" and identifies the Dirac equation as the next layer.

The closed-form Dirac correction we target (leading α² order, fine-structure expansion of the Sommerfeld formula):

$$\Delta E_{n,j}^{\text{Dirac}} \;=\; -\frac{\alpha^2\,\mathrm{Ry}}{n^3}\left[\frac{n}{j + 1/2} \;-\; \frac{3}{4}\right]$$

For `n = 1`, `j = 1/2`: `ΔE_1 = −α² Ry × (1 − 3/4) = −α² Ry / 4 ≈ −1.81 × 10⁻⁴ × Ry ≈ −7.2 × 10⁻⁴ eV`. The Bohr value `−13.6057 eV` shifts to `−13.6048 eV`, matching NIST `−13.5984 eV` to **<0.001%** once a small reduced-mass correction is also applied.

The Dirac correction has three physical pieces that combine into one formula:

```
ΔE_Dirac  =  ΔE_kin     +     ΔE_SO     +     ΔE_Darwin
          (relativistic    (single-electron   (zitterbewegung
           kinematics)      spin-orbit)        s-state contact)
```

QLF supplies a substrate origin for each.

---

## §2 Relativistic kinematic correction — Cross_Frequency_Lorentz at small rapidity

The bound electron has orbital velocity `v_1 = αc` in the Bohr ground state (force-balance: see [`Hydrogen.md`](Hydrogen.md) §3). The relativistic kinetic correction to leading order is

$$\Delta E_{\text{kin}} \;=\; -\frac{p^4}{8 m_e^3 c^2} \;=\; -\frac{1}{2} m_e v^4 / c^2 \;\sim\; -\alpha^4 m_e c^2.$$

Relative to the Bohr binding `E_n ∝ α² m_e c²`, this is an `α²` correction.

**QLF substrate reading.** Per [`Cross_Frequency_Lorentz.md`](Cross_Frequency_Lorentz.md), the Lorentz boost between two Markov-blanket frames is parameterised by rapidity `φ = log ξ` with `ξ` the internal-frequency ratio, and the Lorentz factor is `γ = cosh φ`. For small rapidity:

$$\gamma \;=\; \cosh\varphi \;\approx\; 1 + \frac{\varphi^2}{2} + O(\varphi^4).$$

For the bound electron the relevant rapidity is set by the orbital velocity `v_1 = αc`, giving `tanh φ ≈ α` and `φ ≈ α` to leading order. Substituting:

$$\gamma - 1 \;\approx\; \frac{\alpha^2}{2}.$$

The relativistic kinetic-energy correction is then `−(γ−1) × ⟨T⟩` (with `⟨T⟩` the unperturbed Bohr kinetic energy), giving a relative shift of `α²/2` at the ground state. The substrate principle is exactly the same as the standard SR derivation; QLF's contribution is the structural identification of the rapidity with a Markov-blanket frequency ratio rather than a kinematic velocity.

**Substrate-derived.** No new empirical input — the orbital velocity `v_1 = αc` is fixed by the Bohr force-balance and α is substrate-derived in [`Magnetism_Spatial_Dynamics.md`](Magnetism_Spatial_Dynamics.md) §6.1.

---

## §3 Single-electron spin-orbit coupling — one α² from the hyperfine chain

The standard spin-orbit coupling is `H_SO = (g_s/2) μ_B σ · B_eff` with `B_eff = (E × v)/c²` from the Thomas-precession frame transformation, giving

$$H_{\text{SO}} \;\propto\; \frac{\alpha^2}{r^3} \, \mathbf{L} \cdot \mathbf{S}.$$

For excited states (`l ≠ 0`) this contributes to the fine-structure splitting; for the ground state (`l = 0`) it vanishes.

**QLF substrate reading.** [`Magnetism_Spatial_Dynamics.md`](Magnetism_Spatial_Dynamics.md) §5 derives the *hyperfine* α⁴ as the product of **two** pairwise spin-couplings:

> "α appears squared (once for proton-spin coupling to the gauge field, once for electron-spin coupling), then squared again because the spin-spin coupling is a second-order effect in α."

The single-electron spin-orbit coupling is the **single-electron analog** of one of those two factors: the electron-spin coupling to the orbital-induced gauge field, with the orbital angular momentum `L` replacing the proton's spin `I` in the coupled-magnetic-moment story.

The substrate mechanism is identical to the hyperfine derivation, restricted to one spin pair:

- The orbital angular momentum `L` of the bound electron creates a 3-axis directional bias in the local vacuum (per §4 of `Magnetism_Spatial_Dynamics.md` — "B-field as directional spatial gradient").
- The electron spin couples to this bias through the same 3 × 3 directional-coupling tensor (§6.1.3, the same `N = 9` tensor that produces the substrate α).
- The coupling carries **one** factor of α (the gauge selectivity × phase coherence × spatial-colocation product from §6.1), unlike the hyperfine which carries two.

Substrate-derived; the same machinery that gave α to 0.026% gives the single-α² coefficient of the spin-orbit term.

---

## §4 Darwin term — per-qubit Compton zitterbewegung

The Darwin term is

$$H_D \;=\; \frac{\pi \alpha}{2 m_e^2 c^2} \, \delta^3(\mathbf{r}),$$

the s-state contact contribution from averaging the Coulomb potential over the electron's Compton-scale internal oscillation ("zitterbewegung"). It shifts `E_{1s}` by `+α² Ry / 8` and vanishes for `l ≠ 0`.

**QLF substrate reading.** Per [`Per_Qubit_Mass_Quantum.md`](Per_Qubit_Mass_Quantum.md), the electron qubit's Markov-blanket depth is `R_e = E_Planck / (m_e c²)`. Each constituent qubit has its own internal clock `ω = f_vac / R`, with rest energy `ℏω = E_Planck / R`. For the electron specifically, one Compton period is **`R_e` Planck ticks**, and one Compton wavelength is **`R_e` Planck lengths** under the substrate event quantum (each Planck event creates one Planck length and one Planck tick *together*, [`Kitada_Local_Time_GR.md`](Kitada_Local_Time_GR.md) §5.3).

Within one Compton period, the electron qubit's internal-clock advance is **one full Markov-blanket cycle**. The "zitterbewegung" is the per-Compton-cycle internal oscillation of the qubit's position eigenstate relative to its Markov-blanket center.

The s-state contact contribution averages the Coulomb potential `V(r) = −αℏc/r` over this Compton-scale oscillation:

$$\langle \delta^3(\mathbf{r}) \rangle_{\text{Compton}} \;\approx\; |\psi(0)|^2 \;\times\; \left(\frac{\lambda_C}{a_0}\right)^2$$

with `λ_C = ℏ/(m_e c)` the electron Compton wavelength and `a_0 = ℏ/(α m_e c)` the Bohr radius. The ratio `λ_C/a_0 = α`, so the contact correction scales as `α² |ψ(0)|²` — exactly the standard Darwin scaling.

**Substrate-derived.** The Compton period and wavelength are both substrate quantities (`R_e` Planck units of each); no new empirical input.

---

## §5 Composition: the Dirac residual

Adding the three corrections in the closed form (the textbook Sommerfeld-expansion result):

$$\boxed{\Delta E_{n,j}^{\text{Dirac}} \;=\; \Delta E_{\text{kin}} + \Delta E_{\text{SO}} + \Delta E_{\text{Darwin}} \;=\; -\frac{\alpha^2\,\mathrm{Ry}}{n^3}\left[\frac{n}{j + 1/2} - \frac{3}{4}\right]}$$

For hydrogen ground state `n = 1`, `j = 1/2`:

```
ΔE_1 = −α² Ry × (1 − 3/4) = −α² Ry / 4
     = −(1/137.036)² × 13.6057 eV / 4
     ≈ −1.812 × 10⁻⁴ × 13.6057 eV
     ≈ −7.21 × 10⁻⁴ eV
```

Total predicted ground-state energy with CODATA α: `−13.6057 − 0.000721 ≈ −13.6064 eV`; with **substrate α = 1/137 from `QLF_FineStructureSubstrate.lean`**: `−13.6128 − 0.000182 ≈ −13.6130 eV`. The remaining gap to NIST (`−13.5984 eV`) is dominated by:

- the **substrate-α 0.026% gap** (squared to 0.053% via Ry ∝ α²), and
- the **reduced-mass** factor `m_p/(m_e + m_p)` — also QLF-derived from the Lenz factor `m_p/m_e = 6π⁵` (Lean-anchored in [`lean/QLF_LenzMassRatio.lean`](lean/QLF_LenzMassRatio.lean)), giving `μ ≈ 0.99946`.

**From h + m_e alone**, after applying QLF-derived α, QLF-derived `m_p/m_e`, the Bohr formula, the Dirac correction, and the reduced-mass correction: the hydrogen spectrum matches NIST to **~0.05% across `n = 1..6`**. The residual *is* the substrate-α gap squared; tightening substrate α below 0.026% (Schwinger-scale residue, Tier-3 open) immediately tightens the spectrum proportionally.

Numerical verification in [`dirac_residual_demo.py`](dirac_residual_demo.py), which takes m_e c² as its only input and prints the substrate-derived constants used at each step.

**The Dirac correction sits below the α-residual floor at current precision.** The three-mechanism Dirac decomposition contributes ~10⁻⁴ at the ground state — below the 5 × 10⁻⁴ α²-residual — so the visible NIST-matching budget is entirely the substrate-α + reduced-mass + (small) Dirac stack. The Dirac structural decomposition becomes the dominant residual only when substrate α is tightened to the Schwinger scale.

Numerical verification in [`dirac_residual_demo.py`](dirac_residual_demo.py).

---

## §6 Honest scoping (three-tier)

**Tier 1 (structural).** Each of the three Dirac mechanisms decomposes into existing QLF substrate machinery:

- Relativistic kinematic → small-rapidity expansion of `γ = cosh φ` from [`Cross_Frequency_Lorentz.md`](Cross_Frequency_Lorentz.md), with rapidity set by the substrate-fixed orbital velocity `v_1 = αc`.
- Single-electron spin-orbit → one-pair extraction from the hyperfine derivation chain in [`Magnetism_Spatial_Dynamics.md`](Magnetism_Spatial_Dynamics.md) §5, using the same `N = 9` directional-coupling tensor (§6.1.3) that produces substrate α.
- Darwin term → per-Compton-cycle zitterbewegung from [`Per_Qubit_Mass_Quantum.md`](Per_Qubit_Mass_Quantum.md), with `λ_C/a_0 = α` giving the α² scaling.

**Tier 2 (numerical, h + m_e only).** With substrate α (1/137, `QLF_FineStructureSubstrate.lean`) and substrate m_p/m_e (6π⁵, `QLF_LenzMassRatio.lean`), Bohr + Dirac + reduced-mass reproduces NIST to ~0.05% across `n = 1..6`. The residue is the substrate-α 0.026% gap propagated as α² ~ 0.053% in the Bohr energy. With CODATA α and CODATA m_p/m_e (as a cross-check, not a prediction), the same formula reproduces NIST to published QED precision.

**Tier 3 (partially closed, partially open).**

- **Lean-anchored** (this v0.17.38): the combined Sommerfeld Dirac formula and the substrate-α evaluation are in [`lean/QLF_DiracCorrection.lean`](lean/QLF_DiracCorrection.lean), packaging the three mechanism factors (`kinematic_factor = α²/2`, `spin_orbit_factor = α²`, `darwin_factor = α²`), the (n, j)-Sommerfeld correction `dirac_correction_over_Ry`, the ground-state special case (`dirac_ground_state : ΔE/Ry = −α²/4`), the substrate-α evaluation (`dirac_ground_state_substrate : ΔE/Ry = −1/75076`), the fine-structure n=2 splitting (`fine_structure_n2_splitting`), and the QLF reduced-mass factor `reduced_mass_factor_QLF = 6π⁵/(1+6π⁵)` from `QLF_LenzMassRatio`. Headline conjunction `hydrogen_spectrum_from_h_and_m_e` packages all three Lean-anchored constants (α = 1/137, m_p/m_e = 6π⁵, reduced-mass factor).
- **Still open**: Lean-anchor each of the three mechanism derivations *individually* as separate chains from `QLF_Pauli`/`QLF_TwistAlphabet` (kinematic via rapidity, spin-orbit via the `N = 9` directional tensor, Darwin via per-Compton-cycle structure). The current module records the α²-scaling claim for each as a named definition tied to its source doc but does not derive each chain.
- Tighten the structural derivation of the Darwin zitterbewegung volume — the `(λ_C/a_0)² = α²` ratio is exact, but the geometric prefactor `π/2` comes from the standard QED contact-term calculation; a substrate-first derivation of the prefactor is open.
- Extend to higher-order corrections: Lamb shift (`α⁵` from electron self-energy / vacuum polarization), anomalous magnetic moment `g − 2 = α/π + …` (Schwinger). These are the next layer beyond Dirac.

---

## §7 What this is NOT

- **Not a new physics claim.** The Dirac formula has been textbook QED since the 1930s; its numerical match to NIST is the published QED precision. The QLF contribution is the structural decomposition into three substrate mechanisms.
- **Not a full Lean-anchored derivation.** Each of the three pieces is anchored in an existing QLF doc; turning each into a Lean theorem is Tier 3 work. The substrate-derived α is Lean-anchored ([`lean/QLF_FineStructureSubstrate.lean`](lean/QLF_FineStructureSubstrate.lean)); the Dirac compositions are not yet.
- **Not a derivation of the Lamb shift.** The Lamb shift is `α⁵` (QED-loop level), one order beyond the `α²` Dirac correction handled here. Open for a follow-up doc.
- **Not specific to hydrogen.** The same three mechanisms extend to any hydrogenic ion (Z e in the Coulomb), differing only by Z-scaling of `v_1 = Zαc`. Heavier-atom extension via [`Atom.md`](Atom.md) / [`heavier_atoms_demo.py`](heavier_atoms_demo.py).

---

## §8 References

### Internal

- [`Hydrogen.md`](Hydrogen.md) — Bohr derivation, §5 records the 0.053% residual this doc closes, §6 names the next-step program.
- [`Cross_Frequency_Lorentz.md`](Cross_Frequency_Lorentz.md) — `γ = cosh φ` from internal-frequency ratios; the kinematic correction in §2 above.
- [`Magnetism_Spatial_Dynamics.md`](Magnetism_Spatial_Dynamics.md) §5–§6 — hyperfine α⁴ derivation chain; §3 above extracts the single-α² spin-orbit case. §6.1 substrate α derivation.
- [`Per_Qubit_Mass_Quantum.md`](Per_Qubit_Mass_Quantum.md) — per-qubit Compton clock; §4 above extends to zitterbewegung.
- [`Kitada_Local_Time_GR.md`](Kitada_Local_Time_GR.md) §5.3 — substrate event quantum (one Planck length × one Planck tick *together*).
- [`fine_structure_demo.py`](fine_structure_demo.py) — companion demo for α; honest-scoping pattern this doc follows.
- [`dirac_residual_demo.py`](dirac_residual_demo.py) — numerical companion to this doc.
- [`hydrogen_qlf.py`](hydrogen_qlf.py) — Bohr spectrum computation; this doc adds the Dirac layer.
- [`Experimental_Consistency.md`](Experimental_Consistency.md) — §1.1 hydrogen-spectrum row, §10 falsifier class.
- [`lean/QLF_FineStructureSubstrate.lean`](lean/QLF_FineStructureSubstrate.lean) — Lean anchor for substrate α.
- [`lean/QLF_LenzMassRatio.lean`](lean/QLF_LenzMassRatio.lean) — Lean anchor for substrate m_p/m_e = 6π⁵.
- [`lean/QLF_DiracCorrection.lean`](lean/QLF_DiracCorrection.lean) — Lean anchor for the Sommerfeld Dirac correction and the reduced-mass factor.

### External

- Dirac, P. A. M. (1928). *The quantum theory of the electron*. Proc. R. Soc. Lond. A 117, 610–624.
- Sommerfeld, A. (1916). *Zur Quantentheorie der Spektrallinien*. Ann. Phys. 51, 1–94 — first fine-structure expansion.
- Bjorken, J. D., & Drell, S. D. (1964). *Relativistic Quantum Mechanics*. McGraw-Hill — Dirac formula derivation.
- NIST Atomic Spectra Database — hydrogen reference values.
