import Mathlib

set_option linter.unusedVariables false

/-!
# QLF_Consciousness — the frequency-hierarchy of resonant closures (structural skeleton)

A QLF model of consciousness: self-awareness is a Markov blanket modeling **self, environment, and
their interaction** ([`TheBigProblem.md`](../TheBigProblem.md)), realized as a hierarchy of ZFA
closures at **different frequencies**, with conscious thought being whatever closure the agent is
**resonantly tuned to** at a given moment. Each closure is a local clock of period `R` (its
`local_clock_period`, [`QLF_LocalClock`](QLF_LocalClock.lean)), so its closure frequency is `f = 1/R`
([`Philosophy.md`](../Philosophy.md) §2, "independent quantum logical systems at each clock
frequency").

This module is the **structural skeleton** of that model — frequency = inverse period, conscious
content = the highest-frequency available closure, binding raises frequency, and quieting the internal
closures shifts consciousness to a low-frequency external channel. It is **not** a theorem of
consciousness or qualia; the hard problem stays bracketed (see `Consciousness.md`, honest scope).

* **`freq R = 1/R`** with **`freq_lt_of_lt`** — a *shorter* period is a *higher* frequency.
* **Binding raises frequency (the graduation).** A higher closure that binds two phase-locked
  sub-closures into a closure-of-closures (the disjunctive OR-fold of `QLF_InfoSynthesis`) closes at the
  **faster** of the two (`bind = min`), so its frequency is **at least each constituent's**
  (`freq_bind_ge_left` / `freq_bind_ge_right`): integration shows up as a higher closure rate (the
  gamma-band / global-workspace "ignition" reading).
* **Conscious content = the highest-frequency available closure** — here the faster of the dominant
  internal closure and the dominant external *joint* closure (`consciousPeriod = min`). Waking:
  internal is fastest, so internal is conscious (`conscious_internal`). Cosmic / receiver regime:
  **quiet** the internal closures (let their period grow past the external's) and the conscious content
  shifts to the **low-frequency external joint closure** (`conscious_external`,
  `quieting_shifts_to_external`) — one becomes a *receiver* of a faint distant station.

Reuses only the frequency ↔ period identity of `QLF_LocalClock`; no new axioms. See
[`Consciousness.md`](../Consciousness.md), [`TheQuantumBrain.md`](../TheQuantumBrain.md).
-/

namespace QLF.Consciousness

/-- The **closure frequency** of a closure of local-clock period `R` (= its `local_clock_period`,
    `QLF_LocalClock`): `f = 1/R`. A deeper closure (larger `R`) ticks slower; a higher-frequency closure
    has a shorter period. -/
noncomputable def freq (R : ℕ) : ℝ := 1 / (R : ℝ)

/-- **Frequency is the inverse order of period**: a shorter period is a higher frequency. -/
theorem freq_lt_of_lt {a b : ℕ} (ha : 0 < a) (hab : a < b) : freq b < freq a := by
  unfold freq
  apply one_div_lt_one_div_of_lt
  · exact_mod_cast ha
  · exact_mod_cast hab

/-- **Binding** two concurrent closures into a higher closure phase-locked to the **faster** of the
    two: the composite closes at the shorter period `min a b` (the resonant/beat rate of the bound
    pair). This is the closure-of-closures of the disjunctive OR-fold (`QLF_InfoSynthesis`). -/
def bind (a b : ℕ) : ℕ := min a b

/-- **Binding raises frequency (the graduation), vs the first constituent** — the bound closure's
    frequency is at least the first sub-closure's: integration shows up as a *higher* closure rate. -/
theorem freq_bind_ge_left {a b : ℕ} (ha : 0 < a) (hb : 0 < b) : freq a ≤ freq (bind a b) := by
  unfold bind freq
  apply one_div_le_one_div_of_le
  · exact_mod_cast (lt_min ha hb)
  · exact_mod_cast (min_le_left a b)

/-- **Binding raises frequency (the graduation), vs the second constituent.** -/
theorem freq_bind_ge_right {a b : ℕ} (ha : 0 < a) (hb : 0 < b) : freq b ≤ freq (bind a b) := by
  unfold bind freq
  apply one_div_le_one_div_of_le
  · exact_mod_cast (lt_min ha hb)
  · exact_mod_cast (min_le_right a b)

/-- The **conscious content** at a moment is the **highest-frequency = shortest-period** closure
    available — here the faster of the dominant internal closure (period `i`) and the dominant external
    *joint* closure (period `e`): `min i e`. The argmax-frequency closure "graduates" to the top of the
    resonance hierarchy and is what we experience as conscious thought. -/
def consciousPeriod (i e : ℕ) : ℕ := min i e

/-- **Waking regime — internal binding is conscious.** When the internal closure is at least as fast as
    the external (`i ≤ e`), the conscious content is the internal closure. -/
theorem conscious_internal {i e : ℕ} (h : i ≤ e) : consciousPeriod i e = i :=
  min_eq_left h

/-- **Cosmic / receiver regime — the external joint closure is conscious.** When the internal closure is
    quieted below the external's frequency (`e ≤ i`, i.e. the internal period has grown past the
    external's), the conscious content is the low-frequency external joint closure: one becomes a
    *receiver* of `e`. -/
theorem conscious_external {i e : ℕ} (h : e ≤ i) : consciousPeriod i e = e :=
  min_eq_right h

/-- **Quieting shifts consciousness outward.** Raising the internal period from a waking `i₀ < e` (where
    the fast internal closure is conscious) to a quieted `i₁` with `e ≤ i₁` moves the conscious content
    from the internal closure to the external joint closure `e` — and `e` is the genuinely
    *lower-frequency* channel (`freq e < freq i₀`). The cosmic-consciousness regime: silence the local
    oscillator and receive the faint low-frequency joint closure. -/
theorem quieting_shifts_to_external {i₀ i₁ e : ℕ}
    (hi0 : 0 < i₀) (hwake : i₀ < e) (hquiet : e ≤ i₁) :
    consciousPeriod i₀ e = i₀ ∧ consciousPeriod i₁ e = e ∧ freq e < freq i₀ :=
  ⟨conscious_internal (le_of_lt hwake), conscious_external hquiet, freq_lt_of_lt hi0 hwake⟩

/-- **Established (structural skeleton, issue/model — `Consciousness.md`):** the frequency-hierarchy of
    resonant closures. Frequency is the inverse closure period (`freq`, `freq_lt_of_lt`); binding
    sub-closures into a higher closure raises the frequency to at least each constituent's
    (`freq_bind_ge_left`/`_right` — the graduation); conscious content is the highest-frequency available
    closure (`consciousPeriod`), the fast internal binding by default (`conscious_internal`) and the
    low-frequency external **joint** closure when the internal is quieted (`conscious_external`,
    `quieting_shifts_to_external` — the cosmic receiver regime). **Honest scope:** this is the functional
    architecture (which closure is conscious, why tuning/binding selects it); the **hard problem**
    (qualia) is bracketed, not solved. Reuses the `f = 1/R` identity of `QLF_LocalClock`; no new axioms.
    See `Consciousness.md`, `TheQuantumBrain.md`, `TheBigProblem.md`. -/
theorem consciousness_frequency_hierarchy_summary : True := trivial

end QLF.Consciousness
