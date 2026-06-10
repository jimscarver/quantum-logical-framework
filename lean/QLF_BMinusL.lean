import QLF_Axioms

set_option linter.unusedVariables false

/-!
# QLF_BMinusL — signed-count conservation, and why B−L is NOT a weight dictionary

This module anchors the conservation of QLF's **signed twist counts** (electric
charge is the prototype) — and, in doing so, proves a sharp **obstruction**: B−L
*cannot* be any such weight dictionary, so it must be a winding / topological
invariant. This corrects an earlier framing that called B−L "the same theorem as
charge conservation"; the attempt to build a B−L weight dictionary is what proved
the route impossible.

A weight `w : TopoElement → Int` is **annihilation-odd** when it negates under the
half-spin swap (`w x + w (swap_topo x) = 0`) — exactly the antiparticle relation,
and exactly what makes the pos/neg pairs `zeno_prune` removes cancel.

* `wcount_append`       — additive under concatenation (composition of histories).
* `wcount_zeno_prune` / `wcount_full_zeno_prune` — invariant under the ZFA dynamics.
* `signed_count_conserved` — the named conservation theorem (charge is the instance).
* `no_spontaneous`      — a charge-neutral input stays charge-neutral through closure.
* **`wcount_zero_on_ZFA`** — the obstruction: *every* annihilation-odd signed count
  is **zero on every ZFA closure** (a closure prunes to the empty string).

**Why B−L is not a weight dictionary.** Electric charge is consistent with
`wcount_zero_on_ZFA` — every QLF closure is electrically neutral. But B−L is **not
zero on closures**: a stable neutral closure such as the deuterium atom carries
`B−L = 1`. Equivalently and decisively: a baryon and an antibaryon are both
count-balanced closures with the *identical* twist multiset (conjugation maps the
balanced counts to themselves), yet they carry `B−L = +1` vs `−1`; a weight
dictionary is a function of the counts alone, so it must assign them the *same*
value — it cannot distinguish them. Hence **B−L depends on the sequence/orientation
(a winding invariant), not on twist counts** — matching "baryon number = topological
winding" (`Conservation.md` §8). The winding anchor is the correct, still-open
object; this module proves the weight-dictionary route is closed.
-/

namespace QLF.BMinusL

/-- A signed count with per-element integer weight `w`. -/
def wcount (w : TopoElement → Int) : TopoString → Int
  | [] => 0
  | x :: tail => w x + wcount w tail

@[simp] lemma wcount_nil (w : TopoElement → Int) : wcount w [] = 0 := rfl

@[simp] lemma wcount_cons (w : TopoElement → Int) (x : TopoElement) (l : TopoString) :
    wcount w (x :: l) = w x + wcount w l := rfl

/-- **Annihilation-odd**: the weight negates under the half-spin swap (the
    antiparticle relation). Exactly the condition that makes pruned pos/neg
    pairs cancel. -/
def AnnihilationOdd (w : TopoElement → Int) : Prop :=
  ∀ x : TopoElement, w x + w (swap_topo x) = 0

/-- A signed count is a homomorphism `(TopoString, ++) → (ℤ, +)`. -/
theorem wcount_append (w : TopoElement → Int) (s t : TopoString) :
    wcount w (s ++ t) = wcount w s + wcount w t := by
  induction s with
  | nil => simp
  | cons x xs ih =>
    simp only [List.cons_append, wcount_cons, ih]
    omega

private lemma pair_cancel (w : TopoElement → Int) (hw : AnnihilationOdd w) :
    w (TopoElement.phase LogicPhase.pos) + w (TopoElement.phase LogicPhase.neg) = 0 := by
  have h := hw (TopoElement.phase LogicPhase.pos)
  simpa [swap_topo] using h

private lemma pair_cancel' (w : TopoElement → Int) (hw : AnnihilationOdd w) :
    w (TopoElement.phase LogicPhase.neg) + w (TopoElement.phase LogicPhase.pos) = 0 := by
  have h := pair_cancel w hw; omega

/-- **Single-pass prune invariance** for any annihilation-odd signed count
    (the generalisation of `single_prune_invariant`, which is the charge case). -/
theorem wcount_zeno_prune (w : TopoElement → Int) (hw : AnnihilationOdd w)
    (s : TopoString) : wcount w (zeno_prune s) = wcount w s := by
  induction s using zeno_prune.induct
  · rfl
  · next tail ih =>
    have hp := pair_cancel w hw
    simp only [zeno_prune, wcount_cons]
    rw [ih]; omega
  · next tail ih =>
    have hp := pair_cancel' w hw
    simp only [zeno_prune, wcount_cons]
    rw [ih]; omega
  · next head tail ih =>
    simp only [zeno_prune, wcount_cons]
    rw [ih]

/-- **Full (fixed-point) prune invariance**: the ZFA dynamics conserve any
    annihilation-odd signed count (generalises `full_prune_invariant`). -/
theorem wcount_full_zeno_prune (w : TopoElement → Int) (hw : AnnihilationOdd w)
    (s : TopoString) : wcount w (full_zeno_prune s) = wcount w s := by
  let P : Nat → Prop := fun n =>
    ∀ t : TopoString, t.length = n → wcount w (full_zeno_prune t) = wcount w t
  have hP : ∀ n, P n := by
    intro n
    refine Nat.strong_induction_on n ?_
    intro n ih t ht
    by_cases hlt : (zeno_prune t).length < t.length
    · rw [full_zeno_prune, dif_pos hlt]
      have hrec_len : (zeno_prune t).length < n := by omega
      have hrec : P (zeno_prune t).length := ih _ hrec_len
      have hrec' : wcount w (full_zeno_prune (zeno_prune t)) = wcount w (zeno_prune t) :=
        hrec (zeno_prune t) rfl
      exact hrec'.trans (wcount_zeno_prune w hw t)
    · rw [full_zeno_prune, dif_neg hlt]
  exact hP s.length s rfl

/-- **Signed-count conservation.** Any annihilation-odd signed count is invariant
    under the ZFA dynamics. Electric charge is the canonical instance (below).
    Note: this does **not** cover B−L — see `wcount_zero_on_ZFA`. -/
theorem signed_count_conserved (w : TopoElement → Int) (hw : AnnihilationOdd w)
    (s : TopoString) : wcount w (full_zeno_prune s) = wcount w s :=
  wcount_full_zeno_prune w hw s

/-- **No spontaneous net charge.** A history that is charge-neutral before closure
    stays charge-neutral after — a signed count is never conjured from a neutral
    input. (This is the *charge* statement; the analogous B−L statement does not
    follow this way, since B−L is not a signed count — `wcount_zero_on_ZFA`.) -/
theorem no_spontaneous (w : TopoElement → Int) (hw : AnnihilationOdd w)
    (s : TopoString) (h0 : wcount w s = 0) : wcount w (full_zeno_prune s) = 0 := by
  rw [wcount_full_zeno_prune w hw s, h0]

/-- A ZFA closure prunes to the empty string: `achieves_ZFA` says the fully-pruned
    history has no `is_gauge` element, and every element *is* `is_gauge`. -/
theorem zfa_prune_nil {s : TopoString} (h : achieves_ZFA s) :
    full_zeno_prune s = [] := by
  unfold achieves_ZFA at h
  cases hfp : full_zeno_prune s with
  | nil => rfl
  | cons x xs =>
    rw [hfp] at h
    cases x <;> simp [is_gauge] at h

/-- **The obstruction — B−L is not a weight dictionary.** Every annihilation-odd
    signed count (the conserved, charge-class weights) is **zero on every ZFA
    closure**, because a closure prunes to the empty string. Electric charge is
    consistent (QLF closures are neutral); B−L is not (the deuterium atom is a
    stable neutral closure with `B−L = 1`), so B−L cannot be any such weight — it
    is a winding invariant. -/
theorem wcount_zero_on_ZFA (w : TopoElement → Int) (hw : AnnihilationOdd w)
    (s : TopoString) (h : achieves_ZFA s) : wcount w s = 0 := by
  rw [← wcount_full_zeno_prune w hw s, zfa_prune_nil h, wcount_nil]

/-! ## Electric charge is the canonical instance -/

/-- Electric-charge weight: `+1` for pos, `−1` for neg, `0` for gauge. -/
def chargeWeight : TopoElement → Int
  | TopoElement.phase LogicPhase.pos => 1
  | TopoElement.phase LogicPhase.neg => -1
  | TopoElement.gauge => 0

theorem chargeWeight_annihilationOdd : AnnihilationOdd chargeWeight := by
  intro x
  cases x with
  | gauge => rfl
  | phase p => cases p <;> rfl

/-- `wcount chargeWeight` reproduces the canonical signed count `count_pos − count_neg`. -/
theorem wcount_chargeWeight (s : TopoString) :
    wcount chargeWeight s = count_pos s - count_neg s := by
  induction s with
  | nil => rfl
  | cons x xs ih =>
    rw [wcount_cons, count_pos_cons, count_neg_cons, ih]
    cases x with
    | gauge => simp only [chargeWeight, val_pos, val_neg]; omega
    | phase p => cases p <;> simp only [chargeWeight, val_pos, val_neg] <;> omega

end QLF.BMinusL
