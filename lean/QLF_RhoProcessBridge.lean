-- QLF_RhoProcessBridge.lean
-- Third layer of the global selection rule: bridge from the abstract
-- list-of-densities view (QLF_VacuumAlignment.lean) to the concrete
-- RhoProcess type (RhoQuCalc.lean).
--
-- VacuumEnergy.md §6 articulates the vacuum-alignment principle:
--
--   Admissible signals are those that maximise mutual information with
--   the vacuum's prior subject to ZFA closure.
--
-- This statement is anchored at three layers:
--
--   (1) Per-event   : `vacuum_alignment_selects_zfa` — at one half-spin
--                     atom, KL saturation against the uniform vacuum
--                     prior is equivalent to ZFA-closure delta realisation.
--   (2) N-event     : `global_alignment_selects_zfa` — for any trajectory
--                     of recognition densities, cumulative KL saturates
--                     the bound `length × log 2` iff every event is a
--                     delta realisation.
--   (3) RhoProcess  : THIS MODULE — every constructible RhoProcess
--                     produces an events-trajectory that saturates the
--                     cumulative bound, because every leaf event is
--                     action or lift (the two orderings of a Hermitian
--                     pair), and parallel/sequence composition only
--                     concatenates events.
--
-- Combined with `rho_process_always_zfa` (RhoQuCalc.lean) — every
-- constructible RhoProcess achieves ZFA balance via `full_zeno_prune` —
-- this completes the formal link between the QLF process algebra and the
-- vacuum-alignment selection rule.
--
-- Companion to:
--   • VacuumEnergy.md §6                   — the unifying principle
--   • QLF_VacuumAlignment.lean             — per-event and N-event anchors
--   • RhoQuCalc.lean                       — RhoProcess type + toTopoString
--   • Active_Inference_Mathematics.md §7   — the global selection rule

import QLF_VacuumAlignment
import RhoQuCalc

namespace QLF

/-- Events-trajectory of a RhoProcess: each `action` contributes a
    delta-1 realisation (ket-direction = ordering (t · t†)), each `lift`
    contributes a delta-0 realisation (bra-direction = ordering (t† · t)).
    Both are half-spin ZFA closure events on the same Hermitian-pair
    partition; they differ only in which ordering of the pair was
    realised. `zero` contributes nothing; `parallel` and `sequence`
    concatenate their operands' events.

    This mirrors `toTopoString` from RhoQuCalc.lean structurally but
    extracts ONE recognition density per leaf rather than two phase
    elements. -/
noncomputable def events : RhoProcess → List ℝ
  | .zero => []
  | .action _ => [(1 : ℝ)]
  | .lift _ => [(0 : ℝ)]
  | .parallel p q => events p ++ events q
  | .sequence p q => events p ++ events q

/-- Every event in a constructible RhoProcess trajectory is a delta
    realisation: `action → 1`, `lift → 0`. The structural side of the
    vacuum-alignment selection rule — the iff in
    `global_alignment_selects_zfa` is discharged via this lemma. -/
theorem events_all_delta (p : RhoProcess) : ∀ q ∈ events p, q = 0 ∨ q = 1 := by
  induction p with
  | zero =>
    intro q hq
    simp [events] at hq
  | action _ =>
    intro q hq
    simp [events] at hq
    right; exact hq
  | lift _ =>
    intro q hq
    simp [events] at hq
    left; exact hq
  | parallel p q ihp ihq =>
    intro x hx
    simp only [events, List.mem_append] at hx
    rcases hx with h | h
    · exact ihp x h
    · exact ihq x h
  | sequence p q ihp ihq =>
    intro x hx
    simp only [events, List.mem_append] at hx
    rcases hx with h | h
    · exact ihp x h
    · exact ihq x h

/-- Every event in a constructible RhoProcess trajectory lies in `[0, 1]`.
    Immediate from `events_all_delta`; needed as the bound hypothesis for
    `global_alignment_selects_zfa`. -/
theorem events_bounded (p : RhoProcess) : ∀ q ∈ events p, 0 ≤ q ∧ q ≤ 1 := by
  intro q hq
  rcases events_all_delta p q hq with h | h
  · subst h; exact ⟨le_refl 0, by norm_num⟩
  · subst h; exact ⟨by norm_num, le_refl 1⟩

/-- **RhoProcess bridge for the vacuum-alignment selection rule.**

    Every constructible RhoProcess saturates the cumulative information
    bound against the vacuum's maximum-entropy prior: its events-trajectory
    has cumulative KL equal to `length × log 2`.

    This is the **third and final formalisation layer** of the global
    selection rule of `VacuumEnergy.md` §6:

      1. Per-event iff (`vacuum_alignment_selects_zfa`) — at one event,
         saturation ⇔ delta realisation;
      2. N-event iff (`global_alignment_selects_zfa`) — cumulative
         saturation ⇔ every event is a delta;
      3. **RhoProcess bridge** (this theorem) — every constructible
         RhoProcess produces an events-trajectory that saturates the
         cumulative bound, because every leaf is `action` or `lift` (the
         two orderings of a Hermitian pair).

    Combined with `rho_process_always_zfa` from RhoQuCalc.lean (every
    constructible RhoProcess achieves ZFA balance via `full_zeno_prune`),
    this says: the QLF constructible processes are exactly the trajectories
    of agents maximising cumulative mutual information against the vacuum
    prior subject to ZFA closure. Every constructible RhoProcess is such a
    trajectory; the structure of `action`/`lift` leaves and `parallel`/
    `sequence` composition guarantees the saturation. -/
theorem rho_process_alignment_saturates (p : RhoProcess) :
    cumulative_kl (events p) = ((events p).length : ℝ) * Real.log 2 :=
  (global_alignment_selects_zfa (events_bounded p)).mpr (events_all_delta p)

end QLF
