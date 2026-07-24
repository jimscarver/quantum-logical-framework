import QLF_LorentzCover

set_option linter.unusedVariables false

/-!
# QLF_LorentzGeneration — the round-trip lemmas (toward eliminating the Lorentz-cover axiom)

The concrete Lean path to discharging `lorentz_generated_by_boosts_rotations` (`QLF_LorentzCover`)
runs: **round-trip lemmas → spinor-image submonoid → real-matrix KAK generation**. This module lands
the first rungs — the `Form ↔ Matrix` round-trips that the whole reduction rests on.

* `fromMatrix_toMatrix` — the **forward round-trip** `Form.fromMatrix f.toMatrix = f`: the coordinate
  reader inverts the matrix builder.
* `spinorAct_isHermitian` — the spinor action `X ↦ A X A†` preserves Hermiticity, so a realized
  intermediate state is again a genuine `Form` matrix (needed to *chain* realizations).

Couched in the **Witten 1988 → Reshetikhin–Turaev mode** (`Millennium.md`): the physics core is proven
and the single remaining bridge is settled Lie theory (the KAK/Cartan generation of `SO⁺(1,3)`). These
lemmas begin turning that settled-math bridge into an in-Lean theorem. **Next rungs:** the *reverse*
round-trip `toMatrix_fromMatrix` on Hermitian matrices, the realized-image submonoid
(`Realizes 1 1`, `Realizes A₁ Λ₁ → Realizes A₂ Λ₂ → Realizes (A₁A₂) (Λ₁Λ₂)`), then the real-matrix
generation. No new axioms.
-/

namespace QLF.LorentzGeneration

open Matrix Complex QLF.LorentzCover

/-- **The forward round-trip: `fromMatrix ∘ toMatrix = id`.** The coordinate reader recovers the
    `Form` from its Minkowski matrix. -/
theorem fromMatrix_toMatrix (f : Form) : Form.fromMatrix f.toMatrix = f := by
  obtain ⟨t, x, y, z⟩ := f
  have m00 : Form.toMatrix ⟨t, x, y, z⟩ 0 0 = (↑t + ↑z : ℂ) := by
    simp only [Form.toMatrix, Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons,
      Matrix.of_apply, Matrix.cons_val', Matrix.empty_val', Matrix.cons_val_fin_one,
      Matrix.head_fin_const]
  have m11 : Form.toMatrix ⟨t, x, y, z⟩ 1 1 = (↑t - ↑z : ℂ) := by
    simp only [Form.toMatrix, Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons,
      Matrix.of_apply, Matrix.cons_val', Matrix.empty_val', Matrix.cons_val_fin_one,
      Matrix.head_fin_const]
  have m01 : Form.toMatrix ⟨t, x, y, z⟩ 0 1 = (↑x - I * ↑y : ℂ) := by
    simp only [Form.toMatrix, Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons,
      Matrix.of_apply, Matrix.cons_val', Matrix.empty_val', Matrix.cons_val_fin_one,
      Matrix.head_fin_const]
  have m10 : Form.toMatrix ⟨t, x, y, z⟩ 1 0 = (↑x + I * ↑y : ℂ) := by
    simp only [Form.toMatrix, Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons,
      Matrix.of_apply, Matrix.cons_val', Matrix.empty_val', Matrix.cons_val_fin_one,
      Matrix.head_fin_const]
  have ht : ((↑t + ↑z : ℂ) + (↑t - ↑z)) / 2 = (↑t : ℂ) := by ring
  have hx : ((↑x - I * ↑y : ℂ) + (↑x + I * ↑y)) / 2 = (↑x : ℂ) := by ring
  have hy : (I * ((↑x - I * ↑y : ℂ) - (↑x + I * ↑y))) / 2 = (↑y : ℂ) := by
    linear_combination (-(↑y : ℂ)) * Complex.I_sq
  have hz : ((↑t + ↑z : ℂ) - (↑t - ↑z)) / 2 = (↑z : ℂ) := by ring
  simp only [Form.fromMatrix, m00, m11, m01, m10, ht, hx, hy, hz, Complex.ofReal_re]

/-- **The spinor action preserves Hermiticity.** If `X` is Hermitian then `X ↦ A X A†` is Hermitian —
    so a realized intermediate state `A₂ · f.toMatrix · A₂†` is again a `Form` matrix (Hermitian),
    which is what lets realizations *chain* (`Realizes` composition, next rung). -/
theorem spinorAct_isHermitian (A X : Matrix (Fin 2) (Fin 2) ℂ) (hX : Xᴴ = X) :
    (spinorAct A X)ᴴ = spinorAct A X := by
  simp only [spinorAct, Matrix.conjTranspose_mul, Matrix.conjTranspose_conjTranspose, hX,
    Matrix.mul_assoc]

/-- A `Form`'s matrix is Hermitian (special case, reusing `Form.toMatrix_adjoint`). -/
theorem toMatrix_isHermitian (f : Form) : (f.toMatrix)ᴴ = f.toMatrix :=
  f.toMatrix_adjoint

/-- Status: the forward round-trip and Hermiticity preservation are proven — the first rungs of the
    Lorentz-axiom discharge. The reverse Hermitian round-trip + the realized-image submonoid + the
    real-matrix KAK generation are the remaining rungs (couched in the Witten-1988 mode). -/
theorem lorentz_roundtrip_started : True := trivial

end QLF.LorentzGeneration
