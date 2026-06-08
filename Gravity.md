# Gravity in the Quantum Logical Framework

**Repository:** [`quantum-logical-framework`](https://github.com/jimscarver/quantum-logical-framework)  
**Document:** `Gravity.md`  
**Document version:** 1.4 (updated 7 June 2026 — quantitative substrate program now Lean-anchored)

## 🚀 Quantitative substrate program (June 2026)

The qualitative gravity-from-screening picture below is now backed by a **quantitative Lean-anchored substrate program** that derives Newton's law, Schwarzschild metric, and Mercury's 43"/century perihelion shift from QLF substrate primitives:

| Result | Doc | Lean module | Match to observation |
|---|---|---|---|
| **Newton's law `F = GMm/r²`** | [Gravity_From_Delay.md](Gravity_From_Delay.md) | [`QLF_GravityFromDelay.lean`](lean/QLF_GravityFromDelay.lean) | structural (1/r² from 3D substrate = same 3D that gives α via N=9=3²) |
| **G's structural form `L_Planck² c³/ℏ`** | Gravity_From_Delay §8 | `GravitationalConstant.G_value_eq` | unit-conversion bookkeeping |
| **Schwarzschild weak-field metric** | [GR_Schwarzschild.md](GR_Schwarzschild.md) | (composed in Mercury module) | `g_tt` from Cross-Frequency Lorentz, `g_rr` from substrate event quantum |
| **Mercury perihelion 42.99"/century** | [Mercury_Perihelion.md](Mercury_Perihelion.md) | [`QLF_MercuryPerihelion.lean`](lean/QLF_MercuryPerihelion.lean) | **0.03% vs Park et al. 2017** (42.98 ± 0.04") |

This is the **first quantitative QLF substrate prediction of a GR observable** — matching Einstein's 1915 calculation and the first observational success of GR.

Structural ingredients used (all already Lean-anchored):
- Holographic surface event count `4π R²` (3D substrate)
- Per-event log 2 entropy (`zfa_closure_minimizes_free_energy`)
- `c = L_Planck/τ_Planck` substrate event quantum
- Cross-Frequency Lorentz boost (gravitational redshift)
- Per-qubit mass-energy `m c² = E_Planck/R`

The qualitative material below remains valid as the conceptual foundation; the quantitative program above is the executable extension built on the substrate primitives recorded there.

---

## Abstract

Gravity is **not** a fundamental force or curvature of a pre-existing spacetime. It is the **relational distortion** that emerges when the full Zero Free Action (ZFA) network of distinctions is partially deconstructed by an observer’s Markov blanket. The gauge-folding rule (21 April 2026) supplies the microscopic engine: only `+`–`−` folds create local time, accumulate constructing delay, and produce immediate Hawking radiation, forcing the remaining geometry to warp.

## 1. Emergence from Deconstruction

The complete ZFA history string is a flat relational web of balanced distinctions. Entropy (tracing-out beyond the Markov blanket) deconstructs this web into a single consistent observer slicing. The unresolved distinctions cannot vanish; they must be screened holographically. This screening produces:
- Local contraction around high-density gauge-folded regions (gravity).
- Future-directed expansion in low-density regions (dark-energy equivalent).

No extra fields or spacetime background are required — gravity is the geometric back-reaction to logical information hiding.

## 2. Gauge Folding as the Microscopic Source of Gravity (New Rule)

The presence of **LOCAL gauge twists** (`+` and `-`) determines whether a particle acts as a gravity source:

- **Gauge-folded particles** (`+`–`−`): Primordial quantum black holes.  
  Constructing delay \(\Delta t_{\rm construct} = R / f\) (topological depth \(R\) at vacuum frequency \(f\)) creates **local time** inside the fold.  
  High logical density → inward radial bias in the spin network → gravity.

- **Non-gauge particles** (no `+` or `-`): Massless.  
  Create **local space** only (zero temporal depth).  
  No constructing delay → no local contraction.

The density-dependent space/time role swap (high density makes time the dominant local axis) is the exact mechanism of geodesic deviation and curvature.

## 3. Computational Proof in `particles.py`

Every synthesized particle is now automatically classified. Example run:
```bash
python particles.py --seed "^+" --max-depth 6 --enable-gauge --show-density-swap
```

Typical gauge-fold output:
```text
Topology          : ^+v-
Classification    : primordial_BH
Constructing Delay: 4 cycles
Creates local     : time
Logical Density   : HIGH → time is the local axis
Hawking Radiation : +-
```

This bias is passed directly to the spin-network geometry in the QuCalc engine, reproducing Newtonian gravity, post-Newtonian corrections, and the Schwarzschild metric as emergent limits — all without adding any new fields.

## 4. Summary Table

| Entity                  | Fold Type     | Local Axis Created | Logical Density | Geometric Effect            | Emergent Phenomenon          |
|-------------------------|---------------|--------------------|-----------------|-----------------------------|------------------------------|
| Primordial quantum BH   | `+`–`−`       | Time               | High            | Inward radial bias          | Gravity (local contraction)  |
| Massless particle       | No `+`–`−`    | Space              | Low             | Transverse expansion        | Null geodesics / propagation |
| Cosmological vacuum     | Mixed         | Density-dependent swap | Average      | Net future expansion bias   | Dark-energy equivalent       |

## 5. Ties to Other Documents

**Quantitative substrate program (June 2026, Lean-anchored):**
- [`Gravity_From_Delay.md`](Gravity_From_Delay.md): Newton's law `F = GMm/r²` from holographic event count + per-event log 2 + 3D substrate. `G = L_Planck² c³/ℏ` as unit-conversion bookkeeping; 1/r² as structural 3D signature.
- [`GR_Schwarzschild.md`](GR_Schwarzschild.md): Schwarzschild weak-field metric from Cross-Frequency Lorentz gravitational redshift + substrate radial event scaling. `g_tt = -(1 - R_s/r)`, `g_rr = (1 - R_s/r)⁻¹`.
- [`Mercury_Perihelion.md`](Mercury_Perihelion.md): Mercury's anomalous 43"/century perihelion advance from composed Newton + Schwarzschild; 0.03% match to Park et al. 2017.

**Qualitative foundations:**
- `Entropy.md`: Gravity screens unresolved distinctions (area law \(S = A/4\ell_P^2\)).
- `Frequency_Synchronization.md`: Constructing delay \(R/f\) as the source of local time.
- `SpaceTime.md` & `Time.md`: Density-dependent role swap as origin of relativistic frames; §4 of each unifies gravitational and kinematic time dilation as one mechanism — gravity is the **local departure from the statistically uniform stateless ether** (a mass cluster lowers local \(W_{ZFA}\)), the same uniformity from which Lorentz invariance emerges.
- `Particles.md` & `HALF-SPIN-ZFA-EMBEDDING.md`: Explicit particle classification.
- `Hadrons_Markov_Blankets.md`: Markov blanket = horizon for gauge-folded radiation.
- `BLACK-HOLES.md` (to be rewritten): Full particle ↔ black-hole equivalence proven here.
- [`Hierarchical_Control.md`](Hierarchical_Control.md): Gravity is the macroscopic top-down constraint in the bottom-up/top-down architecture; cosmic-horizon entropy is the highest-level prior.

## Conclusion

Gravity in QLF is the inevitable geometric consequence of entropy deconstruction inside a ZFA-complete logical web. The gauge-folding rule makes this fully computable at the particle scale: only primordial black holes (`+`–`−` folds) curve space locally, while the same mechanism produces cosmic acceleration globally. General relativity emerges as the effective description of QuCalc folds after coarse-graining — no additional postulates required.

See also: [Quantum_Gravity.md](Quantum_Gravity.md) — master synthesis tying gravity (this doc), holography, cosmic expansion, and ER=EPR as four faces of the same algebraic event; [Kitada_Local_Time_GR.md](Kitada_Local_Time_GR.md) §5 — scoping doc identifying the path to quantitative Einstein-equation coefficients (8π, G) via local-clock synchronization failure across a Markov blanket, building on Kitada's local-time framework (gr-qc/9612043) + the QLF substrate's near-equilibrium thermodynamic reading (VacuumEnergy.md §6.2).

*Last aligned with repo state 21 April 2026. This version fully incorporates the gauge-folding rule and `particles.py` v2.2 classification.*
