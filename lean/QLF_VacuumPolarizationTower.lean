import QLF_VacuumPolarization
import QLF_HorizonClosure
import QLF_Kolmogorov

set_option linter.unusedVariables false

/-!
# QLF_VacuumPolarizationTower — the horizon→scale tower: the running *function* from the census

`QLF_VacuumPolarization` (module 170) anchored the leading one-loop coefficient `2/(3π)` from the
two-vertex split census. This module builds the second half of issue #117: the **horizon → scale
(`Q²`) tower** that turns that per-loop coefficient into the running *function* `α⁻¹(Q²)` — the
substrate reading of vacuum polarization as a census-weighted, scale-dependent sum over the
elementary closures, with scale-dependence entering natively through the closure horizon
(`closedAtHorizon`, `QLF_HorizonClosure`).

## The finding — the QED logarithm IS the census octave count

The running is logarithmic for a reason the census makes exact. Scale is counted in **octaves**
(multiplicative doublings), and each octave contributes the **same** census quantum — the scale-free
`log 2` (`QLF_Kolmogorov.energyPerClosure`, reused; octave-independence is `flux_scale_invariant`).
So:

* **Horizon → scale.** `horizonScale Q₀ R = Q₀ · 2^R` — one octave of momentum per resolution pass,
  so the `closedAtHorizon` horizon `R` *is* the octave counter (`horizon_scale_octaves`), and
  log-scale is **additive** in octaves: `ln Q(R_Q) = ln Q(R_f) + (R_Q − R_f)·ln 2`
  (`log_scale_additive`).

* **The per-octave increment is constant (scale-free).** Each octave adds the same
  `perOctaveIncrement Qf = (2/3π)·Q_f² · log 2` to `α⁻¹` — the module-170 coefficient times the
  octave's `log 2` census quantum. Octave-independence is *reused* from Kolmogorov's flux invariance
  (`running_increment_scale_invariant` via `flux_scale_invariant`): the same `log 2` at every scale.

* **The octave tower renders to the smooth QED log.** Summing the constant increment over `k`
  octaves gives `octaveTower Qf k = (2/3π)·Q_f² · log(2^k)` (`octave_tower_recovers_qed_log`, via
  `Real.log_pow`: `k · log 2 = ln 2^k`). The **discrete** octave count `k` (integer, quantum `log 2`)
  renders **exactly** to the **continuous** `ln(Q/m_f)` of QED — the substrate discreteness washing
  into the continuum logarithm, no divergence (the Landau pole sits above the Planck-floor octave,
  `QLF_RunningCouplings`).

* **Thresholds are automatic (ℕ truncation).** A fermion of threshold octave `R_f` contributes
  `octaveTower Qf (R_Q − R_f)`, and ℕ-truncated subtraction makes this **zero** below threshold
  (`inactive_below_threshold`: `R_Q ≤ R_f ⟹ 0`) and **positive** above it
  (`active_above_threshold`) — the species "turns on" when the probe crosses its scale, exactly the
  QED threshold structure. So *"the count available changes with the horizon"* (#117) is the ℕ-count
  `R_Q − R_f`, and the tower `towerRunning` is the sum over the active elementary closures; `α⁻¹`
  decreases monotonically toward the UV (`towerRunning_le_alpha0`, `octaveTower_mono`).

Assembled: `α⁻¹(Q²) = α⁻¹₀ − Σ_f (2/3π)·Q_f² · ln(Q²/m_f²)` — QED's one-loop running, every factor
census-sourced: the coefficient `2/3π` (module 170), the log = octave count (here), the threshold =
ℕ truncation (here), the sum = active elementary closures.

## Honest scope

This anchors the running **function's structure** — the logarithmic form as the octave count, the
scale-free per-octave increment (reused), the automatic thresholds, and the monotone UV flow — all
value-free. It does **not** fix the **value** `α⁻¹(0) = 137.036` (the `0.036` residual) or the
running slope's magnitude: those need the specific **elementary-closure spectrum** — *which*
prime-count closures are active, their charge census `Q_f²`, and their threshold octaves `R_f` — the
open input (`qed_running_tower_in_progress`), which is **not fitted** (the `0.036` minefield is
pre-buried in `QLF_AlphaRigidity` / #117; one-term geometric matches are refuted). The tower supplies
the skeleton; the closure spectrum is the flesh. Reuses `QLF_VacuumPolarization` + `QLF_Kolmogorov` +
`QLF_HorizonClosure`; no new axioms. See `Alpha.md`, `TheContinuum.md` §3.1, issue #117.
-/

namespace QLF

open Real

/-! ### The scale-free per-octave increment -/

/-- The QED vacuum-polarization coefficient `2/(3π)` is positive. -/
theorem qedVacPolCoeff_pos : 0 < qedVacPolCoeff := by
  rw [qedVacPolCoeff_eq]; positivity

/-- **The per-octave running increment** — the contribution one octave of scale adds to `α⁻¹`:
    the module-170 coefficient `2/(3π)` times the charge census `Q_f²` times the octave's `log 2`
    census quantum (`QLF_Kolmogorov.energyPerClosure`). The **same at every octave** (scale-free). -/
noncomputable def perOctaveIncrement (Qf : ℝ) : ℝ :=
  qedVacPolCoeff * Qf ^ 2 * Kolmogorov.energyPerClosure

theorem perOctaveIncrement_nonneg (Qf : ℝ) : 0 ≤ perOctaveIncrement Qf := by
  unfold perOctaveIncrement
  exact mul_nonneg (mul_nonneg (le_of_lt qedVacPolCoeff_pos) (sq_nonneg Qf))
    (le_of_lt Kolmogorov.energyPerClosure_pos)

theorem perOctaveIncrement_pos (Qf : ℝ) (h : Qf ≠ 0) : 0 < perOctaveIncrement Qf := by
  unfold perOctaveIncrement
  have hQ : (0 : ℝ) < Qf ^ 2 := lt_of_le_of_ne (sq_nonneg Qf) ((pow_ne_zero 2 h).symm)
  exact mul_pos (mul_pos qedVacPolCoeff_pos hQ) Kolmogorov.energyPerClosure_pos

/-- The per-octave increment **is** a Kolmogorov octave flux (`energyPerClosure · count`) with the
    scale-invariant count `qedVacPolCoeff · Q_f²`. Makes the reuse explicit. -/
theorem perOctave_is_flux (Qf : ℝ) (n : ℕ) :
    perOctaveIncrement Qf = Kolmogorov.fluxAt (fun _ => qedVacPolCoeff * Qf ^ 2) n := by
  simp only [perOctaveIncrement, Kolmogorov.fluxAt]; ring

/-- **Scale invariance of the running increment** — reused from Kolmogorov's flux invariance: the
    per-octave contribution to `α⁻¹` is octave-independent (the same `log 2` census quantum at every
    scale), which is *why* the running is a clean logarithm rather than some other function. -/
theorem running_increment_scale_invariant (Qf : ℝ) (m n : ℕ) :
    Kolmogorov.fluxAt (fun _ => qedVacPolCoeff * Qf ^ 2) m
      = Kolmogorov.fluxAt (fun _ => qedVacPolCoeff * Qf ^ 2) n :=
  Kolmogorov.flux_scale_invariant _ (qedVacPolCoeff * Qf ^ 2) (fun _ => rfl) m n

/-! ### The octave tower -/

/-- **The octave tower** — `k` octaves of scale, each adding the scale-free increment. -/
noncomputable def octaveTower (Qf : ℝ) (k : ℕ) : ℝ :=
  ∑ _i ∈ Finset.range k, perOctaveIncrement Qf

/-- The tower is the octave count times the (constant) per-octave increment. -/
theorem octaveTower_eq (Qf : ℝ) (k : ℕ) :
    octaveTower Qf k = (k : ℝ) * perOctaveIncrement Qf := by
  simp only [octaveTower, Finset.sum_const, Finset.card_range, nsmul_eq_mul]

theorem octaveTower_zero (Qf : ℝ) : octaveTower Qf 0 = 0 := by
  simp [octaveTower]

theorem octaveTower_nonneg (Qf : ℝ) (k : ℕ) : 0 ≤ octaveTower Qf k := by
  rw [octaveTower_eq]
  exact mul_nonneg (Nat.cast_nonneg k) (perOctaveIncrement_nonneg Qf)

/-- More octaves ⟹ more running (`α⁻¹` moves further): the tower is monotone in the octave count. -/
theorem octaveTower_mono (Qf : ℝ) {k k' : ℕ} (h : k ≤ k') :
    octaveTower Qf k ≤ octaveTower Qf k' := by
  rw [octaveTower_eq, octaveTower_eq]
  exact mul_le_mul_of_nonneg_right (by exact_mod_cast h) (perOctaveIncrement_nonneg Qf)

/-- **The octave tower renders to the smooth QED logarithm.** The discrete octave count `k` (integer,
    quantum `log 2`) equals the continuous `log(2^k) = ln(Q/m_f)` of QED: `octaveTower Qf k =
    (2/3π)·Q_f² · log(2^k)`. The substrate discreteness washes into the continuum logarithm. -/
theorem octave_tower_recovers_qed_log (Qf : ℝ) (k : ℕ) :
    octaveTower Qf k = qedVacPolCoeff * Qf ^ 2 * Real.log (2 ^ k) := by
  rw [octaveTower_eq]
  simp only [perOctaveIncrement, Kolmogorov.energyPerClosure, Real.log_pow]
  ring

/-! ### Horizon → scale -/

/-- **The horizon → scale map** `Q(R) = Q₀ · 2^R` — one octave of momentum per resolution pass, so
    the `closedAtHorizon` horizon `R` is the octave counter. -/
noncomputable def horizonScale (Q0 : ℝ) (R : ℕ) : ℝ := Q0 * 2 ^ R

theorem horizonScale_pos (Q0 : ℝ) (R : ℕ) (h : 0 < Q0) : 0 < horizonScale Q0 R := by
  unfold horizonScale; positivity

/-- The scale grows by one octave (`× 2`) per resolution pass: `Q(R_Q) = Q(R_f) · 2^(R_Q − R_f)`. -/
theorem horizon_scale_octaves (Q0 : ℝ) (Rf RQ : ℕ) (h : Rf ≤ RQ) :
    horizonScale Q0 RQ = horizonScale Q0 Rf * 2 ^ (RQ - Rf) := by
  unfold horizonScale
  rw [mul_assoc, ← pow_add, Nat.add_sub_cancel' h]

/-- **Log-scale is additive in octaves** — `ln Q(R_Q) = ln Q(R_f) + (R_Q − R_f)·ln 2`. The octave
    count *is* the log of the scale ratio; this is why a scale-free per-octave increment gives a
    logarithmic running. -/
theorem log_scale_additive (Q0 : ℝ) (Rf RQ : ℕ) (hQ0 : 0 < Q0) (h : Rf ≤ RQ) :
    Real.log (horizonScale Q0 RQ)
      = Real.log (horizonScale Q0 Rf) + (↑(RQ - Rf) : ℝ) * Real.log 2 := by
  rw [horizon_scale_octaves Q0 Rf RQ h,
      Real.log_mul (ne_of_gt (horizonScale_pos Q0 Rf hQ0))
        (by positivity : (2 : ℝ) ^ (RQ - Rf) ≠ 0),
      Real.log_pow]

/-! ### Thresholds and the tower over elementary closures -/

/-- **A species is inactive below its threshold** — ℕ-truncated subtraction makes the octave count
    (hence the contribution) zero until the probe horizon `R_Q` crosses the threshold `R_f`. -/
theorem inactive_below_threshold (Qf : ℝ) (Rf RQ : ℕ) (h : RQ ≤ Rf) :
    octaveTower Qf (RQ - Rf) = 0 := by
  rw [Nat.sub_eq_zero_of_le h, octaveTower_zero]

/-- **A species is active above its threshold** — once the probe crosses `R_f`, the octave count is
    positive and (for nonzero charge) the contribution is strictly positive. -/
theorem active_above_threshold (Qf : ℝ) (Rf RQ : ℕ) (hlt : Rf < RQ) (hQ : Qf ≠ 0) :
    0 < octaveTower Qf (RQ - Rf) := by
  rw [octaveTower_eq]
  have hk : (0 : ℝ) < ((RQ - Rf : ℕ) : ℝ) := by
    have : 0 < RQ - Rf := Nat.sub_pos_of_lt hlt
    exact_mod_cast this
  exact mul_pos hk (perOctaveIncrement_pos Qf hQ)

/-- **The tower** — `α⁻¹(Q²)` as the IR value minus the sum over active elementary closures, each a
    `(charge Q_f, threshold octave R_f)` contributing its octave tower `octaveTower Q_f (R_Q − R_f)`
    (zero below threshold). The substrate reading of the vacuum-polarization sum. -/
noncomputable def towerRunning (alpha0 : ℝ) (species : List (ℝ × ℕ)) (RQ : ℕ) : ℝ :=
  alpha0 - (species.map (fun p => octaveTower p.1 (RQ - p.2))).sum

/-- **The running lowers `α⁻¹`** (raises `α`) — every closure's contribution is nonnegative, so the
    tower never pushes `α⁻¹` above its IR value; the coupling grows toward the UV (QED screening,
    the `infrared_growth` branch of `QLF_RunningCouplings`). -/
theorem towerRunning_le_alpha0 (alpha0 : ℝ) (species : List (ℝ × ℕ)) (RQ : ℕ) :
    towerRunning alpha0 species RQ ≤ alpha0 := by
  unfold towerRunning
  have hnn : 0 ≤ (species.map (fun p => octaveTower p.1 (RQ - p.2))).sum := by
    apply List.sum_nonneg
    intro x hx
    simp only [List.mem_map] at hx
    obtain ⟨p, _, rfl⟩ := hx
    exact octaveTower_nonneg _ _
  linarith

end QLF
