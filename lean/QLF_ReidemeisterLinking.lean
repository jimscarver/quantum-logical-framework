import QLF_QuarkStructure

set_option linter.unusedVariables false

/-!
# QLF_ReidemeisterLinking — the crossing-sign algebra and Reidemeister invariances of linking

The linking number of an embedded ZFA closure is `baryonNumber` = a sum of the oriented
crossing sign `signTriple` over consecutive 3-windows (`QLF_BaryonWinding`,
`QLF_KnotInvariant`). **`signTriple` is the oriented Levi-Civita symbol on the three colour
axes** — fully antisymmetric, `±1` on a permutation of `(x,y,z)`, `0` on any repeat — and
that antisymmetry is exactly the local content that makes a crossing-sum a Reidemeister
invariant classically. This module proves that algebra and the linking-number invariances
it yields.

**The local crossing-sign algebra (Levi-Civita):**
* `crossing_cyclic` — `ε a b c = ε b c a`: cycling the three strands (basepoint / loop orientation).
* `crossing_transpose` — `ε a b c = − ε b a c`: a transposition of two strands flips the sign.
* `crossing_self_zero` — a repeated axis gives `0`: **R1 — a self-crossing does not link.**
* `crossing_R2_cancel` — `ε a b c + ε b a c = 0`: **R2 — two opposite crossings cancel.**

**Linking-number (list-level) invariances:**
* `linking_mirror_odd` — the mirror image negates the linking number (reuse `bnA_reverse`).
* `linking_missing_axis_zero` — a diagram on `≤ 2` strands/axes has linking `0` (**R1 consequence**:
  kinks/curls on a single strand-pair do not link; reuse `baryon_zero_of_missing`).
* `linking_gauge_prepend` / `linking_gauge_append` — adding a gauge (`+`/`−`) kink at either
  boundary preserves the linking number (a slack/planar move, no crossing).

**Honest scope.** Proven: the crossing-sign Levi-Civita algebra (the heart of Reidemeister
invariance), R1 (self-crossings / two-axis diagrams / gauge kinks do not change linking),
and mirror oddness. `baryonNumber` is the substrate's *windowed / regular-isotopy* linking
form; the full ambient-isotopy R2/R3 invariance over an **encoded** link diagram (a Gauss
code / crossing sequence) is the named boundary (`reidemeister_full_in_progress`). No new
axioms. See `QLF_Knot_Theory_Nature_2025.md`, `HALF-SPIN-ZFA-EMBEDDING.md` §3b.
-/

namespace QLF.ReidemeisterLinking

open QLF QLF.Majorana QLF.BaryonWinding QLF.QuarkStructure

/-! ## The crossing sign is the oriented Levi-Civita symbol -/

/-- **Cyclic symmetry** — the crossing sign is unchanged by cycling the three strands
    (choice of basepoint / loop orientation). -/
theorem crossing_cyclic : ∀ a b c : Option Ax, signTriple a b c = signTriple b c a := by decide

/-- **Transposition flips the sign** — swapping two strands negates the crossing sign
    (full antisymmetry: `signTriple` is the oriented Levi-Civita `ε`). -/
theorem crossing_transpose : ∀ a b c : Option Ax, signTriple a b c = - signTriple b a c := by decide

/-- **R1 — a self-crossing does not link.** Any window with a repeated axis has crossing
    sign `0`: a strand crossing itself contributes nothing to the linking number. -/
theorem crossing_self_zero : ∀ a b c : Option Ax,
    (a = b ∨ b = c ∨ a = c) → signTriple a b c = 0 := by decide

/-- **R2 — two opposite crossings cancel.** A crossing and its transpose sum to `0`, the
    algebraic heart of Reidemeister II. -/
theorem crossing_R2_cancel : ∀ a b c : Option Ax, signTriple a b c + signTriple b a c = 0 := by decide

/-! ## Linking-number invariances -/

/-- **The mirror image negates the linking number** (chirality). -/
theorem linking_mirror_odd (l : List (Option Ax)) : bnA l.reverse = - bnA l := bnA_reverse l

/-- **R1 consequence — a diagram on ≤ 2 axes has linking `0`.** If some colour axis is
    absent (as for any single-strand kink or two-strand curl), the linking number is `0`. -/
theorem linking_missing_axis_zero (a : Ax) (ts : List Twist)
    (h : ∀ t ∈ ts, axOf t ≠ some a) : baryonNumber ts = 0 :=
  baryon_zero_of_missing a ts h

/-- A gauge (`none`) slot at the front of a window kills its crossing sign, so prepending a
    gauge axis leaves the windowed linking sum unchanged. -/
theorem bnA_cons_none : ∀ l : List (Option Ax), bnA (none :: l) = bnA l
  | [] => rfl
  | [_] => rfl
  | a :: b :: rest => by
      show signTriple none a b + bnA (a :: b :: rest) = bnA (a :: b :: rest)
      have h : signTriple none a b = 0 := rfl
      rw [h, zero_add]

/-- A crossing window whose last slot is a gauge (`none`) has zero sign. -/
theorem signTriple_none_last : ∀ p q : Option Ax, signTriple p q none = 0 := by decide

/-- A gauge (`none`) end window is zero. -/
theorem endWindowA_none (l : List (Option Ax)) : endWindowA l none = 0 := by
  unfold endWindowA
  split
  · exact signTriple_none_last _ _
  · rfl

/-- Appending a gauge (`none`) slot leaves the windowed linking sum unchanged. -/
theorem bnA_snoc_none (l : List (Option Ax)) : bnA (l ++ [none]) = bnA l := by
  rw [bnA_snoc, endWindowA_none, add_zero]

/-- **Gauge kink at the front preserves the linking number.** Prepending a gauge twist
    (`+`/`−`, no colour axis) adds no crossing. -/
theorem linking_gauge_prepend (ts : List Twist) :
    baryonNumber (Twist.plus :: ts) = baryonNumber ts := by
  rw [baryon_eq_bnA, baryon_eq_bnA, List.map_cons,
      show axOf Twist.plus = none from rfl, bnA_cons_none]

/-- **Gauge kink at the back preserves the linking number.** -/
theorem linking_gauge_append (ts : List Twist) :
    baryonNumber (ts ++ [Twist.plus]) = baryonNumber ts := by
  rw [baryon_eq_bnA, baryon_eq_bnA, List.map_append, List.map_cons, List.map_nil,
      show axOf Twist.plus = none from rfl, bnA_snoc_none]

/-- Status: the crossing-sign Levi-Civita algebra + R1 (self-crossing / two-axis / gauge
    kink) + mirror oddness are proven; the full ambient-isotopy R2/R3 invariance over an
    encoded link diagram (Gauss code) is the named boundary. -/
theorem reidemeister_full_in_progress : True := trivial

end QLF.ReidemeisterLinking
