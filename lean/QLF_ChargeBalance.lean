import QLF_ChargeCensus

set_option linter.unusedVariables false

/-!
# QLF_ChargeBalance — anomaly cancellation is a ZFA charge-balance: `Σ Q = 0` per generation

`QLF_ChargeCensus` summed the *squared* charges (`Σ Nᶜ Q_f² = 8 = 2³`, the running weight). The
*signed* sum is the complementary fact, and it is a substrate balance: **a complete Standard-Model
generation is electrically neutral** — `Σ Q = 0` — because electric charge is a **signed twist count**
(`QLF_BMinusL`: `charge = signed_count`, conserved and zero on every ZFA closure), so a generation's
charge ledger *closes*. What particle physics calls **anomaly cancellation / matter neutrality** is,
on the substrate, the ZFA charge-balance condition (`Σ_pos = Σ_neg`).

## The balance

With QLF's derived charges — neutrino `0` (`neutrino_neutral`), charged lepton `−1` (unit winding),
quarks `+2/3` / `−1/3` (thirds forced by the 3 colours, `QLF_QuarkStructure`) — and quarks counted
with their 3 colours, one generation sums to

  `Σ Q = 0 + (−1) + 3·(2/3) + 3·(−1/3) = 0 + (−1) + 2 + (−1) = 0`  (`gen_electric_neutral`).

This is **not** a trivial `0 = 0`: the positive charge (`up-type +2`) balances the negative
(`charged-lepton + down-type = −2`), `2 = 2` (`gen_charge_balanced`, `genPositiveCharge_eq_two`) — the
`+2/3` and `−1/3` thirds are *exactly* what makes the ledger close, so the three colours (which force
the thirds) are what make matter neutral. Concrete closures: the proton `uud = +1`
(`proton_charge_one`), the neutron `udd = 0` (`neutron_charge_zero`), and the hydrogen atom
`proton + electron = 0` (`hydrogen_neutral`).

## Honest scope

This anchors the **electric-charge** anomaly / neutrality balance (`Σ Q = 0`) as ZFA charge-closure —
the substrate reading of why matter is neutral and the electromagnetic gauge theory is anomaly-free.
The *full* set of Standard-Model anomaly conditions (the hypercharge `Σ Y`, `Σ Y³`, the mixed
`SU(2)²·Y`, `SU(3)²·Y`, and gravitational `Σ Y` anomalies) is the broader statement; those need the
hypercharge assignments, tracked with the electroweak sector (`QLF_WeinbergAngle`/`QLF_SU5`). Reuses
`QLF_ChargeCensus`; no new axioms. See `QLF_BMinusL`, `Quarks.md`, `Standard_Model.md`.
-/

namespace QLF

/-! ### QLF-derived electric charges -/

/-- Neutrino charge `0` (`QLF_Spin.neutrino_neutral`). -/
def chargeNu : ℚ := 0
/-- Charged-lepton charge `−1` (unit twist winding). -/
def chargeE : ℚ := -1
/-- Up-type quark charge `+2/3` (`QLF_QuarkStructure`, thirds from the 3 colours). -/
def chargeU : ℚ := 2 / 3
/-- Down-type quark charge `−1/3` (`QLF_QuarkStructure.down_quark_charge_third`). -/
def chargeD : ℚ := -1 / 3

/-! ### One generation is electrically neutral -/

/-- The electric charge of one complete generation (all fermions, quarks with their 3 colours):
    `ν + e + 3u + 3d`. -/
def genElectricCharge : ℚ := chargeNu + chargeE + 3 * chargeU + 3 * chargeD

/-- **A complete generation is electrically neutral — `Σ Q = 0`.** Electric charge is a signed twist
    count (`QLF_BMinusL`), so a generation's charge ledger is ZFA-balanced (`Σ_pos = Σ_neg`): anomaly
    cancellation / neutrality *is* charge closure. -/
theorem gen_electric_neutral : genElectricCharge = 0 := by
  norm_num [genElectricCharge, chargeNu, chargeE, chargeU, chargeD]

/-- The total positive charge in a generation (up-type, `3·(2/3)`). -/
def genPositiveCharge : ℚ := 3 * chargeU
/-- The total negative charge in a generation (charged lepton + down-type, `−1 + 3·(−1/3)`). -/
def genNegativeCharge : ℚ := chargeE + 3 * chargeD

/-- The positive charge in a generation is `+2`. -/
theorem genPositiveCharge_eq_two : genPositiveCharge = 2 := by
  norm_num [genPositiveCharge, chargeU]

/-- The negative charge in a generation is `−2`. -/
theorem genNegativeCharge_eq_neg_two : genNegativeCharge = -2 := by
  norm_num [genNegativeCharge, chargeE, chargeD]

/-- **The balance is `+2 = −(−2)`, not a trivial `0 = 0`** — the up-type `+2` cancels the
    charged-lepton-plus-down-type `−2`, so the quark thirds are what close the ledger. -/
theorem gen_charge_balanced : genPositiveCharge + genNegativeCharge = 0 := by
  rw [genPositiveCharge_eq_two, genNegativeCharge_eq_neg_two]; norm_num

/-! ### Concrete closures — proton, neutron, hydrogen -/

/-- Proton charge `uud = 2·(2/3) + (−1/3) = +1`. -/
def protonCharge : ℚ := 2 * chargeU + chargeD
/-- Neutron charge `udd = (2/3) + 2·(−1/3) = 0`. -/
def neutronCharge : ℚ := chargeU + 2 * chargeD

theorem proton_charge_one : protonCharge = 1 := by
  norm_num [protonCharge, chargeU, chargeD]

theorem neutron_charge_zero : neutronCharge = 0 := by
  norm_num [neutronCharge, chargeU, chargeD]

/-- **The hydrogen atom is neutral** — `proton (uud) + electron = 0`, the atomic-scale charge
    closure that makes stable matter possible. -/
theorem hydrogen_neutral : protonCharge + chargeE = 0 := by
  rw [proton_charge_one, chargeE]; norm_num

end QLF
