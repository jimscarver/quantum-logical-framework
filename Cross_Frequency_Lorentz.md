# Cross-Frequency Lorentz Boost in QLF

The Lorentz boost between two Markov-blanket frames is a **change of basis on their internal ZFA event rates**. This document writes out that derivation explicitly, closing the open-work item [`Hierarchical_Control.md` §6](Hierarchical_Control.md) ("Cross-frequency Lorentz derivation: write out the Lorentz boost between two Markov-blanket frames as a change of basis on their internal ZFA event rates, complementing [`UniversalRelativity.md`](UniversalRelativity.md)'s spacetime-emergence argument").

The argument is structural — the Lorentz factor $\gamma$ is identified as a ratio of internal Markov-blanket frequencies, time dilation and length contraction fall out as direct consequences, and the spacetime interval is the QLF analog of the invariant ZFA event count. The constancy of $c$ is derived separately from the cosmic-ratio identity $c = R_{\text{cosmic}} / T_{\text{cosmic}} = L_{\text{Planck}} / \tau_{\text{Planck}}$ ([`Kitada_Local_Time_GR.md`](Kitada_Local_Time_GR.md) §5.3, [`lean/QLF_SubstrateLightSpeed.lean`](lean/QLF_SubstrateLightSpeed.lean)); the boost derivation here takes that substrate $c$ as input.

---

## §1 Setup: Markov-blanket frames as internal clocks

Per [`Frequency_Synchronization.md`](Frequency_Synchronization.md) and [`Hadrons_Markov_Blankets.md`](Hadrons_Markov_Blankets.md), every observer in QLF is a Markov blanket at some scale $R$ with internal clock

$$\Delta t = R / f$$

where $f$ is the local ZFA event rate. Frequency $f$ is *not* an external parameter — it is the resonant rate at which the blanket's interior synchronises with the global history string. Two distinct Markov-blanket frames $A$ and $B$ therefore have *internal* clock rates $f_A$ and $f_B$ that need not agree.

In what follows "frame" always means "Markov-blanket frame," and "internal frequency" always means the ZFA event rate at which that blanket synchronises its interior. The argument is observer-relative throughout: there is no privileged global $f$.

---

## §2 The Markov-blanket boundary as the rapidity basis

Each Markov blanket has a topological boundary that screens its interior from the exterior bath. The boundary admits two complementary kinds of admissible closures:

- **Gauge-fold closures** (`+` / `-` axis) — contribute to the *temporal* face of the blanket; they advance the blanket's internal clock.
- **Non-gauge closures** (`^v` / `<>` / `/\` axes) — contribute to the *spatial* face; they shift the blanket's interior with respect to its exterior.

Per [`Frequency_Synchronization.md`](Frequency_Synchronization.md) §"space/time role swap": in high-density blankets (deep gravity, fast motion) the gauge-fold rate dominates and time-like ticks crowd; in sparse blankets the non-gauge closures dominate and spatial separation crowds. The blanket's *internal frequency mix* therefore encodes its kinematic state.

Define the dimensionless **rapidity parameter** between two blanket frames as

$$\xi_{B \mid A} \;\equiv\; \frac{f_B^{\text{observed-in-}A}}{f_A^{\text{proper}}}$$

i.e. the ratio of $B$'s internal-clock rate *as reckoned from* $A$'s reference, to $A$'s own proper rate. This is the QLF analog of the relativistic Doppler factor — see §3.

---

## §3 The change-of-basis claim

Standard special relativity asserts that the Lorentz boost $\Lambda_v$ acts on the four-vector $(ct, \vec{x})$ as

$$ct' = \gamma(ct - \beta x), \qquad x' = \gamma(x - \beta ct), \qquad \beta = v/c, \quad \gamma = 1/\sqrt{1 - \beta^2}.$$

**QLF reading.** The Lorentz boost between frames $A$ and $B$ is the change of basis between $A$'s internal ZFA event rate $f_A$ and $B$'s, as observed from $A$. The reckoning is purely a frame transformation — no global frequency need be invoked — and the boost is parameterised by $\xi_{B \mid A}$ rather than by $\beta$ or $\gamma$ directly.

The bridge:

$$\gamma \;=\; \frac{f_A^{\text{proper}}}{f_B^{\text{observed-in-}A}} \;=\; \frac{1}{\xi_{B \mid A}}.$$

In words: if $A$ observes $B$'s clock ticking at half $A$'s own rate, then $\gamma = 2$ — $B$'s clock is dilated by factor 2 relative to $A$'s. This is exactly the standard time-dilation reading, restated in terms of internal Markov-blanket frequencies rather than coordinate time.

Equivalently, in rapidity form $\varphi \equiv \operatorname{atanh}\beta$:

$$\xi_{B \mid A} \;=\; e^{-\varphi}, \qquad \gamma \;=\; \cosh\varphi \;=\; \frac{\xi^{-1} + \xi}{2}.$$

The Lorentz boost is a hyperbolic rotation by rapidity $\varphi$ in the $(ct, x)$ plane; equivalently, a *logarithmic* shift in the frequency-ratio variable $\xi$. The change-of-basis matrix between $A$'s ZFA-event-rate basis and $B$'s is the boost matrix $\Lambda_v$ acting on the temporal/spatial face decomposition of §2.

---

## §4 Consequences

Three standard SR results fall out by direct substitution.

### 4.1 Time dilation

If $B$ has proper interval $\Delta\tau_B$ (in $B$'s rest frame), then $A$ measures $B$'s clock to advance by

$$\Delta t_A \;=\; \gamma \, \Delta\tau_B \;=\; \frac{1}{\xi_{B \mid A}} \, \Delta\tau_B.$$

In QLF terms: a single proper-time tick of $B$'s Markov blanket (one ZFA event in $B$'s interior) is reckoned from $A$ as $\xi_{B \mid A}^{-1}$ of $A$'s proper-time ticks — i.e., $A$ counts more events between two of $B$'s clock ticks. "Moving clocks run slow" is the Markov-blanket reading "$B$'s observed internal frequency is reduced in $A$'s reckoning."

### 4.2 Length contraction

Lengths along the boost axis transform as

$$L_A \;=\; L_B / \gamma \;=\; \xi_{B \mid A} \, L_B.$$

In QLF terms: per [`Frequency_Synchronization.md`](Frequency_Synchronization.md)'s `Δt = R/f` relation, a Markov blanket at scale $R$ has $R \propto 1/f$ at fixed internal-event-count. If $B$'s frequency is reduced by $\xi_{B \mid A}$, its spatial face is correspondingly contracted by the same factor when projected into $A$'s frame.

### 4.3 Invariant interval

The spacetime interval

$$\Delta s^2 \;=\; c^2\Delta t^2 - \Delta\vec{x}^2$$

is Lorentz-invariant. In QLF terms, $\Delta s^2$ corresponds to the **invariant count of admissible ZFA closures** in the joint causal frontier of the two events — a property of the global ZFA ledger that does not depend on which Markov blanket reads it. Specifically:

- The temporal contribution $c^2\Delta t^2$ counts gauge-fold events (time-like blanket ticks).
- The spatial contribution $\Delta\vec{x}^2$ counts non-gauge closures (space-like blanket extensions).
- Their signed difference is the total ZFA closure count between the two events, regardless of frame.

This is the QLF rendering of the standard SR interval invariance: not a postulate, but a consequence of the fact that ZFA event counts are a property of the ledger, not the observer.

---

## §5 Cross-frequency reading in pictures

The cross-frequency rapidity $\xi$ admits a clean geometric picture: each Markov-blanket frame draws its $(ct, x)$ axes rotated by rapidity $\varphi$ from any other frame's axes. The "rotation angle" is set by the frequency ratio, not by an externally imposed velocity:

```
     ┌── Frame A's (ct_A, x_A) basis ──┐
     │                                 │
     ▼                                 ▼
   ct_A axis                       x_A axis
     │                                 │
     │     ╱  ct_B axis      x_B axis  │
     │   ╱  (rotated by      (rotated  │
     │ ╱     rapidity φ)     by φ)     │
     ●─────────────────────────────────●
                 invariant interval Δs²
              (ZFA closure count is frame-free)
```

Two Markov-blanket frames at rapidity $\varphi$ apart see each other's clocks at rate $e^{-\varphi}$ and each other's spatial extent at rate $e^{-\varphi}$ — both contracted by the same Doppler factor. The Lorentz factor $\gamma = \cosh\varphi$ is the symmetric quadratic mean of $\xi$ and $\xi^{-1}$, accounting for the fact that the *ratio* is what matters, not its direction.

In high-density regions (e.g. near a black-hole horizon, or for fast-moving frames), the rapidity gets large in either direction; both observers see each other's clocks slowed by the same factor, and the symmetric formula $\gamma = (\xi + \xi^{-1})/2$ recovers this.

---

## §6 What this DOES and DOES NOT do

### Does

- **Identify the Lorentz factor with a Markov-blanket frequency ratio.** Specifically $\gamma = 1/\xi_{B \mid A} = \cosh\varphi$, where $\xi$ is the relativistic Doppler factor between frames and $\varphi$ is the rapidity.
- **Recover standard time dilation, length contraction, and interval invariance** as immediate consequences of the frequency-ratio identification.
- **Re-frame Lorentz boosts as observer-relative ledger-reading operations**, not as transformations on a privileged global $(t, x)$ chart. Each Markov-blanket frame reads its own internal ZFA event rate; the boost is the change-of-basis between two such readings.
- **Match the qualitative claims of [`Hierarchical_Control.md`](Hierarchical_Control.md) §2** ("time dilation is frequency mismatch between observer frames"; "Lorentz transformations are derived as the change-of-basis between frame-local ZFA event rates, not postulated").

### Does NOT

- **Provide a Lean theorem `lorentz_boost_from_zfa_frequencies`.** That would require formalising the Markov-blanket frequency structure inside the Lean kernel; it is open work and a natural successor.
- **Address non-boost frame transformations** (rotations, accelerations, the full Lorentz group). The boost is the simplest case; rotations are blanket-internal symmetries that preserve $f$; accelerations require a frequency-derivative term and are out of scope here.
- **Provide quantitative empirical predictions distinguishable from standard SR.** The QLF reading is empirically equivalent to standard SR by construction — the value comes from the constructive substrate, not from new measurable effects.

---

## §7 Open work

- **Lean theorem**: formalise `lorentz_boost_from_zfa_frequencies` — define a `Frame` structure with internal-frequency field, define the boost transformation as a change of basis, and prove that it preserves the QLF-spacetime-interval analog. Connects to the existing `SpacetimeDynamics` and `ZFAEventDynamics` modules but requires a new structural layer.
- **Generalisation to acceleration**: the constant-rapidity case here generalises to time-varying rapidity for accelerated frames. The QLF analog should yield the equivalence principle as a consequence of locally-varying Markov-blanket frequencies — connects to [`Gravity.md`](Gravity.md).
- **Cosmological-redshift application**: at cosmic scale, frame-pair frequency ratios encode the cosmological redshift $1 + z = \lambda_{\text{obs}} / \lambda_{\text{emit}} = \xi^{-1}$. Connects to [`AgeOfUniverse.md`](AgeOfUniverse.md)'s cosmic-causal-frontier framing.
- **Quantum-clock instantiation**: a direct experimental match would compare two atomic clocks at different gravitational potentials and verify $\gamma = f_A/f_B$ matches the GR prediction. The standard GR gravitational redshift is already this equation; the QLF reading just reframes it.

---

## References

### Internal

- [`Hierarchical_Control.md`](Hierarchical_Control.md) §2 — names the cross-frequency-relativity claim that this doc formalises; §6 lists this as open work.
- [`Frequency_Synchronization.md`](Frequency_Synchronization.md) — `Δt = R/f` and the resonant-frequency framing.
- [`Hadrons_Markov_Blankets.md`](Hadrons_Markov_Blankets.md) — Markov-blanket at different scales; the "same blanket strategy" recursion.
- [`UniversalRelativity.md`](UniversalRelativity.md) — spacetime emergence in QLF; the constancy of $c$ as an information-transfer bound.
- [`SpaceTime.md`](SpaceTime.md) — event-synthesised space and time.
- [`Gravity.md`](Gravity.md) — gravitational warping as top-down screening; the equivalence-principle bridge for the acceleration generalisation.
- [`AgeOfUniverse.md`](AgeOfUniverse.md) — cosmic causal frontier; the cosmological-redshift application.
- [`Active_Inference_Mathematics.md`](Active_Inference_Mathematics.md) — every closure is a Markov-blanket-relative event; this doc is the relativistic-kinematics face of that framing.

### External

- Einstein, A. (1905). *Zur Elektrodynamik bewegter Körper*. Annalen der Physik 17, 891–921.
- Lorentz, H. A. (1904). *Electromagnetic phenomena in a system moving with any velocity smaller than that of light*. Proc. Royal Netherlands Academy 6, 809–831.
- Misner, C. W., Thorne, K. S., & Wheeler, J. A. (1973). *Gravitation*. W. H. Freeman — rapidity / hyperbolic-rotation picture.

---

### See also

- [`Hierarchical_Control.md`](Hierarchical_Control.md) §6 — this doc closes the "Cross-frequency Lorentz derivation" open item listed there.
- [`UniversalRelativity.md`](UniversalRelativity.md) — the spacetime-emergence companion; together they constitute QLF's full relativistic framing.
- [`Kitada_Local_Time_GR.md`](Kitada_Local_Time_GR.md) — scoping doc reading rapidity = log(internal-frequency ratio) under Kitada's local-time framework. §5.3 derives the **constancy of `c`** from the cosmic-ratio identity `c = R_cosmic / T_cosmic = L_Planck / τ_Planck` — the cosmic-horizon depth `n` cancels exactly, with the derivation structural via the substrate's irreducible space-time event quantum. Lean anchor: [`lean/QLF_SubstrateLightSpeed.lean`](lean/QLF_SubstrateLightSpeed.lean).
