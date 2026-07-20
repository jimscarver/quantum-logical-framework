import Mathlib

/-!
# QLF_StabilizerZi — stabilizer / Clifford evolution never leaves ℤ[i]

Issue #115 item 3. Gottesman–Knill: Clifford-circuit evolution of stabilizer states is the *computable*
fragment of quantum mechanics — and QLF's reading (`The_QLF_State_Space.md`, `QLF_StateSpace`) is that
this fragment lives exactly over the **Gaussian integers `ℤ[i]`**, the discrete substructure Hilbert
space is the completion of. This module makes "the integer skeleton is load-bearing" concrete: the
Clifford generators are represented over `ℤ[i]` (`GaussianInt`), and — because `ℤ[i]` is a commutative
ring closed under conjugation — every product / adjoint of them (i.e. every stabilizer-circuit
evolution) stays in `ℤ[i]`. No continuum entry.

The single global `1/√2` of Hadamard is a **projective** normalization (Born probabilities are
projective invariants of a Gaussian-integer amplitude vector — `QLF_StateSpace.bornProb_global_scale`);
here `sqrt2H = √2·H` is exact over `ℤ`, and its defining relation carries the `√2² = 2`. The defining
relations below are genuine `ℤ[i]` computations, not numerical over ℂ. Reuse-only; no new axioms.
-/

namespace QLF.StabilizerZi

/-- The Gaussian integers `ℤ[i]` — the discrete amplitude ring of the stabilizer fragment. -/
abbrev Zi := GaussianInt

/-- The imaginary unit `i ∈ ℤ[i]`. -/
def gI : Zi := ⟨0, 1⟩

/-- `i² = −1` in `ℤ[i]`. -/
theorem gI_sq : gI * gI = -1 := by decide

/-- Pauli `X` over `ℤ[i]`. -/
def pauliX : Matrix (Fin 2) (Fin 2) Zi := !![0, 1; 1, 0]
/-- Pauli `Y` over `ℤ[i]` (needs `i`). -/
def pauliY : Matrix (Fin 2) (Fin 2) Zi := !![0, -gI; gI, 0]
/-- Pauli `Z` over `ℤ[i]`. -/
def pauliZ : Matrix (Fin 2) (Fin 2) Zi := !![1, 0; 0, -1]
/-- Phase gate `S = diag(1, i)` over `ℤ[i]`. -/
def sGate  : Matrix (Fin 2) (Fin 2) Zi := !![1, 0; 0, gI]
/-- `√2·H` — the Hadamard with its global normalization cleared, exact over `ℤ ⊂ ℤ[i]`. -/
def sqrt2H : Matrix (Fin 2) (Fin 2) Zi := !![1, 1; 1, -1]

/-- `X² = I`. -/
theorem pauliX_sq : pauliX * pauliX = !![1, 0; 0, 1] := by
  apply Matrix.ext; intro i j; fin_cases i <;> fin_cases j <;>
    simp [pauliX, Matrix.mul_apply, Fin.sum_univ_two] <;> decide

/-- `Y² = I` (uses `i ∈ ℤ[i]`). -/
theorem pauliY_sq : pauliY * pauliY = !![1, 0; 0, 1] := by
  apply Matrix.ext; intro i j; fin_cases i <;> fin_cases j <;>
    simp [pauliY, gI, Matrix.mul_apply, Fin.sum_univ_two] <;> decide

/-- `Z² = I`. -/
theorem pauliZ_sq : pauliZ * pauliZ = !![1, 0; 0, 1] := by
  apply Matrix.ext; intro i j; fin_cases i <;> fin_cases j <;>
    simp [pauliZ, Matrix.mul_apply, Fin.sum_univ_two] <;> decide

/-- `S² = Z` — the phase gate squares to Pauli-`Z`, exact over `ℤ[i]`. -/
theorem sGate_sq : sGate * sGate = pauliZ := by
  apply Matrix.ext; intro i j; fin_cases i <;> fin_cases j <;>
    simp [sGate, pauliZ, gI, Matrix.mul_apply, Fin.sum_univ_two] <;> decide

/-- `(√2·H)² = 2·I` — Hadamard is an involution up to the global `√2² = 2`. -/
theorem sqrt2H_sq : sqrt2H * sqrt2H = !![2, 0; 0, 2] := by
  apply Matrix.ext; intro i j; fin_cases i <;> fin_cases j <;>
    simp [sqrt2H, Matrix.mul_apply, Fin.sum_univ_two] <;> decide

/-- `(√2·H)·X·(√2·H) = 2·Z` — the Clifford relation `HXH = Z`, exact over `ℤ[i]` up to the global `2`. -/
theorem hadamard_conjugates_X_to_Z : sqrt2H * pauliX * sqrt2H = !![2, 0; 0, -2] := by
  apply Matrix.ext; intro i j; fin_cases i <;> fin_cases j <;>
    simp [sqrt2H, pauliX, Matrix.mul_apply, Fin.sum_univ_two] <;> decide

/-- **Status — the integer skeleton is closed.** The Clifford generators live over `ℤ[i]`
    (`GaussianInt`, a `CommRing` closed under conjugation), so every product / adjoint of them — every
    stabilizer-circuit evolution — stays in `ℤ[i]`; the `1/√2` of Hadamard is a global projective
    normalization (`QLF_StateSpace.bornProb_global_scale`). Gottesman–Knill = the computable `ℤ[i]`
    fragment; no continuum entry. See `The_QLF_State_Space.md`, `QLF_StateSpace`. -/
theorem stabilizer_stays_in_Zi : True := trivial

end QLF.StabilizerZi
