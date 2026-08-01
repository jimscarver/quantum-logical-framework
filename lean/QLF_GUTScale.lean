import QLF_ElectroweakBeta

set_option linter.unusedVariables false

/-!
# QLF_GUTScale — the unification scale: structure derived, absolute value scale-bound

With the three β-coefficients now substrate-fixed (`QLF_ElectroweakBeta`) and the unification target
`sin²θ_W = 3/8` derived (`QLF_WeinbergAngle`), the **structure** of gauge-coupling unification is
pinned down. This module anchors the unification-scale *formula* — and states, honestly, exactly why
the *absolute* GUT scale is not a free QLF prediction but ties to the one open scale (frontier #1).

## The unification-scale formula

Two couplings running at one loop (`QLF_RunningCouplings.inv_coupling`, `1/α_i(t) = 1/α_i(0) +
(b_i/2π)·t`, `t = ln(μ/μ₀)`) **meet** at the scale

  `t* = 2π·(α₂⁻¹(μ₀) − α₁⁻¹(μ₀)) / (b₁ − b₂)`  (`couplings_meet_at`),

an exact algebraic consequence. QLF supplies the **denominator from first principles**: `b₁ − b₂ =
41/10 − (−19/6) = 109/15` (`b1_minus_b2_val`), and the **unification target** `sin²θ_W = 3/8`
(`QLF_WeinbergAngle.sin2_weinberg_substrate_eq`) is the value the *rendered* `sin²θ_W(μ)` runs to at
`t*`. So "why does unification happen at *this* log-distance" reduces to the `μ₀ = M_Z` coupling gap
`α₂⁻¹ − α₁⁻¹` in the numerator — a **measured input**, not a QLF free parameter.

Three-way unification (`α₁ = α₂ = α₃` at one point) is *over-determined* — the three pairwise
meeting scales coincide only if the couplings are consistent. That the QLF-derived `b_i` + the
measured `M_Z` couplings **do** nearly meet (exactly, in the MSSM) is a genuine consistency the
substrate passes at the coefficient level; QLF derives the `b_i` and the `3/8` target that make the
test meaningful, not the couplings that are fed into it.

## Honest scope (`gut_scale_in_progress`)

**Derived (value-free):** the unification-scale *formula* and its QLF inputs — the slope `b₁ − b₂ =
109/15` (`b1_minus_b2_val`) and the target `sin²θ_W = 3/8`. **Open (the absolute value):** the GUT
scale `M_GUT = M_Z·exp(t*)` needs the `M_Z` couplings `α_i(M_Z)` in the numerator — measured inputs
tied to the **absolute scale** (frontier #1, the open coupling `g`/`v`). This is the same boundary as
the SM/MSSM, which *fit* the `M_Z` couplings and run up; neither derives `M_GUT` from nothing. QLF's
addition is that the *slope* (`b_i`) and *target* (`3/8`) are no longer inputs.

**Pre-buried (per Step-0, `Alpha.md` §6a discipline):** the numerical proximity `ln(M_Pl/M_GUT) ≈ 2π`
(with the *non-reduced* Planck mass, `1.22×10¹⁹/2×10¹⁶ ≈ 610`, `ln 610 ≈ 6.4 ≈ 2π`) is **not** a
result — it **fails the robustness test**: it depends on the Planck-mass convention (reduced vs.
non-reduced, a factor `√(8π)`) and on the GUT-model spread of `M_GUT` (`10¹⁵–10¹⁶·⁵`), so it matches
only a particular choice and is *not* stable. Recorded here so the next person who computes it finds
it already flagged, exactly as the `dim Gr(3,15) = 36` α-match is pre-buried in `QLF_AlphaRigidity`.

Reuses `QLF_ElectroweakBeta` + `QLF_RunningCouplings`; no new axioms. See `Weak_Force.md` §6,
`Alpha.md` §4a.
-/

namespace QLF

/-- **The unification-scale formula.** Two one-loop couplings `inv_coupling A_i b_i` meet at
    `t* = 2π·(A₂ − A₁)/(b₁ − b₂)` — proven by direct algebra. The denominator `b₁ − b₂` is the
    QLF-derived slope; the numerator `A₂ − A₁` is the `μ₀`-scale coupling gap. -/
theorem couplings_meet_at (A1 A2 β1 β2 : ℝ) (hβ : β1 ≠ β2) :
    inv_coupling A1 β1 (2 * Real.pi * (A2 - A1) / (β1 - β2))
      = inv_coupling A2 β2 (2 * Real.pi * (A2 - A1) / (β1 - β2)) := by
  unfold inv_coupling
  have hpi : Real.pi ≠ 0 := Real.pi_ne_zero
  have hβne : β1 - β2 ≠ 0 := sub_ne_zero.mpr hβ
  field_simp
  ring

/-- **The QLF-derived unification slope** `b₁ − b₂ = 109/15` — the denominator of the
    unification-scale formula, fixed by the substrate counts (`QLF_ElectroweakBeta`). -/
theorem b1_minus_b2_val : (b1 : ℚ) - b2 = 109 / 15 := by
  rw [b1_eq, b2_eq]; norm_num

/-- The unification slope is **positive** — `b₁ > b₂` (U(1) screens, SU(2) is asymptotically free),
    so `sin²θ_W` runs monotonically *down* from `3/8` as the scale decreases from `M_GUT` to `M_Z`. -/
theorem b1_gt_b2 : (b2 : ℚ) < b1 := by rw [b1_eq, b2_eq]; norm_num

/-- **The GUT log-distance** `t* = 2π·(A₂ − A₁)/(b₁ − b₂)` with QLF's derived denominator, as a
    function of the (input) `M_Z` inverse-coupling gap `A₂ − A₁`. The map from the measured coupling
    gap to `ln(M_GUT/M_Z)`; the numerator is the open scale-bound input. -/
noncomputable def gutLogDistance (couplingGap : ℝ) : ℝ :=
  2 * Real.pi * couplingGap / ((b1 : ℝ) - (b2 : ℝ))

/-- `gutLogDistance` is the `t*` at which the two couplings with gap `A₂ − A₁` meet — specialising
    `couplings_meet_at` to the QLF-derived `b₁, b₂` (which differ, `b1_gt_b2`). So the whole
    dependence of `ln(M_GUT/M_Z)` on QLF is through the derived slope `b₁ − b₂`; the numerator is the
    input coupling gap. -/
theorem gut_scale_from_gap (A1 A2 : ℝ) :
    inv_coupling A1 (b1 : ℝ) (gutLogDistance (A2 - A1))
      = inv_coupling A2 (b2 : ℝ) (gutLogDistance (A2 - A1)) := by
  have hlt : (b2 : ℝ) < (b1 : ℝ) := by exact_mod_cast b1_gt_b2
  have hβ : (b1 : ℝ) ≠ (b2 : ℝ) := ne_of_gt hlt
  simpa [gutLogDistance] using couplings_meet_at A1 A2 (b1 : ℝ) (b2 : ℝ) hβ

end QLF
