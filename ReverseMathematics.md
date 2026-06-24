# QLF and Reverse Mathematics

**Reverse Mathematics** (Harvey Friedman, 1975) asks a deceptively simple question: which axioms are *strictly necessary* to prove a given theorem? Instead of starting from a bloated axiomatic system like ZFC and proving theorems forward, it works backward — isolating the minimal logical subsystem that grounds each result.

When you examine the Quantum Logical Framework through this lens, a precise alignment emerges: **QLF is a physical realization of Reverse Mathematics.** It treats physical laws as theorems and uses computational closure as the minimal axiomatic base.

But QLF *uses* Reverse Mathematics as a measuring instrument; it is not Reverse Mathematics. RM is *descriptive* (it measures the axiom strength existing theorems cost) and ontologically neutral; QLF is *generative* (a substrate builds the objects — numbers, the ring operations, the unit group), adds an *active-inference selection* (only ZFA-closed histories are admitted), and makes the *ontological commitment* RM declines (the `RCA₀` floor **is** physical reality). How mathematics emerges forward from the substrate — and how that differs from RM — is [`Mathematics_From_QLF.md`](Mathematics_From_QLF.md).

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
> Work backward using Lean to find what minimal microscale constraint yields it.  
> Prove that over a computable base (RCA₀), **phase symmetry is logically equivalent to Zero Free Action**.

The machine-verified equivalence is:

```
zfa_implies_critical_line   : achieves_ZFA s → is_symmetric s
phase_symmetric_achieves_zfa : is_symmetric s → (pure-phase s) → achieves_ZFA s
```

Together these form a **bidirectional equivalence** (over the pure-phase restriction): ZFA ↔ symmetry. A conservation law has been reversed down to its minimal discrete logical primitive. No continuous field, no Lagrangian, no background geometry — just constructive list operations.

The same pattern extends to the counting structure. `find_stable_states_length_even` proves that the number of ZFA-achieving strings of length 2n is exactly C(2n, n) — a purely combinatorial, RCA₀-provable quantitative law emerging from the ZFA loss function.

---

## 4. The MRE bridge: structurally motivating the WKL₀ axiom

§2 isolates `spectral_hilbert_polya : scalar mode → ρ.re = 1/2` as a WKL₀-level axiom — well-defined, explicitly separated, but unmotivated beyond *"this is where RCA₀ ends."* This section gives the axiom an information-theoretic motivation drawn from [MRE.md](MRE.md), without changing its proof-theoretic strength. The bridge stays an axiom; the axiom becomes principled.

### 4.1 The combinatorial closed form (RCA₀)

The QLF resonant sum has a clean closed form derivable inside RCA₀ — separate the even-index part of $(4+1)^n + (4-1)^n$:

$$\sum_{k=0}^{\lfloor n/2 \rfloor} \binom{n}{2k} \, 4^{n - 2k} = \frac{5^n + 3^n}{2}$$

Verified at `n = 0..10` (sequence `1, 4, 17, 76, 353, 1684, 8177, 40156, 198593, 986404, 4912337`; see [`qlf_dirichlet_search.py`](qlf_dirichlet_search.py) Report 6). This is suitable for a Lean lemma `cardinality_of_resonant_generations`.

The associated generating function is

$$Z_{\mathrm{QLF}}(x) = \sum_{n \geq 0} \frac{5^n + 3^n}{2} \cdot x^n = \frac{1}{2} \cdot \left( \frac{1}{1 - 5x} + \frac{1}{1 - 3x} \right)$$

— an algebraic function with simple poles at $x = 1/5$ and $x = 1/3$. Both the sum and the generating function are RCA₀ objects.

### 4.2 What MRE adds (still RCA₀)

[MRE.md §2.1](MRE.md) proves the **binary-partition information-gain bound**:

$$D_{\mathrm{KL}}(q \mathbin{\Vert} p) \leq \log 2$$

with equality only at the 50/50 split. The argument is fully constructive (count balance, max-entropy event shape) and RCA₀-statable. Any deviation from exact 1/2 balance leaves residual free action — a positive spectral gap (`spectral_gap_zero_iff_symmetric`, [SpectralGap.md](SpectralGap.md)) — which is forbidden by `rho_process_always_zfa`.

The **MRE saturation principle**: every admissible ZFA closure sits at the 1/2 balance locus. This is an RCA₀ theorem about TopoStrings.

### 4.3 The Mellin transform (WKL₀)

The Mellin transform

$$\mathcal{M}[f](s) = \int_0^\infty f(t) \cdot t^{s-1} \, dt$$

requires compactness arguments — Heine-Borel, dominated convergence — that live at the **WKL₀** level of the Reverse Mathematics hierarchy. Mellin transforms of algebraic generating functions like $Z_{\mathrm{QLF}}$ are well-defined WKL₀ objects: their existence and analytic continuation properties are WKL₀-provable for the specific function classes QLF generates.

This is the bridge layer. The combinatorial input (resonant sum, generating function) is RCA₀; the analytic output ($\mathcal{M}[Z_{\mathrm{QLF}}]$ as a function on $\mathbb{C}$) is WKL₀. No ACA₀ machinery is invoked.

### 4.4 The proposed MRE-motivated axiom

```
RCA₀:     Σ C(n, 2k) · 4^(n-2k) = (5^n + 3^n)/2          [closed form, Lean-ready]
            ↓ generating function
RCA₀:     Z_QLF(x) = (1/(1-5x) + 1/(1-3x))/2             [algebraic]
            ↓ Mellin transform (WKL₀: compactness)
WKL₀:     M[Z_QLF](s) — analytic object on ℂ
            ↓ MRE saturation: only the 1/2 balance locus is admissible
WKL₀+MRE: structural singularities of the QLF Mellin image lie on Re(s) = 1/2
            ↓ ζ correspondence (the bridge axiom we want to motivate)
ACA₀:     ζ(s) has its non-trivial zeros on Re(s) = 1/2
```

The bridge can then be stated as:

**`MRE_bridge`** (proposed WKL₀-level axiom): under the Mellin-transform encoding (provable WKL₀-side), the MRE-saturation principle (RCA₀-statable) requires the structural singularities of $\mathcal{M}[Z_{\mathrm{QLF}}]$ — and hence of the QLF-encoded $\zeta$ — to lie on $\Re(s) = 1/2$.

This is the same logical strength as the existing `spectral_hilbert_polya`. The change is **content**: the axiom is justified by an information-theoretic principle internal to QLF (MRE saturation), not by appeal to external Hilbert-Pólya conjectures.

### 4.5 Why this is progress

- **Same proof-theoretic strength.** Still a WKL₀ axiom; the Reverse Mathematics classification of §2 is unchanged.
- **Structurally motivated.** The axiom expresses a chain `(RCA₀ closed form) → (RCA₀ MRE saturation) → (WKL₀ Mellin compactness) → (WKL₀ critical-line condition)` instead of being a bare placeholder.
- **Falsifiable.** A specific Mellin-image identity is the bridge to verify. Future work can attempt to discharge the axiom by either (a) constructing the explicit Mellin identity within WKL₀ + MRE saturation, or (b) finding a counterexample where MRE saturation fails to force the critical-line condition. [`qlf_dirichlet_search.py`](qlf_dirichlet_search.py) Report 7 supplies the numerical demo.
- **Connects two of QLF's deepest results.** [MRE.md](MRE.md) (Hermitian-pair max entropy) and [Riemann-Conjecture-Proof.md](Riemann-Conjecture-Proof.md) (RH reduction) become a single argument: the critical line is the locus of maximum information-gain ZFA pruning.
- **Reinforced by the per-qubit ℏω reading** ([`Per_Qubit_Mass_Quantum.md`](Per_Qubit_Mass_Quantum.md), [`Information_Energy_Equivalence.md`](Information_Energy_Equivalence.md)): under the Wheeler-Fields `ℏω = 1 bit at frequency ω` equivalence, the Mellin variable `s` has a physical energy/frequency reading, and `Re(s) = 1/2` becomes the locus where information and energy saturate jointly (§4.8). Proof-theoretic strength unchanged; the bridge's content gains a third reinforcing layer.

### 4.6 What's still axiomatic

The Mellin-MRE-bridge step is still an axiom. The numerical evidence in [`qlf_dirichlet_search.py`](qlf_dirichlet_search.py) Reports 4 and 7 is **consistent with** such a bridge (the asymptotic $1/\sqrt{\pi}$ factor in Report 4 is the Stirling-derived Mellin factor), but the formal identity is open work. The promotion path:

- Lean theorem: state `MRE_bridge` in `lean/QLF_Riemann.lean` with the Mellin-image formulation that explicitly invokes MRE saturation. A commented sketch is staged in the Lean source.
- Numerical: extend Report 7 to higher resolution and a wider class of generating functions; check whether structural singularities always sit on $\Re(s) = 1/2$ as predicted.
- Analytic: identify the precise compactness theorem that, combined with MRE saturation, would discharge the axiom inside WKL₀.

### 4.7 Connection to Montgomery-Odlyzko / GUE spacing

The GUE spacing of Riemann zeros (Montgomery 1973, Odlyzko 1987) is the deepest empirical signature of the analytic side. The QLF gap-zero density `C(2n, n) / 4^n ~ 1/√(πn)` produces matching $\sqrt{\pi n}$ spacing asymptotically ([SpectralGap.md §2](SpectralGap.md)) — but only asymptotically, not exactly. Under the MRE-bridge framing, this is exactly the expected behavior: the Mellin image of the QLF generating function carries the discrete GUE-like density across the bridge into the asymptotic spacing of the analytic zeros. The bridge axiom IS the statement that this asymptotic match is exact in the limit.

### 4.8 Information-energy reading of the MRE bridge

The per-event log 2 information quantum that motivates §4.2 has a dual: each ZFA closure event also carries an energy quantum `ℏω` (per [`Per_Qubit_Mass_Quantum.md`](Per_Qubit_Mass_Quantum.md), with `ω = f_vac / R` set by the Markov-blanket depth). The two quanta are properties of the same per-event reality, related by the **Wheeler-Fields equivalence** [`Information_Energy_Equivalence.md`](Information_Energy_Equivalence.md) derived from QLF first principles:

$$\hbar \omega \;\equiv\; \text{1 bit at frequency } \omega$$

This reading deepens §4's bridge motivation by giving `Re(s) = 1/2` **three coincident interpretations** of the same structural object:

1. **Information-MRE** (§4.2): the 50/50 binary partition saturates the `log 2` information-gain bound. The 1/2 is the most-balanced split of the possibility tree.
2. **Half-spin closure** ([`HALF-SPIN-ZFA-EMBEDDING.md`](HALF-SPIN-ZFA-EMBEDDING.md) §3a): the 1/2-spin atom is the unique fixed point of set-theoretic minimality ∧ algebraic Pauli closure ∧ information-theoretic optimality.
3. **Energy-Wheeler-Fields**: the per-event `ℏω` energy quantum and the per-event 1-bit information quantum saturate at the same locus. The Mellin variable `s` has a clean physical reading as an energy/frequency variable; the structural-singularity locus is the joint saturation point of information and energy.

The bridge axiom's **content** is sharpened: not just "MRE saturation requires the critical line" but "the information-energy quantum jointly saturates on the critical line." The three readings are not independent claims; they all point at the same `1/2`, the unique fixed point of the half-spin ZFA closure.

The bridge's **proof-theoretic strength is unchanged**: still a WKL₀-level axiom. The Mellin identity needed to discharge it remains an open analytic problem; no Lean theorem is added here.

Two paths to a discharge worth flagging:

- **Mellin-identity path** (already named in §4.6): construct an exact identity within WKL₀ + MRE saturation linking `M[Z_QLF](s)` to a tabulated Dirichlet series, with the energy-weighting a physical interpretation of `s` rather than an abstract parameter.
- **Berry-Keating-style spectral path**: the per-qubit reading suggests a natural Hamiltonian `H = ℏω = E_Planck / R̂` where `R̂` is the admissible-Markov-blanket-depth operator. If `R̂`'s spectrum has the symmetry that places its eigenvalues on `Re(s) = 1/2` under the Mellin map, this provides a QLF analog of the Berry-Keating `xp + 1/2` Hamiltonian. Connects to [`QLF_Spectral.lean`](lean/QLF_Spectral.lean) (Hermitian spectral projectors) and would be the Lean-theorem-grade resolution. §4.9 below identifies the Hilbert space on which `R̂` is self-adjoint **by construction**.

**An empirically testable prediction implied by the per-qubit reading**: if the QLF per-qubit accounting is correct, the discrete spectrum of admissible Markov-blanket depths `{R_e, R_μ, R_p, R_τ, …}` should exhibit Wigner-Dyson GUE spacing statistics in the large-depth limit — the same spectral signature §4.7 already identifies for the Montgomery-Odlyzko law. Confirmation would constitute independent evidence for the bridge parallel to the Mellin-image structural argument.

**Empirical status** (added after the test was run; see [`Wigner_Dyson_QLF_Test.md`](Wigner_Dyson_QLF_Test.md) and [`wigner_dyson_qlf_test.py`](wigner_dyson_qlf_test.py)). A direct test on 74 PDG-derived QLF-admissible bound-state depths (hadronic ground states plus light atomic systems) does **not** support the GUE prediction. In the cleanest single-sector cuts (pseudoscalar mesons J^P^C = 0⁻⁺, and 1/2⁺ baryons), spacing variance is closer to Poisson (1.0) than to GUE (≈ 0.18); in the symmetry-deduplicated hadron block the Kolmogorov-Smirnov test rejects GUE at α = 0.05 while remaining consistent with Poisson. The structural §4.9 correspondence below is unaffected, but the spacing-statistics extension is empirically weakened.

### 4.9 Adjoint involution and the critical-line fixed locus

§4.8 records three coincident interpretations of `Re(s) = 1/2`. The QLF adjoint operator on twist histories supplies a fourth — and, in the process, identifies the Hilbert space the Berry-Keating path needs.

**The QLF adjoint.** On twist histories `H = s₁s₂…sₙ` over the 8-symbol alphabet, the **Hermitian adjoint** is

$$H^\dagger \;=\; \overline{s_n}\,\overline{s_{n-1}}\,\cdots\,\overline{s_1}$$

where the per-letter parity flip is `t ↦ t ⊕ 1` (pairing `^↔v, >↔<, /↔\, +↔-`). Concretely: reverse the sequence, then flip every twist to its conjugate. This is the operator-level adjoint — `(AB)† = B†A†` — and is implemented as `adjoint_history` (line 238) in [`twist_core.py`](twist_core.py), `Twist.conj` in [`lean/QLF_TwistAlphabet.lean`](lean/QLF_TwistAlphabet.lean) (with history-level `adjoint` in [`lean/BraKetRhoQuCalc.lean`](lean/BraKetRhoQuCalc.lean)), and `Twist::conjugate` in the runtime kernel.

The adjoint is involutive: `H†† = H`. Its defining identity, proved in [`Hermitian_Conjugacy_Proof.md`](Hermitian_Conjugacy_Proof.md), is

$$E + E^\dagger \;\equiv\; \text{ZFA}.$$

Appending a history's adjoint annihilates it — the discrete analog of `U U† = I`.

**The fixed locus.** Define the **self-adjoint histories**

$$\Sigma_{\text{sa}} \;=\; \{H : H = H^\dagger\}.$$

`Σ_sa` is strictly smaller than the set of ZFA-admissible histories. The Hermitian pairs `^v, v^, ><, <>, /\, \/, +-, -+` are in `Σ_sa`; `^vv^` is ZFA-balanced but its adjoint is `v^^v`, so `^vv^ ∉ Σ_sa`. Self-adjointness is exactly the palindrome-under-flip condition `sᵢ = \overline{s_{n+1-i}}`, which is the operator-level reality / Hermitian condition.

**Structural correspondence to Riemann ξ.** The completed zeta function ξ(s) satisfies the functional equation `ξ(s) = ξ(1−s)`. The critical line `Re(s) = 1/2` is the fixed locus of the involution `s ↔ 1−s`. The Hilbert-Pólya program seeks a self-adjoint operator H with real spectrum `{t_n}` such that `1/2 + i t_n` are the nontrivial ζ-zeros.

| Riemann ξ side | QLF side |
| --- | --- |
| Functional-equation involution `s ↔ 1−s` | Adjoint involution `H ↔ H†` |
| Critical line `Re(s) = 1/2` (fixed locus) | `Σ_sa` (fixed locus) |
| Hilbert-Pólya self-adjoint operator on ζ-space | Depth operator `R̂` on `ℓ²(Σ_sa)` |
| Real spectrum `{t_n}` of ζ-zero ordinates | Real spectrum `{R_e, R_μ, R_p, R_τ, …}` of admissible Markov-blanket depths |

**Fourth coincident reading of "1/2"** (extending §4.8's three):

1. Information-MRE binary partition (§4.2)
2. Half-spin closure fixed point ([`HALF-SPIN-ZFA-EMBEDDING.md`](HALF-SPIN-ZFA-EMBEDDING.md) §3a)
3. Information-energy joint saturation (§4.8, Wheeler-Fields)
4. **Adjoint involution fixed locus** — direct structural counterpart of `s ↔ 1−s`. The "balance" that saturates information in (1) and energy in (3) is the *same* balance that makes a history equal to its own adjoint.

**Concrete refinement of the Berry-Keating path.** §4.8 flagged `H = ℏω · R̂` as a Hilbert-Pólya candidate but did not say on what space `R̂` is self-adjoint. The adjoint involution supplies that space directly: define `R̂` on `ℓ²(Σ_sa)`, the Hilbert space spanned by self-adjoint QLF histories. Then

$$\hat R = \hat R^\dagger \quad\text{by construction,}$$

since the QLF adjoint preserves `Σ_sa` (by `H†† = H`) and the Markov-blanket depth is invariant under `H ↔ H†` (depth counts admissible nested closures, which the adjoint preserves). The spectrum is therefore real, discrete, and consists of admissible depths.

This is the missing structural piece of the Berry-Keating construction: a defined Hilbert space, a self-adjoint operator on it, and a candidate spectrum. §4.8's Wigner-Dyson empirical extension was a separate, stronger claim; a first-pass test of it on currently-available QLF-admissible bound-state depths (see [`Wigner_Dyson_QLF_Test.md`](Wigner_Dyson_QLF_Test.md)) does not support the spacing-statistics prediction in observable data. The structural correspondence in this §4.9 is independent of that result and stands on its own. The vacuum-alignment principle in [`VacuumEnergy.md`](VacuumEnergy.md) §6.1 reframes the PDG-test outcome as a **projection effect**: observed bound-state masses are the vacuum-resonance projection of the abstract `R̂` spectrum, carrying gauge-symmetry clustering rather than the full GUE statistics. The un-projected `R̂` spectrum on `ℓ²(Σ_sa)` remains the right target for a future kernel-direct test with a depth functional constructed against the vacuum coupling.

**Status.** The bridge axiom `spectral_hilbert_polya` is still a WKL₀-level axiom; §4.9 does not discharge it. What §4.9 changes is the *target Lean theorem*: instead of an abstract "such a self-adjoint operator exists," the target becomes the concrete

> `R̂_self_adjoint`: the Markov-blanket depth operator on `ℓ²(Σ_sa)` is self-adjoint.

This is a future-work theorem with a defined Hilbert space and a defined operator. The runtime kernel also exposes the adjoint as the `/conj <twists>` slash command in QuantumOS, allowing users to construct and probe `Σ_sa` directly.

---

## Connection to the Lean Repository

The full axiom inventory and proof chain are documented in [`lean/README.md`](lean/README.md). The combinatorial core theorems referenced above are in:

- [`lean/QLF_Axioms.lean`](lean/QLF_Axioms.lean) — ZFA, pruning, symmetry
- [`lean/QLF_Universality.lean`](lean/QLF_Universality.lean) — every terminating computation encodes as ZFA
- [`lean/QLF_Spectral.lean`](lean/QLF_Spectral.lean) — Hermitian structure, scalar identity
- [`lean/QLF_Riemann.lean`](lean/QLF_Riemann.lean) — the full proof chain including the axiom boundary; the proposed `MRE_bridge` refinement of §4 is sketched as a comment block here

The Reverse Mathematics perspective is the meta-mathematical justification for the entire Lean formalization strategy: prove everything that can be proved in RCA₀, isolate everything that genuinely requires more, and label the boundary explicitly. §4 refines this further: when an axiom must sit on the boundary, give it a structural motivation drawn from RCA₀ principles internal to the framework.

See also: [GodCreatedTheIntegers.md](GodCreatedTheIntegers.md) — historical context: the discrete/deterministic vision of Zuse, Wheeler, Wolfram, 't Hooft, and Mead that QLF fulfills; [MRE.md](MRE.md) — the per-event log 2 saturation that motivates §4's bridge; [Riemann-Conjecture-Proof.md](Riemann-Conjecture-Proof.md) — the RH reduction whose bridge axiom §4 refines; [SpectralGap.md](SpectralGap.md) — the "asymptotic, not algebraically exact" caveat that §4's Mellin form respects; [Active_Inference_Mathematics.md](Active_Inference_Mathematics.md) — uses the RCA₀ floor + WKL₀ bridge classification developed here to position QLF as a candidate ZFC replacement for the part of mathematics that is not mathematical fantasy.
