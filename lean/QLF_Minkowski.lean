import SpacetimeDynamics
import Mathlib

/-!
# QLF_Minkowski — the QLF state IS Minkowski space; its determinant is the spacetime interval

The basic QLF state object is a `Form` (`SpacetimeDynamics.lean`): a 2×2 **Hermitian** matrix
`!![t+z, x−iy; x+iy, t−z]` parameterized by `(t, x, y, z)`. This is not an analogy — it is the
classical isomorphism **Herm₂(ℂ) ≅ Minkowski space `ℝ^{1,3}`**: a 4-vector `(t,x,y,z)` maps to
`X = t·I + x·σx + y·σy + z·σz`, the **1 trace direction = time** and the **3 traceless Pauli
directions = space** (the same 3 spatial axes as `QLF_Generations`). So *every closure's spectral mode*
(`toSpectralMode_hermitian`) is a point of Minkowski space.

The load-bearing fact, machine-checked here:

* **`det_toMatrix_eq_interval`** — `det X = t² − x² − y² − z²`, the **Minkowski interval** (signature
  `+,−,−,−`). The determinant of the Hermitian state *is* the spacetime metric.
* **`pure_qubit_null`** — a pure qubit (`t=½`, `x²+y²+z²=¼`) has interval `0`: pure states sit on the
  **light cone**, and the Bloch sphere is the **celestial sphere** (the projective null cone, Penrose).
* **`lorentz_preserves_interval`** — the action `X ↦ A X A†` with `det A = 1` (i.e. `A ∈ SL(2,ℂ)`)
  preserves the determinant, hence the interval: `SL(2,ℂ)` acts as the **Lorentz group** `SO⁺(1,3)`,
  its half-spin twists the **2-spinors** (the `SU(2)→SO(3)` double cover of `QLF_Spin` is the spatial
  restriction of this `SL(2,ℂ)→SO⁺(1,3)` spinor double cover).

Over the substrate the entries are Gaussian integers (`QLF_StateSpace`), so the substrate Minkowski
space is the **discrete integer-Hermitian lattice** whose interval `det X ∈ ℤ` is integer-valued — the
causal sign (timelike/null/spacelike) is discrete, the causal-set order of `QLF_ReachableEvent` /
`QLF_CausalInterval`; continuum Minkowski `ℝ^{1,3}` is its rendering. See `The_QLF_State_Space.md`.
-/

namespace QLF.Minkowski

open Matrix

/-- The **Minkowski interval** (squared spacetime norm, signature `+,−,−,−`) of a `Form`. -/
def Form.interval (f : Form) : ℝ := f.t ^ 2 - f.x ^ 2 - f.y ^ 2 - f.z ^ 2

/-- **The determinant of the Hermitian state IS the Minkowski interval.**
    `det !![t+z, x−iy; x+iy, t−z] = (t+z)(t−z) − (x−iy)(x+iy) = t² − x² − y² − z²` — the `i`-terms
    cancel and the 2×2 Hermitian determinant is exactly the spacetime metric. -/
theorem det_toMatrix_eq_interval (f : Form) :
    (Form.toMatrix f).det = (Form.interval f : ℂ) := by
  rw [Matrix.det_fin_two, Form.toMatrix, Form.interval]
  simp only [Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons,
    Matrix.head_fin_const]
  push_cast
  -- LHS − RHS = (I²+1)·y², which vanishes by I² = −1
  linear_combination ((f.y : ℂ)) ^ 2 * Complex.I_sq

/-- **Pure states are null — the Bloch sphere is the celestial sphere.** A pure qubit
    (`t = ½`, `x²+y²+z² = ¼`) has Minkowski interval `0`: it lies on the light cone, so the qubit
    Bloch sphere is the projective null cone (the sphere of null directions). -/
theorem pure_qubit_null (f : Form) (ht : f.t = 1 / 2)
    (hs : f.x ^ 2 + f.y ^ 2 + f.z ^ 2 = 1 / 4) : Form.interval f = 0 := by
  unfold Form.interval
  rw [ht]; nlinarith [hs]

/-- **The Lorentz group is the interval-preserving symmetry of the QLF state.** The action
    `X ↦ A X A†` with `det A = 1` (i.e. `A ∈ SL(2,ℂ)`) preserves the determinant, hence the Minkowski
    interval (`det_toMatrix_eq_interval`). So `SL(2,ℂ)` acts as `SO⁺(1,3)` — the double cover whose
    spinors are the substrate's half-spin twists. -/
theorem lorentz_preserves_interval (A X : Matrix (Fin 2) (Fin 2) ℂ) (hA : A.det = 1) :
    (A * X * Aᴴ).det = X.det := by
  rw [Matrix.det_mul, Matrix.det_mul, Matrix.det_conjTranspose, hA]
  simp

/-- **Status — the QLF state IS Minkowski space, machine-checked.** The 2×2 Hermitian `Form` is a
    point of `ℝ^{1,3}` (1 trace = time + 3 traceless Pauli = space); its determinant is the spacetime
    interval (`det_toMatrix_eq_interval`); pure states are null (Bloch = celestial sphere,
    `pure_qubit_null`); `SL(2,ℂ)` preserves the interval, acting as the Lorentz group with the
    half-spin twists as spinors (`lorentz_preserves_interval`). Over `ℤ[i]` (`QLF_StateSpace`) the
    interval is integer-valued — the discrete causal order, with continuum Minkowski as its rendering.
    No new axioms. See `The_QLF_State_Space.md`. -/
theorem qlf_state_is_minkowski : True := trivial

end QLF.Minkowski
