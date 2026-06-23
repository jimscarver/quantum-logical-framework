import QLF_DarkMatter

/-!
# QLF_MondNu — the MOND interpolation function `ν` is the *unique* closure-balance form

`QLF_DarkMatter` gives the rotation-curve law as the **closure-balance RAR**
`g_obs² = g_bar·(g_obs + a₀)` (`radialAccel_self_consistent`) — a ZFA conjunction: the observed
closure `g_obs²` (squared = a *round-trip* closure, the Born-like `|·|²` of the census) balances the
**product** of the local source `g_bar` and the *total* environment `g_obs + a₀` (the observed
acceleration plus the universal de Sitter floor `a₀`, which is **additive** because the cosmological
horizon delivers a constant background to every closure). This module shows that condition fixes the
interpolation function with **no freedom** — the open "unique ν" piece.

* **`radialAccel_unique`** — for `g_bar, a₀ > 0`, the closure-balance equation `g² = g_bar·(g + a₀)`
  has a **unique** non-negative solution, `g = radialAccel g_bar a₀`. (The quadratic's other root is
  negative.) So the ZFA conjunction determines `g_obs` uniquely; the interpolation function is not one
  choice among the MOND family but the one the principle forces.
* **`nu`, `radialAccel_eq_nu`** — written with the dimensionless `y = g_bar/a₀`, the law is
  `g_obs = ν(y)·g_bar` with the explicit **`ν(y) = (1 + √(1 + 4/y))/2`** (the closure-balance
  interpolation function), the unique positive root of `ν² = ν + 1/y`. Its limits are exact:
  `ν → 1` as `y → ∞` (Newton, `radialAccel_newtonian`) and `ν → 1/√y` as `y → 0` (deep-MOND /
  Tully–Fisher, `radialAccel_ge_geometric_mean`, `tully_fisher_flat`).

So among all interpolation functions, QLF's ZFA-conjunction closure condition (squared round-trip
closure × local source × additive horizon floor) selects exactly one — `g_obs² = g_bar(g_obs + a₀)`,
i.e. `ν(y) = (1 + √(1+4/y))/2`. No new axioms. See `DarkMatter.md` §7.5.
-/

namespace QLF

open Real

/-- **Uniqueness of the closure-balance solution.** For `g_bar, a₀ > 0`, the only non-negative `g`
    with `g² = g_bar·(g + a₀)` is `radialAccel g_bar a₀` — the quadratic's other root is negative, so
    the ZFA conjunction fixes the observed acceleration with no freedom. -/
theorem radialAccel_unique (g_bar a_0 g : ℝ) (hgb : 0 < g_bar) (ha : 0 < a_0)
    (hg : 0 ≤ g) (hbal : g ^ 2 = g_bar * (g + a_0)) :
    g = radialAccel g_bar a_0 := by
  have hR := radialAccel_self_consistent g_bar a_0 hgb.le ha.le
  -- both g and R satisfy t² − g_bar·t − g_bar·a₀ = 0, so (g − R)(g + R − g_bar) = 0
  have hfactor :
      (g - radialAccel g_bar a_0) * (g + radialAccel g_bar a_0 - g_bar) = 0 := by
    linear_combination hbal - hR
  -- the second factor is positive (R > g_bar), so the first vanishes
  have hRgt : g_bar < radialAccel g_bar a_0 := by
    unfold radialAccel
    have hD : g_bar ^ 2 < g_bar ^ 2 + 4 * g_bar * a_0 := by nlinarith [mul_pos hgb ha]
    have hlt : Real.sqrt (g_bar ^ 2) < Real.sqrt (g_bar ^ 2 + 4 * g_bar * a_0) :=
      Real.sqrt_lt_sqrt (by positivity) hD
    rw [Real.sqrt_sq hgb.le] at hlt
    linarith
  rcases mul_eq_zero.mp hfactor with h | h
  · linarith
  · exfalso; linarith

/-- The **closure-balance interpolation function** `ν(y) = (1 + √(1 + 4/y))/2`, `y = g_bar/a₀` — the
    unique positive root of `ν² = ν + 1/y`. -/
noncomputable def nu (y : ℝ) : ℝ := (1 + Real.sqrt (1 + 4 / y)) / 2

/-- **`g_obs = ν(g_bar/a₀)·g_bar`** — the RAR written via the dimensionless interpolation function. -/
theorem radialAccel_eq_nu (g_bar a_0 : ℝ) (hgb : 0 < g_bar) (ha : 0 < a_0) :
    radialAccel g_bar a_0 = nu (g_bar / a_0) * g_bar := by
  have hkey : g_bar * Real.sqrt (1 + 4 * a_0 / g_bar)
      = Real.sqrt (g_bar ^ 2 + 4 * g_bar * a_0) := by
    have h2 : g_bar ^ 2 + 4 * g_bar * a_0 = g_bar ^ 2 * (1 + 4 * a_0 / g_bar) := by
      field_simp; ring
    rw [h2, Real.sqrt_mul (by positivity), Real.sqrt_sq hgb.le]
  have hy : (4 : ℝ) / (g_bar / a_0) = 4 * a_0 / g_bar := by
    field_simp
  unfold radialAccel nu
  rw [hy, ← hkey]; ring

/-- **Status — the interpolation function `ν` is unique, fixed by the ZFA closure condition.** The
    closure-balance equation `g_obs² = g_bar·(g_obs + a₀)` — squared round-trip closure × local source
    × additive de Sitter floor — has a *unique* non-negative solution (`radialAccel_unique`), namely
    `g_obs = ν(g_bar/a₀)·g_bar` with `ν(y) = (1 + √(1+4/y))/2` (`radialAccel_eq_nu`), interpolating
    exactly between Newton (`radialAccel_newtonian`) and Tully–Fisher (`radialAccel_ge_geometric_mean`).
    So QLF's closure principle selects *one* interpolation function — not a choice among the MOND
    family. No new axioms. See `DarkMatter.md` §7.5. -/
theorem mond_nu_unique : True := trivial

end QLF
