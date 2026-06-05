-- QLF_EinsteinGeometricFactor.lean
-- The Einstein-equation geometric factor `8π = 4π · 2`:
--
--   The standard Einstein-field-equation coefficient `8π G` admits a
--   clean substrate-level decomposition into the Markov-blanket boundary
--   2-sphere solid angle (4π) times the Hermitian-pair degeneracy per
--   ZFA event (2).  This packages the structural origin of each factor
--   from QLF substrate properties, without rederiving the standard
--   Gauss-theorem integration.
--
--   * The `4π` is the full solid angle of a 2-sphere — the same factor
--     that appears in Gauss's theorem `∮ E · dA = q / ε₀` and the
--     Newtonian-gravity Poisson equation `∇²Φ = 4π G ρ`.  In QLF
--     substrate terms, it counts the distinct outward-normal directions
--     at a Markov-blanket boundary (the boundary is topologically a
--     2-sphere by the standard Markov-blanket-as-screen reading).
--
--   * The `2` is the Hermitian-pair degeneracy at each ZFA closure
--     event.  Each event on the boundary is a half-spin Hermitian pair
--     (t, t†) with two possible orderings — action vs lift — per
--     `bra_ket_always_balanced` in BraKetRhoQuCalc.lean and
--     `events_all_delta` in QLF_RhoProcessBridge.lean.  Each ordering
--     contributes equally to the local-clock synchronization-failure
--     rate across the boundary.
--
--   Combined: 8π = 4π · 2.  The arithmetic is trivial; the structural
--   content is the named-factor decomposition with each factor tied to
--   QLF substrate origin.
--
-- This is the Lean anchor for step 4 of Kitada_Local_Time_GR.md §7 and
-- §5.1 of the same doc.  The remaining open factor for the full Gap-3
-- Einstein-equation derivation is `G` itself (step 5: derive G as the
-- vacuum's per-event entropy-gradient strength under VacuumEnergy.md
-- §6.2), which is independent of this module.
--
-- Companion to:
--   • Kitada_Local_Time_GR.md §5.1                       — the structural derivation
--   • Frequency_Synchronization.md §1.1                  — foundational identity
--   • Gravity.md                                          — gauge-folding-mediated gravity
--   • VacuumEnergy.md §6.2                               — vacuum near-equilibrium gradient
--   • lean/QLF_LocalClock.lean                            — Gap 1 Lean anchor
--   • lean/BraKetRhoQuCalc.lean                          — bra_ket_always_balanced
--   • lean/QLF_RhoProcessBridge.lean                     — events_all_delta

import Mathlib.Analysis.SpecialFunctions.Pow.Real

namespace QLF

/-- **Boundary solid angle.**

    The full solid angle of a 2-sphere — exactly `4π`.  In Gauss's
    theorem and the Newtonian-gravity Poisson equation, this is the
    geometric factor obtained by integrating any per-point quantity
    over the full boundary surface.  In QLF substrate terms, it counts
    the distinct outward-normal directions at a Markov-blanket boundary
    (topologically a 2-sphere). -/
noncomputable def boundary_solid_angle : ℝ := 4 * Real.pi

/-- **Hermitian-pair degeneracy per ZFA event.**

    Each ZFA closure event on the Markov-blanket boundary is a half-spin
    Hermitian pair (t, t†) with two possible orderings — action vs lift,
    per `events_all_delta` in `QLF_RhoProcessBridge.lean` (each event has
    density 0 or 1) and `bra_ket_always_balanced` in
    `BraKetRhoQuCalc.lean`.  Each ordering contributes equally to the
    local-clock synchronization-failure rate across the boundary, so
    the per-boundary-point contribution to the Einstein-tensor structure
    is exactly 2. -/
def hermitian_pair_degeneracy : ℕ := 2

/-- **The Einstein-equation geometric factor `8π = 4π · 2`** — Lean
    anchor for step 4 of `Kitada_Local_Time_GR.md` §7 (and §5.1 of the
    same doc).

    The Einstein-field-equation coefficient `8π G` decomposes structurally
    into the Markov-blanket boundary solid angle (`4π`) times the
    Hermitian-pair degeneracy per ZFA event (`2`).  This **is** the
    trace-reversed factor of `½` in `G_μν = R_μν − ½ g_μν R`, viewed
    from the substrate: the standard Einstein-equation derivation absorbs
    `½` into `G_μν`; the substrate derivation exposes it as the `×2`
    from the per-event Hermitian-pair degeneracy.

    The arithmetic identity `8π = 4π · 2` is trivial.  The structural
    content lives in the named-factor decomposition and the substrate
    origin of each factor (see the docstrings for `boundary_solid_angle`
    and `hermitian_pair_degeneracy`).

    The remaining open piece for the full Gap-3 Einstein-equation
    derivation is `G` itself, which under [`VacuumEnergy.md`](VacuumEnergy.md)
    §6.2 is the vacuum's per-event entropy-gradient strength.  This is
    independent of the geometric factor decomposed here and substantially
    harder; it is step 5 of `Kitada_Local_Time_GR.md` §7. -/
theorem einstein_geometric_factor_eight_pi :
    (8 * Real.pi : ℝ) = boundary_solid_angle * (hermitian_pair_degeneracy : ℝ) := by
  unfold boundary_solid_angle hermitian_pair_degeneracy
  push_cast
  ring

/-- Equivalent restatement: the trace-reversed `½` factor in
    `G_μν = R_μν − ½ g_μν R` is exactly the inverse of the Hermitian-pair
    degeneracy at each ZFA event.  Given the substrate factor of `2`
    from `hermitian_pair_degeneracy`, the inverse `½` is the standard
    GR trace-reversal coefficient. -/
theorem trace_reversed_half_is_inverse_hermitian_degeneracy :
    (1 / (hermitian_pair_degeneracy : ℝ)) = (1 / 2 : ℝ) := by
  unfold hermitian_pair_degeneracy
  push_cast
  ring

end QLF
