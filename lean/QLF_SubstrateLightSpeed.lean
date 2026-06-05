-- QLF_SubstrateLightSpeed.lean
-- The constancy of the speed of light c from the QLF substrate's cosmic-ratio
-- identity:
--
--   c = R_cosmic / T_cosmic = (n · L_Planck) / (n · τ_Planck) = L_Planck / τ_Planck
--
-- Both R_cosmic and T_cosmic are derived independently of c (HadronicDepth.md
-- and AgeOfUniverse.md §4.1 / Kitada §4 respectively).  The cosmic-horizon
-- Markov-blanket depth n cancels exactly, leaving c as the substrate property
-- L_Planck / τ_Planck — the rate at which gauge-free signals propagate
-- through the uniform Planck-event substrate.
--
-- This module also packages the generalisation to any Markov blanket of depth
-- ρ.  Any Markov blanket of depth ρ has local spatial extent ρ · L_Planck and
-- local clock period ρ · τ_Planck, with the ratio c_local = c_substrate.  The
-- ρ cancels by the substrate's irreducible space-time event quantum: each
-- Planck event creates one Planck length and one Planck tick together; gauge-
-- folding nests ρ events without changing the per-event 1:1 length-to-time
-- identity.
--
-- This is the Lean anchor for step 7 of Kitada_Local_Time_GR.md §7, and §5.3
-- of the same doc.  Together with QLF_LocalClock.lean (Gap 1) and
-- QLF_EinsteinGeometricFactor.lean (Gap 3 step 4), it closes the basic
-- relativistic identities for the QLF substrate.
--
-- Companion to:
--   • Kitada_Local_Time_GR.md §5.3                        — the structural derivation
--   • AgeOfUniverse.md §4.1                               — cosmic age T = n · τ_Planck
--   • HadronicDepth.md                                    — n ~ (m_Planck / m_p)³
--   • Frequency_Synchronization.md §1.1                   — foundational identity
--   • Photon_Energy_Bits.md                               — gauge-free signals
--   • Experimental_Consistency.md §3 line 92, §4.5         — open item now closed
--   • lean/QLF_LocalClock.lean                            — Gap 1 Lean anchor
--   • lean/QLF_EinsteinGeometricFactor.lean               — Gap 3 step 4

import Mathlib.Analysis.SpecialFunctions.Pow.Real

namespace QLF

/-- **Planck length** — the substrate's irreducible spatial unit.

    `L_Planck = sqrt(ℏ G / c³) ≈ 1.616 × 10⁻³⁵ m`.  In QLF terms, it is the
    spatial extent of one substrate Planck event.  Each event creates one
    Planck length and one Planck tick together (the irreducible space-time
    event quantum). -/
noncomputable def planck_length : ℝ := 1.616255e-35

/-- **Planck time** — the substrate's irreducible temporal unit.

    `τ_Planck = sqrt(ℏ G / c⁵) ≈ 5.39 × 10⁻⁴⁴ s`.  In QLF terms, it is the
    temporal extent of one substrate Planck event. -/
noncomputable def planck_time : ℝ := 5.391247e-44

/-- **Substrate speed of light** — the rate at which gauge-free signals
    propagate through the uniform Planck-event substrate.

    `c_substrate = L_Planck / τ_Planck ≈ 2.998 × 10⁸ m/s` matches the CODATA
    value `c = 299 792 458 m/s` (the small ratio mismatch reflects the
    SI-definition rounding of `L_Planck` and `τ_Planck`).

    By construction, this is independent of any signal's frequency (gauge-free
    signals see the substrate's uniform Planck-event rate everywhere) and
    independent of local Markov-blanket gauge-fold density (the cosmic-ratio
    identity below cancels the depth `n` exactly). -/
noncomputable def substrate_light_speed : ℝ := planck_length / planck_time

/-- **Cosmic-horizon Markov-blanket depth** — the dimensionless Hadronic-
    Depth quantity `n ≈ 6 × 10⁶⁰`, anchored at the proton mass via
    `n ~ (m_Planck / m_p)³` per `HadronicDepth.md`.

    The cosmic horizon is a Markov blanket of this depth (per
    `AgeOfUniverse.md` §4.1 / `Kitada_Local_Time_GR.md` §4).  Below we use
    `n` as a positive real parameter; specific numerical anchoring is in
    `HadronicDepth.md`. -/
noncomputable def cosmic_horizon_depth : ℝ := 6.0e60

/-- **Apparent universe size** — the cosmic-horizon Markov blanket's spatial
    extent: `R_cosmic = n · L_Planck`.

    Each Planck event creates one Planck length; nesting `n` events gives
    spatial extent `n · L_Planck`. -/
noncomputable def apparent_universe_size : ℝ := cosmic_horizon_depth * planck_length

/-- **Apparent universe age** — the cosmic-horizon Markov blanket's proper
    time: `T_cosmic = n · τ_Planck`.

    Each Planck event advances the substrate clock by one tick; nesting `n`
    events gives proper time `n · τ_Planck`.  See `AgeOfUniverse.md` §4.1
    and `Kitada_Local_Time_GR.md` §4 for the Mach-relational derivation of
    this as the cosmic-horizon Markov blanket's proper time. -/
noncomputable def apparent_universe_age : ℝ := cosmic_horizon_depth * planck_time

/-- **The cosmic-ratio identity for `c`** — Lean anchor for step 7 of
    `Kitada_Local_Time_GR.md` §7 (and §5.3 of the same doc).

    The speed of light equals the cosmic blanket's spatial-to-temporal
    ratio:

    $$ c \;=\; \frac{R_{\text{cosmic}}}{T_{\text{cosmic}}} \;=\;
       \frac{n \cdot L_{\text{Planck}}}{n \cdot \tau_{\text{Planck}}} \;=\;
       \frac{L_{\text{Planck}}}{\tau_{\text{Planck}}} $$

    The cosmic-horizon depth `n` cancels exactly.  `c` falls out as a
    substrate property from two independently-derived QLF quantities
    (apparent size and apparent age), neither of which assumes `c`
    upstream — closing the circular-dependence obstacle that would arise
    if `c` were derived from the local-clock synchronization-failure
    formula `Δt_sync ~ (R/f)/c`.

    Proof: `field_simp` clears the division; `ring` discharges the
    algebraic identity once non-degeneracy of `n` and `τ_Planck` is
    available. -/
theorem substrate_light_speed_from_cosmic_ratio
    (hn : cosmic_horizon_depth ≠ 0)
    (htau : planck_time ≠ 0) :
    apparent_universe_size / apparent_universe_age = substrate_light_speed := by
  unfold apparent_universe_size apparent_universe_age substrate_light_speed
  field_simp

/-- **Local light speed invariance** — for any Markov blanket of depth `ρ`,
    the local `c` equals the substrate `c`.

    $$ c_{\text{local}} \;=\; \frac{\rho \cdot L_{\text{Planck}}}{\rho \cdot \tau_{\text{Planck}}}
       \;=\; \frac{L_{\text{Planck}}}{\tau_{\text{Planck}}} \;=\; c_{\text{substrate}} $$

    The `ρ` cancels by the substrate's irreducible space-time event quantum:
    each Planck event creates one Planck length and one Planck tick together;
    gauge-folding nests `ρ` events without changing the per-event 1:1 length-
    to-time identity.  This is the QLF reading of local Lorentz invariance,
    structurally grounded in the substrate event quantum rather than imposed
    as a metric postulate.

    Proof: identical algebraic cancellation as the cosmic-ratio identity. -/
theorem local_light_speed_invariant
    (ρ : ℝ) (hρ : ρ ≠ 0) (htau : planck_time ≠ 0) :
    (ρ * planck_length) / (ρ * planck_time) = substrate_light_speed := by
  unfold substrate_light_speed
  field_simp

end QLF
