import QLF_Realizability
import QLF_Reversibility
import Mathlib

/-!
# QLF_PostulateReduction — the reconstruction postulates collapse into the one postulate

The reconstruction theorem (`Completeness_Evidence.md` §6, issue #118) is usually stated over **five**
ZFA-free postulates: orthomodularity, finite information capacity, closure-as-receipt, reversible logic
with irreversible realization, and no-disconnection. This module records that they are **not five
independent axioms** — four reduce to the *one* postulate ("physical reality is the finite,
self-consistent/closing subset of logical possibility"), leaving essentially one-and-a-half:

* **Finite information capacity** — the *"finite"* clause of the one postulate, not independent; it
  forces discreteness (`finite_capacity_forces_discreteness`, reusing `no_continuum_in_finite_region`).
* **Closure-as-receipt** — the *"self-consistent/closing"* clause restated; definitional.
* **Reversible logic with irreversible realization** — **DERIVED**, not assumed: the reverse is the
  involutive dagger and the forward closure is many-to-one
  (`reversible_logic_irreversible_realization`, reusing
  `time_reverse_involutive_but_closure_degenerate`).
* **No-disconnection** — plausibly derivable from the relational nature of closure (a disconnected event
  closes with nothing, so it is never selected); stated in the doc, not yet a Lean theorem.
* **Orthomodularity** — the genuine residue, and half-free: the *orthocomplement* comes from the dagger
  involution; only the orthomodular *law* is the Gleason-hard content the one postulate does not force.

So the reconstruction target collapses from "five postulates ⟹ ZFA" to **"the one postulate + the
orthomodular law ⟹ ZFA (up to isomorphism)"**. This module anchors the two *proven* rungs of that
collapse; no new axioms.
-/

namespace QLF.PostulateReduction

open QLF QLF.Majorana

/-- **Finite capacity ⟹ discreteness (the finite-capacity postulate is a component of the one
    postulate).** A finite-information realm (`Finite R`) carries no injection from an infinite state
    space (`Infinite S`), so no continuum is realized. Reuses `no_continuum_in_finite_region`. -/
theorem finite_capacity_forces_discreteness
    {S R : Type*} [Infinite S] [Finite R] (realize : S → R) :
    ¬ Function.Injective realize :=
  QLF.Realizability.no_continuum_in_finite_region realize

/-- **Reversible logic with irreversible realization (the postulate) — DERIVED.** Not an added axiom:
    the reverse is the involutive dagger (`antiparticle (antiparticle ts) = ts`) while the forward
    closure is many-to-one (`≥ 2` histories per closure). Reuses
    `time_reverse_involutive_but_closure_degenerate`. -/
theorem reversible_logic_irreversible_realization
    (ts : List Twist) {n : ℕ} (hn : 1 ≤ n) :
    antiparticle (antiparticle ts) = ts ∧
      2 ≤ ((expand_generation (2 * n)).filter verify).length :=
  QLF.Reversibility.time_reverse_involutive_but_closure_degenerate ts hn

/-- **Status — the five reconstruction postulates collapse into one-and-a-half.** Two rungs are proven
    here (finite-capacity→discreteness; reversible-logic/irreversible-realization); closure-as-receipt is
    the selection clause restated; no-disconnection is plausibly derivable (doc); orthomodularity is the
    residue (orthocomplement free from the dagger, the orthomodular law Gleason-hard). The collapsed
    target is "the one postulate + the orthomodular law ⟹ ZFA". See `Completeness_Evidence.md` §6b. -/
theorem postulate_reduction_summary : True := trivial

end QLF.PostulateReduction
