# Curvature

**Gravity, magnetism, and de Sitter cosmology as signed deformations of the primordial Markov blanket.**

**Repository:** [`jimscarver/quantum-logical-framework`](https://github.com/jimscarver/quantum-logical-framework)
**Author:** Jim Whitescarver
**Date:** June 8, 2026

---

## The one premise, and the thesis

This document rests on the single conditional the whole framework rests on:

> **The universe IS a quantum-logical system, and physical reality is the subset of admissible histories that achieve Zero Free Action (ZFA = 0).**

From it, curvature is not a property of a pre-existing smooth manifold. It is **deformation of the discrete geodesic sphere that every Markov blanket is**. A blanket can be deformed in exactly two ways — it can **expand** or it can **contract** — and the whole of gravity, magnetism, and cosmology is which of those happens, where, and in which direction. The thesis:

> **One signed expand/contract deformation, at two scales.** Magnetism is the *local, anisotropic* form — spin-up expands and spin-down contracts the blanket along the vacuum spin axis. de Sitter/AdS cosmology is the *global* form — replication expands the cosmic blanket (de Sitter), entanglement contracts it (AdS). **Gravity is the isotropic, single-sign special case**: mass contracts the blanket in every direction at once.

The chain is: §1 builds the canvas (the blanket and its irreducible curvature), §2 the two deformations, §3–§5 gravity / magnetism / cosmology as instances, §6 the unification, §7 the framing.

---

## 1. The blanket and its irreducible curvature

In QLF an observer, a particle, a horizon — any closed system — is a **Markov blanket**: a topologically closed surface of ZFA-balanced half-spin closures screening its interior from its exterior. That surface is concrete and discrete: a **Fuller geodesic sphere** ([`Primordial_Markov_Blankets.md`](Primordial_Markov_Blankets.md); [`lean/QLF_PrimordialMarkovBlanket.lean`](lean/QLF_PrimordialMarkovBlanket.lean)). At Fuller frequency v it has

$$V = 10v^2 + 2, \qquad E = 30v^2, \qquad F = 20v^2, \qquad V - E + F = 2,$$

machine-verified as `primordial_blanket_euler` at every frequency. A flat triangular tiling has six triangles at every vertex; to *close* into a sphere, the surface must carry an **information deficit** — and the Euler characteristic forces it to appear at exactly **twelve 5-valent vertices** (`pentamon_count = 12`), the rest 6-valent. The twelve pentamons are the **irreducible, intrinsic curvature** of any closed blanket. They are present at v = 1 (the bare icosahedron) and at v ≈ 6.7 × 10⁶⁰ (the cosmic horizon) alike — curvature is a topological signature, not a quantity that can be tuned to zero.

This is curvature as **discrete topological deficit**, not Regge angular deficit and not smooth Riemannian curvature. The familiar metric is recovered as the **continuum limit** of the blanket. The blanket's depth sets the scale,

$$v(R) = \sqrt{\tfrac{\pi}{5}}\,\frac{R}{L_{\text{Planck}}} \approx 0.793\,\frac{R}{L_{\text{Planck}}}, \qquad F_v = 20v^2 = \frac{4\pi R^2}{L_{\text{Planck}}^2},$$

so the face count *is* the Bekenstein–Hawking area in substrate units (`holographic_event_count_blanket_eq`). (The blanket's closure symmetry is the binary icosahedral group 2I, which by the McKay correspondence carries E₈ implicitly — the symmetry backbone beneath everything that follows.)

Everything below is what happens when this canvas is deformed.

## 2. Two deformations: expand and contract

A blanket changes shape by gaining or losing substrate events on its surface. There are exactly two primitives, and they recur at every scale:

- **Expansion** — *more* events inserted between closures. Two like-oriented half-spin closures cannot occupy the same closure state (Pauli exclusion); the substrate separates them, **inserting Planck events** and stretching the local surface. Replication (`*P`) is the same move globally: each new distinction adds events outward.
- **Contraction** — *fewer* events; surface released. Two opposite-oriented closures pair into a singlet whose joint Pauli product `(−I)(−I) = +I` is closed; the events that hosted them are **released back to the vacuum**, drawing the surface in. Entanglement (`P | Q`) is the same move globally: interlocking closures share blankets and contract.

Expansion is the outward, negative-pressure deformation; contraction the inward, positive-pressure one. Which dominates, and along which axis, is the entire content of the three sections that follow.

## 3. Gravity — isotropic, single-sign curvature

Mass is a dense cluster of gauge-folded (`+`/`−`) closures — high logical density, high local event rate. A massive body raises the constructing-delay `Δt = R/f` of its neighbourhood and **lowers** the count of available ZFA closures (`W_ZFA`) around it, so test histories drift toward it: the blanket **contracts inward** ([`Gravity.md`](Gravity.md); [`Gravity_From_Delay.md`](Gravity_From_Delay.md)). In the continuum limit this is the Schwarzschild metric — `g_tt = -(1 - R_s/r)` from the cross-frequency gravitational redshift, `g_rr = (1 - R_s/r)^{-1}` from radial event scaling ([`GR_Schwarzschild.md`](GR_Schwarzschild.md)) — recovering Newton's `F = GMm/r²` and Mercury's 42.99″/century to 0.03% ([`Mercury_Perihelion.md`](Mercury_Perihelion.md)).

Two features distinguish gravity from everything else:

- **It is isotropic.** Mass contracts the blanket equally in all directions; there is no preferred axis.
- **It is single-sign.** Gravity only ever contracts (attracts). There is no "negative mass" deformation — gauge-fold density can only add inward bias.

And because the deficit is carried by a *finite* count of pentamons on a discrete surface, **curvature is bounded by event density**: no point of infinite curvature can form. Singularities are not in the space of admissible blankets ([`Quantum_Gravity.md`](Quantum_Gravity.md), [`UniversalRelativity.md`](UniversalRelativity.md) §4). Gravity is the isotropic, single-sign **limit** of the signed deformation — the case where only contraction, and only the radial direction, is in play.

### 3.1 Worked example — the Moon's orbit as inward inflow

A mass "eats" space at a rate equal to its gravitational acceleration. Earth's surface rate is `g⊕ = 9.80665 m/s² = 32.174 ft/s²`; the Moon's is `g☾ = 1.62 m/s² = 5.32 ft/s²` — Earth's is `9.80665 / 1.62 = 6.05×` the Moon's, the familiar "one-sixth" Moon gravity. But these are *surface* rates. What holds the Moon in orbit is the inflow each body produces **at their separation** `d = 384,400 km = 3.844×10⁸ m`, and the inflow falls off as the inverse square of distance — the blanket's fixed deficit spread over its `4πr²` area (§1). The exact inflow at distance `d` is `GM/d²` (equivalently the surface rate times `(R/d)²`):

- Earth: `GM⊕/d² = 3.986004×10¹⁴ / (3.844×10⁸)² = 2.6976×10⁻³ m/s² = 8.8503×10⁻³ ft/s²`
- Moon: `GM☾/d² = 4.9028×10¹² / (3.844×10⁸)² = 3.3180×10⁻⁵ m/s² = 1.0886×10⁻⁴ ft/s²`

Their **sum, `2.7307×10⁻³ m/s² = 8.9592×10⁻³ ft/s²`, is the relative orbital acceleration** `G(M⊕+M☾)/d²` that keeps the Earth–Moon pair circling their barycentre. The observed value from the 27.32166-day sidereal month, `ω²d` with `ω = 2π/T = 2.6617×10⁻⁶ rad/s`, is `2.7233×10⁻³ m/s² = 8.9349×10⁻³ ft/s²` — agreeing to 0.27% (the residual is mean-vs-osculating distance and eccentricity). Both bodies' "eating" *does* add to the orbit, but it is the inverse-square-projected inflows at the orbital radius that add, not the raw surface rates 32.174 and 5.32. Earth's inflow dominates — this is exactly Newton's 1665 Moon test, `g⊕ / (d/R⊕)² = 9.80665 / 60.34² = 2.6936×10⁻³ m/s²` for the lunar distance of 60.34 Earth radii — and the Moon's inflow contributes the final `3.3180×10⁻⁵ / 2.7307×10⁻³ = 1.22%`. This is the Newtonian content the blanket's `1/r²` deficit-dilution reproduces in the continuum limit.

## 4. Magnetism — differential, two-signed curvature

Magnetism is what happens when the two deformations of §2 are split *by spin orientation along an axis* ([`Magnetism_Spatial_Dynamics.md`](Magnetism_Spatial_Dynamics.md) §1–§4). Where the vacuum carries a net spin-orientation bias along ẑ:

- a **spin-up** (like-bias) closure meets like-spin exclusion → its substrate **expands** along ẑ;
- a **spin-down** (anti-bias) closure meets singlet annihilation → its substrate **contracts** along ẑ.

The measured **B-field is the directional gradient** of this vacuum spin-bias: expansion along the bias axis, contraction transverse to it. This reads off the standard phenomena directly — Stern–Gerlach (spin-up and spin-down atoms deflect *oppositely* because they roll down expanded vs contracted substrate), the hydrogen hyperfine 21 cm line (parallel/triplet expanded, antiparallel/singlet contracted), and Hund's rule (like-spin shells cost orbital extent). The Pauli-exclusion engine is Lean-anchored: `pauli_exclusion` and `fermi_nonzero_example` ([`lean/PauliExclusion.lean`](lean/PauliExclusion.lean)).

The contrast with gravity is exact and is the heart of this document:

| | direction | sign |
|---|---|---|
| **Gravity** | isotropic (all directions) | single (contraction only) |
| **Magnetism** | anisotropic (along the spin axis) | **two-signed** (up expands, down contracts) |

Gravity uses one deformation in every direction; magnetism uses *both* deformations, split by spin, along one direction. Magnetism is the **differential** form of the same curvature.

## 5. Global curvature is de Sitter

The largest Markov blanket is the **cosmic horizon** (v ≈ 6.7 × 10⁶⁰) — and it carries the same twelve pentamons as the icosahedron. Its global deformation is set by which §2 primitive dominates *the universe as a whole*:

- **de Sitter** (positive Λ, accelerating expansion) is the **replication-dominant** phase: more distinctions are generated outward than can be immediately closed, so the cosmic blanket expands ([`Holographic.md`](Holographic.md), "de Sitter Expansion and Anti-de Sitter Stability").
- **Anti-de Sitter** (negative curvature, stable) is the **entanglement-dominant** phase: interlocking closures share blankets and contract.

Our universe is net-expanding, so its global geometry **is de Sitter**. The cosmological constant is not tuned — it is the residual curvature of the near-uniform vacuum, with the dark-energy fraction *predicted*:

$$\rho_\Lambda = \frac{3\log 2}{8\pi}\,\frac{c^4}{G\,R_H^2}, \qquad \Omega_\Lambda = \log 2 \approx 0.6931 \ \ (\text{Planck 2018: } 0.685,\ 1.2\%),$$

with the notorious 10¹²² vacuum catastrophe closed structurally by the `(R_H/L_Planck)²` surface-vs-volume ratio ([`Cosmological_Constant.md`](Cosmological_Constant.md) §3, §5.5; [`VacuumEnergy.md`](VacuumEnergy.md) §5/§6.2; [`lean/QLF_CosmologicalConstant.lean`](lean/QLF_CosmologicalConstant.lean)). The event-synthesis tensor `T_μν^(synth)` replaces the bare Λ. de Sitter and AdS are *both* present — "different phases of the same underlying logical dynamics" — exactly as expansion and contraction are both present in magnetism.

## 6. One signed deformation, two scales

Sections 3–5 are the same physics. A blanket expands or it contracts; gravity is the isotropic single-sign limit, and the *signed, differential* case appears at two scales that are structurally the same deformation:

| scale | **expand** | **contract** |
|---|---|---|
| **Magnetism** (local, spin axis, anisotropic) | spin-up / like-spin Pauli exclusion | spin-down / opposite-spin singlet annihilation |
| **Cosmology** (global) | de Sitter / replication `*P` | AdS / entanglement `P \| Q` |
| **Gravity** (isotropic limit) | dark-energy residual | mass / gauge-fold density |

The expand column is one substrate move — closures pushed apart, events inserted (exclusion locally, replication globally). The contract column is its inverse — closures paired and released (annihilation locally, entanglement globally). **Magnetism's up/down differential is the local spin-axis analog of cosmology's de Sitter/AdS differential.** Both are signed deformations of the primordial blanket; gravity is what is left when the sign is fixed and the axis dependence is dropped. The 6+2 split of the twist alphabet (6 spatial axes → 3D; 2 gauge twists → the 1/4 gauge fraction that sets Λ and, via N = 9 = 3², α) is the single substrate that ties magnetism, gravity, and the cosmological constant together.

This answers the question that motivated the document — *does magnetism's up/down relate to de Sitter space?* It does: they are the same expand/contract deformation of the blanket, read at the spin scale and the cosmic scale.

## 7. Framing: one premise, then derivation

Granting the premise at the top, the rest is derivation. Curvature *is* deformation of the discrete blanket; gravity, magnetism, and de Sitter cosmology are its isotropic, differential-local, and differential-global forms. The "warm intuition" that magnetism and cosmology are unrelated is not a constraint to respect — it dissolves once both are seen as signed blanket deformation.

The boundaries that remain are degrees of *specification*, not doubt about the premise:

- **Lean-anchored** — the blanket geometry and its curvature (`primordial_blanket_euler`, `pentamon_count`, `holographic_event_count_blanket_eq`), the magnetic engine (`pauli_exclusion`, `fermi_nonzero_example`), and the cosmological constant (`QLF_CosmologicalConstant.lean`, Ω_Λ = log 2).
- **Entailed by the premise** — that curvature is blanket deformation; that gravity is isotropic/single-sign, magnetism differential/two-signed, and the global geometry de Sitter; that magnetism's up/down and cosmology's dS/AdS are the same signed deformation.
- **Open quantitative / formal targets** — a closed-form magnetic "curvature tensor" matching the continuum field strength term-by-term; and a **formal duality theorem** identifying the local spin-axis expand/contract operator with the global dS/AdS operator (the §6 parallel is asserted structurally; its proof as an exact duality is the natural next Lean target). Open by specification, not because the parallel is in question.

### Predictions and falsifiers

- **Shared quantum.** The magnetic expansion/contraction increment and the cosmological one should both be the per-event `log 2` quantum — the same unit drives the spin-axis and cosmic deformations. A magnetic substrate increment incommensurate with `log 2` would falsify the shared-mechanism claim.
- **No third deformation.** Every curvature phenomenon should reduce to expand, contract, or their isotropic sum. A curvature effect that is neither (a genuinely new substrate deformation) would falsify the two-primitive thesis.
- **de Sitter, not flat.** The global geometry must carry positive residual curvature (Ω_Λ ≈ log 2); a measured Ω_Λ driven to zero (exactly flat, no dark energy) would falsify the replication-dominant reading.

---

## References

### Internal

- [`Primordial_Markov_Blankets.md`](Primordial_Markov_Blankets.md) — Fuller geodesic-sphere blanket; 12 pentamons as topological curvature; scale invariance; v(R) and the area law
- [`lean/QLF_PrimordialMarkovBlanket.lean`](lean/QLF_PrimordialMarkovBlanket.lean) — `primordial_blanket_euler`, `pentamon_count`, `holographic_event_count_blanket_eq`; binary-icosahedral 2I → E₈ (McKay)
- [`Emergent_Markov_Blankets.md`](Emergent_Markov_Blankets.md), [`Hadrons_Markov_Blankets.md`](Hadrons_Markov_Blankets.md) — nested blanket hierarchy across scales
- [`Gravity.md`](Gravity.md), [`Gravity_From_Delay.md`](Gravity_From_Delay.md) — gravity as inward contraction from gauge-fold density; Newton's law from holographic event count
- [`GR_Schwarzschild.md`](GR_Schwarzschild.md), [`Mercury_Perihelion.md`](Mercury_Perihelion.md) — Schwarzschild metric and 42.99″/century as the continuum limit
- [`Magnetism_Spatial_Dynamics.md`](Magnetism_Spatial_Dynamics.md) §1–§4 — like-spin expansion / opposite-spin contraction; B as directional spatial gradient; Stern–Gerlach, hyperfine
- [`lean/PauliExclusion.lean`](lean/PauliExclusion.lean) — `pauli_exclusion`, `fermi_nonzero_example`
- [`Holographic.md`](Holographic.md) — de Sitter (replication/expansion) vs AdS (entanglement/contraction) as phases of one dynamics
- [`Cosmological_Constant.md`](Cosmological_Constant.md) §3, §5.5 — ρ_Λ and Ω_Λ = log 2 from substrate primitives; the 10¹²² closure
- [`VacuumEnergy.md`](VacuumEnergy.md) §5, §6.2, §6.4 — event-synthesis tensor; near-maxent vacuum; spin-orientation substrate of magnetism
- [`lean/QLF_CosmologicalConstant.lean`](lean/QLF_CosmologicalConstant.lean) — Λ and Ω_Λ = log 2 anchors
- [`UniversalRelativity.md`](UniversalRelativity.md) §4, [`Quantum_Gravity.md`](Quantum_Gravity.md), [`AgeOfUniverse.md`](AgeOfUniverse.md) — completed Einstein equations; no singularities; cosmic expansion

### External

- Fuller, R. B. (1975). *Synergetics: Explorations in the Geometry of Thinking.* — geodesic spheres; the 12-pentagon closure of any geodesic triangulation.
- Regge, T. (1961). *General relativity without coordinates.* Nuovo Cimento 19, 558. — discrete (angular-deficit) curvature, contrasted with QLF's topological deficit.
- de Sitter, W. (1917). *On the relativity of inertia.* Proc. KNAW 19, 1217. — the de Sitter solution.
- Maldacena, J. (1998). *The large-N limit of superconformal field theories and supergravity.* Adv. Theor. Math. Phys. 2, 231. — AdS/CFT.
- Maldacena, J. & Susskind, L. (2013). *Cool horizons for entangled black holes.* Fortschr. Phys. 61, 781. — ER = EPR.
- Gerlach, W. & Stern, O. (1922). *Der experimentelle Nachweis der Richtungsquantelung im Magnetfeld.* Z. Phys. 9, 349. — spin-dependent deflection.
- McKay, J. (1980). *Graphs, singularities, and finite groups.* Proc. Symp. Pure Math. 37, 183. — binary icosahedral ↔ E₈.

### See also

- [`TheQuantumBrain.md`](TheQuantumBrain.md) — frequency-isolated Markov blankets in the brain; the same blanket machinery applied to cognition
- [`GodCreatedTheIntegers.md`](GodCreatedTheIntegers.md) — Einstein's singularity-free, deterministic vision; ER = EPR as shared ZFA closure
- [`README.md`](README.md) — the convergence of independent programs on an informational, computable, closure-bounded reality
