# Reversibility in QLF — the reverse *is* the Hermitian conjugate

In the [Quantum Logical Framework (QLF)](README.md), **time-reversal is the Hermitian conjugate** (the
dagger `†`), and this resolves the old tension between *reversible microscopic laws* and the *forward
arrow of time* — not by a new postulate, but because the two live in different places: reversibility in
the **timeless closure algebra**, the arrow in the **forward synthesis** of closures into the time they
make themselves.

---

## 1. The reverse is the Hermitian conjugate

Machine-verified: the dagger of a process is the conjugate-transpose of its operator,

$$\texttt{eval}(\texttt{dagger}\;p) \;=\; (\texttt{eval}\;p)^{\dagger} \qquad(\text{Lean: } \texttt{eval\_dagger}).$$

The Hermitian conjugate is *complex-conjugate* **and** *reverse-order* — which is exactly quantum
mechanics' antiunitary time-reversal `T = K · (order reversal)`. QLF says it literally at the twist level:
the antiparticle / time-reverse map is

$$\texttt{antiparticle}(ts) \;=\; (ts.\texttt{map}\;\texttt{conj}).\texttt{reverse} \qquad(\text{conjugate each, reverse the sequence}),$$

and across a *sequence* of closures the dagger reverses the order, `(A B C …)† = … C† B† A†`
(`dagger_sequence_reversal`). It is an **involution** — `antiparticle (antiparticle ts) = ts`
(`antiparticle_involutive`), so `T² = 1`: reversible in principle. (Charge conjugation is the same move
viewed spatially — `C_eq_motional_reversal`, `QLF_Spin`.)

## 2. A physical closure is its own time-reverse (`H = H†`)

Every QLF string maps to a Hermitian spectral mode (`toSpectralMode_hermitian`), and **ZFA balance ⟺
symmetric ⟺ the mode is scalar × identity** — self-adjoint (`spectral_symmetric_eq_scalar_id`). So:

> **A physical (ZFA-balanced) closure equals its own Hermitian conjugate, `H = H†`.** It is a *fixed
> point* of time-reversal. **No arrow lives inside a single closure.**

The bra is the dagger of the ket, `⟨ψ| = |ψ⟩†` — a balanced state is consistent with its own time-reverse
(`bra_ket_always_balanced`, `BraKetRhoQuCalc`).

## 3. The arrow is in the *sequencing*, not the laws

If each closure is `H = H†` (no per-event arrow) and the dagger is an involution (reversible), where does
the arrow come from? From the **forward sequencing**. The dagger reverses the *whole product*
(`… C† B† A†`); to apply that reversal as a *process* is to run the history backward — i.e. **to go back
in time**. And in QLF there is **no "back" to go to**, because time is *synthesized by closure*:

$$f = 1/t \qquad(\text{each ZFA event makes its own local time}; \texttt{ZFAEventDynamics}).$$

There is no external time axis in which to perform the reversal: you would have to *un-synthesize the very
time the reversal would run in*. The reverse exists as an **operation on the timeless algebra** (the
dagger); it has **nowhere to run as a process**.

> The laws are time-reversal symmetric (the dagger involution, `H = H†` states). The arrow is the
> condition of being a closure *embedded in its own synthesized time* — not a property of the laws, and
> not a fine-tuned past condition. The observer does not *see* an arrow; the observer *is* the forward
> closure process.

## 4. Two layers of irreversibility — one event

There are two independent reasons you cannot go back, and **the same closure event creates both**:

1. **No meta-time** — each closure synthesizes one tick of local time (`f = 1/t`). Reversing needs an
   outside clock; there is none.
2. **The closure is many-to-one** — it coarse-grains `C(2n,n)` admissible histories into one outcome
   (`disjunct_count_eq_central_binomial`, `QLF_InfoSynthesis`), synthesizing exactly one bit
   `ΔF = −log 2` (`zfa_closure_minimizes_free_energy`, `QLF_FreeEnergy`). Even *with* a meta-time you could
   not uniquely retrodict which history fired — the past is recoverable only up to the closure
   equivalence class.

These are not two phenomena. **Each ZFA closure simultaneously *makes* a tick of time and *discards* the
which-history.** Time and irreversibility are born in the same event — which is exactly why "to be
reversible you would need to go back in time": the time *and* the loss are the same closure, so undoing
the loss means undoing the time, and there is nothing to undo it in.

## 5. The payoff — time-reversal symmetry **is** the critical line

The `H ↔ H†` involution of §1–§2 is the *same* involution behind QLF's
[Riemann program](README.md): its fixed points are the Hermitian (real-eigenvalue) closures, which is the
Hilbert–Pólya / critical-line condition (`spectral_hilbert_polya`, `QLF_Riemann`), and the *same*
`functional_equation_fixed_real` reflection reused by Birch–Swinnerton-Dyer and Hodge
(`bsd_riemann_shared_involution`). So

$$\boxed{\;\text{time-reversal symmetric } (H = H^{\dagger}) \;\;\Longleftrightarrow\;\; \text{real spectrum} \;\;\Longleftrightarrow\;\; \text{on the critical line.}\;}$$

Physical reality is selected as the **self-adjoint = time-reversal-fixed** subset of possibility, and that
selection is the same `H ↔ H†` whose fixed line carries the Riemann zeros. Time-reversal symmetry, the
reality of energies, and the critical line are **one** involution.

## 6. Are reversible theories wrong? — *half-right*

Not wholesale. Reversibility is a **real** symmetry of the QLF laws (the dagger; every closure `H = H†`),
so a reversible theory has the **law-level algebra right**. It goes wrong only when it treats that as the
*whole* universe. A theory that says the universe is reversible **full stop** — no genuine arrow, no real
measurement, no irreversible synthesis — omits the **closure**, and the closure is where time,
definiteness, and information come from, and it is irreversible (§3–§4).

The tell: any purely-reversible theory must still *explain* the arrow of time, the second law, and
measurement — and can only do so by **smuggling in a non-reversible ingredient**:

- a fine-tuned low-entropy **past boundary condition** (the "Past Hypothesis"),
- a separate **collapse postulate**, or
- coarse-graining **by ignorance** ("we just don't track the microstate").

QLF needs none of these crutches — the closure **is** the arrow, constructively (`full_zeno_prune` +
`disjunctive_closure` + `ΔF = −log 2`). So reversible theories are not *false*; they are **incomplete** —
the timeless half (the possibility space, the dagger) without the rendering half (the forward, lossy
closure in synthesized time).

Casualties of the *strong* reversibility claim:

- **Purely-unitary / "no collapse" (Everett):** the unitary algebra is the possibility space, but the
  closure (the OR firing into *one relative world per observer*) is real and irreversible — **many
  observers, not many worlds** (Smolin). Denying the closure is the error.
- **Block universe / eternalism:** the future is not laid out and re-runnable; it is *un-rendered
  possibility*, and "now" is the closure edge. Time is synthesized (`f = 1/t`), not a dimension you can
  drive backward.
- **Deterministic reversible-CA underpinnings** ('t Hooft): a reversible cellular automaton has no genuine
  measurement or arrow; QLF's substrate *selects and prunes* irreversibly — it is not a reversible CA.

And it is the right physics, sharply: QLF's `ΔF = −log 2` per closure **is Landauer's `k_B T ln 2`** — the
irreversible cost of fixing one bit. Reversible *unitary* evolution (the dagger) is real; the moment a
closure yields a *definite* outcome, that step is irreversible — exactly the reversible-gates /
irreversible-measurement split of real quantum computing. "Everything can be reversible computation" is the
claim QLF denies: you can *postpone* the bit, but to **have** a definite world you must close, and closing
costs `log 2` and one tick of time.

## 7. What we can say, if the universe is quantum logical

The second law, decoherence, measurement-without-collapse, and the arrow of time are **one thing** — the
forward, many-to-one, bit-synthesizing direction of ZFA closure, in a time it makes itself. The universe is
**microscopically reversible** (the dagger involution; each closure `H = H†`) and **macroscopically
forward-only** (the synthesis), and *constructively* so — `full_zeno_prune` + `disjunctive_closure` +
`ΔF = −log 2`, not a hand-waved "we just don't track the microstate." No separate arrow postulate, no
fine-tuned initial condition: the arrow is the embedding, and reversal is an algebra operation with no
time to run in.

**Energy conservation is the same lesson.** Just as reversibility is a real symmetry of the *laws* but
not of the *universe*, energy conservation is a real *present-local* balance but not a fundamental global
law: each closure that synthesizes a tick of time also *creates* energy, lending half forward (the cosmic
expansion / dark energy) while the present half balances. The arrow of time and the creation of energy are
the **same** forward event-duality — a TOE that axiomatizes either reversibility *or* global energy
conservation has mistaken the present-local balance of the closure for the whole of it. See
[`Conservation.md`](Conservation.md) §2b.

## Lean anchors

| Statement | Lean |
|---|---|
| the reverse = the Hermitian conjugate | `eval_dagger` (`RhoQuCalc`) |
| dagger reverses the sequence `(AB)† = B†A†` | `dagger_sequence_reversal` (`BraKetRhoQuCalc`) |
| time-reverse is an involution (`T² = 1`) | `antiparticle_involutive` (`QLF_Majorana`) |
| charge conjugation = motional/time reversal | `C_eq_motional_reversal` (`QLF_Spin`) |
| every closure's mode is Hermitian | `toSpectralMode_hermitian` (`QLF_Spectral`) |
| **balanced ⟺ `H = H†`** (self-time-reverse) | `spectral_symmetric_eq_scalar_id` (`QLF_Spectral`) |
| forward closure is many-to-one (`C(2n,n)` histories → 1) | `disjunct_count_eq_central_binomial` (`QLF_InfoSynthesis`) |
| each closure synthesizes one bit `ΔF = −log 2` | `zfa_closure_minimizes_free_energy` (`QLF_FreeEnergy`) |
| time is synthesized, `f = 1/t` | `ZFAEventDynamics` |
| `H = H†` fixed points = the critical line | `spectral_hilbert_polya` (`QLF_Riemann`), `functional_equation_fixed_real` |
| **capstone:** reverse is involutive **but** forward closure is many-to-one | `time_reverse_involutive_but_closure_degenerate` (`QLF_Reversibility`) |

## Honest scope

The pieces are each machine-verified; this document is the **synthesis** that names how they fit —
*reverse = dagger*, *balanced = `H = H†` = self-time-reverse*, *arrow = forward sequencing in synthesized
time*, *`H ↔ H†` = critical line*. The packaging theorem contrasting the **involutive** time-reverse
(`antiparticle_involutive`, a bijection) with the **non-injective** forward closure (`C(2n,n) ≥ 2`
histories per closure) is verified as **`time_reverse_involutive_but_closure_degenerate`**
(`QLF_Reversibility`, no new axioms — both halves reuse existing theorems). The remaining
synthesized-time framing (there is no meta-axis in which to *run* the reverse) is prose grounded in
`ZFAEventDynamics` (`f = 1/t`), not a further Lean obligation. See [`Decoherence.md`](Decoherence.md),
[`Entropy.md`](Entropy.md), [`Conservation.md`](Conservation.md), [`Philosophy.md`](Philosophy.md), and the
synthesized-spacetime account in [`ZFAEventDynamics.lean`](lean/ZFAEventDynamics.lean).
