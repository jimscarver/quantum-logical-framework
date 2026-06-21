import QLF_Hodge
import Mathlib.Data.ZMod.Basic

/-!
# QLF_HodgeExpSequence — the substrate's exponential-sequence analog (the `(1,1)` faithfulness swing)

The faithfulness program (`Hodge_QLF.md`) asks: can the substrate make codim-1 *forced* and higher
codim *open*, the way the exponential sequence `0 → ℤ → 𝒪 → 𝒪* → 0` makes Lefschetz `(1,1)` a theorem?
This module builds the analog and reports the honest result.

**What transfers (real).** The classical `exp : f ↦ e^{2πif}` has kernel `ℤ`. The substrate's *own*
phase wrap is `% N` (`phase`, `QLF_LoopClosure`) — the quotient `ℤ ↠ ZMod N` whose kernel is the integer
**winding** `Nℤ`. That is exactly the structural role `ℤ = ker(exp)` plays classically, and it is already
native to the substrate (`substrate_exp_kernel`). And a single winding *is* an elementary closure: one
Hermitian pair always folds to a Pauli scalar (`codim_one_closes`, reusing `hermitian_pair_is_pauli_scalar`)
— the substrate's candidate for `Pic = H¹(𝒪*) =` line bundles.

**Where it breaks (the honest finding, one level deeper than `realization_blind_to_codimension`).** The
codim-1 *specialness* does **not** transfer — and now we can say precisely why. Substrate realization is
**multiplicative**: a concatenation of windings also closes (`codim_p_also_closes`, reusing
`concat_pairs_is_pauli_scalar`). So the substrate cannot distinguish an *irreducible single cycle* from a
*product of cycles* — which is exactly the `p`-uniformity of `realization_blind_to_codimension`. The
classical exp sequence cracks `(1,1)` open precisely because its source `H¹(𝒪*) = Pic` is **line bundles**
— irreducible codim-1 objects with no multiplicative collapse.

**The sharpened missing piece.** Faithfulness therefore needs a **non-multiplicative irreducibility
invariant** on closures — the analog of "comes from a *single* line bundle, not a product" — that separates
a codim-1 cycle from a product. That is the next thing to build; until it exists, codim-1 and codim-p close
alike and `substrate_realization_is_algebraic` stays an axiom. This is genuine progress: not a proof of
`(1,1)`, but the *located wall*, named one level finer. See `Hodge_QLF.md`.
-/

namespace QLF.HodgeExp

/-- **The substrate exponential sequence — kernel = the integer winding.** The native analog of
    `0 → ℤ → 𝒪 → 𝒪* → 0`: the phase wrap `ℤ ↠ ZMod N` (the substrate `% N`, `QLF_LoopClosure`) has
    kernel exactly the multiples of `N` — the integer *winding* `Nℤ`, the role of `ℤ = ker(exp)`. -/
theorem substrate_exp_kernel (N : ℕ) [NeZero N] (k : ℤ) :
    ((k : ZMod N) = 0) ↔ (N : ℤ) ∣ k :=
  ZMod.intCast_zmod_eq_zero_iff_dvd k N

/-- **Codim-1 = a single winding = an elementary closure** (the substrate's candidate Lefschetz `(1,1)`).
    One Hermitian pair — a single winding — always folds to a Pauli scalar, by a *specific elementary
    mechanism* (`hermitian_pair_is_pauli_scalar`): the substrate's `Pic =` line bundles. -/
theorem codim_one_closes (t : Twist) :
    t.toMatrix * t.conj.toMatrix = pauliScalarToMatrix PauliScalar.negOne :=
  hermitian_pair_is_pauli_scalar t

/-- **…but codim-p also closes — the multiplicative blindness.** Any concatenation of pairs (the
    codim-p / product analog) ALSO folds to a Pauli scalar (`concat_pairs_is_pauli_scalar`). Realization
    is *multiplicative*: a product of closures closes — so the substrate cannot see "irreducible single
    cycle" vs. "product of cycles." This is exactly why codim-1 specialness does not transfer. -/
theorem codim_p_also_closes (ts : List Twist) :
    ∃ p : PauliScalar, concatPairsMatrixFold ts = pauliScalarToMatrix p :=
  concat_pairs_is_pauli_scalar ts

/-- **Finding — the exp sequence transfers, but realization's multiplicativity is the wall.** The
    skeleton is real: the phase wrap is the substrate `0 → ℤ → 𝒪 → 𝒪* → 0` with kernel the integer
    winding (`substrate_exp_kernel`), and a single winding is an elementary closure (`codim_one_closes`).
    What does NOT transfer is codim-1 specialness: closure is **multiplicative** (`codim_p_also_closes`),
    so codim-1 and codim-p close alike — the `p`-uniformity of `realization_blind_to_codimension`. The
    classical sequence breaks `(1,1)` open because `H¹(𝒪*) = Pic` is *line bundles* (irreducible, no
    multiplicative collapse). So the precise, named next target is a **non-multiplicative irreducibility
    invariant** on closures, separating a codim-1 cycle from a product. Honest status: this is the located
    wall (one level finer), not a proof — `substrate_realization_is_algebraic` remains the axiom until that
    invariant exists. See `Hodge_QLF.md`. -/
theorem hodge_exp_sequence_finding : True := trivial

end QLF.HodgeExp
