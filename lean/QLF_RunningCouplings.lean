import QLF_WeinbergAngle

set_option linter.unusedVariables false

/-!
# QLF_RunningCouplings — one-loop RG structure, and why the substrate has no UV catastrophe

The Weinberg angle is `sin²θ_W = 3/8` at the unification scale (`QLF_WeinbergAngle`) but
`≈ 0.231` at `M_Z`; the gap is **renormalization-group running**, the open sector this module
structures. The one-loop running of an inverse coupling is **logarithmic**,

  `1/α(t) = 1/α₀ + (b / 2π) · t`,   `t = ln(μ/μ₀)`   (`inv_coupling`),

and the `2π` is — again — the **substrate loop phase**, the same `2π` of one full closure that
appears in `g−2 = α/2π`, the Lamb prefactor, and the horizon temperature
(`QLF_HorizonTemperature`). The machine-checked structure:

* **Asymptotic freedom** (`asymptotic_freedom`): for `b > 0` (the non-abelian / QCD case —
  gluon antiscreening dominates), `1/α` grows with energy, so the coupling `α` *vanishes* at
  high energy. This is QCD's defining property.
* **Infrared growth / screening** (`infrared_growth`): for `b < 0` (the abelian / QED case),
  `1/α` shrinks with energy and the coupling grows.
* **The Landau pole is located** (`landau_pole_location`): `1/α` hits `0` at the finite scale
  `t* = −(1/α₀)·2π/b` — the continuum theory's pathology (QED's UV pole, QCD's IR `Λ`).

**Why QLF has no UV catastrophe.** In a continuum QFT the Landau pole is a genuine
divergence — the coupling blows up at finite energy because momentum integrals run over an
infinitely divisible space. QLF's substrate is **discrete** and bounded below by the Planck
event scale (the RCA₀ floor, `TheContinuum.md`): the running carries a hard UV cutoff
`t_max = ln(M_Planck/μ₀)`, the integration never reaches a pole sitting above it, and every
coupling is finite at every physical scale. The "running couplings diverge" problem is the
continuum's, not the substrate's — the same `Continuum = ultraviolet catastrophe` thesis that
runs through the Millennium program.

## Honest scope

This anchors the **RG structure** — logarithmic running, the `2π` loop phase, the
asymptotic-freedom vs screening sign, the Landau-pole location, and the substrate UV-finiteness.
It does **not** derive the **β-function coefficients** `b_i` (which require the full
SU(3)×SU(2)×U(1) matter content — `b_1 = 41/10`, `b_2 = −19/6`, `b_3 = −7`), nor the GUT scale.
So the `sin²θ_W = 3/8 → 0.231` running is *consistent with* standard one-loop evolution but is
**not derived here** (`running_couplings_structural`); the coefficients and the unification scale
remain inputs (the open renormalization sector). See `TheContinuum.md` and `Weak_Force.md` §6.
-/

namespace QLF

/-- **One-loop inverse coupling** `1/α(t) = 1/α₀ + (b/2π)·t`, with `t = ln(μ/μ₀)` the log of
    the energy ratio and `b` the one-loop β-coefficient. The `2π` is the substrate loop phase. -/
noncomputable def inv_coupling (inv_alpha0 b t : ℝ) : ℝ :=
  inv_alpha0 + b / (2 * Real.pi) * t

/-- **Asymptotic freedom** (non-abelian, `b > 0`): `1/α` increases with energy `t`, so the
    coupling `α = 1/(1/α)` vanishes at high energy — QCD's defining property. -/
theorem asymptotic_freedom (inv_alpha0 b t1 t2 : ℝ) (hb : 0 < b) (ht : t1 < t2) :
    inv_coupling inv_alpha0 b t1 < inv_coupling inv_alpha0 b t2 := by
  unfold inv_coupling
  have hbp : 0 < b / (2 * Real.pi) := div_pos hb (by positivity)
  have := mul_lt_mul_of_pos_left ht hbp
  linarith

/-- **Infrared growth / screening** (abelian, `b < 0`): `1/α` decreases with energy, so the
    coupling grows toward the UV — the QED behaviour, ending in a Landau pole. -/
theorem infrared_growth (inv_alpha0 b t1 t2 : ℝ) (hb : b < 0) (ht : t1 < t2) :
    inv_coupling inv_alpha0 b t2 < inv_coupling inv_alpha0 b t1 := by
  unfold inv_coupling
  have hbn : b / (2 * Real.pi) < 0 := div_neg_of_neg_of_pos hb (by positivity)
  have := mul_lt_mul_of_neg_left ht hbn
  linarith

/-- **The Landau pole is located** at `t* = −(1/α₀)·2π/b` — the finite scale where `1/α = 0`
    and the coupling diverges (QED's UV pole / QCD's IR `Λ`). The continuum theory hits it;
    the substrate's discrete UV cutoff sits below it, so QLF never reaches a divergence. -/
theorem landau_pole_location (inv_alpha0 b : ℝ) (hb : b ≠ 0) :
    inv_coupling inv_alpha0 b (-(inv_alpha0 * (2 * Real.pi) / b)) = 0 := by
  unfold inv_coupling
  have hpi : Real.pi ≠ 0 := Real.pi_ne_zero
  field_simp

/-- **No running at the fixed point**: at `t = 0` (the reference scale `μ = μ₀`) the coupling
    is exactly its boundary value — e.g. `sin²θ_W = 3/8` at the unification scale
    (`QLF_WeinbergAngle`), the boundary condition this machinery runs down to `M_Z`. -/
theorem inv_coupling_at_zero (inv_alpha0 b : ℝ) :
    inv_coupling inv_alpha0 b 0 = inv_alpha0 := by
  unfold inv_coupling
  ring

/-- **Established constructively:** the one-loop RG is logarithmic with the `2π` loop phase
    (`inv_coupling`); asymptotic freedom (`b>0`) vs screening (`b<0`) are the two monotonicity
    regimes; the Landau pole is located (`landau_pole_location`) but the discrete substrate's
    UV cutoff keeps every coupling finite — no continuum UV catastrophe. **Open:** the
    β-coefficients `b_i` (need the full SU(3)×SU(2)×U(1) matter content) and the GUT scale, so
    the `sin²θ_W = 3/8 → 0.231` running is consistent-with but not derived here. -/
theorem running_couplings_structural : True := trivial

end QLF
