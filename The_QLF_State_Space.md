# The Space QLF Lives In — Gaussian-Integer Lattices, not Hilbert Space

Hilbert space is the right home for *general* quantum mechanics, and it is **too general** for [QLF](README.md) — by exactly the same continuum it adds to everything else. A separable Hilbert space `ℂ^∞` has three features QLF rejects:

- the **cardinality of the continuum** (uncountably many states),
- **continuous `U(1)` phases** (an amplitude can be any unit complex number),
- **infinite dimension** (a fixed `ℵ₀` worth of independent directions).

None of these is physically realized — a finite-information region holds finitely many distinguishable states (Bekenstein; machine-checked as `no_continuum_in_finite_region` in [`lean/QLF_Realizability.lean`](lean/QLF_Realizability.lean)). So Hilbert space is not where QLF *lives*; it is the **completion** of where QLF lives. The substrate's state space is the discrete, computable structure underneath:

> **QLF's state space is a finite-rank free module over the Gaussian integers `ℤ[i]` — a Gaussian-integer lattice — with phases in `μ₄ = {±1, ±i}` and rational Born probabilities. Hilbert space `ℂ^∞` is its continuum limit.**

Every clause is grounded in already-verified code.

---

## 1. The phase group is `μ₄`, not `U(1)`

Standard QM lets a state pick up any phase `e^{iθ}`, `θ ∈ [0, 2π)` — a continuous circle. QLF's phases are **discrete**. Every balanced closure folds to a **Pauli scalar** `{+I, −I, +iI, −iI}` (`count_balanced_pauli_closed`, [`lean/QLF_TwistAlphabet.lean`](lean/QLF_TwistAlphabet.lean)), and that four-element set is exactly

$$\{\,i^0,\,i^1,\,i^2,\,i^3\,\} \;=\; \mu_4 \;=\; \text{the 4th roots of unity} \;=\; (\mathbb{Z}[i])^\times,$$

the **units of the Gaussian integers**. This is machine-checked in [`lean/QLF_StateSpace.lean`](lean/QLF_StateSpace.lean): every phase satisfies `p⁴ = 1` (`pauliScalar_pow_four_eq_one`), `i` generates a group of order exactly 4 (`pauliScalar_i_order_four`), and the embedding into `ℂ` lands on the complex 4th roots of unity (`toComplex_pow_four`). The continuous circle `U(1)` is replaced by its four-point cyclic subgroup `μ₄ = ℤ/4`.

---

## 2. Amplitudes are Gaussian integers; Born probabilities are rational

The substrate's generators are the Pauli matrices, and their **entries are Gaussian integers**:

$$\sigma_x = \begin{pmatrix}0&1\\1&0\end{pmatrix},\quad \sigma_y = \begin{pmatrix}0&-i\\i&0\end{pmatrix},\quad \sigma_z = \begin{pmatrix}1&0\\0&-1\end{pmatrix} \;\subset\; M_2(\mathbb{Z}[i]).$$

Every twist fold is a product of these, so it lives in `M₂(ℤ[i])`. The Born amplitude is the path sum ([`Born_Rule.md`](Born_Rule.md))

$$\langle \varphi \mid \psi \rangle = \sum_{h} e^{i\theta(h)}, \qquad e^{i\theta(h)} \in \mu_4,$$

a sum of 4th-roots-of-unity — hence a **Gaussian integer** `a + bi ∈ ℤ[i]`. The Born probability is then

$$P(\varphi\mid\psi) = \frac{|\langle\varphi\mid\psi\rangle|^2}{Z} = \frac{a^2 + b^2}{Z},$$

a **ratio of non-negative integers** (a net constructive path-count over the integer partition function `Z`). Probabilities are **rational, computable, RCA₀** — there is no irrational amplitude and no continuum anywhere in the exact substrate. (This is the state-space face of `Shannon_And_Phase.md`: the count is `|a|²`, the phase is `arg ∈ μ₄`.)

---

## 3. Finite-dimensional per causal horizon

A separable Hilbert space has a fixed infinite dimension. QLF's state space is **finite-dimensional at every causal horizon**: the possibility tree at depth `n` is finite (`C(2n,n)` ZFA-stable closures among `4ⁿ`), and a bounded region resolves only finitely many distinguishable states (Bekenstein, [`lean/QLF_Realizability.lean`](lean/QLF_Realizability.lean)). So the state space is a **finite-rank `ℤ[i]`-module**; its rank *grows* with horizon depth but is always finite. Infinite dimension is never instantiated — it is the limit, not the substrate.

---

## 4. The algebra: the Pauli/Clifford `*`-algebra over `ℤ[i]`

The operators are `M₂(ℤ[i])` and its tensor powers, with the **Hermitian conjugate `†`** as the `*`-involution ([`Reversibility.md`](Reversibility.md), `eval_dagger`; a balanced closure is self-adjoint, `H = H†`). This is precisely the **stabilizer / Clifford fragment** of quantum mechanics — the part that is *efficiently classically simulable* (the Gottesman–Knill theorem), i.e. **computable**. QLF's reading is the natural one: the **substrate is the computable `ℤ[i]` (Pauli/Clifford) fragment**, and the continuum amplitudes of *universal* quantum mechanics — the `T`-gate, arbitrary rotations, irrational amplitudes — are the **statistical limit** as the `ℤ[i]`-lattices densify. The discreteness that makes the substrate simulable is the discreteness that makes it physical.

---

## 5. Hilbert space is the completion

As the causal horizon grows, the finite-rank `ℤ[i]`-lattices **nest and densify**; their colimit, metrically completed, is the separable Hilbert space `ℓ²(ℂ)`. So Hilbert space is the **rendering** of the substrate — the continuum closure of a discrete, computable lattice — exactly as the smooth manifold is the rendering of the causal set and `ℝ` is the rendering of the computable reals ([`TheContinuum.md`](TheContinuum.md)). It is "too general" because it contains the entire continuum tail (uncountable states, continuous phases, infinite dimension) that the substrate never realizes. QM works *through* the limit; QLF says the substrate is the discrete object the limit is taken of.

---

## 6. Where `ℤ[i]` meets `ℂ`: the Riemann boundary

The substrate's spectral operators are `M₂(ℤ[i])`-valued (`toSpectralMode`, [`lean/QLF_Spectral.lean`](lean/QLF_Spectral.lean)). But a *zero of `ζ`* — the critical-line eigenvalue `ρ ∈ ℂ` — lives in the analytic continuum. That crossing, from the discrete `ℤ[i]` substrate to the continuous `ℂ`, is *exactly* where QLF's one Riemann bridge axiom sits (`spectral_hilbert_polya`). The state-space picture says precisely why Riemann is a *boundary* problem: the substrate is `ℤ[i]`; `ζ`'s zeros are in `ℂ`; the bridge is the rendering.

---

## 7. Honest scope, and the one open refinement

- **Settled (grounded in proven theorems):** the phase group is `μ₄ = (ℤ[i])ˣ` (`QLF_StateSpace.lean`, `count_balanced_pauli_closed`); the `σ`-generators and folds are `ℤ[i]`-valued; Born probabilities are rational; the state space is finite-dimensional per horizon (`QLF_Realizability`). The *discreteness* of the state ring — a cyclotomic integer ring, **not `ℂ`** — is the firm claim, and it is what makes "Hilbert space is too general" precise.
- **The Hilbert-space-as-completion** statement is the continuum-as-limit thesis of [`TheContinuum.md`](TheContinuum.md) applied to the state space — structural, not a new theorem.
- **Open refinement.** Superposition / the Hadamard gate introduce `1/√2`, which would enlarge the *Clifford* ring to `ℤ[ζ₈] = ℤ[1/\sqrt2,\,i]` (the 8th cyclotomic ring) — and QLF's alphabet is, suggestively, **8-twist**. So the precise open question is whether QLF's exact state ring is `ℤ[i]` (the gauge/closure core) or `ℤ[ζ₈]` (with `√2` from superposition). Either way the answer is a **cyclotomic integer ring, not the complex continuum** — that is the part that is settled.
- **Not claimed:** that QLF *is only* stabilizer QM. QLF derives *universal* quantum mechanics — but through the continuum *limit* of the discrete substrate, not by making the continuum fundamental.

**The one-line answer:** QLF lives in a Gaussian-integer lattice with `μ₄` phases — the computable, finite-dimensional Pauli/Clifford world over `ℤ[i]` — and Hilbert space is the continuum it completes to.

## See also

- [`lean/QLF_StateSpace.lean`](lean/QLF_StateSpace.lean) — the `μ₄ = (ℤ[i])ˣ` phase group, machine-checked.
- [`lean/QLF_Pauli.lean`](lean/QLF_Pauli.lean) · [`lean/QLF_TwistAlphabet.lean`](lean/QLF_TwistAlphabet.lean) (`count_balanced_pauli_closed`) — the phase group and the fold.
- [`Born_Rule.md`](Born_Rule.md) · [`Shannon_And_Phase.md`](Shannon_And_Phase.md) — amplitudes as phase-weighted path counts; count vs phase.
- [`TheContinuum.md`](TheContinuum.md) · [`lean/QLF_Realizability.lean`](lean/QLF_Realizability.lean) — the continuum as completion; finite-information realizability.
- [`Reversibility.md`](Reversibility.md) · [`lean/QLF_Spectral.lean`](lean/QLF_Spectral.lean) — the `†`-involution and the spectral mode / Riemann boundary.
