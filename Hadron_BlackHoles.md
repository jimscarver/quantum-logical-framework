# Mesons and baryons as quantum black holes

Lean: [`lean/QLF_QuantumBlackHole.lean`](lean/QLF_QuantumBlackHole.lean).

## The question

[QLF](README.md) already says a **gauge-folded particle** (`+`–`−` twists) *is* a primordial quantum
black hole — a Planck-scale Markov blanket that functions as a horizon and radiates
([BLACK-HOLES.md](BLACK-HOLES.md), [Hadrons_Markov_Blankets.md](Hadrons_Markov_Blankets.md)).
What about the composite hadrons — the pion, the proton, the neutron? Are *they* quantum
black holes too?

**Yes.** Every hadron is a Markov-blanket horizon. The earlier docs drew a line — composite
hadrons were called blankets but "not yet black holes" — that this note erases: the
difference between a proton and a primordial black hole is not *whether* it is a horizon but
whether its gauge / chirality is **hidden** or **exposed**.

## Why the horizon is the Planck blanket, not a Schwarzschild horizon

A sub-Planck particle is **not** a Schwarzschild black hole at its own Compton scale. In
Planck units (`ℏ = c = G = 1`, mass `μ = m/M_Planck`) the two relevant radii are

- reduced Compton radius `λ_C = 1/μ` (quantum size of the particle),
- Schwarzschild radius `r_s = 2μ` (gravitational horizon of the mass).

These coincide **only at the Planck mass**: `1/μ = 2μ ⟺ μ² = 1/2`
(`compton_eq_schwarzschild_iff`, machine-verified). For any sub-Planck mass `μ² < 1/2` — and
every hadron is `~10⁻¹⁹` of the Planck mass — the Compton radius is far the larger
(`sub_planck_compton_gt_schwarzschild`). So a hadron's Schwarzschild radius is buried deep
inside its Compton wavelength; it is not a Schwarzschild hole. Its quantum-black-hole horizon
is instead the **Planck-scale Markov blanket** — the `+`–`−` gauge-fold boundary QLF already
identifies as the horizon. The Compton–Schwarzschild crossing is exactly the Planck-mass
boundary where "particle" and "black hole" descriptions merge (Carr–Mureika–Nicolini).

## The horizon obeys the area law

A hadron's blanket carries the substrate holographic entropy
`S = 4π R² log 2` (`hadron_horizon_entropy_eq`, reusing the Lean-verified
`holographic_entropy_eq` from [`QLF_GravityFromDelay`](lean/QLF_GravityFromDelay.lean)). The
entropy scales as the **area** of the blanket, not its volume — the Bekenstein–Hawking area
law at substrate granularity (the substrate `log 2` per event vs the continuum `1/4` is the
known coarse-graining factor, [Gravity_From_Delay.md §4](Gravity_From_Delay.md)).

## Mass = E_Planck / R: lighter is deeper

The per-qubit mass quantum is `m = E_Planck / R` for blanket depth `R`
([Per_Qubit_Mass_Quantum.md](Per_Qubit_Mass_Quantum.md)); in Planck units `m = 1/R`. So a
**lighter** hadron is a **deeper, larger** horizon (`lighter_is_deeper`). The pion — the
lightest hadron — is therefore the **deepest hadronic horizon**, which dovetails with its
being the cosmologically-selected hadronic scale: QLF's cosmic-depth relation
`m³ ~ ℏ²H₀/Gc` is satisfied by the pion, not the proton ([Pion_QLF.md §2](Pion_QLF.md),
[HadronicDepth.md](HadronicDepth.md)). The pion is the QCD-scale horizon the universe's ZFA
depth picks out.

## The coherence: hidden vs exposed chirality fixes *both* mass and horizon fate

The single distinction that sets a hadron's mass factor *also* sets its horizon's fate:

| hadron | quarks | chirality | mass factor | horizon | fate |
|---|---|---|---|---|---|
| proton | 3 (`\|S₃\|=6`) | **hidden** (Borromean) | geometric `π⁵` → `6π⁵` | composite, **non-radiating** | **stable** |
| pion `±` | 2 (`\|S₂\|=2`) | **exposed** (Goldstone) | EM `1/α` → `2/α` | exposed gauge fold, **radiating** | **decays** (Hawking evaporation) |

The proton hides its chirality inside the Borromean closure: the gauge folds are routed
internally, the horizon does not radiate, and the chirality integrates away into the
*geometric* factor `π⁵` ([`QLF_LenzMassRatio`](lean/QLF_LenzMassRatio.lean)). The pion exposes
its chirality as the pseudoscalar Goldstone mode: the gauge fold is open, the horizon
radiates (the pion decays — `π± → μν`, `π⁰ → γγ`), and the chirality couples
electromagnetically with strength `α`, giving the *EM* factor `1/α`
([`QLF_PionMassRatio`](lean/QLF_PionMassRatio.lean)). **One axis — hidden vs exposed —
produces two coupled consequences: the mass factor and whether the horizon evaporates.**
Particle decay *is* Hawking evaporation of a small quantum black hole; hadron stability *is* a
non-radiating composite horizon. The meson-vs-baryon split is machine-anchored on
`baryonNumber` (`pion_meson_horizon`: `B=0`; `proton_baryon_horizon`: `B=1`).

## Honest scope

This is a **unification + thermodynamic reading**, not a new mass mechanism. The blanket
depth `R` for a given hadron is identified from its measured mass — it is an *input*, not
derived (`m = E_Planck/R` runs both ways, and a charged pion is super-extremal, so only the
small `m(π±) − m(π⁰) ≈ 4.6` MeV splitting is electromagnetic, not the bulk `2/α`). So
black-hole thermodynamics does **not** derive absolute hadron masses or the pion's `1/α` —
that remains the open mechanism `pion_mass_ratio_in_progress`
([Pion_QLF.md §3](Pion_QLF.md)). What this note *does* establish, machine-verified: every
hadron is a Planck-blanket quantum black hole (the Compton–Schwarzschild crossing fixes the
horizon there), obeying the area law, with mass `1/R` and a meson/baryon classification — and
the coherence that the hidden/exposed chirality axis governs mass factor *and* horizon fate
together.

## References

- J. D. Bekenstein, *Black holes and entropy*, Phys. Rev. D **7** (1973) 2333.
- S. W. Hawking, *Particle creation by black holes*, Commun. Math. Phys. **43** (1975) 199.
- B. J. Carr, J. Mureika & P. Nicolini, *Sub-Planckian black holes and the
  Generalized Uncertainty Principle*, JHEP **07** (2015) 052 — the Compton–Schwarzschild
  duality / particle–black-hole unification at the Planck mass.
- G. 't Hooft, *Dimensional reduction in quantum gravity*, gr-qc/9310026 (1993) — holography.

**See also:** [BLACK-HOLES.md](BLACK-HOLES.md), [Hadrons_Markov_Blankets.md](Hadrons_Markov_Blankets.md),
[Pion_QLF.md](Pion_QLF.md), [Per_Qubit_Mass_Quantum.md](Per_Qubit_Mass_Quantum.md),
[Gravity_From_Delay.md](Gravity_From_Delay.md),
[`lean/QLF_QuantumBlackHole.lean`](lean/QLF_QuantumBlackHole.lean),
[`lean/QLF_GravityFromDelay.lean`](lean/QLF_GravityFromDelay.lean),
[`lean/QLF_PionMassRatio.lean`](lean/QLF_PionMassRatio.lean).
