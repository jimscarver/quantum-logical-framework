import Mathlib.Data.List.Basic
import Mathlib.Data.Int.Basic

set_option linter.unusedVariables false

-- ==========================================
-- 1. FUNDAMENTAL TYPES & COUNTING
-- ==========================================

inductive LogicPhase
  | pos
  | neg
deriving BEq, DecidableEq

inductive TopoElement
  | phase : LogicPhase → TopoElement
  | gauge : TopoElement  
deriving BEq, DecidableEq

abbrev TopoString := List TopoElement

-- Physics Postulate: Any un-annihilated element (even a phase) acts as a gauge.
def is_gauge : TopoElement → Bool
  | TopoElement.phase _ => true
  | TopoElement.gauge => true

def count_pos : TopoString → Int
  | [] => 0
  | TopoElement.phase LogicPhase.pos :: tail => 1 + count_pos tail
  | _ :: tail => count_pos tail

def count_neg : TopoString → Int
  | [] => 0
  | TopoElement.phase LogicPhase.neg :: tail => 1 + count_neg tail
  | _ :: tail => count_neg tail

def is_symmetric (s : TopoString) : Prop :=
  count_pos s = count_neg s

-- ==========================================
-- 2. THE HALF-SPIN TOPOLOGY
-- ==========================================

def swap_topo : TopoElement → TopoElement
  | TopoElement.phase LogicPhase.pos => TopoElement.phase LogicPhase.neg
  | TopoElement.phase LogicPhase.neg => TopoElement.phase LogicPhase.pos
  | TopoElement.gauge => TopoElement.gauge

def apply_single_fold : TopoString → TopoString
  | [] => []
  | head :: tail => swap_topo head :: apply_single_fold tail

def apply_double_fold (s : TopoString) : TopoString :=
  apply_single_fold (apply_single_fold s)

lemma swap_topo_twice (x : TopoElement) : swap_topo (swap_topo x) = x := by
  cases x with
  | gauge => rfl
  | phase p => cases p <;> rfl

theorem double_fold_identity (s : TopoString) : apply_double_fold s = s := by
  unfold apply_double_fold
  induction s with
  | nil => rfl
  | cons head tail ih =>
    simp [apply_single_fold, swap_topo_twice, ih]

-- ==========================================
-- 3. THE SINGLE-PASS PRUNE & INVARIANT
-- ==========================================

def zeno_prune : TopoString → TopoString
  | [] => []
  | TopoElement.phase LogicPhase.pos :: TopoElement.phase LogicPhase.neg :: tail => zeno_prune tail
  | TopoElement.phase LogicPhase.neg :: TopoElement.phase LogicPhase.pos :: tail => zeno_prune tail
  | head :: tail => head :: zeno_prune tail

def val_pos : TopoElement → Int
  | TopoElement.phase LogicPhase.pos => 1
  | _ => 0

def val_neg : TopoElement → Int
  | TopoElement.phase LogicPhase.neg => 1
  | _ => 0

lemma count_pos_cons (x : TopoElement) (l : TopoString) :
    count_pos (x :: l) = val_pos x + count_pos l := by
  cases x with
  | gauge => simp [count_pos, val_pos]
  | phase p => cases p <;> simp [count_pos, val_pos]

lemma count_neg_cons (x : TopoElement) (l : TopoString) :
    count_neg (x :: l) = val_neg x + count_neg l := by
  cases x with
  | gauge => simp [count_neg, val_neg]
  | phase p => cases p <;> simp [count_neg, val_neg]

theorem single_prune_invariant (s : TopoString) :
    count_pos (zeno_prune s) - count_neg (zeno_prune s) = count_pos s - count_neg s := by
  induction s using zeno_prune.induct
  · rfl
  · next tail ih =>
    simp [zeno_prune, count_pos, count_neg, ih]
    omega
  · next tail ih =>
    simp [zeno_prune, count_pos, count_neg, ih]
    omega
  · next head tail ih =>
    simp only [zeno_prune, count_pos_cons, count_neg_cons]
    omega

-- ==========================================
-- 4. THE RECURSIVE FIXED-POINT PRUNE
-- ==========================================

def full_zeno_prune (s : TopoString) : TopoString :=
  if _h : (zeno_prune s).length < s.length then
    full_zeno_prune (zeno_prune s)
  else
    s
termination_by s.length

theorem full_prune_invariant (s : TopoString) :
    count_pos (full_zeno_prune s) - count_neg (full_zeno_prune s) =
      count_pos s - count_neg s := by
  let P : Nat → Prop := fun n =>
    ∀ t : TopoString, t.length = n →
      count_pos (full_zeno_prune t) - count_neg (full_zeno_prune t) =
        count_pos t - count_neg t

  have hP : ∀ n, P n := by
    intro n
    refine Nat.strong_induction_on n ?_
    intro n ih t ht
    by_cases hlt : (zeno_prune t).length < t.length
    · rw [full_zeno_prune, dif_pos hlt]
      have hrec_len : (zeno_prune t).length < n := by omega
      have hrec : P (zeno_prune t).length := ih _ hrec_len
      have hrec' :
          count_pos (full_zeno_prune (zeno_prune t)) -
              count_neg (full_zeno_prune (zeno_prune t)) =
            count_pos (zeno_prune t) - count_neg (zeno_prune t) :=
        hrec (zeno_prune t) rfl
      exact hrec'.trans (single_prune_invariant t)
    · rw [full_zeno_prune, dif_neg hlt]
      -- RESOLVED: The explicit `rfl` was deleted here. `rw` automatically closes it!

  exact hP s.length s rfl

-- ==========================================
-- 5. ZERO FREE ACTION (ZFA) & ZERO-COUNT LEMMAS
-- ==========================================

def achieves_ZFA (s : TopoString) : Prop :=
  (full_zeno_prune s).any is_gauge = false

-- RESOLVED: Pushed `h` into the goal with `revert` so `simp` automatically evaluates
-- `is_gauge` to true, rendering the hypothesis `true = false` and closing the proof.
lemma no_gauge_zero_pos : ∀ (l : TopoString), l.any is_gauge = false → count_pos l = 0
  | [], _ => rfl
  | head :: tail, h => by
    revert h
    cases head <;> simp [is_gauge]

lemma no_gauge_zero_neg : ∀ (l : TopoString), l.any is_gauge = false → count_neg l = 0
  | [], _ => rfl
  | head :: tail, h => by
    revert h
    cases head <;> simp [is_gauge]

theorem zfa_implies_zero_count_pos (s : TopoString) (h_zfa : achieves_ZFA s) : 
    count_pos (full_zeno_prune s) = 0 := by
  exact no_gauge_zero_pos (full_zeno_prune s) h_zfa

theorem zfa_implies_zero_count_neg (s : TopoString) (h_zfa : achieves_ZFA s) : 
    count_neg (full_zeno_prune s) = 0 := by
  exact no_gauge_zero_neg (full_zeno_prune s) h_zfa

-- ==========================================
-- 6. THE BRIDGE TO THE CRITICAL LINE
-- ==========================================

theorem zfa_implies_critical_line (s : TopoString) :
    achieves_ZFA s → is_symmetric s := by
  intro h_zfa
  unfold is_symmetric
  
  have h_inv := full_prune_invariant s
  
  have h_pos_zero : count_pos (full_zeno_prune s) = 0 := 
    zfa_implies_zero_count_pos s h_zfa
    
  have h_neg_zero : count_neg (full_zeno_prune s) = 0 := 
    zfa_implies_zero_count_neg s h_zfa
    
  rw [h_pos_zero, h_neg_zero] at h_inv
  
  omega
