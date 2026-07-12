import Mathlib

/-!
# QLF_AlphaRigidity — the elementarity spine of α-rigidity (issue #116)

`Alpha.md` §6a: within a frozen substrate-motivated grammar, `α⁻¹ = 137` is the *only* reachable
value — rigidity, not existence (the value is derived in `QLF_FineStructureSubstrate`). This module
lands the **elementarity spine and the rigidity over the construction's one free parameter** (the
rendering dimension). The remaining census `reachable_finite` (N) is issue #116.

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

/-! ## R1/R2 — rigidity over the construction's one free parameter (the rendering dimension)

The frozen construction (§6a) is `α⁻¹ = 128 + d²`: the bare inverse `2⁷ = 128` (the selectivity
product) is fixed, the directional-coupling tensor contributes `d²` at rendering dimension `d`, and the
resummation adds them. So the admissible constructions form a **one-parameter family in `d`** — and the
rigidity question is exactly whether `137` is reached at more than one `d`. It is not. This is the
substantive, non-circular rigidity: `128` and the `+d²` form are 137-independent, and `d = 3` is itself
forced by minimal-faithful-rendering (`SpaceTime.md` §3a), so the value is rigid, not chosen.
-/

/-- The α⁻¹ construction template: the fixed bare inverse `128 = 2⁷` (selectivity product) plus the
    directional-coupling tensor `d²` at rendering dimension `d`. The **one** free parameter is `d`. -/
def inverseAlpha (d : ℕ) : ℕ := 128 + d * d

/-- At the minimal faithful rendering dimension `d = 3`, `α⁻¹ = 137`. -/
theorem inverseAlpha_at_three : inverseAlpha 3 = 137 := by decide

/-- **R1 — 137 is reached at exactly one dimension.** `inverseAlpha d = 137 ↔ d = 3`: within the frozen
    construction, no rendering dimension but `d = 3` yields `137`. -/
theorem alpha_unique (d : ℕ) : inverseAlpha d = 137 ↔ d = 3 := by
  unfold inverseAlpha
  constructor
  · intro h
    have h9 : d * d = 9 := by omega
    have hle : d ≤ 9 := by nlinarith [h9]
    interval_cases d <;> omega
  · rintro rfl; rfl

/-- **R2 — the headline exclusion.** No admissible dimension other than `d = 3` reaches `137`: the
    construction cannot follow a moving measurement — had α come out otherwise, it is refuted. -/
theorem rival_excluded {d : ℕ} (hd : d ≠ 3) : inverseAlpha d ≠ 137 := fun h => hd ((alpha_unique d).mp h)

/-- **136 dies the second death — unreachable in the frozen family.** No rendering dimension yields
    `128 + d² = 136` (`d² = 8` has no ℕ solution). Together with I3 (`136` composite ⟹ non-elementary),
    `136` dies twice, independently — the anti-Eddington payoff. -/
theorem dimension_136_unreachable (d : ℕ) : inverseAlpha d ≠ 136 := by
  unfold inverseAlpha
  intro h
  have h8 : d * d = 8 := by omega
  have hle : d ≤ 8 := by nlinarith [h8]
  interval_cases d <;> omega

/-- Summary: the elementarity spine (I1–I3, P1) **and** the rigidity over the construction's one free
    parameter are proven — `137` is reached at exactly `d = 3` (`alpha_unique`), no rival dimension
    reaches it (`rival_excluded`), and `136` is unreachable in the family (`dimension_136_unreachable`,
    the second of its two deaths). **Honest scope:** the rigidity is over the *rendering dimension* (the
    construction's genuine free parameter, `d = 3` forced by minimal-faithful-rendering); the further
    claim that the admissible constructions are *exactly* the family `{128 + d²}` — i.e. the grammar
    constraints pin the template up to `d` — is the Step-0 motivated restriction (§6a), not a mechanical
    enumeration over arbitrary `Expr`. The census `N(d)` (issue #116) quantifies the residual. -/
theorem alpha_rigidity_summary : True := trivial

end QLF.AlphaRigidity
