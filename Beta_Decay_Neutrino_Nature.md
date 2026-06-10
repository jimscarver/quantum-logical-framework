# Beta Decay and the Nature of the Neutrino

In the Quantum Logical Framework (QLF), nuclear decay is not a random probabilistic event; it is the deterministic restructuring of a topological Markov blanket to relieve logical stress. This document covers β decay as boundary restructuring, and what QLF says about the **nature of the neutrino** — which, on the framework's own principles and now **machine-verified**, is **Majorana** (its own antiparticle), carrying the prediction of **neutrinoless double-beta decay** (`0νββ`).

## 1. The neutrino is Majorana — machine-verified

In QLF the **antiparticle** of a configuration is its **Hermitian conjugate** ([Annihilation.md](Annihilation.md)): conjugate every twist (`Twist.conj`) and **reverse the order**, since the adjoint of a product reverses it, `(A·B·C)† = C†·B†·A†`. A particle is **Majorana** (its own antiparticle) exactly when its twist history is a **fixed point** of this operation — a decidable property of the string.

**Machine-verified** ([`lean/QLF_Majorana.lean`](lean/QLF_Majorana.lean)):

- `neutrino_majorana` — the neutrino loop `^v` **is** a fixed point of conjugate-and-reverse, so the neutrino **is its own antiparticle**.
- `electron_not_majorana` — the electron loop `^<v>` is **not** a fixed point; its conjugate is a *distinct* history (the positron), so the charged lepton is **Dirac**.

The electron case makes this non-vacuous: the same test that calls the neutrino Majorana correctly calls the electron Dirac. And the neutrino comes out as the **unique** self-conjugate fermion for a structural reason — it is the only fermion with neither charge nor a chiral/linked structure, so its minimal non-chiral loop is the only one symmetric under conjugate-and-reverse (charged or chiral histories pick up an order they cannot match after reversal). QLF therefore reproduces, from structure, the real-physics fact that **only the neutrino can be Majorana** (a charged fermion cannot — it would violate charge conjugation).

**The prediction.** A Majorana neutrino means **lepton number is violated** — the neutrino carries no conserved lepton charge to distinguish `ν` from `ν̄`. The signature is **neutrinoless double-beta decay**, `2n → 2p + 2e⁻` (`ΔL = 2`), which **LEGEND, nEXO, and KamLAND-Zen are searching for now**. A definitive observation of `0νββ` confirms it; a definitive Dirac result (a measured Dirac-mass mechanism, or `0νββ` excluded at the relevant scale) would challenge the `^v` assignment. This is the corpus's clearest empirical commitment distinguishable from the Standard Model (which is agnostic on Dirac vs Majorana).

**What this means for `B−L`.** Because the neutrino is Majorana, `B−L` is **not an exactly conserved charge** — it is violated by `ΔL = 2` in `0νββ`. This is consistent with the framework's deeper structure: `B−L` is not even a conserved *signed count*. The obstruction `wcount_zero_on_ZFA` ([`lean/QLF_BMinusL.lean`](lean/QLF_BMinusL.lean)) proves any conserved signed count is **zero on every ZFA closure**, yet the deuteron is a stable neutral closure with `B−L = 1` — so `B−L` is at most a winding-type quantity, and the Majorana neutrino shows it is violated outright. **Electric charge, by contrast, *is* an exactly conserved signed count** (`signed_count_conserved`), and every QLF closure is electrically neutral. So charge is exact; `B−L` is not. (This also places QLF in agreement with, not tension with, the quantum-gravity expectation that gravity admits no exact global symmetries.)

**Honest tier.** The Majorana result is **machine-verified**, conditional on two QLF inputs: the assignment neutrino `= ^v`, and antiparticle `=` Hermitian conjugate (the corpus's convention, principled because the operator adjoint reverses order). *Given* those, Majorana is proved, not argued. The remaining physics content — that `0νββ` actually proceeds at a given rate — is the falsifiable empirical claim the experiments test.

## 2. Beta decay as boundary restructuring

A hadron (like a neutron) is a Markov blanket — a macroscopic context that hides complex fractional logic (quarks) from the surrounding vacuum environment.

A free neutron contains a topological stress (excess bound action) relative to the vacuum. To achieve a more stable bisimilarity with the environment, the neutron must restructure its Markov blanket into a lower-energy proton. (The proton is a net-charge *deficit*, not a free observable: it is completed into a neutral hydrogen-class closure by a negative lepton — and the β-decay event co-produces exactly that completer, the electron below. Which lepton variety completes it — `e⁻`/`μ⁻`/`τ⁻` → hydrogen / muonic / tauonic — is a generation degree of freedom; see [Weak_Force.md](Weak_Force.md) §4a.)

* **The Unspooling:** the neutron opens its topological boundary, unspooling the excess logic.
* **The Ejection:** this logic must immediately resolve to preserve global ZFA. It splits into two unforgeable names:
  1. **The Electron:** a highly chiral, tightly bound ZFA loop (`^<v>`) that carries away the asymmetric logical debt — and being chiral, it has a *distinct* antiparticle (the positron): the electron is Dirac.
  2. **The Majorana Neutrino:** a *non-chiral* loop (`^v`) whose Hermitian conjugate is identical to itself, hence its own antiparticle. It carries away the residual relational momentum without disturbing the chiral balance of the new system.

See also: [Annihilation.md](Annihilation.md) — develops the LH `^<v>` vs RH `^>v<` chiral twist patterns as Hermitian pairs whose composition folds to identity (the algebraic content of pair annihilation); the unspooling described in §2 is the same topological unwinding read at the hadron scale. [Weak_Force.md](Weak_Force.md) — consolidates the weak sector and flags the tension that this account mediates β decay by a gauge-fold pair-flip *operation* without an explicit W *particle* (which appears only in the τ-decay vertex). [`lean/QLF_Majorana.lean`](lean/QLF_Majorana.lean) — the machine-verified self-conjugacy of the neutrino loop.
