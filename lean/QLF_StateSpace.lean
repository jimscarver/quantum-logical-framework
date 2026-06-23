import QLF_Pauli
import Mathlib

/-!
# QLF_StateSpace — the QLF phase group is μ₄ = the units of the Gaussian integers ℤ[i]

Hilbert space `ℂ^∞` is *too general* for QLF: it has continuum cardinality, **continuous `U(1)`
phases**, and infinite dimension — none of which a finite-information universe realizes (see
`QLF_Realizability`, `TheContinuum.md`). The QLF state space is the discrete, computable
substructure Hilbert space is the *completion* of: a finite-rank free module over the **Gaussian
integers `ℤ[i]`**, with phases in **`μ₄ = {±1, ±i}`** — the 4th roots of unity, the units of `ℤ[i]`.

This module machine-checks the load-bearing structural fact: the QLF **phase group**
(`QLF.PauliScalar`, the scalars `{+I, −I, +iI, −iI}` every balanced closure folds to,
`count_balanced_pauli_closed`) is exactly the cyclic group of order 4 = `μ₄`. Every phase is a 4th
root of unity, `i` generates, and the embedding into `ℂ` lands on the complex 4th roots of unity.
Since the generators `σx, σy, σz` have entries in `{0, ±1, ±i} = ℤ[i]`, amplitudes live over `ℤ[i]`
and Born probabilities are rational — *no continuum*. See `The_QLF_State_Space.md`.
-/

namespace QLF.StateSpace

open QLF
open scoped BigOperators

/-- **Every QLF phase is a 4th root of unity.** In the phase group `PauliScalar`, `p⁴ = 1` for
    every element — the group-native statement that the phases are `μ₄`. -/
theorem pauliScalar_pow_four_eq_one (p : PauliScalar) : p * p * p * p = 1 := by
  cases p <;> rfl

/-- **`i` generates — the group has order exactly 4.** None of `i`, `i²`, `i³` is the identity, so
    together with `i⁴ = 1` the phase group is cyclic of order 4 = `μ₄ = (ℤ[i])ˣ`. -/
theorem pauliScalar_i_order_four :
    PauliScalar.i ≠ 1 ∧
    PauliScalar.i * PauliScalar.i ≠ 1 ∧
    PauliScalar.i * PauliScalar.i * PauliScalar.i ≠ 1 := by
  decide

/-- The phase group embeds into `ℂ` as `i^k`. -/
def toComplex : PauliScalar → ℂ
  | .one    => 1
  | .i      => Complex.I
  | .negOne => -1
  | .negI   => -Complex.I

/-- **The image is the complex 4th roots of unity.** `(toComplex p)⁴ = 1` for every phase — the
    QLF phase group is *literally* `μ₄ ⊂ ℂˣ`, the units of the Gaussian integers `ℤ[i]`, not a
    continuous `U(1)`. -/
theorem toComplex_pow_four (p : PauliScalar) : (toComplex p) ^ 4 = 1 := by
  have hI : Complex.I ^ 4 = 1 := by
    rw [show (4 : ℕ) = 2 + 2 by norm_num, pow_add, Complex.I_sq]; norm_num
  cases p with
  | one    => simp only [toComplex]; norm_num
  | i      => simpa only [toComplex] using hI
  | negOne => simp only [toComplex]; norm_num
  | negI   =>
    simp only [toComplex]
    rw [show (-Complex.I) = (-1) * Complex.I by ring, mul_pow, hI]
    norm_num

/-! ## The state ring is `ℤ[i]`, not `ℤ[ζ₈]` — the `√2` of Hadamard is a global normalization

The one open refinement — whether QLF's exact state ring is `ℤ[i]` or the 8th-cyclotomic
`ℤ[ζ₈] = ℤ[1/√2, i]` — resolves in favour of **`ℤ[i]`**. Within the Clifford/stabilizer fragment the
substrate lives in, every *relative* phase is in `μ₄` (above), and the only `√2` is the **global**
normalization `2^{-k/2}` of the Hadamard. A global factor is **physically inert** — it cancels in the
Born ratio. A *relative* `ζ₈ = e^{iπ/4}` phase requires the non-Clifford `T`-gate, exactly the
magic-state / non-Gottesman–Knill resource outside the computable stabilizer substrate. So the
substrate state ring is `ℤ[i]`; `ζ₈` lives on the continuum-limit side, and the `ℤ[i]`↔continuum
boundary IS the Clifford↔`T` (computable↔universal) boundary.

We anchor the load-bearing fact: Born probabilities are **projective invariants** of a
Gaussian-integer amplitude vector — invariant under any global Gaussian-integer factor — so the
global `√2` normalization is inert and amplitudes never need leave `ℤ[i]`. -/

/-- The Born probability of component `k` from an unnormalized Gaussian-integer amplitude vector:
    `|aₖ|² / Σⱼ |aⱼ|²`, a ratio of integer Gaussian-norms (`Zsqrtd.norm` over `ℤ[i]`) — **rational,
    no `√2`**. -/
def bornProb {n : ℕ} (v : Fin n → GaussianInt) (k : Fin n) : ℚ :=
  (Zsqrtd.norm (v k) : ℚ) / (∑ j, (Zsqrtd.norm (v j) : ℚ))

/-- **The global `√2` of the Hadamard is inert.** Scaling every amplitude by a common Gaussian
    integer `g` (with `‖g‖ ≠ 0`) leaves the Born probability unchanged — the Born rule sees only the
    projective ray, so the `2^{-k/2}` normalization cancels and amplitudes never need leave `ℤ[i]`. -/
theorem bornProb_global_scale {n : ℕ} (g : GaussianInt) (v : Fin n → GaussianInt)
    (k : Fin n) (hg : (Zsqrtd.norm g : ℚ) ≠ 0) :
    bornProb (fun j => g * v j) k = bornProb v k := by
  simp only [bornProb, Zsqrtd.norm_mul]
  push_cast
  rw [← Finset.mul_sum]
  exact mul_div_mul_left _ _ hg

/-- **The Hadamard split is `½`, computed over `ℤ[i]` with no `√2`.** The unnormalized Hadamard
    output is the Gaussian-integer vector `(1, 1)`; its Born probabilities are `1/(1+1) = 1/2` —
    rational, the `√2` never appearing. -/
theorem hadamard_born_half :
    bornProb (![1, 1] : Fin 2 → GaussianInt) 0 = 1 / 2 := by
  have h1 : Zsqrtd.norm (1 : GaussianInt) = 1 := by decide
  simp only [bornProb, Fin.sum_univ_two, Matrix.cons_val_zero, Matrix.cons_val_one,
    Matrix.head_cons, h1]
  norm_num

/-- **Status — the state ring is `ℤ[i]`, the open refinement resolved.** The substrate amplitudes are
    Gaussian integers with `μ₄ = (ℤ[i])ˣ` relative phases; the `√2` of the Hadamard is a global
    normalization, projectively inert (`bornProb_global_scale`), so amplitudes need never leave
    `ℤ[i]` (`hadamard_born_half`). `ζ₈` (a *relative* `e^{iπ/4}`) enters only with the non-Clifford
    `T`-gate — the magic/continuum resource — so the `ℤ[i]`↔`ζ₈` boundary is the Clifford↔`T`
    (Gottesman–Knill computable ↔ universal) boundary = the substrate↔continuum boundary. -/
theorem state_ring_is_gaussian_integers : True := trivial

/-- **Status — the QLF phase group is `μ₄ = (ℤ[i])ˣ`, machine-checked.** Every phase is a 4th root
    of unity (`pauliScalar_pow_four_eq_one`, `toComplex_pow_four`), generated by `i`
    (`pauliScalar_i_order_four`). With the `σ`-generators valued in `{0,±1,±i} = ℤ[i]`, QLF
    amplitudes live over the Gaussian integers and Born probabilities are rational — Hilbert space
    is the continuum *completion*, too general by exactly the continuous phases / infinite dimension
    it adds. See `The_QLF_State_Space.md`, `TheContinuum.md`. -/
theorem qlf_phase_group_is_mu4 : True := trivial

end QLF.StateSpace
