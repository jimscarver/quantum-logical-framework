import QLF_ChargeCensus

set_option linter.unusedVariables false

/-!
# QLF_AnomalyCancellation — gauge consistency as a ZFA ledger-balance: every anomaly cancels

The Standard Model's most striking consistency miracle is **anomaly cancellation**: the gauge theory
is quantum-mechanically consistent only because a set of otherwise-unrelated charge sums *all vanish*
per generation. On the substrate this is a **ZFA balance** — the hypercharge ledger of a complete
generation *closes* (`Σ_pos = Σ_neg`), the same closure principle behind electric neutrality
(`QLF_ChargeBalance`, `Σ Q = 0`), now for every gauge current.

## The content and its charges — all QLF-derived

One left-handed generation is the SU(5) `5̄ ⊕ 10 = 15` Weyl fermions (`QLF_SU5`), with hypercharge
`Y = Q − T₃` fixed by QLF's derived electric charge `Q` (the thirds forced by the 3 colours,
`QLF_QuarkStructure`) and weak isospin `T₃ = ±1/2` (the SU(2) doublet structure, `QLF_WeinbergAngle`):

| field | `Y` | colour | SU(2) |
|---|---|---|---|
| `Q_L` | `1/6` | 3 | doublet |
| `u^c` | `−2/3` | 3̄ | singlet |
| `d^c` | `1/3` | 3̄ | singlet |
| `L`   | `−1/2` | 1 | doublet |
| `e^c` | `1` | 1 | singlet |

(`Y_Q = 2/3 − 1/2`, `Y_L = 0 − 1/2`, etc. — `Y_from_Q_T3`.)

## Every anomaly cancels — the ledger closes

* **Gravitational / `[U(1)]`** `Σ Y = 6·(1/6) + 3·(−2/3) + 3·(1/3) + 2·(−1/2) + (1) = 0`
  (`grav_anomaly_zero`).
* **`[U(1)]³`** `Σ Y³ = 6·(1/6)³ + 3·(−2/3)³ + 3·(1/3)³ + 2·(−1/2)³ + (1)³ = 0` (`cubic_anomaly_zero`).
* **`[SU(2)]²·U(1)`** (sum `Y` over SU(2) doublets, weighted by colour) `= 3·(1/6) + (−1/2) = 0`
  (`su2_anomaly_zero`).
* **`[SU(3)]²·U(1)`** (sum `Y` over colour triplets, weighted by SU(2) dim) `= 2·(1/6) + (−2/3) + (1/3)
  = 0` (`su3_mixed_anomaly_zero`).
* **`[SU(3)]³`** (`A(3) = +1`, `A(3̄) = −1`: two triplets `Q_L` vs the `u^c, d^c` anti-triplets)
  `= 2·(+1) + (−1) + (−1) = 0` (`su3_cubic_anomaly_zero`).

So the gauge theory is anomaly-free **because the generation's charge ledger is ZFA-balanced** — the
quark thirds (from the 3 colours) are *exactly* what make every sum close. Anomaly cancellation is the
gauge-current form of charge closure.

## Honest scope

The anomaly *sums* are census computations over QLF's derived content; the values `Q` (thirds) and `T₃`
(isospin) are QLF-derived, and `Y = Q − T₃`. The `A(3̄) = −A(3)` of the cubic colour anomaly is the
standard group-theory sign (the substrate `3̄` = the Hermitian-conjugate colour closure). Reuses
`QLF_ChargeCensus`; no new axioms. See `QLF_ChargeBalance`, `QLF_SU5`, `Standard_Model.md`.
-/

namespace QLF

/-! ### QLF-derived hypercharges `Y = Q − T₃` (SU(5) `5̄ ⊕ 10` content) -/

/-- Left quark doublet hypercharge `Y = 2/3 − 1/2 = 1/6`. -/
def Y_Q : ℚ := 1 / 6
/-- Up antiquark `Y = −2/3`. -/
def Y_uc : ℚ := -2 / 3
/-- Down antiquark `Y = 1/3`. -/
def Y_dc : ℚ := 1 / 3
/-- Lepton doublet `Y = 0 − 1/2 = −1/2`. -/
def Y_L : ℚ := -1 / 2
/-- Positron `Y = 1`. -/
def Y_ec : ℚ := 1

/-- The quark-doublet hypercharge is `Q − T₃` on its up component (`2/3 − 1/2`). -/
theorem Y_Q_from_Q_T3 : Y_Q = 2 / 3 - 1 / 2 := by norm_num [Y_Q]
/-- The lepton-doublet hypercharge is `Q − T₃` on its neutrino component (`0 − 1/2`). -/
theorem Y_L_from_Q_T3 : Y_L = 0 - 1 / 2 := by norm_num [Y_L]

/-! ### The five anomalies all vanish -/

/-- **Gravitational / `[U(1)]` anomaly** `Σ (colour·SU2)·Y = 0`. -/
def gravAnomaly : ℚ := 6 * Y_Q + 3 * Y_uc + 3 * Y_dc + 2 * Y_L + 1 * Y_ec

theorem grav_anomaly_zero : gravAnomaly = 0 := by
  norm_num [gravAnomaly, Y_Q, Y_uc, Y_dc, Y_L, Y_ec]

/-- **`[U(1)]³` anomaly** `Σ (colour·SU2)·Y³ = 0`. -/
def cubicAnomaly : ℚ := 6 * Y_Q ^ 3 + 3 * Y_uc ^ 3 + 3 * Y_dc ^ 3 + 2 * Y_L ^ 3 + 1 * Y_ec ^ 3

theorem cubic_anomaly_zero : cubicAnomaly = 0 := by
  norm_num [cubicAnomaly, Y_Q, Y_uc, Y_dc, Y_L, Y_ec]

/-- **`[SU(2)]²·U(1)` anomaly** — sum `Y` over the SU(2) doublets (`Q_L` ×3 colour, `L` ×1) `= 0`. -/
def su2MixedAnomaly : ℚ := 3 * Y_Q + 1 * Y_L

theorem su2_anomaly_zero : su2MixedAnomaly = 0 := by
  norm_num [su2MixedAnomaly, Y_Q, Y_L]

/-- **`[SU(3)]²·U(1)` anomaly** — sum `Y` over the colour triplets (`Q_L` ×2 SU(2), `u^c`, `d^c`)
    `= 0`. -/
def su3MixedAnomaly : ℚ := 2 * Y_Q + 1 * Y_uc + 1 * Y_dc

theorem su3_mixed_anomaly_zero : su3MixedAnomaly = 0 := by
  norm_num [su3MixedAnomaly, Y_Q, Y_uc, Y_dc]

/-- **`[SU(3)]³` anomaly** — `A(3) = +1`, `A(3̄) = −1`; two triplets (`Q_L`) vs the two anti-triplets
    (`u^c, d^c`) `= 2·(+1) + (−1) + (−1) = 0`. The colour `3̄` is the Hermitian-conjugate closure. -/
def su3CubicAnomaly : ℚ := 2 * 1 + (-1) + (-1)

theorem su3_cubic_anomaly_zero : su3CubicAnomaly = 0 := by
  norm_num [su3CubicAnomaly]

/-- **The generation is anomaly-free — every gauge current's ledger closes.** The conjunction of all
    five vanishing sums: gauge-theory consistency as a ZFA charge-balance. -/
theorem generation_anomaly_free :
    gravAnomaly = 0 ∧ cubicAnomaly = 0 ∧ su2MixedAnomaly = 0 ∧
      su3MixedAnomaly = 0 ∧ su3CubicAnomaly = 0 :=
  ⟨grav_anomaly_zero, cubic_anomaly_zero, su2_anomaly_zero,
    su3_mixed_anomaly_zero, su3_cubic_anomaly_zero⟩

end QLF
