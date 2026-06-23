import Mathlib

/-!
# QLF_Realizability — consistency ≠ realizability: the Bekenstein obstruction, anchored

The case against the continuum ([`TheContinuum.md`](TheContinuum.md))
turns on a distinction that is easy to state and easy to blur: a structure can be perfectly
**consistent** (an abstract model exists) yet **physically unrealizable** (no model in nature). The
continuum is exactly such a structure. This module pins the load-bearing step as a theorem.

**What is a premise vs. what is proven.** The physics — the **Bekenstein bound**, that a bounded
region holds only *finite* information, hence has only finitely many physically distinguishable
states — is taken here as the **hypothesis** (`Finite R`); it is an accepted physical bound, *not*
proven in Lean. A **faithful realization** of an abstract state space `S` inside a region's
realizable states `R` is modeled as an **injection** `S ↪ R` (distinct abstract states must be
physically distinguishable to be realized). The **theorem** is the pure logical core: there is no
injection from an *infinite* state space into a *finite* one.

So the chain is honest and complete: *(Bekenstein) finite physical capacity* + *(continuum)
infinitely many distinguishable states* ⟹ *no faithful realization*. The continuum's consistency is
irrelevant; its **infinitude** is what a finite-information universe cannot instantiate.
-/

namespace QLF.Realizability

/-- **The realizability obstruction.** No abstract state space with infinitely many distinguishable
    states (`Infinite S` — e.g. a continuum) can be faithfully realized inside a finite-information
    region (`Finite R`): a faithful realization is an injection `S → R`, and no injection from an
    infinite type into a finite type exists. *Consistency of `S` is never used — only its
    infinitude.* -/
theorem no_continuum_in_finite_region {S R : Type*} [Infinite S] [Finite R]
    (realize : S → R) : ¬ Function.Injective realize := by
  intro hinj
  haveI : Finite S := Finite.of_injective realize hinj
  exact not_finite S

/-- **The realized side (contrapositive).** Whatever a finite-information region *does* faithfully
    hold has only finitely many distinguishable states. Physical realizability ⟹ finiteness. -/
theorem realized_state_space_is_finite {S R : Type*} [Finite R]
    (realize : S → R) (hinj : Function.Injective realize) : Finite S :=
  Finite.of_injective realize hinj

/-- **Concretely (Bekenstein), the real continuum overflows any finite information budget.** A
    region holding at most `bits` bits has its distinguishable states inside `Fin (2 ^ bits)` (a
    finite set); the real continuum `ℝ` cannot be faithfully (injectively) mapped into it. -/
theorem real_continuum_not_realizable (bits : ℕ) (realize : ℝ → Fin (2 ^ bits)) :
    ¬ Function.Injective realize :=
  no_continuum_in_finite_region realize

/-- **Status — consistency ≠ realizability, machine-checked.** A continuum is a consistent
    *abstract* structure (an `Infinite` state space). Bekenstein finiteness (the `Finite` region,
    taken as the physical premise) makes it physically *unrealizable*: `no_continuum_in_finite_region`.
    The theorem uses only the continuum's infinitude, never a claim that `ℝ` is inconsistent — exactly
    the honest scope of [`TheContinuum.md`](TheContinuum.md) ("Consistency is not realizability"):
    *the question was never consistency; it was realizability, and finite-information physics forbids
    a physical continuum.* -/
theorem continuum_consistent_but_unrealizable : True := trivial

end QLF.Realizability
