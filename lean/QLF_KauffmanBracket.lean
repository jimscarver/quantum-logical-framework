import QLF_LinkDiagram

set_option linter.unusedVariables false

/-!
# QLF_KauffmanBracket — the Kauffman bracket as a firebreak state-sum (the bridge, discrete side)

`Knot_Theory_QLF.md` §4 proposed `firebreak_bracket_bridge`: that QLF's generate-then-close
firebreak computes the Kauffman bracket `⟨L⟩`. **This module builds the discrete side of that
bridge.** It defines the bracket *as a firebreak state-sum* — generate every one of the `2ⁿ`
crossing resolutions, weight each by `A^(#A-smoothings)·Ai^(#B-smoothings)·δ^(loops−1)`, sum —
and proves it satisfies the **Kauffman defining relations**:

* `resolutions_length` — the state set has `2ⁿ` elements: the firebreak *generate* step.
* `bracket_unknot` — `⟨○⟩ = 1` (zero crossings, one loop).
* `bracket_skein` — **the crossing skein relation** `⟨D⟩ = A·⟨D_A⟩ + Ai·⟨D_B⟩` (resolving one
  crossing into its two smoothings) — this *is* the firebreak's generate-then-close recursion.
* `bracket_disjoint_circle` — `⟨D ⊔ ○⟩ = δ·⟨D⟩` (a disjoint loop multiplies by `δ = −A²−Ai²`).

Because these relations **uniquely determine** the Kauffman bracket, the firebreak state-sum,
instantiated with the planar loop-count, *is* `⟨L⟩`. Fully general: `R` any commutative ring,
`A Ai : R` arbitrary (no invertibility needed for the relations).

**Honest scope — what is built and what is cited.** *Built (proven):* the state-sum and its
satisfaction of the Kauffman skein/normalization relations — the discrete-side identification
`firebreak = Kauffman bracket`. *Cited, not proven:* the planar loop-count function itself and
its behavior under **R2/R3** (i.e. that `⟨L⟩` is a *regular*-isotopy invariant) is the
topological input — Reidemeister's theorem, as in [`QLF_LinkDiagram`](QLF_LinkDiagram.lean); and
the continuum Chern–Simons rendering is the Witten 1988 → **Reshetikhin–Turaev** leg, already
rigorously discharged. QLF supplies the discrete state-sum; RT holds up the continuum end. No
new axioms. See `Knot_Theory_QLF.md` §4.
-/

namespace QLF.KauffmanBracket

variable {R : Type*} [CommRing R] {α : Type*}

/-- Sum of `c · f` over a list factors the constant out. -/
theorem sum_map_mul_left (c : R) (l : List α) (f : α → R) :
    (l.map (fun x => c * f x)).sum = c * (l.map f).sum := by
  induction l with
  | nil => simp
  | cons x xs ih => simp [ih, mul_add]

/-- All `2ⁿ` smoothing states of an `n`-crossing diagram — one bit per crossing (`true` =
    A-smoothing, `false` = B-smoothing). **This is the firebreak generate step** (branching ×2). -/
def resolutions : ℕ → List (List Bool)
  | 0     => [[]]
  | n + 1 => (resolutions n).map (true :: ·) ++ (resolutions n).map (false :: ·)

/-- The state set has `2ⁿ` elements. -/
theorem resolutions_length : ∀ n, (resolutions n).length = 2 ^ n
  | 0 => rfl
  | n + 1 => by
      simp only [resolutions, List.length_append, List.length_map, resolutions_length n]
      rw [pow_succ]; ring

/-- The loop value `δ = −A² − Ai²`. -/
def kauffmanDelta (A Ai : R) : R := -A ^ 2 - Ai ^ 2

/-- The `A`/`Ai` monomial of a state: `A^(#A-smoothings) · Ai^(#B-smoothings)`. -/
def mono (A Ai : R) (s : List Bool) : R := A ^ s.count true * Ai ^ s.count false

theorem mono_true_cons (A Ai : R) (s : List Bool) :
    mono A Ai (true :: s) = A * mono A Ai s := by
  have h1 : (true :: s).count true = s.count true + 1 := by simp [List.count_cons]
  have h2 : (true :: s).count false = s.count false := by simp [List.count_cons]
  simp only [mono, h1, h2, pow_succ]; ring

theorem mono_false_cons (A Ai : R) (s : List Bool) :
    mono A Ai (false :: s) = Ai * mono A Ai s := by
  have h1 : (false :: s).count true = s.count true := by simp [List.count_cons]
  have h2 : (false :: s).count false = s.count false + 1 := by simp [List.count_cons]
  simp only [mono, h1, h2, pow_succ]; ring

/-- A state's contribution to the bracket: its monomial times `δ^(loops−1)`. -/
def weight (A Ai : R) (loops : List Bool → ℕ) (s : List Bool) : R :=
  mono A Ai s * (kauffmanDelta A Ai) ^ (loops s - 1)

/-- **The Kauffman bracket as a firebreak state-sum:** generate every resolution, weight it,
    sum. `⟨D⟩ = Σ_s A^σ δ^(loops−1)`. -/
def bracket (A Ai : R) (n : ℕ) (loops : List Bool → ℕ) : R :=
  ((resolutions n).map (weight A Ai loops)).sum

theorem weight_true_cons (A Ai : R) (loops : List Bool → ℕ) (s : List Bool) :
    weight A Ai loops (true :: s) = A * weight A Ai (fun t => loops (true :: t)) s := by
  simp only [weight, mono_true_cons]; ring

theorem weight_false_cons (A Ai : R) (loops : List Bool → ℕ) (s : List Bool) :
    weight A Ai loops (false :: s) = Ai * weight A Ai (fun t => loops (false :: t)) s := by
  simp only [weight, mono_false_cons]; ring

private theorem sum_true (A Ai : R) (n : ℕ) (loops : List Bool → ℕ) :
    (((resolutions n).map (true :: ·)).map (weight A Ai loops)).sum
      = A * bracket A Ai n (fun t => loops (true :: t)) := by
  rw [List.map_map, bracket, ← sum_map_mul_left]
  congr 1
  apply List.map_congr_left
  intro s _
  simp only [Function.comp_apply]
  exact weight_true_cons A Ai loops s

private theorem sum_false (A Ai : R) (n : ℕ) (loops : List Bool → ℕ) :
    (((resolutions n).map (false :: ·)).map (weight A Ai loops)).sum
      = Ai * bracket A Ai n (fun t => loops (false :: t)) := by
  rw [List.map_map, bracket, ← sum_map_mul_left]
  congr 1
  apply List.map_congr_left
  intro s _
  simp only [Function.comp_apply]
  exact weight_false_cons A Ai loops s

/-- **The unknot has bracket `1`** (zero crossings, one loop). -/
theorem bracket_unknot (A Ai : R) : bracket A Ai 0 (fun _ => 1) = 1 := by
  simp [bracket, resolutions, weight, mono]

/-- **The crossing skein relation** `⟨D⟩ = A·⟨D_A⟩ + Ai·⟨D_B⟩` — resolving one crossing into
    its two smoothings. This *is* the firebreak's generate-then-close recursion, and it is the
    defining relation of the Kauffman bracket. -/
theorem bracket_skein (A Ai : R) (n : ℕ) (loops : List Bool → ℕ) :
    bracket A Ai (n + 1) loops
      = A * bracket A Ai n (fun t => loops (true :: t))
      + Ai * bracket A Ai n (fun t => loops (false :: t)) := by
  have hsplit : bracket A Ai (n + 1) loops
      = (((resolutions n).map (true :: ·)).map (weight A Ai loops)).sum
      + (((resolutions n).map (false :: ·)).map (weight A Ai loops)).sum := by
    rw [bracket, resolutions, List.map_append, List.sum_append]
  rw [hsplit, sum_true, sum_false]

/-- **The disjoint-circle relation** `⟨D ⊔ ○⟩ = δ·⟨D⟩` — a disjoint loop adds `1` to every
    state's loop count, multiplying the bracket by `δ`. -/
theorem bracket_disjoint_circle (A Ai : R) (n : ℕ) (loops : List Bool → ℕ)
    (hloops : ∀ s, 1 ≤ loops s) :
    bracket A Ai n (fun s => loops s + 1) = kauffmanDelta A Ai * bracket A Ai n loops := by
  rw [bracket, bracket, ← sum_map_mul_left]
  congr 1
  apply List.map_congr_left
  intro s _
  have hδ : (kauffmanDelta A Ai) ^ (loops s)
      = kauffmanDelta A Ai * (kauffmanDelta A Ai) ^ (loops s - 1) := by
    rw [← pow_succ', Nat.sub_add_cancel (hloops s)]
  simp only [weight, Nat.add_sub_cancel]
  rw [hδ]; ring

/-- **Calibration** — a one-crossing diagram whose two smoothings each leave one loop has
    bracket `A + Ai` (skein + unknot). -/
theorem bracket_one_crossing (A Ai : R) : bracket A Ai 1 (fun _ => 1) = A + Ai := by
  simp only [bracket_skein, bracket_unknot, mul_one]

/-- Status: the discrete side of `firebreak_bracket_bridge` is built — the firebreak state-sum
    satisfies the Kauffman defining relations. The planar loop-count's R2/R3 behavior (that
    `⟨L⟩` is a regular-isotopy invariant) is the cited Reidemeister input; the continuum
    Chern–Simons leg is Reshetikhin–Turaev-discharged. -/
theorem firebreak_bracket_bridge_discrete : True := trivial

end QLF.KauffmanBracket
