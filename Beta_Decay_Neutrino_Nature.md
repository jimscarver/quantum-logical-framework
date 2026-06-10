# Beta Decay and the Nature of the Neutrino

In the Quantum Logical Framework (QLF), nuclear decay is not a random probabilistic event; it is the deterministic restructuring of a topological Markov blanket to relieve logical stress. This document covers β decay as boundary restructuring, and what QLF says about the **nature of the neutrino** — which, on the framework's own principles, is **Dirac**, carrying the prediction of **no neutrinoless double-beta decay**.

> **History.** This file (formerly `Majorana_Beta_Decay.md`) previously argued the neutrino is *Majorana* — its own antiparticle — from the fact that its loop is non-chiral. On re-examination that inference was flawed: it conflated the *spatial* non-chirality of the loop with *self-conjugacy*, and — decisively — a Majorana neutrino **violates lepton number** (`B−L`), whereas QLF's foundational, machine-verified principle is **exact per-event signed-count balance**. The corrected QLF position is **Dirac**; see §1.

## 1. The neutrino is Dirac — exact `B−L` balance forbids 0νββ

QLF's most fundamental, machine-verified property is **per-event signed-count balance** — ZFA closure, `count_balanced_pauli_closed` ([`lean/QLF_TwistAlphabet.lean`](lean/QLF_TwistAlphabet.lean)). Every conserved *additive* quantum number is a signed twist count that balances **exactly, per event** — this is the corpus's account of charge, momentum, and the information ledger ([Conservation.md](Conservation.md) §8).

**Lepton number is such a count.** In β decay `n → p + e⁻ + ν̄`, the electron (`L = +1`) is co-produced with an **antineutrino** (`L = −1`): the pair is born balanced — exactly as the electron's charge is co-produced to complete the proton-deficit into a neutral hydrogen-class closure ([Weak_Force.md](Weak_Force.md) §4a, §5f). So **`B−L` is conserved per event, exactly** (the neutron and proton both carry `L = 0`; `e⁻` and `ν̄` carry `+1` and `−1`).

A **Majorana** neutrino (`ν = ν̄`, lepton number not defined) would make **neutrinoless double-beta decay** `2n → 2p + 2e⁻` possible — an event that creates **two units of lepton number from nothing**, i.e. violates `B−L` by 2. That is precisely the kind of signed-count *imbalance* that per-event ZFA closure forbids. Majorana would be an **exception** to the framework's foundational balance principle; **Dirac is the rule.** Hence:

> **QLF predicts: neutrinos are Dirac (`ν ≠ ν̄`); `B−L` is exactly conserved; there is NO neutrinoless double-beta decay.**

The neutrino's **spatial** loop is genuinely non-chiral (a symmetric `^v`-type oscillation, with no left/right handedness — contrast the chiral electron `^<v>` LH vs `^>v<` RH). But spatial non-chirality does **not** make it self-conjugate: the antineutrino is distinguished from the neutrino not by a spatial handedness but by its **opposite conserved lepton count** — the signed balance the decay event enforces. The earlier "non-chiral ⇒ its own antiparticle" step was the error; it read the symmetry of the spatial loop as the vanishing of lepton number, which it is not.

**Falsifiable (Class B — QLF-specific).** A confirmed **positive** 0νββ signal (LEGEND, nEXO, KamLAND-Zen) would refute QLF's exact-`B−L` account specifically, without indicting the rest of standard physics (the Standard Model is *agnostic* on Dirac vs Majorana). The **decades of null** 0νββ results are consistent with the QLF prediction. This is a cleaner falsifier than the former Majorana claim: it predicts the *absence* of a signal that has, so far, been absent — rather than staking the framework on a positive signal that has never appeared.

**`B−L`, not `B` or `L` separately.** QLF's exact symmetry is `B−L`: it conserves the *difference*, while `B` and `L` may each shift in a `B−L`-conserving (sphaleron / baryogenesis) process — the same selection rule that lets an anti-tau's proton-mirror core convert to a proton (`Δ(B−L)=0`, [Weak_Force.md](Weak_Force.md) §5g). Matter dominance (Sakharov) needs `B` violation, which `B−L`-conservation permits; it does **not** need `B−L` violation. So the balanced closures of physical reality — hydrogen has `B−L = 0` (`B=+1` proton balanced by `L=+1` electron) — are exactly the `B−L`-neutral ones. "Electrons balance protons" *is* `B−L` balance.

**Honest tier.** This is a **prediction**, not a theorem. It rests on lepton number being one of the per-event-balanced signed counts (the corpus's own conservation framing, [Conservation.md](Conservation.md) §8) — structurally natural and consistent with the machine-verified keystone, but the lepton-number twist dictionary is not yet a Lean anchor. It sits at the same tier the Majorana claim did, now pointing the way the balance principle **and** the data both favor.

## 2. Beta decay as boundary restructuring

A hadron (like a neutron) is a Markov blanket — a macroscopic context that hides complex fractional logic (quarks) from the surrounding vacuum environment.

A free neutron contains a topological stress (excess bound action) relative to the vacuum. To achieve a more stable bisimilarity with the environment, the neutron must restructure its Markov blanket into a lower-energy proton. (The proton is a net-charge *deficit*, not a free observable: it is completed into a neutral hydrogen-class closure by a negative lepton — and the β-decay event co-produces exactly that completer, the electron below. Which lepton variety completes it — `e⁻`/`μ⁻`/`τ⁻` → hydrogen / muonic / tauonic — is a generation degree of freedom; see [Weak_Force.md](Weak_Force.md) §4a.)

* **The Unspooling:** the neutron opens its topological boundary, unspooling the excess logic.
* **The Ejection:** this logic must immediately resolve to preserve global ZFA. It splits into two unforgeable names:
  1. **The Electron:** a highly chiral, tightly bound ZFA loop that carries away the asymmetric logical debt (`L = +1`).
  2. **The (Dirac) Antineutrino:** a *non-chiral*, nearly massless string that carries away the residual relational momentum **and the balancing lepton count** (`L = −1`). It is the distinct conjugate of the neutrino — *not* identical to it — so global `B−L` is preserved per event by construction.

See also: [Annihilation.md](Annihilation.md) — develops the LH `^<v>` vs RH `^>v<` chiral twist patterns from §1 as Hermitian pairs whose composition folds to identity (the algebraic content of pair annihilation); the unspooling described in §2 is the same topological unwinding read at the hadron scale. [Weak_Force.md](Weak_Force.md) — consolidates the weak sector and flags the tension that this account mediates β decay by a gauge-fold pair-flip *operation* without an explicit W *particle* (which appears only in the τ-decay vertex). [Conservation.md](Conservation.md) §7–8 — CPT exactness and the `B−L` (lepton/baryon) conservation this prediction rests on.
