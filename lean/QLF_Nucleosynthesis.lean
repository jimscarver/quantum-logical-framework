import Mathlib.Analysis.SpecialFunctions.Log.Basic

set_option linter.unusedVariables false

/-!
# QLF_Nucleosynthesis — the primordial helium fraction from the n/p ratio

Big-Bang nucleosynthesis turns the early plasma into ~75% hydrogen and ~25% helium-4 by mass.
The **helium mass fraction** `Y_p` is fixed almost entirely by the **neutron-to-proton ratio**
`r = n/p` at weak freeze-out: essentially every surviving neutron ends up bound in the deepest
light closure, **⁴He** (the doubly-magic `Z=N=2` nucleus, `Magic_numbers.md`), so

  `Y_p = 2n/(n+p) = 2r/(1+r)`   (`helium_fraction`).

With the standard freeze-out ratio `r ≈ 1/7`, this gives `Y_p = 1/4` (`helium_fraction_one_seventh`)
— matching the observed `Y_p ≈ 0.247`. The counterfactual `r = 1` (equal neutrons and protons)
would give `Y_p = 1` — all helium, no hydrogen (`helium_fraction_equal_np`) — so the observed
quarter-helium universe *requires* the small freeze-out `r`.

## Honest scope

This anchors the **`Y_p = 2r/(1+r)` funnel** (every neutron → ⁴He, the deepest light closure) and
that `r ≈ 1/7 ⟹ Y_p ≈ 1/4`. It does **not** derive `r` itself — the freeze-out ratio is set by the
neutron–proton mass difference and the weak rates (`G_F`), both open in QLF (`Weak_Force.md` §5e,
§6) exactly as the absolute scale is. Nor does it derive the deuterium / ⁷Li abundances or the
**CMB power spectrum** (acoustic peaks) — those need the full thermal history
(`nucleosynthesis_in_progress`). See `Fusion.md`.
-/

namespace QLF

/-- **Primordial helium-4 mass fraction** from the neutron-to-proton ratio `r = n/p` at
    freeze-out: `Y_p = 2r/(1+r)` (every surviving neutron is bound into ⁴He). -/
noncomputable def helium_fraction (r : ℝ) : ℝ := 2 * r / (1 + r)

/-- **`r = 1/7 ⟹ Y_p = 1/4`** — the standard freeze-out ratio gives the observed quarter-helium
    universe (`Y_p ≈ 0.247`). -/
theorem helium_fraction_one_seventh : helium_fraction (1 / 7) = 1 / 4 := by
  unfold helium_fraction
  norm_num

/-- **Counterfactual**: equal neutrons and protons (`r = 1`) would give `Y_p = 1` — all helium,
    no hydrogen. The observed quarter-helium universe requires the small freeze-out `r`. -/
theorem helium_fraction_equal_np : helium_fraction 1 = 1 := by
  unfold helium_fraction
  norm_num

/-- **Established constructively:** the helium funnel `Y_p = 2r/(1+r)` (neutrons → the deepest
    light closure ⁴He) gives the observed `Y_p ≈ 1/4` from the freeze-out ratio `r ≈ 1/7`
    (`helium_fraction_one_seventh`). **Open:** `r` itself (needs the n–p splitting + weak rates
    `G_F`), the D/⁷Li abundances, and the CMB power spectrum (`nucleosynthesis_in_progress`). -/
theorem nucleosynthesis_in_progress : True := trivial

end QLF
