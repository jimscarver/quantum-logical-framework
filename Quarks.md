# Quarks in QLF — colour, charge, flavour, and confinement

What the [Quantum Logical Framework](README.md) (QLF) can and cannot say about quarks, read off the
**nucleon knot** of [`Atomic_Structure_QLF.md`](Atomic_Structure_QLF.md) §7: a baryon is a 3-axis
Borromean closure whose three internal qubits are the three colour directions, threaded by charge. This
doc collects the proven core, the dynamical reading, the open frontier, and the predictions — with the
standard three-tier scope (✓ proven / ⚠ structural reading / ✗ open).

A quark in QLF is not a standalone particle — only hadrons are closure observables
([`QLF_QuarkMass`](lean/QLF_QuarkMass.lean), `quark_not_closed`). In the knot picture a quark is a
**junction** where two internal colour dimensions meet and the closure turns — interior to one closure,
with no free end. That single fact is most of confinement.

---

## 1. Colour — the three axes (essentially complete ✓)

- **Colour = the three spatial axes.** `axOf` ([`QLF_BaryonWinding`](lean/QLF_BaryonWinding.lean)):
  `<>`→x, `^v`→y, `/\`→z; gauge `+−` carries no axis. R/G/B = (x,y,z).
- **SU(3) = the traceless 3-axis directional tensor** ([`QLF_StrongAlgebra`](lean/QLF_StrongAlgebra.lean):
  `trace_commutator_zero`, `gluon_commutator_nonzero`); the eight gluons are its off-diagonal couplings —
  i.e. the **connectors** where the closure hops between colour axes.
- **The Borromean three-colour necessity** ([`QLF_QuarkStructure`](lean/QLF_QuarkStructure.lean),
  `baryon_needs_all_three_axes`): `B ≠ 0` requires a twist on **every** colour axis; remove any one colour
  and `B = 0`. So a baryon needs all three quarks/axes — no one- or two-colour baryon. The minimal baryon
  `>^/` carries exactly one twist per axis (`minimal_baryon_one_per_axis`): three quarks = three axes.

This is a genuine proof of the colour structure (three colours, SU(3), Borromean closure, singlets).

## 2. Confinement — the singlet-closure obstruction (proven ✓)

Confinement is **proven**, as the closure obstruction already established for charge, applied to colour
([`QLF_Confinement`](lean/QLF_Confinement.lean)):

- **`charged_not_closed`** — a state carrying a net annihilation-odd charge (electric, or the strong
  instance **colour**) is **not** a ZFA closure. A lone quark carries net colour ⟹ it **cannot close** ⟹
  it is not a physical state.
- **`singlet_closure`** — every ZFA closure has zero net charge/colour: **only singlets close**.
- **`baryon_needs_all_three_axes`** — and the only nonzero-baryon closure is the three-axis Borromean
  triple. **`single_colour_not_baryon`** — a history on a single colour axis has `B = 0`: a lone quark's
  colour content is not a baryon. Together: physical hadrons are colour-neutral, and a baryon is exactly
  the three-colour lock — no lone or two-colour baryon.

**The dynamical reading — confinement as the 3-body threshold (⚠ cited dynamics, QLF-native bridge).**
The closure ladder is the n-body integrability ladder:

| internal dimensions | n-body | behaviour |
|---|---|---|
| 1 (neutrino) | 1-body | trivially closes |
| 2 (electron, positronium, muonium) | 2-body, **integrable** | always closes — leptons are free, **no confinement** |
| 3 (baryon) | 3-body, **chaotic** (Poincaré) | closes **only** in the special Borromean lock |

A *generic* 3-axis history is chaotic ⇒ non-terminating ⇒ **pruned** (`full_zeno_prune`; a terminating
computation is exactly a ZFA closure, `qlf_universality`). So a lone or perturbed quark configuration is
chaotic and never closes — you cannot pull a quark out. Confinement = the onset of three-body chaos; the
Borromean triple is the integrable island (the prime-3 lock, [`QLF_PrimeResonance`](lean/QLF_PrimeResonance.lean),
"balanced and prime"). The **flux tube / linear potential `V(r) ∝ r`** is the structural reading (the
closure cost grows with separation); its *value* and the asymptotic-freedom→confinement RG flow stay open
(`confinement_in_progress`).

## 3. Charge — conservation, neutrality, quantisation

- **Proven ✓:** electric charge = signed gauge-phase count (`chargeWeight`,
  [`QLF_BMinusL`](lean/QLF_BMinusL.lean)); conserved (`signed_count_conserved`); **zero on every closure**
  (`wcount_zero_on_ZFA`) — global neutrality; annihilation-odd; `charged_not_closed` (a bare charge needs
  its completer — the proton needs its electron, [`Weak_Force.md`](Weak_Force.md) §4a).
- **Quantisation in thirds, from colour (✓ proven).** The charge quantum is `1/n` for `n` colours:
  **`charge_quantum_from_colours`** ([`QLF_QuarkStructure`](lean/QLF_QuarkStructure.lean)) — tracelessness
  `n·q + L = 0` with an integer-charge remainder `L` forces `q = −L/n`. With QLF's `n = 3` colours
  (= 3 spatial axes) and the SU(5) `5̄` (three `d^c` colour copies + a lepton doublet of net charge `−1`),
  **`down_quark_charge_third`** gives `3q − 1 = 0 ⟹ q = 1/3` — the down quark is `−1/3`. So the **thirds
  are forced by the three colours** (the SU(5) multiplet content, [`QLF_SU5`](lean/QLF_SU5.lean), is the
  input; the *thirds* are the theorem). The absolute up/down value is then the §4 split.

## 4. Flavour — the settled bookkeeping vs the mass puzzle

Flavour is the label for *which* of the six quark fields an excitation is. As in the SM it splits cleanly
into a **settled gauge-quantum-number bookkeeping** and the **open mass/Yukawa puzzle** — and QLF
reproduces the first (some of it now proven) and *reframes* the second.
[`diagrams/flavor_grid.svg`](diagrams/flavor_grid.svg) shows the 3×2 grid with the CKM transitions.

**Settled — the gauge bookkeeping (QLF reproduces; some proven ✓).**
- **Charge:** up-type `+2/3`, down-type `−1/3` — **proven** thirds from the three colours (§3).
- **Weak isospin** `T₃ = ±1/2` *within* a generation = the weak `SU(2)` doublet (the 2-state "bit";
  `weak_isospin_su2` in [`BraKetRhoQuCalc`](lean/BraKetRhoQuCalc.lean); `u,d` doublet in
  [`QLF_QuarkMass`](lean/QLF_QuarkMass.lean)). `u↔d` is one gauge-fold pair-flip — charge changes by 1
  (`uud=+1`, `udd=0`, §7).
- **Three generations** = the three axes (`num_generations_eq_three`, [`QLF_Generations`](lean/QLF_Generations.lean)).
- **CKM:** flavour changes *only* via the W charged current; unitarity = closure, near-diagonal (Cabibbo),
  3 angles + 1 CP phase, CP needing ≥3 generations (Kobayashi–Maskawa) — [`QLF_CKM`](lean/QLF_CKM.lean),
  [`QLF_FlavorMixing`](lean/QLF_FlavorMixing.lean). The angle *values* stay open. (GIM / no tree-level FCNC
  is *consistent-with*, not derived.)

**The puzzle — mass / Yukawa.** In the SM each quark's mass is a free Yukawa coupling to the Higgs, and the
"flavor puzzle" is *why* three tiers spanning five orders of magnitude. This is the genuinely open part —
and the one place QLF goes past "free input."

**Folds demystify mass, so QLF can go further.** In QLF mass is not a coupling but the **gauge-fold delay**
`m = 1/R` — the constructing delay of the closure (`mass_is_gauge_fold_delay`,
[`QLF_HiggsMechanism`](lean/QLF_HiggsMechanism.lean); `m=1/R` in [`QLF_QuantumBlackHole`](lean/QLF_QuantumBlackHole.lean)).
So the SM's free Yukawa **is** a closure depth — structural, not dialled. The flavour mass puzzle becomes
**"why these fold depths,"** and QLF has partial answers:

- The **three generations = three fold-depth tiers**, and the charged-lepton tier is **Koide-constrained**:
  `Q = 2/3` from `N=3 ∧ A²=2`, predicting `m_τ` to **0.006%** (`koide_two_thirds`,
  [`QLF_Koide`](lean/QLF_Koide.lean)) — a real relation *among* the three masses the SM has no handle on.
- **One scale.** Every mass is the **proton scale times a ratio**, `m = m_p · (ratio)` (`spectrum_one_scale`,
  [`QLF_MassSpectrum`](lean/QLF_MassSpectrum.lean)) — the SM's ~13 mass parameters collapse to **one**
  absolute input, `m_p`. ([`diagrams/flavor_grid.svg`](diagrams/flavor_grid.svg) gives the six quark masses
  in `m_p` units.) And that one ratio span is **exponentially natural**, not fine-tuned: dimensional
  transmutation gives `ln R = 14π = 2π·b₀` ([`QLF_AlphaS`](lean/QLF_AlphaS.lean)) — the huge hierarchy is
  `e^{14π}` from a single integer, not a tuned coupling.
- For **quarks specifically**, confinement intervenes: bare quark masses are not closure observables
  (`quark_not_closed`); the observable is the hadron-mass *splitting* `m_n−m_p` (the d↔u step), the
  well-posed target (the down is *less* charged yet *heavier* — mass ≠ charge,
  [`Weak_Force.md`](Weak_Force.md) §5e).

**Quark masses in proton-mass units** (`m_p = 938.27 MeV`, the single QLF scale):

| Quark | Gen | Charge | Mass | Mass / `m_p` |
|---|---:|---:|---:|---:|
| u (up) | 1 | +2/3 | 2.16 MeV | 0.0023 |
| d (down) | 1 | −1/3 | 4.67 MeV | 0.0050 |
| s (strange) | 2 | −1/3 | 93.4 MeV | 0.100 |
| c (charm) | 2 | +2/3 | 1.27 GeV | 1.35 |
| b (bottom) | 3 | −1/3 | 4.18 GeV | 4.45 |
| t (top) | 3 | +2/3 | 172.7 GeV | 184 |

Values are PDG (MS-bar for `u,d,s,c,b`; pole mass for `t`). These are **running, scale- and
scheme-dependent** numbers *extracted* from high-energy data (there is no free quark to weigh): a quark
mass is defined at a reference scale and *decreases* toward higher energy (RG running), and it shifts with
scheme — the top alone moves ~6% between pole (≈173 GeV) and MS-bar (≈163 GeV). Mass *ratios* are nearly
RG-invariant, so the relative pattern is robust; but a bare-quark mass being tied to the extraction scale
is exactly why it is **not** a QLF observable (`quark_not_closed`: the closure observable is the *hadron*,
not the bare quark). The
`m_p` column is the QLF reading: every mass `= m_p ×` (a ratio) (`spectrum_one_scale`,
[`QLF_MassSpectrum`](lean/QLF_MassSpectrum.lean)); and since `m = 1/R`, it is the **inverse fold-depth**
ratio (lighter = deeper closure). The ~5-orders-of-magnitude span `0.0023 → 184` is the flavor puzzle —
exponentially natural in the closure-depth picture, not six independently tuned couplings.

**Charged leptons in proton-mass units** (the clean Koide tier — the sharp example):

| Lepton | Gen | Charge | Mass | Mass / `m_p` |
|---|---:|---:|---:|---:|
| e (electron) | 1 | −1 | 0.511 MeV | 0.000545 |
| μ (muon) | 2 | −1 | 105.66 MeV | 0.1126 |
| τ (tau) | 3 | −1 | 1776.86 MeV | 1.894 |

Unlike quarks, charged-lepton masses **are** clean closure observables, and the three obey **Koide**
exactly: `Q = (Σm) / (Σ√m)² = 0.6667 = 2/3` (`koide_two_thirds`, [`QLF_Koide`](lean/QLF_Koide.lean)),
which predicts `m_τ` to **0.006%** from `m_e, m_μ` — the sharpest case of the depth-ratio reduction (the
tier collapses to `{m_p, δ}`, with the Koide angle `δ` the one open input). Neutrinos are **Majorana**
with sub-eV masses (open; [`QLF_NeutrinoMass`](lean/QLF_NeutrinoMass.lean)).

**Honest residual (still open ✗):** the Koide **angle `δ`** (which fixes the individual masses within a
tier), the absolute scale, the per-flavour **twist signature**, and the quark CKM/Yukawa angle *values*.
"Flavour = the Yukawa structure" — and in QLF that structure is **fold depth**: demystified, partly
derived (Koide tier relation + exponential hierarchy), not yet fully.

## 5. Predictions

Graded honestly — what is a **genuine/falsifiable** prediction vs a **reproduction with a new reason**.

1. **Dimensional confinement — the 3-body threshold (falsifiable).** No confined sub-three-colour state
   (no lone-quark or diquark baryon); confinement turns on at *exactly* three axes = three spatial
   dimensions. *Skeleton proven* (`baryon_needs_all_three_axes`; `single_colour_not_baryon` and
   `baryon_zero_of_missing`: fewer than three colours ⟹ `B=0`); the chaos cause is cited. **Falsifier:** a
   stable two-colour bound state, or confinement in a genuinely 2D system.
2. **Exotic hadrons are molecular, not fundamental (falsifiable).** The only nonzero-`B` Borromean closure
   is the three-axis triple, so tetra-/penta-quark states must be two colour-singlets loosely bound, not
   new fundamental closures — matching the emerging experimental "molecular" reading. **Falsifier:** a
   compact, deeply-bound exotic with no two-singlet substructure.
3. **No fourth generation — exactly three (proven prediction).** Three axes ⟹ three generations
   ([`QLF_Generations`](lean/QLF_Generations.lean), `num_generations_eq_three`) — the same "3" as colour.
4. **The charge quantum is `1/n` for `n` colours (proven).** `charge_quantum_from_colours`: tracelessness
   `n·q + L = 0` ⟹ `q = −L/n`, so the charge quantum is exactly `1/`(number of colours); QLF's three
   colours give the **thirds** (`down_quark_charge_third`: `q = 1/3`). The sharp counterfactual ("`1/d` in
   `d` spatial dimensions, since colours = spatial axes") is the one speculative step; the `1/3`-from-3
   itself is now a theorem.

The strongest *new* ones are **1** (proven skeleton + falsifiable) and **2** (current experimental
relevance). **3** and the `1/3`-from-three-colours of **4** are proven; the dimensional counterfactual in
**4** is the soft part.

---

## Honest scope

- ✓ **Proven:** colour = 3 axes + SU(3); the Borromean three-colour necessity; confinement (only singlets
  close, `charged_not_closed`/`singlet_closure`; no lone-quark baryon, `single_colour_not_baryon`); charge
  conservation, neutrality, `charged_not_closed`, and **quantisation in thirds from the three colours**
  (`charge_quantum_from_colours`, `down_quark_charge_third`); three generations.
- ⚠ **Structural reading:** the integrability/chaos cause of confinement (the bridge *chaotic ⇒
  non-terminating ⇒ pruned* is QLF-native; 3-body chaos itself is cited Poincaré); the flux-tube linear
  potential; the quark-as-junction picture; the `1/d`-in-`d`-dimensions counterfactual.
- ✗ **Open:** the per-flavour (u/d) twist signature and quark masses; the string-tension value and the
  asymptotic-freedom→confinement RG flow.

## References

### Internal (QLF)

- [`Atomic_Structure_QLF.md`](Atomic_Structure_QLF.md) §7 — the nucleon knot the quark reading comes from;
  [`diagrams/hydrogen_proton_quarks.svg`](diagrams/hydrogen_proton_quarks.svg).
- [`Forces_From_Three_Axes.md`](Forces_From_Three_Axes.md) — colour = the 3 axes; the open flavour sector.
- [`Weak_Force.md`](Weak_Force.md) §5 — the `d↔u` step, `m_n−m_p`, electron-out vs electron-in.
- Lean: [`QLF_QuarkStructure`](lean/QLF_QuarkStructure.lean), [`QLF_Confinement`](lean/QLF_Confinement.lean),
  [`QLF_BaryonWinding`](lean/QLF_BaryonWinding.lean), [`QLF_StrongAlgebra`](lean/QLF_StrongAlgebra.lean),
  [`QLF_QuarkMass`](lean/QLF_QuarkMass.lean), [`QLF_BMinusL`](lean/QLF_BMinusL.lean),
  [`QLF_SU5`](lean/QLF_SU5.lean), [`QLF_Generations`](lean/QLF_Generations.lean),
  [`QLF_PrimeResonance`](lean/QLF_PrimeResonance.lean).

### External

- Gell-Mann, M. (1964). *A schematic model of baryons and mesons.* Phys. Lett. **8**, 214 — quarks.
- Greenberg, O. W. (1964). *Spin and unitary-spin independence in a paraquark model.* Phys. Rev. Lett.
  **13**, 598 — colour.
- Fritzsch, H., Gell-Mann, M., Leutwyler, H. (1973). *Advantages of the color octet gluon picture.*
  Phys. Lett. B **47**, 365 — QCD / SU(3) colour, the eight gluons.
- Gross, D. J., Wilczek, F. (1973); Politzer, H. D. (1973). *Asymptotic freedom* — the high-energy
  vanishing of the strong coupling (the deconfined limit).
- Wilson, K. G. (1974). *Confinement of quarks.* Phys. Rev. D **10**, 2445 — the Wilson loop and the
  linear (flux-tube) potential `V(r) ∝ r`.
- Georgi, H., Glashow, S. L. (1974). *Unity of all elementary-particle forces.* Phys. Rev. Lett. **32**,
  438 — SU(5); the tracelessness charge-quantisation argument behind the *thirds-from-three-colours* (§3).
- Skyrme, T. H. R. (1962). *A unified field theory of mesons and baryons.* Nucl. Phys. **31**, 556 —
  baryon number as a topological winding (QLF's `baryonNumber`).
- Poincaré, H. (1890). *Sur le problème des trois corps et les équations de la dynamique.* Acta Math.
  **13**, 1 — non-integrability of the three-body problem (the chaos behind the 3-axis confinement
  threshold, §2).
- Zhukov, M. V. et al. (1993). *Bound state properties of Borromean halo nuclei.* Phys. Rep. **231**, 151
  — Borromean three-body binding (bound only as a triple, no two-body sub-bound state).
- Chen, H.-X., Chen, W., Liu, X., Zhu, S.-L. (2016). *The hidden-charm pentaquark and tetraquark states.*
  Phys. Rep. **639**, 1 — the multiquark / molecular-vs-compact debate (Prediction 2).
