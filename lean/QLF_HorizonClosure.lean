import QLF_Axioms

set_option linter.unusedVariables false

/-!
# QLF_HorizonClosure — closure is horizon-relative; observation is bounded closure (issue #104)

Issue #104 (Allen): *"Open" and "closed" may not be absolute states — they are horizon-relative.* A
process is **open** when it has not yet stabilized into a usable receipt within some local limit of
rate / memory / access / information capacity, and **closed** when it is stable enough to function as a
receipt *inside that local horizon*. Absolute closure is an asymptotic ideal, not a thing any local
finite-capacity subsystem fully owns. *"Observation is bounded closure, not eyeballs."*

QLF already has the absolute notion — `achieves_ZFA s ⟺ full_zeno_prune s = []` (prune the phase
string to the empty closure *at fixpoint*). This module supplies the **bounded** notion and proves it
is genuinely horizon-relative.

* **A finite-resolution horizon** prunes only `R` passes: `boundedPrune R` applies the one-pass
  cancellation `zeno_prune` exactly `R` times — closure observed at a finite rate/depth `R`, the
  bounded analog of the to-fixpoint `full_zeno_prune`. **`closedAtHorizon R s`** := it has stabilized to
  the empty closure within `R` passes (a usable receipt at resolution `R`).
* **Horizon-relativity (`horizon_relative`).** The nested singlet `⟨+ ⟨+ −⟩ −⟩ = [+,+,−,−]` is **not**
  closed at horizon `1` (one pass leaves `[+,−]`) but **is** closed at horizon `2`: the *same* history
  reads *open* to a shallow observer and *closed* to a deeper one. Open/closed is not a primitive yes/no.
* **Closure is stable as the horizon widens** (`closedAtHorizon_mono`): once a process stabilizes into a
  receipt within a horizon, every larger horizon still reads it closed.
* **Bounded closure is the genuine receipt** (`nestedSinglet_zfa`): the very same nested singlet that is
  closed at horizon `2` is also **absolutely closed** (`achieves_ZFA`) — the deep-horizon reading is the
  true closure, so absolute closure is the asymptotic ideal the finite horizons approach.

**The observer.** A finite-capacity observer is a finite-information region — `QLF_Realizability`
([`no_continuum_in_finite_region`](QLF_Realizability.lean)) makes "a bounded region resolves only
finitely many states" a theorem. Such an observer operates at some finite horizon `R`; it never *owns*
the unbounded (absolute) horizon, only ever a bounded `closedAtHorizon R`. So the observer is not a
finisher added at the end — it is a local finite-capacity horizon inside the process, and what it calls
"observation" is `closedAtHorizon` at its own resolution. See `Open_Problems.md`.
-/

namespace QLF.HorizonClosure

/-- **A finite-resolution horizon**: prune (close) only up to `R` passes. `boundedPrune R s` applies
    the one-pass cancellation `zeno_prune` `R` times — closure observed at a finite rate/depth `R`, the
    bounded analog of the to-fixpoint `full_zeno_prune`. -/
def boundedPrune : ℕ → TopoString → TopoString
  | 0, s => s
  | (R + 1), s => zeno_prune (boundedPrune R s)

/-- **Closed at horizon `R`**: the history has stabilized to the empty (fully-cancelled) closure within
    `R` passes — a usable receipt at resolution `R`. -/
def closedAtHorizon (R : ℕ) (s : TopoString) : Prop := boundedPrune R s = []

/-- **Closure is stable as the horizon widens by one step**: closed at `R` ⟹ closed at `R+1`. -/
theorem closedAtHorizon_succ {R : ℕ} {s : TopoString} (h : closedAtHorizon R s) :
    closedAtHorizon (R + 1) s := by
  unfold closedAtHorizon at h ⊢
  show zeno_prune (boundedPrune R s) = []
  simp only [h, zeno_prune]

/-- **Closure is stable as the horizon widens**: closed at `R` ⟹ closed at every larger horizon `R'`.
    Once a process stabilizes into a receipt within a horizon, every wider horizon still reads it
    closed. -/
theorem closedAtHorizon_mono {R : ℕ} {s : TopoString} (h : closedAtHorizon R s) :
    ∀ {R' : ℕ}, R ≤ R' → closedAtHorizon R' s := by
  intro R' hR
  induction R', hR using Nat.le_induction with
  | base => exact h
  | succ n hn ih => exact closedAtHorizon_succ ih

/-- The **nested singlet** `⟨+ ⟨+ −⟩ −⟩ = [+,+,−,−]` — the canonical horizon-relative history. The
    inner pair cancels on the first pass, the outer pair on the second. -/
def nestedSinglet : TopoString :=
  [TopoElement.phase LogicPhase.pos, TopoElement.phase LogicPhase.pos,
   TopoElement.phase LogicPhase.neg, TopoElement.phase LogicPhase.neg]

/-- **Open/closed is horizon-relative.** The nested singlet is **not** closed at horizon `1` (one pass
    leaves `[+,−]`) but **is** closed at horizon `2` — the *same* history reads *open* to a shallow
    observer and *closed* to a deeper one. -/
theorem horizon_relative :
    ¬ closedAtHorizon 1 nestedSinglet ∧ closedAtHorizon 2 nestedSinglet := by
  refine ⟨?_, ?_⟩
  · unfold closedAtHorizon; decide
  · unfold closedAtHorizon; decide

/-- **The bounded closure is the genuine receipt.** The nested singlet — closed at horizon `2`
    (`horizon_relative`) — is also **absolutely closed** (`achieves_ZFA`, the to-fixpoint prune reaches
    the empty closure). So the deep-horizon reading *is* the true closure: absolute closure is the
    asymptotic ideal the finite horizons approach, exhibited here on the canonical witness (open at
    horizon 1, closed at horizon 2, absolutely closed). -/
theorem nestedSinglet_zfa : achieves_ZFA nestedSinglet := by
  unfold achieves_ZFA
  native_decide

/-- **Established constructively (issue #104):** closure is horizon-relative. The bounded closure
    `closedAtHorizon R` (prune only `R` passes — finite rate/depth/capacity) is monotone in the horizon
    (`closedAtHorizon_mono`), and the deep-horizon reading is the genuine receipt (`nestedSinglet_zfa`:
    the witness closed at horizon 2 is absolutely `achieves_ZFA`). The nested singlet `[+,+,−,−]`
    exhibits the whole picture — **open at horizon 1, closed at horizon 2** (`horizon_relative`), and
    **absolutely closed** (`nestedSinglet_zfa`) — so open/closed is not a primitive yes/no but what
    closure looks like under a finite horizon, with absolute closure the asymptotic ideal the horizons
    approach. The observer is a local finite-capacity information horizon (a finite-information region,
    `QLF_Realizability`) reading `closedAtHorizon` at its own resolution, never owning the absolute
    horizon. No new axioms. -/
theorem horizon_closure_summary : True := trivial

end QLF.HorizonClosure
