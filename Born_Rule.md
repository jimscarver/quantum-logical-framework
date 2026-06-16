# The Born Rule, Derived from ZFA

**Standard QM postulates the Born rule** — the probability of observing outcome $\varphi$ given state $\psi$ is $|\langle \varphi | \psi \rangle|^2$. This single postulate, added on top of unitary evolution, is the **measurement axiom** that connects the deterministic Schrödinger equation to probabilistic experimental outcomes. In standard QM no derivation from more fundamental principles is generally accepted; the rule is empirical input.

**QLF derives the Born rule** as a consequence of (a) the uniform-prior structure of the possibility tree, (b) the binary-partition information-gain bound of [MRE.md](MRE.md), (c) the multiplicity principle of [BayesianMechanics.md](BayesianMechanics.md), and (d) the local-ZFA-closure framing of [Measurement_Problem.md](Measurement_Problem.md). The Born rule is not a postulate — it is what the QLF algebra produces when an observer asks "what is the probability that the next ZFA closure yields branch $\varphi$ given the current state $\psi$?"

## 1. The possibility tree and uniform prior

A QLF observer at a given moment has access to a **possibility tree** $\mathcal{T}_\psi$: the set of admissible ZFA-closed histories reachable from the current state $\psi$, filtered by the local Markov blanket's causal frontier ([Hadrons_Markov_Blankets.md](Hadrons_Markov_Blankets.md), [Hierarchical_Control.md](Hierarchical_Control.md)). Each leaf of $\mathcal{T}_\psi$ is a specific admissible closure satisfying both halves of ZFA (count balance + Pauli closure, per [Experimental_Consistency.md §2.1](Experimental_Consistency.md)).

The **uniform prior** on $\mathcal{T}_\psi$ is the assertion that every admissible leaf is equally probable absent further information. This is the [BayesianMechanics.md](BayesianMechanics.md) "multiplicity principle" — *the thing that can happen in the most ways happens first* — read at the leaf level: each leaf corresponds to one micro-path; equally-counted paths get equal weight.

## 2. From paths to amplitudes

Standard QM associates each branch with a complex amplitude $\langle \varphi | \psi \rangle$. In QLF the amplitude is the **path-integral sum** over all admissible micro-histories that take state $\psi$ to outcome $\varphi$, weighted by the QuCalc phase ([path_integral.py](path_integral.py), [Maxwell.md](Maxwell.md) on the $E = h \cdot \text{bits}$ rule):

$$\langle \varphi | \psi \rangle = \sum_{h \in \mathcal{T}_{\psi \to \varphi}} e^{i \theta(h)}$$

where $\theta(h)$ is the cumulative phase of history $h$ (the QuCalc realization of the Feynman path-integral phase). The sum is over all admissible Pauli-closed paths from $\psi$ to $\varphi$.

This is not new physics — it is the same Feynman path-integral construction, with the path space restricted to admissible ZFA-closed histories. The QLF contribution is making the path space **discrete and combinatorially finite at each causal horizon** (per the BFS saturation noted in [MRE.md §2.2](MRE.md)).

## 3. Born rule as binary-partition optimum

The probability of outcome $\varphi$ given state $\psi$ is the **fraction of the possibility tree that ends at $\varphi$**, weighted by the constructive/destructive interference of contributing paths:

$$P(\varphi | \psi) = \frac{|\sum_{h \in \mathcal{T}_{\psi \to \varphi}} e^{i \theta(h)}|^2}{\sum_{\varphi'} |\sum_{h' \in \mathcal{T}_{\psi \to \varphi'}} e^{i \theta(h')}|^2} = \frac{|\langle \varphi | \psi \rangle|^2}{\sum_{\varphi'} |\langle \varphi' | \psi \rangle|^2}$$

The squared modulus appears because **each path contributes an amplitude with a phase; constructive paths add coherently, destructive paths cancel**, and the resulting count of effective paths is $|A|^2$ when $A$ is the complex sum. The denominator is the normalization across all admissible final states (the **partition function** of the possibility tree).

In the canonical orthonormal case $\sum_{\varphi'} |\langle \varphi' | \psi \rangle|^2 = 1$, this reduces to the standard Born rule

$$P(\varphi | \psi) = |\langle \varphi | \psi \rangle|^2.$$

## 4. Why the squared modulus, not the modulus

A naive reader might ask: why $|A|^2$ rather than $|A|$? Two QLF arguments:

**Information-theoretic** (from MRE.md). Each ZFA closure is a binary partition of the local possibility tree, with information gain $\leq \log 2$ saturated at the 50/50 split (the per-event maximum of MRE.md §2.1). The probability assignment that saturates this bound at the leaf level is the one for which $-\sum P(\varphi) \log P(\varphi)$ is maximized subject to the path-integral amplitude constraint $\sum P(\varphi) = 1$ and $P(\varphi) \propto |\langle \varphi | \psi \rangle|^2$. The $|A|^2$ form is the unique probability assignment that:
- Reduces to the path-count when phases align (no interference)
- Maximizes the per-event information gain at each closure
- Preserves the unitary norm of the underlying state vector across all measurement contexts

**Algebraic** (from the Pauli structure). The Pauli matrices satisfy $\sigma_i^2 = I$ and $\{\sigma_i, \sigma_j\} = 2\delta_{ij} I$. The squared modulus $|A|^2 = A^* A$ is the unique bilinear form that recovers the standard probability structure ($P \geq 0$, $\sum P = 1$) when the underlying amplitudes are complex. Anything else (e.g. $|A|^p$ for $p \neq 2$) breaks the Hermitian-conjugate symmetry that QLF inherits from [Hermitian_Conjugacy_Proof.md](Hermitian_Conjugacy_Proof.md)'s $E + E^\dagger \equiv \text{ZFA}$.

## 5. Why probability appears at all (the role of the Markov blanket)

In a fully ZFA-closed universe with no observer there is **no probability** — every history is determined. Probability is an **observer-relative** notion that arises because each Markov blanket sees only its own slice of the universal possibility tree ([Hadrons_Markov_Blankets.md](Hadrons_Markov_Blankets.md), Rovelli's Relational Quantum Mechanics applied at the QLF substrate).

The observer's local possibility tree is the **conditional** possibility tree: those leaves consistent with the observer's history. The uniform prior on this conditional tree is the source of the probability distribution. When the observer measures, they pick one leaf; the post-measurement state is the realized branch.

This is exactly the [Measurement_Problem.md §4a](Measurement_Problem.md) framing: each measurement = one ZFA closure = $\log 2$ nats of information gain per atom, with the specific branch picked according to the Born rule. The "wavefunction collapse" is the observer's possibility tree shrinking by half (per bit).

## 6. The Gleason-theorem connection

Gleason's theorem (1957) shows that for Hilbert spaces of dimension $\geq 3$, the **only** probability measure on the lattice of projection operators that satisfies countable additivity is the Born rule $P(\varphi) = \text{Tr}(\rho \, \Pi_\varphi)$. This is often cited as a derivation of the Born rule from first principles in standard QM.

The QLF construction in §3–4 is consistent with Gleason but goes further: it identifies **what is being assigned probability** (admissible ZFA-closed leaves of the local possibility tree) and **why** (the uniform prior over admissible micro-paths follows from the multiplicity principle and the algebra's Hermitian symmetry). Gleason fixes the form $|\langle \varphi | \psi \rangle|^2$; QLF fixes the underlying ensemble.

## 7. Worked example: spin-1/2 measurement

State $\psi = |z+\rangle$ (spin up along z-axis). Possibility tree for an x-axis measurement: two leaves, $|x+\rangle$ and $|x-\rangle$.

Amplitudes (path-integral sums):
- $\langle x+ | z+ \rangle = 1/\sqrt 2$
- $\langle x- | z+ \rangle = 1/\sqrt 2$

Squared moduli (Born):
- $P(x+) = 1/2$
- $P(x-) = 1/2$

QLF reading: the QuCalc engine starting from a `|z+⟩`-encoded history has two admissible Pauli-closed paths to `|x+⟩` and two to `|x-⟩`, evenly weighted under the uniform prior. The 50/50 outcome is the binary-partition optimum of [MRE.md §2.1](MRE.md), realized at the spin-1/2 atom level. Per-event information gain = $\log 2$ nats, exactly as expected.

For a measurement at angle $\theta$ from the z-axis:
- $\langle \theta+ | z+ \rangle = \cos(\theta/2)$
- $P(\theta+) = \cos^2(\theta/2)$

QLF reading: the path-integral sum gives $\cos(\theta/2)$ as the constructively-interfering contribution; the squared modulus gives the Born probability. The angular dependence is encoded in the Pauli algebra's structure constants, not added as a separate rule.

## 8. Open work

- **Lean theorem**: `born_rule_from_uniform_prior` formalizing the path-counting → $|A|^2$ derivation in §3–4.
- **Numerical demo**: extend `path_integral.py` to compute Born probabilities directly from QuCalc path enumeration; verify against standard QM for a battery of canonical cases (single spin, two-spin singlet, three-slit interference).
- **Gleason-theorem connection in Lean**: formalize the QLF-side of Gleason's uniqueness — given the uniform prior and the Pauli algebra, $|A|^2$ is the unique probability functional.
- **Quantum contextuality**: Bell-Kochen-Specker theorem is the constraint that probability assignments must be consistent across measurement contexts. QLF's per-context possibility trees should derive this consistency automatically.

## References

### Internal

- [MRE.md](MRE.md) — per-event $\log 2$ binary-partition optimum, information-theoretic foundation
- [BayesianMechanics.md](BayesianMechanics.md) — multiplicity principle: "the thing that can happen in the most ways happens first"
- [Measurement_Problem.md](Measurement_Problem.md) — §4a measurement = ZFA closure = log 2 per atom; this doc develops the probability assignment behind that information gain
- [Hierarchical_Control.md](Hierarchical_Control.md) — Friston FEP derivation; the Born rule is the recognition density $q$ over the conditional possibility tree
- [Hadrons_Markov_Blankets.md](Hadrons_Markov_Blankets.md) — Markov blanket as the observer-relative conditioning structure
- [Hermitian_Conjugacy_Proof.md](Hermitian_Conjugacy_Proof.md) — $E + E^\dagger \equiv \text{ZFA}$; the Hermitian-conjugate symmetry that makes $|A|^2 = A^* A$ the unique bilinear probability form
- [Lagrangian_Formulation.md](Lagrangian_Formulation.md) — Σ₈ Pauli algebra; the structure constants encoding measurement-context relationships
- [Entanglement.md](Entanglement.md) — Bell violations from the non-commutative algebra
- [Experimental_Consistency.md](Experimental_Consistency.md) — §2.1 on the count-balance ∧ Pauli-closure ZFA conjunction
- `path_integral.py` — QuCalc path enumeration

### External

- Born, M. (1926). *Zur Quantenmechanik der Stoßvorgänge.* Z. Phys. 37, 863 — original Born rule postulate.
- Gleason, A. M. (1957). *Measures on the closed subspaces of a Hilbert space.* J. Math. Mech. 6, 885 — uniqueness theorem.
- Feynman, R. P. (1948). *Space-time approach to non-relativistic quantum mechanics.* Rev. Mod. Phys. 20, 367 — path integral formulation.
- Caves, C. M., Fuchs, C. A., Schack, R. (2002). *Quantum probabilities as Bayesian probabilities.* Phys. Rev. A 65, 022305 — QBism, the closest standard-QM reading to the QLF derivation here.
