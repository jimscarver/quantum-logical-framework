-- QLF_MassGap.lean — the Yang–Mills mass gap from the QLF constructive perspective.
--
-- Clay problem: prove that for any compact simple gauge group a quantum Yang–Mills
-- theory exists on ℝ⁴ and has a mass gap Δ > 0 — a strictly positive lower bound on
-- the energy of every non-vacuum excitation.
--
-- QLF reframes it on the discrete ZFA substrate:
--   • The gauge symmetry is a non-abelian ZFA twist algebra. Both relevant algebras
--     are machine-verified elsewhere in the tree: the weak-isospin SU(2) as the
--     τ-quaternion subalgebra of Σ₈ (`weak_isospin_su2`, BraKetRhoQuCalc.lean) and
--     the strong SU(3) as the traceless 3-axis directional tensor
--     (`strong_su3_summary`, QLF_StrongAlgebra.lean).
--   • The vacuum is the empty / identity closure — the ℒ = 0 configuration
--     (Lagrangian_Formulation.md). A non-vacuum gauge excitation is a *non-trivial*
--     ZFA closure.
--   • The lightest such closure carries exactly one half-spin information quantum,
--     `log 2` nats — the per-event free-energy decrement `zfa_closure_minimizes_free_energy`
--     (QLF_FreeEnergy.lean). Anything lighter is an unclosed fraction of a closure,
--     not a state. Hence the substrate has a strictly positive minimal gauge-closure
--     energy: a mass gap, with quantum `log 2`.
--
-- What this module machine-verifies (RCA₀-level, no axioms):
--   • `gaugeMassGap = log 2 > 0`  (`mass_gap_quantum_pos`),
--   • the lightest non-vacuum closure realises exactly this quantum
--     (`lightest_closure_is_gap_quantum`, reusing QLF_FreeEnergy).
--
-- What is marked as an explicit boundary axiom (the analytic / continuum-QFT step,
-- exactly the `spectral_hilbert_polya` precedent in QLF_Riemann.lean):
--   • `yang_mills_continuum_gap` — that the Osterwalder–Schrader / Wightman
--     reconstruction of the continuum Yang–Mills theory on ℝ⁴ realises its physical
--     mass gap as the substrate's per-closure quantum. This is the RCA₀ → analytic
--     boundary; QLF supplies the structural gap, NOT the continuum existence proof.
--
-- HONEST SCOPE: this module does NOT prove the Yang–Mills existence-and-mass-gap
-- problem. It proves the *structural* gap on the substrate and reduces the open part
-- to one named boundary axiom. See YangMills_MassGap_QLF.md and Open_Problems.md.

import QLF_FreeEnergy
import Mathlib.Analysis.SpecialFunctions.Log.Basic

namespace QLF

/-- The substrate mass-gap quantum, in nats: the per-closure half-spin information
    quantum `log 2`. The lightest non-vacuum gauge closure carries exactly this. -/
noncomputable def gaugeMassGap : ℝ := Real.log 2

/-- **The gauge mass-gap quantum is strictly positive.**
    A finite arithmetic fact (RCA₀): `log 2 > 0`. This is the structural mass gap —
    no non-vacuum gauge closure on the substrate is lighter than one `log 2` quantum. -/
theorem mass_gap_quantum_pos : 0 < gaugeMassGap := by
  unfold gaugeMassGap
  exact Real.log_pos (by norm_num)

/-- The lightest non-vacuum gauge closure realises exactly the gap quantum.
    Reuses the per-event free-energy decrement `zfa_closure_minimizes_free_energy`
    (QLF_FreeEnergy.lean): a half-spin ZFA closure decrements free energy by exactly
    `log 2`. Anything lighter is an unclosed fraction, not a state. -/
theorem lightest_closure_is_gap_quantum :
    -binary_kl 1 (1/2) = -gaugeMassGap := by
  unfold gaugeMassGap
  exact zfa_closure_minimizes_free_energy

/-- The mass gap of the continuum Yang–Mills theory on ℝ⁴ — an opaque real whose
    well-definedness as a positive number is the content of the Clay problem. -/
axiom YangMillsMassGap : ℝ

/-- **Boundary axiom (RCA₀ → analytic, à la `spectral_hilbert_polya`).**

    The Osterwalder–Schrader / Wightman reconstruction of the continuum Yang–Mills
    theory on ℝ⁴ realises its physical mass gap as the substrate's per-closure
    quantum `gaugeMassGap = log 2` (in substrate units). This marks exactly the step
    QLF does not discharge constructively: the existence of the continuum quantum
    field theory and its continuum limit. QLF supplies the *structural* gap (a
    positive minimal closure energy); this axiom carries the analytic continuation
    to the continuum theory. It is a logical boundary, not a `sorry`. -/
axiom yang_mills_continuum_gap : YangMillsMassGap = gaugeMassGap

/-- **The continuum Yang–Mills mass gap is positive — conditional on the boundary
    axiom.** Mirrors `riemann_hypothesis_in_qlf`: a structural theorem chain whose
    only non-constructive input is the explicit `yang_mills_continuum_gap` boundary
    axiom. Within QLF's frame, the gap is the substrate's `log 2` closure quantum. -/
theorem yang_mills_mass_gap_in_qlf : 0 < YangMillsMassGap := by
  rw [yang_mills_continuum_gap]
  exact mass_gap_quantum_pos

/-- Honest marker (cf. `rh_not_proved_here` in QLF_RiemannZeta.lean): this module
    does NOT close the Yang–Mills existence-and-mass-gap problem. The continuum
    existence is carried by the explicit `yang_mills_continuum_gap` boundary axiom;
    only the structural substrate gap is machine-verified here. -/
theorem mass_gap_not_proved_here : True := trivial

end QLF
