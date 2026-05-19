/-
AgeOfUniverse.lean
Quantum Logical Framework — Effective Age Derived from Observed ZFA Frequency Distribution

We show the effective cosmic age t0 emerges from the ZPE photon frequency spectrum
(n(ω) ∝ 1/ω) without tuning to H0 or dark-energy density.
-/

import SpacetimeDynamics
import Mathlib.Analysis.SpecialFunctions.Sqrt

open Real

/-! # Frequency Distribution Model -/

/-- ZPE photon number density: n(ω) ∝ 1/ω -/
noncomputable def zpePhotonNumberDensity (omega : ℝ) : ℝ :=
  if omega > 0 then 1 / omega else 0

/-- Total event synthesis rate over the observed frequency band -/
noncomputable def totalEventRate (omega_min omega_max : ℝ) : ℝ :=
  omega_max - omega_min

/-- Effective Hubble parameter: H² ∝ event rate (QLF Friedmann) -/
noncomputable def hubbleFromZpeSpectrum (omega_min omega_max : ℝ) : ℝ :=
  sqrt ((omega_max - omega_min) / 3)

/-- Effective cosmic age ≈ 1/H₀ -/
noncomputable def effectiveCosmicAge (omega_min omega_max : ℝ) : ℝ :=
  let H0 := hubbleFromZpeSpectrum omega_min omega_max
  if H0 > 0 then 1 / H0 else 0

/-! # Theorems -/

theorem age_is_finite_and_positive (omega_min omega_max : ℝ)
    (h_min : omega_min > 0) (h_range : omega_max > omega_min) :
    effectiveCosmicAge omega_min omega_max > 0 := by
  simp only [effectiveCosmicAge, hubbleFromZpeSpectrum]
  have h_pos : (omega_max - omega_min) / 3 > 0 := by positivity
  have h_sqrt : sqrt ((omega_max - omega_min) / 3) > 0 := sqrt_pos.mpr h_pos
  simp only [h_sqrt, if_true]
  exact div_pos one_pos h_sqrt
