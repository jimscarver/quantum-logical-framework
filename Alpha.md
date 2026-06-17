# α — The Fine-Structure Constant in QLF (comprehensive reference)

> **This is a result of the [Quantum Logical Framework (QLF)](README.md)** — read it in that context.
> QLF derives physics from one substrate (the 8-twist phase-string alphabet, ZFA closure, synthesized
> spacetime), machine-verified in Lean 4 across the [89-module tree](lean/README.md). α is not a
> standalone numerology here; it is a **consequence of QLF's derived 3-D rendering** of the closure
> graph. And that 3-D is **the human/cosmic perspective**: the only dimension in which a relational
> world renders faithfully and comprehensibly, supports stable atoms and chemistry (hence observers),
> and supports stable cosmic structure (Newton's `1/r²`, bound orbits). So `α = 1/137` is *our* α — the
> coupling of the world **as we, and the cosmos we observe, are rendered** — and the framework derives 3
> rather than assuming it ([`SpaceTime.md`](SpaceTime.md) §3a; the over-determination is §6 below).

**The canonical QLF document for the fine-structure constant `α ≈ 1/137`.** It collects, in one place,
everything QLF says about α and links every related proof:

1. [What α is](#1-what-α-is) · 2. [The first-principles derivation](#2-the-first-principles-derivation)
· 3. [Which scale — the 3-D-rendered IR anchor](#3-which-scale--the-3-d-rendered-ir-anchor) ·
4. [The running](#4-the-running--why-α-was-higher-in-the-early-universe) ·
5. [No cosmological-time drift](#5-no-cosmological-time-drift-of-α0) ·
6. [4-D / 5-D and the over-determination of 3-D](#6-4-d--5-d-and-the-over-determination-of-3-d) ·
7. [Parallel derivation pathways](#7-parallel-derivation-pathways) ·
8. [α and the other substrate constants](#8-α-and-the-other-substrate-constants--the-shared-62-split) ·
9. [Forces from α](#9-forces-from-α) · 10. [Where α is used](#10-where-α-is-used--downstream-derivations) ·
11. [The constants mapper](#11-the-constants-mapper) · 12. [Lean-theorem index](#12-lean-theorem-index) ·
13. [Honest scope](#13-honest-scope).

---

## 1. What α is

α is the dimensionless strength of the electromagnetic interaction. Its measured low-energy value is

```
α(0) = 1/137.035999…   (CODATA, the q²→0 / Thomson limit)
```

In the **Standard Model α is a free input** — measured and plugged in; the SM cannot even *formulate*
"why is α ≈ 1/137" ([`Beyond_Standard_Model.md`](Beyond_Standard_Model.md)). **QLF derives it**:
`α = 1/137` (exact rational) from the structure of the 8-twist substrate alphabet and the
3-dimensionality of synthesized space, with **no observable input** — 0.026% vs CODATA. This is the
first Lean-verified theorem for a fundamental constant in the QLF tree (`alpha_QLF_eq`,
`only_3d_substrate_gives_137`, [`lean/QLF_FineStructureSubstrate.lean`](lean/QLF_FineStructureSubstrate.lean)).

---

## 2. The first-principles derivation

A two-stage combinatorial reduction. Full prose: [`Magnetism_Spatial_Dynamics.md`](Magnetism_Spatial_Dynamics.md)
§6.1; runnable demo `magnetism_spatial_dynamics_demo.py`.

### Stage 1 — bare combinatorial coupling

Per Planck tick, four independent substrate selectivities multiply:

| Factor | Value | Substrate source |
|---|---|---|
| Naive closure rate | `1/16` | 4 base half-spin closures `{^v, <>, /\, +-}`, prob `1/8` per twist-pair, from the 8-twist alphabet |
| Gauge selectivity | `1/4` | only `+-` (1 of the 4) is the gauge fold that mediates Coulomb binding |
| Phase coherence | `1/2` | binary in-phase / out-of-phase selectivity |
| Spatial co-location | `1` | binding-photon `λ/2 ≈ 45 nm ≫` Bohr radius `a₀ ≈ 0.053 nm` |

```
α_bare = 1/16 × 1/4 × 1/2 × 1 = 1/128 = 2⁻⁷     (alpha_bare_eq)
```

### Stage 2 — the screening correction (bare → dressed)

Energy conservation is **emergent**, not an axiom; its leading effect is the standard self-energy /
vacuum-polarization resummation `α = α_bare / (1 + N·α_bare)`, with **`N = 9`** the components of the
`3 × 3` directional-coupling tensor (`N_directional_modes_eq_nine`):

```
α = (1/128) / (1 + 9/128) = 1/137.000     (alpha_QLF_eq)   vs  1/137.036  (0.026%)
```

The `(1+9α)` factor *is* a screening step — the bare `2⁻⁷=1/128` is the unscreened coupling, `1/137` the
screened (low-energy) one — which is why the derived number lands on the IR value (§3).

### The closed form and the dimension counterfactuals

The whole chain collapses to a single rational function of the rendering dimension `d`:

```
α(d) = α_bare / (1 + d²·α_bare) = 1 / (128 + d²)     (alpha_at_dim_closed_form)
```

| Substrate dimension | `N = d²` | `α = 1/(128 + d²)` | Theorem |
|---|---|---|---|
| 2-D | `4` | `1/132` (off ~4%) | `alpha_QLF_2d_counterfactual` |
| **3-D** | **`9`** | **`1/137` (0.026%)** | **`alpha_QLF_eq`** |
| 4-D | `16` | `1/144` (off ~5%) | `alpha_QLF_4d_counterfactual` |
| 5-D | `25` | `1/153` (off ~12%) | `alpha_at_dim_five` |

`N = 9 = 3²` is a 3-D object; **α = N = 3² is a *consequence* of the 3-D rendering**
([`SpaceTime.md`](SpaceTime.md) §3a; the `6+2` split, [`Magic_numbers.md`](Magic_numbers.md)). α is a
function of `d` **alone** — the key fact for §5.

---

## 3. Which scale — the 3-D-rendered IR anchor

`1/137` is the coupling of **fully-rendered 3-D space** — the **IR, zero-momentum-transfer (`q²→0`),
Thomson limit**, the macroscopic/low-energy value. Two facts pin this: (1) `N = 9 = 3²` exists only once
space renders to dimension 3 (the macroscopic limit); (2) the `(1+9α)` resummation takes the unscreened
`1/128` to the *screened* `1/137` (the fully-screened charge measured at large distances). So `1/137` is
a **privileged, physically-defined** reference point, not an arbitrary one — the value CODATA quotes.

### Why 3-D — the human/cosmic perspective

In QLF spacetime is **synthesized**, and an observer's world is the *rendering* of the closure graph at
the observer's scale ([`SpaceTime.md`](SpaceTime.md) §3a: 3 is the *minimal* dimension in which any
relational structure renders faithfully *and comprehensibly*). The fully-rendered 3-D limit is exactly
the **human and cosmic perspective** — the scale at which atoms hold, chemistry and observers exist
(§6), and structure is stable under Newton's `1/r²`. So `α = 1/137` is **our** α: the coupling of the
world *as rendered for observers like us, and for the cosmos we look out on*. The value is not
anthropically *selected* from a landscape — QLF *derives* `3` — but it is anthropically *located*.

---

## 4. The running — why α was higher in the early universe

In the SM the *effective* coupling grows with energy: `α(0)=1/137`, `α(M_Z)≈1/128`, higher beyond; the
hot early universe sampled higher energies, so effective α was larger. This is **vacuum-polarization
screening**, not a change of a fundamental constant. QLF reads it geometrically: the *effective*
dimension is emergent (Myrheim–Meyer, [`lean/QLF_CausalDimension.lean`](lean/QLF_CausalDimension.lean))
and **reduces toward `2` in the UV** (the universal `d→2` of causal sets / CDT / asymptotic safety).
Through `α(d)=1/(128+d²)`, a flow `3→2` takes `α: 1/137→1/132` (`alpha_QLF_2d_counterfactual`) — the
**correct SM direction** (α grows in the UV). Cosmologically: *α was higher because space had not yet
fully rendered to 3-D.*

The RG structure itself is Lean-anchored in [`lean/QLF_RunningCouplings.lean`](lean/QLF_RunningCouplings.lean):
one-loop `1/α(t)=1/α₀+(b/2π)·t` (`inv_coupling`, the `2π` loop phase), asymptotic freedom
(`asymptotic_freedom`) vs screening (`infrared_growth`), the Landau pole *located*
(`landau_pole_location`) but **cut off by the substrate's discrete UV floor** — no continuum UV
catastrophe ([`TheContinuum.md`](TheContinuum.md) §3.1). The strong β-coefficient is substrate-fixed
`b₀=7` (`beta_coefficient_eq_seven`, [`lean/QLF_BetaFunction.lean`](lean/QLF_BetaFunction.lean)), feeding
the `14π` hierarchy ([`lean/QLF_AlphaS.lean`](lean/QLF_AlphaS.lean)).

**Honest scope:** the dimension-flow gives the right *direction* + a geometric *contribution*; the full
running *magnitude* (`α(M_Z)≈1/128`) is matter vacuum-polarization — the open β-coefficient sector
(`running_couplings_structural`).

---

## 5. No cosmological-time drift of α(0)

**This is obvious within QLF — not a hard-won prediction.** The substrate is pure combinatorics with
**no external scale** (the only scale, the Planck floor, is itself by-construction), so the *fundamental*
dimensionless invariant `α(0)` has nothing to vary against — neither energy nor cosmic time. (The
*effective* coupling `α(μ)` *does* run with energy — §4 — but that is screening of the same fixed
`α(0)`, not a change in it.) Concretely,
`α(d)=1/(128+d²)` has **no scale and no time argument**: `α(0)=α(3)=1/137` is an atemporal, scale-free
structural fact — manifest from the closed form, recorded as `no_cosmological_drift_of_alpha` (with
`alpha_at_dim_closed_form`, `alpha_at_dim_three`, `alpha_at_dim_eq_alpha_QLF`). There is no dynamical
variable for it to drift along; the 8-twist alphabet is the substrate's *definition* (not a field) and
`d=3` is fixed by necessity ([`SpaceTime.md`](SpaceTime.md) §3a). So within QLF this is a **theorem — a
trivial one**, on the **same footing as `α=1/137` itself**; we don't need to belabor proving the obvious,
and the Lean marker simply records it.

It is **sharper than the SM**, which treats `α(0)` as a free input that varying-α models can promote to a
drifting scalar field; QLF *structurally forbids* it. As an empirical claim about the *universe* it is a
falsifiable **prediction** — a confirmed cosmological drift of `α(0)` would falsify the QLF substrate —
but that "does QLF describe our universe?" caveat is the **universal** one attached to *every* QLF result
(`α=1/137` included), not a special weakness here. Distinct from the §4 energy-running of the *effective*
coupling (real, screening); this concerns the *fundamental* value over cosmic *time* (the Webb axis —
mainstream measurements consistent with null).

---

## 6. 4-D / 5-D and the over-determination of 3-D

The counterfactual values `α(4)=1/144`, `α(5)=1/153` (`alpha_QLF_4d_counterfactual`, `alpha_at_dim_five`)
do **not** support a viable physics — and not merely because the number is off. At `d ≥ 4` the physics
collapses, from QLF's own structures, three ways at once:

1. **Atoms — none above 3-D.** QLF derives `F ∝ 1/r^(d−1)` (holographic surface count,
   [`Gravity_From_Delay.md`](Gravity_From_Delay.md)), so `V ∝ 1/r^(d−2)`: stable Bohr orbits at `d=3`
   (`1/r`), critically unstable at `d=4` (`1/r²`), collapse at `d=5` (`1/r³`) — the **Ehrenfest (1917) /
   Tangherlini** theorem, here a *consequence of QLF's own force law*. So `α(4)`, `α(5)` describe
   substrates with **no stable atoms** — they exclude chemistry, they don't support it.
2. **Nuclei — wrong magic numbers.** The `ℓ=3` shell threshold is 3-D-specific
   ([`Magic_numbers.md`](Magic_numbers.md): `d=4→ℓ≥2`, `d=5→ℓ≥1`); the observed `2,8,20,28,50,82,126`
   requires `d=3`.
3. **Forces — unification breaks.** `U(1)×SU(2)×SU(3)` is the algebra of the **3 spatial axes**
   ([`Forces_From_Three_Axes.md`](Forces_From_Three_Axes.md)); `sin²θ_W=3/8`, `α=N=3²` are 3-D-locked.
   QLF unifies the three forces as **projections of one 3-axis closure** — it does *not* add dimensions
   to unify (contrast Kaluza–Klein / string, where `5-D`+ *is* the mechanism). So 4-D/5-D *break*
   unification rather than enabling it.

**Over-determination is the real answer.** `α=1/137` (`d=3`) is the unique value simultaneously
consistent with the measured α, stable atoms (Ehrenfest), the magic numbers, Newton's `1/r²`, three
generations, `sin²θ_W=3/8`, and the minimal-faithful-rendering necessity. The 4-D/5-D values fail
several at once — which is why 3-D is a *derivation*, not a coincidence. (Higher `d` appears only as the
*effective* dimension — the §4 UV flow, or effective configuration-space behavior of composed closures,
[`eight-twists-sufficiency.md`](eight-twists-sufficiency.md) — never as the macroscopic rendering.)

---

## 7. Parallel derivation pathways

QLF reaches α by more than one route; their agreement is a non-trivial internal consistency claim:

| Pathway | What it derives | Status | Reference |
|---|---|---|---|
| **Substrate combinatorial** | `α = 1/137` from the 8-twist alphabet + `N=9=3²`, zero input (§2) | ✅ Lean (`alpha_QLF_eq`) | this doc; [`Magnetism_Spatial_Dynamics.md`](Magnetism_Spatial_Dynamics.md) §6.1 |
| **Bohr / Rydberg inversion** | the *identity* `Ry = ½α²m_e c²` (Tier-1, structural) ⇒ `α = √(2Ry/m_e c²)` to 10⁻¹⁰ (Tier-2, with measured `Ry`, `m_e`) | ✅ identity derived; value uses measured inputs | [`Hydrogen.md`](Hydrogen.md) §§2–4; `fine_structure_demo.py` |
| **Chirality-hiding `R_e = R_p·6π⁵`** | α via the electron/proton Markov-blanket depth ratio (the Lenz coincidence) | 🔵 Tier-3 open (needs `R_e` from closure multiplicity) | [`Proton_Resonance_R_e.md`](Proton_Resonance_R_e.md) |

The combinatorial route is the one that lands the value with **no observable input**; the three should
converge in a complete theory (open cross-check).

---

## 8. α and the other substrate constants — the shared 6+2 split

The `6 spatial + 2 gauge` split of the 8-twist alphabet (the `3` spatial axes) is the *same* structure
behind several constants — α is one face of it:

| Constant | Value | Tie to the `6+2` / `3` | Lean |
|---|---|---|---|
| **α** | `1/137` | `N = 3² = 9` directional tensor | `alpha_QLF_eq` |
| **Weinberg angle** | `sin²θ_W = 3/8` (unification) | spatial fraction `3/8` = SU(5) normalization | `sin2_weinberg_substrate_eq` ([`lean/QLF_WeinbergAngle.lean`](lean/QLF_WeinbergAngle.lean)) |
| **Cosmological constant** | `Ω_Λ = log 2` (1.2%) | gauge fraction `2/8 = 1/4` | `only_2_gauge_matches_observed_Omega_Lambda` ([`lean/QLF_CosmologicalConstant.lean`](lean/QLF_CosmologicalConstant.lean)) |
| **Three generations** | `3` | `num_generations = substrate_spatial_dimension = 3` | `num_generations_eq_three`, `three_axis_signature` ([`lean/QLF_Generations.lean`](lean/QLF_Generations.lean)) |
| **SU(5) generation content** | `5̄⊕10 = 15` | the `5 = colour(3)⊕weak(2)` split | `generation_eq_fifteen` ([`lean/QLF_SU5.lean`](lean/QLF_SU5.lean)) |
| **Newton's law** | `F ∝ 1/r²` | holographic surface `∝ r^(d−1)`, `d=3` | `newton_exponent_only_3d_matches` ([`lean/QLF_GravityFromDelay.lean`](lean/QLF_GravityFromDelay.lean)) |
| **Nuclear magic numbers** | `2,8,20,28,…` (`ℓ=3` threshold) | 3-D-SHO degeneracy `(k+1)(k+2)`, `k>2` | [`Magic_numbers.md`](Magic_numbers.md) |

So α's `3²` and the Weinberg `3/8` and the cosmological `2/8` are **one substrate fact read three ways**
— the strongest cross-check on the 3-dimensionality.

---

## 9. Forces from α

The **dimensionless** Standard-Model force strengths root in α (itself `N=3²`) plus the integers `2,7`;
only the **absolute scale** needs one empirical mass (`m_e` or `m_p`). So the four forces reduce to *one
derived structure (α) + one empirical mass* — [`Forces_From_Alpha.md`](Forces_From_Alpha.md). The forces
are different **projections of the one 3-axis gauge-twist closure** that already produces α
([`Forces_From_Three_Axes.md`](Forces_From_Three_Axes.md); EM abelian vs weak/strong non-abelian,
`gauge_unification_signature`, [`lean/QLF_GaugeUnification.lean`](lean/QLF_GaugeUnification.lean)).

---

## 10. Where α is used — downstream derivations

The derived α feeds the atomic/EM tree; each derivation *justifies its α* by pointing here:

| Quantity | Relation | Match | Lean / doc |
|---|---|---|---|
| Rydberg / Bohr | `Ry = ½ α² m_e c²`, `a₀ = ℏ/(α m_e c)` | identity exact | [`Hydrogen.md`](Hydrogen.md) §§2–4 |
| Dirac fine structure | spin-orbit / kinematic / Darwin `∝ α²` | closes 0.05% residual | `three_mechanisms_alpha_squared` ([`lean/QLF_DiracCorrection.lean`](lean/QLF_DiracCorrection.lean)) |
| Lamb shift | prefactor `4/(3πn³)` with the loop `α` | structural | `lamb_prefactor_loop_phase` ([`lean/QLF_LambShift.lean`](lean/QLF_LambShift.lean)) |
| Electron `g−2` | `a_e = α/2π` (Schwinger) | 0.2% | `a_e_QLF_eq_schwinger`, `g_factor_QLF_eq` ([`lean/QLF_GMinusTwo.lean`](lean/QLF_GMinusTwo.lean)) |
| von Klitzing | `R_K = h/e² = Z₀/(2α) ≈ 25813 Ω` | 0.026% (= α error) | `von_klitzing_substrate`, `hall_resistance` ([`lean/QLF_CondensedMatter.lean`](lean/QLF_CondensedMatter.lean)); [`Electricity.md`](Electricity.md) §7 |
| Charged pion | `m_π±/m_e = 2/α = 274` | 0.3% | `pion_electron_ratio_eq`, `proton_pion_ratio_eq` ([`lean/QLF_PionMassRatio.lean`](lean/QLF_PionMassRatio.lean)); [`Pion_QLF.md`](Pion_QLF.md) |
| Hyperfine (21 cm) | `ΔE_HFS ∝ α⁴` | reproduced (Tier-2) | [`Magnetism_Spatial_Dynamics.md`](Magnetism_Spatial_Dynamics.md) §5 |

---

## 11. The constants mapper

[`constants_mapper.py`](constants_mapper.py) reports α explicitly tagged **`[DERIVED]`** — a pure
first-principles value, no measured input (`α = (1/128)/(1+9/128) = 1/137`, 0.026%) — distinct from the
`gauge_spatial_count_ratio` (a `[NATIVE]` ensemble observable, *not* α) and bridge quantities like
`G_prediction_SI` (`[BRIDGE]`). Run `python3 constants_mapper.py` to see the full provenance-tagged
report.

---

## 12. Lean-theorem index

All in [`lean/QLF_FineStructureSubstrate.lean`](lean/QLF_FineStructureSubstrate.lean) unless noted; finite
rational arithmetic (`norm_num`), no axioms beyond Lean/Mathlib.

**Derivation:** `naive_closure_rate`, `gauge_selectivity`, `phase_coherence`, `spatial_colocation`,
`alpha_bare`, `alpha_bare_eq`; `substrate_spatial_dimension`, `N_directional_modes`,
`N_directional_modes_eq_nine`; `alpha_QLF`, **`alpha_QLF_eq`** (`= 1/137`).
**Dimension dependence:** `alpha_QLF_2d_counterfactual` (`1/132`), `alpha_QLF_4d_counterfactual` (`1/144`),
`alpha_at_dim`, **`alpha_at_dim_closed_form`** (`α(d)=1/(128+d²)`), `alpha_at_dim_three`,
`alpha_at_dim_five` (`1/153`), `alpha_at_dim_eq_alpha_QLF`, `only_3d_substrate_gives_137`.
**Scale / time:** **`no_cosmological_drift_of_alpha`**.
**Running (context):** `inv_coupling`, `asymptotic_freedom`, `infrared_growth`, `landau_pole_location`,
`running_couplings_structural` ([`QLF_RunningCouplings`](lean/QLF_RunningCouplings.lean));
`beta_coefficient_eq_seven` ([`QLF_BetaFunction`](lean/QLF_BetaFunction.lean)).
**Downstream:** `three_mechanisms_alpha_squared`, `lamb_prefactor_loop_phase`, `a_e_QLF_eq_schwinger`,
`von_klitzing_substrate`, `pion_electron_ratio_eq` (modules in §10).
**Shared `6+2`:** `sin2_weinberg_substrate_eq`, `only_2_gauge_matches_observed_Omega_Lambda`,
`num_generations_eq_three`, `generation_eq_fifteen`, `newton_exponent_only_3d_matches` (modules in §8).

---

## 13. Honest scope

- **Derived (first-principles, zero free parameters, Lean-verified):** the IR / fully-rendered-3-D value
  `α(0) = 1/137` (0.026% vs CODATA).
- **Structural (*direction* only):** the QED running ≈ effective-dimension flow `3→2`
  toward the UV (`QLF_CausalDimension` + the `1/132` counterfactual); not the running *magnitude*.
- **Open (named):** the β-coefficients / matter vacuum polarization setting the running magnitude
  (`running_couplings_structural`); the residual 0.026% at the Schwinger scale `α/2π`; the cross-pathway
  consistency with the chirality-hiding route ([`Proton_Resonance_R_e.md`](Proton_Resonance_R_e.md)).
- **Scale- and time-invariance of `α(0)` — a (trivial) theorem, on the same footing as `α=1/137`.**
  Obvious within QLF: the substrate has no external scale, so a dimensionless invariant can't drift;
  manifest from `α(d)=1/(128+d²)` (`no_cosmological_drift_of_alpha`). As an empirical claim about the
  universe it is a falsifiable *prediction* (the SM is agnostic / permits varying-α; QLF forbids it) — but
  the "does QLF describe reality?" caveat is universal to *all* QLF results, not special to this one (§5).

The result stands as a constructive derivation of the fundamental (IR, 3-D-rendered) fine-structure
constant; the *running* is the departure from that limit, whose magnitude is the open renormalization
sector QLF already flags.

---

## See also

- [`Magnetism_Spatial_Dynamics.md`](Magnetism_Spatial_Dynamics.md) §6.1 — full prose derivation + demo.
- [`SpaceTime.md`](SpaceTime.md) §3a — why space renders 3-D, `α = N = 3²` as a consequence.
- [`TheContinuum.md`](TheContinuum.md) §3.1 — running couplings without a UV catastrophe.
- [`Forces_From_Alpha.md`](Forces_From_Alpha.md) · [`Forces_From_Three_Axes.md`](Forces_From_Three_Axes.md) — the forces from α.
- [`Hydrogen.md`](Hydrogen.md) · [`Dirac_Correction.md`](Dirac_Correction.md) · [`Lamb_Shift.md`](Lamb_Shift.md) · [`g_minus_2.md`](g_minus_2.md) · [`Electricity.md`](Electricity.md) · [`Pion_QLF.md`](Pion_QLF.md) — downstream uses.
- [`Beyond_Standard_Model.md`](Beyond_Standard_Model.md) — α as derived (vs SM free input) + the no-drift prediction.
- [`Open_Problems.md`](Open_Problems.md) — the renormalization / running sector status.
- [`README.md`](README.md) · [`lean/README.md`](lean/README.md) — the project overview and module table.
