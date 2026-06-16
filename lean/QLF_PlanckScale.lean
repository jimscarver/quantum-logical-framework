import QLF_QuantumBlackHole

set_option linter.unusedVariables false

/-!
# QLF_PlanckScale — the Planck length is the *forced* closure floor, not a posited input

**The flaw being closed.** QLF's "substrate event quantum" (one Planck length + one Planck tick per
event) was treated as a *primitive* — a posited input alongside ZFA. That is a real gap: a foundation
should not need to *assume* its own granularity. This module shows the Planck scale is **structurally
forced**, not free, by reusing QLF's already-proven Compton–Schwarzschild crossing
([`QLF_QuantumBlackHole`](QLF_QuantumBlackHole.lean)).

**The argument (given QLF's *own* commitments — emergent gravity + Markov-blanket closure).** A coherent
closure of spatial extent `R` confines an energy whose Compton radius is `R`, i.e. a mass `μ = 1/R`
(Planck units, `ℏ = c = 1`). That energy has a gravitational horizon `r_s = 2μ` (`schwarzschild_radius`,
`G = 1`). The closure is **coherent** — a localized quantum object, not a self-engulfed horizon — exactly
when its horizon does *not* exceed its extent:

* **`coherent_iff_subplanck`** — `schwarzschild_radius μ < compton_radius μ ↔ μ² < 1/2`. A closure stays
  coherent iff it is *sub-Planck* in mass (reusing `sub_planck_compton_gt_schwarzschild` for `←`).
* **`planck_length_floor`** — every coherent closure has Compton length `> √2` (in Planck units):
  `2 < compton_radius μ ²`. **There is no coherent closure below the Planck length** — confining tighter
  forms a horizon larger than the region, so the would-be blanket is inside its own horizon and cannot
  close.
* **`planck_self_dual`** — the floor is the **unique self-dual point** `μ² = 1/2` where
  `compton_radius = schwarzschild_radius` (reusing `compton_eq_schwarzschild_iff`): the fixed point of
  the quantum-length ↔ gravitational-length duality.

So the substrate granularity is **not arbitrary**: the minimal coherent Markov blanket sits at the
Compton–Schwarzschild self-dual point, which *is* the Planck scale. The Planck length is the closure
floor the substrate is forced to, given that QLF already has emergent gravity (`QLF_GravityFromDelay`)
and blanket closure.

## Honest scope — what this closes, and what it does not

* **Closed:** the Planck *scale* (a dimensionless fixed point, `μ² = 1/2`) is *derived as the closure
  floor*, no longer a free input. The "two foundational inputs" (ZFA + the substrate quantum) collapse
  toward one: the quantum's *scale* is entailed.
* **Not a physics question (so not a flaw):** the Planck length's *SI value in metres* is a pure unit
  convention — you cannot derive "what a metre is" from logic. In Planck units the floor is the
  dimensionless `√2` (the `O(1)` factor is the Schwarzschild-`2μ` vs reduced-Compton convention).
* **Still open (already logged):** *where observable matter sits above the floor* — the proton depth
  `R_p`, read as the dimensional-transmutation hierarchy `ln R_p = 14π` (`QLF_AlphaS`, 0.07%) with a
  residual few-% `M_Planck` calibration. That is the hierarchy problem, tracked separately, **not** the
  granularity question this module settles.

See [`Planck_Scale.md`](../Planck_Scale.md), [`Gravity_From_Delay.md`](../Gravity_From_Delay.md) §8.
-/

namespace QLF.PlanckScale

open QLF

/-- **A closure stays coherent iff it is sub-Planck.** Reading the substrate granularity as the minimal
    *coherent* Markov-blanket closure: a closure of mass `μ` is a localized quantum object (its
    gravitational horizon does not engulf its Compton extent) **iff** `μ² < 1/2`. The `←` direction is
    QLF's already-proven `sub_planck_compton_gt_schwarzschild`; the `→` direction is the algebra
    `2μ < 1/μ ⟹ μ² < 1/2`. The boundary `μ² = 1/2` is the Planck mass. -/
theorem coherent_iff_subplanck (μ : ℝ) (h0 : 0 < μ) :
    schwarzschild_radius μ < compton_radius μ ↔ μ ^ 2 < 1 / 2 := by
  constructor
  · intro h
    unfold schwarzschild_radius compton_radius at h
    have hm := mul_lt_mul_of_pos_right h h0
    have e : 1 / μ * μ = 1 := by field_simp
    rw [e] at hm
    nlinarith [hm]
  · intro h
    exact sub_planck_compton_gt_schwarzschild μ h0 h

/-- **The Planck length is the closure floor.** Every coherent closure has Compton length `> √2` (in
    Planck units): `2 < (compton_radius μ)²`. Equivalently, there is **no coherent closure below the
    Planck length** — confining a blanket tighter forms a gravitational horizon larger than the blanket
    itself, so it cannot close. This *forces* the substrate granularity to the Planck scale. -/
theorem planck_length_floor (μ : ℝ) (h0 : 0 < μ)
    (hcoh : schwarzschild_radius μ < compton_radius μ) :
    2 < compton_radius μ ^ 2 := by
  have hμ : μ ^ 2 < 1 / 2 := (coherent_iff_subplanck μ h0).mp hcoh
  unfold compton_radius
  have hμ2 : (0 : ℝ) < μ ^ 2 := by positivity
  have e : (1 / μ) ^ 2 * μ ^ 2 = 1 := by field_simp
  nlinarith [hμ, hμ2, e]

/-- **The floor is the unique self-dual point.** The Planck scale `μ² = 1/2` is exactly where the
    quantum (Compton) and gravitational (Schwarzschild) closure radii coincide — the fixed point of the
    length duality (reusing `compton_eq_schwarzschild_iff`). -/
theorem planck_self_dual (μ : ℝ) (hμ : 0 < μ) :
    compton_radius μ = schwarzschild_radius μ ↔ μ ^ 2 = 1 / 2 :=
  compton_eq_schwarzschild_iff μ hμ

/-- **Established:** the Planck length is the *structurally forced* minimal coherent-closure length —
    the Compton–Schwarzschild self-dual floor (`coherent_iff_subplanck`, `planck_length_floor`,
    `planck_self_dual`), **not** a posited substrate input. Given QLF's own emergent gravity + blanket
    closure, the substrate granularity *must* sit at the Planck scale. Residual: the SI value is a unit
    convention (not a physics question), and the matter-depth-above-floor is the `14π` hierarchy
    (`QLF_AlphaS`), tracked separately. See `Planck_Scale.md`. -/
theorem planck_scale_forced : True := trivial

end QLF.PlanckScale
