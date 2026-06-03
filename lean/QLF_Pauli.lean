-- QLF_Pauli.lean
-- Pauli scalar group: {+I, -I, +iI, -iI} closed under matrix multiplication.
--
-- Algebraic kernel of the runtime `is_pauli_closed` check in
-- `twist_core.py` and the `zfa-core` Rust kernel. The four scalar elements
-- form a cyclic group of order 4 (isomorphic to ℤ/4 with generator i)
-- under matrix multiplication. Pauli closure is therefore preserved under
-- concatenation of twist sequences whose folds land in this group.
--
-- Combined with `emergent_blanket_formation` in `QLF_QuCalc.lean`
-- (count-balance preserved under concatenation), this completes the
-- algebraic closure story for both halves of ZFA:
--
--     is_zfa s := is_count_balanced s ∧ is_pauli_closed s
--
-- Both halves are now Lean-anchored under concatenation (per
-- `Experimental_Consistency.md` §2.1 and `twist_core.py` since 8f02271).
--
-- Scope: this module captures the algebraic-kernel half. The full
-- hardware-mapping claim — that arbitrary admissible-balanced twist
-- sequences land in the Pauli scalar group when interpreted via the
-- 8-twist Pauli mapping — is a stronger statement that requires the
-- explicit twist-alphabet definition and remains separate work.

namespace QLF

/-- The Pauli scalar group `{+I, -I, +iI, -iI}` as a 4-element type.
    Each element is `i^k` for `k ∈ {0, 1, 2, 3}` representing a scalar
    multiple of the 2×2 identity matrix. Under matrix multiplication the
    four scalars form a cyclic group of order 4 (≃ ℤ/4). -/
inductive PauliScalar where
  | one        -- +I    (i⁰)
  | i          -- +iI   (i¹)
  | negOne     -- -I    (i²)
  | negI       -- -iI   (i³)
deriving BEq, DecidableEq, Repr

namespace PauliScalar

/-- Multiplication on the Pauli scalar group — equivalent to powers of i mod 4
    (cyclic). All 16 combinations enumerated explicitly to avoid pattern
    overlap. -/
def mul : PauliScalar → PauliScalar → PauliScalar
  | one,    one    => one
  | one,    i      => i
  | one,    negOne => negOne
  | one,    negI   => negI
  | i,      one    => i
  | i,      i      => negOne
  | i,      negOne => negI
  | i,      negI   => one
  | negOne, one    => negOne
  | negOne, i      => negI
  | negOne, negOne => one
  | negOne, negI   => i
  | negI,   one    => negI
  | negI,   i      => one
  | negI,   negOne => i
  | negI,   negI   => negOne

instance : Mul PauliScalar := ⟨mul⟩
instance : One PauliScalar := ⟨one⟩

/-- Multiplication is commutative (all four elements are scalar multiples of I). -/
theorem mul_comm (a b : PauliScalar) : a * b = b * a := by
  cases a <;> cases b <;> rfl

/-- Multiplication is associative. -/
theorem mul_assoc (a b c : PauliScalar) : (a * b) * c = a * (b * c) := by
  cases a <;> cases b <;> cases c <;> rfl

/-- `one` is the left identity. -/
theorem one_mul (a : PauliScalar) : (1 : PauliScalar) * a = a := by
  cases a <;> rfl

/-- `one` is the right identity. -/
theorem mul_one (a : PauliScalar) : a * (1 : PauliScalar) = a := by
  cases a <;> rfl

/-- Multiplicative inverse: every element has an inverse. -/
def inv : PauliScalar → PauliScalar
  | one    => one
  | i      => negI
  | negOne => negOne
  | negI   => i

theorem mul_inv (a : PauliScalar) : a * a.inv = 1 := by
  cases a <;> rfl

theorem inv_mul (a : PauliScalar) : a.inv * a = 1 := by
  cases a <;> rfl

end PauliScalar

/-- Pauli fold: cumulative product of a sequence of Pauli scalars,
    initialised at the multiplicative identity. -/
def pauli_fold : List PauliScalar → PauliScalar
  | []        => PauliScalar.one
  | x :: rest => x * pauli_fold rest

/-- Pauli fold is a multiplicative homomorphism: concatenation of two
    sequences multiplies their folds. -/
theorem pauli_fold_append (s₁ s₂ : List PauliScalar) :
    pauli_fold (s₁ ++ s₂) = pauli_fold s₁ * pauli_fold s₂ := by
  induction s₁ with
  | nil =>
    show pauli_fold s₂ = PauliScalar.one * pauli_fold s₂
    exact (PauliScalar.one_mul _).symm
  | cons head tail ih =>
    show head * pauli_fold (tail ++ s₂) = (head * pauli_fold tail) * pauli_fold s₂
    rw [ih, PauliScalar.mul_assoc]

/-- **Pauli closure under concatenation** — the algebraic kernel of the
    runtime `is_pauli_closed` check in `twist_core.py` and the `zfa-core`
    Rust kernel.

    Any sequence of Pauli scalars folds to a Pauli scalar (built into the
    type: `pauli_fold : List PauliScalar → PauliScalar`). Concatenation of
    two sequences multiplies their folds in the cyclic-order-4 Pauli
    scalar group; the group is closed under multiplication by construction
    (all 16 combinations in `PauliScalar.mul` return a `PauliScalar`).

    Combined with `emergent_blanket_formation` in `lean/QLF_QuCalc.lean`
    (count-balance preserved under concatenation), this completes the
    algebraic closure story for both halves of the runtime ZFA condition:

        is_zfa s := is_count_balanced s ∧ is_pauli_closed s

    Both halves are now Lean-anchored under concatenation.

    The full hardware-mapping claim — that arbitrary admissible-balanced
    twist sequences land in the Pauli scalar group when interpreted via
    the 8-twist Pauli mapping (`^v` ↔ ±σ_y, `<>` ↔ ∓σ_x, `/\` ↔ ±σ_z,
    `+-` ↔ ±I) — is a stronger statement that requires the explicit
    twist-alphabet definition and remains separate work; see
    `Experimental_Consistency.md` §2.1. -/
theorem pauli_closed_of_admissible_zfa
    (s₁ s₂ : List PauliScalar) :
    pauli_fold (s₁ ++ s₂) = pauli_fold s₁ * pauli_fold s₂ :=
  pauli_fold_append s₁ s₂

end QLF
