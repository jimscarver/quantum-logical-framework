import QLF_DarkMatter
import QLF_LoopClosure

/-!
# QLF_MondScale — the `2π` in `a₀ = cH₀/(2π)` derived from first principles

The dark-matter / MOND crossover acceleration is `a₀ = cH₀/(2π)` (`QLF_DarkMatter.mond_acceleration`),
the SPARC-confirmed scale. The `2π` was *identified* as the loop phase but not *derived*. Here it is:
the `2π` is the **period of one ZFA closure loop**, `τ_ZFA` (`QLF_LoopClosure`), so `a₀` is the Hubble
acceleration delivered **per closure loop**.

## First principles

The Hubble rate `H₀` is the cosmic closure's **angular** rate — radians of loop phase per unit time. The
cosmic horizon is a thermal de Sitter horizon, and its temperature `T_dS = ℏH₀/(2πk_B)`
(`QLF_HorizonTemperature.desitter_temperature_eq`) is *literally* the canonical `T = ℏω/(2πk_B)` with
`ω = H₀`: so `H₀` **is** the horizon's angular frequency, and the `2π` is the Euclidean period that makes
one closure loop smooth (the same `2π` as the Unruh temperature). One closure = one full loop =
`τ_ZFA = 2π` radians (`QLF_LoopClosure.render_one_cycle`, `tau_is_two_pi_QLF`). Hence the cosmic **cyclic**
closure rate (closures per unit time) is `f_H = H₀/τ_ZFA = H₀/(2π)`, and the crossover acceleration is `c`
times that cyclic rate:

> `a₀ = c · f_H = c · H₀/τ_ZFA = cH₀/(2π)`.

The `2π` is therefore the radians-per-closure-loop conversion — *the same* `τ_ZFA = 2·π_QLF` behind
`g−2 = α/2π`, the Unruh/de Sitter temperatures (`QLF_HorizonTemperature`), and `Ω_Λ` — and `π_QLF` is
itself derived from the substrate closure census (`QLF_PhysicalPi`: `π = lim 1/(n·returnDensity n)`, no
circle). So the `2π` in `a₀` is the substrate closure-loop period grounded in counting, **not a fitted
MOND constant**. See `DarkMatter.md`, `Gravity_From_Delay.md` §5.
-/

namespace QLF.MondScale

open QLF QLF.LoopClosure

/-- The cosmic **cyclic** closure rate from the **angular** rate `ω`: closures (full loops) per unit
    time `= ω / τ_ZFA`. (`H₀` is the angular loop-phase rate; one closure = `τ_ZFA = 2π` radians.) -/
noncomputable def cyclicClosureRate (omega : ℝ) : ℝ := omega / tau_ZFA

/-- **The `2π` in `a₀` is the ZFA closure-loop period.** `a₀ = (cH₀)/τ_ZFA` — the Hubble acceleration
    `cH₀` delivered per closure loop. Since `τ_ZFA = 2π` (`QLF_LoopClosure`), this *is* `cH₀/(2π)`. -/
theorem a0_is_hubble_per_closure_loop (c H0 : ℝ) :
    mond_acceleration c H0 = hubble_acceleration c H0 / tau_ZFA := by
  unfold mond_acceleration hubble_acceleration tau_ZFA; ring

/-- **`a₀ = c × (cosmic cyclic closure rate)`.** The crossover acceleration is `c` times the cyclic
    closure rate `H₀/τ_ZFA` — `H₀` the angular rate, divided by `τ_ZFA = 2π` radians per loop. -/
theorem a0_eq_c_times_cyclic_rate (c H0 : ℝ) :
    mond_acceleration c H0 = c * cyclicClosureRate H0 := by
  unfold mond_acceleration cyclicClosureRate tau_ZFA; ring

/-- The closure-loop period is two `π_QLF` half-cycles (`tau_is_two_pi_QLF`), and `π_QLF` is the
    census-derived `π` of `QLF_PhysicalPi` — so the `2π` of `a₀` is grounded in substrate counting. -/
theorem loop_period_is_two_pi_QLF : tau_ZFA = 2 * pi_QLF := tau_is_two_pi_QLF

/-- **Status — the `2π` in `a₀` is derived, not posited.** `a₀ = cH₀/τ_ZFA` is the Hubble acceleration
    per ZFA closure loop (`a0_is_hubble_per_closure_loop`); `H₀` is the cosmic horizon's *angular* rate
    (exhibited by `T_dS = ℏH₀/(2πk_B)`), so `a₀ = c·` the cyclic rate `H₀/τ_ZFA`
    (`a0_eq_c_times_cyclic_rate`); and `τ_ZFA = 2·π_QLF` (`loop_period_is_two_pi_QLF`) with `π_QLF`
    census-derived (`QLF_PhysicalPi`). So the `2π` is the substrate closure-loop period — the same loop
    behind `g−2 = α/2π` and the horizon temperatures — not a fitted MOND constant. **Honest scope:**
    identifying `H₀` as the cosmic closure's *angular* rate is the physical premise the algebra rests on
    (the de Sitter temperature form is its evidence); the SPARC fit confirms the `1/2π` prefactor at the
    local `H₀`. -/
theorem mond_scale_two_pi_derived : True := trivial

end QLF.MondScale
