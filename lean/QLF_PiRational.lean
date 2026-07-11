import Mathlib
import QLF_PhysicalPi

/-!
# QLF_PiRational — the substrate π-approximant is rational; the interface is `Real`-free (issue #113)

Motivated by [`Completeness_Evidence.md`](../Completeness_Evidence.md) §2a: **no
measurement has ever produced a real number.** Every outcome is a rational plus a
rational error interval, and the *rendering obligation is substrate → ℚ-with-intervals,
not substrate → ℝ*. This module makes the counting-layer half of that concrete and
machine-checked: the substrate's **own π-approximant is a rational by construction**,
carrying no `Real`.

The 2-D closure-walk return density `returnDensity n : ℚ` (`QLF_PhysicalPi`,
`returnDensity n = (C(2n,n)/4ⁿ)²`) is the substrate object whose sequence `1/(n·returnDensity n)`
converges to `π` (Wallis/Stirling, settled). It is `ℚ`-valued at every finite `n` — the
truncations `pi_precision_demo.py` delivers — so `π` never appears at the counting interface;
it enters only as the limit. Below: the concrete rational values, and the general fact that
*every* approximant is rational.

The complementary half — the load-bearing `(rational)·π` **physics bounds** (`14π`, `8π`,
`2π`) restated as rational enclosures to audited precision — is proven below via Mathlib's
current π-bounds `Real.pi_gt_d6`/`Real.pi_lt_d6` (`3.141592 < π < 3.141593`; the Lean 4.32
Mathlib renamed the decimal-named family to the `_dN` digit-count convention in
`Mathlib/Analysis/Real/Pi/Bounds.lean`). Each physics quantity is thus a rational interval,
`Real.pi` appearing only *inside* an enclosure with rational endpoints. Precedent for the
rational-bound style: `QLF_AlphaBound` (`137 < α⁻¹ < 137.048`, rational bounds, zero axioms).
-/

namespace QLF.PiRational

open QLF.PhysicalPi

/-- The substrate π-approximant at `n = 1` is the rational `1/4`
    (`returnDensity 1 = (C(2,1)/4)² = (2/4)² = 1/4`). No `Real`. -/
theorem returnDensity_one : returnDensity 1 = 1 / 4 := by native_decide

/-- At `n = 2`: `returnDensity 2 = (C(4,2)/4²)² = (6/16)² = 9/64`. -/
theorem returnDensity_two : returnDensity 2 = 9 / 64 := by native_decide

/-- At `n = 3`: `returnDensity 3 = (C(6,3)/4³)² = (20/64)² = 25/256`. -/
theorem returnDensity_three : returnDensity 3 = 25 / 256 := by native_decide

/-- **Every substrate π-approximant is rational** — the counting layer carries no `ℝ`.
    (Trivial by type: `returnDensity n : ℚ`; stated to make the `Real`-freedom explicit.) -/
theorem returnDensity_isRational (n : ℕ) : ∃ q : ℚ, returnDensity n = q :=
  ⟨returnDensity n, rfl⟩

/-! ### The physics-bound half — `(rational)·π` quantities as rational enclosures -/

/-- **π lies in a rational interval** — the only thing any measurement of π gives.
    Directly Mathlib's `_d6` bounds, whose endpoints are rationals. -/
theorem pi_rational_interval :
    (3.141592 : ℝ) < Real.pi ∧ Real.pi < 3.141593 :=
  ⟨Real.pi_gt_d6, Real.pi_lt_d6⟩

/-- **The loop-closure period `2π` as a rational interval** (`QLF_LoopClosure`: the
    machine is `% N`, `2π` the rendered full cycle): `6.283 < 2π < 6.284`. -/
theorem two_pi_rational_interval :
    (6.283 : ℝ) < 2 * Real.pi ∧ 2 * Real.pi < 6.284 := by
  constructor <;> linarith [Real.pi_gt_d6, Real.pi_lt_d6]

/-- **The mass hierarchy `ln R_p = 14π` as a rational interval** (`QLF_AlphaS`):
    `43.982 < 14π < 43.983` (vs measured `ln(M_P/m_p) ≈ 44.01`). No `Real` needed to
    state or test the claim. -/
theorem hierarchy_rational_interval :
    (43.982 : ℝ) < 14 * Real.pi ∧ 14 * Real.pi < 43.983 := by
  constructor <;> linarith [Real.pi_gt_d6, Real.pi_lt_d6]

/-- **The Einstein geometric factor `8π` as a rational interval**
    (`QLF_EinsteinGeometricFactor`, `8π = 4π·2`): `25.132 < 8π < 25.133`. -/
theorem eight_pi_rational_interval :
    (25.132 : ℝ) < 8 * Real.pi ∧ 8 * Real.pi < 25.133 := by
  constructor <;> linarith [Real.pi_gt_d6, Real.pi_lt_d6]

/-- Summary: the substrate's π-approximants are concrete rationals, `Real`-free (`π`
    enters only as their settled limit), and every load-bearing `(rational)·π` physics
    quantity is a rational enclosure to audited precision — the interface never needs `ℝ`.
    Both halves of issue #113 are now anchored. -/
theorem pi_rational_summary : True := trivial

end QLF.PiRational
