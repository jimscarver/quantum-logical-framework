# Gravity from substrate time delay: G and Newton's law from holographic event-counting

**Scoping doc — Newton's law `F = G M m / r²` from QLF substrate primitives.** Every interaction takes one Planck tick per Planck length: round-trip between two masses at distance `r` requires `R = r / L_Planck` substrate ticks. During the delay, vacuum events accumulate on the holographic boundary enclosing each mass. The accumulated entropy gradient pulls the masses together — Verlinde's entropic-gravity derivation, but with the substrate event count and per-event `log 2` quantum as the only inputs.

**G is unit-conversion bookkeeping.** In QLF's substrate-first ontology, `L_Planck` and `τ_Planck` are *primitives* (one of each per substrate event). The Planck mass `M_Planck = E_Planck / c² = ℏ / (c² τ_Planck)` follows. Newton's constant `G = L_Planck³ / (M_Planck τ_Planck²)` is then just the ratio of substrate primitives expressed in SI units — its CODATA value `6.674 × 10⁻¹¹ m³/(kg·s²)` is the SI calibration of the substrate event quantum, not a separate empirical input.

**1/r² is the 3D substrate signature.** The 1/r² fall-off follows from substrate surface-area scaling `~R²` in 3 spatial dimensions. The 3-dimensionality of the substrate comes from the 8-twist alphabet's 6+2 split (6 spatial twists = 3 axis pairs, [`Magic_numbers.md`](Magic_numbers.md)). Counterfactual: in d spatial dimensions Newton's law would be `F ∝ 1/r^(d−1)`. The observed 1/r² is a structural prediction tied to the substrate 3D, the same 3D that produced α via the `N = 9 = 3²` directional tensor.

---

## §1 The G question

Newton's constant has the value `G = 6.67430 × 10⁻¹¹ m³ kg⁻¹ s⁻²` in SI. In Planck units G = 1 by definition (since L_Planck, τ_Planck, M_Planck are *defined* from {ℏ, c, G}). Standard physics offers no first-principles derivation of why G has this numerical value — it is taken as a fundamental constant of nature.

**The QLF substrate reading.** L_Planck and τ_Planck are *substrate primitives* — one Planck length and one Planck tick per substrate event, *together* ([`Kitada_Local_Time_GR.md`](Kitada_Local_Time_GR.md) §5.3, Lean-anchored in [`lean/QLF_SubstrateLightSpeed.lean`](lean/QLF_SubstrateLightSpeed.lean)). The Planck mass is then `M_Planck = ℏ / (c² τ_Planck) = ℏ / (c · L_Planck)` — the rest-energy of a single Planck-event qubit. Newton's constant follows:

$$G \;=\; \frac{L_{\text{Planck}}^3}{M_{\text{Planck}} \, \tau_{\text{Planck}}^2} \;=\; \frac{L_{\text{Planck}}^2 \, c^3}{\hbar}$$

The SI numerical value 6.67430 × 10⁻¹¹ reflects the calibration of substrate event quantum to SI units — not a separate empirical input.

**The deeper question.** Why does gravity have the *form* `F ∝ M m / r²`, with `G` as the coefficient? This is the Verlinde-style entropic-gravity question, and QLF substrate primitives answer it directly.

---

## §2 Substrate event quantum and the time delay

Per the substrate event quantum ([`Kitada_Local_Time_GR.md`](Kitada_Local_Time_GR.md) §5.3): every substrate event creates **one Planck length** of spatial extent and **one Planck tick** of duration, *together*. The speed of light `c = L_Planck / τ_Planck` is the ratio of substrate primitives — Lean-anchored as `substrate_light_speed_from_cosmic_ratio` in [`lean/QLF_SubstrateLightSpeed.lean`](lean/QLF_SubstrateLightSpeed.lean).

**Time delay for an interaction at distance `r`.** Two masses separated by `r` exchange gauge-twist closures (the substrate primitive for any interaction). The round-trip delay is

$$\Delta t \;=\; \frac{2 r}{c} \;=\; 2 r / c \;=\; 2 R \, \tau_{\text{Planck}}, \qquad R \;\equiv\; r / L_{\text{Planck}}.$$

During the delay, vacuum substrate events accumulate on the topological boundary enclosing each mass. Each event holds `log 2` nats of information ([`MRE.md`](MRE.md), Lean-anchored as `zfa_closure_minimizes_free_energy` in [`lean/QLF_FreeEnergy.lean`](lean/QLF_FreeEnergy.lean)).

The accumulated information *on the holographic boundary* (not in the bulk) generates the gravitational coupling. The key step: how many substrate events sit on a holographic boundary of radius R?

---

## §3 Holographic surface event count: 4π R²

A 2-sphere of physical radius `r` has area `A = 4π r²`. In substrate units, the boundary holds

$$N \;=\; \frac{A}{L_{\text{Planck}}^2} \;=\; 4 \pi \, R^2$$

independent substrate events. Each event is one Planck-length × Planck-length patch of the holographic surface; each one hosts one half-spin ZFA closure.

**Why R² (not R³)?** Substrate-event counting on the 2D boundary, not the 3D bulk. The Bekenstein-Hawking holographic principle says all the information about the bulk is encoded on the boundary — substrate events on the boundary are the substrate-language statement of this. The factor `4π` is the solid angle (one of two factors in the `8π` Einstein-equation coefficient, Lean-anchored as `einstein_eight_pi_decomposition` in [`lean/QLF_EinsteinGeometricFactor.lean`](lean/QLF_EinsteinGeometricFactor.lean)).

**3-dimensionality of the substrate is the structural ingredient.** In `d` spatial dimensions, a `(d−1)`-dimensional holographic boundary at radius `r` has `N ∝ r^(d−1)` substrate events. For QLF's 3D spatial substrate (derived from the 8-twist 6+2 split, [`Magic_numbers.md`](Magic_numbers.md)): `N ∝ R²`. This is what gives Newton's law its `1/r²` form (§7 below).

---

## §4 Entropy on the holographic horizon

Each substrate event holds `log 2` nats of information (per-event MRE quantum, Lean-anchored). Total entropy on the holographic surface:

$$S \;=\; N \cdot \log 2 \;=\; 4\pi R^2 \log 2 \;=\; \frac{4 \pi r^2 \log 2}{L_{\text{Planck}}^2}.$$

Multiplied by `k_B` for SI thermodynamic units: `S = (4π r²/L_Planck²) × k_B log 2`. This matches the Bekenstein-Hawking horizon entropy `S_BH = k_B A / (4 L_Planck²)` up to the factor `log 2 / 4 = (log 2)/4` — the substrate-event-counting version differs from the continuous Bekenstein-Hawking by `4/log 2 ≈ 5.77`, which is the substrate→continuum coarse-graining. (Honest scope: the substrate counting prescription needs to be matched against the continuous-geometry holographic principle; this is open work — see §9.)

The point for gravity derivation: entropy is `S ∝ R² × log 2 × k_B`, with the per-event `log 2` quantum carrying the substrate origin.

---

## §5 Vacuum temperature on the horizon

The horizon hosts `N = 4π R²` substrate events, sharing the total energy `M c²` of the enclosed mass `M`. Equipartition gives each event `(1/2) k_B T` of energy:

$$N \cdot \frac{1}{2} k_B T \;=\; M c^2 \;\Rightarrow\; T \;=\; \frac{2 M c^2}{N k_B} \;=\; \frac{M c^2}{2 \pi R^2 k_B}.$$

This is the substrate analog of the Unruh / Bekenstein-Hawking temperature. Notice the scaling: `T ∝ M / r²` — already 1/r² appearing in the temperature, because the surface event count scales as r² in 3D.

In substrate units (substituting `R = r/L_Planck`):

$$T \;=\; \frac{M c^2 L_{\text{Planck}}^2}{2 \pi r^2 k_B}.$$

**This is where G appears.** Substituting `L_Planck² = ℏ G / c³`:

$$T \;=\; \frac{M G \, \hbar}{2 \pi r^2 c \, k_B}.$$

— the standard Unruh-like horizon temperature, with G arising from the substrate event quantum via `L_Planck² = ℏ G / c³`.

---

## §6 Bekenstein bound at horizon crossing

A test mass `m` crossing the horizon advances by one Compton wavelength `λ_C = ℏ / (m c)` per Bekenstein cycle. The entropy change for the horizon-crossing is

$$dS \;=\; \frac{2 \pi k_B \, m c}{\hbar} \, dx$$

(Bekenstein 1973, holds for any quantum mechanical particle). In substrate language: each Compton-cycle motion adds one Planck-event closure to the horizon's substrate-event ledger; the `2π` is the angular phase per Compton cycle.

The Bekenstein bound is a quantum-mechanical fact that QLF doesn't yet Lean-anchor at the substrate level (Tier-3 open). But its form is natural: `dS/dx = (2π/λ_C) × k_B = 2π m c k_B / ℏ`, reading as "one substrate event per Compton wavelength of motion."

---

## §7 Force from entropy gradient: F = G M m / r²

Combining §5 (temperature) and §6 (entropy gradient):

$$F \;=\; T \cdot \frac{dS}{dx} \;=\; \frac{M G \hbar}{2\pi r^2 c k_B} \cdot \frac{2 \pi m c k_B}{\hbar} \;=\; \boxed{\frac{G M m}{r^2}}.$$

**Newton's law of gravitation falls out**, with G appearing exactly as the coefficient via `L_Planck² = ℏ G / c³` in the substrate event quantum.

### §7.1 Structural decomposition

| Factor | Substrate origin | Reference |
|---|---|---|
| `1/r²` | Holographic surface event count `N = 4π R²` (3D substrate from 8-twist 6+2 split) | §3, [`Magic_numbers.md`](Magic_numbers.md) |
| `M` | Total energy on horizon, distributed by equipartition over `N` events | §5 |
| `m` | Bekenstein entropy gradient `dS/dx ∝ m c k_B / ℏ` | §6 |
| `G` | Substrate event quantum `L_Planck² = ℏ G / c³` (definitional in QLF substrate) | §2 |
| `4π` | Solid angle (one of two factors in Einstein equation's `8π`, Lean-anchored) | §3 |

The `4π` cancels in the final force formula because it appears once in `N` (numerator of equipartition) and once in the temperature's `(2π R²)` (numerator). The remaining `4π → 1` cancellation is exact in the standard Verlinde derivation.

### §7.2 Counterfactual: dimensional dependence of gravity

In `d` spatial dimensions, the holographic boundary at radius `r` has `N ∝ r^(d−1)` substrate events. The same derivation gives:

$$F \;\propto\; \frac{M m}{r^{d-1}}.$$

For QLF's 3D substrate: `d = 3`, force `∝ 1/r²` — Newton's law. Counterfactual: in 2D substrate Newton's law would be `1/r¹`; in 4D substrate `1/r³`. The observed `1/r²` falls-off **is a structural prediction tied to the 3-dimensionality of the substrate**, the same 3D that produced α via the `N = 9 = 3²` directional tensor in [`lean/QLF_FineStructureSubstrate.lean`](lean/QLF_FineStructureSubstrate.lean).

This ties Newton's law structurally to the same 6+2 alphabet split that produces α and the nuclear magic numbers — the substrate's 3-dimensionality is the common-source predictor.

---

## §8 G in SI: unit-conversion bookkeeping

In QLF's substrate-first ontology, `L_Planck` and `τ_Planck` are *primitives* (one per substrate event), and `M_Planck = ℏ / (c² τ_Planck)`. Newton's constant in SI is then

$$G \;=\; \frac{L_{\text{Planck}}^3}{M_{\text{Planck}} \, \tau_{\text{Planck}}^2} \;=\; \frac{L_{\text{Planck}}^2 \, c^3}{\hbar}.$$

The CODATA value `G = 6.67430 × 10⁻¹¹ m³ kg⁻¹ s⁻²` is the SI calibration of the substrate event quantum — not a separate empirical input. In Planck units G = 1.

**Substrate Tier 1 (structural):** the *form* of Newton's law `F ∝ M m / r²` and the dimensional structure of G fall out from §§3–7. **Tier 2 (numerical):** G in SI = bookkeeping. **Tier 3 (open):** if one wants to *predict* the SI value of G from substrate alone, one would need to derive L_Planck (or M_Planck) in terms of standard observable inputs — the same Planck-scale question that asks "why is the proton 10¹⁹ Planck masses smaller than the Planck mass?" That is the hierarchy problem, scoped in [`HadronicDepth.md`](HadronicDepth.md).

---

## §9 Honest scoping (three-tier)

**Tier 1 (structural — what falls out from substrate primitives).**

- The holographic surface event count `N = 4π R²` from substrate event-counting on the 2-sphere (3D substrate).
- Per-event `log 2` entropy (Lean-anchored).
- Equipartition of horizon energy `Mc²` across `N` events gives `T ∝ M/r²`.
- Bekenstein-form entropy gradient `dS/dx ∝ mc/ℏ` (form structural, Lean-anchoring open).
- Force from entropy gradient: `F = T · dS/dx = GMm/r²` (Newton's law).
- 1/r² is the 3D substrate signature (counterfactual: 2D → 1/r¹, 4D → 1/r³).

**Tier 2 (numerical).**

- G in SI = `L_Planck² c³/ℏ ≈ 6.674 × 10⁻¹¹ m³ kg⁻¹ s⁻²` — unit-conversion bookkeeping (no separate empirical input).
- 1/r² verified by all gravitational observations (Cavendish through binary pulsars).

**Tier 3 (open).**

- Substrate-event-counting prescription on the holographic boundary needs matching to continuous Bekenstein-Hawking `S = A/(4 L_Planck²)`. The `log 2 / 4` per-event factor is a coarse-graining discrepancy.
- Lean-anchor the holographic event count `N = 4π R²` from substrate Markov-blanket boundary topology.
- Lean-anchor the Bekenstein bound `dS = (2π m c k_B / ℏ) dx` substrate-derivation.
- GR-quantitative extensions: Mercury perihelion shift, gravitational lensing, GPS time dilation. The structural framing is in [`Kitada_Local_Time_GR.md`](Kitada_Local_Time_GR.md); quantitative substrate derivation Tier-3 open.
- Predict numerical G from first principles independently of L_Planck (would reduce to the hierarchy problem, [`HadronicDepth.md`](HadronicDepth.md)).
- Strong-field corrections: derive the full Einstein equations from this substrate framework (the `8π` factor is Lean-anchored; the curvature-side derivation is open).

---

## §10 What this is NOT

- **Not a derivation of G's numerical SI value from substrate alone.** G in SI is bookkeeping; the SI value reflects L_Planck calibration. The *form* of Newton's law and the *structural origin* of G fall out; the SI number is a downstream unit-system question.
- **Not a derivation of full Einstein equations.** Only Newton's `F = GMm/r²` (the weak-field static limit). Mercury perihelion, gravitational waves, cosmological-constant derivation are Tier-3 open (§9).
- **Not a derivation of the hierarchy problem.** `M_Planck / m_proton ≈ 10¹⁹` is not explained here. That's the `R_p` derivation question scoped in [`HadronicDepth.md`](HadronicDepth.md) and [`Proton_Resonance_R_e.md`](Proton_Resonance_R_e.md).
- **Not a new physics claim.** Verlinde (2010) derived Newton's law from entropic gravity; this doc is the QLF substrate-event-count version of that derivation, with the per-event `log 2` and 4π R² counting being the substrate primitives.

---

## §11 References

### Internal

- [`Kitada_Local_Time_GR.md`](Kitada_Local_Time_GR.md) §5.3 — substrate event quantum (one Planck length × one Planck tick *together*); Gap 3 names G as "vacuum's per-event entropy-gradient strength."
- [`VacuumEnergy.md`](VacuumEnergy.md) §6 — vacuum-alignment principle as TOE-completing layer.
- [`MRE.md`](MRE.md) — per-event `log 2` information quantum.
- [`Magic_numbers.md`](Magic_numbers.md) — 3-dimensionality of the substrate from the 8-twist 6+2 split.
- [`HadronicDepth.md`](HadronicDepth.md) — Markov-blanket depths; the hierarchy `R_p ≈ 10¹⁹` question.
- [`Proton_Resonance_R_e.md`](Proton_Resonance_R_e.md) — `R_e = R_p · 6π⁵` chirality-hiding resonance.
- [`Gravity.md`](Gravity.md) — gravitational warping as top-down screening; qualitative companion.
- [`Magnetism_Spatial_Dynamics.md`](Magnetism_Spatial_Dynamics.md) §6.1 — substrate α from 3D directional tensor (sibling counterfactual).
- [`lean/QLF_FreeEnergy.lean`](lean/QLF_FreeEnergy.lean) — `zfa_closure_minimizes_free_energy` (per-event log 2).
- [`lean/QLF_EinsteinGeometricFactor.lean`](lean/QLF_EinsteinGeometricFactor.lean) — `8π = 4π · 2` Einstein-equation factor.
- [`lean/QLF_SubstrateLightSpeed.lean`](lean/QLF_SubstrateLightSpeed.lean) — `c = L_Planck / τ_Planck` substrate identity.
- [`lean/QLF_LocalClock.lean`](lean/QLF_LocalClock.lean) — `R = local clock count`.
- [`lean/QLF_FineStructureSubstrate.lean`](lean/QLF_FineStructureSubstrate.lean) — `N = 9 = 3²` 3D directional tensor (sibling 3D-substrate prediction).
- [`lean/QLF_GravityFromDelay.lean`](lean/QLF_GravityFromDelay.lean) — Lean anchor for this module.
- [`gravity_delay_demo.py`](gravity_delay_demo.py) — numerical companion.
- [`Experimental_Consistency.md`](Experimental_Consistency.md) §8 — gravity scope; §10 falsifiers.

### External

- Verlinde, E. (2011). *On the Origin of Gravity and the Laws of Newton*. JHEP 04:029. [arXiv:1001.0785](https://arxiv.org/abs/1001.0785) — entropic gravity derivation this doc translates into substrate language.
- Jacobson, T. (1995). *Thermodynamics of Spacetime: The Einstein Equation of State*. Phys. Rev. Lett. 75, 1260 — earlier thermodynamic-gravity derivation.
- Bekenstein, J. D. (1973). *Black Holes and Entropy*. Phys. Rev. D 7, 2333 — original Bekenstein bound `dS = 2π m c k_B dx / ℏ`.
- Hawking, S. W. (1975). *Particle Creation by Black Holes*. Comm. Math. Phys. 43, 199 — Hawking temperature, related substrate identification.
- Padmanabhan, T. (2010). *Thermodynamical Aspects of Gravity*. Rep. Prog. Phys. 73, 046901 — review of thermodynamic-gravity derivations.
- Newton, I. (1687). *Philosophiae Naturalis Principia Mathematica*. — original gravitational inverse-square law.
- CODATA 2022 — `G = 6.67430 × 10⁻¹¹ m³ kg⁻¹ s⁻²`.
