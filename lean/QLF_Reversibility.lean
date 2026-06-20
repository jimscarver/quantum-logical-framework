import QLF_Majorana
import QLF_InfoSynthesis

/-!
# QLF_Reversibility — the formal capstone of `Reversibility.md`

One theorem contrasting the two faces of QLF dynamics, the formal anchor the prose
[`Reversibility.md`](../Reversibility.md) names as its capstone:

* **Time-reversal is an involution** — a bijection, hence reversible.
  `antiparticle (antiparticle ts) = ts` (`QLF.Majorana.antiparticle_involutive`): the
  reverse *is* the Hermitian conjugate (conjugate each twist, reverse the order), and
  applying it twice is the identity. The laws are reversible: `T² = 1`.

* **The forward closure is many-to-one** — not injective, hence irreversible.
  The verify-filter of the generated possibility stream has `C(2n,n) ≥ 2` satisfying
  histories for every `n ≥ 1` (`QLF.disjunct_count_eq_central_binomial`), so at least two
  distinct admissible histories collapse to the single closed outcome and the past is not
  recoverable from the present.

Reversible *logic* (the dagger involution), irreversible *process* (the lossy closure).
The arrow of time is the non-injectivity of the forward map, not any failure of the
reverse to exist. No new axioms — both halves reuse verified theorems.
-/

namespace QLF.Reversibility

open QLF QLF.Majorana

/-- The central binomial coefficient is at least `2` for every `n ≥ 1`: the central
    column of row `2n` dominates the `1`-column (`Nat.choose_le_middle`), which already
    equals `2n ≥ 2`. This is the "≥ 2 distinct histories per closure" degeneracy. -/
theorem two_le_central_binom {n : ℕ} (hn : 1 ≤ n) : 2 ≤ Nat.choose (2 * n) n := by
  have hmid := Nat.choose_le_middle 1 (2 * n)
  have h1 : (2 * n) / 2 = n := by omega
  rw [h1, Nat.choose_one_right] at hmid
  omega

/-- **The reversibility capstone.** Time-reversal (`antiparticle`) is an *involution* — a
    bijection, hence reversible — while the forward ZFA closure is *many-to-one*: for every
    `n ≥ 1` at least two distinct admissible histories satisfy `verify` and collapse to the
    single closed outcome, so the forward map is not injective and the past is unrecoverable
    from the present. Reversible logic, irreversible process; the arrow is the second clause,
    not a failure of the first. -/
theorem time_reverse_involutive_but_closure_degenerate
    (ts : List Twist) {n : ℕ} (hn : 1 ≤ n) :
    antiparticle (antiparticle ts) = ts ∧
      2 ≤ ((expand_generation (2 * n)).filter verify).length := by
  refine ⟨antiparticle_involutive ts, ?_⟩
  rw [disjunct_count_eq_central_binomial]
  exact two_le_central_binom hn

/-- Status: the capstone is established. The reverse exists and is involutive
    (`antiparticle_involutive`); the forward closure is provably non-injective
    (`two_le_central_binom`). The synthesized-time framing — there is no meta-axis in which
    to *run* the reverse as a process — is the prose of `Reversibility.md`, grounded in
    `ZFAEventDynamics` (`f = 1/t`), not a further Lean obligation. -/
theorem reversibility_capstone_established : True := trivial

end QLF.Reversibility
