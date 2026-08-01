import QLF_CondensateGap
import QLF_ClosureBinding

set_option linter.unusedVariables false

/-!
# QLF_BindingStrength — the gravitational floor + the `g`-decomposition: localizing frontier #1

Frontier #1 (issue #121) is the closure-binding coupling `g` that fixes the absolute electroweak
scale `R_stable = v`. The frontier's own analysis has established the honest ceiling: condensation is
**generic** (`QLF_CondensateGap`), so the residual is the single coupling `g = (log 2) × (channel) ×
(packing)`; and the electroweak scale is **condensation criticality, not transmutation** — there is
**no clean `b_EW` count** (`b_EW = ln(M_Pl/v)/2π = 6.118` matches no substrate integer; the `6`-match
is 1.9 % off and refused, `closure_binding.py` §4). So `g`/`v` is **not** a counting exercise and is
**not derived here** — it is the interacting many-closure density at the SOC critical point, a
substrate-*dynamics* problem. This module does the one *disciplined* thing available: it Lean-anchors
the pieces that ARE rigorous — the **gravitational floor** and the **`g`-decomposition** — pinning
down exactly what the irreducible packing factor must supply, without fitting `v`.

## The gravitational floor (previously only in `higgs_running_demo.py` §E)

QLF's emergent gravity (Einstein–Cartan torsion) induces a four-fermion coupling
`g_grav = c·N_c/(4π²)`, with `N_c = 3` (colours = axes, QLF-derived) and `c = O(1)` the
Kibble–Sciama/Fierz torsion coefficient. At `c = 3π/2` (Kibble–Sciama), `g_grav = 9/(8π) ≈ 0.36`
(`gravBinding_kibble_sciama`), which is **subcritical** — `< g_crit = 1` (`gravBinding_subcritical`):
**gravity alone is too weak to condense the electroweak vacuum** (the known result). So the
closure-binding must supply the rest, `g_crit − g_grav > 0` (`binding_must_supply_rest`) — the target
the packing factor has to reach.

## The `g`-decomposition

The closure-binding coupling is `bindingCoupling channel packing = (log 2)·channel·packing`, with the
**quantum** the free-energy `log 2` (`QLF.ClosureBinding.binding_quantum`, derived) and the
**channel** factor the allowed-channel structure (`t̄t` binds, `tt` blocked — derived). The **packing
factor** is the one dimensionless number the interacting theory must fix; it is positive iff the
binding is real (`bindingCoupling_pos`) and monotone in the packing density
(`bindingCoupling_mono_packing`). Deeper packing ⟹ larger `g` ⟹ shallower condensation depth
`N* ~ π/(4g²)` (`QLF_CondensateGap.criticalCoupling_antitone`), i.e. a *larger* `v`.

## Honest scope (`binding_strength_in_progress`)

**Anchored (value-free):** the gravitational floor `g_grav` and its subcriticality (so closure-binding
is *necessary*), and the `g`-decomposition with the packing factor as the named residual. **Open (the
irreducible number, #121):** the **packing factor** itself — the interacting many-closure density at
the SOC critical point. It is **not** a clean count (no `b_EW`), so it is **not fitted** and **not
derived** here; a genuine derivation needs modeling the substrate *interaction* (how gauge folds
attract), beyond the free-census core. `v` stays honestly **calibrated, not predicted**. Reuses
`QLF_CondensateGap` + `QLF_ClosureBinding`; no new axioms. See `Higgs.md` §5a, issue #121.
-/

namespace QLF.BindingStrength

open Real

/-- `N_c = 3` (colours = the 3 axes, QLF-derived). -/
def Nc : ℝ := 3

/-- The **NJL critical coupling** (naive single-cutoff normalization), `g_crit = 1`. -/
def gCrit : ℝ := 1

/-! ### The gravitational floor -/

/-- The four-fermion coupling induced by QLF's emergent gravity (Einstein–Cartan torsion):
    `g_grav = c·N_c/(4π²)`, with `c` the O(1) Kibble–Sciama/Fierz torsion coefficient. -/
noncomputable def gravBinding (c : ℝ) : ℝ := c * Nc / (4 * Real.pi ^ 2)

/-- At the Kibble–Sciama coefficient `c = 3π/2`, `g_grav = 9/(8π)`. -/
theorem gravBinding_kibble_sciama : gravBinding (3 * Real.pi / 2) = 9 / (8 * Real.pi) := by
  unfold gravBinding Nc
  have hpi : Real.pi ≠ 0 := Real.pi_ne_zero
  field_simp
  ring

/-- **Gravity alone is subcritical** — `g_grav(3π/2) = 9/(8π) < 1 = g_crit`: the Einstein–Cartan
    torsion four-fermion coupling is too weak to condense the electroweak vacuum. -/
theorem gravBinding_subcritical : gravBinding (3 * Real.pi / 2) < gCrit := by
  rw [gravBinding_kibble_sciama]
  unfold gCrit
  rw [div_lt_one (by positivity)]
  linarith [Real.pi_gt_three]

/-- **So the closure-binding must supply the rest** — `g_crit − g_grav > 0` is the coupling gap the
    packing factor has to reach (the SOC-attractor target). -/
theorem binding_must_supply_rest : 0 < gCrit - gravBinding (3 * Real.pi / 2) := by
  have := gravBinding_subcritical
  linarith

/-! ### The `g`-decomposition -/

/-- The closure-binding coupling `g = (log 2)·channel·packing` — the free-energy quantum `log 2`
    (`QLF.ClosureBinding.binding_quantum`), the allowed-channel factor, and the **packing factor**
    (the irreducible open input). -/
noncomputable def bindingCoupling (channel packing : ℝ) : ℝ := Real.log 2 * channel * packing

/-- The binding quantum is the free-energy `log 2` (reuse `QLF_ClosureBinding`). -/
theorem binding_quantum_is_log_two : QLF.binary_kl 1 (1 / 2) = Real.log 2 :=
  QLF.ClosureBinding.binding_quantum

/-- The binding coupling is positive exactly when the channel and packing are (a real binding). -/
theorem bindingCoupling_pos (channel packing : ℝ) (hc : 0 < channel) (hp : 0 < packing) :
    0 < bindingCoupling channel packing := by
  unfold bindingCoupling
  have hlog : 0 < Real.log 2 := Real.log_pos (by norm_num)
  exact mul_pos (mul_pos hlog hc) hp

/-- **Monotone in the packing density** — denser packing ⟹ stronger binding `g`. -/
theorem bindingCoupling_mono_packing (channel : ℝ) (hc : 0 < channel) {p p' : ℝ} (h : p ≤ p') :
    bindingCoupling channel p ≤ bindingCoupling channel p' := by
  unfold bindingCoupling
  have hlog : 0 < Real.log 2 := Real.log_pos (by norm_num)
  have hnn : 0 ≤ Real.log 2 * channel := le_of_lt (mul_pos hlog hc)
  exact mul_le_mul_of_nonneg_left h hnn

/-- Honest-scope marker: the packing factor (hence `g`, hence `v`) is the irreducible open number of
    the electroweak sector — not a clean count, not fitted, not derived here (issue #121). -/
theorem binding_strength_in_progress : True := trivial

end QLF.BindingStrength
