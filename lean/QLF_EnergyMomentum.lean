import QLF_Minkowski
import Mathlib

set_option linter.unusedVariables false

/-!
# QLF_EnergyMomentum — the relativistic `E² = p² + m²` off the Minkowski interval

The QLF state space **is** Minkowski space: the Hermitian `Form` `(t,x,y,z)` has determinant
`t² − x² − y² − z²`, the spacetime interval (`det_toMatrix_eq_interval`, `QLF_Minkowski`). Read the
*same* Form as a **4-momentum** `(E, p_x, p_y, p_z)` — the trace coordinate is the energy, the three
Pauli coordinates the momentum (units `c = 1`) — and its interval is `E² − |p|²`, the **invariant mass
squared**. So the relativistic energy–momentum relation is not a new postulate: it **is** the interval.

* **`energy_momentum_relation`** — `E² = p² + m²` (`(energy p)² = momentumSq p + invariantMassSq p`),
  read straight off `Form.interval`.
* **`massSq_eq_det`** — the invariant mass² is the **determinant of the 4-momentum** Form (the same
  `Herm₂(ℂ) ≅ ℝ^{1,3}` identity, `det_toMatrix_eq_interval`). `m² = det(E,p)`.
* **`mass_lorentz_invariant`** — a boost/rotation acts on the 4-momentum by the `SL(2,ℂ)` congruence
  `X ↦ A X A†` (`|det A| = 1`), which preserves the determinant = `m²`
  (`interval_preserved_of_unit_det`): **all observers agree on the invariant mass**.
* **`rest_energy_sq`** — at rest (`p = 0`), `E² = m²`: rest energy `E = mc²`.
* **`massless_null`** — massless (`m² = 0`, the photon), `E² = p²`: a null/light-like 4-momentum on the
  light cone, the same null condition as a pure qubit (`pure_qubit_null`, Bloch = celestial sphere).

So momentum enters QLF not as a bare additive count (that is the `Conservation.md` Noether entry) but
through the **verified Lorentzian state space**: the energy–momentum relation, the rest energy `E=mc²`,
and the masslessness of light all follow from the one interval `det = t² − x² − y² − z²`. Reuses
`QLF_Minkowski`; no new axioms. See `The_QLF_State_Space.md` §7, `UniversalRelativity.md`.
-/

namespace QLF.EnergyMomentum

open QLF.Minkowski Matrix

/-- The **energy** of a 4-momentum `Form` — the time/trace coordinate (`c = 1`). -/
def energy (p : Form) : ℝ := p.t

/-- The **squared momentum** `|p|²` — the three Pauli (spatial) coordinates. -/
def momentumSq (p : Form) : ℝ := p.x ^ 2 + p.y ^ 2 + p.z ^ 2

/-- The **invariant mass squared** `m²` — the Minkowski interval of the 4-momentum `E² − |p|²`. -/
def invariantMassSq (p : Form) : ℝ := Form.interval p

/-- **The relativistic energy–momentum relation `E² = p² + m²`** — read directly off the Minkowski
    interval (`Form.interval = E² − |p|²`). Not a new postulate: the relation **is** the interval. -/
theorem energy_momentum_relation (p : Form) :
    (energy p) ^ 2 = momentumSq p + invariantMassSq p := by
  simp only [energy, momentumSq, invariantMassSq, Form.interval]
  ring

/-- **The invariant mass² is the determinant of the 4-momentum Form** — the same `Herm₂(ℂ) ≅ ℝ^{1,3}`
    identity as the spacetime interval (`det_toMatrix_eq_interval`). So `m² = det(E, p_x, p_y, p_z)`. -/
theorem massSq_eq_det (p : Form) :
    (Form.toMatrix p).det = (invariantMassSq p : ℂ) :=
  det_toMatrix_eq_interval p

/-- **Mass is a Lorentz invariant.** A boost/rotation acts on the 4-momentum by the `SL(2,ℂ)`
    congruence `X ↦ A X A†` with `|det A| = 1`, which preserves the determinant `= m²`
    (`interval_preserved_of_unit_det`). So all observers agree on the invariant mass — the energy and
    momentum transform, `m²` does not. -/
theorem mass_lorentz_invariant (A : Matrix (Fin 2) (Fin 2) ℂ) (p : Form)
    (hA : Complex.normSq A.det = 1) :
    (A * Form.toMatrix p * Aᴴ).det = (invariantMassSq p : ℂ) := by
  rw [interval_preserved_of_unit_det A (Form.toMatrix p) hA]
  exact massSq_eq_det p

/-- **Rest frame — `E = mc²`.** A particle at rest (`p = 0`) has `E² = m²`: all its energy is rest
    mass. -/
theorem rest_energy_sq (p : Form) (hx : p.x = 0) (hy : p.y = 0) (hz : p.z = 0) :
    (energy p) ^ 2 = invariantMassSq p := by
  rw [energy_momentum_relation]
  simp only [momentumSq, hx, hy, hz]
  ring

/-- **Massless — `E = |p|` (a null 4-momentum).** A massless particle (`m² = 0`, e.g. the photon) has
    `E² = p²`: its 4-momentum is light-like, on the light cone — the same null condition as a pure qubit
    (`pure_qubit_null`, Bloch = celestial sphere). -/
theorem massless_null (p : Form) (hm : invariantMassSq p = 0) :
    (energy p) ^ 2 = momentumSq p := by
  rw [energy_momentum_relation, hm, add_zero]

/-- **Established:** the relativistic energy–momentum relation on QLF's verified Minkowski state space.
    `E² = p² + m²` (`energy_momentum_relation`) is the Minkowski interval of the 4-momentum; the
    invariant mass² is its determinant (`massSq_eq_det`) and a Lorentz invariant
    (`mass_lorentz_invariant`); the rest energy is `E = mc²` (`rest_energy_sq`); and a massless particle
    is null, `E = |p|` (`massless_null`). So momentum enters QLF through the verified Lorentzian geometry
    (`QLF_Minkowski`), not as a bare additive count. No new axioms. See `The_QLF_State_Space.md` §7. -/
theorem energy_momentum_summary : True := trivial

end QLF.EnergyMomentum
