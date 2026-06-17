# P vs NP in [QLF](README.md)

> **Status: proof in progress, constructively reframed.** Lean-anchored in
> [`lean/QLF_PvsNP.lean`](lean/QLF_PvsNP.lean): the generate/verify asymmetry is proven on
> real theorems (the realized set is the O(n) verify-filter of the candidates, with size
> `C(2n,n)`); the formal complexity separation is the remaining step, over an infinite
> computational model — the continuum/choice sector where ZFC is *itself proven to fail*
> (Gödel/Turing/Busy Beaver). That step is ZFC's defect, not a gap in this reading. See
> [Open_Problems.md](Open_Problems.md). Unifying thesis:
> [Continuum_Choice_Fallacy.md](Continuum_Choice_Fallacy.md).

## 1. The classical problem

The most famous Millennium Prize Problem: is **P = NP**? Is every problem whose
solution can be *verified* quickly (NP) also *solvable* quickly (P)? Equivalently,
is search no harder than checking? The expected answer is **P ≠ NP** — that finding
a needle is fundamentally harder than recognising one — but no proof is known, and
the difficulty is that lower bounds on computation are notoriously hard to establish.

## 2. The QLF substrate already separates the two operations

QLF's engine is literally a *generate-then-verify* machine, and the two halves have
visibly different cost:

- **Generate (search).** The QuCalc expansion enumerates the possibility space of
  phase-string histories. At depth `2n` the branching is exponential: there are
  `4^n` length-`2n` twist strings before any filtering. This is the modal-realist
  space — *all* logically admissible histories exist a priori
  ([Philosophy.md](Philosophy.md)); finding the physical ones is a search through an
  exponentially large tree.
- **Verify (check).** ZFA closure is a **linear-time** predicate: walk the string
  once and check `count_pos = count_neg` (and Pauli closure, which
  `count_balanced_pauli_closed` shows is entailed). `qlf_universality`
  ([`lean/QLF_Universality.lean`](lean/QLF_Universality.lean)) is the statement that
  this O(n) closure check is exactly what selects the physical (terminating)
  computations from the full ruliad. Verification is cheap; generation is not.

So in QLF the **P/NP boundary is the boundary between the ZFA *filter* and the QuCalc
*generator*.** Verification = "is this history a ZFA closure?" (P). Search =
"produce a ZFA closure with property X" (NP). They are different objects in the
framework, not two views of one.

## 3. The structural reading: why the asymmetry should be irreducible

QLF's selection principle gives a reason the asymmetry does not collapse:

- **Closure is global; it cannot be assembled greedily.** A ZFA closure is balanced
  *as a whole* (and Pauli-closed in *order*); a prefix of a closure is generally not
  a closure (the half-spin pruning `full_zeno_prune` discards unclosed fractions).
  There is no local certificate that a partial history can be *extended* to a
  closure with a target property — which is precisely the obstruction to turning
  fast verification into fast search.
- **Of the exponentially many depth-`2n` histories, exactly `C(2n,n)` are ZFA-balanced**
  (`find_stable_states_length_even`, [`lean/QLF_QuCalc.lean`](lean/QLF_QuCalc.lean)) —
  a `~4^n/√n` fraction. The solutions are dense enough to verify one instantly yet
  spread through the tree with no shortcut to *the one you want*.
- This is the same wall as the **Busy-Beaver / ZFC ultraviolet catastrophe**
  ([Active_Inference_Mathematics.md](Active_Inference_Mathematics.md) §6,
  [ReverseMathematics.md](ReverseMathematics.md)): QLF lives at the **RCA₀** floor,
  below the uncomputable. Within that floor, the cost of *constructing* a witness is
  not bounded by the cost of *recognising* one — the generator and the filter are
  genuinely separate machines.

QLF therefore *leans* P ≠ NP: search through the possibility space is structurally
heavier than the linear closure check, and the framework exhibits no mechanism that
reduces one to the other.

## 4. Where the boundary sits

A *structural* asymmetry is not a *complexity-theoretic lower bound*. Turning
"closure is global and has no greedy certificate" into "no polynomial-time algorithm
decides SAT" is the genuinely hard analytic/combinatorial step — the same kind of
RCA₀ → higher-strength crossing QLF marks elsewhere with an explicit axiom. QLF makes
the generate/verify gap concrete and gives a substrate reason it should not close; the
formal separation P ≠ NP is the remaining step, over an infinite computational model —
the sector where ZFC is *itself proven to fail* (Gödel/Turing/Busy Beaver). It is ZFC's
defect, not a gap in this reading.

This is Lean-anchored in [`lean/QLF_PvsNP.lean`](lean/QLF_PvsNP.lean): the two halves
that *are* QLF facts are proven by reusing verified theorems — the realized set IS the
O(n) verify-filter of the generated candidates (`realized_is_verify_filter`, definitional)
and its cardinality is the genuine `C(2n,n)` (`realized_count_eq_central_binomial`, reusing
`find_stable_states_length_even`) — while the separation itself is the single explicit
boundary axiom `generate_not_reducible_to_verify` over an abstract `PTime`/`search` cost
model, with the `p_vs_np_proof_in_progress` status marker.

## 5. Epistemic stance

Within QLF's frame, P ≠ NP is the computational face of the same principle as the
ZFC ultraviolet catastrophe: **possibility is cheap to enumerate and cheap to check,
but expensive to *select*.** The universe is the ZFA-closed subset of an exponential
possibility space, and there is no free lunch that hands you the closure you want
without searching for it. The circuit lower bound is the remaining step, and it lives in
the same infinite-model sector where ZFC is proven to fail — so this document names that
boundary as ZFC's defect, and claims the substrate-constructive asymmetry as genuine
progress, not as a finished ZFC proof.

## References

- S. A. Cook, *The complexity of theorem-proving procedures*, Proc. 3rd ACM STOC (1971) 151–158 — NP-completeness.
- L. A. Levin, *Universal sequential search problems*, Probl. Peredachi Inf. **9** (1973) — independent formulation.
- R. M. Karp, *Reducibility among combinatorial problems*, in *Complexity of Computer Computations* (1972) 85–103.
- S. Cook, *The P versus NP Problem* — Clay Mathematics Institute (official problem description). <https://www.claymath.org/millennium-problems/>
