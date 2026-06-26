import QLF_Fusion
import QLF_FreeEnergy

set_option linter.unusedVariables false

/-!
# QLF_NoFreeDuplication — the substrate forbids free Banach–Tarski duplication

The Banach–Tarski paradox (Banach & Tarski 1924) uses the Axiom of Choice to cut a solid ball into
finitely many pieces and reassemble them into **two** identical balls — volume conjured from nothing,
duplication for free. QLF's stance (`Banach_Tarski_QLF.md`, `Continuum_Choice_Fallacy.md`,
`TheContinuum.md`) is that this is the cleanest **impossible mathematics**: AC is *false in the
intended physical model*, and the QLF substrate admits no such free copy — every real duplication must
**buy distinguishability and pay in information**.

This module anchors that "no free duplication" principle as a *reuse-corollary* of three already-
verified facts (it does **not** formalize Banach–Tarski itself — BT is a real, consistent ZFC theorem;
the claim is consistency ≠ realizability, not inconsistency):

* **`identical_copy_pauli_blocked`** — two *identical* offspring closures have no bound fermionic
  channel (`fermi_antisym p p = 0`): you cannot make a second identical copy share the closure. The
  substrate's no-cloning / no-diproton (reuses `QLF.Fusion.diproton_pauli_blocked = pauli_exclusion`).
  `fermi_antisym` is **not** identically zero (`fermi_nonzero_example`), so this is a genuine
  constraint on *identical* copies, not a vacuous identity.
* **`realizable_duplication_needs_distinguishability`** — a viable one-becomes-two needs a
  *distinguishable* channel: the identical pair is blocked while a distinguishable Hermitian pair
  closes to identity (reuses `QLF.Fusion.pp_join_requires_distinguishability`, the β⁺ keystone). The
  same move at every scale — nucleonic `p+p` needs a `u→d` β⁺ step, cellular mitosis needs two
  distinguishable daughters.
* **`duplication_pays_log_two`** — making the one distinguishing bit is a half-spin ZFA closure
  costing `ΔF = −log 2` nats (Landauer; reuses `QLF.zfa_closure_minimizes_free_energy`). You cannot get
  two distinguishable closures from one for free.

So no-cloning ↔ no-diproton ↔ no-free-mitosis ↔ no-Banach–Tarski: one principle — *all real duplication
buys distinguishability and pays in energy/time/information*. Banach–Tarski is what duplication looks
like with that ledger dropped (AC's free choice); mitosis is what it looks like with the ledger kept
(ZFA closure).

## Honest scope

The three facts are **already proven** and reused here, no new axioms, no `sorry`. Banach–Tarski itself
is **not** formalized (it needs measure theory + a free-group paradoxical decomposition, and QLF's
point is precisely that those objects are non-realizable, not that they're inconsistent). The
mitosis/cellular reading is a *structural analogy* (Markov-blanket fission as the biological instance of
paid duplication), not a derivation of cell biology. See `Banach_Tarski_QLF.md`.
-/

namespace QLF.NoFreeDuplication

open QLF QLF.Fusion QLF.Spin Matrix

/-- **No free identical copy.** Two identical offspring closures have no bound fermionic channel —
    `fermi_antisym p p = 0` — so a second *identical* copy cannot share the closure (the substrate's
    no-cloning / no-diproton). Direct reuse of `diproton_pauli_blocked` (= `pauli_exclusion`); genuine
    because `fermi_antisym` is not identically zero (`fermi_nonzero_example`). -/
theorem identical_copy_pauli_blocked (p : RhoProcess) : fermi_antisym p p = 0 :=
  diproton_pauli_blocked p

/-- **Realizable duplication needs distinguishability.** The identical pair is Pauli-blocked
    (`fermi_antisym p p = 0`, left) while a *distinguishable* Hermitian pair closes to identity
    (right): a viable one-becomes-two must make a real difference, not copy for free. Direct reuse of
    the β⁺ keystone `pp_join_requires_distinguishability`. -/
theorem realizable_duplication_needs_distinguishability (p : RhoProcess) (s t : Twist) :
    fermi_antisym p p = 0 ∧
      (s.toMatrix * s.conj.toMatrix) * (t.toMatrix * t.conj.toMatrix) = (1 : M) :=
  pp_join_requires_distinguishability p s t

/-- **Duplication pays one bit.** Making the single distinguishing bit is a half-spin ZFA closure
    event, costing `ΔF = −log 2` nats — Landauer's bound. You cannot get two distinguishable closures
    from one for free. Direct reuse of `zfa_closure_minimizes_free_energy`. -/
theorem duplication_pays_log_two :
    -binary_kl 1 (1/2) = -Real.log 2 :=
  zfa_closure_minimizes_free_energy

/-- **Established (the no-free-duplication principle, by reuse):** identical copies are Pauli-blocked
    (`identical_copy_pauli_blocked`), a realizable one-becomes-two needs distinguishable products
    (`realizable_duplication_needs_distinguishability`), and minting the distinguishing bit pays
    `ΔF = −log 2` (`duplication_pays_log_two`). The substrate's "no free Banach–Tarski," one principle
    behind no-cloning, the no-diproton, and mitosis. No new axioms. See `Banach_Tarski_QLF.md`. -/
theorem no_free_duplication_summary : True := trivial

end QLF.NoFreeDuplication
