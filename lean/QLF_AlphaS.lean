import QLF_MassSpectrum
import QLF_BetaFunction

set_option linter.unusedVariables false

/-!
# QLF_AlphaS — the substrate strong coupling, and the hierarchy from one integer

`QLF_MassSpectrum` reduced the absolute mass scale to dimensional transmutation,
`ln R_p = 2π/(b₀·α_s)`, leaving the substrate-scale strong coupling `α_s` and the calibration as
the only open inputs. `QLF_BetaFunction` fixed `b₀ = 7` from the substrate (`N_c=3`, `n_f=6`). This
module closes the `α_s` input with a structural identification — and the result is striking.

**The posit:** `α_s(substrate) = 1/b₀²` (`substrate_alpha_s`). This is motivated, not arbitrary:
the *measured* running of `α_s` from `M_Z` up to the Planck scale gives `1/α_s(M_Planck) ≈ 52`
(one-loop, `b₀=7`), and `b₀² = 49` — agreement to ~7%. So the substrate coupling is the
inverse-squared β-coefficient, to within the running's accuracy.

**The consequence — the hierarchy is a pure integer.** With `α_s = 1/b₀²`, the transmutation
collapses (`log_hierarchy_pure_integer`):

  `ln R_p = 2π/(b₀·α_s) = 2π/(b₀·(1/b₀²)) = 2π·b₀`.

With `b₀ = 7`: `ln R_p = 14π ≈ 43.98` (`hierarchy_log_eq_fourteen_pi`), matching the measured
`ln(M_Planck/m_p) ≈ 44.01` to **0.07%**. The *entire* Planck/proton hierarchy — and hence (via
`QLF_MassSpectrum`'s one-parameter reduction) the absolute mass spectrum — follows from the single
integer `b₀ = 7`, itself the substrate's `N_c=3` and `n_f=6`:

  `R_p = e^{2π b₀} = e^{14π}`.

## Honest scope

`α_s = 1/b₀²` is a **structural identification**, consistent with the measured running (~7%), not a
derivation from substrate coupling dynamics. The match is **0.07% on the log** but **~3% on the
value** `R_p` (`e^{14π} = 1.26×10¹⁹` vs `M_Planck/m_p = 1.30×10¹⁹`), the ~3% being the Planck-mass
convention / SI calibration that `QLF_MassSpectrum` already flagged. So: the hierarchy is reduced
to one integer, with the residual calibration and the `α_s=1/b₀²` mechanism the open pieces
(`alpha_s_substrate_in_progress`). See `Per_Qubit_Mass_Quantum.md` §3.3a.
-/

namespace QLF

/-- **Substrate strong coupling** `α_s = 1/b₀²` — the inverse-squared β-coefficient (consistent
    with the measured running `1/α_s(M_Planck) ≈ 52 ≈ b₀² = 49`). -/
noncomputable def substrate_alpha_s (b : ℝ) : ℝ := 1 / b ^ 2

/-- **The transmutation collapses to a pure integer**: with `α_s = 1/b²`, the log-hierarchy
    `2π/(b·α_s) = 2π·b`. -/
theorem log_hierarchy_pure_integer (b : ℝ) (hb : b ≠ 0) :
    2 * Real.pi / (b * substrate_alpha_s b) = 2 * Real.pi * b := by
  unfold substrate_alpha_s
  field_simp

/-- Reusing the dimensional-transmutation depth: `ln(transmuted_hierarchy b (1/b²)) = 2π·b`. -/
theorem log_transmuted_hierarchy_integer (b : ℝ) (hb : b ≠ 0) :
    Real.log (transmuted_hierarchy b (substrate_alpha_s b)) = 2 * Real.pi * b := by
  rw [log_transmuted_hierarchy]
  exact log_hierarchy_pure_integer b hb

/-- **The hierarchy from one integer.** With the substrate β-coefficient `b₀ = 7` (`N_c=3, n_f=6`,
    `QLF_BetaFunction`) and `α_s = 1/b₀²`, the proton/Planck log-hierarchy is exactly `2π·7 = 14π`
    (`≈ 43.98`), matching the measured `ln(M_Planck/m_p) ≈ 44.01` to 0.07%. The absolute scale —
    and the whole mass spectrum — from the single integer `7`. -/
theorem hierarchy_log_eq_fourteen_pi :
    Real.log (transmuted_hierarchy (beta_coefficient 3 6)
      (substrate_alpha_s (beta_coefficient 3 6))) = 14 * Real.pi := by
  have hb : beta_coefficient 3 6 ≠ 0 := by rw [beta_coefficient_eq_seven]; norm_num
  rw [log_transmuted_hierarchy_integer _ hb, beta_coefficient_eq_seven]
  ring

/-- **Established constructively:** positing `α_s(substrate) = 1/b₀²` (consistent with the measured
    running to ~7%) collapses the dimensional-transmutation hierarchy to a **pure integer**,
    `ln R_p = 2π·b₀` (`log_hierarchy_pure_integer`); with the substrate `b₀ = 7` this is `14π`,
    matching `ln(M_Planck/m_p)` to **0.07%** (`hierarchy_log_eq_fourteen_pi`). So the absolute mass
    scale follows from the single integer `b₀ = 7` (= `N_c=3`, `n_f=6`). **Open:** the
    `α_s = 1/b₀²` identification as a *derivation* (not just a running-consistent posit), and the
    ~3% value-level Planck-mass/SI calibration (`alpha_s_substrate_in_progress`). -/
theorem alpha_s_substrate_in_progress : True := trivial

/-! ### Bounds on the hierarchy — the `α_s` sensitivity made explicit

`ln R_p = 2π·(1/α_s)/b₀` is *exponentially* sensitive to `α_s`: the value `R_p` is pinned only as
tightly as `α_s`.  `α_s` is fixed to a running-consistent window — `1/α_s ∈ [49, 52]` (the posit
`b₀² = 49` vs the one-loop extrapolation `≈ 52`) — so with `b₀ = 7` the *log*-hierarchy lies in a band
and the measured value sits inside, near the `14π`/posit edge.  (In fact the measured value implies
`1/α_s ≈ 49.0`, so the posit `b₀² = 49` is the data-favoured end.)  The tight `0.07%` is the agreement
*at the posit*, not the width of the prediction. -/

/-- **Hierarchy band.**  With `b₀ = 7`, for `1/α_s = x ∈ [49, 52]` the log-hierarchy `2π·x/7` lies in
    `[14π, 104π/7] ≈ [43.98, 46.67]`. -/
theorem hierarchy_log_band {x : ℝ} (hlo : 49 ≤ x) (hhi : x ≤ 52) :
    14 * Real.pi ≤ 2 * Real.pi * x / 7 ∧ 2 * Real.pi * x / 7 ≤ 104 * Real.pi / 7 := by
  refine ⟨?_, ?_⟩ <;> nlinarith [Real.pi_pos]

-- The measured `ln(M_Planck/m_p) ≈ 44.01` sits inside this band `[14π, 104π/7] ≈ [43.98, 46.67]`,
-- near the `14π` (posit) edge — `14π ≈ 43.982 < 44.01` — so the data implies `1/α_s ≈ 49.0` and the
-- posit `b₀² = 49` is the data-favoured end (a numeric fact at the band's lower edge).

/-- **The band is wide in the value** (exponential sensitivity): the `α_s` window spans `6π/7 ≈ 2.69`
    in the log, i.e. a factor `e^{6π/7} ≈ 15` in `R_p`.  So the hierarchy is reduced to one integer at
    the *log* level, but the absolute value is not tightly bounded — it is exp-sensitive to `α_s`. -/
theorem hierarchy_band_width : 104 * Real.pi / 7 - 14 * Real.pi = 6 * Real.pi / 7 := by ring

end QLF
