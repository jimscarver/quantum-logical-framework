import QLF_CensusWalk

set_option linter.unusedVariables false

/-!
# QLF_CensusBrownian — the closure census is a random walk (the Riemann GMC bridge, discrete side)

The substrate's closure census is, at its core, a **simple random walk**. A ZFA-balanced string of
length `2n` (`#+ = #−`) is exactly a **closed** simple-random-walk path — each twist a `±1` step,
count-balance the condition that the walk *returns to its origin* — so the census of such closures is
`C(2n,n)`, the closed-walk count, and the return density `(C(2n,n)/4ⁿ)²` is the 2-D Brownian return
probability. This module makes that Brownian reading explicit (reuse of `QLF_PhysicalPi` /
`QLF_CensusWalk`), the discrete footing under the **log-correlated-field / Gaussian-multiplicative-chaos
bridge candidate** for the Riemann critical line (`Riemann-Conjecture-Proof.md`).

* `census_is_closed_walk_count` — the ZFA closure census of length `2n` is `C(2n,n)` = the number of
  closed `2n`-step `±1` walks (reuse `closure_census`).
* `returnProb1D` — the 1-D simple-random-walk return probability `C(2n,n)/4ⁿ`.
* `returnDensity_eq_sq_1d` — the 2-D return density is **two independent 1-D Brownian returns**,
  `P₂ₙ(0) = (returnProb1D)²` — the diffusive (Brownian) structure of the census.

**Why it matters (the bridge candidate).** Balance = walk-closure is the *same* condition as the
critical line (`count_pos = count_neg ⇒ Re = 1/2`, `zfa_implies_critical_line`), so the walk returns
exactly on the critical line. Indexing the ZFA phase by *scale* with Brownian statistics is a
**log-correlated Gaussian field** (its exponential a Gaussian multiplicative chaos), and `ζ` on the
critical line is rigorously described by *exactly* these objects (Montgomery–Odlyzko GUE;
Fyodorov–Hiary–Keating; Saksman–Webb) — with QLF's **Planck floor** supplying the UV cutoff GMC
requires. **Honest scope:** this anchors the census's Brownian structure (proven); the `n^{−p/2}`
diffusive asymptotic (Wallis/Stirling) and the log-correlated/GMC correspondence to `ζ` are settled
analysis / the *bridge candidate* — they enrich the reformulation and attach a settled-math neighbour,
they do **not** prove RH (`spectral_hilbert_polya`/`MRE_bridge` stay Class-A). No new axioms. See
`Riemann-Conjecture-Proof.md`.
-/

namespace QLF.CensusBrownian

open QLF.PhysicalPi

/-- **The ZFA closure census IS the closed-walk count.** A balanced string of length `2n` is a closed
    `2n`-step `±1` walk (balance = return to origin); the census of such closures is `C(2n,n)`. -/
theorem census_is_closed_walk_count (n : ℕ) :
    (find_stable_states (2 * n)).length = Nat.choose (2 * n) n :=
  closure_census n

/-- The **1-D simple-random-walk return probability** at time `2n`: `C(2n,n)/4ⁿ` (`n` up-steps and `n`
    down-steps among `2n`, each with probability `1/2`). -/
def returnProb1D (n : ℕ) : ℚ := (Nat.choose (2 * n) n : ℚ) / (4 : ℚ) ^ n

/-- **The 2-D return density is the square of the 1-D Brownian return** — two independent axes:
    `P₂ₙ(0) = (C(2n,n)/4ⁿ)² = returnProb1D²`. The census's moving part is diffusive by construction. -/
theorem returnDensity_eq_sq_1d (n : ℕ) :
    returnDensity n = (returnProb1D n) ^ 2 := by
  unfold returnDensity returnProb1D
  rw [div_pow, ← pow_mul, Nat.mul_comm n 2]

/-- Status: the census's Brownian (random-walk) structure is anchored; the diffusive `n^{−p/2}`
    asymptotic and the log-correlated-field / GMC correspondence to `ζ` are the settled-analysis
    bridge candidate (not a proof of RH). -/
theorem census_brownian_bridge_candidate : True := trivial

end QLF.CensusBrownian
