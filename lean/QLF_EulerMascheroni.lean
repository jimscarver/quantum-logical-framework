-- QLF_EulerMascheroni.lean
-- The Euler-Mascheroni constant γ ≈ 0.5772156649 from QLF substrate:
-- the harmonic-excess identity over the ZFA-stable closure ensemble.
--
-- QLF reading (Experimental_Consistency.md §6.2): γ emerges as the
-- harmonic excess of the ordered stable-closure ensemble — the
-- difference between the N-th harmonic sum and the natural log of N
-- in the limit N → ∞:
--
--   γ_QLF  =  lim (N → ∞) (H_N − ln N)
--
-- where H_N = ∑_{k=1}^N 1/k.  The numerical demonstration in
-- `constants_mapper.emerge_gamma()` converges to Euler's γ at 0.017%
-- relative error over composed ZFA-stable ensembles at N ≈ 5000.
--
-- This module Lean-anchors the structural form: the harmonic sum H_N,
-- the harmonic excess H_N − ln N, and γ_QLF as the limit identifier.
--
-- Honest scope: this module Lean-verifies definitional and small-N
-- structural arithmetic.  The full convergence proof (Tendsto with
-- monotone-bounded sequence) is a standard real-analysis result
-- deferred to a future module when Mathlib's Euler-Mascheroni API
-- lands or local convergence machinery is added.  Numerical
-- demonstration is in `constants_mapper.py`.
--
-- This is the **third Lean-anchored fundamental constant** in the QLF
-- tree (after α in QLF_FineStructureSubstrate.lean and m_p/m_e in
-- QLF_LenzMassRatio.lean).  Brings the constants-from-substrate
-- program to three constants: α, m_p/m_e, γ.
--
-- Companion to:
--   • Experimental_Consistency.md §6.2                    — harmonic-excess γ derivation
--   • constants_mapper.py emerge_gamma()                  — numerical demo, 0.017% at N≈5000
--   • lean/QLF_FineStructureSubstrate.lean                — α sibling
--   • lean/QLF_LenzMassRatio.lean                         — m_p/m_e sibling

import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Algebra.BigOperators.Group.Finset

namespace QLF

open Finset

/-- **N-th harmonic sum** `H_N = ∑_{k=1}^N (1/k)`.

    The standard mathematical harmonic sum.  In the QLF context, this
    counts the cumulative weighting of ZFA-stable closures of the
    ordered ensemble at depth N. -/
noncomputable def harmonic (N : ℕ) : ℝ :=
  ∑ k in range N, 1 / ((k : ℝ) + 1)

/-- **Harmonic excess at N**: `H_N − ln N`.

    The departure of the N-th harmonic sum from the natural-log of N.
    This is the substrate observable from which γ is read off.  At
    finite N it converges to Euler's γ ≈ 0.5772 with leading-order
    correction 1/(2N) (Euler-Maclaurin).

    The QLF reading: in the limit N → ∞, the ZFA-stable closure
    ensemble's harmonic excess saturates the universal constant γ. -/
noncomputable def harmonic_excess (N : ℕ) : ℝ :=
  harmonic N - Real.log (N : ℝ)

/-- **γ_QLF**: the Euler-Mascheroni constant identified as the limit
    of the harmonic-excess sequence.

    γ_QLF  =  lim_{N → ∞} (H_N − ln N)  ≈  0.5772156649

    Defined here as a noncomputable real numerical literal matching
    the standard mathematical value.  The structural identity that
    ties this value to the harmonic-excess limit is the convergence
    theorem `lim (H_N − ln N) = γ_QLF`, which is a standard real-
    analysis result (monotone bounded sequence).  Numerical
    demonstration via constants_mapper.emerge_gamma() at N ≈ 5000
    gives the value to 0.017% relative error. -/
noncomputable def gamma_QLF : ℝ := 0.5772156649

/-- **Harmonic excess is definitionally `H_N − ln N`**.

    Trivial structural identity: the harmonic excess at any N is the
    harmonic sum minus the log of N.  This anchors the substrate
    observable in Lean. -/
theorem harmonic_excess_def (N : ℕ) :
    harmonic_excess N = harmonic N - Real.log (N : ℝ) := rfl

/-- **Harmonic sum at N=0**: `H_0 = 0` (empty sum). -/
theorem harmonic_zero : harmonic 0 = 0 := by
  unfold harmonic
  simp

/-- **Harmonic sum at N=1**: `H_1 = 1`. -/
theorem harmonic_one : harmonic 1 = 1 := by
  unfold harmonic
  simp

/-- **Harmonic excess at N=1**: `1 − ln 1 = 1`.

    The first nontrivial substrate observable. -/
theorem harmonic_excess_one : harmonic_excess 1 = 1 := by
  unfold harmonic_excess
  rw [harmonic_one]
  simp [Real.log_one]

/-- **γ_QLF equals the standard Euler-Mascheroni numerical value**. -/
theorem gamma_QLF_value : gamma_QLF = 0.5772156649 := rfl

/-- **Structural identity for γ_QLF**: it is by definition the
    Euler-Mascheroni constant, identified via the harmonic-excess
    limit.

    Conjunction of the value identity and the harmonic-excess
    formulation.  The convergence `lim (H_N − ln N) = γ_QLF` is a
    standard real-analysis result (monotone bounded sequence); the
    explicit Lean convergence proof is deferred to a future revision
    of this module. -/
theorem gamma_QLF_structural :
    gamma_QLF = 0.5772156649 ∧
    (∀ N : ℕ, harmonic_excess N = harmonic N - Real.log (N : ℝ)) := by
  exact ⟨gamma_QLF_value, harmonic_excess_def⟩

end QLF
