# Universal Relativity

**The Grand Unification — A Quantum-Logical Completion of Einstein’s Vision**  
*Spacetime, gravity, **the four forces**, mass, cosmic age, and string-like structure as emergent, **relative** perspectives on one zero-free-action event synthesis*

**Repository:** [`jimscarver/quantum-logical-framework`](https://github.com/jimscarver/quantum-logical-framework)  
**Authors:** Jim Whitescarver, with Grok (xAI) and Claude (Anthropic)  
**Date:** April 26, 2026 (grand-unification update 15 June 2026)  

> **Universal Relativity is the grand unification.** Einstein made *spacetime* relative; QLF makes
> *everything* relative. The four forces, gravity, and mass are not separate things — they are
> **relative perspectives on one ZFA closure**, seen from different 3-axis projections, at different
> logical densities, in different Markov-blanket frames. There is one substrate; physics is the set of
> relative views of it. (§4a.)

## Summary

Universal Relativity extends Einstein's central move — *no absolute frame, no absolute simultaneity* —
from spacetime to the whole of physics. From the single postulate that only zero-free-action (ZFA)
histories persist:

- **Spacetime is synthesized**, not given: intervals are built event-by-event from ZFA closures
  ([`SpaceTime.md`](SpaceTime.md)).
- **Special relativity is derived**: local `c`, Lorentz invariance, and the equivalence principle
  emerge from closure in a statistically uniform stateless ether ([`Time.md`](Time.md) §4,
  [`Cross_Frequency_Lorentz.md`](Cross_Frequency_Lorentz.md)), rather than being postulated.
- **Singularities are impossible by construction**: event synthesis is discrete and finite, so gravity
  and cosmic expansion are local quantum event synthesis, not divergences ([`BLACK-HOLES.md`](BLACK-HOLES.md)).
- **The four forces are one perspective-dependent closure** (§4a,
  [`Forces_From_Three_Axes.md`](Forces_From_Three_Axes.md)): electromagnetism is the *abelian* trace,
  the weak and strong forces are its *non-abelian* spatial projections (at different logical densities),
  and gravity is the *geometry* of the same closures — joined at **mass = constructing delay**. Einstein
  made spacetime relative; Universal Relativity makes *everything* relative: which projection, what
  density, whose frame.
- **Causality stays strictly local**: light-speed correlations are same-time, same-place closure
  events; only information from the past acts locally, and the past determines the future purely
  locally — the realized history is a causal set ([`SpaceTime.md`](SpaceTime.md)).
- **Cosmic age is a derived count of Planck ticks** `t₀ = N·τ_Planck`, not an empirical input (§5,
  [`AgeOfUniverse.md`](AgeOfUniverse.md)).
- **Quantum gravity and the dark sector are accounted for**: gravity is quantized as the discrete
  causal-set geometry of closures (no graviton to gauge — [`Quantum_Gravity.md`](Quantum_Gravity.md),
  the master synthesis); **dark energy** is `Ω_Λ = log 2`, the local-clock tick that closes the 10¹²²
  vacuum catastrophe ([`Cosmological_Constant.md`](Cosmological_Constant.md)); and **dark matter** is
  denser logic near masses on the *same* Hubble horizon — `a₀ = cH₀/2π`, expand/contract as the two
  faces of one horizon ([`DarkMatter.md`](DarkMatter.md)).

The single most complete companion is [`Quantum_Gravity.md`](Quantum_Gravity.md) — the master synthesis
treating this completion as one face of a unified algebraic event (gravity, holography, expansion, the
dark sector, ER=EPR). The personal narrative and the Einstein dialog behind it are in
[`MyStory.md`](MyStory.md).

## Abstract

Universal Relativity is a proposed quantum-logical completion of Einstein’s relativity. It treats spacetime, gravity, cosmic expansion, quantum measurement, and string-like extended structure as emergent consequences of a single postulate:

> **Only zero-free-action histories persist as physical events.**

In this framework the universe is **possibilist**: all admissible logical histories exist as possibilities, but only histories that achieve **Zero Free Action** (`ZFA = 0`) are realized as events. Those events synthesize spacetime intervals. Matter, fields, gravity, and cosmic time are therefore not assumed as primitive. They emerge from stable closures in an 8-twist quantum-logical algebra:

```text
^ v < > / \ + -
```

Einstein assumed a constant local speed of light and the equivalence principle. Universal Relativity **derives** local `c` and Lorentz invariance from ZFA closure — the uniform-ether mechanism of [`Time.md`](Time.md) §4 / [`SpaceTime.md`](SpaceTime.md) §4 (see §3) — and grounds the equivalence principle in the same dilation mechanism. The program is computable and singularity-free by construction.

The recent `AgeOfUniverse.md` update extends this idea to cosmology. The cosmic age of approximately **13.8 billion years** is interpreted not as the age of possibility itself, nor as proof of an absolute beginning, nor as a free empirical input, but as a **derived count of Planck ticks** — the effective proper time accumulated along the realized ZFA event history of our observable universe (`ℏ` fixes the tick, the substrate fixes the count; §5).

## 1. Possibilist Ontology

All possible quantum-logical histories exist as possibilities. A physical event occurs only when a history closes with zero free action.

Every physical process is represented as a history string in the 8-twist algebra. Zero Free Action is the closure condition:

$$
\sum_{i=0}^{7} \text{imbalance}_i = 0
$$

This means exact balance among the eight twist directions:

```text
^ v < > / \ + -
```

A ZFA-closed history becomes an event. A non-closed history remains only a possibility. Physics is therefore the realized subset of possibilistic quantum logic.

See:

- [`possibilist-ontology.md`](possibilist-ontology.md)
- [`zfa-catalog-rho-notation.md`](zfa-catalog-rho-notation.md)
- [`QuCalc.md`](QuCalc.md)

## 2. The Sole Fundamental Postulate

Universal Relativity replaces multiple physical assumptions with one quantum-logical rule:

> **Every realized history must close with Zero Free Action.**

From this single rule the framework accounts for:

- spacetime interval synthesis;
- constant local light speed;
- Lorentz invariance;
- gravitational equivalence;
- Pauli exclusion;
- dark-energy-like cosmic expansion;
- effective cosmic age;
- string-like extended histories.

The central claim is not that events occur inside spacetime. The stronger claim is:

> **Events synthesize spacetime.**

## 3. Emergence of Special Relativity

In [`SpaceTime.py`](SpaceTime.py), a ZFA event is converted into emergent macroscopic intervals:

```python
photon = SpacetimeGenerator("^^^^<<<<////")
model = photon.model_spacetime()
# → Space x ∝ spatial free action
# → Time t ∝ 1 / local free action
# → Clock frequency f = 1/t
```

The invariant interval is interpreted as the large-scale expression of ZFA closure. Hermitian conjugacy supplies the complementary relation required for closure, while Lorentz transformations preserve the balanced event structure.

Example:

```text
ZFA photon history: ^>v< (closed)
Emergent Δx = 1.0, Δt = 1.0 → c = 1 (natural units)
Boosted observer sees same invariant interval
```

The mechanism behind this emergent Lorentz invariance is now explicit: the QLF vacuum is a **statistically uniform, stateless ether** (Einstein's 1920 ether — real metric structure, no preferred frame), derived in [`Time.md`](Time.md) §4 and [`SpaceTime.md`](SpaceTime.md) §4. No frame being privileged, time dilation is reciprocal and local `c` is frame-independent — Lorentz invariance is emergent, not postulated. The explicit boost-as-frequency-change-of-basis is in [`Cross_Frequency_Lorentz.md`](Cross_Frequency_Lorentz.md).

## 4. Completion of General Relativity

Einstein’s equation with a bare cosmological constant is:

$$
G_{\mu\nu} + \Lambda g_{\mu\nu}
= \frac{8\pi G}{c^4} T_{\mu\nu}^{(\mathrm{matter})}
$$

Universal Relativity replaces the fixed cosmological term with a dynamical event-synthesis tensor built from a scalar field $\phi$, interpreted as local ZFA event density:

$$
T_{\mu\nu}^{(\mathrm{synth})}
= \partial_\mu \phi\, \partial_\nu \phi
- g_{\mu\nu}
\left[
\frac{1}{2}(\nabla \phi)^2 + V(\phi)
\right]
$$

where:

$$
\phi \propto \frac{1}{\text{local free action}}
$$

When $\phi$ is approximately homogeneous and static, the synthesis tensor behaves like an effective cosmological term. When $\phi$ varies, it represents local event-density structure. Singularities are avoided because event synthesis is discrete and finite rather than continuous and infinitely divisible.

See:

- [`Gravity.md`](Gravity.md)
- [`VacuumEnergy.md`](VacuumEnergy.md)
- [`BLACK-HOLES.md`](BLACK-HOLES.md)
- [`lean/SpacetimeDynamics.lean`](lean/SpacetimeDynamics.lean)

## 4a. The Grand Unification — the four forces as relative perspectives on one closure

Einstein's relativity made *spacetime* relative — no absolute frame, no absolute simultaneity. Universal
Relativity extends the same move to **all of physics**: the four forces, gravity, and mass are not
separate fundamentals but **relative perspectives on one ZFA closure**, differing only in *which
projection*, at *what logical density*, in *whose Markov-blanket frame* the closure is viewed.

**One gauge interaction, three projections (the gauge forces).** There is a single gauge-twist closure
on the three spatial axes. The three "forces" are which component of the `3×3` directional structure it
is read through ([`Forces_From_Three_Axes.md`](Forces_From_Three_Axes.md) §3, §3a):

- **Electromagnetism = the *abelian* sector** — the gauge-fold (Pauli scalar) group *commutes*
  (`em_gauge_abelian`, [`lean/QLF_GaugeUnification.lean`](lean/QLF_GaugeUnification.lean)) ⟹ the
  **massless, long-range photon**, the unbroken `U(1)`.
- **Weak and strong = *non-abelian* projections** of the same three axes (`strong_nonabelian`,
  `weak_isospin_su2`) ⟹ self-interacting, short-range, **confined / massive**.

So the abelian/non-abelian split **is** the massless-photon-vs-massive-`W`/`Z` split. **Electroweak
symmetry breaking** is the **logical-density threshold**: above it the projections are symmetric (all
gauge bosons massless, unified); below it the Markov-blanket structure (QLF's constructive Higgs =
gauge-fold delay, [`Higgs.md`](Higgs.md)) confines the non-abelian projections, giving `W`/`Z` mass as
gauge-fold depth (`m = 1/R`) while the photon stays free. The Weinberg angle `sin²θ_W = 3/8` is the
projection ratio (`sin2_weinberg_substrate_eq`, [`lean/QLF_WeinbergAngle.lean`](lean/QLF_WeinbergAngle.lean)).
The weak projection **catalyzes** transformations because it *re-projects the blanket itself* (a flavour
change is a change of 3-D perspective — the β⁺ keystone of [`Fusion.md`](Fusion.md)).

**Gravity = the fourth force as the *geometry* of the same closures.** Gravity is **not** a fourth gauge
force (QLF does not try to gauge it — the move that has defeated quantum-gravity programs). It is the
emergent geometry of the *aggregate* of closures: the **causal order** is a causal set
([`lean/QLF_ReachableEvent.lean`](lean/QLF_ReachableEvent.lean)) whose number↔volume and layer growth
give the metric and curvature (Sorkin / Benincasa–Dowker, [`lean/QLF_CausalInterval.lean`](lean/QLF_CausalInterval.lean),
[`lean/QLF_CausalDimension.lean`](lean/QLF_CausalDimension.lean)), and the **thermodynamics** of each
local horizon fixes `8πG = 2π/η`, `Λ = log 2` (Jacobson, `einstein_coupling_from_thermodynamics`,
[`lean/QLF_EinsteinEquations.lean`](lean/QLF_EinsteinEquations.lean), [`Einstein_Equations.md`](Einstein_Equations.md)).
The gauge forces are how closures *interact*; gravity is how closures *arrange*.

**The hinge is mass = constructing delay.** The gauge-fold delay that electroweak breaking reads as
*inertial* mass is the *same* delay the causal geometry reads as the *gravitational* source — so the
**equivalence principle falls out of the substrate**: one delay, inertia at the vertex and curvature in
the geometry. (The graviton is correspondingly composite spin-2, not a fundamental gauge boson.)

> **The grand-unified statement.** *One substrate: ZFA closure. The four forces are relative
> perspectives on it — electromagnetism the abelian trace, the weak and strong forces its non-abelian
> spatial projections (seen at different logical densities), and gravity the geometry of the aggregate.
> Mass — the constructing delay — is the hinge that joins the gauge sector to gravity. Everything is
> relative: which projection, what density, whose frame. There is one closure; physics is its set of
> relative views.*

This is the same `6+2` / three-axis substrate that fixes `α` (`N=3²`,
[`lean/QLF_FineStructureSubstrate.lean`](lean/QLF_FineStructureSubstrate.lean)), `Ω_Λ` (`2/8`,
[`lean/QLF_CosmologicalConstant.lean`](lean/QLF_CosmologicalConstant.lean)), the Weinberg angle (`3/8`,
[`lean/QLF_WeinbergAngle.lean`](lean/QLF_WeinbergAngle.lean)), the `5̄⊕10` generation
([`lean/QLF_SU5.lean`](lean/QLF_SU5.lean)), and the 3-dimensionality of space itself
([`SpaceTime.md`](SpaceTime.md) §3a). **Honest scope:** the *unification* is structural and
substrate-grounded (the gauge algebras, the abelian/non-abelian split, the Weinberg ratio, the
equation-of-state coefficient, the causal-order curvature structure are all machine-anchored); the
quantitative *dynamics* — the gauge couplings and Higgs VEV, the discrete d'Alembertian → Ricci and the
continuum field equations — are the named open rungs ([`Forces_From_Three_Axes.md`](Forces_From_Three_Axes.md)
§3a–3b, [`Einstein_Equations.md`](Einstein_Equations.md) §6a).

## 5. Age of the Universe as Event-Synthesis Time

The recent repository update [`AgeOfUniverse.md`](AgeOfUniverse.md) adds a QLF treatment of cosmic age:

```text
universe_age = "~13.8 Gyr effective cosmic age from ZFA event-synthesis history"
```

In standard cosmology, the age of the observable universe is *inferred* from the expansion history of
the scale factor — an empirical fit. Universal Relativity does **not** retain it as an empirical scale:
the age is a **count of Planck ticks**, `t₀ = N · τ_Planck`. Planck's constant fixes the tick
`τ_Planck = √(ℏG/c⁵)` with no empirical input; the substrate fixes the count `N` (the cosmic depth, via
hadronic depth and the `Ω_Λ = log 2` crossover), so `t₀ ≈ 13.8 Gyr` is *derived* with no `H₀` tuning
([`AgeOfUniverse.md`](AgeOfUniverse.md)), up to a single calibration.

The age of the universe is not the age of possibility itself, and it is not a free empirical input. It
is the effective accumulated proper time synthesized by the realized ZFA event history of our
observable universe — a finite integer of `ℏ`-sized ticks, *what the cosmic clock reads now*.

In QLF notation:

$$
t_0 \approx \sum_{e \in \mathcal{H}_0} \Delta \tau_e
$$

where $\mathcal{H}_0$ is the realized ZFA-closed history of our observable universe, and $\Delta \tau_e$ is the local interval synthesized by event $e$.

Since event intervals are inversely related to local frequency:

$$
\Delta \tau_e \sim \frac{1}{f_e}
$$

we may write:

$$
t_0 \sim \sum_{e \in \mathcal{H}_0} \frac{1}{f_e}
$$

The age update connects this to the observed frequency distribution of vacuum/ZFA events using:

$$
n(\omega) \propto \frac{1}{\omega}
$$

The total event-synthesis rate is modeled as:

$$
R = \int_{\omega_{\min}}^{\omega_{\max}} n(\omega)\,d\omega
$$

and the effective cosmic age is related to the expansion integral:

$$
t_0 = \int_0^1 \frac{da}{aH(a)}
$$

**The age is not an empirical input — it is a count of Planck ticks.** Write `t₀ = N · τ_Planck`. The
**tick** `τ_Planck = √(ℏG/c⁵)` is the substrate event quantum, fixed by `ℏ` (with `G`, `c` themselves
substrate-derived) — *Planck's constant alone sets the size of one tick of the cosmic clock, with no
empirical input*. What remains is the **count** `N` (the cosmic Markov-blanket depth, `~6.7×10⁶⁰`), and
`N` is **not free** either: the substrate fixes it through the **hadronic-depth** relation
`N ~ (m_P/m_p)³` and the **dark-energy crossover** (we observe at the era where `Ω_Λ = log 2`, which
fixes the Hubble horizon `R_H` and hence `N`). [`AgeOfUniverse.md`](AgeOfUniverse.md) derives `t₀ ≈ 13.8
Gyr` from the ZFA event-frequency spectrum *with no tuning to `H₀` or the dark-energy density*. So the
`~13.8 Gyr` is a **derived count of ℏ-sized ticks**, not an empirical boundary condition; the one
residual is a single calibration (effectively `H₀`/the overall scale), which "reduces to deriving `N`"
([`Open_Problems.md`](Open_Problems.md)). The only genuinely state-like fact is that "now" is a clock
reading — *how far the construction has got* — but the characteristic age (the dark-energy-onset epoch)
is substrate-determined.

See:

- [`AgeOfUniverse.md`](AgeOfUniverse.md)
- [`lean/AgeOfUniverse.lean`](lean/AgeOfUniverse.lean)
- [`VacuumEnergy.md`](VacuumEnergy.md)
- [`lean/SpacetimeDynamics.lean`](lean/SpacetimeDynamics.lean)

## 6. Quantum Mechanics as Local ZFA Dynamics

Quantum mechanics is interpreted as the microscopic dynamics of the same event process.

- Superposition is represented by parallel admissible histories.
- Entanglement is shared closure structure across histories.
- Measurement is the realization of a ZFA-closed history.
- Pauli exclusion is antisymmetric closure for fermionic histories.

In RhoQuCalc notation, parallel quantum-logical composition is represented by:

```text
P | Q
```

A fermionic event cannot be duplicated into the same ZFA history without contradiction. This bounds local event density and contributes to stable matter.

See:

- [`RhoQuCalc.lean`](lean/RhoQuCalc.lean)
- [`PauliExclusion.lean`](lean/PauliExclusion.lean)
- [`quantum_simulator.py`](quantum_simulator.py)

## 7. Relation to String Theory

Universal Relativity provides a bridge to string theory without treating strings as fundamental objects in a pre-existing spacetime background.

String theory begins with extended one-dimensional objects whose modes appear as particles. Universal Relativity begins with **history strings** in the 8-twist algebra. A particle-like state is a stable ZFA-closed pattern of logical action. A string-like object is therefore a higher-order process composed of many event closures.

| Question | String Theory | Universal Relativity / QLF |
|---|---|---|
| Primitive object | Fundamental string or brane | ZFA-closed event/history string |
| Background | Usually formulated on spacetime | Spacetime synthesized by events |
| Extra dimensions | Added for consistency | Interpreted as orthogonal twist directions |
| Particle modes | Vibrations of strings | Stable spectra of ZFA histories |
| Vacuum landscape | Many possible compactifications | Possibilist sectors of ZFA closure |
| Gravity | Graviton mode / geometry | Event-synthesis delay and curvature |

Thus string theory is not simply rejected. It is reinterpreted as an effective language for extended ZFA histories.

See:

- [`StringTheory.md`](StringTheory.md)
- [`lean/StringTheoryQLF.lean`](lean/StringTheoryQLF.lean)
- [`lean/MTheoryQLF.lean`](lean/MTheoryQLF.lean)

## 8. Predictions and Testability

Universal Relativity aims to be testable by requiring the ZFA event model to reproduce known physics while predicting measurable deviations.

Key targets include:

- recovery of local Lorentz invariance;
- recovery of GR in the large-scale limit;
- recovery of the observed cosmic age near 13.8 Gyr;
- dark-energy-like acceleration from event synthesis;
- finite black-hole interiors without information loss;
- emergent constants from ensemble averages;
- possible small deviations in the dark-energy equation-of-state parameter `w`.

The theory must reproduce existing observations before any new prediction can be considered successful.

## 9. Implementation in QLF

The theory is represented in the repository through:

- **Core engine:** [`qucalc_engine.py`](qucalc_engine.py), [`twist_core.py`](twist_core.py)
- **Spacetime synthesis:** [`SpaceTime.py`](SpaceTime.py)
- **Gravity and tensors:** [`gravitational_tensor.py`](gravitational_tensor.py), [`spacetime_dynamics.py`](spacetime_dynamics.py)
- **Age of universe:** [`AgeOfUniverse.md`](AgeOfUniverse.md), [`lean/AgeOfUniverse.lean`](lean/AgeOfUniverse.lean)
- **String bridge:** [`StringTheory.md`](StringTheory.md), [`lean/StringTheoryQLF.lean`](lean/StringTheoryQLF.lean), [`lean/MTheoryQLF.lean`](lean/MTheoryQLF.lean)
- **RhoQuCalc:** [`rho_transpiler.py`](rho_transpiler.py), [`quantum_simulator.py`](quantum_simulator.py)
- **Formalization:** [`lean/ZFAEventDynamics.lean`](lean/ZFAEventDynamics.lean), [`lean/RhoQuCalc.lean`](lean/RhoQuCalc.lean), [`lean/SpacetimeDynamics.lean`](lean/SpacetimeDynamics.lean), [`lean/PauliExclusion.lean`](lean/PauliExclusion.lean)

Run:

```bash
git clone https://github.com/jimscarver/quantum-logical-framework
cd quantum-logical-framework
pip install -e .

python spacetime_dynamics.py
lean --run lean/SpacetimeDynamics.lean
lean --run lean/AgeOfUniverse.lean
```

## 10. Theory in One Sentence

Universal Relativity states that the physical universe is the realized subset of all possible quantum-logical histories whose event strings close with zero free action, thereby synthesizing spacetime, matter, **the four forces**, gravity, mass, cosmic time, and string-like structure as **relative perspectives** on one balanced logical closure — the abelian trace (EM), the non-abelian spatial projections (weak, strong), and the causal-order geometry (gravity), joined at mass = constructing delay.

## Conclusion

Universal Relativity recasts Einstein’s geometric vision at a deeper quantum-logical level, and **completes it into the grand unification**. Geometry is not fundamental. Spacetime is synthesized by events. Gravity is the large-scale expression of event-density structure and delay. Quantum mechanics is the local bookkeeping of ZFA closure. And the **four forces are one** — relative perspectives on a single gauge-twist closure (EM the abelian trace; weak and strong its non-abelian spatial projections at different logical densities; gravity the geometry of the aggregate), joined to gravity at mass = constructing delay (§4a). Einstein made spacetime relative; Universal Relativity makes *everything* relative — there is one closure, and physics is its set of relative views.

The age of the universe, approximately **13.8 billion years**, is **not** an empirical boundary
condition — it is a *count of Planck ticks*, `t₀ = N · τ_Planck`. Planck's constant fixes the tick
`τ_Planck = √(ℏG/c⁵)` with no empirical input; the substrate fixes the count `N` (hadronic depth,
`Ω_Λ = log 2` crossover), so `t₀` is derived (no `H₀` tuning, [`AgeOfUniverse.md`](AgeOfUniverse.md)) up
to one calibration. It is the effective proper time accumulated by the realized event-synthesis history
of our observable universe — *what time the cosmic clock reads*, whose tick is `ℏ`.

The universe does not have to begin as a singular object in pre-existing time. It is an ongoing quantum-logical synthesis of time, space, matter, and relation.

**Further reading**

- [`Forces_From_Three_Axes.md`](Forces_From_Three_Axes.md) — the grand unification in detail: the gauge forces as 3-axis projections (§3a) and gravity as the fourth force, the geometry of the same closures (§3b)
- [`Einstein_Equations.md`](Einstein_Equations.md) — the field equations as the substrate's equation of state + the curvature side from the causal order (§6a)
- [`WHITE_PAPER.md`](WHITE_PAPER.md)
- [`possibilist-ontology.md`](possibilist-ontology.md)
- [`Philosophy.md`](Philosophy.md)
- [`Time.md`](Time.md) — time threads, the stateless uniform ether, and the explicit derivation of Lorentz invariance from vacuum uniformity (§4)
- [`SpaceTime.md`](SpaceTime.md)
- [`Gravity.md`](Gravity.md)
- [`VacuumEnergy.md`](VacuumEnergy.md)
- [`BLACK-HOLES.md`](BLACK-HOLES.md)
- [`AgeOfUniverse.md`](AgeOfUniverse.md)
- [`StringTheory.md`](StringTheory.md)
- [`E_mc2_derivation.md`](E_mc2_derivation.md)
- [`Hierarchical_Control.md`](Hierarchical_Control.md) — cross-frequency relativity as the bridge between bottom-up ZFA event synthesis and top-down Markov-blanket constraint; Lorentz transformations as change-of-basis between frame-local ZFA event rates.
- [`Cross_Frequency_Lorentz.md`](Cross_Frequency_Lorentz.md) — explicit derivation of the Lorentz boost as a change of basis on Markov-blanket internal frequencies; identifies γ = cosh(rapidity) with the frequency-ratio Doppler factor; recovers time dilation, length contraction, and interval invariance.
- [`Quantum_Gravity.md`](Quantum_Gravity.md) — master synthesis treating this doc's relativity completion as one face of a unified algebraic event (gravity, holography, expansion, ER=EPR).
- [`Curvature.md`](Curvature.md) — curvature as signed deformation of the primordial Markov blanket: gravity (isotropic), magnetism (differential), de Sitter cosmology (global); the metric of §3–§4 as its continuum limit.

Welcome to Universal Relativity.
