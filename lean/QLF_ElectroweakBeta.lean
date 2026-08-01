import QLF_AnomalyCancellation
import QLF_BetaFunction

set_option linter.unusedVariables false

/-!
# QLF_ElectroweakBeta — the three one-loop β-coefficients from the substrate counts

`QLF_BetaFunction` fixed the QCD coefficient `b₀ = 7` from `N_c = 3` (axes) and `n_f = 6` (3 gens ×
2 flavours). This module extends that to the **full Standard-Model triple** `(b_1, b_2, b_3)` — the
one-loop β-coefficients that govern the running of the electroweak and strong couplings and drive the
`sin²θ_W` flow from the unification value `3/8` (`QLF_WeinbergAngle`) down toward its `M_Z` value.

## The coefficients from QLF counts + standard one-loop factors

In the Georgi–Quinn–Weinberg convention `b_i = −(11/3)·C₂(G_i) + (2/3)·Σ_Weyl T(r_f) +
(1/3)·Σ_scalar T(r_s)`, every *count* is a QLF substrate fact and only the universal one-loop
weights `11/3, 2/3, 1/3` (and the SU(5) GUT normalization `3/5` for U(1)) are standard group theory —
the same division of labour as `QLF_BetaFunction`'s `b₀ = 7`:

* **`b₃ = −7`** (`b3_eq`) — `C₂(SU(3)) = N_c = 3` (colours = axes), `Σ_Weyl T = 6` (6 quark
  flavours × 2 Weyl × `T(fund)=½`). `−11 + 4 = −7`. This is `QLF_BetaFunction`'s `b₀ = 7` in the
  opposite (AF-positive) sign convention — `neg_b3_eq_qcd` (`−b₃ = 7`).
* **`b₂ = −19/6`** (`b2_eq`) — `C₂(SU(2)) = 2`, `Σ_Weyl T = 6` (3 gens × 4 left-doublets × `½`:
  the colour-triplet quark doublet counts 3, the lepton doublet 1), plus the **one Higgs doublet**
  `T = ½`. `−22/3 + 4 + 1/6 = −19/6`.
* **`b₁ = 41/10`** (`b1_eq`) — `C₂(U(1)) = 0`, `Σ_Weyl Y² = 3·(10/3) = 10` over the 15 fermions
  (`hyperSqPerGen = 10/3`, from the QLF hypercharges `Y = Q − T₃`, reusing `QLF_AnomalyCancellation`),
  plus the Higgs `Σ Y² = 1/2`, all GUT-normalized by `3/5`: `(3/5)·(2/3·10 + 1/6) = (3/5)·(41/6) =
  41/10`.

So the SM's three β-coefficients `(41/10, −19/6, −7)` follow from the substrate counts (colours,
generations, the 15 hypercharges, one Higgs doublet) and the universal one-loop weights — value-free,
no fitting. `b₃` reproduces `QLF_BetaFunction` exactly.

## `sin²θ_W` running

The one-loop running is `1/α_i(μ) = 1/α_i(μ₀) + (b_i/2π)·ln(μ/μ₀)` (`QLF_RunningCouplings.inv_coupling`,
the `2π` loop phase). The weak mixing angle starts at the unification value `sin²θ_W = 3/8`
(`QLF_WeinbergAngle.sin2_weinberg_substrate_eq`, the SU(5) normalization = the substrate `3/8` split)
and runs down; the flow is driven by the differential coefficient `b₁ − b₂ > 0` (`b1_minus_b2_pos`) —
U(1) screens (`b₁ > 0`) while SU(2) is asymptotically free (`b₂ < 0`), so `α₁` and `α₂` separate and
`sin²θ_W` decreases from `3/8` toward the observed `≈ 0.231`.

## Honest scope

The **coefficients** `(b_1, b_2, b_3)` are anchored from QLF counts + standard one-loop factors (the
`QLF_BetaFunction` posture), and the running **structure** (logarithmic, `2π` phase, the `b₁−b₂`
driver, the `3/8` start) is fixed. The **value** `sin²θ_W(M_Z) = 0.231` is **not** derived here: it
needs the **unification / GUT scale** and the `α_i` inputs — the absolute-scale sector (frontier #1,
the open coupling `g`/`v`), over which the log runs. The SM's famous *non-exact* one-loop unification
(the couplings nearly but not quite meet without SUSY) is reproduced at the coefficient level. So this
is the electroweak analogue of `QLF_BetaFunction`: counts derived, scale open
(`electroweak_beta_in_progress`). Reuses `QLF_AnomalyCancellation` + `QLF_BetaFunction`; no new axioms.
See `Weak_Force.md` §6, `TheContinuum.md` §3.1, `Alpha.md` §4a.
-/

namespace QLF

/-! ### The substrate counts and standard one-loop weights -/

/-- Quadratic Casimir `C₂(SU(3)) = N_c = 3` (colours = the 3 axes). -/
def C2_SU3 : ℚ := 3
/-- Quadratic Casimir `C₂(SU(2)) = 2`. -/
def C2_SU2 : ℚ := 2

/-- SU(3) Weyl Dynkin sum `Σ T = 6`: 6 quark flavours × 2 Weyl × `T(fund) = ½` (= `n_f`). -/
def weylT_SU3 : ℚ := 6
/-- SU(2) Weyl Dynkin sum `Σ T = 6`: 3 generations × 4 left-doublets (3 colour + 1 lepton) × `½`. -/
def weylT_SU2 : ℚ := 6
/-- The single Higgs doublet's SU(2) Dynkin index `T(fund) = ½`. -/
def higgsT_SU2 : ℚ := 1 / 2
/-- The Higgs doublet's hypercharge-squared sum `Σ Y² = 2·(1/2)² = 1/2` (two components, `Y = ½`). -/
def higgsY2 : ℚ := 2 * (1 / 2) ^ 2

/-- **Per-generation hypercharge-squared census** `Σ_Weyl Y² = 10/3`, from the QLF hypercharges
    `Y = Q − T₃` (reusing `QLF_AnomalyCancellation`): `6·Y_Q² + 3·Y_uc² + 3·Y_dc² + 2·Y_L² + Y_ec²`. -/
def hyperSqPerGen : ℚ := 6 * Y_Q ^ 2 + 3 * Y_uc ^ 2 + 3 * Y_dc ^ 2 + 2 * Y_L ^ 2 + 1 * Y_ec ^ 2

theorem hyperSqPerGen_eq : hyperSqPerGen = 10 / 3 := by
  norm_num [hyperSqPerGen, Y_Q, Y_uc, Y_dc, Y_L, Y_ec]

/-- Total fermionic `Σ_Weyl Y² = 3·(10/3) = 10` over the 3 generations. -/
def weylY2 : ℚ := 3 * hyperSqPerGen

theorem weylY2_eq : weylY2 = 10 := by
  unfold weylY2; rw [hyperSqPerGen_eq]; norm_num

/-! ### The three β-coefficients (Georgi–Quinn–Weinberg convention) -/

/-- `b₃ = −(11/3)·C₂(SU3) + (2/3)·Σ_Weyl T`. -/
def b3 : ℚ := -(11 / 3) * C2_SU3 + (2 / 3) * weylT_SU3
/-- `b₂ = −(11/3)·C₂(SU2) + (2/3)·Σ_Weyl T + (1/3)·T(Higgs)`. -/
def b2 : ℚ := -(11 / 3) * C2_SU2 + (2 / 3) * weylT_SU2 + (1 / 3) * higgsT_SU2
/-- `b₁ = (3/5)·[(2/3)·Σ_Weyl Y² + (1/3)·Σ_Higgs Y²]` (SU(5) GUT normalization). -/
def b1 : ℚ := (3 / 5) * ((2 / 3) * weylY2 + (1 / 3) * higgsY2)

/-- **`b₃ = −7`** — the QCD coefficient, from `C₂ = 3` (axes) and `Σ_Weyl T = 6`. -/
theorem b3_eq : b3 = -7 := by norm_num [b3, C2_SU3, weylT_SU3]

/-- **`b₂ = −19/6`** — the SU(2)_L coefficient (asymptotically free). -/
theorem b2_eq : b2 = -19 / 6 := by norm_num [b2, C2_SU2, weylT_SU2, higgsT_SU2]

/-- **`b₁ = 41/10`** — the GUT-normalized U(1)_Y coefficient (screening). -/
theorem b1_eq : b1 = 41 / 10 := by
  unfold b1; rw [weylY2_eq]; norm_num [higgsY2]

/-- **`b₃` reproduces `QLF_BetaFunction`'s `b₀ = 7`** (opposite sign convention: AF-positive). -/
theorem neg_b3_eq_qcd : -b3 = 7 := by rw [b3_eq]; norm_num

/-- The SM's one-loop β triple, all from substrate counts + standard weights. -/
theorem sm_beta_triple : b1 = 41 / 10 ∧ b2 = -19 / 6 ∧ b3 = -7 :=
  ⟨b1_eq, b2_eq, b3_eq⟩

/-! ### The `sin²θ_W` running driver -/

/-- **The `sin²θ_W`-running driver `b₁ − b₂ > 0`** — U(1) screens (`b₁ > 0`), SU(2) is asymptotically
    free (`b₂ < 0`), so `α₁` and `α₂` separate toward the IR and `sin²θ_W` runs *down* from the
    unification value `3/8`. -/
theorem b1_minus_b2_pos : 0 < b1 - b2 := by
  rw [b1_eq, b2_eq]; norm_num

/-- `b₁ > 0` (U(1) not asymptotically free — screening). -/
theorem b1_pos : 0 < b1 := by rw [b1_eq]; norm_num
/-- `b₂ < 0` (SU(2) asymptotically free). -/
theorem b2_neg : b2 < 0 := by rw [b2_eq]; norm_num
/-- `b₃ < 0` (SU(3) asymptotically free — confinement in the IR). -/
theorem b3_neg : b3 < 0 := by rw [b3_eq]; norm_num

end QLF
