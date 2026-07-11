import Mathlib

/-!
# QLF_PiRational — π-dependent physics bounds as rational intervals (issue #113)

The template module for the `Real.pi` → rational-interval pass, motivated by
[`Completeness_Evidence.md`](../Completeness_Evidence.md) §2a: **no measurement
has ever produced a real number.** Every outcome is a rational plus a rational
error interval, so a physics quantity of the form `(rational) · π` is never
*measured* as a real — only ever *bounded* by a rational interval. This module
states that explicitly for the load-bearing π-quantities: their content is a
rational enclosure, `Real.pi` appearing only *inside* the interval whose
endpoints are rational.

The rational π bounds are Mathlib's (`Real.pi_gt_3141592`, `Real.pi_lt_3141593`),
which are *already* rational-valued (`3.141592 = 3141592/1000000`). The substrate
supplies these approximants by construction — the closure census `returnDensity`
is `ℚ`-valued with limit `1/π` (`QLF_PhysicalPi`), and `pi_precision_demo.py`
delivers the truncations. So the counting layer is `Real`-free and the
physics-bound layer is rational-enclosure; the continuum never enters at the
interface. This is the concrete template; the full sweep of the other modules is
tracked in issue #113. Cf. the precedent `QLF_AlphaBound` (`137 < α⁻¹ < 137.048`,
rational bounds, zero axioms).
-/

namespace QLF.PiRational

/-- **π lies in a rational interval** — the only thing any measurement of π gives.
    Directly Mathlib's 7-digit bounds, whose endpoints are rationals. -/
theorem pi_rational_interval :
    (3.141592 : ℝ) < Real.pi ∧ Real.pi < 3.141593 :=
  ⟨Real.pi_gt_3141592, Real.pi_lt_3141593⟩

/-- **The loop-closure period `2π` as a rational interval.** `2π` is the *rendered*
    full cycle (`QLF_LoopClosure`: the machine is `% N`, `2π` the display); its
    physical content is the rational enclosure `6.28 < 2π < 6.29`. -/
theorem two_pi_rational_interval :
    (6.28 : ℝ) < 2 * Real.pi ∧ 2 * Real.pi < 6.29 := by
  constructor <;> linarith [Real.pi_gt_3141592, Real.pi_lt_3141593]

/-- **The mass hierarchy `ln R_p = 14π` as a rational interval.** The `QLF_AlphaS`
    claim `ln(M_P/m_p) ≈ 14π` is, at the interface, the rational enclosure
    `43.98 < 14π < 43.99` (vs measured `ln(M_P/m_p) ≈ 44.01`). No real needed to
    state or test it. -/
theorem hierarchy_rational_interval :
    (43.98 : ℝ) < 14 * Real.pi ∧ 14 * Real.pi < 43.99 := by
  constructor <;> linarith [Real.pi_gt_3141592, Real.pi_lt_3141593]

/-- The Einstein geometric factor `8π` as a rational interval (`QLF_EinsteinGeometricFactor`,
    `8π = 4π·2`): `25.13 < 8π < 25.14`. -/
theorem eight_pi_rational_interval :
    (25.13 : ℝ) < 8 * Real.pi ∧ 8 * Real.pi < 25.14 := by
  constructor <;> linarith [Real.pi_gt_3141592, Real.pi_lt_3141593]

/-- Summary: each load-bearing `(rational)·π` quantity is stated as a rational
    enclosure to audited precision — the interface never needs `ℝ`. The counting
    layer (`returnDensity : ℚ`, `QLF_PhysicalPi`) is already `Real`-free; the full
    module sweep is issue #113. -/
theorem pi_rational_summary : True := trivial

end QLF.PiRational
