import QLF_StateSpace

/-!
# QLF_BornProbability — count-ratio Born probabilities satisfy the probability axioms (item 5)

The #65 keystone (issue #115 item 5): the substrate's Born probabilities are **integer path-count
ratios** (`bornProb v k = ‖aₖ‖² / Σⱼ‖aⱼ‖²` over the Gaussian integers, [`QLF_StateSpace`](QLF_StateSpace.lean)),
and they satisfy the Kolmogorov probability axioms — **from integer counting, no primitive real**.
This is what licenses reading amplitudes/logits as a *reporting layer over closure counts*: the
"probabilities" are already a genuine probability measure on the events, built from `ℤ[i]`-norms.

* **`bornProb_nonneg`** — every component probability is `≥ 0` (Gaussian norms are non-negative).
* **`bornProb_sum_eq_one`** — normalization: the component probabilities sum to `1` (given a
  non-degenerate state, i.e. non-zero total norm).
* **`eventProb`** / **`eventProb_disjoint_union`** — additivity: the probability of a set of
  outcomes is the sum of the component probabilities, and it is **additive over disjoint events**
  (`P(S ⊔ T) = P(S) + P(T)`) — the finite Kolmogorov additivity axiom.

Everything is exact `ℚ` arithmetic over `ℤ[i]`-norms; no `Real`, no axioms. The uniqueness of the
Born rule *form* (`|a|²`, Gleason) is a separate, harder statement (the reconstruction program,
[`Completeness_Evidence.md`](../Completeness_Evidence.md) §6); this proves the *measure axioms* for
the count-ratio rule QLF already uses.
-/

namespace QLF.BornProbability

open QLF.StateSpace

/-- **Non-negativity.** Each Born probability is `≥ 0` — a ratio of non-negative Gaussian norms
    (`Zsqrtd.norm_nonneg` at `d = -1 ≤ 0`). -/
theorem bornProb_nonneg {n : ℕ} (v : Fin n → GaussianInt) (k : Fin n) :
    0 ≤ bornProb v k := by
  unfold bornProb
  apply div_nonneg
  · exact_mod_cast Zsqrtd.norm_nonneg (by norm_num) (v k)
  · exact Finset.sum_nonneg (fun j _ => by exact_mod_cast Zsqrtd.norm_nonneg (by norm_num) (v j))

/-- **Normalization.** For a non-degenerate state (non-zero total norm) the component probabilities
    sum to `1`: `Σₖ ‖aₖ‖² / Σⱼ‖aⱼ‖² = (Σₖ‖aₖ‖²)/(Σⱼ‖aⱼ‖²) = 1`. Integer counting, exact. -/
theorem bornProb_sum_eq_one {n : ℕ} (v : Fin n → GaussianInt)
    (h : (∑ j, (Zsqrtd.norm (v j) : ℚ)) ≠ 0) :
    (∑ k, bornProb v k) = 1 := by
  unfold bornProb
  rw [← Finset.sum_div]
  exact div_self h

/-- The probability of an **event** (a set of outcomes) — the sum of its component probabilities. -/
def eventProb {n : ℕ} (v : Fin n → GaussianInt) (S : Finset (Fin n)) : ℚ :=
  ∑ k ∈ S, bornProb v k

/-- **Finite additivity (Kolmogorov's axiom).** The probability of a disjoint union of events is the
    sum of their probabilities: `P(S ⊔ T) = P(S) + P(T)`. -/
theorem eventProb_disjoint_union {n : ℕ} (v : Fin n → GaussianInt)
    (S T : Finset (Fin n)) (hd : Disjoint S T) :
    eventProb v (S ∪ T) = eventProb v S + eventProb v T := by
  unfold eventProb
  exact Finset.sum_union hd

/-- **The full-event probability is `1`** (given a non-degenerate state) — `eventProb` on the whole
    outcome space `Finset.univ` is normalization. -/
theorem eventProb_univ {n : ℕ} (v : Fin n → GaussianInt)
    (h : (∑ j, (Zsqrtd.norm (v j) : ℚ)) ≠ 0) :
    eventProb v Finset.univ = 1 := by
  unfold eventProb
  exact bornProb_sum_eq_one v h

/-- Summary: the count-ratio Born rule (`bornProb` over `ℤ[i]`-norms) is a genuine probability
    measure — non-negative (`bornProb_nonneg`), normalized (`bornProb_sum_eq_one`), finitely additive
    over disjoint events (`eventProb_disjoint_union`) — all exact `ℚ` arithmetic, no primitive real.
    So logits/amplitudes are a reporting layer over closure counts. The *uniqueness* of the `|a|²`
    form (Gleason) is the separate reconstruction target (#115). -/
theorem born_probability_summary : True := trivial

end QLF.BornProbability
