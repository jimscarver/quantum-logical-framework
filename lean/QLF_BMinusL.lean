import QLF_Axioms

set_option linter.unusedVariables false

/-!
# QLF_BMinusL — B−L (and every annihilation-odd signed count) is conserved by ZFA dynamics

The conserved *additive* quantum numbers of QLF are **signed twist counts**. This
module proves, in full generality, that **any annihilation-odd signed count is
invariant under the ZFA pruning dynamics** (`zeno_prune`, `full_zeno_prune`) and
additive under concatenation. Electric charge (`count_pos − count_neg`) is one
instance; **B−L is another** — so *B−L conservation is the same theorem as charge
conservation*, not a separate assumption.

A weight `w : TopoElement → Int` is **annihilation-odd** when it negates under the
half-spin swap (`w x + w (swap_topo x) = 0`). This is exactly the antiparticle
relation, and it is precisely what makes the pos/neg pairs that `zeno_prune`
removes contribute zero — so the count survives pruning.

* `wcount_append`     — additive under concatenation (composition of histories).
* `wcount_zeno_prune` / `wcount_full_zeno_prune` — invariant under the ZFA dynamics.
* `bMinusL_conserved` — the named B−L specialisation (any annihilation-odd `w`).
* `no_spontaneous`    — the precise sense in which **proton synthesis cannot break
  B−L**: a history that starts `B−L`-neutral stays `B−L`-neutral through closure,
  so a proton's `B−L = +1` (it is a quantum black hole carrying B−L as *hair*,
  `BLACK-HOLES.md` §3a) must be co-produced with a balancing lepton — never
  conjured from a neutral input.

What this does **not** pin down is the *value dictionary* — which combination of
twist axes equals physical B−L (`Q=0` yet `B−L=1` for the neutron requires an axis
orthogonal to charge, i.e. the multi-axis 8-twist alphabet). Conservation holds
for the whole class regardless, so the open piece is the value assignment, not the
conservation. See `Conservation.md` §8.
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

/-- **B−L conservation is the same theorem as charge conservation.** Any additive
    quantum number whose antiparticle relation is the half-spin swap is
    annihilation-odd, hence invariant under the ZFA dynamics. B−L is such a
    number. -/
theorem bMinusL_conserved (w : TopoElement → Int) (hw : AnnihilationOdd w)
    (s : TopoString) : wcount w (full_zeno_prune s) = wcount w s :=
  wcount_full_zeno_prune w hw s

/-- **Proton synthesis cannot break B−L.** A history that is `B−L`-neutral before
    closure stays `B−L`-neutral after — net `B−L` is never conjured from a neutral
    input. A proton's `B−L = +1` (it is a quantum black hole carrying B−L as hair)
    must be co-produced with a balancing lepton. -/
theorem no_spontaneous (w : TopoElement → Int) (hw : AnnihilationOdd w)
    (s : TopoString) (h0 : wcount w s = 0) : wcount w (full_zeno_prune s) = 0 := by
  rw [wcount_full_zeno_prune w hw s, h0]

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
