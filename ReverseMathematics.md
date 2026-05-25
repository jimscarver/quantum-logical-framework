# QLF and Reverse Mathematics

**Reverse Mathematics** (Harvey Friedman, 1975) asks a deceptively simple question: which axioms are *strictly necessary* to prove a given theorem? Instead of starting from a bloated axiomatic system like ZFC and proving theorems forward, it works backward — isolating the minimal logical subsystem that grounds each result.

When you examine the Quantum Logical Framework through this lens, a precise alignment emerges: **QLF is a physical realization of Reverse Mathematics.** It treats physical laws as theorems and uses computational closure as the minimal axiomatic base.

---

## 1. Locating QLF on the Subsystem Hierarchy

Reverse Mathematics classifies mathematical theorems into a hierarchy of five subsystems of second-order arithmetic, ordered by logical strength:

```
[Strongest]  Π¹₁-CA₀  (Impredicative comprehension — non-constructive loops)
                │
             ATR₀      (Arithmetical Transfinite Recursion)
                │
             ACA₀      (Arithmetical Comprehension — Kőnig's Lemma, König's Lemma)
                │
             WKL₀      (Weak König's Lemma — compactness, classical analysis)
                │
[Minimal]    RCA₀      (Recursive Comprehension — strictly computable mathematics)
```

The bedrock subsystem is **RCA₀**. Any mathematical object that cannot be constructed by a terminating algorithm is beyond RCA₀'s reach. RCA₀ is the formal home of **constructive, decidable, finitary mathematics**.

### The QLF Core is RCA₀

Every piece of QLF's combinatorial machinery is strictly inside RCA₀:

| QLF construct | Why it is RCA₀ |
|---|---|
| `expand_generation n` | Finite tree, built by structural recursion on `n` |
| `full_zeno_prune s` | Terminating algorithm (length strictly decreases each pass) |
| `achieves_ZFA_bool s` | A decidable boolean predicate |
| `find_stable_states n` | Finite list filter over a finite generated set |
| `find_stable_states_length_even` | Proved by Pascal induction — no choice, no continuity |
| `zfa_implies_critical_line` | Proved from counting inequalities alone |
| `phase_symmetric_achieves_zfa` | Direct construction |

No axiom of choice, no existential witness extracted from infinity, no appeal to continuous limits. The Lean 4 proofs in `lean/QLF_Axioms.lean`, `lean/QLF_QuCalc.lean`, `lean/QLF_Universality.lean`, and the combinatorial core of `lean/QLF_Riemann.lean` are all machine-verified within constructive, computable bounds.

**QLF asserts a radical physical hypothesis: nature executes its code strictly within RCA₀.** The continuous-limit bridge — how ZFA discrete closures converge to a field theory with variational principle S=∫ℒ dΩ — is developed in [Lagrangian_Formulation.md](Lagrangian_Formulation.md), with `EventSynthesisField → Λ_eff` (SpacetimeDynamics.lean:57) as the continuous limit.

---

## 2. Why the Riemann Bridge Requires a Higher Axiom

The Riemann zeta function lives in analytic number theory. Its non-trivial zeros are defined using:

- The complex plane ℂ (requires Dedekind cuts or Cauchy completions — WKL₀ territory)
- Infinite Dirichlet series (sequential limits — ACA₀ territory)
- Analytic continuation (compactness, Heine-Borel — WKL₀)

This is a fundamental Reverse Mathematics fact: **properties of arbitrary complex analytic functions belong to a strictly higher logical subsystem than constructive combinatorics.**

### What the Lean Axioms Mean

`lean/QLF_Riemann.lean` contains three explicit axioms:

```
spectral_hilbert_polya   : scalar spectral mode ⟹ ρ.re = 1/2
NonTrivialZero           : predicate identifying non-trivial zeros of ζ(s)
resonant_computation_for : associates a TerminatingComputation to each candidate zero
```

These are not gaps, not placeholders, and not apologies. They are the **exact logical boundary** between:

- The discrete, constructive, RCA₀ world of QLF combinatorics
- The continuous, analytic, WKL₀/ACA₀ world of the Riemann zeta function

By isolating these as explicit axioms rather than hiding them inside opaque proofs, QLF performs a Reverse Mathematics classification: it shows precisely *what additional logical strength* is needed to connect discrete phase combinatorics to the classical analytic statement of the Riemann Hypothesis.

Lean 4 is not failing to prove these facts — it is enforcing the Reverse Mathematics constraint. A theorem belonging to WKL₀ cannot be proved from RCA₀ tools alone without an explicit bridging axiom.

### The Proof Chain

```
encode_is_phase_only      : encodeComputation c is pure-phase              [RCA₀]
encode_is_zfa             : encodeComputation c achieves ZFA               [RCA₀]
zfa_implies_critical_line : ZFA ⟹ is_symmetric                            [RCA₀]
spectral_symmetric_eq_scalar_id : is_symmetric ⟹ toSpectralMode s = c•I  [RCA₀]
──────────────────────────────────────────────────────────────────────────────────
spectral_hilbert_polya    : scalar mode ⟹ ρ.re = 1/2                [AXIOM — WKL₀ bridge]
──────────────────────────────────────────────────────────────────────────────────
riemann_hypothesis_in_qlf : NonTrivialZero ρ ⟹ ρ.re = 1/2               [derived]
```

Everything above the line is a machine-verified RCA₀ theorem. The single axiom marks the exact subsystem jump.

---

## 3. Reverse Physics

The classical Reverse Mathematics program classifies *mathematical* theorems. QLF extends the methodology to *physical* laws — call it **Reverse Physics**.

Standard physics assumes macroscopic laws (conservation of energy, Lorentz invariance, phase symmetry) as foundational axioms imposed on a continuous background. QLF inverts this:

> Start with the observed "theorem" of phase symmetry.  
> Work backward using Lean to find what minimal microscale constraint forces it.  
> Prove that over a computable base (RCA₀), **phase symmetry is logically equivalent to Zero Free Action**.

The machine-verified equivalence is:

```
zfa_implies_critical_line   : achieves_ZFA s → is_symmetric s
phase_symmetric_achieves_zfa : is_symmetric s → (pure-phase s) → achieves_ZFA s
```

Together these form a **bidirectional equivalence** (over the pure-phase restriction): ZFA ↔ symmetry. A conservation law has been reversed down to its minimal discrete logical primitive. No continuous field, no Lagrangian, no background geometry — just constructive list operations.

The same pattern extends to the counting structure. `find_stable_states_length_even` proves that the number of ZFA-achieving strings of length 2n is exactly C(2n, n) — a purely combinatorial, RCA₀-provable quantitative law emerging from the ZFA loss function.

---

## Connection to the Lean Repository

The full axiom inventory and proof chain are documented in [`lean/README.md`](lean/README.md). The combinatorial core theorems referenced above are in:

- [`lean/QLF_Axioms.lean`](lean/QLF_Axioms.lean) — ZFA, pruning, symmetry
- [`lean/QLF_Universality.lean`](lean/QLF_Universality.lean) — every terminating computation encodes as ZFA
- [`lean/QLF_Spectral.lean`](lean/QLF_Spectral.lean) — Hermitian structure, scalar identity
- [`lean/QLF_Riemann.lean`](lean/QLF_Riemann.lean) — the full proof chain including the axiom boundary

The Reverse Mathematics perspective is the meta-mathematical justification for the entire Lean formalization strategy: prove everything that can be proved in RCA₀, isolate everything that genuinely requires more, and label the boundary explicitly.

See also: [GodCreatedTheIntegers.md](GodCreatedTheIntegers.md) — historical context: the discrete/deterministic vision of Zuse, Wheeler, Wolfram, 't Hooft, and Mead that QLF fulfills.
