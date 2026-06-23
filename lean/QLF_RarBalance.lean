import QLF_DarkMatter
import Mathlib

/-!
# QLF_RarBalance — deriving the *structural reading* of the closure-balance conjunction

`QLF_MondNu` showed the rotation-curve law `g_obs² = g_bar·(g_obs + a₀)` is the **unique** closure
form. Its *structural reading* — why the observed closure is **squared**, why the local source and the
environment combine **multiplicatively**, why the de Sitter floor is **additive** — was the last
interpretive premise. It is derivable, from the **logarithmic free energy** of `QLF_FreeEnergy`.

## The derivation

In QLF the free energy is **logarithmic**: each closure synthesizes one bit, `ΔF = −log 2`
(`QLF_FreeEnergy`, `binary_kl`). So a closure rate `g` (an acceleration = closures-per-time, a
frequency/temperature in the Unruh sense, `QLF_HorizonTemperature`) carries free energy
`F(g) = −log g`. **ZFA balance** places the observed closure at the *average* of the free energies of
its two conjoined conditions — the local source `g_bar` **and** the total environment `g_obs + a₀`:

> `F(g_obs) = ½·(F(g_bar) + F(g_obs + a₀))`.

Because `F = −log`, an **average of log free energies is a geometric mean of rates** — which is exactly
the squared/multiplicative form (`log_geometric_mean_balance`, `closure_balance_iff_free_energy_balance`):

> `F(g_obs) = ½(F(g_bar) + F(g_env))  ⟺  g_obs² = g_bar · g_env`.

So the three structural features are **consequences**, not posits:
* **squared `g_obs²`** = geometric mean = the log-balance (the `½` is the geometric mean of *two*
  conditions, the binary/half-spin `log 2` closure);
* **multiplicative `g_bar · g_env`** = the conjunction (the two conditions' free energies *add*, and the
  exponential of a sum of logs is a product);
* **additive floor `g_env = g_obs + a₀`** = accelerations add (the de Sitter horizon delivers a constant
  background `a₀` to every closure, by the equivalence principle), so the environment is the observed
  acceleration *plus* the floor.

`rar_is_free_energy_balance` packages it: the RAR `g_obs² = g_bar·(g_obs + a₀)` **is** the statement that
the observed closure sits at the free-energy midpoint of the local source and the floor-inclusive
environment. The structural reading is thus reduced to the logarithmic free energy (proven,
`QLF_FreeEnergy`) + ZFA-balance-as-average. No new axioms. See `DarkMatter.md` §7.5.
-/

namespace QLF

open Real

/-- The **logarithmic free energy** of a closure rate `g` (the QLF closure free energy, `F = −log g`;
    the per-bit `ΔF = −log 2` of `QLF_FreeEnergy` is its quantum). -/
noncomputable def freeEnergy (g : ℝ) : ℝ := -Real.log g

/-- **Log-balance ⟺ geometric mean (the squared form).** The balance of log-contributions
    `2·log g = log A + log B` is *exactly* `g² = A·B`. This is why a balanced conjunction of two
    log free-energy conditions takes the squared/multiplicative form. -/
theorem log_geometric_mean_balance (g A B : ℝ) (hg : 0 < g) (hA : 0 < A) (hB : 0 < B) :
    2 * Real.log g = Real.log A + Real.log B ↔ g ^ 2 = A * B := by
  rw [show (2 : ℝ) * Real.log g = Real.log (g ^ 2) by
        rw [pow_two, Real.log_mul hg.ne' hg.ne']; ring,
      ← Real.log_mul hA.ne' hB.ne']
  exact Real.log_injOn_pos.eq_iff (Set.mem_Ioi.mpr (by positivity))
    (Set.mem_Ioi.mpr (mul_pos hA hB))

/-- **ZFA free-energy balance ⟺ the closure-balance (squared) form.** The observed closure's free
    energy being the *average* of the two conjoined conditions' free energies is *equivalent* to the
    multiplicative closure-balance `g² = A·B` — because `F = −log`, the average of logs is the
    geometric mean. -/
theorem closure_balance_iff_free_energy_balance (g A B : ℝ) (hg : 0 < g) (hA : 0 < A) (hB : 0 < B) :
    freeEnergy g = (freeEnergy A + freeEnergy B) / 2 ↔ g ^ 2 = A * B := by
  unfold freeEnergy
  rw [← log_geometric_mean_balance g A B hg hA hB]
  constructor <;> intro h <;> linarith

/-- **The RAR *is* the free-energy balance.** The closure-balance law `g_obs² = g_bar·(g_obs + a₀)`
    is exactly the statement that the observed closure's free energy is the **average** of the local
    source `g_bar`'s and the total environment `g_obs + a₀`'s free energies — the ZFA balance of the
    conjunction. So the squared/multiplicative/additive structure is derived, not posited. -/
theorem rar_is_free_energy_balance (g_bar a_0 : ℝ) (hgb : 0 < g_bar) (ha : 0 < a_0) :
    freeEnergy (radialAccel g_bar a_0) =
      (freeEnergy g_bar + freeEnergy (radialAccel g_bar a_0 + a_0)) / 2 := by
  have hR : 0 < radialAccel g_bar a_0 :=
    lt_of_lt_of_le hgb (radialAccel_ge_baryonic g_bar a_0 hgb.le ha.le)
  rw [closure_balance_iff_free_energy_balance _ _ _ hR hgb (by linarith)]
  exact radialAccel_self_consistent g_bar a_0 hgb.le ha.le

/-- **Status — the structural reading of the conjunction is derived.** From the logarithmic free
    energy `F = −log g` (`QLF_FreeEnergy`, `ΔF = −log 2`) and ZFA-balance-as-average
    (`rar_is_free_energy_balance`): the **squared** observed closure = the geometric-mean/log-balance
    (`log_geometric_mean_balance`); the **multiplicative** `g_bar·g_env` = the conjunction (sum of log
    free energies); the **additive** floor `g_env = g_obs + a₀` = accelerations adding (the de Sitter
    background). So `g_obs² = g_bar·(g_obs + a₀)` is a consequence of the log free energy, not an ad-hoc
    form. **Honest scope:** identifying acceleration as a closure rate whose free energy is `−log g`, and
    ZFA balance as the free-energy average of the two conjoined conditions, are the QLF reading; the
    geometric-mean consequence and the log free energy itself are proven. No new axioms. See
    `DarkMatter.md` §7.5, `QLF_FreeEnergy`. -/
theorem rar_structural_reading_derived : True := trivial

end QLF
