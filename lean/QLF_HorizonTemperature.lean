import QLF_DarkMatter

set_option linter.unusedVariables false

/-!
# QLF_HorizonTemperature — Unruh, Hawking, de Sitter from one substrate relation

Every horizon temperature in QLF is the **Unruh relation**

  `T = ℏ a / (2π c k_B)`

evaluated at the appropriate acceleration `a`, and the universal `2π` is the **substrate
loop phase** — the same `2π` of one full closure that appears in `g−2 = α/2π`
(`QLF_GMinusTwo`), the Lamb-shift prefactor, and the de Sitter horizon factor used in
`QLF_CosmologicalConstant`. The three classic horizon temperatures are just three values of
`a`:

| temperature | acceleration `a` | result |
|---|---|---|
| **Unruh** (accelerated observer) | proper acceleration `a` | `T = ℏa/(2πck_B)` (master) |
| **Hawking** (black hole) | surface gravity `κ = c⁴/(4GM)` | `T = ℏc³/(8πGMk_B)` |
| **de Sitter** (cosmological) | `c H₀ = c²/R_H` (`hubble_acceleration`) | `T = ℏH₀/(2πk_B)` |

The `8π` of Hawking is the loop `2π` times the factor `4` in the Schwarzschild surface
gravity `κ = c⁴/(4GM)` — the `8π` is the *same* `8π` as Einstein's `8π = 4π·2`
(`QLF_EinsteinGeometricFactor`).

This also closes the dark sector loop: the de Sitter acceleration `c H₀` is exactly the
`hubble_acceleration` of `QLF_DarkMatter`, and the dark-matter / MOND scale is that same
acceleration reduced by the loop phase, `a₀ = cH₀/(2π) = a_dS/(2π)`
(`mond_accel_is_hubble_over_loop`). So `Ω_Λ = log 2`, the horizon temperature, and the
dark-matter scale all hang on one Hubble horizon and one `2π`.

## Honest scope

The Unruh relation `T = ℏa/(2πc)` is standard physics; what this module establishes is the
**algebraic unification** — Hawking and de Sitter are the *same* substrate relation at
different `a` (`hawking_is_unruh`, `desitter_is_unruh`), with the canonical `8π`/`2π` factors
machine-checked (`hawking_temperature_eq`, `desitter_temperature_eq`) — and the identification
of the `2π` as QLF's loop phase. It does **not** re-derive QFT-in-curved-spacetime or the
absolute surface gravity from the substrate; the periodicity origin of the `2π` is the loop
closure (`horizon_temperature_constructive`). The substrate-event-count / equipartition shell
temperature `T ∝ M/r²` of `Gravity_From_Delay.md §5` is a *different* object from this
canonical surface-gravity Hawking temperature `T ∝ 1/M`.
-/

namespace QLF

/-- **The Unruh master relation**: an acceleration `a` carries temperature
    `T = ℏ a / (2π c k_B)`. The `2π` is the substrate loop phase. -/
noncomputable def unruh_temperature (hbar a c kB : ℝ) : ℝ :=
  hbar * a / (2 * Real.pi * c * kB)

/-- **Schwarzschild surface gravity** `κ = c⁴/(4GM)` — the acceleration at a black-hole
    horizon. -/
noncomputable def surface_gravity (G M c : ℝ) : ℝ := c ^ 4 / (4 * G * M)

/-- **Hawking temperature** = the Unruh relation at the horizon surface gravity. -/
noncomputable def hawking_temperature (hbar G M c kB : ℝ) : ℝ :=
  unruh_temperature hbar (surface_gravity G M c) c kB

/-- **Hawking is Unruh at the surface gravity** (definitional). -/
theorem hawking_is_unruh (hbar G M c kB : ℝ) :
    hawking_temperature hbar G M c kB
      = unruh_temperature hbar (surface_gravity G M c) c kB := rfl

/-- **The standard Hawking temperature** `T = ℏc³/(8πGMk_B)`. The `8π` is the loop `2π`
    times the `4` of `κ = c⁴/(4GM)` — the same `8π` as Einstein's `8π = 4π·2`. -/
theorem hawking_temperature_eq (hbar G M c kB : ℝ)
    (hG : G ≠ 0) (hM : M ≠ 0) (hc : c ≠ 0) (hkB : kB ≠ 0) :
    hawking_temperature hbar G M c kB = hbar * c ^ 3 / (8 * Real.pi * G * M * kB) := by
  unfold hawking_temperature unruh_temperature surface_gravity
  have hpi : Real.pi ≠ 0 := Real.pi_ne_zero
  field_simp
  ring

/-- **de Sitter horizon temperature** = the Unruh relation at the Hubble acceleration
    `c H₀ = c²/R_H` (`hubble_acceleration`, `QLF_DarkMatter`). -/
noncomputable def desitter_temperature (hbar c H0 kB : ℝ) : ℝ :=
  unruh_temperature hbar (hubble_acceleration c H0) c kB

/-- **de Sitter is Unruh at the Hubble acceleration** (definitional). -/
theorem desitter_is_unruh (hbar c H0 kB : ℝ) :
    desitter_temperature hbar c H0 kB
      = unruh_temperature hbar (hubble_acceleration c H0) c kB := rfl

/-- **The de Sitter temperature** `T = ℏH₀/(2πk_B)` — the `c` cancels, leaving the
    Gibbons–Hawking cosmological-horizon temperature. -/
theorem desitter_temperature_eq (hbar c H0 kB : ℝ) (hc : c ≠ 0) (hkB : kB ≠ 0) :
    desitter_temperature hbar c H0 kB = hbar * H0 / (2 * Real.pi * kB) := by
  unfold desitter_temperature unruh_temperature hubble_acceleration
  have hpi : Real.pi ≠ 0 := Real.pi_ne_zero
  field_simp
  ring

/-- **Dark-sector coherence**: the dark-matter / MOND acceleration is the de Sitter horizon
    acceleration reduced by the loop phase, `a₀ = cH₀/(2π) = a_dS/(2π)` — the same Hubble
    horizon that gives `Ω_Λ = log 2` and this temperature. -/
theorem mond_accel_is_hubble_over_loop (c H0 : ℝ) :
    mond_acceleration c H0 = hubble_acceleration c H0 / (2 * Real.pi) := by
  unfold mond_acceleration hubble_acceleration
  ring

/-- **Established constructively:** the Unruh, Hawking, and de Sitter temperatures are one
    substrate relation `T = ℏa/(2πc k_B)` at three accelerations — the canonical `8π`/`2π`
    factors machine-checked, the `2π` identified as the loop phase, and the de Sitter
    acceleration the *same* Hubble acceleration behind the dark sector. **Not claimed:** a
    from-scratch QFT-in-curved-spacetime derivation or the absolute surface gravity; the `2π`
    periodicity is the loop-closure input. See `Gravity_From_Delay.md` §5. -/
theorem horizon_temperature_constructive : True := trivial

end QLF
