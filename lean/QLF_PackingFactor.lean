import QLF_BindingStrength

set_option linter.unusedVariables false

/-!
# QLF_PackingFactor — modeling the packing factor from the 8-twist combinatorics (the diagnostic)

Frontier #1's irreducible piece is the **packing factor** in `g = (log 2)·channel·packing`
(`QLF_BindingStrength`). This module *does the modeling asked for* — constructs the combinatorial
packing factor from the 8-twist alphabet and computes its consequence — and Lean-anchors the honest
result, which is a **diagnostic, not a value**: a bare combinatorial packing gives an **O(1)**,
subcritical coupling, hence only **modest condensation depth**, so it **cannot** by itself produce the
`v ≪ M_Pl` hierarchy. That is the near-critical SOC value (`g ~ 10⁻⁸`), which is *interacting
dynamics*, not counting. So this rigorously **confirms** the `closure_binding.py` §4 conclusion by
explicit construction — the packing factor is *not* a clean count.

## The combinatorial model

The closure-binding four-fermion coupling has the **standard NJL loop structure** — a fermion loop
with `N_c` colours and a `4π²` phase-space factor — the *same* form as the gravitational
`g_grav = c·N_c/(4π²)` (`QLF_BindingStrength.gravBinding`). So the combinatorial packing coupling is

  `closureLoopCoupling mult = mult · N_c / (4π²)`,

with `mult` the 8-twist closure **multiplicity** — the number of closures packing into a binding
vertex (bounded by the alphabet, `mult ≤ 8`). The loop form `N_c/(4π²)` is the standard NJL input; the
multiplicity is the combinatorial count. **`bare_packing_subcritical`** — for *any* alphabet
multiplicity `mult ≤ 8`, `closureLoopCoupling mult < 1 = g_crit`: the bare combinatorial packing is
**subcritical** (indeed `closureLoopCoupling 8 = 6/π² ≈ 0.61`, the same O(1) scale as `g_grav ≈ 0.36`).

## Why a bare count gives no hierarchy

The condensation depth is the transmutation form `N*(g) = π/(4g²)`
(`condensationDepth`; from `g·gapSum(N*) = 1` with the Wallis census `gapSum(N) ~ 2√(N/π)`,
`QLF_CondensateGap`). It is **antitone** in `g` (`condensationDepth_antitone`): *smaller* `g` ⟹
*deeper* condensation. A bare **O(1)** packing coupling therefore gives an **O(1)** depth — `v ~ M_Pl`,
no hierarchy. The observed `v` sits at depth `N* ~ M_Pl/v ~ 10¹⁶`, which needs `g ~ √(π/4·10⁻¹⁶) ~
10⁻⁸` — **eight orders below any bare 8-twist count**. So the packing factor that fixes `v` is the
**near-critical** value the SOC attractor selects, not the combinatorial multiplicity.

## Honest scope (`packing_factor_in_progress`)

**The modeling is done and its verdict Lean-anchored:** the bare 8-twist packing has the right NJL
loop *structure* (`closureLoopCoupling`, `bare_packing_subcritical`) but is O(1), and an O(1) coupling
gives no hierarchy (`condensationDepth_antitone`) — so `g`/`v` is **not** a clean combinatorial count
(confirming `closure_binding.py` §4). **Open (unchanged, #121):** the actual `v` is the SOC-critical
departure `g ~ 10⁻⁸`, set by the interacting many-closure density at criticality — a
substrate-*dynamics* problem. `v` stays **calibrated, not predicted**; **nothing is fitted** here (the
`N* ~ M_Pl/v` and `g ~ 10⁻⁸` comparison is a *consequence check*, not an input). The loop form
`N_c/(4π²)` is the standard NJL input, not derived. Reuses `QLF_BindingStrength`; no new axioms. See
`Higgs.md` §5a, `closure_binding.py` §4, issue #121.
-/

namespace QLF.PackingFactor

open QLF.BindingStrength

/-! ### The combinatorial packing coupling (NJL loop form) -/

/-- The closure-binding coupling from the 8-twist packing multiplicity `mult`, in the standard NJL
    loop form `mult·N_c/(4π²)` — the *same* structure as the gravitational `g_grav`. -/
noncomputable def closureLoopCoupling (mult : ℝ) : ℝ := mult * Nc / (4 * Real.pi ^ 2)

/-- **The bare combinatorial packing is subcritical** — for any alphabet multiplicity `mult ≤ 8`,
    `closureLoopCoupling mult < 1 = g_crit`. (At `mult = 8`, `= 6/π² ≈ 0.61`.) So a bare 8-twist count
    is O(1), the same scale as `g_grav` — not the `~10⁻⁸` the hierarchy needs. -/
theorem bare_packing_subcritical (mult : ℝ) (h0 : 0 ≤ mult) (h8 : mult ≤ 8) :
    closureLoopCoupling mult < 1 := by
  unfold closureLoopCoupling Nc
  rw [div_lt_one (by positivity)]
  nlinarith [Real.pi_gt_three, h8, h0, sq_nonneg (Real.pi - 3)]

/-! ### The condensation depth and why O(1) packing gives no hierarchy -/

/-- The transmutation condensation depth `N*(g) = π/(4g²)` — from `g·gapSum(N*) = 1` with the Wallis
    census `gapSum(N) ~ 2√(N/π)` (`QLF_CondensateGap`). -/
noncomputable def condensationDepth (g : ℝ) : ℝ := Real.pi / (4 * g ^ 2)

/-- The condensation depth is positive (for `g ≠ 0`). -/
theorem condensationDepth_pos (g : ℝ) (hg : g ≠ 0) : 0 < condensationDepth g := by
  unfold condensationDepth
  have hg2 : (0 : ℝ) < g ^ 2 := lt_of_le_of_ne (sq_nonneg g) (Ne.symm (pow_ne_zero 2 hg))
  exact div_pos Real.pi_pos (by linarith)

/-- **Smaller coupling ⟹ deeper condensation** — `condensationDepth` is antitone in `g`. So only a
    *tiny* `g` gives a large depth (a hierarchy); a bare **O(1)** packing gives an **O(1)** depth
    (`v ~ M_Pl`, no hierarchy). This is why the bare combinatorial count cannot fix `v`. -/
theorem condensationDepth_antitone {g1 g2 : ℝ} (h1 : 0 < g1) (h : g1 ≤ g2) :
    condensationDepth g2 ≤ condensationDepth g1 := by
  unfold condensationDepth
  have h2pos : 0 < g2 := lt_of_lt_of_le h1 h
  gcongr

/-- Honest-scope marker: the bare 8-twist packing is modelled (subcritical, O(1)), and shown by
    `condensationDepth_antitone` to give no hierarchy — so the `v`-fixing packing is the near-critical
    SOC value, not a clean count (confirming `closure_binding.py` §4). Not fitted; #121 open. -/
theorem packing_factor_in_progress : True := trivial

end QLF.PackingFactor
