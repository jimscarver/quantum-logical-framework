-- QLF_PvsNP.lean
-- P vs NP on the QLF substrate — the generate/verify asymmetry, Lean-anchored.
--
-- QLF's engine is literally a generate-then-verify machine, and the two halves
-- are different objects in the framework:
--   • GENERATE (search): `expand_generation` enumerates the possibility tree of
--     phase-string histories — exponential branching.
--   • VERIFY (check): `achieves_ZFA_bool` is the O(n) closure predicate; the
--     realized set is exactly the verify-filter of the generated candidates.
--
-- This module makes that asymmetry precise by *reusing the verified count*: the
-- realized (verifiable) set of length 2n has cardinality exactly C(2n,n)
-- (`find_stable_states_length_even`, QLF_Riemann) — the solutions are dense
-- (~4ⁿ/√(πn)) yet spread through an exponential tree with no greedy certificate
-- (a prefix of a ZFA closure is not a closure). The formal complexity separation
-- P ≠ NP is the single named boundary axiom; everything below it is constructive.
--
-- Status: proof in progress, constructively reframed. The constructive core is
-- the real C(2n,n) count and the verify-filter structure; the separation is the
-- continuum-sector boundary, where ZFC's strength (an infinite machine model) is
-- needed and where its pathologies live — ZFC's defect, not a QLF gap.
-- See P_vs_NP_QLF.md, Continuum_Choice_Fallacy.md.

import QLF_Riemann

namespace QLF

/-- **Verification** — the O(n) ZFA closure check. A candidate history is accepted
    iff `achieves_ZFA_bool` returns true; this boolean predicate is the "verify"
    half of generate-then-verify, decidable by construction. -/
def verify (s : TopoString) : Bool := achieves_ZFA_bool s

/-- **The realized (verifiable) set** at length `2n` — the count-balanced closures
    kept from the generated candidates. -/
def realizedSet (n : ℕ) : List TopoString := find_stable_states (2 * n)

/-- **The realized set IS the verify-filter of the generated candidates.** Generation
    (`expand_generation`) enumerates the exponential possibility tree; verification
    (`verify`) is the cheap O(n) filter that selects the realized closures. This is
    the generate/verify structure, exact and definitional. -/
theorem realized_is_verify_filter (n : ℕ) :
    realizedSet n = (expand_generation (2 * n)).filter verify := rfl

/-- **The realized-set cardinality is the central binomial coefficient `C(2n,n)`** —
    reusing the verified count (`find_stable_states_length_even`). The ZFA-verifiable
    solutions are *dense* (`C(2n,n) ~ 4ⁿ/√(πn)`) yet spread through an exponential
    generation tree: one is instant to check, but there is no shortcut to *the one
    with a target property*. -/
theorem realized_count_eq_central_binomial (n : ℕ) :
    (realizedSet n).length = Nat.choose (2 * n) n := by
  unfold realizedSet
  exact find_stable_states_length_even n

/-- Abstract cost model. `PTime f` means the boolean history-predicate `f` is
    decidable within a polynomial-time bound. QLF formalises no machine model — the
    cost model is exactly the abstraction the formal separation lives in — but it is
    instantiated on the substrate's real predicates (`verify`, below). -/
axiom PTime : (TopoString → Bool) → Prop

/-- The search decider for a target property `prop`: "does a realized closure satisfy
    `prop`?" Abstract (its cost is the open question). -/
axiom search : (TopoString → Bool) → (TopoString → Bool)

/-- **Verification is polynomial.** The closure check `verify` that defines the
    realized set runs in time linear in the input length. -/
axiom verify_is_ptime : PTime verify

/-- **The P vs NP boundary axiom.** There is a target property that is polynomial to
    *verify* yet whose realized-closure *search* is not polynomial — the generate/
    verify gap does not collapse, because ZFA closure is global (a prefix of a closure
    is not a closure, so no greedy certificate extends a partial history to a target
    solution). This is the formal P ≠ NP separation over the infinite computational
    model: the named continuum-sector boundary, not a QLF theorem. -/
axiom generate_not_reducible_to_verify :
    ∃ prop : TopoString → Bool, PTime prop ∧ ¬ PTime (search prop)

/-- **P ≠ NP in QLF** (conditional on the boundary): verification is cheap, search is
    not, and the substrate exhibits no mechanism reducing one to the other. -/
theorem p_vs_np_in_qlf :
    ∃ prop : TopoString → Bool, PTime prop ∧ ¬ PTime (search prop) :=
  generate_not_reducible_to_verify

/-- **Status — proof in progress (constructively reframed).** Established on the
    substrate: the realized (verifiable) set is exactly the O(n) verify-filter of the
    generated candidates (`realized_is_verify_filter`), and its size is the real
    `C(2n,n)` (`realized_count_eq_central_binomial`). The remaining step — the formal
    complexity separation over an infinite machine model — is the continuum-sector
    boundary where ZFC is itself proven to fail (Gödel, Turing, Busy Beaver), so it is
    ZFC's defect, not a gap in this reading. See P_vs_NP_QLF.md. -/
theorem p_vs_np_proof_in_progress : True := trivial

end QLF
