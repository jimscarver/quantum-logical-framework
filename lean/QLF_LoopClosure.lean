import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic

set_option linter.unusedVariables false

/-!
# QLF_LoopClosure — the closure machine vs the `2π` rendering (the dependency direction)

Addresses the recurring `π`/closure critique (issues #59, #71, #73, and the spirit of #66 / #37):
when QLF writes `2π`, is it *describing the machine* or *displaying a finite closure result*?
The answer, made explicit here by separating three objects (Allen's `ZFA / τ_ZFA / π_QLF`):

* **The closure operation is `Nat.mod` — finite, decidable, RCA₀, with NO `Real.pi`.** Substrate
  phase is `phase k N = k % N`; a full cycle of `N` ticks closes exactly (`phase_full_cycle`:
  `phase (k+N) N = phase k N`), and a phase is always a finite-alphabet residue `< N`
  (`phase_lt`). This is cyclic algebra, not a Euclidean circle — it is *the machine*.
* **The continuum `2π` is *chosen* in the rendering, not recovered from the machine.** `renderAngle k
  N = 2π·k/N` is the map from the finite cycle to the reported angle; `Real.pi` is *inserted* **here
  and nowhere else**. `render_full_cycle` / `render_one_cycle` only confirm this chosen rendering is
  *self-consistent* — a full `N`-tick cycle maps to a `+2π` increment — they do **not** derive `2π`
  from the substrate (it is already in `renderAngle`'s definition). Honest verb (Allen #89/#90): `2π`
  is the **chosen continuum rendering** of the finite cycle `% N`, not a quantity *recovered* from it.
* **`τ_ZFA` and `π_QLF` named.** `tau_ZFA = 2π` (one full closure period) and `pi_QLF = π` (half a
  cycle) are the *continuum renderings* (`tau_is_two_pi_QLF`); the substrate object behind them is
  the finite cycle `cycleTicks N = N`.

So the dependency direction is the honest one Allen asked for: **the closure machine (`% N`) is
primitive and `Real.pi`-free; the continuum `2π` is the reporting approximation *chosen to display*
it (inserted in `renderAngle`, not recovered from `% N`).**
The loop-phase `2π` that appears in `g−2 = α/2π`, the Unruh temperature, and `a₀ = cH₀/2π`
([`QLF_HorizonTemperature`](QLF_HorizonTemperature.lean), [`QLF_GMinusTwo`](QLF_GMinusTwo.lean)) is
this rendered full cycle, not Euclidean geometry sneaking in as a primitive.

## Honest scope

This anchors the **separation and the dependency direction** — closure is `Real.pi`-free, `2π` is the
rendering *chosen for* the finite cycle (`2π` inserted in `renderAngle`, the theorems confirming the
choice is self-consistent). It does **not** derive the *value* of `π` from a specific
substrate `N` (that is not required — a finite primitive is legitimate, #71); the finite-precision
audit ([`pi_precision_demo.py`](../pi_precision_demo.py), #37) separately shows ≤15 digits of the
loop constant reproduce all audited measured physics, so no infinite precision is needed. Which
physical `N` a given loop closes on is the open piece (`loop_closure_value_in_progress`). See
[`TheContinuum.md`](../TheContinuum.md).
-/

namespace QLF.LoopClosure

/-- A full substrate cycle is `N` discrete ticks — finite and exact. -/
def cycleTicks (N : ℕ) : ℕ := N

/-- **The closure operation.** Substrate phase = tick count modulo the cycle (`Nat.mod`) —
    decidable, RCA₀, **no `Real.pi`**. This is the machine. -/
def phase (k N : ℕ) : ℕ := k % N

/-- **Phase closes exactly after one full cycle** — cyclic algebra, no continuum: advancing by a
    whole cycle returns the same phase. -/
theorem phase_full_cycle (k N : ℕ) : phase (k + N) N = phase k N :=
  Nat.add_mod_right k N

/-- A phase is always a finite-alphabet residue strictly below the cycle length (`N>0`). -/
theorem phase_lt (k N : ℕ) (hN : 0 < N) : phase k N < N :=
  Nat.mod_lt k hN

/-- **The continuum rendering.** The reported angle of phase `k` in an `N`-tick cycle is `2π·k/N`.
    `Real.pi` appears HERE and only here — in the rendering map, never in `phase`. -/
noncomputable def renderAngle (k N : ℕ) : ℝ := 2 * Real.pi * (k : ℝ) / (N : ℝ)

/-- **The chosen rendering is self-consistent over a full cycle.** Advancing the finite phase by a
    whole `N`-tick cycle shifts the *chosen* rendered angle by exactly `+2π`. NOTE: `2π` is **inserted**
    by `renderAngle`'s definition (`2 * Real.pi`); this theorem confirms the choice is consistent (a
    full cycle ↦ one `+2π` step), it does **not** *recover* `2π` from the substrate. -/
theorem render_full_cycle (k N : ℕ) (hN : 0 < N) :
    renderAngle (k + N) N = renderAngle k N + 2 * Real.pi := by
  unfold renderAngle
  have hN' : (N : ℝ) ≠ 0 := Nat.cast_ne_zero.mpr hN.ne'
  push_cast
  field_simp

/-- The bare full-cycle constant `τ_ZFA = 2π` is the rendered single cycle. -/
theorem render_one_cycle (N : ℕ) (hN : 0 < N) : renderAngle N N = 2 * Real.pi := by
  unfold renderAngle
  have hN' : (N : ℝ) ≠ 0 := Nat.cast_ne_zero.mpr hN.ne'
  rw [mul_div_assoc, div_self hN', mul_one]

/-- The full-cycle rendering constant `τ_ZFA = 2π` (one closure period). -/
noncomputable def tau_ZFA : ℝ := 2 * Real.pi

/-- The half-cycle rendering `π_QLF = π`. -/
noncomputable def pi_QLF : ℝ := Real.pi

/-- `τ_ZFA = 2·π_QLF` — the full cycle is two half-cycles, both *renderings* of the finite cycle. -/
theorem tau_is_two_pi_QLF : tau_ZFA = 2 * pi_QLF := by
  unfold tau_ZFA pi_QLF; ring

/-- **The dependency direction (closure machine vs chosen rendering):** the closure operation
    `phase = (· % N)` is finite, decidable, and `Real.pi`-free (`phase_full_cycle`, `phase_lt`); the
    continuum `2π` enters only in `renderAngle`, where it is **inserted** (`2 * Real.pi`). The render
    theorems (`render_full_cycle`, `render_one_cycle`) confirm that *chosen* rendering is
    self-consistent — a full cycle ↦ `+2π` — they do **not** recover `2π` from the substrate. So `2π`
    *displays* the finite closure `k % N`; it is neither imported as the source of closure nor derived
    from it (Allen #89/#90). **Open:** the *value* — which physical `N` a given loop closes on (the
    finite-precision audit, #37, shows ≤15 digits suffice; `loop_closure_value_in_progress`). And the
    *effective-limit* recovery of continuum geometry (coarse-grained observables → Euclidean `π`
    relations) is the ordinary emergent-spacetime burden, tracked in `QLF_PhysicalPi` / `Physical_Pi.md`. -/
theorem loop_closure_value_in_progress : True := trivial

end QLF.LoopClosure
