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

import QLF.QLF_FreeEnergy

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
    push_neg at hnot
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

end QLF
