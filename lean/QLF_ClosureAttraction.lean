import QLF_Axioms
import Mathlib

set_option linter.unusedVariables false

/-!
# QLF_ClosureAttraction — "gauge folds attract" as a theorem: binding reduces free action

The interacting closure-binding dynamics (frontier #1, issue #121), modelled the substrate-native way
(Grok's Route 1, "shared-closure / free-action reduction"): **attraction is not a force between
particles — it is a bias in the ZFA generation/pruning for joint histories that reduce net free
action**, and it is a *theorem* of the existing `count_pos`/`count_neg` imbalance machinery, with **no
new primitives, no continuum potential, no free coupling, no external field**.

## Free action and its reduction under composition

A gauge fold is a `+`/`−` pair; the **net gauge imbalance** of a history is `netGauge s = count_pos s
− count_neg s` (`QLF_Axioms`), and the **free action** is its magnitude `freeAction s = |netGauge s|`
(zero exactly on a ZFA-balanced/symmetric history, `zfa_iff_zero_free_action`). Because the counts are
additive under concatenation (`count_pos_append`/`count_neg_append`), the net gauge is additive
(`netGauge_append`), so free action obeys the **triangle inequality**:

* **`freeAction_subadditive`** — `freeAction (A ++ B) ≤ freeAction A + freeAction B`: joining two
  histories *never raises* the free action. So the substrate's ZFA selection (minimise free action) is
  **never repelled** by binding — the universal attractiveness of composition.
* **`attraction A B = freeAction A + freeAction B − freeAction (A ++ B) ≥ 0`** (`attraction_nonneg`):
  the free-action *reduction* from joining is the measure of attraction (Grok's "reduction in
  free-action vector length").

## Channel selection falls out of the sign — opposite-gauge attracts, like-gauge does not

* **`opposite_gauge_attracts`** — if the net gauges are complementary (`netGauge B = −netGauge A`,
  `≠ 0`), the joint history *cancels* to zero free action while the parts do not, so
  `freeAction (A ++ B) < freeAction A + freeAction B`: **strict attraction**. This is the `t̄t` /
  fermion–antifermion channel (`QLF_ClosureBinding.antiparticle_channel_binds`, `dagger_closes`) in the
  free-action picture — its `dagger` carries the opposite gauge.
* **`complementary_binding_closes`** — that maximal case makes the joint history **ZFA-balanced**
  (`is_symmetric (A ++ B)`): the shared closure, free action driven to `0`.
* **`same_gauge_no_attraction`** — if the net gauges have the *same* sign, `freeAction (A ++ B) =
  freeAction A + freeAction B`: **no reduction, no attraction** (the like-charge channel — additionally
  Pauli-blocked, `QLF_ClosureBinding.identical_channel_blocked`).

So *which* channel binds is not posited — it is the sign of `netGauge`: opposite attracts, same does
not. Each realized shared closure then carries the `log 2` free-energy quantum
(`QLF_FreeEnergy`/`QLF_ClosureBinding.binding_quantum`), and `g = (log 2)·channel·packing`.

## Honest scope (`closure_attraction_in_progress`)

**The attraction *structure* is now a theorem** — binding reduces free action, strictly for opposite
gauge, to zero for complementary; channel selection is the sign; no new axioms. **Open (unchanged,
#121):** the **packing factor** — the local *density* of available opposite-gauge slots that the SOC
steady state selects (Grok: "packing = the local density of opposite-gauge slots") — stays the
emergent dynamical observable, *not* absorbed into any free-census count and *not* fitted (the same
honesty as the gravitational floor, `QLF_BindingStrength`). This anchors the *bias*; the *equilibrium
density* is the interacting-dynamics residual. Reuses `QLF_Axioms`; no new axioms. See `Higgs.md` §5a,
`QLF_ClosureBinding`, issue #121.
-/

namespace QLF.ClosureAttraction

/-! ### Additivity of the gauge counts -/

theorem count_pos_append (A B : TopoString) : count_pos (A ++ B) = count_pos A + count_pos B := by
  induction A with
  | nil => simp [count_pos]
  | cons head tail ih =>
    cases head with
    | phase p =>
      cases p with
      | pos => simp only [List.cons_append, count_pos]; omega
      | neg => simp only [List.cons_append, count_pos]; omega
    | gauge => simp only [List.cons_append, count_pos]; omega

theorem count_neg_append (A B : TopoString) : count_neg (A ++ B) = count_neg A + count_neg B := by
  induction A with
  | nil => simp [count_neg]
  | cons head tail ih =>
    cases head with
    | phase p =>
      cases p with
      | pos => simp only [List.cons_append, count_neg]; omega
      | neg => simp only [List.cons_append, count_neg]; omega
    | gauge => simp only [List.cons_append, count_neg]; omega

/-! ### Net gauge imbalance and free action -/

/-- The **net gauge imbalance** of a history: `count_pos − count_neg` (the free-action vector). -/
def netGauge (s : TopoString) : ℤ := count_pos s - count_neg s

/-- Net gauge is additive under composition. -/
theorem netGauge_append (A B : TopoString) : netGauge (A ++ B) = netGauge A + netGauge B := by
  unfold netGauge; rw [count_pos_append, count_neg_append]; ring

/-- The **free action** of a history: the magnitude of its net gauge imbalance (`0` iff ZFA-balanced). -/
def freeAction (s : TopoString) : ℤ := |netGauge s|

theorem freeAction_nonneg (s : TopoString) : 0 ≤ freeAction s := abs_nonneg _

/-- **Free action is subadditive** — joining two histories never raises the free action. -/
theorem freeAction_subadditive (A B : TopoString) :
    freeAction (A ++ B) ≤ freeAction A + freeAction B := by
  unfold freeAction; rw [netGauge_append]; exact abs_add _ _

/-- ZFA balance ⟺ zero free action. -/
theorem zfa_iff_zero_free_action (s : TopoString) : is_symmetric s ↔ freeAction s = 0 := by
  simp [is_symmetric, freeAction, netGauge, abs_eq_zero, sub_eq_zero]

/-! ### Attraction = free-action reduction -/

/-- The **attraction** of two histories: the free-action reduction from joining them. -/
def attraction (A B : TopoString) : ℤ := freeAction A + freeAction B - freeAction (A ++ B)

/-- **Attraction is never negative** — the substrate is never *repelled* by binding. -/
theorem attraction_nonneg (A B : TopoString) : 0 ≤ attraction A B := by
  unfold attraction; linarith [freeAction_subadditive A B]

/-- **Opposite-gauge histories attract strictly** — complementary net gauges (`netGauge B =
    −netGauge A ≠ 0`) cancel, so the joint free action is strictly below the sum: the `t̄t` channel. -/
theorem opposite_gauge_attracts (A B : TopoString)
    (h : netGauge B = -netGauge A) (hne : netGauge A ≠ 0) :
    freeAction (A ++ B) < freeAction A + freeAction B := by
  unfold freeAction
  rw [netGauge_append, h]
  have hpos : 0 < |netGauge A| := abs_pos.mpr hne
  have hz : netGauge A + -netGauge A = 0 := by ring
  rw [hz, abs_zero, abs_neg]
  linarith

/-- **The complementary channel closes** — maximal attraction drives the joint history to ZFA balance
    (`is_symmetric`): the shared closure. -/
theorem complementary_binding_closes (A B : TopoString) (h : netGauge B = -netGauge A) :
    is_symmetric (A ++ B) := by
  rw [zfa_iff_zero_free_action]
  unfold freeAction
  rw [netGauge_append, h]
  simp

/-- **Same-gauge histories do not attract** — same-sign net gauges add, no free-action reduction
    (the like-charge channel; additionally Pauli-blocked). -/
theorem same_gauge_no_attraction (A B : TopoString)
    (hA : 0 ≤ netGauge A) (hB : 0 ≤ netGauge B) :
    freeAction (A ++ B) = freeAction A + freeAction B := by
  unfold freeAction
  rw [netGauge_append, abs_of_nonneg (by linarith : (0:ℤ) ≤ netGauge A + netGauge B),
    abs_of_nonneg hA, abs_of_nonneg hB]

/-- Honest-scope marker: the attraction *bias* is a theorem (free-action reduction, opposite-gauge
    strict, complementary closes); the packing *density* (SOC steady state) stays the open dynamical
    observable, not fitted (#121). -/
theorem closure_attraction_in_progress : True := trivial

end QLF.ClosureAttraction
