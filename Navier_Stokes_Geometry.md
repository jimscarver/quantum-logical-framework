# The geometry of Navier–Stokes — angular momentum, vorticity, and where QLF avoids the infinity

The dynamics of the substrate geometry ([`Geometry_Of_Space.md`](Geometry_Of_Space.md)) are rotational,
and the [Quantum Logical Framework](README.md) (QLF) already carries the right objects. This doc
formalizes **angular momentum conservation**, then reads the **Navier–Stokes** geometry off it — and
shows precisely **where QLF avoids the blow-up** and **what correction it makes**. The structural
spine is machine-verified in [`lean/QLF_AngularMomentum.lean`](lean/QLF_AngularMomentum.lean).

---

## 1. Angular momentum = circulation

`baryonNumber` ([`QLF_BaryonWinding`](lean/QLF_BaryonWinding.lean)) is a **sliding-window sum of
`signTriple`** — the oriented all-three-axes sign (`+1` cyclic `(x,y,z)`, `−1` anticyclic, `0`
otherwise), the discrete **Levi-Civita curl** of three consecutive twist-axes. Summed over the path it
is the **signed 3-axis winding** — orbital angular momentum, the **Kelvin circulation** of the twist
flow, the Noether charge of the substrate's rotational `su(2)` symmetry (`su2_comm_xy`, `QLF_Spin`).

- **`circulation := baryonNumber`** — angular momentum. Calibrated: the Borromean proton `>^/` carries
  `+1`, its antiparticle `−1` (`baryon_antiproton`), a meson `q q̄` cancels to `0` (`baryon_meson`).
- **`circulation_reverses_under_time_reversal`** — angular momentum is a **pseudovector**: time-reversal
  / parity (`antiparticle` = conjugate-and-reverse) flips it, `L → −L`. This is the defining
  transformation of angular momentum, and it is exactly `baryon_dagger_odd` re-read.

So the conserved rotational charge of the geometry is the circulation, T-odd as angular momentum must be.

## 2. Vorticity is the discrete curl — and it is quantized

In fluid dynamics the **vorticity** `ω = ∇×v` is the local rotation rate — the angular momentum density.
On the substrate it is exactly the local curl cell:

- **`vorticity a b c := signTriple (axOf a) (axOf b) (axOf c)`** — the oriented all-three-axes sign of
  three consecutive twist-axes, the per-cell circulation.
- **`vorticity_antisymmetric`** — reversing the cell flips the sign (`ω(c,b,a) = −ω(a,b,c)`): a curl is
  orientation-odd, as it must be (`signTriple_rev`).
- **`vorticity_quantized` — `|ω| ≤ 1`.** Every cell carries **at most one circulation quantum**
  (`signTriple ∈ {−1, 0, +1}`). The vorticity is *quantized*.

## 3. Where QLF avoids the Navier–Stokes infinity

The Clay Navier–Stokes problem is whether a smooth incompressible flow can develop a **finite-time
singularity** — and the sharp criterion (Beale–Kato–Majda) is exactly **vorticity blow-up**: a
singularity forms iff `∫ ‖ω‖_∞ dt → ∞`, i.e. iff the vorticity becomes **unbounded**.

On the substrate that cannot happen:

- **Local: `ω` is capped at one quantum per cell** (`vorticity_quantized`, `|ω| ≤ 1`). There is no
  `ω → ∞` because there is a smallest, largest circulation a cell can hold. The blow-up criterion is
  *unsatisfiable* on the discrete geometry.
- **Global: angular momentum in a finite region is finite** (`circulation_bounded`, `|L| ≤ n`). A
  length-`n` history holds at most `n` circulation quanta — no runaway angular momentum.
- **The continuum's singular vorticity is unrealizable** (`continuum_vorticity_unrealizable`): a
  continuum vorticity value is a real number (`Infinite ℝ`), but a substrate cell holds finite
  information (`Finite R`), so there is **no faithful realization** of an `ℝ`-valued vorticity in a
  finite cell ([`no_continuum_in_finite_region`](lean/QLF_Realizability.lean)).

This gives the existing result `realized_flow_is_stable` ([`QLF_NavierStokes`](lean/QLF_NavierStokes.lean) —
"no realized flow blows up") its **geometric mechanism**: a blow-up would require unbounded vorticity,
and vorticity is capped at one quantum per cell.

## 4. The nature of the correction

The continuum permits `ω → ∞` because it models vorticity as a **real field with no smallest quantum** —
arbitrarily fine, arbitrarily intense rotation concentrated at a point. The substrate **quantizes
circulation to `±1` per cell** and bounds the count per region. That **discreteness is the correction** —
not a regularization bolted on, but the substrate's native floor. It is the *same* cutoff that removes
the ultraviolet catastrophe and the `10¹²²` vacuum catastrophe ([`TheContinuum.md`](TheContinuum.md)):
wherever the continuum produces an infinity by allowing unbounded fineness, the discrete substrate caps
it. The Navier–Stokes would-be singularity is one more instance — and the cap is *angular-momentum
quantization*.

## 5. Deriving the bridge — the Planck cap + Beale–Kato–Majda

The original module posited `navier_stokes_continuum_limit` as one opaque axiom ("the continuum inherits
the substrate's no-blow-up"). With the vorticity quantization in hand, [`QLF_NavierStokesBKM`](lean/QLF_NavierStokesBKM.lean)
**unbundles it into three transparent pieces** — *deriving* the no-blow-up rather than positing it:

1. **Proven (substrate arithmetic, no axiom).** Physical vorticity = circulation quantum / cell area.
   The quantum is `≤ 1` (`vorticity_quantized`) and the cell area is `≥ L_P²` (the Planck floor — no
   coherent sub-Planck cell, [`QLF_PlanckScale`](lean/QLF_PlanckScale.lean)), so physical vorticity is
   **`≤ 1/L_P²`** (`planck_caps_vorticity`): a fixed, *uniform-in-time* cap. The per-cell bound *with a
   smallest cell* is a uniform cap — there is no `ω → ∞`.
2. **Cited (a real theorem, not a QLF posit).** **Beale–Kato–Majda (1984):** a uniform-in-time vorticity
   bound ⟹ the BKM integral `∫₀ᵀ ‖ω‖_∞ dt ≤ M·T` is finite on every `[0,T]` ⟹ no finite-time
   singularity (`beale_kato_majda`). QLF carries no PDE machinery in Lean, so BKM is *cited* — exactly as
   Wallis/Stirling are cited for `π`.
3. **The sharp bridge (the residual gap).** The continuum solution's vorticity *is* the Planck-capped
   substrate vorticity (`continuum_vorticity_planck_capped`) — QLF's continuum-as-rendering thesis applied
   to the vorticity field. Small and precise, it **replaces** the opaque axiom.

From these, **`navier_stokes_no_blowup` is a theorem.** This directly answers *"is the semi-fractal
geometry sufficient?"*: **yes at the fixed Planck floor** — the cap *is* the floor, and there the
no-blow-up follows. The Clay statement lives in the unfloored `v → ∞` limit, which is precisely the
singular limit where a per-cell bound degenerates — and that is exactly the rendering step (3). So the
bridge is not eliminated but **localized**: from "the whole continuum inherits no-blow-up" down to "the
continuum vorticity is the Planck-capped substrate vorticity," with the mechanism explicit and BKM cited.

## 6. Turbulence — the quantized-vortex tangle and the frequency cascade

The same vorticity quantum reframes **turbulence** ([`QLF_Turbulence`](lean/QLF_Turbulence.lean)). First,
the crucial distinction: **it is all Navier–Stokes — but two different questions.** Both turbulence and
the Clay problem are the *same equations*; they split into

- the **regularity** question — global existence & smoothness / no finite-time blow-up. *This* is the
  Clay Millennium problem, and §5 reduces it (vorticity cap + BKM); and
- the **statistics** question — the `−5/3` Kolmogorov spectrum, intermittency, anomalous dissipation.
  *This* is "the turbulence problem," a **distinct and also-open** question, **not** the Clay one.

The vorticity quantum is the one lever under both:

- **Turbulence is a tangle of quantized vortices.** A vortex line is one circulation quantum
  (`vortex_quantum`, `|ω| ≤ 1`); total circulation is an *integer* count of net quanta
  (`circulation_integer_quantized`, `baryonNumber ∈ ℤ`). So the vorticity field is a discrete line-tangle,
  not a continuum — **Onsager–Feynman quantization** (verified in superfluid `He`/BECs) derived from the
  substrate. This makes **classical turbulence the coarse-grained limit of quantum turbulence**, which is
  why superfluid turbulence reproduces the classical Kolmogorov cascade.
- **The cascade is a frequency hierarchy.** An eddy of scale `R` is a closure of frequency `f = 1/R`;
  down the cascade (smaller eddies) the frequency increases (`cascade_frequency_increases`), bounded above
  by the dissipation floor (`cascade_capped` — the Kolmogorov scale, ultimately Planck). Dissipation is
  vortex **reconnection** (a ZFA closure) at the floor, radiating Kelvin waves — the superfluid-turbulence
  mechanism, and the same cap that removes the blow-up.

So the regularity side is *reduced* (§5); the statistics side is *structurally reframed* here
(quantized tangle, frequency cascade, classical = coarse-grained quantum) and taken one concrete,
falsifiable step further in §6a.

## 6a. The −5/3 spectrum and intermittency from self-similar closure statistics

The frequency cascade of §6 is a hierarchy of **fractal ZFA closures at every scale**, and Kolmogorov's
theory *is* a self-similarity statement — so the closure hierarchy has real quantitative content here.
Computation: [`turbulence_intermittency.py`](turbulence_intermittency.py).

**The `−5/3` spectrum, from closure-flux scale invariance.** K41 needs one premise: the energy flux
through the inertial range is scale-invariant. QLF supplies exactly that — each closure carries `log 2`
([`QLF_FreeEnergy`](lean/QLF_FreeEnergy.lean)), and if the energy passed from frequency-`f` closures to
their `2f` sub-closures is `f`-independent across the inertial range (the closure hierarchy is exactly
self-similar between injection and the `cascade_capped` floor), then dimensional analysis gives
`E(k) ~ ε^{2/3} k^{−5/3}`. The QLF-specific object is the **flux-invariance lemma** — closure-flux is
octave-independent in the inertial range — reusing `cascade_frequency_increases`; the `−5/3` exponent
is then K41's standard corollary, not a new claim. The hard invariant every closure model must pass is
`ζ_3 = 1` (the exact `4/5` law), which holds because `⟨W⟩ = 1` *is* flux conservation (`log 2` per
closure, conserved down the cascade).

**Intermittency — where the fractal reading bites.** Real turbulence deviates from the K41 monofractal
`ζ_p = p/3` because the cascade is **multifractal**, not monofractal — precisely "fractal closures at
many frequencies, not one." In the random-multiplier framework (`ζ_p = p/3 − log₂⟨W^{p/3}⟩`, with
`ζ_3 = 1` forced), the deviation is the distribution of the per-octave flux multiplier `W`, which QLF
must supply from closure statistics. The computation compares the candidates against measured exponents:

| `p` | K41 `p/3` | She–Leveque (C₀=2, β=⅔) | measured |
|---|---|---|---|
| 2 | 0.667 | 0.696 | 0.70 |
| 4 | 1.333 | 1.280 | 1.28 |
| 6 | 2.000 | 1.778 | 1.78 |
| 8 | 2.667 | 2.211 | 2.13 |

K41 misses at high `p` (RMS 0.242 vs measured) — **that deficit is the intermittency**. The
**parameter-free She–Leveque** log-Poisson cascade fits (RMS 0.029), and its one structural input is
**`C₀ = 2 =` the codimension of the most singular structures = 1-D vortex *filaments* in 3-D space
(`3 − 1 = 2`)** — an object QLF *already has*: its vortex lines are quantized 1-D filaments
(`vortex_quantum`, `circulation_integer_quantized`, Onsager–Feynman). So the parameter the fit needs is
**grounded in the substrate, not fitted**; the log-normal route instead needs `μ ≈ 0.231` (measured
`~0.25`), reducing intermittency to a single number — the **census variance of realized closures per
octave** (`C(2n,n)/4ⁿ` fluctuations).

**Why She–Leveque and not log-normal — closure statistics *select* the class.** The two candidates are not on equal footing. Closures are **rare, quasi-independent events** in a region, so their occupation is **Poisson** — the very object already verified for the causal-set curvature limit (`poissonOccupation`, [`QLF_CausalContinuum`](lean/QLF_CausalContinuum.lean)). A Poisson-multiplier cascade is **log-Poisson** (Dubrulle 1994), *not* log-normal — and log-Poisson with the grounded `C₀ = 2` is exactly She–Leveque. This is decided on **realizability**, not just goodness-of-fit: at high `p` the log-normal `ζ_p` **turns over and decreases** (past `p ≈ 14.5` for `μ = 0.23`), violating the requirement that `ζ_p` be non-decreasing, whereas She–Leveque stays monotone with asymptotic slope `1/9` (the minimum Hölder exponent of the most-singular structures). So QLF's Poisson closure statistics *pick out* the physically correct log-Poisson class and rule the log-normal out — the same "the continuum/unbounded object is unphysical, the discrete one is realizable" move as everywhere in QLF ([`QLF_Realizability`](lean/QLF_Realizability.lean)). The one residual free input is then `β = 2/3`.

**Honest scope — this closes the 🔵 *statistics* item, not the 🧱 regularity boundary.** What is done:
`−5/3` reduced to the flux-invariance lemma + K41; `ζ_3 = 1` exact; intermittency shown to be the
multifractal (fractal-closure) deviation, with She–Leveque's `C₀ = 2` grounded in QLF's quantized vortex
filaments and matching data parameter-free. And the **class is now selected**, not just fitted: Poisson
closures → log-Poisson → She–Leveque, decided on realizability (the log-normal is unphysical at high `p`,
above). With the class fixed and `C₀ = 2` grounded, intermittency reduces to a **single remaining input,
`β = 2/3`** (`μ = 2 − ζ_6 = 0.222` then follows and matches data). What stays open
(`turbulence_statistics_in_progress`): a Lean proof of the flux-invariance lemma, the derivation of
`β = 2/3` from the closure step-ratio, and — separately — the Clay regularity boundary of §5, which
self-similar frequencies say nothing about. The fractal reading is **falsifiable**: it lives or dies by
whether the closure step-ratio is `2/3`, and it can fail cleanly.

## 7. Honest scope

- **Proven on the substrate:** angular momentum = circulation, its pseudovector law, vorticity =
  quantized discrete curl, `|ω| ≤ 1`, `|L| ≤ n`, and the unrealizability of continuum vorticity in a
  finite cell — all machine-verified, no new axioms.
- **The boundary, now reduced — not eliminated.** The opaque `navier_stokes_continuum_limit`
  ([`QLF_NavierStokes`](lean/QLF_NavierStokes.lean)) is replaced (§5) by the *proven* Planck vorticity cap
  + the *cited* BKM theorem + a *sharp* faithfulness bridge `continuum_vorticity_planck_capped`, from
  which `navier_stokes_no_blowup` is a theorem. The residual gap is just the vorticity-rendering
  faithfulness — small, precise, and exactly QLF's continuum-as-rendering thesis. This is a **reduction**,
  **not a Clay proof**: BKM and the faithfulness bridge remain inputs, and the Clay statement is in the
  unfloored `v → ∞` limit (the rendering step), not at the Planck-floored substrate where the result is
  proven.
- **Beale–Kato–Majda** is *cited* as a real 1984 theorem (the standard continuum criterion that names
  what the substrate rules out), not re-derived — QLF has no PDE machinery in Lean.

See also: [`NavierStokes_QLF.md`](NavierStokes_QLF.md) (the existence/smoothness reformulation),
[`Geometry_Of_Space.md`](Geometry_Of_Space.md) (the geometry these dynamics live on),
[`Conservation.md`](Conservation.md) (Noether currents), [`Curvature.md`](Curvature.md) (blanket
deformation), [`TheContinuum.md`](TheContinuum.md) (why discreteness removes the infinities).
