import QLF_TwistAlphabet
import QLF_AlgebraEmergence
import QLF_Realizability
import Mathlib

/-!
# QLF_EmergenceChain — the emergence forcing chain, assembled

Answers "can ZFA *emerge* from the one premise, and *will* it emerge in a possibilist logical realm?"
by chaining results that are **already proven elsewhere** into a single stated forcing chain — reuse
only, no new axioms. The point is to show how far the emergence proof already reaches, and to name the
residue precisely.

The chain, from the bare premise (a possibilist, logically-consistent, finite-information realm):

* **Link 1 — discreteness is forced.** A finite-information realm admits no injection from an infinite
  state space, so no continuum is realized (`no_continuum_in_finite_region`, `QLF_Realizability`). The
  realized realm is discrete.
* **Link 2 — balanced closure folds to the algebra.** Every count-balanced history folds, under the
  8-twist Pauli mapping, to a fold-target element `p` (`count_balanced_pauli_closed`,
  `QLF_TwistAlphabet`) — the closure condition *forces* the algebraic invariant, it is not posited.
* **Link 3 — the fold-target IS the μ₄ invariant `ℤ/4`.** The fold multiplication carries to `ℤ/4`
  addition (`toZMod_hom`), faithfully (`toZMod_injective`, `QLF_AlgebraEmergence`) — the closure
  algebra is the cyclic group `μ₄ = (ℤ[i])ˣ`, **derived from the fold, not imported**.

So the ZFA closure **invariant** (discreteness + balanced closure + its μ₄ algebra) emerges by
construction. Per the invariant-vs-machine reframing (`Completeness_Evidence.md` §0), "ZFA will emerge"
means this *invariant* is forced — NOT that the 8-twist *machine* is the unique substrate (multiple
realizability: many alphabets realize one invariant; `comparison_isomorphism`, `QLF_Motives`).

**Honest scope (the open residue).** This assembles proven links; it does **not** close the two hard
steps: *why this alphabet* (the 8-twist / 6+2 split as forced — issue #116, α-rigidity) and the full
*Gleason-hard uniqueness* (any structure meeting the ZFA-free postulates is isomorphic to ZFA in the
non-distributive orthomodular case — issue #118, `Completeness_Evidence.md` §6). What is proven here is
the *necessary-condition* spine, retargeted to the invariant.
-/

namespace QLF.EmergenceChain

open QLF QLF.AlgebraEmergence

/-- **Link 1 — discreteness is forced.** A finite-information realm (`Finite R`) cannot faithfully
    carry an infinite state space (`Infinite S`): no injection exists. So a possibilist *realized*
    realm is discrete — no continuum survives. Reuses `no_continuum_in_finite_region`. -/
theorem realized_realm_discrete {S R : Type*} [Infinite S] [Finite R] (realize : S → R) :
    ¬ Function.Injective realize :=
  QLF.Realizability.no_continuum_in_finite_region realize

/-- **Link 2 — balanced closure folds to the algebra.** Every count-balanced history folds to a
    fold-target element `p`. The closure condition forces the algebraic invariant. Reuses
    `count_balanced_pauli_closed`. -/
theorem closure_folds_to_scalar {ts : List Twist} (h : countBalanced ts) :
    ∃ p : PauliScalar, twistMatrixFold ts = pauliScalarToMatrix p :=
  count_balanced_pauli_closed h

/-- **Link 3 — the fold-target is the μ₄ invariant `ℤ/4`.** The fold multiplication is `ℤ/4` addition
    (`toZMod_hom`), faithfully (`toZMod_injective`) — the closure algebra is the cyclic group of order
    4, derived not imported. -/
theorem foldTarget_is_mu4 :
    (∀ a b : PauliScalar, toZMod (a * b) = toZMod a + toZMod b) ∧ Function.Injective toZMod :=
  ⟨toZMod_hom, toZMod_injective⟩

/-- **The emergence forcing chain (assembled).** For any count-balanced closure, the closure folds to a
    fold-target element `p` (Link 2), and the fold-target is the cyclic group `ℤ/4 = μ₄` — the fold
    multiplication realized as `ℤ/4` addition, faithfully (Link 3). So the ZFA closure *invariant*
    emerges by construction, reusing only proven theorems. Discreteness of the realized realm (Link 1)
    is `realized_realm_discrete`. -/
theorem emergence_chain {ts : List Twist} (h : countBalanced ts) :
    (∃ p : PauliScalar, twistMatrixFold ts = pauliScalarToMatrix p)
      ∧ (∀ a b : PauliScalar, toZMod (a * b) = toZMod a + toZMod b)
      ∧ Function.Injective toZMod :=
  ⟨count_balanced_pauli_closed h, toZMod_hom, toZMod_injective⟩

/-- **Status — the invariant emerges; the machine is not (and need not be) forced.** The chain above
    is proven (reuse-only). What stays open is *why this alphabet* (#116) and the full Gleason-hard
    postulates→ZFA isomorphism (#118) — uniqueness of the *invariant*, not of the implementation. See
    `Completeness_Evidence.md` §6, `Mathematics_From_QLF.md`. -/
theorem emergence_chain_summary : True := trivial

end QLF.EmergenceChain
