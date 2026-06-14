import QLF_GMinusTwo

set_option linter.unusedVariables false

/-!
# QLF_MuonG2 — placing the muon `g−2`: leading term derived, the "anomaly" localized

The muon anomalous magnetic moment `a_μ = (g−2)/2` is famous for a ~5σ *data-driven* discrepancy
with the Standard Model. QLF places it honestly.

**The leading term is QLF's, and it is universal.** The dominant contribution is the Schwinger
term `a_μ = α/(2π)` — exactly the same as the electron's (`a_e_QLF = α/2π`, `QLF_GMinusTwo`),
because the one-loop QED vertex is **mass-independent**. So QLF derives `a_μ ≈ α/2π ≈ 1.1617×10⁻³`
to the same ~0.6% as `a_e`, with **lepton universality** of the leading anomaly
(`a_mu_leading_eq_a_e`).

**Why the muon is the sensitive probe.** Everything beyond the universal QED part is
*mass-dependent*, and the muon is heavy: its sensitivity to **hadronic vacuum-polarization** loops
is amplified by `(m_μ/m_e)² ≈ 42753` (`hadronic_sensitivity`). That is *why* a hadronic-sector
discrepancy shows up for the muon and is invisible in the (far better measured) electron. The
discrepancy lives **entirely** in the hadronic contributions — dominated by the `ππ`/`ρ` channel,
i.e. the **pion**, which in QLF is the lightest hadron / deepest hadronic horizon
(`QLF_QuantumBlackHole`, `QLF_PionMassRatio`).

**The honest status of the "anomaly."** It is **not settled.** The discrepancy size depends on the
hadronic-vacuum-polarization input: the *data-driven* `e⁺e⁻` value gives ~5σ, but the *lattice*
(BMW 2020) and the CMD-3 measurement shrink it toward ~1σ. The field has been converging away from
a clear anomaly. So QLF makes **no claim to "explain" a new-physics anomaly** — it identifies the
residual as the hadronic-vacuum-polarization sector, which is (a) QLF's own open hadronic
quantitative frontier (no quark masses, no `f_π`; `pion_mass_ratio_in_progress`) and (b)
experimentally in flux.

## Honest scope

Anchored: the leading `a_μ = α/2π` (universal, ~0.6%, reusing `QLF_GMinusTwo`) and the
`(m_μ/m_e)²` hadronic-sensitivity amplification that explains the muon's role. **Not** derived: the
hadronic-vacuum-polarization contribution `a_μ^HVP` and hence the discrepancy — the open hadronic
sector, on a question that is itself experimentally unresolved (`muon_g2_in_progress`). See
`g_minus_2.md`.
-/

namespace QLF

/-- **Leading muon anomalous moment** = the universal Schwinger term `α/(2π)`. -/
noncomputable def a_mu_leading : ℝ := alpha_QLF / (2 * Real.pi)

/-- **Lepton universality of the leading anomaly**: `a_μ` and `a_e` share `α/2π` at leading order
    (the one-loop QED vertex is mass-independent). -/
theorem a_mu_leading_eq_a_e : a_mu_leading = a_e_QLF := by
  unfold a_mu_leading
  rw [a_e_QLF_eq_schwinger]

/-- Muon/electron mass ratio (PDG `206.7683`). -/
noncomputable def muon_electron_ratio : ℝ := 206.7682830

/-- **Hadronic-sensitivity amplification** `(m_μ/m_e)²` — the muon is this many times more
    sensitive to hadronic vacuum-polarization loops than the electron. -/
noncomputable def hadronic_sensitivity : ℝ := muon_electron_ratio ^ 2

/-- **`(m_μ/m_e)² ≈ 42753`** — ~43000× amplification: why the hadronic discrepancy is a *muon*
    effect, invisible in the electron. -/
theorem hadronic_sensitivity_value :
    42000 < hadronic_sensitivity ∧ hadronic_sensitivity < 43000 := by
  unfold hadronic_sensitivity muon_electron_ratio
  constructor <;> norm_num

/-- **Established constructively:** the leading muon moment is the universal Schwinger term
    `a_μ = α/2π = a_e` (`a_mu_leading_eq_a_e`, ~0.6% via `QLF_GMinusTwo`), and the muon's
    `(m_μ/m_e)² ≈ 42753` amplification (`hadronic_sensitivity_value`) is *why* the hadronic
    discrepancy is a muon effect. **Open / unsettled:** the hadronic-vacuum-polarization
    contribution `a_μ^HVP` (QLF's open hadronic sector — pion-dominated, `QLF_PionMassRatio`) and
    hence the discrepancy itself, whose experimental size is in flux (data-driven ~5σ vs
    lattice/CMD-3 ~1σ) — QLF claims no new-physics anomaly (`muon_g2_in_progress`). -/
theorem muon_g2_in_progress : True := trivial

end QLF
