import QLF_BasisIndependence

set_option linter.unusedVariables false
set_option linter.unusedSectionVars false

/-!
# QLF_MultiObserver — a truth true from two or more perspectives, and in two ways

An **observer's frame** is a relabeling of the twist alphabet by the discrete symmetry group of
`QLF_BasisIndependence` — two axis transpositions, an axis reversal, the gauge swap (generating the
48 signed axis permutations × gauge swap). One observer's `^<v>` is another's, in relabeled letters:
*the same events, different names*. This module packages what `QLF_BasisIndependence` proves into the
explicit multi-observer statement, and states the "two ways" it holds.

## True from every perspective

* **`closure_verdict_frame_independent`** — for any frame `p`, `countBalanced (p.reframe ts) ↔
  countBalanced ts`. Whether a history is a **ZFA closure** does not depend on the frame it is read
  in. (`count_balanced_pauli_closed`: on twist strings this *is* full ZFA — count balance entails
  Pauli closure — not merely count balance.)
* **`phase_frame_independent`** — for any frame `p` and any closure, `twistMatrixFold (p.reframe ts)
  = twistMatrixFold ts`. The **phase** a closure carries is the same in every frame.
* **`observers_agree`** — hence for *any two* observers `p₁`, `p₂`: they agree on whether a history
  closes, and — when it does — on its phase. Truth is what closes ([`QucalcSearch.md`](../QucalcSearch.md):
  `/solve` is the truth divination), and this shows that truth is **objective** — the same from every
  perspective, not something the observer contributes to. The frame is notation; the closure is not.

## True in two ways

The agreement is established by **two independent routes**:

* the **count route** — `countBalanced`, a statement about twist *multiplicities* (`#^ = #v`, …),
  invariant because a relabeling permutes the letters;
* the **Pauli route** — `twistMatrixFold`, a statement about the 2×2 *matrix product*, invariant
  because the phase rule's sign and inversion corrections cancel on balanced words
  (`QLF_BasisIndependence`).

`count_balanced_pauli_closed` shows the first *entails* the second in general, so the two routes are
**consistent, not redundant** — the "converging independent derivations are multiplicity, not
repetition" pattern ([`Philosophy.md`](../Philosophy.md) §3a rule 5).
`truth_from_two_perspectives_in_two_ways` carries the closure verdict all the way to the μ₄ scalar and
shows both observers land on the same one.

No new axioms — a repackaging of `QLF_BasisIndependence` + `count_balanced_pauli_closed`.
-/

namespace QLF.MultiObserver

open QLF QLF.BasisIndependence

/-- An observer's frame: a word over the four generating relabelings (`xy`/`yz` axis transpositions,
    `fx` axis reversal, `g` gauge swap). Composition of frames is composition of `Perspective`s. -/
inductive Perspective
  | id : Perspective
  | xy : Perspective → Perspective
  | yz : Perspective → Perspective
  | fx : Perspective → Perspective
  | g  : Perspective → Perspective

/-- Read a history in a given observer's labels — *the same events*, relabeled. -/
def Perspective.reframe : Perspective → List Twist → List Twist
  | .id,   ts => ts
  | .xy p, ts => (p.reframe ts).map swapXY
  | .yz p, ts => (p.reframe ts).map swapYZ
  | .fx p, ts => (p.reframe ts).map flipX
  | .g  p, ts => (p.reframe ts).map swapGauge

/-- Each generating relabeling is an involution on histories (the group acts by *permutation*). -/
private theorem map_map_involutive {f : Twist → Twist} (hf : ∀ t, f (f t) = t) (ts : List Twist) :
    (ts.map f).map f = ts := by
  induction ts with
  | nil => rfl
  | cons t ts ih => simp [List.map_cons, hf t, ih]

private theorem cb_iff_swapXY (ts : List Twist) :
    countBalanced (ts.map swapXY) ↔ countBalanced ts :=
  ⟨fun h => by
    have h2 := countBalanced_map_swapXY h
    rwa [map_map_involutive swapXY_involutive ts] at h2, countBalanced_map_swapXY⟩

private theorem cb_iff_swapYZ (ts : List Twist) :
    countBalanced (ts.map swapYZ) ↔ countBalanced ts :=
  ⟨fun h => by
    have h2 := countBalanced_map_swapYZ h
    rwa [map_map_involutive swapYZ_involutive ts] at h2, countBalanced_map_swapYZ⟩

private theorem cb_iff_flipX (ts : List Twist) :
    countBalanced (ts.map flipX) ↔ countBalanced ts :=
  ⟨fun h => by
    have h2 := countBalanced_map_flipX h
    rwa [map_map_involutive flipX_involutive ts] at h2, countBalanced_map_flipX⟩

private theorem cb_iff_swapGauge (ts : List Twist) :
    countBalanced (ts.map swapGauge) ↔ countBalanced ts :=
  ⟨fun h => by
    have h2 := countBalanced_map_swapGauge h
    rwa [map_map_involutive swapGauge_involutive ts] at h2, countBalanced_map_swapGauge⟩

/-- **The closure verdict is frame-independent.** A history is a ZFA closure in one observer's frame
    iff it is a closure in every observer's frame. -/
theorem closure_verdict_frame_independent (p : Perspective) (ts : List Twist) :
    countBalanced (p.reframe ts) ↔ countBalanced ts := by
  induction p with
  | id => exact Iff.rfl
  | xy p ih => simp only [Perspective.reframe]; exact (cb_iff_swapXY (p.reframe ts)).trans ih
  | yz p ih => simp only [Perspective.reframe]; exact (cb_iff_swapYZ (p.reframe ts)).trans ih
  | fx p ih => simp only [Perspective.reframe]; exact (cb_iff_flipX (p.reframe ts)).trans ih
  | g  p ih => simp only [Perspective.reframe]; exact (cb_iff_swapGauge (p.reframe ts)).trans ih

/-- **The phase is frame-independent.** Every observer reads the same Pauli fold off a closure. -/
theorem phase_frame_independent (p : Perspective) {ts : List Twist} (h : countBalanced ts) :
    twistMatrixFold (p.reframe ts) = twistMatrixFold ts := by
  induction p with
  | id => rfl
  | xy p ih =>
      have hb : countBalanced (p.reframe ts) := (closure_verdict_frame_independent p ts).mpr h
      simp only [Perspective.reframe]
      rw [fold_invariant_swapXY hb]; exact ih
  | yz p ih =>
      have hb : countBalanced (p.reframe ts) := (closure_verdict_frame_independent p ts).mpr h
      simp only [Perspective.reframe]
      rw [fold_invariant_swapYZ hb]; exact ih
  | fx p ih =>
      have hb : countBalanced (p.reframe ts) := (closure_verdict_frame_independent p ts).mpr h
      simp only [Perspective.reframe]
      rw [fold_invariant_flipX hb]; exact ih
  | g  p ih =>
      have hb : countBalanced (p.reframe ts) := (closure_verdict_frame_independent p ts).mpr h
      simp only [Perspective.reframe]
      rw [fold_invariant_swapGauge hb]; exact ih

/-- **Two observers agree.** For *any two* frames `p₁`, `p₂` and any history: they agree on whether it
    closes, and — when it does — on the phase it carries. -/
theorem observers_agree (p₁ p₂ : Perspective) (ts : List Twist) :
    (countBalanced (p₁.reframe ts) ↔ countBalanced (p₂.reframe ts)) ∧
      (countBalanced ts →
        twistMatrixFold (p₁.reframe ts) = twistMatrixFold (p₂.reframe ts)) := by
  refine ⟨(closure_verdict_frame_independent p₁ ts).trans
            (closure_verdict_frame_independent p₂ ts).symm, fun h => ?_⟩
  rw [phase_frame_independent p₁ h, phase_frame_independent p₂ h]

/-- **The full statement.** Two observers reading a closure agree on it by *two* independent
    invariants: the count verdict (`countBalanced`) and the Pauli scalar (`twistMatrixFold`), and
    both land on the *same* μ₄ scalar. -/
theorem truth_from_two_perspectives_in_two_ways
    (p₁ p₂ : Perspective) {ts : List Twist} (h : countBalanced ts) :
    countBalanced (p₁.reframe ts) ∧ countBalanced (p₂.reframe ts) ∧
      twistMatrixFold (p₁.reframe ts) = twistMatrixFold (p₂.reframe ts) ∧
      ∃ q : PauliScalar,
        twistMatrixFold (p₁.reframe ts) = pauliScalarToMatrix q ∧
        twistMatrixFold (p₂.reframe ts) = pauliScalarToMatrix q := by
  have h1 : countBalanced (p₁.reframe ts) := (closure_verdict_frame_independent p₁ ts).mpr h
  have h2 : countBalanced (p₂.reframe ts) := (closure_verdict_frame_independent p₂ ts).mpr h
  obtain ⟨q, hq⟩ := count_balanced_pauli_closed h
  exact ⟨h1, h2, (observers_agree p₁ p₂ ts).2 h,
    q, by rw [phase_frame_independent p₁ h, hq], by rw [phase_frame_independent p₂ h, hq]⟩

/-- Non-vacuity: the `^<v>` plaquette, two genuinely different observers (identity vs. `X↔Y` then
    gauge swap), agreement checked. -/
example :
    countBalanced ((Perspective.id).reframe
        [Twist.up, Twist.left, Twist.down, Twist.right]) ↔
    countBalanced ((Perspective.xy (Perspective.g Perspective.id)).reframe
        [Twist.up, Twist.left, Twist.down, Twist.right]) :=
  (observers_agree Perspective.id (Perspective.xy (Perspective.g Perspective.id))
    [Twist.up, Twist.left, Twist.down, Twist.right]).1

/-- **Summary.** `closure_verdict_frame_independent` + `phase_frame_independent` ⟹ `observers_agree`:
    the ZFA closure verdict and the phase of a closure are the same for every observer in the discrete
    frame group, so two or more perspectives agree on the truth — witnessed **two ways** (the count
    route and the Pauli route, `truth_from_two_perspectives_in_two_ways`). No new axioms; a
    repackaging of `QLF_BasisIndependence`. -/
theorem multi_observer_summary : True := trivial

end QLF.MultiObserver
