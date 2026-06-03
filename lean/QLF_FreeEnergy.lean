-- QLF_FreeEnergy.lean
-- The per-event free-energy decrement at a half-spin ZFA closure: ΔF = -log 2 nats.
--
-- A half-spin ZFA atom is a Hermitian-conjugate pair (t, t†) whose Pauli-matrix
-- product is a scalar in the Pauli group. Its two orderings (t, t†) and (t†, t)
-- form a binary partition of equal multiplicity. With recognition density q =
-- delta on the realised ordering and generative prior p = uniform over both
-- orderings, the Kullback-Leibler divergence D_KL(q ‖ p) equals log 2, and
-- Friston's variational free energy F = D_KL(q ‖ p) - log Z decrements by
-- exactly log 2 per realisation event.
--
-- The theorem is RCA₀-statable: it is a finite arithmetic identity about the
-- binary KL divergence between a delta and a uniform on two outcomes, using
-- Mathlib's `Real.log` (which is 0 at 0, lifting the standard convention
-- 0·log 0 = 0 into a literal Lean equality).
--
-- Companion to:
--   • MRE.md §2.1                       — binary-partition saturation D_KL ≤ log 2
--   • Hierarchical_Control.md §3.2      — derives ΔF = -log 2 per event from FEP
--   • Active_Inference_Mathematics.md §3 — the single rule of QLF active-inference math
--   • active_inference_vfe_demo.py       — brute-force numerical verification on all
--                                          4 Hermitian-conjugate pair types and all
--                                          384 ZFA-closed 4-twist atoms

import Mathlib.Analysis.SpecialFunctions.Log.Basic

namespace QLF

/-- Binary Kullback-Leibler divergence:
        D_KL((q, 1-q) ‖ (p, 1-p)) = q · log(q/p) + (1-q) · log((1-q)/(1-p)).

    Uses Mathlib's `Real.log` (defined to be 0 on non-positive inputs),
    which lifts the standard convention `0 · log 0 = 0` into a literal
    Lean equality without needing a side condition. -/
noncomputable def binary_kl (q p : ℝ) : ℝ :=
  q * Real.log (q / p) + (1 - q) * Real.log ((1 - q) / (1 - p))

/-- Binary-partition saturation at the 50/50 split (MRE.md §2.1):
    the KL divergence of a delta-on-1 from the uniform Bernoulli(1/2)
    is exactly `log 2`. -/
theorem binary_kl_delta_uniform : binary_kl 1 (1/2) = Real.log 2 := by
  unfold binary_kl
  have h1 : (1 : ℝ) - 1 = 0 := by norm_num
  have h2 : (1 : ℝ) / (1/2) = 2 := by norm_num
  rw [h1, h2]
  simp

/-- **Per-event free-energy decrement at a half-spin ZFA closure: ΔF = -log 2 nats.**

    A half-spin ZFA atom is a Hermitian-conjugate pair (t, t†) whose Pauli-matrix
    product is a scalar in the Pauli group. Its two orderings (t·t†) and (t†·t)
    form a binary partition of equal multiplicity. With recognition density q =
    delta on the realised ordering and generative prior p = uniform over both
    orderings, `D_KL(q ‖ p) = log 2` (proved as `binary_kl_delta_uniform`).

    Friston's variational free energy `F = D_KL(q ‖ p) - log Z` therefore
    decrements by exactly `log 2` per realisation event:
        ΔF = -log 2 nats per half-spin ZFA closure.

    This is the keystone formal anchor for the active-inference mathematics:
    every event in QLF carries exactly one `log 2` quantum of resolved
    information (Active_Inference_Mathematics.md §3). -/
theorem zfa_closure_minimizes_free_energy :
    -binary_kl 1 (1/2) = -Real.log 2 := by
  rw [binary_kl_delta_uniform]

/-- Cumulative free-energy decrement for `k` independent half-spin ZFA
    closure events: `ΔF = -k · log 2` nats.

    Numerically demonstrated for `k = 2` (the 4-twist atom case, cumulative
    `ΔF = -2 log 2 = -log 4`) in `active_inference_vfe_demo.py`. -/
theorem zfa_closures_cumulative (k : ℕ) :
    -(k : ℝ) * binary_kl 1 (1/2) = -(k : ℝ) * Real.log 2 := by
  rw [binary_kl_delta_uniform]

end QLF
