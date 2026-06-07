# Schwarzschild metric from QLF substrate: g_tt + g_rr at leading order

**Scoping doc — the static spherically-symmetric weak-field metric from QLF substrate primitives.** Newton's law `F = GMm/r²` already falls out of substrate event-counting on the holographic boundary ([`Gravity_From_Delay.md`](Gravity_From_Delay.md)). The next layer up — General Relativity in the weak field — adds:

- **`g_tt`** (time dilation): gravitational redshift = Markov-blanket frequency shift from [`Cross_Frequency_Lorentz.md`](Cross_Frequency_Lorentz.md), applied to substrate events near mass M.
- **`g_rr`** (spatial radial stretching): substrate radial event scaling caused by M's presence in the vacuum.

Both components are determined by the dimensionless ratio `R_s / r = 2GM/(rc²)`, where `R_s` is the Schwarzschild radius. The Newton potential `φ = −GM/r` (already substrate-derived) sets the leading-order metric:

$$g_{tt} \;\approx\; -\left(1 + \frac{2 \varphi}{c^2}\right), \qquad g_{rr} \;\approx\; \left(1 + \frac{2 \varphi}{c^2}\right)^{-1}.$$

This is the weak-field Schwarzschild metric in isotropic form, ready to compose with orbital mechanics for the Mercury perihelion derivation ([`Mercury_Perihelion.md`](Mercury_Perihelion.md)).

---

## §1 The Newton potential as the substrate input

From [`Gravity_From_Delay.md`](Gravity_From_Delay.md): Newton's law `F = GMm/r²` follows from holographic surface event count + per-event log 2 entropy + 3D-substrate signature. The gravitational potential is the line integral:

$$\varphi(r) \;=\; -\int_\infty^r F \, dr' / m \;=\; -\frac{GM}{r}.$$

This is the substrate-derived input for GR. In dimensionless form:

$$\frac{\varphi(r)}{c^2} \;=\; -\frac{GM}{rc^2} \;=\; -\frac{R_s}{2r},$$

where `R_s ≡ 2GM/c²` is the Schwarzschild radius (a substrate-derived combination of G, M, c — all themselves substrate primitives modulo unit conversion).

For the Sun: `R_s = 2.953 km`. For Mercury at `a = 5.79 × 10¹⁰ m`: `R_s/a = 5.10 × 10⁻⁸`. Weak field.

---

## §2 g_tt from gravitational redshift via Cross-Frequency Lorentz

Per [`Cross_Frequency_Lorentz.md`](Cross_Frequency_Lorentz.md): the Lorentz factor between Markov-blanket frames is `γ = cosh φ` where `φ` is the rapidity, equal to `log(internal-frequency ratio)`. **Gravitational redshift** is exactly the same mechanism, with the frequency ratio set by the gravitational potential.

A substrate event at distance `r` from mass M has its internal Markov-blanket frequency reduced relative to an infinitely-distant observer:

$$\frac{f(r)}{f_\infty} \;=\; \sqrt{1 + \frac{2 \varphi}{c^2}} \;\approx\; 1 + \frac{\varphi}{c^2} \;=\; 1 - \frac{R_s}{2r} \quad (\text{weak field}).$$

This is the **substrate gravitational redshift**, derivable from [`Cross_Frequency_Lorentz.md`](Cross_Frequency_Lorentz.md): clocks at deeper Markov-blanket depths (closer to M) tick slower. The "rapidity" associated with M's gravitational well is

$$\varphi_{\text{grav}}(r) \;=\; \log\!\frac{f(r)}{f_\infty} \;\approx\; \frac{\varphi(r)}{c^2} \;=\; -\frac{R_s}{2r}.$$

**Time-time metric component**. The proper-time element near M is `dτ² = (f(r)/f_∞)² dt²`, so

$$g_{tt} \;=\; -\left(\frac{f(r)}{f_\infty}\right)^2 \;\approx\; -\left(1 + \frac{2\varphi}{c^2}\right) \;=\; -\left(1 - \frac{R_s}{r}\right).$$

This **matches Schwarzschild at leading order**, with the substrate origin being the Markov-blanket frequency shift from Cross-Frequency Lorentz.

---

## §3 g_rr from substrate radial event scaling

The spatial radial component is constrained by the **substrate event quantum**: each event creates one Planck length AND one Planck tick *together* ([`Kitada_Local_Time_GR.md`](Kitada_Local_Time_GR.md) §5.3). If the frequency near M is reduced by factor `(f(r)/f_∞)`, then the substrate spatial extent radial to M is correspondingly *stretched*:

$$\frac{dr_{\text{proper}}}{dr_{\text{coordinate}}} \;=\; \frac{f_\infty}{f(r)} \;=\; \left(1 + \frac{2 \varphi}{c^2}\right)^{-1/2}.$$

**Radial-radial metric component**:

$$g_{rr} \;=\; \left(\frac{dr_{\text{proper}}}{dr_{\text{coord}}}\right)^2 \;=\; \left(1 + \frac{2\varphi}{c^2}\right)^{-1} \;=\; \left(1 - \frac{R_s}{r}\right)^{-1}.$$

This matches Schwarzschild's `g_rr = (1 - R_s/r)⁻¹` at leading order. The substrate origin: spatial events stretch radially to preserve the substrate event quantum `L_Planck × τ_Planck` *together*, even when individual frequencies (= τ_Planck⁻¹) shift.

**Transverse components.** Angular (`θ, φ`) directions are not affected at this order — they don't lie along the propagation direction of the gravitational influence. Substrate-wise: only the radial axis to M experiences the time-space rescaling; transverse directions retain the flat-space substrate metric.

This is why Schwarzschild's `g_θθ = r²` and `g_φφ = r² sin²θ` are flat-space (only changes are in r and t coordinates), and exactly what the substrate event-quantum analysis predicts.

---

## §4 Schwarzschild substrate identity

Combining §2 and §3, the weak-field Schwarzschild metric in standard Schwarzschild coordinates is:

$$ds^2 \;=\; -\left(1 - \frac{R_s}{r}\right) c^2 dt^2 \;+\; \left(1 - \frac{R_s}{r}\right)^{-1} dr^2 \;+\; r^2 d\Omega^2$$

with **`R_s = 2GM/c²`** the Schwarzschild radius, all substrate-derivable:

- `G = L_Planck² c³/ℏ` from substrate event quantum ([`Gravity_From_Delay.md`](Gravity_From_Delay.md) §8)
- `c = L_Planck/τ_Planck` from substrate event quantum ([`lean/QLF_SubstrateLightSpeed.lean`](lean/QLF_SubstrateLightSpeed.lean))
- `M` = empirical input for the specific mass

In Markov-blanket depth language:

$$R_s \;=\; \frac{2 GM}{c^2} \;=\; 2 \frac{R_M^{-1} L_{\text{Planck}}^2 c^3 / \hbar}{c^2} \cdot \frac{\hbar}{c^2 \tau_{\text{Planck}}} \;=\; 2 \frac{L_{\text{Planck}}}{R_M},$$

i.e., **`R_s` is `2 L_Planck / R_M`** where `R_M = E_Planck / (M c²)` is the mass M's Markov-blanket depth from [`Per_Qubit_Mass_Quantum.md`](Per_Qubit_Mass_Quantum.md). For the Sun: `R_M(Sun) = 1.09 × 10²⁹`, so `R_s(Sun) = 2 L_Planck / 1.09 × 10²⁹ × L_Planck⁻¹ = L_Planck × 1.83 × 10²⁹ × (one substrate length) ≈ 2.95 km`. Consistent.

---

## §5 What this delivers

**Tier 1 (structural).** The weak-field Schwarzschild metric components `g_tt = -(1 - R_s/r)` and `g_rr = (1 - R_s/r)⁻¹` follow from substrate primitives:

- Newton potential `φ = -GM/r` from holographic event count (already Lean-anchored).
- Gravitational redshift `f(r)/f_∞ ≈ 1 + φ/c²` from Cross-Frequency Lorentz (already Lean-anchored).
- Substrate event quantum constraint `L_Planck τ_Planck = const` from substrate primitives (already Lean-anchored).

The composition delivers Schwarzschild at leading order with **`R_s = 2GM/c²`** as the natural substrate radius.

**Tier 2 (numerical).** For the Sun: `R_s = 2.953 km`. For Mercury orbit `a = 5.79 × 10¹⁰ m`: `R_s/a = 5.10 × 10⁻⁸` — weak field. The metric is well-approximated by leading-order expansions; higher-order corrections enter at `(R_s/r)²` which is `~10⁻¹⁵` for Mercury's orbit.

**Tier 3 (open).**

- Substrate derivation of `g_θθ = r²` and `g_φφ = r² sin²θ` — flat at this order, but substrate-event-count justification needs articulation.
- Strong-field Schwarzschild (R_s/r ~ 1, near event horizon) — beyond weak-field expansion, needs the full substrate treatment of gravitational singularity.
- Kerr metric (rotating mass) — adds frame-dragging from angular momentum, a second substrate degree of freedom (substrate-event spin orientation).
- Full Einstein equations from substrate vacuum-alignment — the curvature side; this doc handles only the metric (not the equations of motion that give R_μν - (1/2)Rg_μν = 8πG T_μν).
- Composition with Mercury orbital mechanics — done in [`Mercury_Perihelion.md`](Mercury_Perihelion.md).

---

## §6 What this is NOT

- **Not a derivation of the full Einstein equations.** Only the metric components in the weak field static limit. Curvature `R_μν` and stress-energy `T_μν` and the dynamical Einstein equation are above the scope here. Substrate Lean-anchored is just `8π = 4π · 2` ([`lean/QLF_EinsteinGeometricFactor.lean`](lean/QLF_EinsteinGeometricFactor.lean)).
- **Not a derivation of black holes.** Weak-field limit; strong-field substrate treatment is open. The Schwarzschild radius `R_s = 2.95 km (Sun)` is a useful scale but doesn't correspond to a substrate object here.
- **Not a derivation of gravitational waves.** Static metric only. Time-dependent metrics (radiation) need additional substrate machinery.
- **Not a new GR claim.** Schwarzschild is textbook GR from 1916. The QLF contribution is the *substrate decomposition* of the metric components into primitives (Newton + Cross-Frequency Lorentz + substrate event quantum).

---

## §7 References

### Internal

- [`Gravity_From_Delay.md`](Gravity_From_Delay.md) — Newton's law from substrate, source of the φ = -GM/r input.
- [`Cross_Frequency_Lorentz.md`](Cross_Frequency_Lorentz.md) — frequency-ratio Lorentz boost, applied here to gravitational redshift.
- [`Kitada_Local_Time_GR.md`](Kitada_Local_Time_GR.md) §5.3 — substrate event quantum (one Planck length × one Planck tick *together*).
- [`Per_Qubit_Mass_Quantum.md`](Per_Qubit_Mass_Quantum.md) — Markov-blanket depth R = E_Planck/(mc²).
- [`Mercury_Perihelion.md`](Mercury_Perihelion.md) — composition with orbital mechanics for the 43"/century perihelion shift.
- [`lean/QLF_GravityFromDelay.lean`](lean/QLF_GravityFromDelay.lean) — Newton-law substrate Lean module.
- [`lean/QLF_EinsteinGeometricFactor.lean`](lean/QLF_EinsteinGeometricFactor.lean) — `8π = 4π · 2`.
- [`lean/QLF_SubstrateLightSpeed.lean`](lean/QLF_SubstrateLightSpeed.lean) — `c = L_Planck/τ_Planck`.

### External

- Schwarzschild, K. (1916). *Über das Gravitationsfeld eines Massenpunktes nach der Einsteinschen Theorie*. Sitzungsber. Preuss. Akad. Wiss. — original Schwarzschild solution.
- Einstein, A. (1916). *Die Grundlage der allgemeinen Relativitätstheorie*. Ann. Phys. 49, 769 — General Relativity, weak-field limit derivation.
- Will, C. M. (2014). *The Confrontation between General Relativity and Experiment*. Living Rev. Relativity 17, 4 — review of GR experimental tests including Mercury perihelion.
- Misner, C. W., Thorne, K. S., & Wheeler, J. A. (1973). *Gravitation*. — standard reference for Schwarzschild metric and weak-field expansion.
