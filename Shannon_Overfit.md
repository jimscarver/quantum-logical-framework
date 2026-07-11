# The Reals Over-Parameterize Physics — a Shannon proof of non-identifiability

**Status:** Two proven finite theorems (A, B) + one named empirical premise (C). The claim is **not** "the reals are inconsistent" (the consistency guardrail stands — [`TheContinuum.md`](TheContinuum.md), consistency ≠ realizability); it is that an ℝ-valued state space carries, for every possible observation history, uncountably many distinctions that **no finite-capacity channel can ever separate**. Lean: [`lean/QLF_ShannonOverfit.lean`](lean/QLF_ShannonOverfit.lean).

**Companion:** [`Completeness_Evidence.md`](Completeness_Evidence.md) §2a (measurement is counting) and §6 (the reconstruction program, whose finite-capacity postulate this backs).

---

## 0. The sharpening: not overfitting, *non-identifiability*

"The reals overfit physics" is loose — overfitting is fitting noise at the cost of generalization, a statistical vice. The [Quantum Logical Framework](README.md) charge against the continuum is *provably worse and cleaner*: **non-identifiability** — parameters that **no possible data can constrain, even in principle**. Overfitting is a bad bet; non-identifiability is a structural theorem. And it is exactly Shannon-shaped: it is about channel capacity versus the cardinality of what the model claims to distinguish.

## 1. Theorem A — no real is ever received (pigeonhole)

A channel of capacity `C` bits distinguishes at most `2^C` messages — its outputs live in `Fin (2^C)`. Specifying an arbitrary real requires unboundedly many bits, and an *uncomputable* real requires infinitely many with no generating shortcut. So no finite sequence of measurements, of any design, identifies a real number.

> **`no_real_received`** (`QLF_ShannonOverfit`): for every capacity `C` and every receiver `receive : ℝ → Fin (2^C)`, `receive` is **not injective** — distinct reals collapse to the same channel output.

Proof: pigeonhole — no injection from an infinite set into a finite one (reuses [`QLF_Realizability`](lean/QLF_Realizability.lean)'s `real_continuum_not_realizable`, itself `no_continuum_in_finite_region`). This is the load-bearing floor, and it is machine-checked finite combinatorics. **Corollary** (the metrology point of `Completeness_Evidence.md` §2a): every measurement record is a rational-with-interval *necessarily*, not by convention.

## 2. Theorem B — the unconstrained tail (non-identifiability)

Model an idealized real as its infinite bit-stream. Fix any finite dataset `D` = the first `n` bits (`p : ℕ → Bool` observed on `[0, n)`). The set of streams consistent with `D` is

`consistentWith n p := { s | ∀ i, i < n → s i = p i }`.

> **`tail_unconstrained`** (`QLF_ShannonOverfit`): for every `n` and every dataset `p`, `consistentWith n p` is **`Infinite`** — every bit past the `n`-bit prefix is free.

Proof: an explicit injection `ℕ ↪ consistentWith n p` — the tail-witness `tailWitness n p k` agrees with `p` on `[0, n)` and flags position `n + k`, so distinct `k` give distinct consistent states (`tailWitness_injective`, `tailWitness_mem`). Hence `Set.infinite_of_injective_forall_mem`. In estimation terms: the likelihood is flat over the tail, the posterior never updates, the Fisher information about tail bits is identically zero. That **is** the statement "the reals over-parameterize physics" — the model has degrees of freedom with provably zero identifiability from any finite-capacity channel. Also pure finite math (a counting statement about prefixes), no `Real` arithmetic.

## 3. Theorem C — the physical premise that makes it bite

A and B are mathematics. They become *physics* only with one premise:

> **(C) Every bounded physical system/channel has finite information capacity.**

This is not provable — it is empirical — but it is Shannon's legacy plus its physical descendants, each independently and massively supported:

| Support | Statement | Bound it gives |
|---|---|---|
| **Shannon–Hartley** (1948) | finite bandwidth + nonzero noise ⟹ `C = B log₂(1 + S/N)` | finite bits/s per channel |
| **Landauer** (1961) | erasing one bit costs `kT ln 2` | finite bits per unit free energy |
| **Bekenstein / holographic** (1972–) | `S ≤ 2π k R E / ℏc`; bits `≤ A / 4ℓ_P²` | finite bits per bounded region |
| **Heisenberg-limit metrology** | precision bounded by energy·time (Cramér–Rao / QFI) | finite bits per unit energy·time |

Given (C): infinite-precision states are physically impossible, and the continuum's uncountable cardinality does **zero operational work** — the distinguishable state space of any bounded region is finite. Conditional theorem, premise named, premise about as well-supported as physical premises get.

## 4. The honest full statement

> The reals posit uncountably many distinctions (Theorem B). Finite capacity (Shannon + Bekenstein, Theorem C) permits finitely many per bounded system (Theorem A). The surplus is **non-identifiable in principle** — parameters no evidence can ever touch.

Not "the reals are inconsistent" — the guardrail holds. But "**the reals violate finite capacity *if* capacity is finite**," and finite capacity is as well-supported as physical premises come. The continuum is empirically inert at the interface: its extra cardinality is invisible to every experiment.

## 5. Two integration points

**5a. The violation-signature of the finite-capacity postulate.** The reconstruction program (`Completeness_Evidence.md` §6) needs each postulate to ship with its violation signature — what an experiment would look like that breaks it. Breaking the **finite-capacity** postulate is *exactly* "an identifiable real exists": a measurement protocol that pins a real number to arbitrary precision with a finite record. A–C are the formal backing of the capacity row of that postulate table — the negative of `no_real_received` is its violation signature.

**5b. The fantasy tier becomes a defined set, not a label.** `Completeness_Evidence.md`'s surplus-structure charge stratifies ontology by empirical work done. Theorem B upgrades the fantasy tier from rhetoric to arithmetic: **tier 3 = the non-identifiable tail = `consistentWith n p` minus its (single) physical representative** — a *defined, uncountable set of provably idle parameters*, for every finite history. The razor now cuts a named object.

## 6. Honest scope

- **Proven (finite, machine-checked):** A (`no_real_received`) and B (`tail_unconstrained`, via `tailWitness_injective`/`tailWitness_mem`). No `Real` arithmetic — fitting, given the conclusion.
- **Named premise (empirical, not proven):** C, finite physical capacity — the Shannon/Landauer/Bekenstein descendants, each independently supported.
- **Not claimed:** that ℝ is inconsistent (it is not — consistency ≠ realizability, `TheContinuum.md`); that measurement *disproves* the continuum (it shows it *empirically inert at the interface*, the fantasy charge, not a disproof).

## References

### Internal
- [`Completeness_Evidence.md`](Completeness_Evidence.md) — §2a (measurement is counting), §6 (the reconstruction program this backs).
- [`TheContinuum.md`](TheContinuum.md) — consistency ≠ realizability; the five-strike "continuum is gratuitous" case.
- [`lean/QLF_ShannonOverfit.lean`](lean/QLF_ShannonOverfit.lean) — Theorems A and B (`no_real_received`, `tail_unconstrained`).
- [`lean/QLF_Identifiability.lean`](lean/QLF_Identifiability.lean) — the K-free companion form: `capacity_bound` (a `C`-bit record distinguishes ≤ `2^C` states), `consistent_set_infinite` (the finite-precision tail is infinite), and `Identifiable` = has a computable ℚ-approximant (`identifiable_rat`, `identifiable_of_modulus`) — measurement-in-principle *is* computability. The continuum cardinality + the Kolmogorov-`K` tier grading are the residual (issue #115 item 2).
- [`lean/QLF_Realizability.lean`](lean/QLF_Realizability.lean) — the pigeonhole floor Theorem A reuses.

### External
- C. E. Shannon (1948), *A Mathematical Theory of Communication*, Bell Syst. Tech. J. — capacity, Shannon–Hartley.
- R. Landauer (1961), *Irreversibility and heat generation in the computing process*, IBM J. Res. Dev. **5** 183.
- J. D. Bekenstein (1981), *Universal upper bound on the entropy-to-energy ratio for bounded systems*, Phys. Rev. D **23** 287.
- V. Giovannetti, S. Lloyd, L. Maccone (2011), *Advances in quantum metrology*, Nat. Photonics **5** 222 — Heisenberg-limit bits per energy·time.
