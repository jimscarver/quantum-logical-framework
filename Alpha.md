# α — The Fine-Structure Constant from First Principles

**The canonical QLF document for the fine-structure constant `α ≈ 1/137`.** It consolidates the
substrate derivation (previously spread across [`Magnetism_Spatial_Dynamics.md`](Magnetism_Spatial_Dynamics.md) §6.1,
[`Electricity.md`](Electricity.md), [`Hydrogen.md`](Hydrogen.md)), states **which scale** the derived
value lives at, and resolves a question that looks like a contradiction but is not:

> *"My intuition is that α should be scale-free, but the Standard Model says α was higher in the early
> universe. Have we really derived α from first principles?"*

**Short answer:** Yes — QLF derives the **low-energy (`q² → 0`, Thomson-limit) value `1/137`**, which
is the coupling of **fully-rendered 3-D space**, from substrate combinatorics with **zero free
parameters** (machine-verified, [`lean/QLF_FineStructureSubstrate.lean`](lean/QLF_FineStructureSubstrate.lean)).
The Standard Model's "running" — α larger at high energy / in the early universe — does **not** contradict
this: it is the *effective* coupling departing from the fully-rendered limit, which in QLF reads as the
**flow of the effective spatial dimension** away from 3. The fundamental value is scale-free and
time-invariant; the *effective* coupling is what runs. The intuition is right about the fundamental
constant.

---

## 1. The claim

α is the dimensionless strength of the electromagnetic interaction. Its measured low-energy value is

```
α(0) = 1/137.035999…   (CODATA, the q²→0 / Thomson limit)
```

QLF derives `α = 1/137` (exact rational) from the structure of the 8-twist substrate alphabet and the
3-dimensionality of synthesized space, with **no observable input** — a 0.026% match to CODATA. This is
the first Lean-verified theorem for a fundamental constant in the QLF tree
(`alpha_QLF_eq`, `only_3d_substrate_gives_137`).

---

## 2. The first-principles derivation

The derivation is a two-stage combinatorial reduction. (Full prose: [`Magnetism_Spatial_Dynamics.md`](Magnetism_Spatial_Dynamics.md)
§6.1; companion demo `magnetism_spatial_dynamics_demo.py`.)

### Stage 1 — bare combinatorial coupling

Per Planck tick the substrate offers a fixed menu of closures; four independent substrate selectivities
multiply:

| Factor | Value | Substrate source |
|---|---|---|
| Naive closure rate | `1/16` | 4 base half-spin closures `{^v, <>, /\, +-}`, prob `1/8` per twist-pair, from the 8-twist alphabet |
| Gauge selectivity | `1/4` | only `+-` (1 of the 4 base closures) is the gauge fold that mediates Coulomb binding |
| Phase coherence | `1/2` | binary in-phase / out-of-phase selectivity to advance the orbital phase |
| Spatial co-location | `1` | binding-photon `λ/2 ≈ 45 nm ≫` Bohr radius `a₀ ≈ 0.053 nm` |

```
α_bare = 1/16 × 1/4 × 1/2 × 1 = 1/128 = 2⁻⁷     (alpha_bare_eq)
```

A clean substrate-arithmetic number: `1/α_bare = 128 = 2⁷`.

### Stage 2 — the screening correction (bare → dressed)

Energy conservation is **emergent** from substrate dynamics, not an axiom. Its leading effect is the
standard self-energy / vacuum-polarization-style resummation

```
α = α_bare / (1 + N · α_bare)
```

with **`N = 9`** the number of independent components of the **3 × 3 directional-coupling tensor**
`T_{ij}` (`i, j ∈ {X, Y, Z}`): the binding interaction has a directional input × directional output per
substrate event, and an isotropic 3-D substrate gives `3² = 9` independent channels through which the
bound state can off-resonate (`N_directional_modes_eq_nine`). Hence

```
α = (1/128) / (1 + 9/128) = (1/128) / (137/128) = 1/137.000     (alpha_QLF_eq)
  vs  α_CODATA = 1/137.036                                       (0.026%)
```

**Note the structure:** Stage 2 *is* a screening step. The bare `2⁻⁷ = 1/128` is the unscreened
coupling; the dressed `1/137` is the screened (smaller) coupling. This is the same physics as QED vacuum
polarization, and it is why the derived number lands on the **screened, low-energy** value (see §3–§4).

### Why `N = 9` — the 3-D directional tensor

The 8-twist alphabet splits `6 + 2` (6 spatial twists in 3 axis-pairs `Y=^v`, `X=<>`, `Z=/\`; 2 gauge
twists) — see [`Magic_numbers.md`](Magic_numbers.md). Three spatial dimensions is a derived substrate
fact ([`SpaceTime.md`](SpaceTime.md) §3a: 3 is the minimal dimension in which any relational closure
graph renders faithfully). The binding interaction's directional channels form the `3² = 9` tensor.
**α's value is locked to the substrate being 3-dimensional**:

| Substrate dimension | `N = d²` | `α = 1/(128 + d²)` | Theorem |
|---|---|---|---|
| 2-D | `4` | `1/132` (off ~4%) | `alpha_QLF_2d_counterfactual` |
| **3-D** | **`9`** | **`1/137` (0.026%)** | **`alpha_QLF_eq`** |
| 4-D | `16` | `1/144` (off ~5%) | `alpha_QLF_4d_counterfactual` |
| 5-D | `25` | `1/153` (off ~12%) | `alpha_at_dim_five` |

`only_3d_substrate_gives_137` packages the conjunction. **α = N = 3² is therefore a *consequence* of
3-D rendering, not an independent posit** ([`SpaceTime.md`](SpaceTime.md) §3a) — the same `6+2` split
also fixes Newton's `1/r²`, the nuclear magic numbers, and `Ω_Λ = log 2`.

### The closed form

The whole chain collapses to a single rational function of the rendering dimension `d`:

```
α(d) = α_bare / (1 + d²·α_bare) = 1 / (128 + d²)     (alpha_at_dim_closed_form)
```

so `α(3) = 1/137`, `α(2) = 1/132`, `α(4) = 1/144`. **α is a function of `d` alone** — this is the key to
§5: it carries no other variable (in particular, no time).

---

## 3. Which scale is `1/137`? — the 3-D-rendered IR anchor

The number is **not** the value at "some unspecified scale." It is the coupling of **fully-rendered
3-D space** — i.e. the **infrared, zero-momentum-transfer (`q² → 0`), Thomson limit**, the
macroscopic/low-energy value. Two facts pin this:

1. **`N = 9 = 3²` is a fully-rendered-3-D object.** The directional tensor exists only once space has
   rendered to its minimal faithful dimension, 3 — which is the macroscopic (IR) limit.
2. **Stage 2 is the screening resummation** `α_bare/(1+9α)`, taking the unscreened `1/128` to the
   *screened* `1/137`. The fully-screened charge is precisely the `q²→0` value measured at large
   distances.

So `1/137` is a **privileged, physically-defined** reference point (the IR anchor), not an arbitrary
one — which is exactly what makes it a meaningful target to derive. This is the value CODATA quotes as
"the fine-structure constant."

---

## 4. Why α "ran" in the early universe — the dimension-flow reading

In the Standard Model the *effective* coupling `α(μ)` grows with energy `μ`: `α(0) = 1/137` but
`α(M_Z) ≈ 1/128` at the Z mass, and higher still beyond. In the hot early universe the typical
interaction energy was high, so the effective α was larger. This is **vacuum-polarization screening**
(virtual charged pairs screen the bare charge; you penetrate the screening cloud at higher energy) —
**not** a change in a fundamental constant.

QLF's substrate gives this a geometric reading. Dimension in QLF is **emergent** and read off the
volume-scaling exponent (Myrheim–Meyer; [`lean/QLF_CausalDimension.lean`](lean/QLF_CausalDimension.lean)),
so the *effective* dimension can differ at different scales. Toward the UV it **reduces** — the
universal `d → 2` UV dimensional reduction found across discrete-spacetime quantum gravity (causal sets,
CDT, asymptotic safety). Feeding that flow through QLF's own `α = 1/(α_bare⁻¹ + d²)`:

```
effective dimension 3 → 2  (IR → UV)   ⟹   α : 1/137 → 1/132   (larger coupling toward the UV)
```

— the **correct Standard-Model direction** (α grows in the UV), realized with QLF's own 2-D
counterfactual `1/132` (`alpha_QLF_2d_counterfactual`). And the cosmological gloss is clean:

> **α was higher in the early universe because space had not yet fully rendered to 3-D.** High
> temperature ⇒ high effective energy ⇒ lower effective dimension ⇒ larger α. As the universe cooled
> and the closure graph rendered fully to 3-D, α settled to its 3-D value `1/137`.

There is no Landau-pole catastrophe in this picture: the substrate is discrete with a Planck UV floor,
so the running carries a hard cutoff and every coupling stays finite ([`TheContinuum.md`](TheContinuum.md)
§3.1, [`lean/QLF_RunningCouplings.lean`](lean/QLF_RunningCouplings.lean) — the `Continuum = UV catastrophe`
thesis).

**Honest scope on the running.** The dimension-flow gives the right *direction* and a geometric
*contribution*, but **not the full magnitude**: the measured `α(M_Z) ≈ 1/128` is already a larger
coupling than the pure-`d=2` value `1/132`, so most of the running is the actual charged-matter vacuum
polarization — the open β-coefficient sector (`running_couplings_structural`). A suggestive resonance,
flagged as such: QLF's *bare* value is `2⁻⁷ = 1/128`, numerically close to the *less-screened*
`α(M_Z) ≈ 1/128` — consistent with the bare/dressed split mirroring UV/IR, but the `M_Z` scale is not
derived, so this is a structural coincidence, not a claim.

---

## 4a. Do the 4-D / 5-D values support atoms and force unification? — no, 3-D is over-determined

The counterfactual values are `α(4) = 1/144` and `α(5) = 1/153` (`alpha_at_dim_four`,
`alpha_at_dim_five`). The natural question — *do those support an atomic model or force unification?* —
has a sharp answer: **no, and not merely because the number is a few percent off.** At `d ≥ 4` the
*physics itself* collapses, from QLF's own derived structures, in three independent ways. That mutual
failure is what makes `α = 1/137` a **selection**, not a fit.

**1. Atoms — no stable atom above 3-D (from QLF's own force law).** QLF derives the Coulomb/Newton
force as a holographic surface count: `F ∝ 1/r^(d−1)`, so the potential is `V ∝ 1/r^(d−2)`
([`Gravity_From_Delay.md`](Gravity_From_Delay.md)). Then:

| `d` | `V(r)` | Bound state |
|---|---|---|
| 3 | `∝ 1/r` | **stable** — Bohr orbits, the hydrogen spectrum, chemistry |
| 4 | `∝ 1/r²` | **critically unstable** — same radial power as the centrifugal barrier; no normalizable ground state |
| 5 | `∝ 1/r³` | **collapse** — steeper than the barrier; the electron falls into the nucleus |

This is the **Ehrenfest (1917) / Tangherlini** dimensional-stability theorem — here a *consequence of
QLF's own `1/r^(d−1)` law*, not an imported assumption. So `α(4) = 1/144` and `α(5) = 1/153` describe
substrates with **no stable atoms at all**: they do not support the atomic model, they exclude it.
`α = 1/137` (3-D) is the only value compatible with chemistry.

**2. Nuclei — the wrong magic numbers above 3-D.** The nuclear shell `ℓ = 3` threshold comes from the
3-D harmonic-oscillator degeneracy `(k+1)(k+2)` with `k > 2` ([`Magic_numbers.md`](Magic_numbers.md)).
Counterfactual: `d = 4 → ℓ ≥ 2`, `d = 5 → ℓ ≥ 1`, `d = 2 → no threshold`. A 4-D/5-D substrate gives a
*different, wrong* magic-number sequence; the observed `2, 8, 20, 28, 50, 82, 126` requires `d = 3`.

**3. Forces — unification is 3-D-locked, and QLF unifies *without* extra dimensions.** The gauge group
`U(1) × SU(2) × SU(3)` is the symmetry algebra of the **3 spatial axes**
([`Forces_From_Three_Axes.md`](Forces_From_Three_Axes.md)); the unification constants are
dimension-specific — `sin²θ_W = 3/8 = (3 spatial)/(8 alphabet)`, `α = N = 3²`. A 4-D substrate (more
spatial twists) changes the split, giving a different Weinberg angle and a non-matching unification.
Crucially, **QLF does not *add* dimensions to unify** — contrast Kaluza–Klein / string theory, where
`5-D`+ *is* the unification mechanism; QLF unifies the three forces as different **projections of the
same 3-axis closure**. So the 4-D/5-D α values are not a unification mechanism — they *break* the
3-axis unification.

**Over-determination — the real answer.** `α = 1/137` (`d = 3`) is the unique value simultaneously
consistent with: the measured α, **stable atoms** (Ehrenfest, via QLF's force law), the nuclear
**magic numbers** (`ℓ = 3`), **Newton's `1/r²`**, the **three generations**, `sin²θ_W = 3/8`, and the
**minimal-faithful-rendering necessity** ([`SpaceTime.md`](SpaceTime.md) §3a). The 4-D (`1/144`) and 5-D
(`1/153`) values fail *several of these at once*. They do not support the atomic model or force
unification — and that simultaneous failure is precisely why 3-D is a derivation rather than a
coincidence.

**Honest caveat — where higher-`d` does appear.** QLF's *effective* dimension is not always 3: it flows
`3 → 2` toward the UV (§4), and composing closures can produce effective higher-`d` configuration-space
behavior ([`eight-twists-sufficiency.md`](eight-twists-sufficiency.md)). But the *macroscopic,
atom-supporting, force-unifying* rendering is uniquely 3-D. The 4-D/5-D α values are counterfactuals,
not the physical low-energy coupling.

## 5. Can we *prove* no cosmological-time drift of α(0)?

The question conflates two different things the substrate cleanly separates:

| | What it is | Status in QLF |
|---|---|---|
| **RG running in *energy*** | the *effective* `α(μ)` rises with probe energy (screening / dimension-flow) | **real** — the "early universe / high-energy" effect; direction structural, magnitude open |
| **Drift in cosmological *time*** | the *fundamental* `α(0)` itself changing over cosmic history (the Webb et al. quasar-spectra claim) | **forbidden by construction** |

**Yes — in a strong conditional sense, and it is sharper than the Standard Model.** The closed form
`α(d) = 1/(128 + d²)` (§2, `alpha_at_dim_closed_form`) makes the argument precise: **α is a function of
the rendering dimension `d` alone — there is no time variable for it to drift along.** Both inputs to
`α(0) = α(d=3) = 1/137` are atemporal:

1. **The 8-twist alphabet** (which fixes the bare `2⁻⁷` and the screening structure) is the substrate's
   *definition* — not a dynamical field.
2. **`d = 3`** is a *logical necessity* — the minimal dimension in which any closure graph renders
   faithfully ([`SpaceTime.md`](SpaceTime.md) §3a, [`QLF_ReachableEvent`](lean/QLF_ReachableEvent.lean)) —
   not an epoch-dependent accident.

So `α(0) = 1/137` is an **atemporal structural fact** (`alpha_at_dim_three`, `alpha_at_dim_eq_alpha_QLF`,
and the marker `no_cosmological_drift_of_alpha`): QLF **cannot accommodate a drifting `α(0)`** without
changing its axioms (the alphabet or the rendering dimension). This is **stronger than the SM**: the SM
treats `α(0)` as a *free input* that varying-α models can promote to a slowly-drifting scalar field
(dilaton-style); QLF *structurally forbids* that. A confirmed cosmological drift of `α(0)` would
therefore **falsify the QLF substrate** — it could not be absorbed by it.

**The honest boundary (why "conditional theorem," not absolute proof).** Within QLF, "no drift" follows
deductively from the two premises above. What is *not* ZFC-absolute is that those premises hold of the
*physical* universe — i.e. that the macroscopic rendering dimension is itself epoch-independent. QLF
makes that a structural necessity (3 is forced, not chosen), so the only loophole — a macroscopic
rendering dimension that drifts in cosmic time — is one QLF's own ontology closes. The result is a
genuine, falsifiable prediction with a verified deductive core, not a hand-wave.

So the intuition that **α "should be scale-free" is exactly right for the fundamental value** — that is
the `1/137` QLF derives and proves time-independent; the SM "running" is the *effective* coupling
departing from it as the *effective geometry* departs from full 3-D rendering (§4), which is energy, not
time.

---

## 6. Where α is used (downstream derivations)

The derived `α` feeds the rest of the atomic/EM tree. Each of these derivations *justifies its α* by
pointing here:

| Quantity | Relation | Doc |
|---|---|---|
| Rydberg / Bohr | `Ry = ½ α² m_e c²`, `a₀ = ℏ/(α m_e c)` | [`Hydrogen.md`](Hydrogen.md) |
| Dirac fine structure | spin-orbit / Darwin `∝ α²` | [`Dirac_Correction.md`](Dirac_Correction.md) |
| Lamb shift | prefactor `4/(3π n³)` with the loop `α` | [`Lamb_Shift.md`](Lamb_Shift.md) |
| Electron `g−2` | `a_e = α/2π` (Schwinger) | [`g_minus_2.md`](g_minus_2.md) |
| von Klitzing | `R_K = h/e² = Z₀/(2α) ≈ 25813 Ω` | [`Electricity.md`](Electricity.md) §7 |
| Charged pion | `m_π±/m_e = 2/α = 274` | [`Pion_QLF.md`](Pion_QLF.md) |
| Weinberg / forces | `sin²θ_W = 3/8`, forces rooted in `α = N = 3²` | [`Forces_From_Alpha.md`](Forces_From_Alpha.md), [`Weak_Force.md`](Weak_Force.md) |
| Hyperfine (21 cm) | `ΔE_HFS ∝ α⁴` | [`Magnetism_Spatial_Dynamics.md`](Magnetism_Spatial_Dynamics.md) §5 |

The **constants mapper** ([`constants_mapper.py`](constants_mapper.py)) reports `α = 1/137` explicitly
labeled `[DERIVED]` — first-principles, no measured input — distinct from the `gauge_spatial_count_ratio`
(a `[NATIVE]` ensemble observable, *not* α) and from bridge quantities like `G_prediction_SI`
(`[BRIDGE]`, needs one dimensional input).

---

## 7. Lean anchors

In [`lean/QLF_FineStructureSubstrate.lean`](lean/QLF_FineStructureSubstrate.lean), finite rational
arithmetic discharged by `norm_num` (no integrals, no non-constructive steps, no axioms beyond
Lean/Mathlib):

- `alpha_bare_eq` — `α_bare = 1/128`
- `N_directional_modes_eq_nine` — `N = 9` from `substrate_spatial_dimension = 3`, the `3²` count
- **`alpha_QLF_eq`** — `α_QLF = 1/137` (exact rational), the main theorem
- `alpha_QLF_2d_counterfactual` — `= 1/132` (the `d=2` value used in the §4 dimension-flow reading)
- `alpha_QLF_4d_counterfactual` / `alpha_at_dim_five` — `= 1/144` (4-D) / `= 1/153` (5-D); §4a
- `only_3d_substrate_gives_137` — the conjunction (uniqueness of the 3-D substrate)
- **`alpha_at_dim_closed_form`** — `α(d) = 1/(128 + d²)` (α a function of the rendering dimension alone)
- `alpha_at_dim_three` / `alpha_at_dim_eq_alpha_QLF` — `α(3) = 1/137 = alpha_QLF`
- **`no_cosmological_drift_of_alpha`** — the §5 no-time-drift statement (marker; `alpha_at_dim` has no time argument)

Related: [`QLF_CausalDimension`](lean/QLF_CausalDimension.lean) (emergent Myrheim–Meyer dimension),
[`QLF_RunningCouplings`](lean/QLF_RunningCouplings.lean) (the RG structure + UV-finiteness).

---

## 8. Honest scope

- **Derived (first-principles, zero free parameters, Lean-verified):** the IR / fully-rendered-3-D value
  `α(0) = 1/137` (0.026% vs CODATA). This *is* a derivation of a specific, privileged physical quantity.
- **Structural (new connection, *direction* only):** the QED running ≈ effective-dimension flow `3 → 2`
  toward the UV — grounded in [`QLF_CausalDimension`](lean/QLF_CausalDimension.lean) and the `1/132`
  2-D counterfactual. It gives the right direction and a geometric contribution; it does **not** derive
  the running *magnitude*.
- **Open (named):** the β-coefficients / full charged-matter vacuum polarization that set the running's
  magnitude (`running_couplings_structural`); the residual 0.026% at the Schwinger scale `α/2π`; the
  cross-pathway consistency with the chirality-hiding route ([`Proton_Resonance_R_e.md`](Proton_Resonance_R_e.md)).
- **Prediction (falsifiable, not a theorem):** no cosmological-*time* drift of `α(0)`.

The result stands as a constructive derivation of the fundamental (IR, 3-D-rendered) fine-structure
constant; the *running* is the departure from that limit, whose magnitude is the open renormalization
sector QLF already flags.

---

## See also

- [`Magnetism_Spatial_Dynamics.md`](Magnetism_Spatial_Dynamics.md) §6.1 — the full prose derivation and demo.
- [`SpaceTime.md`](SpaceTime.md) §3a — why space renders 3-D, with `α = N = 3²` as a consequence.
- [`TheContinuum.md`](TheContinuum.md) §3.1 — running couplings without a UV catastrophe.
- [`Open_Problems.md`](Open_Problems.md) — the renormalization / running sector status.
- [`README.md`](README.md) · [`lean/README.md`](lean/README.md) — the project overview and module table.
