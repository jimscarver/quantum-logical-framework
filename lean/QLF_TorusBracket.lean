import QLF_KauffmanBracket

set_option linter.unusedVariables false

/-!
# QLF_TorusBracket — a concrete planar loop-count: bracket computes named knots

`QLF_KauffmanBracket` built the bracket as a firebreak state-sum with an *abstract* loop-count
`loops : List Bool → ℕ`. This module supplies a **concrete, computed** loop-count for the
family of **2-strand torus links** `T(2,n)` — the closures of the braid `σ₁ⁿ` — via the
**Temperley–Lieb** planar calculus, so `bracket` computes the actual Kauffman bracket `⟨L⟩`
of *named* knots/links: the unknot `T(2,1)`, the Hopf link `T(2,2)`, the trefoil `T(2,3)`.

**The planar loop-count (`torusLoops`).** A smoothing state is a bit per crossing: `true` =
the `A`-smoothing (the TL identity `1`), `false` = the `A⁻¹`-smoothing (the cup-cap `e`). On
two strands the TL diagram is one of `{1, e}` (a `Bool`), composition is `tlMul`
(`e·e = e` produces one closed loop, else none), and the number of loops of the *closed*
diagram is the loops formed in composition plus the Markov-closure loops (`1↦2`, `e↦1`). This
is a genuine planar computation, not an assertion — `torusLoops` runs it.

**Computed named-knot brackets** (over a field, `A ≠ 0`, so `Ai = A⁻¹`):
* `bracket_unknot_kink` — `T(2,1)` (a kinked unknot): `⟨L⟩ = −A³` (regular-isotopy value, *not*
  `1` — the R1 writhe factor, as it must be).
* `bracket_hopf` — the **Hopf link** `T(2,2)`: `⟨L⟩ = −A⁴ − A⁻⁴`.
* `bracket_trefoil` — the **trefoil** `T(2,3)`: `⟨L⟩ = −A⁵ − A⁻³ + A⁻⁷`.

All three match the literature Kauffman brackets. **Honest scope.** The TL loop-count is a
genuine planar computation for the 2-strand torus-link family; a *general* planar diagram
(arbitrary knot) needs the full 4-valent-graph / rotation-system model — the forward step. No
new axioms. See `Knot_Theory_QLF.md` §4.
-/

namespace QLF.TorusBracket

open QLF.KauffmanBracket

/-- Compose a TL generator `g` (as a `Bool`: `true`=`1`, `false`=`e`) onto an accumulated
    2-strand TL diagram `d`: the product `1/e` closes under `AND`, and `e·e` forms one loop. -/
def tlReduce : List Bool → Bool × ℕ
  | [] => (true, 0)
  | g :: rest =>
      (g && (tlReduce rest).1,
       (tlReduce rest).2 + (if !g && !(tlReduce rest).1 then 1 else 0))

/-- **The concrete planar loop-count of the `T(2,n)` smoothing state `s`**: loops formed under
    TL composition, plus the Markov-closure loops (identity `1 ↦ 2`, cup-cap `e ↦ 1`). -/
def torusLoops (s : List Bool) : ℕ :=
  (tlReduce s).2 + (if (tlReduce s).1 then 2 else 1)

-- ==== loop counts of the small states (computed) ====
theorem tl_t : torusLoops [true] = 2 := by decide
theorem tl_f : torusLoops [false] = 1 := by decide
theorem tl_tt : torusLoops [true, true] = 2 := by decide
theorem tl_tf : torusLoops [true, false] = 1 := by decide
theorem tl_ft : torusLoops [false, true] = 1 := by decide
theorem tl_ff : torusLoops [false, false] = 2 := by decide
theorem tl_ttt : torusLoops [true, true, true] = 2 := by decide
theorem tl_ttf : torusLoops [true, true, false] = 1 := by decide
theorem tl_tft : torusLoops [true, false, true] = 1 := by decide
theorem tl_ftt : torusLoops [false, true, true] = 1 := by decide
theorem tl_tff : torusLoops [true, false, false] = 2 := by decide
theorem tl_ftf : torusLoops [false, true, false] = 2 := by decide
theorem tl_fft : torusLoops [false, false, true] = 2 := by decide
theorem tl_fff : torusLoops [false, false, false] = 3 := by decide

/-- **`T(2,1)` — a kinked unknot — has bracket `−A³`** (the regular-isotopy R1 value, not `1`). -/
theorem bracket_unknot_kink {K : Type*} [Field K] (A : K) (hA : A ≠ 0) :
    bracket A A⁻¹ 1 torusLoops = -A ^ 3 := by
  simp only [bracket, resolutions, List.map_cons, List.map_nil, List.nil_append, List.cons_append,
    List.sum_cons, List.sum_nil, add_zero, weight, mono, kauffmanDelta,
    tl_t, tl_f]
  norm_num [List.count_cons, List.count_nil]
  field_simp
  ring

/-- **The Hopf link `T(2,2)` has bracket `−A⁴ − A⁻⁴`.** -/
theorem bracket_hopf {K : Type*} [Field K] (A : K) (hA : A ≠ 0) :
    bracket A A⁻¹ 2 torusLoops = -A ^ 4 - (A⁻¹) ^ 4 := by
  simp only [bracket, resolutions, List.map_cons, List.map_nil, List.nil_append, List.cons_append,
    List.sum_cons, List.sum_nil, add_zero, weight, mono, kauffmanDelta,
    tl_tt, tl_tf, tl_ft, tl_ff]
  norm_num [List.count_cons, List.count_nil]
  field_simp
  ring

/-- **The trefoil `T(2,3)` has bracket `−A⁵ − A⁻³ + A⁻⁷`.** -/
theorem bracket_trefoil {K : Type*} [Field K] (A : K) (hA : A ≠ 0) :
    bracket A A⁻¹ 3 torusLoops = -A ^ 5 - (A⁻¹) ^ 3 + (A⁻¹) ^ 7 := by
  simp only [bracket, resolutions, List.map_cons, List.map_nil, List.nil_append, List.cons_append,
    List.sum_cons, List.sum_nil, add_zero, weight, mono, kauffmanDelta,
    tl_ttt, tl_ttf, tl_tft, tl_ftt, tl_tff, tl_ftf, tl_fft, tl_fff]
  norm_num [List.count_cons, List.count_nil]
  field_simp
  ring

/-- Status: the concrete Temperley–Lieb loop-count makes `bracket` compute the Kauffman bracket
    of named 2-strand torus links (unknot, Hopf, trefoil). General planar diagrams (arbitrary
    knots) need the full rotation-system model — the forward step. -/
theorem torus_bracket_computes_named_knots : True := trivial

end QLF.TorusBracket
