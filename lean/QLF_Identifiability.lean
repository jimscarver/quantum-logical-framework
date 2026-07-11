import Mathlib

/-!
# QLF_Identifiability — capacity bounds distinguishability; the unconstrained tail (item 2, K-free)

The provable core of [`Shannon_Overfit.md`](../Shannon_Overfit.md) without building Kolmogorov
complexity (issue #115 item 2). Complements [`QLF_ShannonOverfit`](QLF_ShannonOverfit.lean) with the
capacity-counting and finite-precision-tail theorems, stated as theorems *of classical mathematics
about its own ontology* — no claim of ZFC inconsistency, that is the point.

* **Theorem A** (`capacity_bound`) — a `C`-bit record distinguishes at most `2^C` states (pigeonhole).
* **Theorem B** (`consistent_set_infinite`) — any positive-width finite-precision record leaves an
  *infinite* set of consistent real states: the non-identifiable tail.

The physical premise (every bounded system has finite capacity) is empirical, forever outside Lean
(Theorem C of the doc, prose only). The `Identifiable ⟺ computable` equivalence and the continuum
cardinality are the next phases.
-/

namespace QLF.Identifiability

/-! ## Theorem A — capacity bounds distinguishability -/

/-- A protocol transcript of `C` bits. -/
abbrev Transcript (C : ℕ) := Fin C → Bool

/-- A `C`-bit transcript space has exactly `2^C` elements. -/
theorem transcript_card (C : ℕ) : Fintype.card (Transcript C) = 2 ^ C := by
  simp [Transcript, Fintype.card_fun]

/-- **Theorem A.** A `C`-bit measurement scheme distinguishes at most `2^C` states: if a state
    space injects into the transcripts, its cardinality is `≤ 2^C`. Pure pigeonhole. -/
theorem capacity_bound {σ : Type*} [Fintype σ] (C : ℕ)
    (record : σ → Transcript C) (h : Function.Injective record) :
    Fintype.card σ ≤ 2 ^ C :=
  calc Fintype.card σ ≤ Fintype.card (Transcript C) :=
        Fintype.card_le_of_injective record h
    _ = 2 ^ C := transcript_card C

/-! ## Theorem B — the unconstrained tail -/

/-- **Theorem B (infinite form).** Any finite-precision record is a positive-width interval of
    consistent values, and the consistent set is *infinite* — uncountably many theory-distinct
    real states, none separable by the evidence. The `ℝ`-ontology carries non-identifiable degrees
    of freedom past every finite capacity bound of Theorem A. -/
theorem consistent_set_infinite (a b : ℝ) (h : a < b) :
    (Set.Icc a b).Infinite :=
  Set.infinite_coe_iff.mp (Set.Icc.infinite h)

/-! ## Identifiability ⟺ computability -/

/-- A real is **identifiable** iff some *computable* protocol emits rational approximants at every
    requested precision. This is simultaneously the operational definition of measurement-in-
    principle and the standard definition of a computable real — which is the point: once both are
    written down, the "equivalence" is definitional, and the real content moves into robustness
    (independence of the modulus, a later phase / issue #115). -/
def Identifiable (x : ℝ) : Prop :=
  ∃ f : ℕ → ℚ, Computable f ∧ ∀ n : ℕ, |x - (f n : ℝ)| ≤ (1 / 2 : ℝ) ^ n

/-- **Rationals are identifiable** — the sanity anchor validating the `Computable` plumbing (the
    constant sequence is computable and exact). -/
theorem identifiable_rat (q : ℚ) : Identifiable (q : ℝ) := by
  refine ⟨fun _ => q, Computable.const q, fun n => ?_⟩
  simp only [sub_self, abs_zero]
  positivity

/-- **Robustness.** Any computable approximation with *any* computable modulus of convergence
    yields `Identifiable` — which licenses reading `Identifiable` as "computable real" simpliciter:
    the sped-up sequence `n ↦ f (m n)` is computable (`Computable.comp`) and hits precision `(1/2)^n`
    by the modulus. Independence of the modulus is the real content. -/
theorem identifiable_of_modulus (x : ℝ) (f : ℕ → ℚ) (m : ℕ → ℕ)
    (hf : Computable f) (hm : Computable m)
    (hconv : ∀ n k, m n ≤ k → |x - (f k : ℝ)| ≤ (1 / 2 : ℝ) ^ n) :
    Identifiable x :=
  ⟨fun n => f (m n), hf.comp hm, fun n => hconv n (m n) le_rfl⟩

end QLF.Identifiability
