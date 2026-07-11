import Mathlib

/-!
# QLF_EntropyUniqueness — the closure measure is *forced*, not chosen (item 6, the easy wing)

The information-theoretic wing of the reconstruction program ([`Completeness_Evidence.md`](../Completeness_Evidence.md)
§6): the admissibility structure admits a **unique** consistent information measure. This module
proves the **finite / additive** wing — the one that avoids Gleason's analytic difficulty — in the
Baez–Fritz–Leinster / Knuth spirit ("structure forces the measure").

A *consistent information measure* is a real-valued `H` on histories that is **additive on
independent ledgers**: `H (a ++ b) = H a + H b` (the content of two independent closures is the sum
of their contents). Given that single axiom:

* **`additive_nil`** — the empty history carries `H [] = 0` (forced, not stipulated).
* **`additive_uniform_eq_length_mul`** — with a single anchor `H [x] = c` on the generator, the
  measure is **forced to be linear in the closure count**: `H s = |s| · c`. Counting is not a
  modelling choice; additivity + one anchor determines it. With the substrate anchor `c = log 2`
  (the free-energy quantum, `QLF_FreeEnergy`) this *is* Shannon counting on the census.
* **`additive_unique`** — any two additive measures agreeing on the generators agree everywhere:
  the consistent measure is **unique**.

**Honest scope.** This is the *counting* uniqueness (additivity forces the census measure on the
uniform ensemble) — the discrete shadow of the Faddeev / Baez–Fritz–Leinster theorem, deliberately
avoiding Gleason-style analysis. The full distributional uniqueness (the `−Σ p log p` form, forced by
the Cauchy functional equation over arbitrary probability weights) is the analytic residual, tracked
in issue #115. No axioms.
-/

namespace QLF.EntropyUniqueness

variable {α : Type*}

/-- A **consistent information measure**: additive on independent ledgers (concatenation). -/
def IsAdditive (H : List α → ℝ) : Prop := ∀ a b, H (a ++ b) = H a + H b

/-- **The empty history carries zero** — forced by additivity (`H [] = H [] + H []`). -/
theorem additive_nil (H : List α → ℝ) (hadd : IsAdditive H) : H [] = 0 := by
  have h := hadd [] []
  simp only [List.nil_append] at h
  linarith

/-- **The measure is forced to be linear in the closure count.** An additive measure anchored by
    a single value on the generator (`H [x] = c` for all `x`) satisfies `H s = |s| · c` — counting
    is determined, not chosen. -/
theorem additive_uniform_eq_length_mul (H : List α → ℝ) (c : ℝ)
    (hadd : IsAdditive H) (hgen : ∀ x, H [x] = c) :
    ∀ s : List α, H s = s.length * c := by
  intro s
  induction s with
  | nil => simp [additive_nil H hadd]
  | cons x xs ih =>
    have hstep : H (x :: xs) = H [x] + H xs := hadd [x] xs
    rw [hstep, hgen, ih, List.length_cons]
    push_cast
    ring

/-- **Uniqueness.** Two consistent (additive) measures that agree on the generators agree on every
    history: the consistent information measure is unique. -/
theorem additive_unique (H₁ H₂ : List α → ℝ)
    (h1 : IsAdditive H₁) (h2 : IsAdditive H₂) (hgen : ∀ x, H₁ [x] = H₂ [x]) :
    ∀ s : List α, H₁ s = H₂ s := by
  intro s
  induction s with
  | nil => rw [additive_nil H₁ h1, additive_nil H₂ h2]
  | cons x xs ih =>
    have e1 : H₁ (x :: xs) = H₁ [x] + H₁ xs := h1 [x] xs
    have e2 : H₂ (x :: xs) = H₂ [x] + H₂ xs := h2 [x] xs
    rw [e1, e2, hgen, ih]

/-- Summary: additivity forces `H [] = 0` and `H s = |s| · c`, and pins the measure uniquely from
    its value on the generator — the finite/counting wing of "the structure forces the measure",
    with `c = log 2` the physical anchor. The full distributional `−Σ p log p` uniqueness is the
    analytic residual (issue #115). -/
theorem entropy_uniqueness_summary : True := trivial

end QLF.EntropyUniqueness
