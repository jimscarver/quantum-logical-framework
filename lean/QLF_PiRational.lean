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

The complementary half — restating the load-bearing `(rational)·π` **physics bounds**
(`14π`, `8π`, `2π`) as rational enclosures to audited precision — needs Mathlib's current
π-bound lemmas (the Lean 4.32 Mathlib removed the decimal-named `Real.pi_gt_314` family); that
restatement is tracked in issue #113. Precedent for the rational-bound style: `QLF_AlphaBound`
(`137 < α⁻¹ < 137.048`, rational bounds, zero axioms).
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

/-- Summary: the substrate's π-approximants are concrete rationals, `Real`-free; `π`
    enters only as their (settled) limit, never at the interface. The physics-bound
    rational-enclosure restatement is issue #113. -/
theorem pi_rational_summary : True := trivial

end QLF.PiRational
