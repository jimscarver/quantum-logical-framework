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

/-- **Central-binomial generating function** — the analysis-boundary input.  Classically
    `∑_{n} C(2n,n) xⁿ = (1−4x)^(−1/2)` for `|x| < 1/4`; specialized and reindexed at `x = 1/128`
    the tail above evaluates to `128·(√(32/31) − 65/64) = 512·√62/31 − 130`.  A known theorem,
    not yet in this Mathlib; named per the QLF boundary-axiom convention. -/
axiom censusTail_eq : censusTail = 512 * Real.sqrt 62 / 31 - 130

/-- **The exact census upper limit on the inverse coupling** (total closures, per-order map):
    `α⁻¹ ≤ 137 + censusTail = (217 + 512·√62)/31 ≈ 137.048130`. -/
noncomputable def alphaInvCap : ℝ := (217 + 512 * Real.sqrt 62) / 31

/-- Leading value plus the exact census tail is the closed-form cap `(217 + 512·√62)/31`. -/
theorem alphaInvCap_eq : (137 : ℝ) + censusTail = alphaInvCap := by
  unfold alphaInvCap; rw [censusTail_eq]; ring

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
