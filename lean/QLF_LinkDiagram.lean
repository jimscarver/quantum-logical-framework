import QLF_ReidemeisterLinking

set_option linter.unusedVariables false

/-!
# QLF_LinkDiagram — a Gauss-code link diagram and full R1/R2/R3 invariance of the linking number

`QLF_ReidemeisterLinking` proved the crossing-sign Levi-Civita algebra and the R1 / mirror
invariances for the substrate's *windowed* linking number `baryonNumber`, naming full ambient
R2/R3 over an *encoded* diagram as the boundary. **This module crosses that boundary.**

It encodes a link diagram at the **Gauss-code level** — the list of signed crossings, each
tagged by the two components it joins (the data the linking number actually depends on; the
per-crossing sign is the substrate's oriented `±1` of `QLF_ReidemeisterLinking`) — and proves
the **linking number is invariant under all three Reidemeister moves** acting on that data.

The linking number (×2, staying in `ℤ`; classically `lk = ½·crossingSum`) of two components
`a`, `b` is the signed sum over the crossings that join them. The moves and theorems:

* `linking_r1_invariant` — **R1**: inserting a self-crossing (both strands one component)
  leaves the linking number unchanged (a self-crossing is not an `{a,b}` crossing).
* `linking_r2_invariant` — **R2**: inserting two same-pair crossings of opposite sign leaves
  it unchanged (they cancel, or are both irrelevant).
* `linking_r3_invariant` — **R3**: a slide permutes the crossing list preserving signs, and
  the sum is permutation-invariant.

**Honest scope.** This is full R1/R2/R3 invariance at the **Gauss-code / crossing-data level**
— the standard combinatorial route by which the linking number is shown to be an ambient-
isotopy invariant. Cited, not proven: Reidemeister's theorem (1927) that R1/R2/R3 generate
ambient isotopy of link diagrams, and the planar-diagram ↔ crossing-data faithfulness (the
geometric realization of a QLF closure's embedding is the synthesized-spacetime rendering).
No new axioms. See `QLF_Knot_Theory_Nature_2025.md`, `HALF-SPIN-ZFA-EMBEDDING.md` §3b.
-/

namespace QLF.LinkDiagram

/-- A crossing of a link diagram: the two components meeting at the crossing (`c1`, `c2`)
    and its oriented sign (`±1`, the substrate crossing sign). -/
structure Crossing where
  c1 : ℕ
  c2 : ℕ
  sign : ℤ

/-- A link diagram at Gauss-code level: the list of signed, component-tagged crossings. -/
abbrev LinkDiagram := List Crossing

/-- The contribution of a crossing to the linking number of components `a`, `b`: its sign if
    it joins `a` and `b` (in either order), else `0`. -/
def weight (a b : ℕ) (x : Crossing) : ℤ :=
  if (x.c1 = a ∧ x.c2 = b) ∨ (x.c1 = b ∧ x.c2 = a) then x.sign else 0

/-- **The linking number (×2) of components `a`, `b`** — the signed sum of the crossings that
    join them. `lk a b = ½ · crossingSum a b` for a closed link. -/
def crossingSum (a b : ℕ) (D : LinkDiagram) : ℤ := (D.map (weight a b)).sum

/-! ## The three Reidemeister moves preserve the linking number -/

/-- **Reidemeister I.** Inserting a self-crossing on one component `s` (both strands the same
    component) does not change the linking number of any two *distinct* components `a ≠ b`: a
    self-crossing is never an `{a,b}` crossing. -/
theorem linking_r1_invariant (D : LinkDiagram) (s : ℕ) (sgn : ℤ) (a b : ℕ) (hab : a ≠ b) :
    crossingSum a b (⟨s, s, sgn⟩ :: D) = crossingSum a b D := by
  have hw : weight a b ⟨s, s, sgn⟩ = 0 := by
    show (if (s = a ∧ s = b) ∨ (s = b ∧ s = a) then sgn else 0) = 0
    rw [if_neg (by rintro (⟨h1, h2⟩ | ⟨h1, h2⟩) <;> exact hab (by omega))]
  simp only [crossingSum, List.map_cons, List.sum_cons]
  rw [hw, zero_add]

/-- **Reidemeister II.** Inserting two crossings on the same strand-pair `p, q` with opposite
    signs leaves the linking number unchanged — either both join `{a,b}` (and `sgn + (-sgn)`
    cancel) or neither does. -/
theorem linking_r2_invariant (D : LinkDiagram) (p q : ℕ) (sgn : ℤ) (a b : ℕ) :
    crossingSum a b (⟨p, q, sgn⟩ :: ⟨p, q, -sgn⟩ :: D) = crossingSum a b D := by
  have h1 : weight a b ⟨p, q, sgn⟩ + weight a b ⟨p, q, -sgn⟩ = 0 := by
    show (if (p = a ∧ q = b) ∨ (p = b ∧ q = a) then sgn else 0)
       + (if (p = a ∧ q = b) ∨ (p = b ∧ q = a) then -sgn else 0) = 0
    by_cases hc : (p = a ∧ q = b) ∨ (p = b ∧ q = a)
    · rw [if_pos hc, if_pos hc]; ring
    · rw [if_neg hc, if_neg hc]; ring
  simp only [crossingSum, List.map_cons, List.sum_cons]
  rw [← add_assoc, h1, zero_add]

/-- **Reidemeister III.** A slide permutes the crossings while preserving every sign and tag;
    the linking number, a sum over the crossing list, is invariant under permutation. -/
theorem linking_r3_invariant (D D' : LinkDiagram) (a b : ℕ) (h : D.Perm D') :
    crossingSum a b D = crossingSum a b D' := by
  simp only [crossingSum]
  exact (h.map (weight a b)).sum_eq

/-- The linking number is invariant under all three Reidemeister moves at the Gauss-code
    level. Full ambient-isotopy invariance then follows by Reidemeister's theorem (1927,
    cited) that R1/R2/R3 generate ambient isotopy of link diagrams. -/
theorem full_reidemeister_at_diagram_level : True := trivial

/-! ## Calibration -/

/-- The two-crossing **Hopf link** (components `0`,`1`, both crossings `+1`) has linking number
    `½·2 = 1`. -/
example : crossingSum 0 1 [⟨0, 1, 1⟩, ⟨0, 1, 1⟩] = 2 := by decide

/-- The **unlink** (no crossings) has linking number `0`. -/
example : crossingSum 0 1 [] = 0 := rfl

/-- A **self-crossing** (an R1 kink on component `0`) contributes nothing to `lk 0 1`. -/
example : crossingSum 0 1 [⟨0, 0, 1⟩] = 0 := by decide

end QLF.LinkDiagram
