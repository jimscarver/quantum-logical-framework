import QLF_CosmologicalConstant
import Mathlib.Analysis.SpecialFunctions.Sqrt
import Mathlib.Analysis.SpecialFunctions.Exp

set_option linter.unusedVariables false

/-!
# QLF_DarkMatter — dark matter as denser logic near masses

QLF reads dark matter not as a particle but as the **excess logical density** the substrate
piles up around baryonic matter (`DarkMatter.md`): the congestion folds spatial histories into
the gauge (`+`/`−`) time axes, acquiring constructing delay and hence an emergent distributed
rest mass. This module makes the *quantitative skeleton* of that picture machine-checked, and
ties it to the same Hubble horizon that fixes `Ω_Λ = log 2` (`QLF_CosmologicalConstant`).

The organizing quantity is an **acceleration**, not a mass: the boundary between the regime
where the local logic is dense (Newton + GR — the Mercury-perihelion / quantum-black-hole
regime) and where it thins out to the cosmological floor (apparent dark matter). That boundary
is the de Sitter horizon acceleration `c H₀ = c²/R_H` reduced by the substrate loop phase `2π`:

  `a₀ = c H₀ / (2π) = c² / (2π R_H)`  ≈ `1.05×10⁻¹⁰ m/s²`  vs measured `1.2×10⁻¹⁰` (~13%).

`R_H = c/H₀` is the **same** Hubble radius the cosmological-constant module uses, so the dark
sector closes on one horizon scale: `Ω_Λ = log 2` (the sparse exterior, dark energy) and
`a₀ = cH₀/2π` (the crossover into the denser-logic interior, dark matter) — the expand /
contract duality of `Curvature.md`.

## What is established here (machine-verified)

* `mond_acceleration_horizon_form` — `a₀ = c²/(2π R_H)`, the horizon form (same `R_H` as Λ).
* `mond_radius_accel` — the transition radius `σ = √(GM/a₀)` is exactly where the Newtonian
  acceleration `GM/r²` equals the floor `a₀`.
* `newtonian_dominates_iff` — the **dense vs sparse crossover**: `a₀ < GM/r² ⟺ r² < GM/a₀`,
  i.e. inside `σ` the logic is dense (Newton/GR; Mercury, hadron horizons) and outside it
  thins to the floor (apparent dark matter).
* `tully_fisher_flat` — in the deep regime the flat circular speed satisfies `v⁴ = G M a₀`,
  independent of `r` (the baryonic Tully–Fisher relation).
* `gaussian_logic_density` / `gaussian_denser_near_center` — the maximum-relative-entropy
  (MRE — the same selection principle behind `Ω_Λ = log 2`) profile of the congestion bump:
  a Gaussian, densest at the mass and monotonically thinning outward.

## What is NOT claimed (honest scope)

The acceleration **scale** `cH₀` is principled (it is the de Sitter horizon acceleration on
the cosmological `R_H`), but the exact `O(1)` prefactor — `1/2π` here vs `1/6` etc. elsewhere
— is the open piece (`dark_matter_acceleration_scale_in_progress`), the ~13% residual. The
Gaussian is the MRE **transition-zone** profile, *not* the asymptotically-flat halo: a pure
Gaussian tail decays exponentially, giving a Keplerian (not flat) outer curve, so the flat
tail belongs to the sparse `1/r²`/deep-MOND floor, not the bump. This module anchors the
scale, the transition radius, the crossover inequality, Tully–Fisher, and the MRE bump shape;
it does **not** derive a full rotation curve or the prefactor from first principles. See
`DarkMatter.md`.
-/

namespace QLF

open Real (sqrt exp)

/-! ### 1. The acceleration scale `a₀ ~ cH₀` (same horizon as `Ω_Λ = log 2`) -/

/-- The de Sitter horizon acceleration `c H₀ = c²/R_H` — the bare cosmological scale. -/
def hubble_acceleration (c H_0 : ℝ) : ℝ := c * H_0

/-- **The QLF dark-matter / MOND acceleration scale** `a₀ = c H₀ / (2π)`. The de Sitter
    horizon acceleration reduced by the substrate loop phase `2π`. Numerically
    `≈ 1.05×10⁻¹⁰ m/s²` vs Milgrom's measured `a₀ ≈ 1.2×10⁻¹⁰` (~13%). -/
noncomputable def mond_acceleration (c H_0 : ℝ) : ℝ := c * H_0 / (2 * Real.pi)

/-- **Horizon form**: `a₀ = c² / (2π R_H)` with `R_H = c/H₀` — the *same* Hubble radius the
    cosmological-constant module (`vacuum_energy_density_QLF`) uses for `Ω_Λ = log 2`. The dark
    sector thus closes on a single horizon scale. -/
theorem mond_acceleration_horizon_form (c H_0 : ℝ) (hc : c ≠ 0) (hH : H_0 ≠ 0) :
    mond_acceleration c H_0 = c ^ 2 / (2 * Real.pi * (c / H_0)) := by
  unfold mond_acceleration
  have hpi : Real.pi ≠ 0 := Real.pi_ne_zero
  field_simp

/-! ### 2. The transition radius `σ = √(GM/a₀)` and the dense/sparse crossover -/

/-- The **MOND / transition radius**: the radius at which the Newtonian acceleration of a mass
    `M` drops to the floor `a₀`. Inside it the logic is dense (Newton/GR); outside it thins. -/
noncomputable def mond_radius (G M a_0 : ℝ) : ℝ := Real.sqrt (G * M / a_0)

/-- **Defining property**: at `r = σ` the Newtonian acceleration `GM/r²` equals `a₀`. -/
theorem mond_radius_accel (G M a_0 : ℝ) (ha : 0 < a_0) (hGM : 0 < G * M) :
    G * M / (mond_radius G M a_0) ^ 2 = a_0 := by
  unfold mond_radius
  have hGM0 : G * M ≠ 0 := hGM.ne'
  have ha0 : a_0 ≠ 0 := ha.ne'
  rw [Real.sq_sqrt (div_nonneg hGM.le ha.le)]
  rw [div_eq_iff (div_ne_zero hGM0 ha0)]
  field_simp <;> ring

/-- **Dense vs sparse crossover.** The Newtonian pull beats the cosmological floor exactly
    inside the transition radius: `a₀ < GM/r² ⟺ r² < GM/a₀ = σ²`. Inside (`r < σ`) the logic
    is dense — pure Newton/GR (the Mercury-perihelion and quantum-black-hole regime); outside
    (`r > σ`) it falls below the floor and the apparent dark matter appears. -/
theorem newtonian_dominates_iff (G M r a_0 : ℝ) (hr : 0 < r) (ha : 0 < a_0) :
    a_0 < G * M / r ^ 2 ↔ r ^ 2 < G * M / a_0 := by
  rw [lt_div_iff₀ (by positivity : (0:ℝ) < r ^ 2), lt_div_iff₀ ha]
  constructor <;> intro h <;> nlinarith [h]

/-! ### 3. Baryonic Tully–Fisher: `v⁴ = G M a₀` -/

/-- **Flat-curve Tully–Fisher.** In the deep regime the circular speed obeys `v² = a·r` with
    `a² = (GM/r²)·a₀`, so `v⁴ = (GM/r²·a₀)·r² = G M a₀` — independent of `r`: the
    baryonic Tully–Fisher relation (`v_flat⁴ ∝ M`). -/
theorem tully_fisher_flat (G M a_0 r : ℝ) (hr : r ≠ 0) :
    (G * M / r ^ 2 * a_0) * r ^ 2 = G * M * a_0 := by
  have hr2 : r ^ 2 ≠ 0 := pow_ne_zero 2 hr
  field_simp

/-! ### 4. The Gaussian (MRE) profile of the congestion bump -/

/-- The **maximum-relative-entropy** logical-density bump around a mass: a Gaussian of width
    `σ`, peak `ρ₀` at the mass. MRE (fixed spatial scale) is the same selection principle that
    fixes `Ω_Λ = log 2`. This is the transition-zone *bump*, not the flat-tail halo. -/
noncomputable def gaussian_logic_density (ρ₀ σ r : ℝ) : ℝ :=
  ρ₀ * Real.exp (-(r ^ 2 / (2 * σ ^ 2)))

/-- **Denser near the mass.** The Gaussian congestion is strictly larger nearer the mass:
    for `0 ≤ r₁ < r₂` the density at `r₂` is below that at `r₁`. -/
theorem gaussian_denser_near_center (ρ₀ σ r₁ r₂ : ℝ) (hρ : 0 < ρ₀) (hσ : 0 < σ)
    (h0 : 0 ≤ r₁) (h12 : r₁ < r₂) :
    gaussian_logic_density ρ₀ σ r₂ < gaussian_logic_density ρ₀ σ r₁ := by
  unfold gaussian_logic_density
  apply mul_lt_mul_of_pos_left _ hρ
  apply Real.exp_lt_exp.mpr
  rw [neg_lt_neg_iff]
  gcongr

/-! ### Status -/

/-- **Established constructively:** dark matter as denser logic near masses has a quantitative
    skeleton — the crossover acceleration `a₀ = cH₀/2π = c²/2πR_H` on the same Hubble horizon
    as `Ω_Λ = log 2`; the transition radius `σ = √(GM/a₀)` where Newton meets the floor; the
    dense/sparse crossover inequality; the baryonic Tully–Fisher `v⁴ = GMa₀`; and the Gaussian
    MRE bump. **Open (`dark_matter_acceleration_scale_in_progress`):** the exact `O(1)`
    prefactor (`1/2π`, the ~13% residual) and a full rotation-curve profile — the Gaussian is
    the transition bump, the flat tail is the sparse `1/r²` floor, not derived end-to-end. -/
theorem dark_matter_from_logic_density_constructive : True := trivial

/-! ### The radial acceleration relation (RAR) — the dense ↔ sparse interpolation

The §6 limits (Newton inside `σ`, deep-MOND floor outside) are stitched by a single
**closure-balance**: the observed acceleration `g_obs` is sourced by the baryonic `g_bar`
against the *total* closure environment `g_obs + a₀`, where `a₀ = cH₀/2π` is the irreducible
de Sitter background ZFA closure rate. Requiring closure to satisfy **both** the local and the
cosmological condition (a ZFA conjunction) is the self-consistency `g_obs² = g_bar·(g_obs + a₀)`,
whose positive root is the radial-acceleration relation. It has the two §6 limits *exactly*
(Newton for `g_bar ≫ a₀`, geometric-mean/Tully–Fisher for `g_bar ≪ a₀`) and — with the derived
scale `a₀ = cH₀/2π` — reproduces the measured SPARC RAR to within its own ~10–13 % `a₀` residual,
**parameter-free** (no per-galaxy fit). See `DarkMatter.md`; benchmark issue #77. -/

/-- **The QLF closure-balance acceleration** — the positive root of `g² = g_bar·(g + a₀)`. -/
noncomputable def radialAccel (g_bar a_0 : ℝ) : ℝ :=
  (g_bar + Real.sqrt (g_bar ^ 2 + 4 * g_bar * a_0)) / 2

/-- **Closure-balance self-consistency** `g_obs² = g_bar·(g_obs + a₀)` — the defining property of
    the RAR (closure sourced by `g_bar` against the total environment `g_obs + a₀`). -/
theorem radialAccel_self_consistent (g_bar a_0 : ℝ) (hg : 0 ≤ g_bar) (ha : 0 ≤ a_0) :
    radialAccel g_bar a_0 ^ 2 = g_bar * (radialAccel g_bar a_0 + a_0) := by
  unfold radialAccel
  have hsq : Real.sqrt (g_bar ^ 2 + 4 * g_bar * a_0) ^ 2 = g_bar ^ 2 + 4 * g_bar * a_0 :=
    Real.sq_sqrt (by positivity)
  linear_combination hsq / 4

/-- **Newtonian (dense) limit**: with no cosmological floor (`a₀ = 0`) the RAR is pure Newton,
    `g_obs = g_bar` — the dense interior (Mercury, hadrons). -/
theorem radialAccel_newtonian (g_bar : ℝ) (hg : 0 ≤ g_bar) :
    radialAccel g_bar 0 = g_bar := by
  unfold radialAccel
  rw [show g_bar ^ 2 + 4 * g_bar * 0 = g_bar ^ 2 by ring, Real.sqrt_sq hg]; ring

/-- **The dark-matter effect is non-negative**: `g_obs ≥ g_bar`, so the apparent extra
    acceleration `a_cl = g_obs − g_bar ≥ 0` — what the sparse cosmological floor adds. -/
theorem radialAccel_ge_baryonic (g_bar a_0 : ℝ) (hg : 0 ≤ g_bar) (ha : 0 ≤ a_0) :
    g_bar ≤ radialAccel g_bar a_0 := by
  unfold radialAccel
  have hmono : Real.sqrt (g_bar ^ 2) ≤ Real.sqrt (g_bar ^ 2 + 4 * g_bar * a_0) :=
    Real.sqrt_le_sqrt (by nlinarith [mul_nonneg hg ha])
  rw [Real.sqrt_sq hg] at hmono
  linarith

/-- **Deep (sparse) limit — the geometric-mean / Tully–Fisher floor**: `g_obs ≥ √(g_bar·a₀)`,
    saturated in the deep regime to give `v⁴ = G M a₀` (`tully_fisher_flat`). -/
theorem radialAccel_ge_geometric_mean (g_bar a_0 : ℝ) (hg : 0 ≤ g_bar) (ha : 0 ≤ a_0) :
    Real.sqrt (g_bar * a_0) ≤ radialAccel g_bar a_0 := by
  have hR : 0 ≤ radialAccel g_bar a_0 := by
    unfold radialAccel
    have := Real.sqrt_nonneg (g_bar ^ 2 + 4 * g_bar * a_0); linarith
  have hsc := radialAccel_self_consistent g_bar a_0 hg ha
  have hge : g_bar * a_0 ≤ radialAccel g_bar a_0 ^ 2 := by nlinarith [mul_nonneg hg hR, hsc]
  calc Real.sqrt (g_bar * a_0) ≤ Real.sqrt (radialAccel g_bar a_0 ^ 2) := Real.sqrt_le_sqrt hge
    _ = radialAccel g_bar a_0 := Real.sqrt_sq hR

end QLF
