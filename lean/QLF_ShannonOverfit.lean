import QLF_Realizability

/-!
# QLF_ShannonOverfit — the reals over-parameterize physics (non-identifiability)

Machine-checked backing for `Shannon_Overfit.md` and the finite-capacity postulate of the
reconstruction program ([`Completeness_Evidence.md`](../Completeness_Evidence.md) §6). The
charge against ℝ-valued state spaces is sharper than "overfitting"; it is **non-identifiability**
— parameters no finite-capacity evidence can ever constrain. Two finite theorems (no `Real`
*arithmetic*, fitting the conclusion):

* **Theorem A — no real is ever received.** A capacity-`C` channel resolves at most `2^C`
  messages; no injection `ℝ → Fin (2^C)` exists, so no measurement of any design identifies a
  real. Reuses `QLF_Realizability.real_continuum_not_realizable` (pigeonhole).
* **Theorem B — the unconstrained tail.** Every finite `n`-bit dataset leaves an **infinite**
  set of states consistent with it — all bits past the prefix are free. The ℝ-model carries
  degrees of freedom with provably zero identifiability from any finite record.

Theorem C (finite physical capacity — Shannon–Hartley / Landauer / Bekenstein) is the empirical
premise that makes A–B bite; it is ledgered in the doc, not a Lean object. Honest scope: A–B are
pure finite combinatorics; the physics is the *named premise* that bounded systems have finite
capacity. Reuses `QLF_Realizability`; no new axioms.
-/

namespace QLF.ShannonOverfit

/-- **Theorem A — no real is ever received.** No injection from `ℝ` into a capacity-`C`
    channel `Fin (2^C)`; hence no finite measurement record identifies a real number. -/
theorem no_real_received (C : ℕ) (receive : ℝ → Fin (2 ^ C)) :
    ¬ Function.Injective receive :=
  QLF.Realizability.real_continuum_not_realizable C receive

/-- A state is an infinite bit-stream (the idealized real, as its binary expansion). The
    **consistency fiber**: the streams agreeing with a dataset `p` on its first `n` bits. -/
def consistentWith (n : ℕ) (p : ℕ → Bool) : Set (ℕ → Bool) :=
  { s | ∀ i, i < n → s i = p i }

/-- A tail-witness: agrees with `p` on `[0, n)`, and flags exactly position `n + k` — so
    distinct `k` give distinct states, all consistent with the same `n`-bit dataset. -/
def tailWitness (n : ℕ) (p : ℕ → Bool) (k : ℕ) : ℕ → Bool :=
  fun j => if j = n + k then true else (if j < n then p j else false)

/-- Every tail-witness is consistent with the dataset (agrees on the first `n` bits). -/
theorem tailWitness_mem (n : ℕ) (p : ℕ → Bool) (k : ℕ) :
    tailWitness n p k ∈ consistentWith n p := by
  intro i hi
  unfold tailWitness
  rw [if_neg (show i ≠ n + k by omega), if_pos hi]

/-- Distinct `k` give distinct tail-witnesses (they differ at position `n + k`). -/
theorem tailWitness_injective (n : ℕ) (p : ℕ → Bool) :
    Function.Injective (tailWitness n p) := by
  intro a b hab
  by_contra hne
  have h := congrFun hab (n + a)
  unfold tailWitness at h
  rw [if_pos rfl, if_neg (show n + a ≠ n + b by omega),
      if_neg (show ¬ (n + a < n) by omega)] at h
  exact absurd h (by decide)

/-- **Theorem B — the unconstrained tail (non-identifiability).** Every finite `n`-bit dataset
    leaves an *infinite* set of states consistent with it: the ℝ-model posits distinctions no
    finite-capacity channel can ever resolve. -/
theorem tail_unconstrained (n : ℕ) (p : ℕ → Bool) :
    (consistentWith n p).Infinite :=
  Set.infinite_of_injective_forall_mem (tailWitness_injective n p) (fun k => tailWitness_mem n p k)

/-- Summary: no real is received (A), and every finite record leaves an infinite unconstrained
    tail (B). Given finite physical capacity (Theorem C, the empirical premise — Shannon–Hartley /
    Landauer / Bekenstein), the continuum's surplus states are non-identifiable in principle. Not
    "ℝ is inconsistent" — "ℝ violates finite capacity, if capacity is finite." -/
theorem shannon_overfit_summary : True := trivial

end QLF.ShannonOverfit
