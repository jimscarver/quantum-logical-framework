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
  Set.Icc.infinite h

end QLF.Identifiability
