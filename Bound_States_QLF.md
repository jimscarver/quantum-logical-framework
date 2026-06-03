# Bound States as QLF Observables — Why Free Leptons Are Not

**Free leptons do not exist as independent QLF observables.** The natural QLF "particles" are **atomic systems** — bound, balanced, joint-ZFA closures of two or more charged constituents. This document records the framing and explains why the three lepton-mass-from-multiplicity demos (`lepton_mass_demo.py`, `lepton_mass_prime_test.py`, `lepton_mass_irreducible_test.py`) all failed by asking the wrong question. The free-lepton mass ratios `m_μ / m_e ≈ 207` and `m_τ / m_μ ≈ 17` are derived quantities from atomic-system observations, not direct QLF observables.

This is the same structural move that `Delayed_Choice_Eraser.md` makes for photons: a photon is not a projectile traveling between emitter and absorber, it is the joint ZFA closure of the two ends. Applied to leptons: an electron is not an independent particle whose mass can be extracted from QLF multiplicity counts in isolation; it is one half of a joint-ZFA bound state (positronium, hydrogen, muonium, ...) whose mass is the QLF observable.

---

## §1 Free leptons are not stable QLF closures

Standard particle physics tabulates `m_e ≈ 0.511 MeV`, `m_μ ≈ 105.66 MeV`, `m_τ ≈ 1776.86 MeV` as if these are properties of free particles. Operationally they are extracted from atomic and high-energy experiments; physically, a free lepton in the QLF sense is an **open Hermitian deficit** (per `Collective_Electrodynamics.md` §1 and `HALF-SPIN-ZFA-EMBEDDING.md`). It has not yet completed a joint-ZFA closure event.

- A free electron's Hermitian conjugate is its antiparticle, the positron. The pair `(e⁻, e⁺)` together can form a joint ZFA closure — **positronium**.
- A free electron + a proton can close jointly — **hydrogen**.
- A free electron + an antimuon can close jointly — **muonium**.

In every case the QLF-physical state is the bound system, not the free constituent.

---

## §2 The natural QLF atomic-system observables

Three pure-Coulomb bound states with measured masses:

| Atomic system | Constituents | Mass (MeV) | Binding (eV) |
|---|---|---|---|
| **Positronium** (Ps) | e⁻ + e⁺ | 2 · 0.511 = 1.022 | 6.803 |
| **Muonium** (Mu)     | e⁻ + μ⁺ | 105.66 + 0.511 ≈ 106.17 | 13.541 |
| **Hydrogen** (H)     | e⁻ + p  | 938.27 + 0.511 ≈ 938.78 | 13.598 |

All three are charge-balanced, ZFA-closed bound systems. Each has a well-defined mass and binding energy. These are the **observables** the QLF mass-spectrum derivation must reproduce — not the free-lepton ratios.

The τ does not form a stable atomic system; its lifetime (≈ 290 fs) is too short for Bohr-orbital binding. The QLF observable for the third generation is therefore not a "tauonium" but the τ-decay vertex itself — a different kind of joint-ZFA closure event.

---

## §3 Why the three lepton-mass demos failed

[`lepton_mass_demo.py`](lepton_mass_demo.py), [`lepton_mass_prime_test.py`](lepton_mass_prime_test.py), and [`lepton_mass_irreducible_test.py`](lepton_mass_irreducible_test.py) all attempt to predict `m_μ / m_e ≈ 207` and `m_τ / m_μ ≈ 17` from QLF closure-multiplicity counts at increasing depth. All three falsify their candidate formulas — the M(N), M_prime(N), and M_irr(N) ratios are monotonic around 19–30× per depth step, whereas the measured lepton ratios are non-monotonic (207 ≫ 17).

The QLF reading of this failure: **the question was ill-posed**. Free-lepton mass ratios are not QLF observables. The closure-multiplicity counts the three demos computed correspond to a structural inventory of admissible QLF closures, but the right mapping is not to free-lepton masses. The right mapping is to **atomic-system masses or binding energies**.

The three demos remain useful as falsifications of "QLF multiplicity → free-lepton mass" formulas. Their negative result is now sharpened by this framing: the formulas were wrong because the **target** was wrong, not (only) because the multiplicity structure was wrong.

---

## §4 Re-framed mass-spectrum question

The right QLF mass-spectrum question is:

> **Which QLF closure structures correspond to specific atomic systems, and how does their depth or multiplicity scale with the measured atomic-system mass or binding energy?**

Worked subjects:

### 4.1 Positronium ↔ minimal-qubit joint closure

The minimal joint ZFA closure between a lepton and its Hermitian-conjugate partner is the **half-spin ZFA atom** of `HALF-SPIN-ZFA-EMBEDDING.md` §2 — a two-twist Hermitian pair like `^v`. The mass of this closure should map to `m(Ps) = 1.022 MeV`. The "electron mass" is then the QLF observable's *half*: 0.511 MeV is `m(Ps) / 2`, not a free-particle property.

### 4.2 Muonium ↔ asymmetric joint closure

Muonium binds a light electron to a heavier antimuon. The natural QLF reading: a joint closure where one half is the minimal Hermitian pair (electron side) and the other half is a deeper-blanket Hermitian closure (muon side, more qubits to accommodate the heavier mass). Per `Hadrons_Markov_Blankets.md`'s scale-recursion framing, the muon side sits at a deeper Markov blanket — `Δt = R / f` with larger R.

### 4.3 Hydrogen ↔ lepton-baryon joint closure

Hydrogen binds an electron to a proton. The proton is a composite three-quark closure (`Particles.md`, `HadronicDepth.md`). The joint ZFA closure of (electron) + (proton-internal) is structurally different from the lepton–antilepton case of positronium or muonium. The QLF mass `m(H) ≈ 938.78 MeV` is dominated by the proton mass; the binding energy 13.6 eV is the residual joint-closure energy after the constituent rest energies.

### 4.4 The right ratios

Measured atomic-system mass ratios:

- `m(Mu) / m(Ps) ≈ 106.17 / 1.022 ≈ 103.9`
- `m(H)  / m(Ps) ≈ 938.78 / 1.022 ≈ 918.6`
- `m(H)  / m(Mu) ≈ 938.78 / 106.17 ≈ 8.84`

Measured atomic-system binding-energy ratios:

- `E(Mu) / E(Ps) ≈ 13.541 / 6.803 ≈ 1.99`  (very close to 2)
- `E(H)  / E(Ps) ≈ 13.598 / 6.803 ≈ 2.00`  (very close to 2)
- `E(H)  / E(Mu) ≈ 13.598 / 13.541 ≈ 1.004` (essentially 1)

The binding-energy structure is dominated by the **reduced-mass** factor in the Bohr formula `E_bind = (μ / m_e) · 13.6 eV`. Hydrogen and muonium have nearly identical reduced masses (because muon-to-electron is heavy-to-light, similar to proton-to-electron), so their bindings are nearly equal. Positronium has reduced mass `m_e / 2`, hence half the binding.

This is standard non-relativistic QM. The QLF derivation should reproduce these ratios from joint-ZFA closure-multiplicity counts.

---

## §5 Implications for QLF future work

1. **The "lepton mass hierarchy" problem in particle physics is reformulated in QLF as the "atomic-system spectrum" problem.** The questions "why is the muon 207× the electron?" and "why is the tau 17× the muon?" are reframed as "what determines the QLF closure depth of positronium vs. muonium vs. higher bound states?"

2. **The three failed lepton-mass demos are not refuted as numerical work** — they correctly computed M(N), M_irr(N), and prime-arithmetic candidates. They are reframed: those formulas are not predictions of `m_μ / m_e`, they are predictions of *something else*. Identifying what that something else is (probably an atomic-system observable) is open work.

3. **The τ has no stable atomic system.** Its mass is determined by a different mechanism — most likely the energetic threshold for its decay channels (τ⁻ → ν_τ + W⁻; `m_τ > m_W + m_ν` is required). The QLF reading would identify τ with a particular decay-vertex closure rather than a Bohr-bound atomic system.

4. **The "free particle" frame is operationally wrong for QLF** — but it's also operationally wrong for *quantum field theory*. A free electron in QFT is also a fiction; the physical objects are scattering amplitudes between bound or composite states. QLF makes this structural fact explicit at the kernel level: the unit of physical existence is the joint-closure event, not the asymptotic free particle.

5. **The right target observables for future QLF demos are atomic-system masses and binding energies**, computed in QLF as joint-closure depths and multiplicity counts of two- and three-body bound states.

---

## §6 What this is NOT

- **Not a claim that free-lepton masses are unmeasurable.** They are extracted from atomic and scattering experiments and are well-tabulated. The claim is that they are *derived* quantities, not direct QLF observables.
- **Not a claim that QLF cannot derive lepton mass ratios.** It claims the right path goes via atomic-system mass observables, not via direct mass-from-free-lepton-multiplicity.
- **Not a retraction of the three failed mass demos.** They are correct empirical work that falsified specific hypotheses (M ∝ free-lepton mass; M at prime qubit counts; M_irr at prime qubit counts). The falsifications stand; the framing of their target is what is reframed.
- **Not an entirely new claim** — the structural insight (no free particles in QLF, all observables are joint closures) is already in `Delayed_Choice_Eraser.md` (photons), `Hadrons_Markov_Blankets.md` (hadrons), and `HALF-SPIN-ZFA-EMBEDDING.md` (half-spin atoms as Hermitian pairs). This doc applies it specifically to leptons.

---

## §7 Open work

- **Map atomic systems to QLF closure structures.** Positronium ↔ 2-qubit Hermitian pair? Muonium ↔ asymmetric joint closure with different blanket depths? Hydrogen ↔ lepton-baryon joint closure involving three quark closures? Each mapping is a separate constructive piece.
- **Compute the QLF mass for each mapped atomic system.** With the joint-closure depth and the per-event log-2 quantum from `MRE.md`, the mass-energy contribution per closure is well-defined.
- **Test the Bohr-formula reduced-mass structure in QLF.** The `E_bind(reduced mass) ∝ μ` scaling should fall out of QLF closure-multiplicity counts naturally, given the right mapping.
- **Tau as a decay-vertex closure.** Identify the specific QLF closure topology for the τ⁻ → ν_τ + W⁻ vertex and verify that `m_τ` corresponds to the energetic threshold for this closure.

---

## References

### Internal

- [`HALF-SPIN-ZFA-EMBEDDING.md`](HALF-SPIN-ZFA-EMBEDDING.md) — Hermitian pair as the minimal joint closure; the QLF unit of physical existence.
- [`Delayed_Choice_Eraser.md`](Delayed_Choice_Eraser.md) — photons as joint emitter-absorber closures, not free particles. The same structural move applied to photons that this doc applies to leptons.
- [`Collective_Electrodynamics.md`](Collective_Electrodynamics.md) — joint ZFA closures as the unit of EM interaction; vector potential as unresolved free action.
- [`Hadrons_Markov_Blankets.md`](Hadrons_Markov_Blankets.md) — bound-state framing at the hadronic scale; the "same blanket strategy at every scale" recursion that extends naturally to lepton atomic systems.
- [`Hydrogen.md`](Hydrogen.md) — existing Bohr-derivation of hydrogen levels in QLF language.
- [`Atom.md`](Atom.md) — atomic shell structure derived from QLF.
- [`Standard_Model.md`](Standard_Model.md) §6 — "Mass ratios from multiplicity" open work; this doc reframes that open work.
- [`lepton_mass_demo.py`](lepton_mass_demo.py), [`lepton_mass_prime_test.py`](lepton_mass_prime_test.py), [`lepton_mass_irreducible_test.py`](lepton_mass_irreducible_test.py) — the three numerical falsifications that this reframing explains.
- [`Active_Inference_Mathematics.md`](Active_Inference_Mathematics.md) — meta-framing: physical observables are admissible joint closures, not isolated free particles.

### External

- Particle Data Group, *Review of Particle Physics* — measured lepton masses and atomic-system rest masses.
- Karshenboim, S. G. (2005). *Precision physics of simple atoms: QED tests, nuclear structure and fundamental constants*. Phys. Rep. 422, 1–63 — positronium, muonium, hydrogen precision data.
