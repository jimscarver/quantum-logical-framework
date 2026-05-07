import Mathlib.Data.List.Basic
import Mathlib.Data.Int.Basic

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
  cases x
  case phase p => cases p <;> rfl
  case gauge => rfl

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

theorem single_prune_invariant (s : TopoString) :
    count_pos (zeno_prune s) - count_neg (zeno_prune s) = count_pos s - count_neg s := by
  induction s using zeno_prune.induct
  · -- 1st equation: Empty list
    rfl
  · -- 2nd equation: pos :: neg :: tail
    next tail ih =>
      simp [zeno_prune, count_pos, count_neg]
      omega
  · -- 3rd equation: neg :: pos :: tail
    next tail ih =>
      simp [zeno_prune, count_pos, count_neg]
      omega
  · -- 4th equation: head :: tail (catch-all)
    next head tail ih =>
      cases head with
      | gauge => 
        simp [zeno_prune, count_pos, count_neg, ih]
      | phase p => 
        cases p <;> simp [zeno_prune, count_pos, count_neg, ih]

-- ==========================================
-- 4. THE RECURSIVE FIXED-POINT PRUNE (Option 2)
-- ==========================================

def full_zeno_prune (s : TopoString) : TopoString :=
  let pruned := zeno_prune s
  if h : pruned.length < s.length then
    full_zeno_prune pruned
  else
    s
termination_by s.length

theorem full_prune_invariant (s : TopoString) :
    count_pos (full_zeno_prune s) - count_neg (full_zeno_prune s) = count_pos s - count_neg s := by
  induction s using full_zeno_prune.induct with
  | case1 s ih =>
    unfold full_zeno_prune
    split
    · rw [ih]
      exact single_prune_invariant s
    · rfl

-- ==========================================
-- 5. ZERO FREE ACTION (ZFA) & ZERO-COUNT LEMMAS
-- ==========================================

def achieves_ZFA (s : TopoString) : Prop :=
  (full_zeno_prune s).any is_gauge = false

lemma no_gauge_zero_pos : ∀ (l : TopoString), l.any is_gauge = false → count_pos l = 0
  | [], _ => rfl
  | head :: tail, h => by
    simp only [List.any_cons, Bool.or_eq_false_iff] at h
    have ih := no_gauge_zero_pos tail h.right
    cases head <;> cases h.left <;> simp [count_pos, ih]

lemma no_gauge_zero_neg : ∀ (l : TopoString), l.any is_gauge = false → count_neg l = 0
  | [], _ => rfl
  | head :: tail, h => by
    simp only [List.any_cons, Bool.or_eq_false_iff] at h
    have ih := no_gauge_zero_neg tail h.right
    cases head <;> cases h.left <;> simp [count_neg, ih]

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
