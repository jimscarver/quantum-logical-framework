-- QLF_VacuumAlignment.lean
-- The TOE-completing per-event anchor:
--   ZFA-admissibility is exactly mutual-information saturation against the
--   vacuum's maximum-entropy prior.
--
-- VacuumEnergy.md §6 articulates the vacuum-alignment principle: the vacuum
-- is a near-maximum-entropy background, and admissible signals are those
-- that maximise mutual information with the vacuum's global prior subject
-- to ZFA closure. §6.3 names the per-event selection rule that ties closure,
-- energetics, and dynamics under a single statement.
--
-- This module proves the per-event Lean anchor for that principle. Under the
-- vacuum's uniform Bernoulli(1/2) prior on a Hermitian-pair partition, the
-- Kullback-Leibler divergence of a candidate recognition density saturates
-- at log 2 if and only if the density is a delta realisation (q ∈ {0, 1}).
-- The delta realisations are exactly the half-spin ZFA closure events.
--
-- The two halves were already Lean-anchored in QLF_FreeEnergy.lean:
--   • `binary_kl_delta_uniform`     — q = 1 ⇒ KL = log 2
--   • `binary_kl_uniform_lt_log_two` — q ∈ (0, 1) ⇒ KL < log 2
--
-- This module adds the symmetric q = 0 case (`binary_kl_delta_zero_uniform`)
-- and combines all three into the bidirectional theorem
-- `vacuum_alignment_selects_zfa`. The companion-of-companions:
--
--   ZFA-closed history H  ↔  delta realisation on its Hermitian-pair
--                            partition  ↔  KL saturates log 2 against
--                            the uniform vacuum prior.
--
-- The twist-history half of the bridge (every ZFA-closed history factors
-- through Hermitian-pair binary partitions) is captured in QLF_TwistAlphabet,
-- BraKetRhoQuCalc, and RhoQuCalc by `hermitian_pair_is_pauli_scalar`,
-- `bra_ket_always_balanced`, and `rho_process_always_zfa` respectively.
-- Together with the information-side iff proved here, the vacuum-alignment
-- selection rule of VacuumEnergy.md §6.3 has a complete per-event anchor.
--
-- Status: per-event statement. The global selection rule (every constructible
-- RhoProcess is the trajectory of an agent maximising mutual information
-- against the vacuum prior) is the next-tier theorem flagged in
-- Active_Inference_Mathematics.md §7; the per-event iff established here
-- is its first formal anchor.
--
-- Companion to:
--   • VacuumEnergy.md §6                    — the unifying principle statement
--   • QLF_FreeEnergy.lean                   — the two halves combined here
--   • MRE.md §2.1                           — binary-partition KL ≤ log 2
--   • Active_Inference_Mathematics.md §3/§7 — the global selection rule

import QLF_FreeEnergy

namespace QLF

/-- KL of the q = 0 delta against the uniform Bernoulli(1/2) prior is `log 2`.
    Symmetric to `binary_kl_delta_uniform` (which proves the q = 1 case).

    Both deltas saturate KL at `log 2`: q = 1 corresponds to realisation in
    ordering (t · t†), q = 0 to realisation in ordering (t† · t). Both are
    half-spin ZFA closure events on the same Hermitian-pair partition. -/
theorem binary_kl_delta_zero_uniform : binary_kl 0 (1/2) = Real.log 2 := by
  unfold binary_kl
  have h1 : (0 : ℝ) / (1/2) = 0 := by norm_num
  have h2 : (1 - 0 : ℝ) / (1 - 1/2) = 2 := by norm_num
  rw [h1, h2]
  simp

/-- **Vacuum-alignment selects ZFA** — the per-event Lean anchor for
    `VacuumEnergy.md` §6.

    Under the uniform maximum-entropy prior `p = 1/2` (the vacuum's
    Bernoulli prior on the Hermitian-pair partition of a half-spin atom),
    the per-event information gain `D_KL((q, 1-q) ‖ (1/2, 1/2))` saturates
    at `log 2` if and only if the recognition density `q` is a delta
    realisation, i.e. `q ∈ {0, 1}`.

    The delta realisations `q ∈ {0, 1}` are exactly the half-spin ZFA closure
    events (one for each ordering of the Hermitian-conjugate pair). The
    spread-out densities `q ∈ (0, 1)` are exactly the non-closed alternatives.

    This is the per-event formal statement of the vacuum-alignment principle
    from `VacuumEnergy.md` §6.3:

      *Admissible signals are those that maximise mutual information with
       the vacuum's prior subject to ZFA closure.*

    Forward direction (saturation ⇒ delta = ZFA closure): any non-delta
    density `q ∈ (0, 1)` achieves strictly less than `log 2` under the
    uniform prior, by `binary_kl_uniform_lt_log_two`. Contrapositive: only
    deltas saturate.

    Backward direction (delta ⇒ saturation): both `q = 0` and `q = 1`
    achieve exactly `log 2`, by `binary_kl_delta_zero_uniform` and
    `binary_kl_delta_uniform`.

    Together: KL saturation against the maximum-entropy vacuum prior
    is equivalent to ZFA-closure delta realisation. This is the per-event
    discharge of the selection-rule statement flagged as the missing
    unifying principle in `Active_Inference_Mathematics.md` §7. -/
theorem vacuum_alignment_selects_zfa
    {q : ℝ} (hq1 : 0 ≤ q) (hq2 : q ≤ 1) :
    binary_kl q (1/2) = Real.log 2 ↔ q = 0 ∨ q = 1 := by
  constructor
  · intro hkl
    by_contra hnot
    push Not at hnot
    obtain ⟨hne0, hne1⟩ := hnot
    have h0lt : 0 < q := lt_of_le_of_ne hq1 (Ne.symm hne0)
    have hlt1 : q < 1 := lt_of_le_of_ne hq2 hne1
    have hstrict : binary_kl q (1/2) < Real.log 2 :=
      binary_kl_uniform_lt_log_two h0lt hlt1
    linarith
  · intro h
    rcases h with h0 | h1
    · subst h0; exact binary_kl_delta_zero_uniform
    · subst h1; exact binary_kl_delta_uniform

/-- The complementary statement of `vacuum_alignment_selects_zfa`:
    misalignment costs information. For any non-closure recognition density
    `q ∈ (0, 1)` on the Hermitian-pair partition, the information gain
    against the vacuum prior is strictly less than the closure value.

    This is the falsification-side of the selection rule: signals that fail
    to align with the vacuum prior at the half-spin level **leak** information
    relative to the closure case — a per-event statement of why non-ZFA
    histories are pruned by `full_zeno_prune`. -/
theorem misalignment_strictly_underperforms
    {q : ℝ} (h0lt : 0 < q) (hlt1 : q < 1) :
    binary_kl q (1/2) < binary_kl 1 (1/2) := by
  rw [binary_kl_delta_uniform]
  exact binary_kl_uniform_lt_log_two h0lt hlt1

-- =====================================================================
-- Global selection rule — the trajectory-level lift of the per-event iff.
--
-- The per-event theorem `vacuum_alignment_selects_zfa` states that at a
-- single half-spin atom, KL saturation against the vacuum's uniform prior
-- is equivalent to ZFA-closure delta realisation. The global selection
-- rule (Active_Inference_Mathematics.md §7) extends this to trajectories:
-- a sequence of recognition events saturates the cumulative information
-- bound iff every event in the sequence is a ZFA closure.
--
-- Below: `cumulative_kl` is the per-event KL summed over a list of
-- recognition densities. The bound `cumulative_kl_le_length_log_two`
-- states it never exceeds length × log 2. The iff
-- `global_alignment_selects_zfa` states that saturation of this bound is
-- equivalent to every event being a delta realisation — i.e., every
-- event being a ZFA closure. This is the trajectory-level Lean anchor
-- for VacuumEnergy.md §6.3's global selection rule statement, lifted
-- from per-event KL to cumulative-trajectory KL.
--
-- The next layer above this — bridging from a list of recognition
-- densities to the RhoQuCalc.lean RhoProcess type (showing every
-- constructible RhoProcess corresponds to a saturating list) — remains
-- future work; what is established here is the cumulative-information
-- characterisation in its purest form.
-- =====================================================================

/-- KL upper bound extended to the closed unit interval `[0, 1]`. Combines
    `binary_kl_uniform_lt_log_two` (the strict interior bound) with the
    two endpoint cases (`binary_kl_delta_zero_uniform`,
    `binary_kl_delta_uniform`). -/
theorem binary_kl_uniform_le_log_two_endpoint
    {q : ℝ} (hq1 : 0 ≤ q) (hq2 : q ≤ 1) :
    binary_kl q (1/2) ≤ Real.log 2 := by
  by_cases h0 : q = 0
  · rw [h0, binary_kl_delta_zero_uniform]
  · by_cases h1 : q = 1
    · rw [h1, binary_kl_delta_uniform]
    · have h0lt : 0 < q := lt_of_le_of_ne hq1 (Ne.symm h0)
      have hlt1 : q < 1 := lt_of_le_of_ne hq2 h1
      exact le_of_lt (binary_kl_uniform_lt_log_two h0lt hlt1)

/-- Cumulative Kullback-Leibler divergence for a trajectory of recognition
    densities against the uniform vacuum prior. Sums the per-event KL over
    a list of densities. -/
noncomputable def cumulative_kl (qs : List ℝ) : ℝ :=
  (qs.map (fun q => binary_kl q (1/2))).sum

/-- The cumulative KL of a trajectory is bounded above by `length × log 2`
    — the cumulative-information bound on the maximum-entropy vacuum prior.
    Every trajectory respects this bound; saturation is the topic of the
    next theorem. -/
theorem cumulative_kl_le_length_log_two
    {qs : List ℝ} (hqs : ∀ q ∈ qs, 0 ≤ q ∧ q ≤ 1) :
    cumulative_kl qs ≤ (qs.length : ℝ) * Real.log 2 := by
  induction qs with
  | nil => simp [cumulative_kl]
  | cons q rest ih =>
    have hq_bnd : 0 ≤ q ∧ q ≤ 1 := hqs q (List.mem_cons_self)
    have hrest_bnd : ∀ q' ∈ rest, 0 ≤ q' ∧ q' ≤ 1 :=
      fun q' hq' => hqs q' (List.mem_cons_of_mem q hq')
    have hq_le : binary_kl q (1/2) ≤ Real.log 2 :=
      binary_kl_uniform_le_log_two_endpoint hq_bnd.1 hq_bnd.2
    have hrest_le : cumulative_kl rest ≤ (rest.length : ℝ) * Real.log 2 :=
      ih hrest_bnd
    have hcum_cons : cumulative_kl (q :: rest) = binary_kl q (1/2) + cumulative_kl rest := by
      simp [cumulative_kl]
    have hlen : ((q :: rest).length : ℝ) = (rest.length : ℝ) + 1 := by
      simp [List.length_cons]
    rw [hcum_cons, hlen]
    have : (rest.length : ℝ) * Real.log 2 + Real.log 2 = ((rest.length : ℝ) + 1) * Real.log 2 := by
      ring
    linarith

/-- **Global vacuum-alignment selection rule** — the trajectory-level Lean
    anchor for `VacuumEnergy.md` §6.3.

    For a trajectory of recognition densities `qs : List ℝ` against the
    uniform maximum-entropy vacuum prior, the cumulative information gain
    `cumulative_kl qs` saturates the upper bound `length × log 2` if and
    only if every event in the trajectory is a delta realisation, i.e.
    every recognition density is in `{0, 1}`.

    Combined with the per-event iff `vacuum_alignment_selects_zfa`, this
    says: a trajectory maximises cumulative mutual information against the
    vacuum prior if and only if every event in it is a half-spin ZFA
    closure. This is the global selection rule:

      *Every constructible trajectory that maximises cumulative mutual
       information against the vacuum prior is a sequence of ZFA closure
       events — and conversely, every sequence of ZFA closure events
       saturates the cumulative information bound.*

    Proof: by induction on `qs`. The nil case is trivial. In the cons case,
    the cumulative bound saturates iff both the per-event KL at the head and
    the cumulative KL of the tail saturate (a sum of bounded values equals
    the bound only when each summand does). The per-event saturation gives
    `q = 0 ∨ q = 1` via `vacuum_alignment_selects_zfa`; the tail saturation
    gives the inductive predicate for the rest. -/
theorem global_alignment_selects_zfa
    {qs : List ℝ} (hqs : ∀ q ∈ qs, 0 ≤ q ∧ q ≤ 1) :
    cumulative_kl qs = (qs.length : ℝ) * Real.log 2 ↔
      ∀ q ∈ qs, q = 0 ∨ q = 1 := by
  induction qs with
  | nil =>
    refine ⟨?_, ?_⟩
    · intro _ q hq; exact absurd hq (List.not_mem_nil)
    · intro _; simp [cumulative_kl]
  | cons q rest ih =>
    have hq_bnd : 0 ≤ q ∧ q ≤ 1 := hqs q (List.mem_cons_self)
    have hrest_bnd : ∀ q' ∈ rest, 0 ≤ q' ∧ q' ≤ 1 :=
      fun q' hq' => hqs q' (List.mem_cons_of_mem q hq')
    have ihr := ih hrest_bnd
    have hq_le : binary_kl q (1/2) ≤ Real.log 2 :=
      binary_kl_uniform_le_log_two_endpoint hq_bnd.1 hq_bnd.2
    have hrest_le : cumulative_kl rest ≤ (rest.length : ℝ) * Real.log 2 :=
      cumulative_kl_le_length_log_two hrest_bnd
    have hcum_cons : cumulative_kl (q :: rest) = binary_kl q (1/2) + cumulative_kl rest := by
      simp [cumulative_kl]
    have hlen : ((q :: rest).length : ℝ) = (rest.length : ℝ) + 1 := by
      simp [List.length_cons]
    rw [hcum_cons, hlen]
    refine ⟨?_, ?_⟩
    · intro hsum
      -- hsum : binary_kl q (1/2) + cumulative_kl rest = ((rest.length : ℝ) + 1) * log 2
      have hq_sat : binary_kl q (1/2) = Real.log 2 := by nlinarith
      have hrest_sat : cumulative_kl rest = (rest.length : ℝ) * Real.log 2 := by nlinarith
      have hq_zfa : q = 0 ∨ q = 1 :=
        (vacuum_alignment_selects_zfa hq_bnd.1 hq_bnd.2).mp hq_sat
      have hrest_zfa : ∀ q' ∈ rest, q' = 0 ∨ q' = 1 := (ihr).mp hrest_sat
      intro q' hq'
      rw [List.mem_cons] at hq'
      rcases hq' with hq_eq | hq_in
      · rw [hq_eq]; exact hq_zfa
      · exact hrest_zfa q' hq_in
    · intro hall
      have hq_zfa : q = 0 ∨ q = 1 := hall q (List.mem_cons_self)
      have hq_sat : binary_kl q (1/2) = Real.log 2 :=
        (vacuum_alignment_selects_zfa hq_bnd.1 hq_bnd.2).mpr hq_zfa
      have hrest_all : ∀ q' ∈ rest, q' = 0 ∨ q' = 1 :=
        fun q' hq' => hall q' (List.mem_cons_of_mem q hq')
      have hrest_sat : cumulative_kl rest = (rest.length : ℝ) * Real.log 2 :=
        (ihr).mpr hrest_all
      have : (rest.length : ℝ) * Real.log 2 + Real.log 2 = ((rest.length : ℝ) + 1) * Real.log 2 := by
        ring
      linarith

end QLF
