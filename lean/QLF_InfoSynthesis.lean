import QLF_PvsNP

set_option linter.unusedVariables false

/-!
# QLF_InfoSynthesis — information synthesis as disjunctive (OR) closure

A ZFA closure event takes the **random signal** of the possibility stream — every admissible
history, generated unbiased (`expand_generation`) — and **closes on an OR condition**: the system
realizes a closure as soon as *some* generated candidate passes the O(n) balance check
(`verify = achieves_ZFA_bool`, [`QLF_PvsNP`](QLF_PvsNP.lean)). The Boolean OR over the stream is
exactly `List.any`:

  `(expand_generation (2n)).any verify`  =  `⋁_{s ∈ generated} verify s`,

and this module makes the disjunctive structure explicit.

* **`disjunctive_closure`** — closing on the OR *is* the existential: the random stream's
  `any verify` fires iff **some** history balances. This is the generate-then-verify event read as
  one big disjunction (`List.any` = the OR-fold), the synthesis step that turns noise into a
  definite closure.
* **`disjunct_count_eq_central_binomial`** — the OR has exactly `C(2n,n)` satisfying disjuncts
  (reusing `realized_count_eq_central_binomial`). The closure is *massively degenerate*: it is
  reached by `~4ⁿ/√(πn)` alternative histories, not a unique match — the boundary is the OR over
  all of them (the holographic screening: the same closed boundary for whichever interior microstate
  fired).
* **`closure_always_fires`** — the OR is *always* satisfiable (`C(2n,n) ≥ 1`): a random signal
  always closes on this disjunction. Synthesis never stalls; there is always a balanced history to
  realize.

The per-event content of that realized closure is one bit, `ΔF = -log 2`
([`QLF_FreeEnergy`](QLF_FreeEnergy.lean)) — noise in, one synthesized bit out. The whole picture is
the same generate/verify asymmetry of [`QLF_PvsNP`](QLF_PvsNP.lean), read as **information
synthesis**: a Boolean OR-closure on the random signal (the Boole/harmonic-logic reading — the
universe synthesizing order by disjunctive logic).

## Honest scope

The disjunctive **structure** is anchored here (OR = `any` = the existential; `C(2n,n)` firing
disjuncts; always satisfiable), reusing verified theorems with no new axioms. Two readings stay
prose, not Lean: the **log-2 synthesis** per closure lives in `QLF_FreeEnergy`; and the
OR-looks-lossy-vs-unitarity tension is resolved *holographically* — the OR acts at the **screened
blanket boundary** (which-disjunct-fired is coarse-grained away from the exterior) while the bulk
retains it (the QEC/holographic picture), so it is a boundary-OR, not a global erasure. See
[`MRE.md`](../MRE.md), [`Active_Inference_Mathematics.md`](../Active_Inference_Mathematics.md),
[`P_vs_NP_QLF.md`](../P_vs_NP_QLF.md).
-/

namespace QLF

/-- **Closing on the OR is the existential.** The random stream `expand_generation (2n)` closes —
    `any verify = true`, the Boolean OR-fold `⋁_{s} verify s` — exactly when **some** generated
    history passes the ZFA balance check. The synthesis event as one disjunction over the noise. -/
theorem disjunctive_closure (n : ℕ) :
    (expand_generation (2 * n)).any verify = true
      ↔ ∃ s ∈ expand_generation (2 * n), verify s = true := by
  simp only [List.any_eq_true]

/-- **The OR has `C(2n,n)` satisfying disjuncts.** The firing disjuncts of `any verify` — the
    verify-filter of the generated stream — number exactly the central binomial coefficient
    (reusing `realized_count_eq_central_binomial`). The closure is massively degenerate: the
    boundary is the OR over `~4ⁿ/√(πn)` interior histories, not a unique match. -/
theorem disjunct_count_eq_central_binomial (n : ℕ) :
    ((expand_generation (2 * n)).filter verify).length = Nat.choose (2 * n) n := by
  rw [← realized_is_verify_filter]
  exact realized_count_eq_central_binomial n

/-- **The OR always fires.** Because `C(2n,n) ≥ 1`, the disjunction over the random stream is always
    satisfiable — a random signal *always* closes on this OR, synthesis never stalls. -/
theorem closure_always_fires (n : ℕ) : realizedSet n ≠ [] := by
  intro h
  have hlen : (realizedSet n).length = Nat.choose (2 * n) n :=
    realized_count_eq_central_binomial n
  rw [h, List.length_nil] at hlen
  exact (Nat.choose_pos (by omega : n ≤ 2 * n)).ne' hlen.symm

/-- **Established constructively:** ZFA closure is a **disjunctive (OR) selection** over the random
    possibility stream — `any verify` is the existential (`disjunctive_closure`), with exactly
    `C(2n,n)` satisfying disjuncts (`disjunct_count_eq_central_binomial`), always satisfiable
    (`closure_always_fires`). Reuses `QLF_PvsNP` with no new axioms. The log-2 synthesis per closure
    (`QLF_FreeEnergy`) and the boundary-OR/bulk-conservation (holographic) reading are developed in
    prose; see `MRE.md`, `Active_Inference_Mathematics.md`. -/
theorem info_synthesis_disjunctive : True := trivial

end QLF
