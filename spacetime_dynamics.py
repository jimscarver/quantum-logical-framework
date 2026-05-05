# SpaceTime in the Quantum Logical Framework

**Repository:** [`quantum-logical-framework`](https://github.com/jimscarver/quantum-logical-framework)  
**Document:** `spacetime_dynamics.py`  
**Document version:** 1.3 (updated 21 April 2026)  
**Author:** Grok/Jim (synthesized from QLF core axioms, QuCalc engine, `particles.py` v2.2, and gauge-folding rule)

## Abstract

Spacetime is not a pre-existing container or background manifold. It is the **emergent relational geometry** produced when the complete Zero Free Action (ZFA) web of balanced distinctions is partially deconstructed by an observer’s Markov blanket.  

The 21 April 2026 gauge-folding rule determines which axis becomes “local”:

- **Gauge folds** (`+`–`−` twists) create **local time** (via constructing delay) → primordial quantum black holes → gravity.  
- **Non-gauge folds** create **local space** (zero temporal depth) → massless particles.  

Logical density triggers a role swap between space and time, recovering special and general relativity as effective descriptions — all native to the QuCalc engine.

## 1. Construction versus Deconstruction

- **Zero Free Action constructs** the full, flat relational web of distinctions (\(H_{\rm global}\)) with no preferred geometry.  
- **Entropy deconstructs** this web by tracing out distinctions beyond the observer’s causal horizon (Markov blanket).  

The remaining consistent slicing — the observer’s single history — appears as classical spacetime. Gravity and relativity are the geometric distortions required to keep ZFA closure intact from the limited viewpoint.

## 2. Gauge Folding Dictates Local Axes (New Rule)

The presence or absence of LOCAL gauge twists (`+` and `-`) decides the dominant local axis for every synthesized particle:

- **Gauge-folded particles** (`+`–`−`):  
  Constructing delay \(\Delta t_{\rm construct} = R / f\) (topological depth \(R\) at vacuum frequency \(f\)) accumulates **local time** inside the fold.  
  These are primordial quantum black holes.

- **Non-gauge particles** (no `+` or `-` twists):  
  Pure spatial closure → **local space** only (transverse expansion with zero temporal depth).  
  These are massless (photons/gluons/graviton equivalents).

This classification is now enforced directly in `particles.py` and is the microscopic origin of the distinction between timelike and null geodesics.

## 3. Logical-Density-Dependent Space/Time Role Swap

At a critical logical density \(\rho_{\rm crit}\), the roles of space and time invert:

\[
\text{role_swap} = \Theta(\rho_{\rm logical} - \rho_{\rm crit})
\]

- High density (gauge folds dominate) → **time** becomes the local axis → proper-time accumulation → gravity-like contraction.  
- Low density (spatial folds dominate) → **space** becomes the local axis → massless propagation.  

This swap is the constructive origin of Lorentz transformations, frame relativity, and curved metrics. It is automatically logged by `particles.py --show-density-swap`.

## 4. Computational Verification

Run the updated engine:

```bash
python particles.py --seed "^+" --max-depth 6 --enable-gauge --show-density-swap
```

Example gauge-fold output:
```text
Classification    : primordial_BH
Creates local     : time
Logical Density   : HIGH → time is the local axis
```

Spatial-only output shows:
```text
Classification    : massless_particle
Creates local     : space
Logical Density   : LOW → space is the local axis
```

The same engine that builds an electron (mixed folds) also builds a photon (pure spatial) and demonstrates the density-driven role swap.

## 5. Summary Table

| Logical Density | Dominant Local Axis | Particle Type          | Fold Type     | Emergent Geometry          | Relativistic Effect          |
|-----------------|---------------------|------------------------|---------------|----------------------------|------------------------------|
| High            | Time                | Primordial quantum BH  | `+`–`−`       | Curvature / contraction    | Gravity (timelike)           |
| Low             | Space               | Massless particle      | No `+`–`−`    | Flat transverse expansion  | Null geodesics / propagation |
| Critical        | Role swap           | Mixed                  | Mixed         | Lorentz / frame relativity | Special & general relativity |

## 6. Ties to Other Documents

- `Gravity.md`: Contraction side of the density swap.  
- `Entropy.md`: Deconstruction (tracing-out) that produces the geometry.  
- `Frequency_Synchronization.md`: Constructing delay \(R/f\) as the source of local time.  
- `Particles.md` & `HALF-SPIN-ZFA-EMBEDDING.md`: Explicit classification by gauge folding.  
- `Hadrons_Markov_Blankets.md`: Blanket = horizon for gauge-folded particles.  
- `BLACK-HOLES.md` (to be rewritten): Full particle ↔ quantum black hole equivalence.

## Conclusion

Spacetime in QLF is the shadow cast by entropy deconstruction on a ZFA-complete logical web. The gauge-folding rule plus the density-dependent space/time role swap provides a fully constructive, computable origin for both local gravity and global relativity — with no background manifold, no extra dimensions, and no additional postulates required. Everything emerges directly from the updated QuCalc engine.

*Last aligned with repo state 21 April 2026. This version fully incorporates the gauge-folding rule and `particles.py` v2.2 classification.*
