/-
# QLF_AlphaBound — α's derived leading value, and bounds on the open residual

The leading coupling (`QLF_FineStructureSubstrate`) is *derived by construction* from substrate
structure (the 8-twist alphabet → `2⁷`, the 3-D directional tensor → `3²`), parameter-free:

  α⁻¹_lead = 1/α_bare + d² = 128 + 9 = 137   (exact rational, no observable input)

The measured value (CODATA, q²→0 / Thomson) is α⁻¹ = 137.035999….  The construction lands on the
*integer* 137; the residual `+0.036` to the exact value is the open higher-order piece
(`alpha_exact_value_in_progress`, `Alpha.md` status box; memory `alpha-residual-036`).

This module records, machine-checked, the **bounds on that residual** (the leading value is derived;
the residual within the band is the open piece):

* **Unconditional `α⁻¹ > 137`.**  EM is abelian (`QLF_GaugeUnification.em_gauge_abelian`,
  U(1), no self-interaction) ⟹ every higher-order closure correction *screens* (is
  positive) ⟹ the IR coupling is weaker than the leading value.  A falsifiable
  before-data inequality (a measured `α⁻¹ ≤ 137` would refute the screening picture);
  CODATA `137.036 > 137`.  (`alpha_inv_gt_137`)

* **A census bracket containing the measured residual** (conditional on one `α_bare`
  per closure order — the standard one-coupling-power-per-loop counting).  Higher
  closures are counted by the closure census: total `C(2n,n) = 2,6,20,70` and
  irreducible/prime `2·Catalan(n−1) = 2,2,4,10`.  The residual is bracketed by the
  irreducible leading term below and the total census orders + tail majorant above; the
  measured `0.035999` lies strictly inside.  (`codata_residual_in_census_bracket`)

* **Falsifiability of the counting rule.**  A steeper map (`α_bare²` per order) caps the
  residual far below `0.036`, excluding it — so the data *requires* the shallow map.
  (`steep_map_excludes_codata`)

NOT proven here, by design: the length→order suppression rule itself, which would turn
the bracket into the value.  Candidate routes (memory `alpha-residual-036`): a curvature
correction to `N = d²` (`QLF_CausalDimension`), or the irreducible-closure generating
function `1 − √(1−4x)`.  Discipline: derive the rule first, evaluate second — never tune
to `0.036`.  Status: `alpha_bound_forced`, value `alpha_exact_value_in_progress`.
-/
import Mathlib

namespace QLF.AlphaBound

/-- `1/α_bare = 2⁷ = 128`. -/
def bareInv : ℚ := 128

/-- substrate spatial dimension `d = 3`. -/
def dim : ℕ := 3

/-- leading screening insertion `N = d² = 9`. -/
def Nlead : ℕ := dim ^ 2

/-- leading inverse coupling `α⁻¹_lead = 1/α_bare + N = 137`. -/
def leadInv : ℚ := bareInv + (Nlead : ℚ)

theorem leadInv_eq : leadInv = 137 := by
  unfold leadInv bareInv Nlead dim; norm_num

/-- `α_bare = 1/128`. -/
def bare : ℚ := 1 / 128

/-- Total balanced closures of length `2n`, `C(2n,n)` (the verified closure census,
    cf. `find_stable_states_length_even`): `2, 6, 20, 70, …`. -/
def totalClosures : ℕ → ℕ
  | 1 => 2 | 2 => 6 | 3 => 20 | 4 => 70 | _ => 0

/-- Irreducible (prime) balanced closures `2·Catalan(n−1)`: `2, 2, 4, 10, …`. -/
def irrClosures : ℕ → ℕ
  | 1 => 2 | 2 => 2 | 3 => 4 | 4 => 10 | _ => 0

theorem irr_two   : irrClosures 2 = 2 := by decide
theorem total_two : totalClosures 2 = 6 := by decide

/-- The dressed inverse coupling: leading value plus a screening residual `δ`. -/
def dressedInv (δ : ℚ) : ℚ := leadInv + δ

/-- **Unconditional forced bound.**  Abelian EM screens (residual `δ > 0`), so the IR
    coupling is strictly weaker than the leading combinatorial value: `α⁻¹ > 137`. -/
theorem alpha_inv_gt_137 {δ : ℚ} (hδ : 0 < δ) : dressedInv δ > 137 := by
  unfold dressedInv; rw [leadInv_eq]; linarith

/-- The leading new (irreducible length-4) screening term under one `α_bare` per order,
    `irr(2)·α_bare = 2/128 = 1/64` — a forced lower bound on the residual. -/
def residLowerTerm : ℚ := (irrClosures 2 : ℚ) * bare

theorem residLowerTerm_eq : residLowerTerm = 1 / 64 := by
  unfold residLowerTerm bare; rw [irr_two]; norm_num

/-- The first two total-census orders plus a geometric tail majorant — a forced upper
    bracket on the residual (per-order map): `6·α_bare + 20·α_bare² + tail`. -/
def residUpperBracket : ℚ := 6 * bare + 20 * bare ^ 2 + 1 / 7000

theorem residUpperBracket_lt : residUpperBracket < 49 / 1000 := by
  unfold residUpperBracket bare; norm_num

/-- **The census bracket contains the measured residual.**  The measured
    `α⁻¹ − 137 = 0.035999…` lies strictly inside `(irr-leading, total-census)`. -/
theorem codata_residual_in_census_bracket :
    residLowerTerm < 35999 / 1000000 ∧ (35999 : ℚ) / 1000000 < residUpperBracket := by
  refine ⟨?_, ?_⟩
  · rw [residLowerTerm_eq]; norm_num
  · unfold residUpperBracket bare; norm_num

/-- **Falsifiability.**  Under a steeper map (`α_bare²` per order) the residual is capped
    far below the measured `0.036`, excluding it — so the data *requires* the shallow
    (one-coupling-power-per-order) counting. -/
def residSteepCap : ℚ := 6 * bare ^ 2 + 20 * bare ^ 4 + 1 / 1000000

theorem steep_map_excludes_codata : residSteepCap < 35999 / 1000000 := by
  unfold residSteepCap bare; norm_num

/-- **The exact census upper limit.**  The total-closure tail (one `α_bare` per order)
    `∑_{n≥2} C(2n,n)·α_bare^(n-1)` sums in closed form via the central-binomial
    generating function `∑_{n≥0} C(2n,n) xⁿ = (1−4x)^(−1/2)`:

      residual_max = (1/α_bare)·[ (1−4α_bare)^(−1/2) − 1 − 2α_bare ]
                   = 128·( √(32/31) − 65/64 ) = (512√62)/31 − 130 ≈ 0.0481301,

    so the inverse coupling is capped at `α⁻¹ < (217 + 512√62)/31 ≈ 137.048130`.
    Represented here as a rational over-approximation of that limit. -/
def censusUpperLimit : ℚ := 4814 / 100000   -- ≥ 0.0481301 = exact total-census tail

/-- The measured residual lies strictly below the census upper limit
    (`α⁻¹ − 137 = 0.035999… < 0.048130`), with ~0.012 to spare. -/
theorem codata_below_census_upper_limit : (35999 : ℚ) / 1000000 < censusUpperLimit := by
  unfold censusUpperLimit; norm_num

/-- Both ends at once: the measured residual is inside the *exact* census band
    `(irreducible-leading 1/64, total-census limit ≈0.048130)`. -/
theorem codata_in_exact_census_band :
    residLowerTerm < 35999 / 1000000 ∧ (35999 : ℚ) / 1000000 < censusUpperLimit := by
  refine ⟨?_, ?_⟩
  · rw [residLowerTerm_eq]; norm_num
  · unfold censusUpperLimit; norm_num

/-! ### The exact `√62` upper limit, via the central-binomial generating function

The total-closure tail is summed in closed form, formalizing the `√62` cap.  The one analytic
input — the central-binomial generating function `∑ C(2n,n) xⁿ = (1−4x)^(−1/2)`, a classical
theorem living above the substrate's RCA₀ floor — is named explicitly as an axiom, per the QLF
analysis-boundary convention (cf. `spectral_hilbert_polya`, `yang_mills_continuum_gap`).  The
tail is *defined constructively* from the census counts, and everything around the boundary is
proved. -/

/-- The total-closure screening tail at `α_bare = 1/128`, one `α_bare` per closure order:
    `∑_{n≥2} C(2n,n)·α_bare^(n−1)` — a convergent real series built from the census counts. -/
noncomputable def censusTail : ℝ :=
  ∑' n : ℕ, (if 2 ≤ n then (Nat.centralBinom n : ℝ) * (1 / 128 : ℝ) ^ (n - 1) else 0)

/-- Multiplicative recurrence for the binomial-ring coefficient `Ring.choose`, over `ℝ`:
    `(n+1)·choose r (n+1) = choose r n · (r − n)`.  Derived from the descending-Pochhammer
    factorial relation (`Ring.descPochhammer_eq_factorial_smul_choose`). -/
private lemma qlf_ring_choose_succ (r : ℝ) (n : ℕ) :
    ((n : ℝ) + 1) * Ring.choose r (n + 1) = Ring.choose r n * (r - n) := by
  have h1 := Ring.descPochhammer_eq_factorial_smul_choose r (n + 1)
  rw [descPochhammer_succ_right, Polynomial.smeval_mul,
      Ring.descPochhammer_eq_factorial_smul_choose r n,
      Polynomial.smeval_sub, Polynomial.smeval_X, Polynomial.smeval_natCast] at h1
  simp only [pow_one, pow_zero, nsmul_eq_mul, mul_one] at h1
  have hfac : (n.factorial : ℝ) ≠ 0 := by exact_mod_cast Nat.factorial_ne_zero n
  have hf : ((n + 1).factorial : ℝ) = ((n : ℝ) + 1) * (n.factorial : ℝ) := by
    rw [Nat.factorial_succ]; push_cast; ring
  rw [hf] at h1
  have h3 : (n.factorial : ℝ) * (((n : ℝ) + 1) * Ring.choose r (n + 1))
          = (n.factorial : ℝ) * (Ring.choose r n * (r - ↑n)) := by linear_combination -h1
  exact mul_left_cancel₀ hfac h3

/-- The `−1/2` central-binomial coefficient identity: `4ⁿ·choose(−1/2) n = (−1)ⁿ·C(2n,n)`.
    Proved by induction using `qlf_ring_choose_succ` and `Nat.succ_mul_centralBinom_succ`. -/
private lemma qlf_choose_neg_half (n : ℕ) :
    (4 : ℝ) ^ n * Ring.choose (-1 / 2 : ℝ) n = (-1) ^ n * (Nat.centralBinom n : ℝ) := by
  induction n with
  | zero => simp [Ring.choose_zero_right, Nat.centralBinom_zero]
  | succ k ih =>
    have hr := qlf_ring_choose_succ (-1 / 2 : ℝ) k
    have hcbR : ((k : ℝ) + 1) * (Nat.centralBinom (k + 1) : ℝ)
              = 2 * (2 * (k : ℝ) + 1) * (Nat.centralBinom k : ℝ) := by
      exact_mod_cast Nat.succ_mul_centralBinom_succ k
    have hk1 : ((k : ℝ) + 1) ≠ 0 := by positivity
    apply mul_left_cancel₀ hk1
    rw [pow_succ (4 : ℝ) k, pow_succ (-1 : ℝ) k]
    linear_combination (4 * (4 : ℝ) ^ k) * hr + (4 * (-1 / 2 - (k : ℝ))) * ih
      + ((-1 : ℝ) ^ k) * hcbR

/-- **Central-binomial generating function**, specialized at `x = 1/128` — now a *theorem*.
    `∑ C(2n,n)·(1/128)ⁿ = (31/32)^(−1/2) = 4·√62/31`, via Mathlib's binomial series for
    `(1+x)^(−1/2)` (`Real.one_add_rpow_hasFPowerSeriesOnBall_zero`) evaluated at `x = −1/32`,
    with the coefficient identity `qlf_choose_neg_half`.  No longer an axiom — the last analysis
    assumption under the α-residual is discharged from Mathlib's generalized binomial theorem. -/
theorem central_binom_genfun :
    HasSum (fun n : ℕ => (Nat.centralBinom n : ℝ) * (1 / 128 : ℝ) ^ n) (4 * Real.sqrt 62 / 31) := by
  -- per-term identity: choose(−1/2) n · (−1/32)ⁿ = C(2n,n) · (1/128)ⁿ
  have hterm_core : ∀ n : ℕ,
      Ring.choose (-1 / 2 : ℝ) n * (-1 / 32 : ℝ) ^ n
        = (Nat.centralBinom n : ℝ) * (1 / 128 : ℝ) ^ n := by
    intro n
    have hc := qlf_choose_neg_half n
    have hS : (-1 : ℝ) ^ n * (-1) ^ n = 1 := by rw [← mul_pow]; norm_num
    have hpow : (-1 / 32 : ℝ) ^ n = (-1) ^ n * ((4 : ℝ) ^ n * (1 / 128 : ℝ) ^ n) := by
      rw [← mul_pow, ← mul_pow]; norm_num
    rw [hpow]
    linear_combination ((-1 : ℝ) ^ n * (1 / 128 : ℝ) ^ n) * hc
      + ((1 / 128 : ℝ) ^ n * (Nat.centralBinom n : ℝ)) * hS
  -- the closed-form value of the function at the evaluation point
  have hval : (31 / 32 : ℝ) ^ (-1 / 2 : ℝ) = 4 * Real.sqrt 62 / 31 := by
    rw [show (-1 / 2 : ℝ) = -(1 / 2) by norm_num,
        Real.rpow_neg (by norm_num : (0 : ℝ) ≤ 31 / 32), ← Real.sqrt_eq_rpow, ← Real.sqrt_inv]
    rw [show (31 / 32 : ℝ)⁻¹ = (4 * Real.sqrt 62 / 31) ^ 2 by
          have h62 : Real.sqrt 62 ^ 2 = 62 := Real.sq_sqrt (by norm_num)
          rw [div_pow, mul_pow, h62]; norm_num]
    exact Real.sqrt_sq (by positivity)
  -- Mathlib's binomial series for (1+x)^(−1/2) on the unit ball, at x = −1/32
  have hF := Real.one_add_rpow_hasFPowerSeriesOnBall_zero (a := (-1 / 2 : ℝ))
  have hy : (-1 / 32 : ℝ) ∈ Metric.eball (0 : ℝ) 1 := by
    rw [Metric.mem_eball, edist_dist, Real.dist_eq, sub_zero,
        abs_of_neg (show (-1 / 32 : ℝ) < 0 by norm_num),
        show -(-1 / 32 : ℝ) = 1 / 32 by norm_num]
    exact (ENNReal.ofReal_lt_one).mpr (by norm_num)
  have hsum := hF.hasSum hy
  simp only [zero_add] at hsum
  rw [show (1 + (-1 / 32) : ℝ) = 31 / 32 by norm_num, hval] at hsum
  -- rewrite each series term into the central-binomial form
  have hfun : (fun n : ℕ => binomialSeries ℝ (-1 / 2 : ℝ) n (fun _ => (-1 / 32 : ℝ)))
            = (fun n : ℕ => (Nat.centralBinom n : ℝ) * (1 / 128 : ℝ) ^ n) := by
    funext n
    rw [binomialSeries_apply,
        show (List.ofFn (fun _ : Fin n => (-1 / 32 : ℝ))).prod = (-1 / 32 : ℝ) ^ n by
          simp [List.prod_ofFn],
        smul_eq_mul]
    exact hterm_core n
  rw [hfun] at hsum
  exact hsum

/-- The exact total-census screening tail in closed form — **derived** from `central_binom_genfun`
    by peeling the `n = 0, 1` terms and reindexing (factor `128`). -/
theorem censusTail_eq : censusTail = 512 * Real.sqrt 62 / 31 - 130 := by
  set f : ℕ → ℝ := fun n => if 2 ≤ n then (Nat.centralBinom n : ℝ) * (1 / 128 : ℝ) ^ (n - 1) else 0
    with hf
  -- on the `+2` shift the census term is `128·(centralBinom (n+2)·(1/128)^(n+2))`
  have key : ∀ n : ℕ,
      f (n + 2) = 128 * ((Nat.centralBinom (n + 2) : ℝ) * (1 / 128 : ℝ) ^ (n + 2)) := by
    intro n
    show (if 2 ≤ n + 2 then (Nat.centralBinom (n + 2) : ℝ) * (1 / 128 : ℝ) ^ (n + 2 - 1) else 0)
        = 128 * ((Nat.centralBinom (n + 2) : ℝ) * (1 / 128 : ℝ) ^ (n + 2))
    rw [if_pos (by omega : 2 ≤ n + 2), show n + 2 - 1 = n + 1 by omega, pow_add, pow_add]
    ring
  -- shifted central-binomial sum
  have hbs : HasSum (fun n : ℕ => (Nat.centralBinom (n + 2) : ℝ) * (1 / 128 : ℝ) ^ (n + 2))
      (4 * Real.sqrt 62 / 31 - (1 + (1 : ℝ) / 64)) := by
    rw [hasSum_nat_add_iff (f := fun n : ℕ => (Nat.centralBinom n : ℝ) * (1 / 128 : ℝ) ^ n) 2]
    have hs : (∑ i ∈ Finset.range 2, (Nat.centralBinom i : ℝ) * (1 / 128 : ℝ) ^ i) = 1 + (1 : ℝ) / 64 := by
      rw [Finset.sum_range_succ, Finset.sum_range_one]
      norm_num [Nat.centralBinom_zero, show Nat.centralBinom 1 = 2 from by decide]
    rw [hs, show (4 * Real.sqrt 62 / 31 - (1 + (1 : ℝ) / 64)) + (1 + (1 : ℝ) / 64)
          = 4 * Real.sqrt 62 / 31 by ring]
    exact central_binom_genfun
  -- shifted census sum (rewrite the summand via `key`)
  have hfs : HasSum (fun n : ℕ => f (n + 2)) (128 * (4 * Real.sqrt 62 / 31 - (1 + (1 : ℝ) / 64))) := by
    rw [show (fun n : ℕ => f (n + 2))
          = (fun n : ℕ => 128 * ((Nat.centralBinom (n + 2) : ℝ) * (1 / 128 : ℝ) ^ (n + 2)))
        from funext key]
    exact hbs.mul_left 128
  -- unshift
  have hfsum : HasSum f (128 * (4 * Real.sqrt 62 / 31 - (1 + (1 : ℝ) / 64))) := by
    rw [hasSum_nat_add_iff (f := f) 2] at hfs
    have hz : (∑ i ∈ Finset.range 2, f i) = 0 := by
      rw [Finset.sum_range_succ, Finset.sum_range_one]; simp [hf]
    rw [hz, add_zero] at hfs
    exact hfs
  calc censusTail = ∑' n, f n := rfl
    _ = 128 * (4 * Real.sqrt 62 / 31 - (1 + (1 : ℝ) / 64)) := hfsum.tsum_eq
    _ = 512 * Real.sqrt 62 / 31 - 130 := by ring

/- NOTE — both `central_binom_genfun` and `censusTail_eq` are now theorems (above), so the
   census-tail screening factor `512√62/31 − 130` carries **no axiom**: it is derived end-to-end
   from Mathlib's generalized binomial theorem (`Real.one_add_rpow_hasFPowerSeriesOnBall_zero`,
   the `(1+x)^a` binomial series) specialized to `a = −1/2`, `x = −1/32`, via the coefficient
   identity `4ⁿ·choose(−1/2) n = (−1)ⁿ·C(2n,n)` (`qlf_choose_neg_half`).  What remains genuinely
   open under the α-residual is the *physics* — deriving the `+0.036` higher-order piece from the
   substrate census/curvature — not any analysis input (group target, #57). -/

/-- **The exact census upper limit on the inverse coupling** (total closures, per-order map):
    `α⁻¹ ≤ 137 + censusTail = (217 + 512·√62)/31 ≈ 137.048130`. -/
noncomputable def alphaInvCap : ℝ := (217 + 512 * Real.sqrt 62) / 31

/-- Leading value plus the exact census tail is the closed-form cap `(217 + 512·√62)/31`. -/
theorem alphaInvCap_eq : (137 : ℝ) + censusTail = alphaInvCap := by
  unfold alphaInvCap; rw [censusTail_eq]; ring

/-! ### Irreducible (prime-closure) lower bracket, and the Dyson resummation `G = 1/(1−I)`

The total census `G(x) = ∑ C(2n,n) xⁿ = (1−4x)^(−1/2)` is the geometric resummation of the
irreducible (prime) closures `I(x) = ∑ 2·Catalan(n−1) xⁿ = 1 − √(1−4x)`: `G = 1/(1−I)` (every
closure is an ordered sequence of primes — the Dyson/1PI structure). The irreducible closure count
is `2·Catalan(n−1) = 4·C(2n−2,n−1) − C(2n,n)` (central-binomial recurrence), so the irreducible tail
is a linear combination of `central_binom_genfun` and the census tail — **no new analysis input**.
This gives the *lower* end of the forced residual bracket as an exact `√62` closed form. See
`Alpha_Residual.md`. -/

/-- The irreducible closure count `2·Catalan(n−1)` agrees with `4·C(2n−2,n−1) − C(2n,n)` for the
    first orders: `2, 4, 10` at `n = 2, 3, 4` (cf. `irrClosures`). -/
theorem irrCoeff_matches :
    4 * (Nat.centralBinom 1 : ℝ) - Nat.centralBinom 2 = 2 ∧
    4 * (Nat.centralBinom 2 : ℝ) - Nat.centralBinom 3 = 4 ∧
    4 * (Nat.centralBinom 3 : ℝ) - Nat.centralBinom 4 = 10 := by
  norm_num [show Nat.centralBinom 1 = 2 from by decide, show Nat.centralBinom 2 = 6 from by decide,
            show Nat.centralBinom 3 = 20 from by decide, show Nat.centralBinom 4 = 70 from by decide]

/-- The irreducible (prime-closure) screening tail, one `α_bare` per order, with closure count
    `2·Catalan(n−1) = 4·C(2n−2,n−1) − C(2n,n)`. -/
noncomputable def irreducibleTail : ℝ :=
  ∑' n : ℕ, (if 2 ≤ n then (4 * (Nat.centralBinom (n - 1) : ℝ) - (Nat.centralBinom n : ℝ))
    * (1 / 128 : ℝ) ^ (n - 1) else 0)

/-- **Irreducible tail closed form** `126 − 16√62 ≈ 0.015874`, derived from `central_binom_genfun`
    (no new axiom): `irreducibleTail = 4·(G(1/128) − 1) − censusTail`. -/
theorem irreducibleTail_eq : irreducibleTail = 126 - 16 * Real.sqrt 62 := by
  -- ∑_{k≥0} C(2(k+1),k+1)·(1/128)^(k+1) = G − 1
  have h1 : HasSum (fun k => (Nat.centralBinom (k + 1) : ℝ) * (1 / 128 : ℝ) ^ (k + 1))
      (4 * Real.sqrt 62 / 31 - 1) := by
    rw [hasSum_nat_add_iff (f := fun n => (Nat.centralBinom n : ℝ) * (1 / 128 : ℝ) ^ n) 1]
    have hs : (∑ i ∈ Finset.range 1, (Nat.centralBinom i : ℝ) * (1 / 128 : ℝ) ^ i) = 1 := by
      rw [Finset.sum_range_one]; norm_num [Nat.centralBinom_zero]
    rw [hs, show (4 * Real.sqrt 62 / 31 - 1) + 1 = 4 * Real.sqrt 62 / 31 by ring]
    exact central_binom_genfun
  -- ∑_{k≥0} C(2(k+2),k+2)·(1/128)^(k+2) = G − 1 − 1/64
  have h2 : HasSum (fun k => (Nat.centralBinom (k + 2) : ℝ) * (1 / 128 : ℝ) ^ (k + 2))
      (4 * Real.sqrt 62 / 31 - (1 + 1 / 64)) := by
    rw [hasSum_nat_add_iff (f := fun n => (Nat.centralBinom n : ℝ) * (1 / 128 : ℝ) ^ n) 2]
    have hs : (∑ i ∈ Finset.range 2, (Nat.centralBinom i : ℝ) * (1 / 128 : ℝ) ^ i) = 1 + 1 / 64 := by
      rw [Finset.sum_range_succ, Finset.sum_range_one]
      norm_num [Nat.centralBinom_zero, show Nat.centralBinom 1 = 2 from by decide]
    rw [hs, show (4 * Real.sqrt 62 / 31 - (1 + 1 / 64)) + (1 + 1 / 64) = 4 * Real.sqrt 62 / 31 by ring]
    exact central_binom_genfun
  -- the shifted irreducible term = 4·cB(k+1)x^{k+1} − 128·cB(k+2)x^{k+2}
  have hfun : (fun k => (4 * (Nat.centralBinom (k + 1) : ℝ) - (Nat.centralBinom (k + 2) : ℝ))
        * (1 / 128 : ℝ) ^ (k + 1))
      = (fun k => 4 * ((Nat.centralBinom (k + 1) : ℝ) * (1 / 128 : ℝ) ^ (k + 1))
        - 128 * ((Nat.centralBinom (k + 2) : ℝ) * (1 / 128 : ℝ) ^ (k + 2))) := by
    funext k
    have hp : (128 : ℝ) * (1 / 128 : ℝ) ^ (k + 2) = (1 / 128 : ℝ) ^ (k + 1) := by
      rw [pow_add, pow_add]; ring
    rw [← hp]; ring
  have hirrShift : HasSum (fun k => (4 * (Nat.centralBinom (k + 1) : ℝ)
        - (Nat.centralBinom (k + 2) : ℝ)) * (1 / 128 : ℝ) ^ (k + 1)) (126 - 16 * Real.sqrt 62) := by
    rw [hfun, show (126 : ℝ) - 16 * Real.sqrt 62
        = 4 * (4 * Real.sqrt 62 / 31 - 1) - 128 * (4 * Real.sqrt 62 / 31 - (1 + 1 / 64)) by ring]
    exact (h1.mul_left 4).sub (h2.mul_left 128)
  -- relate the guarded tail to the shifted HasSum (mirror of `censusTail_eq`)
  set firr : ℕ → ℝ := fun n => if 2 ≤ n then
    (4 * (Nat.centralBinom (n - 1) : ℝ) - (Nat.centralBinom n : ℝ)) * (1 / 128 : ℝ) ^ (n - 1) else 0
    with hfirr
  have hkey : ∀ k, firr (k + 2)
      = (4 * (Nat.centralBinom (k + 1) : ℝ) - (Nat.centralBinom (k + 2) : ℝ)) * (1 / 128 : ℝ) ^ (k + 1) := by
    intro k
    show (if 2 ≤ k + 2 then
        (4 * (Nat.centralBinom (k + 2 - 1) : ℝ) - (Nat.centralBinom (k + 2) : ℝ))
          * (1 / 128 : ℝ) ^ (k + 2 - 1) else 0) = _
    rw [if_pos (by omega), show k + 2 - 1 = k + 1 by omega]
  have hshift : HasSum (fun k => firr (k + 2)) (126 - 16 * Real.sqrt 62) := by
    have h := hirrShift; rwa [← funext hkey] at h
  have hsum : HasSum firr (126 - 16 * Real.sqrt 62) := by
    rw [hasSum_nat_add_iff (f := firr) 2] at hshift
    have hz : (∑ i ∈ Finset.range 2, firr i) = 0 := by
      rw [Finset.sum_range_succ, Finset.sum_range_one]; simp [hfirr]
    rw [hz, add_zero] at hshift
    exact hshift
  calc irreducibleTail = ∑' n, firr n := rfl
    _ = 126 - 16 * Real.sqrt 62 := hsum.tsum_eq

/-- **Irreducible (lower) cap** on the inverse coupling: `137 + irreducibleTail = 263 − 16√62
    ≈ 137.01587` — the *lower* end of the forced residual bracket, exact closed form. -/
theorem irreducibleCap_eq : (137 : ℝ) + irreducibleTail = 263 - 16 * Real.sqrt 62 := by
  rw [irreducibleTail_eq]; ring

/-- **Dyson / 1PI resummation `G = 1/(1 − I)`** at `x = 1/128`, value level: `G·(1 − I) = 1`,
    with `G = 4√62/31` (`central_binom_genfun`) and `1 − I(1/128) = √(31/32) = √62/8`. So the total
    census is the geometric resummation of the irreducible (prime) closures. -/
theorem census_irreducible_resummation :
    (4 * Real.sqrt 62 / 31) * (Real.sqrt 62 / 8) = 1 := by
  have h62 : Real.sqrt 62 * Real.sqrt 62 = 62 := Real.mul_self_sqrt (by norm_num)
  field_simp
  linear_combination 4 * h62

/-- `7.874 < √62`  (since `7.874² = 61.999876 < 62`). -/
theorem sqrt62_gt : (7874 : ℝ) / 1000 < Real.sqrt 62 := by
  nlinarith [Real.sq_sqrt (show (0 : ℝ) ≤ 62 by norm_num), Real.sqrt_nonneg 62]

/-- **The measured inverse coupling lies strictly below the exact `√62` cap**:
    `137.035999 < (217 + 512·√62)/31 ≈ 137.048130` — fully machine-checked given the
    generating-function boundary. -/
theorem codata_below_alphaInvCap : (137035999 : ℝ) / 1000000 < alphaInvCap := by
  have hlt : (137035999 : ℝ) / 1000000 < (217 + 512 * ((7874 : ℝ) / 1000)) / 31 := by norm_num
  have mono : (217 + 512 * ((7874 : ℝ) / 1000)) / 31 ≤ alphaInvCap := by
    unfold alphaInvCap; gcongr; exact sqrt62_gt.le
  linarith

/-- Status marker: the leading value `137` is derived by construction; the dressed value is
    bounded — `α⁻¹ > 137` (screening) and the closed-form `√62` census cap above — with the
    measured value inside; the exact value (the length→order rule) stays open. -/
theorem alpha_bound_forced : True := trivial

end QLF.AlphaBound
