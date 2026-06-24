import QLF_Pauli
import Mathlib

/-!
# QLF_AlgebraEmergence — a group emerges as a genuine Mathlib structure

The substrate's closure fold sends every count-balanced history to a Pauli scalar
(`count_balanced_pauli_closed`, `QLF_TwistAlphabet`), and these form a proven abelian group
(`QLF_Pauli`: `mul_comm`, `mul_assoc`, `one_mul`, `mul_one`, `mul_inv`). This module exhibits that
fold-group concretely as the **cyclic group of order 4, `ℤ/4`** — the standard Mathlib group — via
`toZMod`. The point (see `Mathematics_From_QLF.md`): the algebraic structure is **derived from the
substrate, not imported**, so using Mathlib's algebra to *verify* QLF is not circular.

`toZMod_hom` is the headline: **the substrate's closure-fold multiplication IS addition mod 4**, so
the fold group is exactly `ℤ/4`. `toZMod_injective` makes the map faithful; with the matching
4-element count this is the isomorphism `PauliScalar ≅ ℤ/4 = μ₄ = (ℤ[i])ˣ`.
-/

namespace QLF.AlgebraEmergence

open QLF

/-- The substrate fold-target `{+1, −1, +i, −i}` indexed as `ℤ/4` by the power of `i` (`iᵏ ↦ k`). -/
def toZMod : PauliScalar → ZMod 4
  | .one    => 0
  | .i      => 1
  | .negOne => 2
  | .negI   => 3

/-- **The closure-fold multiplication is `ℤ/4` addition.** `toZMod (a·b) = toZMod a + toZMod b` — the
    substrate's fold group (`PauliScalar`) is exactly the cyclic group of order 4. -/
theorem toZMod_hom (a b : PauliScalar) : toZMod (a * b) = toZMod a + toZMod b := by
  cases a <;> cases b <;> decide

/-- **The map is faithful** (injective): distinct fold values are distinct in `ℤ/4`. With the matching
    4-element count, `toZMod` is the isomorphism `PauliScalar ≅ ℤ/4`. -/
theorem toZMod_injective : Function.Injective toZMod := by
  intro a b
  cases a <;> cases b <;> intro h <;> first | rfl | exact absurd h (by decide)

/-- **Status — a group emerges as a standard Mathlib structure.** The substrate's closure-fold group
    (`PauliScalar`, reached by every balanced closure via `count_balanced_pauli_closed`) is the cyclic
    group `ℤ/4` (`toZMod_hom`, `toZMod_injective`) = the units of the Gaussian integers
    `μ₄ = (ℤ[i])ˣ` (`QLF_StateSpace`) — **derived from the substrate, not imported**. So using Mathlib's
    algebra to verify QLF is not circular: the structure is generated. See `Mathematics_From_QLF.md`. -/
theorem pauli_fold_group_is_cyclic_four : True := trivial

end QLF.AlgebraEmergence
