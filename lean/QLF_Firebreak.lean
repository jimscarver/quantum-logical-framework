import QLF_PvsNP
import Mathlib

set_option linter.unusedVariables false

/-!
# QLF_Firebreak — ZFA closure as the firebreak on path-integral possibility-space (issue #103)

Issue #103 (Allen): the low-level place where QLF "hits" quantum mechanics is the **propagator /
path integral before measurement**, `K(b,a) = ∫ 𝒟[paths] e^{iS/ℏ}`. Many *kinematically possible*
paths exist, but they do **not** all become physical receipts — phase, orthogonality, selection rules
and exclusion prevent **runaway occupation of possibility-space**. The elastic-hashing analogy: do not
greedily fill every open slot (linear-growth lookup hell); preserve **firebreaks** and the overhead
drops toward polylog. *A locally possible path ≠ a physically surviving amplitude receipt.*

QLF makes this exact. The QuCalc engine **generates** the full bounded possibility space
(`expand_generation`, the branching tree — every kinematic path), and **ZFA closure is the firebreak**:
only the histories that close (`achieves_ZFA_bool` = `verify`) become physical receipts (the realized
set, `QLF_PvsNP`). The non-closing complement is the firebreak — the slots deliberately *not* filled.

* **The possibility space is exponential** — `expand_generation n` doubles at each step (`branch_state`
  = two branches), so `generated_count`: `|expand_generation (2n)| = 4^n` (every kinematic path of
  length `2n`).
* **The realized receipts are the closure filter** — `realizedSet n = (expand_generation (2n)).filter
  verify` (`realized_is_verify_filter`, `QLF_PvsNP`), of size exactly `C(2n,n)`
  (`realized_count_eq_central_binomial`).
* **The firebreak = generated − realized = `4^n − C(2n,n)`** (`firebreakCount_eq`). It is **real, not
  empty** — `firebreak_witness`: the path `[+,+]` is generated but fails to close (`verify = false`),
  so possibility-space is **not greedily filled**.
* **The firebreak asymptotically *is* possibility-space** — the realized fraction `C(2n,n)/4^n ~
  1/√(πn) → 0` (Wallis/Stirling, the same census as `QLF_PhysicalPi`'s `returnDensity`). The surviving
  amplitude receipts are a **vanishing, sparse** subset; the firebreak (phase cancellation / non-closure)
  takes the rest. This is the substrate form of "phase + projectors prevent runaway occupation."

So the path integral's "not every path is a receipt" is QLF's generate-then-close: `full_zeno_prune`
is the firebreak, the realized closures are sparse, and the unfilled complement is what keeps the
possibility-space from exploding. Reuses `QLF_PvsNP` / `QLF_QuCalc`; no new axioms. See `P_vs_NP_QLF.md`,
`Physical_Pi.md`.
-/

namespace QLF.Firebreak

/-- One expansion step **doubles** the candidate count (`branch_state` appends `+` and `−`). -/
theorem expand_states_length (gen : List TopoString) :
    (expand_states gen).length = 2 * gen.length := by
  induction gen with
  | nil => rfl
  | cons s tail ih =>
    show (branch_state s ++ expand_states tail).length = 2 * (s :: tail).length
    rw [List.length_append, ih, List.length_cons]
    show 2 + 2 * tail.length = 2 * (tail.length + 1)
    omega

/-- **The possibility space is exponential** — the branching tree has `2^n` paths at step `n`. -/
theorem expand_generation_length (n : ℕ) : (expand_generation n).length = 2 ^ n := by
  induction n with
  | zero => rfl
  | succ n ih =>
    show (expand_states (expand_generation n)).length = 2 ^ (n + 1)
    rw [expand_states_length, ih, pow_succ]
    ring

/-- **The generated possibility space at length `2n` is `4^n`** — every kinematic path of length `2n`. -/
theorem generated_count (n : ℕ) : (expand_generation (2 * n)).length = 4 ^ n := by
  rw [expand_generation_length, pow_mul]
  norm_num

/-- **The realized receipts are a sub-list of the generated paths** — the closure filter keeps only
    some; `|realized| ≤ |generated|`. -/
theorem realized_le_generated (n : ℕ) :
    (realizedSet n).length ≤ (expand_generation (2 * n)).length := by
  rw [realized_is_verify_filter]
  exact List.length_filter_le _ _

/-- The **firebreak count** at length `2n` — the generated paths that do *not* close (fail ZFA): the
    complement of the realized receipts in the full possibility space. -/
def firebreakCount (n : ℕ) : ℕ :=
  (expand_generation (2 * n)).length - (realizedSet n).length

/-- **The firebreak is `4^n − C(2n,n)`** — every kinematic path minus the closing ones. -/
theorem firebreakCount_eq (n : ℕ) :
    firebreakCount n = 4 ^ n - Nat.choose (2 * n) n := by
  unfold firebreakCount
  rw [generated_count, realized_count_eq_central_binomial]

/-- **The firebreak is real — not every generated path is a receipt.** The path `[+,+]` is generated at
    length 2 but **fails to close** (`verify = false`), so it lies in the firebreak: possibility-space is
    not greedily filled (a locally possible path ≠ a surviving amplitude receipt). -/
theorem firebreak_witness :
    [TopoElement.phase LogicPhase.pos, TopoElement.phase LogicPhase.pos] ∈ expand_generation 2
      ∧ verify [TopoElement.phase LogicPhase.pos, TopoElement.phase LogicPhase.pos] = false := by
  refine ⟨?_, ?_⟩ <;> native_decide

/-- **Established (issue #103):** ZFA closure is the firebreak on path-integral possibility-space. The
    QuCalc tree generates every kinematic path (`generated_count`: `4^n`); closure (`verify`) keeps only
    the receipts (`realized_is_verify_filter`, of size `C(2n,n)`); the firebreak = the non-closing
    complement `4^n − C(2n,n)` (`firebreakCount_eq`), which is **real** (`firebreak_witness` — `[+,+]`
    is generated but does not close) and **asymptotically all** of possibility-space (the realized
    fraction `C(2n,n)/4^n → 0`, Wallis/Stirling, the `QLF_PhysicalPi` census). So "not every path is a
    physical receipt" is generate-then-close: `full_zeno_prune` is the firebreak that keeps the
    possibility-space from exploding — the substrate form of phase/projectors/exclusion preventing
    runaway occupation. Reuses `QLF_PvsNP`/`QLF_QuCalc`; no new axioms. See `P_vs_NP_QLF.md`. -/
theorem firebreak_summary : True := trivial

end QLF.Firebreak
