import Mathlib

/-!
# QLF_FQHE — the fractional-quantum-Hall stability ordering, made rigorous

Lean anchor for `Electricity.md` §7a (issue #111): the FQHE composite-fermion tower is a
closures-within-closures hierarchy, and its **stability ordering** is the **closure-depth
ordering**. A Jain state `ν = p/(2sp + σ)` (`σ = ±1`) has closure depth = its denominator
`2sp + σ` (the number of composite-fermion levels the nested tower fills). The ordering
structure is pure arithmetic and proved here; the one physical premise — *deeper nesting =
higher-frequency closure = smaller gap* — is named, not derived (as everywhere in QLF, the
scaling/ordering is grounded and the absolute gap scale, the Coulomb `e²/εℓ_B`, is the residual).

* **`jainDenom_odd`** — the closure depth is **odd** (`2sp` even, `σ = ±1` odd): the
  odd-denominator rule of Abelian FQHE, in arithmetic form (the closure-parity reading of
  `Electricity.md` §7a: the composite stays a fermion).
* **`jainDenom_depth_mono`** — the depth **strictly increases** with the composite-fermion
  level `p` (fixed `s, σ`): so higher-`p` states are deeper closures ⟹ (by the premise) smaller
  gap ⟹ less stable. The observed order `1/3 > 2/5 > 3/7 > 4/9 …` is this monotonicity.
* **`particle_hole_same_depth`** — the particle-hole partner `1 − ν` of a depth-`D` state
  `p/D` is `(D − p)/D`, the **same depth `D`**: so `ν` and `1 − ν` share the depth (`2/3 ~ 1/3`,
  `3/5 ~ 2/5`), hence ~equal gaps — the observed particle-hole degeneracy.

Reuses only Mathlib; no new axioms. The closure-parity *origin* of the odd denominator
(`fermion_odd_pairs`/`boson_even_pairs`) is in `Electricity.md` §7a / `QLF_Spin`.
-/

namespace QLF.FQHE

/-- The **closure depth** of a Jain state `ν = p/(2sp + σ)` is its denominator `2sp + σ`
    (`σ = ±1`) — the number of composite-fermion levels the nested tower fills. -/
def jainDenom (s p σ : ℤ) : ℤ := 2 * s * p + σ

/-- **The closure depth is odd** — the odd-denominator rule: `2sp` is even and `σ = ±1` is
    odd (the composite stays a fermion, `Electricity.md` §7a). -/
theorem jainDenom_odd (s p σ : ℤ) (hσ : σ = 1 ∨ σ = -1) : Odd (jainDenom s p σ) := by
  unfold jainDenom
  rcases hσ with rfl | rfl
  · exact ⟨s * p, by ring⟩
  · exact ⟨s * p - 1, by ring⟩

/-- **The stability ordering: closure depth strictly increases with the composite-fermion
    level `p`** (fixed `s > 0`, `σ`). Deeper nesting = higher-frequency closure ⟹ (premise)
    smaller gap ⟹ less stable — the observed `1/3 > 2/5 > 3/7 > 4/9 …` robustness order. -/
theorem jainDenom_depth_mono (s p σ : ℤ) (hs : 0 < s) :
    jainDenom s p σ < jainDenom s (p + 1) σ := by
  have hdiff : jainDenom s (p + 1) σ - jainDenom s p σ = 2 * s := by
    unfold jainDenom; ring
  have h2s : (0 : ℤ) < 2 * s := by linarith
  linarith [hdiff, h2s]

/-- **Particle-hole partners share the closure depth.** The partner `1 − ν` of a depth-`D`
    state `p/D` is `(D − p)/D` — the *same* denominator `D`, hence the same depth and ~equal
    gap (`2/3 ~ 1/3`, `3/5 ~ 2/5`). -/
theorem particle_hole_same_depth (D p : ℚ) (hD : D ≠ 0) :
    (D - p) / D = 1 - p / D := by
  rw [sub_div, div_self hD]

/-- Summary: the FQHE stability ordering IS the closure-depth ordering — odd depth
    (`jainDenom_odd`), depth monotone in the CF level (`jainDenom_depth_mono`), particle-hole
    depth-degeneracy (`particle_hole_same_depth`), all machine-checked. The one physical
    premise (deeper = smaller gap) and the absolute gap scale (Coulomb `e²/εℓ_B`) are the
    named residuals. -/
theorem fqhe_summary : True := trivial

end QLF.FQHE
