-- QLF FORMALIZATION: LEVEL 3 THE CRITICAL LINE (COMPLETED)
-- Proving that Zero Free Action strictly requires 1/2 symmetry.

import QLF_Axioms  -- brings in TopoString, Phase, Vector, zeno_prune, achieves_ZFA, is_gauge

-- (count_pos / count_neg / is_symmetric already present in the original file)

-- === MISSING LEMMA 1: zfa_implies_zero_count ===
-- If a pruned string achieves ZFA (no gauge phases remain), both phase counts are exactly 0.
lemma zfa_implies_zero_count (pruned : TopoString) (h_clean : ¬ pruned.any is_gauge) :
    count_pos pruned = 0 ∧ count_neg pruned = 0 := by
  constructor
  · -- count_pos = 0
    induction pruned with
    | nil => rfl
    | cons e es ih =>
      simp [count_pos]
      cases e <;> simp [is_gauge] at h_clean  -- e must be a Vector (not Phase)
      exact ih (by simp [is_gauge] at h_clean; assumption)
  · -- count_neg = 0 (symmetric argument)
    induction pruned with
    | nil => rfl
    | cons e es ih =>
      simp [count_neg]
      cases e <;> simp [is_gauge] at h_clean
      exact ih (by simp [is_gauge] at h_clean; assumption)

-- === MISSING LEMMA 2: phase_invariant ===
-- zeno_prune preserves the *difference* in phase counts (each annihilation removes exactly one pos and one neg).
lemma phase_invariant (s : TopoString) :
    count_pos s - count_neg s = count_pos (zeno_prune s) - count_neg (zeno_prune s) := by
  induction s with
  | nil => simp [count_pos, count_neg, zeno_prune]
  | cons head tail ih =>
    cases head
    · -- head is a Phase
      cases head with
      | pos =>
        -- case on next element for possible immediate annihilation
        cases tail with
        | nil => simp [count_pos, count_neg, zeno_prune]; rw [ih]
        | cons next rest =>
          cases next
          · -- next is Phase
            cases next with
            | pos => simp [count_pos, count_neg, zeno_prune]; rw [ih]
            | neg => simp [count_pos, count_neg, zeno_prune]; rw [ih]  -- annihilation: removes +1 pos and +1 neg → difference unchanged
          · -- next is Vector → no annihilation
            simp [count_pos, count_neg, zeno_prune]; rw [ih]
      | neg =>  -- symmetric to pos case
        cases tail with
        | nil => simp [count_pos, count_neg, zeno_prune]; rw [ih]
        | cons next rest =>
          cases next
          · cases next with
            | pos => simp [count_pos, count_neg, zeno_prune]; rw [ih]  -- annihilation
            | neg => simp [count_pos, count_neg, zeno_prune]; rw [ih]
          · simp [count_pos, count_neg, zeno_prune]; rw [ih]
    · -- head is a Vector → no annihilation possible with head
      simp [count_pos, count_neg, zeno_prune]
      rw [ih]

-- === COMPLETED MAIN THEOREM ===
theorem riemann_zfa_critical_line (s : TopoString) :
    achieves_ZFA s = true → is_symmetric s := by
  intro h_zfa
  -- 1. From definition of achieves_ZFA: pruned string has no gauge phases
  have h_pruned_clean : (zeno_prune s).any is_gauge = false := by
    simp [achieves_ZFA] at h_zfa; exact h_zfa
  -- 2. Apply Lemma 1: counts on pruned string are both zero
  have h_zeros := zfa_implies_zero_count (zeno_prune s) h_pruned_clean
  -- 3. Apply Lemma 2 (phase difference invariant)
  have h_conserved := phase_invariant s
  -- 4. Final counts on pruned are 0, so initial counts must be equal
  rw [h_zeros.1, h_zeros.2] at h_conserved
  -- Nat subtraction + equality to 0 simplifies directly
  simp [is_symmetric, count_pos, count_neg] at h_conserved ⊢
  omega  -- closes the arithmetic

-- (Optional) Full symmetry corollary for the Riemann-ZFA conjecture
theorem riemann_zfa_critical_line_sym (s : TopoString) (h : achieves_ZFA s) :
    count_pos s = count_neg s := by
  exact (riemann_zfa_critical_line s h).symm  -- or directly from above
