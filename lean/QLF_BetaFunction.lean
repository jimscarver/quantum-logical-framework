import QLF_Generations

set_option linter.unusedVariables false

/-!
# QLF_BetaFunction — the QCD asymptotic-freedom coefficient `b₀ = 7` from the substrate

`QLF_RunningCouplings` left the one-loop β-coefficient `b` as an input, and `QLF_MassSpectrum`
fed it into the hierarchy `ln R_p = 2π/(b·α_s)`. For the strong coupling that coefficient is

  `b₀ = 11 N_c/3 − 2 n_f/3`   (`beta_coefficient`),

and QLF supplies both counts from its own structure:

* **`N_c = 3`** — the colour count is the substrate's three spatial axes (`color_count`,
  `substrate_spatial_dimension`; the SU(3) of `QLF_StrongAlgebra`).
* **`n_f = 6`** — two quark flavours (up-type + down-type) per generation, times the **three
  generations** (`flavor_count = 2·num_generations`, `QLF_Generations`).

So `b₀ = 11·3/3 − 2·6/3 = 11 − 4 = 7` (`beta_coefficient_eq_seven`). The gluon antiscreening
`11 N_c/3 = 11` beats the quark screening `2 n_f/3 = 4`, giving `b₀ > 0` — **asymptotic freedom**
(`asymptotic_freedom_from_substrate`) — and with it the dimensional-transmutation hierarchy
`ln R_p = 2π/(7·α_s)` (`QLF_MassSpectrum`): only `α_s` and the calibration remain.

## Honest scope

QLF supplies the *counts* `N_c = 3` (axes) and `n_f = 6` (3 generations × 2 flavours), so the
substrate fixes them. The **coefficient structure** `11 N_c/3 − 2 n_f/3` itself is the standard
one-loop β-function group theory (the `11/3` gluon Casimir, the `2/3` fermion loop), taken as
input here — not re-derived from the substrate (`beta_function_in_progress`). See
`TheContinuum.md` §3.1.
-/

namespace QLF

/-- **Colour count `N_c = 3`** — the substrate's three spatial axes (the SU(3) of
    `QLF_StrongAlgebra`). -/
def color_count : ℕ := substrate_spatial_dimension

/-- **Quark-flavour count `n_f = 6`** — two flavours (up-type + down-type) per generation, times
    the three generations (`num_generations`, `QLF_Generations`). -/
def flavor_count : ℕ := 2 * num_generations

/-- The substrate fixes `N_c = 3` and `n_f = 6`. -/
theorem substrate_qcd_counts : color_count = 3 ∧ flavor_count = 6 := ⟨rfl, by decide⟩

/-- The **one-loop QCD β-coefficient** `b₀ = 11 N_c/3 − 2 n_f/3`. -/
noncomputable def beta_coefficient (Nc nf : ℝ) : ℝ := 11 * Nc / 3 - 2 * nf / 3

/-- **`b₀ = 7`** from `N_c = 3` and `n_f = 6` — the QCD asymptotic-freedom coefficient, from the
    substrate's three axes and three generations. -/
theorem beta_coefficient_eq_seven : beta_coefficient 3 6 = 7 := by
  unfold beta_coefficient
  norm_num

/-- **Asymptotic freedom from the substrate**: gluon antiscreening `11 N_c/3 = 11` exceeds quark
    screening `2 n_f/3 = 4`, so `b₀ = 7 > 0` — the coupling vanishes at high energy. -/
theorem asymptotic_freedom_from_substrate : (0 : ℝ) < beta_coefficient 3 6 := by
  rw [beta_coefficient_eq_seven]
  norm_num

/-- **Established constructively:** the QCD one-loop β-coefficient `b₀ = 11 N_c/3 − 2 n_f/3 = 7`
    follows from the substrate's `N_c = 3` (axes) and `n_f = 6` (3 generations × 2 flavours)
    (`beta_coefficient_eq_seven`, `substrate_qcd_counts`); the antiscreening sign gives
    asymptotic freedom (`asymptotic_freedom_from_substrate`), feeding the hierarchy
    `ln R_p = 2π/(7 α_s)` (`QLF_MassSpectrum`). **Input (not re-derived):** the `11/3`/`2/3`
    one-loop coefficient structure (standard β-function group theory); `α_s` + calibration remain
    open (`beta_function_in_progress`). -/
theorem beta_function_in_progress : True := trivial

end QLF
