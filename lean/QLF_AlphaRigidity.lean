import Mathlib

/-!
# QLF_AlphaRigidity — the elementarity spine of α-rigidity (issue #116)

`Alpha.md` §6a: `α⁻¹ = 137` is not a fit but a **cross-sector consistency joint** — two independent
substrate derivations (the rendering dimension `d = 3` from the 6+2 split, and the bare inverse
`128 = 2⁷` from the selectivity product) meet at the measured value, and a third sector (elementarity:
`137` is prime) agrees at the same point. `d` is *substrate-derived*, not a free/observed parameter, so
this is **overdetermination**, not rigidity over a knob. This module lands the **elementarity spine and
the machine-checked joint**; the full free-`Expr`-grammar enumeration + census `N(d)` is issue #116.

Landed here:
* **I2 `prime_implies_atomic`** — a prime count admits no nontrivial factorization (free arithmetic).
* **P1 `realization`** — the *single physical premise*, an explicit `axiom`: every arithmetic
  factorization of the closure count of an independently existing (ZFE-closed) system is realized by an
  available decomposition into independent sub-receipts. (`RealizedIndependent` is an uninterpreted
  predicate — the physical notion of independent realization — *not* itself a premise; only
  `realization` is.) Scope is ZFE-closed systems: free charge is a non-closed ledger, outside P1.
* **I3 `elementary_iff_prime`** — *elementary* (ZFE-closed ∧ not decomposable) ⟺ *prime* count, from
  I2 + P1. "Stable" appears nowhere: the chain routes through elementarity only.
* **I1 `dyadic_closed`** — admissible values are dyadic. Near-vacuous in the division-free α⁻¹ grammar
  (all values are integers), stated to validate the grammar scaffold; it bites only in a `/3` extension.

The grammar leaves are the substrate primitives that appear as values (`two`, `three`; the `128 = 2⁷`
comes from the selectivity product, `9 = 3²` from the axis tensor); ops are `sum`/`prod`/`pow` — the
corrected grammar of `Alpha.md` §6a (the inflating `alphabetCard`/`splitSpatial` leaves are dropped).
-/

namespace QLF.AlphaRigidity

/-! ## The frozen derivation grammar (corrected) -/

/-- Admissible derivation expressions: the substrate primitives `2` (bit) and `3` (axes) under the
    operations the real α⁻¹ construction uses — `sum`, `prod`, `pow`. Nothing else. -/
inductive Expr
  | two
  | three
  | sum  (a b : Expr)
  | prod (a b : Expr)
  | pow  (a : Expr) (n : ℕ)
  deriving DecidableEq

/-- Integer value of an expression (`α⁻¹` lives in numerators; the grammar is division-free). -/
def val : Expr → ℤ
  | .two      => 2
  | .three    => 3
  | .sum a b  => val a + val b
  | .prod a b => val a * val b
  | .pow a n  => (val a) ^ n

/-- Expression depth (for the bounded-enumeration layer, used by the gated R1). -/
def depth : Expr → ℕ
  | .sum a b  => max (depth a) (depth b) + 1
  | .prod a b => max (depth a) (depth b) + 1
  | .pow a _  => depth a + 1
  | _         => 0

/-! ## I1 — the dyadic invariant (near-vacuous here; validates the scaffold) -/

/-- A rational is dyadic when it is `z / 2^k`. -/
def IsDyadic (q : ℚ) : Prop := ∃ (k : ℕ) (z : ℤ), q = z / 2 ^ k

/-- **I1.** Every grammar value is dyadic — trivially, since the division-free grammar produces only
    integers (`k = 0`). The invariant bites only in a `/3` extension (Koide-style values), which lives
    outside this sub-grammar; here it validates the machinery. -/
theorem dyadic_closed (e : Expr) : IsDyadic (val e : ℚ) :=
  ⟨0, val e, by norm_num⟩

/-! ## I2 — prime ⟹ atomic (free arithmetic) -/

/-- A count is **atomic** when it admits no nontrivial factorization. -/
def Atomic (n : ℕ) : Prop := ¬ ∃ a b, 2 ≤ a ∧ 2 ≤ b ∧ n = a * b

/-- **I2.** A prime count is atomic: no rereading as a product of two `≥ 2` factors. -/
theorem prime_implies_atomic {n : ℕ} (hp : n.Prime) : Atomic n := by
  rintro ⟨a, b, ha, hb, rfl⟩
  rcases hp.eq_one_or_self_of_dvd a ⟨b, rfl⟩ with h1 | hself
  · omega
  · have hle : a * 2 ≤ a * b := Nat.mul_le_mul (le_refl a) hb
    omega

/-! ## P1 — the realization postulate (the single physical premise) -/

/-- Uninterpreted predicate: the closure space of count `n` physically splits as independent
    sub-receipts of counts `a`, `b`. Not a premise — the *carrier* of the physical notion. -/
axiom RealizedIndependent : ℕ → ℕ → ℕ → Prop

/-- **Physical decomposability**: a *realized* nontrivial factorization (arithmetic factorization is
    built in, so the backward direction of `elementary_iff_prime` closes by construction). -/
def DecomposableCount (n : ℕ) : Prop :=
  ∃ a b, 2 ≤ a ∧ 2 ≤ b ∧ n = a * b ∧ RealizedIndependent n a b

/-- **P1 (realization) — the single physical premise, explicit.** Every composite (non-prime,
    `≥ 2`) closure count of an independently existing system is physically decomposable. Scope:
    ZFE-closed systems only (free charge is a non-closed ledger, outside the domain). -/
axiom realization : ∀ n : ℕ, 2 ≤ n → ¬ n.Prime → DecomposableCount n

/-- Decomposability entails the arithmetic factorization (the easy, definitional direction). -/
theorem decomposable_factors {n : ℕ} (h : DecomposableCount n) :
    ∃ a b, 2 ≤ a ∧ 2 ≤ b ∧ n = a * b := by
  obtain ⟨a, b, ha, hb, hab, _⟩ := h
  exact ⟨a, b, ha, hb, hab⟩

/-! ## I3 — elementary ⟺ prime -/

/-- **Elementary**: independently existing (`2 ≤ n`, ZFE-closed) and not physically decomposable.
    Dynamical stability appears nowhere — the chain routes through counting/elementarity only. -/
def Elementary (n : ℕ) : Prop := 2 ≤ n ∧ ¬ DecomposableCount n

/-- **I3.** For `n ≥ 2`, *elementary ⟺ prime* — from I2 (backward) and P1 (forward). -/
theorem elementary_iff_prime {n : ℕ} (h2 : 2 ≤ n) : Elementary n ↔ n.Prime := by
  constructor
  · rintro ⟨_, hnd⟩
    by_contra hnp
    exact hnd (realization n h2 hnp)
  · intro hp
    exact ⟨h2, fun hd => prime_implies_atomic hp (decomposable_factors hd)⟩

/-! ## Density — the grammar alone excludes nothing (so all rigidity lives in the template)

Before the joint: the frozen grammar `{two, three, sum, prod, pow}` reaches **every** integer `≥ 2`
(sums of `two` and `three` already suffice). So the grammar excludes *nothing* — including `136`. This
is the load-bearing disclaimer for `dimension_136_unreachable` below: `136`'s unreachability is a fact
about the *construction template* (`128 + d²`), **not** about the grammar. All rigidity lives in the
template; issue #116's census `N(d)` is the job of quantifying what the §6a admissibility constraints
must therefore impose on the grammar.
-/

/-- Helper: the grammar reaches every even (`2k+2`) and odd (`2k+3`) value `≥ 2`, by induction adding a
    `two` each step. -/
theorem grammar_even_odd (k : ℕ) :
    (∃ e : Expr, val e = ((2 * k + 2 : ℕ) : ℤ)) ∧ (∃ e : Expr, val e = ((2 * k + 3 : ℕ) : ℤ)) := by
  induction k with
  | zero => exact ⟨⟨.two, by norm_num [val]⟩, ⟨.three, by norm_num [val]⟩⟩
  | succ n ih =>
    obtain ⟨⟨ee, hee⟩, ⟨eo, heo⟩⟩ := ih
    exact ⟨⟨.sum .two ee, by simp only [val, hee]; push_cast; ring⟩,
           ⟨.sum .two eo, by simp only [val, heo]; push_cast; ring⟩⟩

/-- **Density: the grammar reaches every count `≥ 2`.** So the grammar itself excludes no value — the
    rigidity is entirely in the construction template, never in the grammar. -/
theorem grammar_reaches_all (n : ℕ) (hn : 2 ≤ n) : ∃ e : Expr, val e = (n : ℤ) := by
  obtain ⟨k, hk | hk⟩ : ∃ k, n = 2 * k + 2 ∨ n = 2 * k + 3 := by
    rcases Nat.even_or_odd (n - 2) with ⟨j, hj⟩ | ⟨j, hj⟩
    · exact ⟨j, Or.inl (by omega)⟩
    · exact ⟨j, Or.inr (by omega)⟩
  · subst hk; exact (grammar_even_odd k).1
  · subst hk; exact (grammar_even_odd k).2

/-! ## The cross-sector consistency theorem (overdetermination), not rigidity over a free parameter

**`d` is not a free parameter.** It is *substrate-derived*: the 6+2 split yields 3 axis-pairs (settled
combinatorics, issue #42), and minimal-faithful-rendering (`SpaceTime.md` §3a) forces the rendering
dimension from that structure — not from observing that our perspective is 3-D (that would feed a
measured datum into `128 + d²` and degrade the parameter-free claim into a one-datum fit). So this is
**not** rigidity over a live knob. It is a **cross-sector consistency theorem**: two *independent*
substrate derivations —
* the **dimension sector**: `d = 3` from the 6+2 split, giving `d² = 9`;
* the **bare-coupling sector**: `128 = 2⁷` from the selectivity product —

intersect, and their intersection `128 + 9` is the measured `α⁻¹ = 137`. That is *overdetermination*,
the strongest evidence QLF has, now with a machine-checked joint. The slogan it licenses: **`α⁻¹` counts
the rendering dimension** — `137 − 128 = 9 = 3²`, so measuring α is, in QLF, measuring `d²`.

What survives of the modal content is **brittleness, not choice**: `alpha_unique` quantifies over
*counterfactual* dimensions and shows **zero slack** — a 4-D rendering would force `α⁻¹ = 144`, full
stop. The dimension and α sectors are **locked**: nothing can perturb one without the other (a standing
conditional prediction, falsifiable in principle in a way "137 fits" never was). *Outstanding check, so
"forced" stays honest:* `d = 3` is settled at the **counting** layer (the split); the **mechanism**-layer
test — the swap-graph growth exponent (issue #62) — is pending. Until it lands at 3, "forced" means
"forced by the split combinatorics, mechanism check pending."
-/

/-- The α⁻¹ construction: the bare inverse `128 = 2⁷` (selectivity product, one substrate sector) plus
    the directional-coupling tensor `d²` at the *substrate-derived* rendering dimension `d` (the other
    sector). `d` is fixed by minimal-faithful-rendering, not free. -/
def inverseAlpha (d : ℕ) : ℕ := 128 + d * d

/-- At the substrate-derived rendering dimension `d = 3` (6+2 split), `α⁻¹ = 137`. -/
theorem inverseAlpha_at_three : inverseAlpha 3 = 137 := by decide

/-- **The slogan, formalized: `α⁻¹` counts the rendering dimension.** `inverseAlpha d − 128 = d²`, so
    the coupling above the bare `128` *is* the squared rendering dimension — measuring α is measuring
    `d²`. -/
theorem alpha_counts_dimension (d : ℕ) : inverseAlpha d - 128 = d * d := by
  unfold inverseAlpha; omega

/-- **The sectors meet only at `d = 3` (zero slack).** `inverseAlpha d = 137 ↔ d = 3`: the bare-coupling
    sector (`128`) and a rendering of dimension `d` agree with the measured `α⁻¹` at *exactly one*
    dimension. Read as brittleness, not choice — the substrate-derived `d = 3` is where the two
    independent sectors intersect, and nowhere else could. -/
theorem alpha_unique (d : ℕ) : inverseAlpha d = 137 ↔ d = 3 := by
  unfold inverseAlpha
  constructor
  · intro h
    have h9 : d * d = 9 := by omega
    have hle : d ≤ 9 := by nlinarith [h9]
    interval_cases d <;> omega
  · rintro rfl; rfl

/-- **The no-slack lemma.** Any dimension other than the substrate-derived `d = 3` misses `137`: the
    sectors are **locked**, so the framework could not have accommodated a mismatch between its own two
    derivations. That it did not have to is the checkable fact (a 4-D rendering would force `144`). -/
theorem rival_excluded {d : ℕ} (hd : d ≠ 3) : inverseAlpha d ≠ 137 := fun h => hd ((alpha_unique d).mp h)

/-- **136 is unreachable at any dimension** (`128 + d² = 136` needs `d² = 8`, no ℕ solution). With I3
    (`136` composite ⟹ non-elementary) this is the *second* independent death of `136` — the
    anti-Eddington payoff: the near-miss the swamp reaches for is doubly excluded. -/
theorem dimension_136_unreachable (d : ℕ) : inverseAlpha d ≠ 136 := by
  unfold inverseAlpha
  intro h
  have h8 : d * d = 8 := by omega
  have hle : d ≤ 8 := by nlinarith [h8]
  interval_cases d <;> omega

/-! ## The third sector — elementarity agrees at the same point -/

/-- **`137` is prime — the elementarity sector agrees.** The intersection value of the dimension and
    bare-coupling sectors is *also* prime, so a third independent property (I3: elementary ⟺ prime)
    holds at the same point. -/
theorem inverseAlpha_three_prime : Nat.Prime (inverseAlpha 3) := by
  unfold inverseAlpha; norm_num

/-- **`137` is elementary** — via I3 (`elementary_iff_prime`, backward direction, I2 only; no P1). So all
    three sectors — dimension (`d = 3`), bare coupling (`128`), and elementarity (prime/atomic) — meet at
    `α⁻¹ = 137`: the machine-checked overdetermination joint. -/
theorem inverseAlpha_three_elementary : Elementary (inverseAlpha 3) := by
  have h2 : 2 ≤ inverseAlpha 3 := by unfold inverseAlpha; norm_num
  exact (elementary_iff_prime h2).mpr inverseAlpha_three_prime

/-- **The third sector *agrees*, it does not *select*.** Among dimensions `d ≤ 14`, `inverseAlpha d` is
    prime only at `d = 3` — so elementarity is a consistency datum at the joint. But it is **not** an
    independent exclusion: `inverseAlpha 15 = 353` is *also* prime (`inverseAlpha_fifteen_prime`), so
    "prime output" alone would bless a 15-D rendering — it is the *dimension* sector that excludes it.
    The three sectors overdetermine **jointly**, not each alone. -/
theorem prime_below_15_only_three (d : ℕ) (hd : d ≤ 14) (hp : Nat.Prime (inverseAlpha d)) : d = 3 := by
  interval_cases d <;> simp only [inverseAlpha] at hp <;> first | rfl | exact absurd hp (by decide)

/-- `inverseAlpha 15 = 353` is prime — the explicit witness that elementarity does not select `d = 3`. -/
theorem inverseAlpha_fifteen_prime : Nat.Prime (inverseAlpha 15) := by
  unfold inverseAlpha; norm_num

/-! ## Summary

The elementarity spine (I1–I3, P1) **and** the cross-sector consistency joint are proven. Three
*independent* substrate sectors meet at `α⁻¹ = 137`: the **dimension** (`d = 3` from the 6+2 split),
the **bare coupling** (`128 = 2⁷`), and **elementarity** (`137` prime/atomic, `inverseAlpha_three_prime`
/`_elementary`). `alpha_unique` shows the meeting has **zero slack** (only `d = 3`); `rival_excluded`
that the sectors are **locked** — overdetermination, not a fit over a free parameter (`d` is
substrate-derived, not observed). `alpha_counts_dimension`: `α⁻¹ − 128 = d²`. `grammar_reaches_all`: the
grammar excludes nothing, so all rigidity lives in the template. `prime_below_15_only_three` +
`inverseAlpha_fifteen_prime`: the elementarity sector *agrees* at the joint but does not *select* it
(`353` is prime too) — the sectors overdetermine jointly.

**Honest scope:** `d = 3` is forced at the *counting* layer (the split); the *mechanism*-layer check
(the swap-graph growth exponent, issue #62) is pending — so "forced" = "by the split combinatorics,
mechanism check pending". The full free-`Expr`-grammar enumeration + census `N(d)` (issue #116) is the
remaining residual.
-/

end QLF.AlphaRigidity
