/-
QLF_Koide.lean — the Koide invariant Q = 2/3 from the closure structure.

The empirical Koide relation among the charged-lepton masses,

    Q = (m_e + m_μ + m_τ) / (√m_e + √m_μ + √m_τ)²  =  2/3   (to 0.0009%),

is exactly equivalent to writing the three √-masses as three balanced phases of
a common amplitude:  √m_k = M(1 + A·c_k),  k = 0,1,2, where the c_k carry the
three-fold 120° structure (Σc_k = 0, Σc_k² = 3/2) and A is the amplitude.

A short algebraic fact (proved below) is that for THIS structure

    Q = (1 + A²/2) / N,            (N = number of balanced phases),

so Q = 2/3 is forced by exactly two inputs:
    N = 3          — three generations  (QLF: the three spatial axes), and
    A² = 2         — amplitude √2       (QLF: the TWO transverse axes; the one
                                          longitudinal axis is the common "1").

That is the QLF derivation of Koide's 2/3: it is the `2 transverse + 1
longitudinal` axis split over `3` axes — the SAME split that gives the
transverse fraction 2/3 in the Lamb prefactor and the photon polarization sum.

SCOPE: this module machine-verifies the algebra (3·Σs² = 2·(Σs)², i.e. Q = 2/3,
from `r² = 2 ∧ Σc = 0 ∧ Σc² = 3/2`). The remaining PHYSICAL input is the
identification of the lepton √-mass vector with this `1 longitudinal + 2
transverse`, three-axis-phase structure; the Koide angle and overall scale stay
inputs. See Weak_Force.md §5b.
-/

import Mathlib.Data.Real.Basic
import Mathlib.Tactic.LinearCombination

namespace QLF

/-- **Koide identity from three balanced phases of amplitude √2.**
    With `sₖ = M(1 + r cₖ)` (the √-masses), `r² = 2` (amplitude √2 — the two
    transverse axes), and the three-fold balanced-phase structure
    `Σcₖ = 0`, `Σcₖ² = 3/2` (three axes 120° apart), the Koide combination
    satisfies `3·Σsₖ² = 2·(Σsₖ)²` — independent of the scale `M` and the
    overall phase. This is the algebraic content of `Q = 2/3`. -/
theorem koide_three_phase (M r c0 c1 c2 : ℝ)
    (hr : r ^ 2 = 2) (hsum : c0 + c1 + c2 = 0) (hsq : c0 ^ 2 + c1 ^ 2 + c2 ^ 2 = 3 / 2) :
    3 * ((M * (1 + r * c0)) ^ 2 + (M * (1 + r * c1)) ^ 2 + (M * (1 + r * c2)) ^ 2)
      = 2 * ((M * (1 + r * c0)) + (M * (1 + r * c1)) + (M * (1 + r * c2))) ^ 2 := by
  linear_combination (M ^ 2 * (-6 * r - 2 * r ^ 2 * (c0 + c1 + c2))) * hsum
    + (3 * M ^ 2 * r ^ 2) * hsq + (9 / 2 * M ^ 2) * hr

/-- **Q = 2/3.** Dividing the identity by `(Σsₖ)² ≠ 0`, the Koide ratio is
    exactly `2/3` — forced by `N = 3` (three axes) and `A² = 2` (two transverse
    axes). -/
theorem koide_two_thirds (M r c0 c1 c2 : ℝ)
    (hr : r ^ 2 = 2) (hsum : c0 + c1 + c2 = 0) (hsq : c0 ^ 2 + c1 ^ 2 + c2 ^ 2 = 3 / 2)
    (hS : (M * (1 + r * c0)) + (M * (1 + r * c1)) + (M * (1 + r * c2)) ≠ 0) :
    ((M * (1 + r * c0)) ^ 2 + (M * (1 + r * c1)) ^ 2 + (M * (1 + r * c2)) ^ 2)
      / ((M * (1 + r * c0)) + (M * (1 + r * c1)) + (M * (1 + r * c2))) ^ 2 = 2 / 3 := by
  rw [div_eq_iff (pow_ne_zero 2 hS)]
  linear_combination (1 / 3 : ℝ) * koide_three_phase M r c0 c1 c2 hr hsum hsq

/-- The three-fold balanced-phase hypotheses are satisfiable (non-vacuous):
    the `δ = 0` representative `(c₀,c₁,c₂) = (1, −1/2, −1/2)` (the `cos(2πk/3)`
    values) has `Σc = 0` and `Σc² = 3/2`. -/
theorem koide_phase_witness :
    (1 : ℝ) + (-1 / 2) + (-1 / 2) = 0 ∧ (1 : ℝ) ^ 2 + (-1 / 2) ^ 2 + (-1 / 2) ^ 2 = 3 / 2 := by
  norm_num

end QLF
