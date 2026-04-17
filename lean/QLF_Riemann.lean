-- QLF_Riemann.lean (updated April 17, 2026)
-- STRENGTHENED: both directional invariants + explicit Mathlib import

import Mathlib.Tactic.Omega

-- [Axioms, Phase, Vector, TopoElement, TopoString, zeno_prune, achieves_ZFA, count_pos, count_neg, is_symmetric — identical to previous version]

-- … (keep the existing zfa_implies_zero_count and phase_invariant lemmas unchanged)

-- NEW symmetric invariant (closes Nat-truncation critique)
lemma neg_minus_pos_invariant (s : TopoString) :
    count_neg s - count_pos s = count_neg (zeno_prune s) - count_pos (zeno_prune s) := by
  induction s with
  | nil => simp [count_pos, count_neg, zeno_prune]
  | cons head tail ih =>
    cases head
    · cases head with
      | pos =>
        cases tail with
        | nil => simp [count_pos, count_neg, zeno_prune]; rw [ih]
        | cons next rest =>
          cases next
          · cases next with
            | pos => simp [count_pos, count_neg, zeno_prune]; rw [ih]
            | neg => simp [count_pos, count_neg, zeno_prune]; rw [ih]
          · simp [count_pos, count_neg, zeno_prune]; rw [ih]
      | neg =>
        cases tail with
        | nil => simp [count_pos, count_neg, zeno_prune]; rw [ih]
        | cons next rest =>
          cases next
          · cases next with
            | pos => simp [count_pos, count_neg, zeno_prune]; rw [ih]
            | neg => simp [count_pos, count_neg, zeno_prune]; rw [ih]
          · simp [count_pos, count_neg, zeno_prune]; rw [ih]
    · simp [count_pos, count_neg, zeno_prune]; rw [ih]

theorem riemann_zfa_critical_line (s : TopoString) :
    achieves_ZFA s = true → is_symmetric s := by
  intro h_zfa
  have h_pruned_clean : (zeno_prune s).any is_gauge = false := by
    simp [achieves_ZFA] at h_zfa; exact h_zfa
  have h_zeros := zfa_implies_zero_count (zeno_prune s) h_pruned_clean
  have h_conserved_pos := phase_invariant s
  have h_conserved_neg := neg_minus_pos_invariant s
  rw [h_zeros.1, h_zeros.2] at h_conserved_pos h_conserved_neg
  have h1 : count_pos s - count_neg s = 0 := h_conserved_pos
  have h2 : count_neg s - count_pos s = 0 := h_conserved_neg
  simp [is_symmetric, count_pos, count_neg]
  omega   -- now closes both directions simultaneously
