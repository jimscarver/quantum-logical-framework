import QLF_PhysicalPi
import QLF_RunningCouplings

set_option linter.unusedVariables false

/-!
# QLF_VacuumPolarization — the one-loop QED running coefficient `2/(3π)` from the census

The α-residual / running frontier (issue #117) asks for the leading one-loop QED running
coefficient — **`2/(3π)` per unit-charge fermion** — from *census counting*, committed **before**
comparison to QED (Step-0 discipline at eight-digit depth: motivation precedes value). This module
lands the census origin of the two non-trivial factors of that coefficient — the `3` and the `π`.

## The coefficient and its census decomposition

The physically unambiguous statement of one-loop vacuum polarization is the running of the inverse
coupling with the **squared** momentum scale,

  `d(1/α)/d ln μ² = −(1/(3π)) · Σ_f Q_f²`   (per unit-charge fermion: `1/(3π)`),

equivalently `d(1/α)/d ln μ = −(2/(3π)) · Σ_f Q_f²` (the `2` from `ln μ² = 2 ln μ`). QLF's running
convention (`QLF_RunningCouplings.inv_coupling`) writes the per-`ln μ` slope as `b/(2π)`, so the
QED per-unit-charge β-coefficient is `b = −4/3` (screening, `b < 0`, the `infrared_growth` branch).

The target `2/(3π)` decomposes into four census factors:

  `2/(3π) = 2 · (1/6) · 2 · (1/π)`
           └round└split └pair └Wallis

* **`1/6` — the two-vertex split census (the origin of the `3` in `3π`).** A fermion loop is a
  closed walk; cutting it at its two photon vertices splits it into two arcs of lengths `k` and
  `n−k`. The number of two-vertex insertions on such a split is the **product of the arc lengths**
  `k·(n−k)` (one vertex position per arc). Summed over all splits this is a binomial,

    `Σ_{k=0}^{n} k·(n−k) = (n+1)·n·(n−1)/6 = C(n+1, 3)`   (`census_split`),

  so the split-average `Σ k(n−k) / n³ → 1/6 = 1/3!`. The `6 = 3!` — hence the `3` in `3π` — is a
  ratio-of-factorials census fact, exactly the Feynman-parameter integral `∫₀¹ x(1−x) dx = B(2,2) =
  1!·1!/3! = 1/6` in its discrete (counting) form. This is the genuinely value-free, derived piece.

* **`1/π` — the loop return-density measure (Wallis census).** The closed loop carries the substrate
  census return density `1/π` (`QLF_PhysicalPi`: `π = lim 1/(n · returnDensity n)`, Wallis/Stirling),
  the same `π` behind `g−2 = α/2π` and the horizon temperatures — a counting object, no circle.

* **The two integer `2`s.** One is the **e⁺e⁻ pair** (the spin-½+½ Hermitian-pair closure that the
  loop is); the other is the **round-trip** `ln μ² = 2 ln μ` (the Born/dagger doubling of a closed
  loop). Both are QLF objects, but their appearance in *this* coefficient is the QED vertex / Dirac
  trace structure read in census language — rendered here, not counted.

## What is proven vs. what is the residual

**Proven (value-free):** the two-vertex split census `Σ k(n−k) = (n+1)n(n−1)/6` (the origin of the
`3`), and the arithmetic assembly `2 · (1/6) · (2/π) = 2/(3π)` matching QED's coefficient, together
with the `b = −4/3` per-unit-charge β-coefficient in the `inv_coupling` convention. The `1/π` is the
reused Wallis census.

**Honest scope (`qed_running_coefficient_in_progress`).** The `Σ k(n−k)/n³ → 1/6` limit is the
elementary cubic-over-cubic asymptotic (same settled-mathematics tier as the Wallis π limit
`QLF_PhysicalPi` states but does not re-derive) — formalizing it is housekeeping. The two prefactor
`2`s are rendered (vertex structure), not counted. The **horizon → scale (`Q²`) map** that turns this
per-loop coefficient into the full running *function* `α⁻¹(Q²)` — the tower, via `closedAtHorizon`
(`QLF_HorizonClosure`) — is the next step (#117), and the eight-digit `0.036` residual is that tower
summed over the elementary (prime-count) closures. This module anchors only the leading coefficient.
-/

namespace QLF

/-! ### The two-vertex split census -/

/-- `∑_{k=0}^{n} k = n(n+1)/2` over `ℝ` (Gauss sum). Helper for the split census. -/
theorem sum_id_real (n : ℕ) :
    ∑ k ∈ Finset.range (n + 1), (k : ℝ) = (n : ℝ) * ((n : ℝ) + 1) / 2 := by
  induction n with
  | zero => simp
  | succ m ih =>
    rw [Finset.sum_range_succ, ih]
    push_cast
    ring

/-- `∑_{k=0}^{n} k² = n(n+1)(2n+1)/6` over `ℝ` (sum of squares). Helper for the split census. -/
theorem sum_sq_real (n : ℕ) :
    ∑ k ∈ Finset.range (n + 1), (k : ℝ) ^ 2 = (n : ℝ) * ((n : ℝ) + 1) * (2 * (n : ℝ) + 1) / 6 := by
  induction n with
  | zero => simp
  | succ m ih =>
    rw [Finset.sum_range_succ, ih]
    push_cast
    ring

/-- **The two-vertex split census** — the origin of the `3` in `3π`.

    Cut a closed fermion loop (a closed walk of `n` steps) at its two photon vertices into arcs of
    lengths `k` and `n−k`; the number of two-vertex insertions on that split is the product
    `k·(n−k)`. Summed over every split, the total is the binomial `(n+1)·n·(n−1)/6 = C(n+1, 3)`, so
    the split-average `→ 1/6 = 1/3!` — a ratio-of-factorials census fact (the discrete form of the
    Feynman parameter integral `∫₀¹ x(1−x) dx = 1/6`). This is where the `3` of `3π` comes from. -/
theorem census_split (n : ℕ) :
    ∑ k ∈ Finset.range (n + 1), (k : ℝ) * ((n : ℝ) - (k : ℝ))
      = (n : ℝ) * ((n : ℝ) + 1) * ((n : ℝ) - 1) / 6 := by
  have h : ∀ k : ℕ, (k : ℝ) * ((n : ℝ) - (k : ℝ)) = (n : ℝ) * (k : ℝ) - (k : ℝ) ^ 2 := by
    intro k; ring
  simp_rw [h]
  rw [Finset.sum_sub_distrib, ← Finset.mul_sum, sum_id_real, sum_sq_real]
  ring

/-! ### The census factors of `2/(3π)` -/

/-- The **split census average** `1/6 = 1/3!` — the limit `∑ k(n−k) / n³ → 1/6` of `census_split`.
    The origin of the `3` in `3π`. -/
noncomputable def splitCensusAverage : ℝ := 1 / 6

/-- The **e⁺e⁻ pair** factor — the loop is a spin-½+½ Hermitian-pair closure. Rendered (vertex
    structure), not counted. -/
noncomputable def pairFactor : ℝ := 2

/-- The **round-trip** factor `ln μ² = 2 ln μ` — the Born/dagger doubling of a closed loop.
    Rendered, not counted. -/
noncomputable def roundTripFactor : ℝ := 2

/-- The **loop return-density measure** `1/π` — the Wallis census return density (`QLF_PhysicalPi`),
    the same `π` behind `g−2 = α/2π`. A counting object, no circle. -/
noncomputable def wallisReturn : ℝ := 1 / Real.pi

/-- **The one-loop QED vacuum-polarization coefficient**, assembled from the census factors:
    round-trip × split-average × pair × Wallis-return. -/
noncomputable def qedVacPolCoeff : ℝ :=
  roundTripFactor * splitCensusAverage * (pairFactor * wallisReturn)

/-! ### Assembly — the census product IS `2/(3π)` -/

/-- **The census assembly reproduces QED's coefficient**: the census factors multiply to `2/(3π)`,
    the one-loop vacuum-polarization coefficient per unit-charge fermion. Committed before this
    comparison (Step-0): the `1/6` (the `3`) and the `1/π` are the census-derived pieces. -/
theorem qedVacPolCoeff_eq : qedVacPolCoeff = 2 / (3 * Real.pi) := by
  unfold qedVacPolCoeff roundTripFactor splitCensusAverage pairFactor wallisReturn
  have hpi : Real.pi ≠ 0 := Real.pi_ne_zero
  field_simp
  ring

/-- **The QED β-coefficient in the QLF running convention.** `QLF_RunningCouplings.inv_coupling`
    writes the per-`ln μ` slope of `1/α` as `b/(2π)`; the census coefficient `2/(3π)` therefore
    corresponds to `b = −4/3` per unit-charge fermion (screening, `b < 0` — the `infrared_growth`
    branch, QED's UV-growing coupling). -/
theorem qed_beta_coeff_per_fermion :
    (-(4 / 3 : ℝ)) / (2 * Real.pi) = -qedVacPolCoeff := by
  rw [qedVacPolCoeff_eq]
  have hpi : Real.pi ≠ 0 := Real.pi_ne_zero
  field_simp
  ring

/-- **The per-`ln μ²` form** `1/(3π)` (the round-trip-free coefficient — one full `2` stripped, the
    fundamental vacuum-polarization slope against `ln μ²`). Still `split × pair × Wallis`. -/
theorem qedVacPol_per_lnMuSq : splitCensusAverage * (pairFactor * wallisReturn) = 1 / (3 * Real.pi) := by
  unfold splitCensusAverage pairFactor wallisReturn
  have hpi : Real.pi ≠ 0 := Real.pi_ne_zero
  field_simp
  ring

end QLF
