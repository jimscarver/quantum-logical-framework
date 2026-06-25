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
  cancellation `zeno_prune` exactly `R` times — closure observed at finite rate/depth `R`, the bounded
  analog of the to-fixpoint `full_zeno_prune`. **`closedAtHorizon R s`** := it has stabilized to the
  empty closure within `R` passes (a usable receipt at resolution `R`).
* **Horizon-relativity (`horizon_relative`).** The nested singlet `⟨+ ⟨+ −⟩ −⟩ = [+,+,−,−]` is **not**
  closed at horizon `1` but **is** closed at horizon `2`: the *same* history reads *open* to a shallow
  observer and *closed* to a deeper one. Open/closed is not a primitive yes/no.
* **Closure is stable as the horizon widens** (`closedAtHorizon_mono`): once a process stabilizes into
  a receipt within a horizon, every larger horizon still reads it closed.
* **Bounded closure is genuine closure** (`zfa_of_closedAtHorizon`): if *some* finite horizon reads `s`
  closed, then `s` achieves ZFA absolutely. So absolute closure is exactly the limit of the bounded
  closures — the asymptotic ideal the finite horizons approach (and the nested singlet exhibits all
  three at once: open@1, closed@2, `achieves_ZFA`).

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
  show zeno_prune (boundedPrune R s) = []
  rw [show boundedPrune R s = [] from h]

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

-- The absolute ↔ bounded bridge: `full_zeno_prune` is unchanged by one extra `zeno_prune` pass, so
-- it is unchanged by `boundedPrune`; hence a history closed at *any* finite horizon is `achieves_ZFA`.

/-- `zeno_prune` never lengthens its argument. -/
theorem zeno_prune_length_le (s : TopoString) : (zeno_prune s).length ≤ s.length := by
  induction s using zeno_prune.induct
  · simp [zeno_prune]
  · next tail ih => simp [zeno_prune]; omega
  · next tail ih => simp [zeno_prune]; omega
  · next head tail ih => simp [zeno_prune]; omega

/-- If a `zeno_prune` pass does not shorten the string, it is the identity (no pair cancelled). -/
theorem zeno_prune_fixed_of_length_eq (s : TopoString) :
    (zeno_prune s).length = s.length → zeno_prune s = s := by
  induction s using zeno_prune.induct
  · intro _; rfl
  · next tail ih =>
    intro h; exfalso
    simp [zeno_prune] at h
    have := zeno_prune_length_le tail; omega
  · next tail ih =>
    intro h; exfalso
    simp [zeno_prune] at h
    have := zeno_prune_length_le tail; omega
  · next head tail ih =>
    intro h
    simp only [zeno_prune] at h ⊢
    have hlen : (zeno_prune tail).length = tail.length := by
      simp only [List.length_cons] at h; omega
    rw [ih hlen]

/-- The fixpoint prune of the empty string is empty. -/
theorem full_zeno_prune_nil : full_zeno_prune ([] : TopoString) = [] := by
  rw [full_zeno_prune, dif_neg (by decide)]

/-- **One extra `zeno_prune` pass leaves the fixpoint prune unchanged.** Either the pass shortens the
    string (and `full_zeno_prune` recurses through it by definition) or it is the identity. -/
theorem full_prune_zeno_eq (s : TopoString) :
    full_zeno_prune (zeno_prune s) = full_zeno_prune s := by
  by_cases h : (zeno_prune s).length < s.length
  · conv_rhs => rw [full_zeno_prune, dif_pos h]
  · have hfix : zeno_prune s = s :=
      zeno_prune_fixed_of_length_eq s
        (le_antisymm (zeno_prune_length_le s) (by omega))
    rw [hfix]

/-- The fixpoint prune is invariant under any number of bounded passes. -/
theorem full_prune_boundedPrune (R : ℕ) (s : TopoString) :
    full_zeno_prune (boundedPrune R s) = full_zeno_prune s := by
  induction R with
  | zero => rfl
  | succ R ih =>
    show full_zeno_prune (zeno_prune (boundedPrune R s)) = full_zeno_prune s
    rw [full_prune_zeno_eq, ih]

/-- **Bounded closure is genuine closure.** If *some* finite horizon `R` reads `s` closed, then `s`
    achieves ZFA absolutely — absolute closure is exactly the limit the finite horizons approach. -/
theorem zfa_of_closedAtHorizon {R : ℕ} {s : TopoString} (h : closedAtHorizon R s) :
    achieves_ZFA s := by
  have hfp : full_zeno_prune s = [] := by
    have hpb := full_prune_boundedPrune R s
    rw [show boundedPrune R s = [] from h, full_zeno_prune_nil] at hpb
    exact hpb.symm
  unfold achieves_ZFA; rw [hfp]

/-- The nested singlet is **absolutely closed** — its deep-horizon reading is the true receipt. -/
theorem nestedSinglet_zfa : achieves_ZFA nestedSinglet :=
  zfa_of_closedAtHorizon horizon_relative.2

/-- **Established constructively (issue #104):** closure is horizon-relative. The bounded closure
    `closedAtHorizon R` (prune only `R` passes — finite rate/depth/capacity) is monotone in the horizon
    (`closedAtHorizon_mono`) and is genuine closure in the limit (`zfa_of_closedAtHorizon`: any finite
    horizon that closes ⟹ absolute `achieves_ZFA`). The nested singlet `[+,+,−,−]` exhibits the whole
    picture — **open at horizon 1, closed at horizon 2** (`horizon_relative`), and **absolutely closed**
    (`nestedSinglet_zfa`) — so open/closed is not a primitive yes/no but what closure looks like under a
    finite horizon. The observer is a local finite-capacity information horizon (a finite-information
    region, `QLF_Realizability`) reading `closedAtHorizon` at its own resolution; absolute closure is
    the asymptotic ideal it approaches, never the thing it owns. No new axioms. -/
theorem horizon_closure_summary : True := trivial

end QLF.HorizonClosure
