# Frequency Synchronization in the Quantum Logical Framework

**Repository:** [`quantum-logical-framework`](https://github.com/jimscarver/quantum-logical-framework)  
**Document:** `Frequency_Synchronization.md`  
**Document version:** 1.2 (updated 21 April 2026)  
**Author:** Grok/Jim (synthesized from QLF core axioms, QuCalc engine, and recent gauge-folding rule)

## Abstract

In the Quantum Logical Framework (QLF), **frequency is not an external parameter** — it is the **resonant rate at which logical distinctions synchronize** across the global history string \(H_{\rm global}\). Frequency synchronization is the precise mechanism that converts topological depth into observable mass, delay, and radiation.

This document explains how frequency governs particle synthesis in QuCalc, with special emphasis on the new gauge-folding rule (21 April 2026):

- **Gauge-folded particles** (`+`–`−` twists) are primordial quantum black holes.  
  They accumulate a **constructing delay** \(\Delta t_{\rm construct} = R / f\) (where \(R\) is topological harmonic depth and \(f\) is the vacuum frequency).  
  This delay **creates local time**.  
  Upon exact Zero Free Action (ZFA) closure they **immediately radiate** as Hawking radiation via one-step horizon re-entry.

- **Non-gauge particles** (no `+` or `-` twists) are massless.  
  They **create local space** with zero temporal depth.  
  No constructing delay and no Hawking radiation occur.

- **Space/time role swap**: The emergent roles of space and time invert depending on **logical density** around the fold. High-density regions (gauge folds) make time the dominant local axis; low-density regions make space dominant. This is the microscopic origin of relativistic frame transformations.

All behavior is native to the updated `particles.py` (v2.2) and `IntuitionisticEngine`.

## 1. What Frequency Synchronization Means in QLF

Frequency \(f\) is the vacuum ecology’s natural “tick rate” — the rate at which unresolved distinctions attempt to close into stable loops. In Planck units the default vacuum frequency is \(f = 1\) (one logical step per unit time), but it can be locally modulated by entanglement density.

- A history string with topological depth \(R\) (number of twists needed for ZFA closure) resonates at frequency \(f = 1/R\).
- Mass emerges directly as \(m \propto R = 1/f\).
- The **constructing delay** is exactly the number of QuCalc cycles required to reach ZFA at that frequency: \(\Delta t_{\rm construct} = R / f\).

This delay is **not** an ad-hoc parameter — it is the logical cost of resolving the primordial divergence inside a dense information ecology.

## 2. Gauge Folding Determines Frequency Behavior (New Core Rule)

The presence or absence of **LOCAL gauge twists** (`+` and `-`) splits all particles into two fundamental classes:

### 2.1 Gauge-Folded Particles (`+`–`−` loops)
- **Classification**: Primordial quantum black holes.
- **Constructing delay**: \(\Delta t_{\rm construct} = R / f\) (non-zero).
- **Local effect**: Creates **local time** inside the Markov blanket (the delay accumulates proper time).
- **Post-closure behavior**: Immediate one-step horizon re-entry → Hawking radiation (see `immediate_reentry_unwind` in `particles.py`).
- **Example output** (from `particles.py --enable-gauge`):
  ```text
  Topology          : ^+v-
  Classification    : primordial_BH
  Constructing Delay: 4 cycles
  Creates local     : time
  Hawking Radiation : +-
  ```

### 2.2 Non-Gauge Particles (spatial/depth-only loops)
- **Classification**: Massless particles (photon/gluon/graviton equivalents).
- **Constructing delay**: 0 cycles.
- **Local effect**: Creates **local space** (pure transverse expansion, zero temporal depth).
- **Post-closure behavior**: No horizon forms → no Hawking radiation.
- **Example output**:
  ```text
  Topology          : ^>v<
  Classification    : massless_particle
  Constructing Delay: 0 cycles
  Creates local     : space
  ```

## 3. Logical-Density-Dependent Space/Time Role Swap

At critical logical density \(\rho_{\rm crit}\), the roles of space and time invert:

- **High density** (gauge folds dominate): Time becomes the “local” axis → constructing delay manifests as proper time → gravity-like contraction.
- **Low density** (spatial folds dominate): Space becomes the “local” axis → massless propagation → expansion-like behavior.

This swap is logged automatically in `particles.py --show-density-swap` and is the microscopic origin of emergent relativity:
\[
\text{role_swap} = \Theta(\rho_{\rm logical} - \rho_{\rm crit})
\]
where \(\Theta\) is the Heaviside step function. It requires no extra postulates — it follows directly from the frequency-synchronization rule applied to gauge vs. non-gauge folds.

## 4. Computational Verification (`particles.py`)

Run the updated engine to see frequency synchronization in action:

```bash
python particles.py --seed "^>" --max-depth 6 --enable-gauge --show-density-swap
```

Typical output demonstrates both classes side-by-side and confirms:
- Gauge folds → delay + local time + immediate Hawking.
- Non-gauge folds → zero delay + local space.
- Density note showing the emergent space/time swap.

## 5. Summary Table

| Fold Type          | Particle Class          | Frequency Behavior          | Constructing Delay | Creates Local | Post-Closure Radiation | Emergent Effect          |
|--------------------|-------------------------|-----------------------------|--------------------|---------------|------------------------|--------------------------|
| `+`–`−` (gauge)    | Primordial quantum BH   | \(f = 1/R\)                 | \(\Delta t = R/f\) | Time          | Immediate Hawking      | Local time + gravity     |
| No `+`–`−`         | Massless particle       | Pure spatial resonance      | 0                  | Space         | None                   | Local space + propagation|
| Density threshold  | Role swap               | High \(\rho\) ↔ low \(\rho\)| —                  | —             | —                      | Relativistic frames      |

## 6. Bottom-up synthesis and top-down constraint

The frequency-synchronization rule above is one face of a deeper architecture: **relativity crosses frequencies, fast controls bottom-up, slow controls top-down.** ZFA closures at the vacuum frequency drive structure up through the scales; Markov-blanket boundaries at each scale screen admissible micro-events from above; cross-frequency time dilation is the relativistic shadow of frequency mismatch between observer scales.

Concretely:

- **Bottom-up (fast → slow, causation)**. Each 1/2-spin ZFA atom ([MRE.md](MRE.md)) is one quantum of free-energy minimization at vacuum frequency. Parallel composition of atoms builds particles, nuclei, atoms, matter. Causation flows up through composition at the rate $f$.
- **Top-down (slow → fast, constraint)**. Each Markov blanket — particle, atomic, hadronic, cosmic ([Hadrons_Markov_Blankets.md](Hadrons_Markov_Blankets.md)) — integrates many fast events into a slowly-evolving boundary state. That state is the prior the agent inside conditions its next closure on. Cosmic-horizon entropy ([AgeOfUniverse.md](AgeOfUniverse.md)) and gravitational warping ([Gravity.md](Gravity.md)) are the highest-level top-down constraints.
- **Cross-frequency = relativity**. The §3 space/time role swap is the local face of this. Lorentz transformations between two observer frames at different logical densities ARE the change of basis between their internal ZFA event rates. Time dilation is forced by ZFA closure consistency, not postulated.

This bottom-up/top-down architecture also **derives Friston's free energy principle from ZFA**: each ZFA closure minimizes free energy by $\log 2$ nats (the per-event maximum, from [MRE.md §2.1](MRE.md)), the topological Markov blanket coincides with Friston's statistical blanket, and active inference is the agent's selection among admissible next ZFA closures. The full development, including the derivation and its open-work caveats (Lean theorem, numerical demo), is in [Hierarchical_Control.md](Hierarchical_Control.md).

## 7. Ties to Other Documents

- [Hierarchical_Control.md](Hierarchical_Control.md): The bottom-up / top-down architecture in full, with the constructive derivation of Friston's free energy principle.
- `Particles.md`: Full particle zoo with gauge/non-gauge classification.
- `HALF-SPIN-ZFA-EMBEDDING.md`: Gauge folds as primordial BH seeds.
- `Entropy.md`: Frequency-delay conserves unitarity in Hawking radiation.
- `Gravity.md` / `SpaceTime.md`: Density-dependent swap as origin of curvature and relativity.
- `BLACK-HOLES.md` (to be rewritten): Will cite this file for the microscopic origin of Hawking radiation.
- [`AgeOfUniverse.md`](AgeOfUniverse.md): Cosmic age derived from ZFA event-synthesis rate — the macroscopic integral of the frequency clock defined here.

## Conclusion

Frequency synchronization is the **clockwork** of QLF. It turns abstract topological depth into mass, delay, time, and radiation — but only when gauge folding (`+`–`−`) is present. Without it, particles remain massless spatial expanders. The density-dependent space/time role swap completes the picture, giving a fully constructive, frequency-driven origin for both quantum particles and emergent spacetime geometry.

All results are now native to the QuCalc engine and fully reproducible.

*Last aligned with repo state 21 April 2026. This document supersedes all prior versions and incorporates the gauge-folding rule from 21 April 2026.*
```
