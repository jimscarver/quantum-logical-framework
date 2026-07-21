import QLF_PhysicalPi
import Mathlib

/-!
# QLF_CensusWalk — the −p/2 spectral exponent, Lean-anchored at low orders

Strengthens `genesis.py` §2 (its one genuine derivation): the census fractal exponent `−p/2` counts
conjugate pairs, because the multi-pair census `C(2m,m)·c_pair(p,m)` is the number of closed `2m`-step
walks on `ℤ^p` (return probability `~ m^{−p/2}`). genesis.py *fits* that slope; this module anchors the
finite foundation at the low orders, tying it to results already proven in `QLF_PhysicalPi`:

* **p = 1** — `realized(1,m) = C(2m,m)` is the closure census itself (`closure_census`,
  `find_stable_states_length_even`). Already proven.
* **p = 2** — `c_pair(2,m) = Σ_{k≤m} C(m,k)² = C(2m,m)` (**Vandermonde sum-of-squares**,
  `sumChooseSq_eq_central`), so `realized(2,m) = C(2m,m)²` (`census_p2`), whose return probability
  `C(2m,m)²/16^m` **is** `QLF_PhysicalPi.returnDensity m` — the machine-checked census→π object
  (`census_p2_is_return_density`). So the p = 2 spectral exponent `−1` is the proven census→π return
  density.

**Honest scope:** only p = 1, 2 are anchored here. The general-p closed-walk identity
`C(2m,m)·c_pair(p,m) = Σ_{|j|=m}(2m)!/∏(jᵢ!)²` and the `−p/2` **asymptotic** (Wallis/Stirling) are the
structural / settled-analysis residual — the same boundary as the π convergence itself
(`QLF_PhysicalPi`). No new axioms.
-/

namespace QLF.CensusWalk

open QLF QLF.PhysicalPi

/-- genesis.py's `c_pair(2, m)`: the sum of squares of binomial coefficients. -/
def sumChooseSq (m : ℕ) : ℕ := ∑ k ∈ Finset.range (m + 1), (Nat.choose m k) ^ 2

/-- **Vandermonde sum-of-squares** — `Σ_{k≤m} C(m,k)² = C(2m,m)`. The p = 2 multi-pair census factor
    equals the central binomial. Derived from `Nat.add_choose_eq` (Vandermonde) + `Nat.choose_symm`. -/
theorem sumChooseSq_eq_central (m : ℕ) :
    sumChooseSq m = Nat.choose (2 * m) m := by
  unfold sumChooseSq
  rw [two_mul, Nat.add_choose_eq, Finset.Nat.sum_antidiagonal_eq_sum_range_succ_mk]
  refine Finset.sum_congr rfl (fun k hk => ?_)
  rw [Finset.mem_range, Nat.lt_succ_iff] at hk
  rw [Nat.choose_symm hk, pow_two]

/-- **The p = 2 multi-pair census** `realized(2,m) = C(2m,m)·c_pair(2,m) = C(2m,m)²`. -/
theorem census_p2 (m : ℕ) :
    Nat.choose (2 * m) m * sumChooseSq m = (Nat.choose (2 * m) m) ^ 2 := by
  rw [sumChooseSq_eq_central, pow_two]

/-- **The p = 2 census ratio IS the proven π return density.** genesis.py's p = 2 return probability
    `realized(2,m)/16^m` equals `QLF_PhysicalPi.returnDensity m = (C(2m,m)/4ᵐ)²` — the census→π object. -/
theorem census_p2_is_return_density (m : ℕ) :
    returnDensity m = ((Nat.choose (2 * m) m * sumChooseSq m : ℕ) : ℚ) / (4 : ℚ) ^ (2 * m) := by
  simp only [returnDensity]
  rw [census_p2]
  push_cast
  ring

/-- **The p = 1 census** `realized(1,m) = C(2m,m)` is the closure census (reuse `closure_census`). -/
theorem census_p1 (m : ℕ) :
    (find_stable_states (2 * m)).length = Nat.choose (2 * m) m :=
  closure_census m

/-- **Status — genesis.py §2 anchored at p = 1, 2.** p = 1 is the closure census; p = 2 is the proven
    π return density (`census_p2_is_return_density`). The general-p closed-walk identity and the `−p/2`
    asymptotic stay the structural / Wallis residual. No new axioms. See `Genesis.md`, `Physical_Pi.md`. -/
theorem census_walk_summary : True := trivial

end QLF.CensusWalk
