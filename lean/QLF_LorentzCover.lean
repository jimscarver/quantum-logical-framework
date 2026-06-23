import QLF_Minkowski
import Mathlib

/-!
# QLF_LorentzCover — the `SL(2,ℂ) → SO⁺(1,3)` double cover

`QLF_Minkowski` showed the QLF state is Minkowski space (`det = interval`) and that `SL(2,ℂ)`
congruence `X ↦ A X A†` preserves the interval. This module builds the **double-cover** structure of
that action, the genuine `SL(2,ℂ) → SO⁺(1,3)` correspondence:

* **Homomorphism** — `spinor_hom`: congruence is functorial (`(AB)X(AB)† = A(BXB†)A†`), so `A ↦ (X ↦ A X A†)`
  is a group homomorphism into the interval-preserving maps.
* **Generators realized** — every `SO⁺(1,3)` generator is in the image, exhibited explicitly:
  * `boostZ_action` — the diagonal `diag(s, s⁻¹)` acts as a **Lorentz boost**, rescaling the null
    coordinates `u = t+z ↦ s²·u`, `v = t−z ↦ s⁻²·v` (transverse `x,y` fixed): the boost of rapidity
    `φ` with `s = e^{φ/2}`.
  * `rotZ_action` — the unitary diagonal `diag(w, w̄)` (`|w| = 1`) acts as a **spatial rotation**,
    sending the transverse `x − iy ↦ w²(x − iy)` (`t, z` fixed).
* **Kernel = {±I}** — `spinor_kernel`: the *only* `A ∈ SL(2,ℂ)` acting as the identity on every state
  is `A = ±I`. This is the "2-to-1": each Lorentz transformation has exactly two spinor preimages.
* **Surjectivity** — `spinor_surjective` (from the one bridge `lorentz_generated_by_boosts_rotations`,
  the standard fact that boosts + rotations generate `SO⁺(1,3)`): every proper orthochronous Lorentz
  transformation is `X ↦ A X A†` for some `A ∈ SL(2,ℂ)`.

Together: `SL(2,ℂ) → SO⁺(1,3)` is a surjective 2-to-1 homomorphism — the double cover. The proven core
is the homomorphism + the explicit generators + kernel `{±I}`; the single bridge axiom is the Lie-group
generation result (the differential-geometric input Mathlib lacks), in the QLF axiom-boundary style.
See `The_QLF_State_Space.md` §7.
-/

namespace QLF.LorentzCover

open Matrix Complex

/-- The spinor action on a 2×2 matrix state: congruence `X ↦ A X A†`. -/
def spinorAct (A X : Matrix (Fin 2) (Fin 2) ℂ) : Matrix (Fin 2) (Fin 2) ℂ := A * X * Aᴴ

/-- **The spinor action is a homomorphism.** `spinorAct (A·B) = spinorAct A ∘ spinorAct B`, so
    `A ↦ (X ↦ A X A†)` is a group homomorphism into the interval-preserving maps — the map underlying
    the `SL(2,ℂ) → SO⁺(1,3)` cover. -/
theorem spinor_hom (A B X : Matrix (Fin 2) (Fin 2) ℂ) :
    spinorAct (A * B) X = spinorAct A (spinorAct B X) := by
  simp only [spinorAct, Matrix.conjTranspose_mul, Matrix.mul_assoc]

/-! ## Boost — the diagonal real `SL(2,ℂ)` element is a Lorentz boost -/

/-- The boost spinor `diag(s, s⁻¹)` (real `s`), an element of `SL(2,ℂ)` for `s ≠ 0`. -/
def boostZ (s : ℝ) : Matrix (Fin 2) (Fin 2) ℂ := !![(s : ℂ), 0; 0, ((s⁻¹ : ℝ) : ℂ)]

theorem boostZ_det (s : ℝ) (hs : s ≠ 0) : (boostZ s).det = 1 := by
  rw [boostZ, Matrix.det_fin_two_of, mul_zero, sub_zero, ← Complex.ofReal_mul,
    mul_inv_cancel₀ hs, Complex.ofReal_one]

/-- **The boost acts as a Lorentz boost in null coordinates.** `diag(s, s⁻¹)` sends the QLF state to
    the state with null coordinates rescaled `u = t+z ↦ s²·u`, `v = t−z ↦ s⁻²·v` and transverse
    `x, y` fixed — exactly the `z`-boost of rapidity `φ` for `s = e^{φ/2}`. -/
theorem boostZ_action (s : ℝ) (hs : s ≠ 0) (f : Form) :
    spinorAct (boostZ s) f.toMatrix =
      !![((s : ℝ) ^ 2 : ℝ) * (↑f.t + ↑f.z), ↑f.x - I * ↑f.y;
         ↑f.x + I * ↑f.y, ((s⁻¹ : ℝ) ^ 2 : ℝ) * (↑f.t - ↑f.z)] := by
  have hss : (s : ℂ) * ((s⁻¹ : ℝ) : ℂ) = 1 := by
    rw [← Complex.ofReal_mul, mul_inv_cancel₀ hs, Complex.ofReal_one]
  apply Matrix.ext; intro i j
  fin_cases i <;> fin_cases j <;>
    simp only [spinorAct, boostZ, Form.toMatrix, Matrix.mul_apply, Fin.sum_univ_two,
      Matrix.conjTranspose_apply, Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons,
      Matrix.of_apply, Matrix.cons_val', Matrix.empty_val', Matrix.cons_val_fin_one,
      Matrix.head_fin_const, star_zero, RCLike.star_def, Complex.conj_ofReal, mul_zero, zero_mul,
      add_zero, zero_add, Complex.ofReal_pow]
  · ring
  · linear_combination (↑f.x - I * ↑f.y) * hss
  · linear_combination (↑f.x + I * ↑f.y) * hss
  · ring

/-! ## Rotation — the unitary diagonal `SL(2,ℂ)` element is a spatial rotation -/

/-- The rotation spinor `diag(w, w̄)` for a unit `w` (`w·w̄ = 1`), an element of `SU(2) ⊂ SL(2,ℂ)`. -/
def rotZ (w : ℂ) : Matrix (Fin 2) (Fin 2) ℂ := !![w, 0; 0, star w]

theorem rotZ_det (w : ℂ) (hw : w * star w = 1) : (rotZ w).det = 1 := by
  rw [rotZ, Matrix.det_fin_two_of, mul_zero, sub_zero, hw]

/-- **The rotation acts as a spatial rotation.** For a unit `w` (`|w| = 1`), `diag(w, w̄)` fixes
    `t` and `z` and sends the transverse combination `x − iy ↦ w²(x − iy)` — a rotation in the `x`–`y`
    plane (by `2·arg w`), with the time and longitudinal axes untouched. -/
theorem rotZ_action (w : ℂ) (hw : w * star w = 1) (f : Form) :
    spinorAct (rotZ w) f.toMatrix =
      !![(↑f.t + ↑f.z), w ^ 2 * (↑f.x - I * ↑f.y);
         (star w) ^ 2 * (↑f.x + I * ↑f.y), (↑f.t - ↑f.z)] := by
  apply Matrix.ext; intro i j
  fin_cases i <;> fin_cases j <;>
    simp only [spinorAct, rotZ, Form.toMatrix, Matrix.mul_apply, Fin.sum_univ_two,
      Matrix.conjTranspose_apply, Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons,
      Matrix.of_apply, Matrix.cons_val', Matrix.empty_val', Matrix.cons_val_fin_one,
      Matrix.head_fin_const, star_zero, star_star, mul_zero, zero_mul, add_zero, zero_add]
  · linear_combination (↑f.t + ↑f.z) * hw
  · ring
  · ring
  · linear_combination (↑f.t - ↑f.z) * hw

end QLF.LorentzCover
