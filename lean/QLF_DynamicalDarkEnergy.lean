import QLF_CosmologicalConstant
import Mathlib

/-!
# QLF_DynamicalDarkEnergy — ρ_Λ ∝ H², so QLF's dark energy is dynamical (not a constant Λ)

Lean-anchors the load-bearing fact behind QLF's Hubble-tension stance (`DarkMatter.md` §5a): QLF's
vacuum energy density `ρ_Λ = (3 log 2 / 8π)·c⁴/(G R_H²)` (`QLF_CosmologicalConstant`,
`vacuum_energy_density_QLF`), with the Hubble radius `R_H = c/H`, **scales as the square of the expansion
rate**: `ρ_Λ = (prefactor·c²/G)·H²`. Hence it is **dynamical** — strictly increasing in `H`, so **denser
in the past** (larger `H`) — *early-dark-energy character*, and explicitly **not** a constant `Λ`. This
is the QLF property that places its cosmology in the resolution-favorable class of the Hubble tension.

**Honest scope:** this anchors the *proportionality and its monotonicity* (dynamical / past-denser /
not-constant), reusing QLF's `ρ_Λ` formula. It does **not** derive the absolute `H₀` or the early-universe
expansion history, so it does **not** resolve the tension numerically (`DarkMatter.md` §5a). No new axioms.
-/

namespace QLF.DynamicalDarkEnergy

open QLF

/-- The `H²`-scaling constant `K = (prefactor·c²)/G`. -/
noncomputable def rhoLambdaCoeff (G c : ℝ) : ℝ := vacuum_energy_prefactor * c ^ 2 / G

/-- **ρ_Λ ∝ H².** Substituting the Hubble radius `R_H = c/H` into QLF's vacuum density gives
    `ρ_Λ = (prefactor·c²/G)·H²` — the dark-energy density is the square of the expansion rate. -/
theorem rhoLambda_prop_Hsq (G c H : ℝ) (hG : G ≠ 0) (hc : c ≠ 0) (hH : H ≠ 0) :
    vacuum_energy_density_QLF G c (c / H) = rhoLambdaCoeff G c * H ^ 2 := by
  unfold vacuum_energy_density_QLF rhoLambdaCoeff
  field_simp

/-- The scaling constant is positive (`prefactor = 3 log 2 / 8π > 0`; physical `G, c > 0`). -/
theorem rhoLambdaCoeff_pos {G c : ℝ} (hG : 0 < G) (hc : 0 < c) : 0 < rhoLambdaCoeff G c := by
  unfold rhoLambdaCoeff vacuum_energy_prefactor
  have hlog : 0 < Real.log 2 := Real.log_pos (by norm_num)
  have hpi : 0 < Real.pi := Real.pi_pos
  positivity

/-- **Dynamical & past-denser.** For physical `G, c > 0`, `ρ_Λ(H)` strictly increases with `H`; since
    `H` decreases over cosmic time, the dark energy was **denser in the past** — early-dark-energy
    character. (Larger `H` = smaller horizon `R_H = c/H` = denser `ρ_Λ`.) -/
theorem rhoLambda_past_denser {G c H₁ H₂ : ℝ} (hG : 0 < G) (hc : 0 < c)
    (h1 : 0 < H₁) (h12 : H₁ < H₂) :
    rhoLambdaCoeff G c * H₁ ^ 2 < rhoLambdaCoeff G c * H₂ ^ 2 := by
  have hK := rhoLambdaCoeff_pos hG hc
  have hsq : H₁ ^ 2 < H₂ ^ 2 := by nlinarith [h1, h12]
  exact mul_lt_mul_of_pos_left hsq hK

/-- **Not a cosmological constant.** `ρ_Λ` takes different values at different `H` — dynamical, unlike
    ΛCDM's static `Λ`. -/
theorem rhoLambda_not_constant {G c : ℝ} (hG : 0 < G) (hc : 0 < c) :
    rhoLambdaCoeff G c * (1 : ℝ) ^ 2 ≠ rhoLambdaCoeff G c * (2 : ℝ) ^ 2 :=
  ne_of_lt (rhoLambda_past_denser hG hc one_pos one_lt_two)

/-- **Status — QLF's dark energy is dynamical.** `ρ_Λ ∝ H²` (`rhoLambda_prop_Hsq`), strictly increasing
    in `H` (`rhoLambda_past_denser`) and non-constant (`rhoLambda_not_constant`): the early-dark-energy
    character behind the resolution-favorable Hubble-tension stance (`DarkMatter.md` §5a). The numeric
    resolution / absolute `H₀` is not derived. No new axioms. -/
theorem dynamical_dark_energy_summary : True := trivial

end QLF.DynamicalDarkEnergy
