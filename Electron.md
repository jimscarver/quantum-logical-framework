# Electron in the Quantum Logical Framework (QLF)

**Repository:** [`quantum-logical-framework`](https://github.com/jimscarver/quantum-logical-framework)
**Document:** `Electron.md`
**Document version:** 2.0 — aligned with [`Bound_States_QLF.md`](Bound_States_QLF.md)
**Author:** Jim/Grok (synthesized from QLF core axioms, QuCalc engine, `particles.py` v2.2, gauge-folding rule, and the bound-state framing)

## Abstract

In QLF, **the electron does not exist as an independent stable observable**. A free electron is an **open Hermitian deficit** — a partial twist sequence that has not completed a joint Zero Free Action closure. The electron becomes a QLF-physical event only when it joins a Hermitian-conjugate partner (positron → positronium), a heavier lepton (antimuon → muonium), or a baryon (proton → hydrogen) in a joint-ZFA bound state. The "electron's mass" reported by experiment, `m_e ≈ 0.511 MeV`, is the electron's **gauge-fold-depth contribution** to the bound-state mass — half of `m(positronium)`, the analogous contribution to `m(hydrogen)`, and so on.

This is the same structural move that [`Delayed_Choice_Eraser.md`](Delayed_Choice_Eraser.md) makes for photons (joint emitter-absorber closure, not free projectile) and that [`Hadrons_Markov_Blankets.md`](Hadrons_Markov_Blankets.md) makes for quarks (no asymptotic free quarks, only bound hadrons). Applied to electrons: an electron is one half of a joint closure, not an isolated particle whose mass can be extracted in isolation. The QLF observables are atomic systems; the "electron" is the gauge-fold contribution of one constituent.

The remainder of this document is a hands-on tutorial. We give the electron's QuCalc topology (the half it contributes to a joint closure), the photon and antiphoton (which jointly satisfy ZFA), and the electron–proton hydrogen formation (a joint-ZFA bound state). Everything runs live in `particles.py`.

## Why the Electron Matters

Most everything we experience is due to electrons participating in joint closures — chemistry, light emission, electric currents, biological membranes. The "electron" of standard physics is shorthand for "the leptonic half of a joint-ZFA closure event." Understanding the electron in QLF means understanding which joint closures it can participate in and how its gauge-fold depth contributes to the bound-state mass and binding.

In QLF the electron is not an abstract point particle with mysterious properties. It is a **gauge-folded topological half-loop** — a partial twist sequence containing at least one `+` or `-` fold along the LOCAL gauge axis. By itself the half-loop has not closed; it carries an open Hermitian deficit. When it intersects a Hermitian-conjugate partner's causal frontier, the joint ZFA closure completes, and the gauge-fold depth of the electron's half contributes its share of the bound system's constructing delay and rest energy.

Its **spin is not mysterious either** — it is literally the twists. The electron loop `^<v>` folds to `−I` (a half-spin fermion needing 720° to return, the SU(2)→SO(3) double cover), and the electron is **Dirac** (not its own antiparticle), all machine-verified in [`Spin_QLF.md`](Spin_QLF.md) / [`lean/QLF_Spin.lean`](lean/QLF_Spin.lean) (`fold_electron`, `rotation_360_eq_negI`, `electron_not_majorana`). Charge conjugation = view-from-behind: the positron is the electron's loop read in reverse.

## 1. The Electron's Half of a Joint Closure

The electron is the **gauge-folded half-loop** that completes a joint ZFA closure when paired with its Hermitian-conjugate partner.

Minimal electron half-topology (spatial + gauge):

$$^<v^+$$

or more fully:

$$^<v>^+$$

- `^` = forward-time seed
- `<` `>` = spatial folds (transverse area)
- `+` = gauge fold → **gauge-fold-depth contribution to bound-state mass**

The electron's half-loop carries an unresolved gauge deficit. It accumulates a **constructing delay** $\Delta t = R/f$ (topological depth $R$ at vacuum frequency $f$) only when its closure is completed by a partner. In isolation it is an open Hermitian deficit; in a positronium binding it joins the positron's mirror half and the joint closure creates a finite local time at depth $2R$, with rest energy `m(Ps) ≈ 1.022 MeV`. Half of this — `0.511 MeV` — is what conventional physics attributes to the "free electron mass."

### Bound systems the electron half-loop completes

| Joint closure | Partner | Bound-state mass | Joint topology (schematic) |
|---|---|---|---|
| **Positronium** | Positron `v>v-` | 1.022 MeV | `^<v>^+ · v<v>v-` (electron half + positron half) |
| **Hydrogen** | Proton (three-quark composite) | 938.78 MeV | electron half + proton internal closure |
| **Muonium** | Antimuon (deeper-blanket gauge half) | 106.17 MeV | electron half + antimuon half (asymmetric blanket depths) |

In each case the "electron" of this document contributes the same gauge-fold-depth `R_e` to the joint closure. The bound-state mass is `R_e + R_partner` (modulo joint-closure binding corrections), not `R_e` alone. See [`Bound_States_QLF.md`](Bound_States_QLF.md) for the spectrum.

### Run the electron half-loop yourself

```bash
python particles.py --seed "^<" --max-depth 4 --enable-gauge True
```

**Sample output (electron half-loop, awaiting joint closure):**
```text
✅ ZFA Closure Achieved:
   Topology          : ^<v>^+
   Classification    : gauge-folded half-loop
   Topological Depth R : 4
   Constructing Delay  : 4 cycles (becomes physical in joint closure)
   Creates local     : time (in joint closure with conjugate partner)
   Logical Density   : HIGH → time is the local axis in the bound state
   Joint partner needed : positron, proton, antimuon, ...
   Hawking Radiation : +- (released on bound-state breakup)
```

This is the electron's half. To become a QLF-physical event the joint partner must close the deficit.

## 2. Photon Folds Forward in Time — Antiphoton Satisfies ZFA

A photon is a **massless joint closure** that requires no gauge fold. It is a pure forward-time spatial closure between an emitter and an absorber — see [`Delayed_Choice_Eraser.md`](Delayed_Choice_Eraser.md) and [`Collective_Electrodynamics.md`](Collective_Electrodynamics.md).

The two halves of the joint photon closure:

- Photon half (forward-time): $^>$
- Antiphoton half (conjugate, backward-time): $v<$

When they meet they form the joint closure with exactly Zero Free Action:

$$H_{\rm photon} \circ H_{\rm antiphoton} = ^> \circ v< \quad \Rightarrow \quad \text{net action} = 0$$

This is the **same structural move** as for the electron — both photons and electrons are halves of joint closures. The difference: the photon's halves have no gauge fold, so the joint closure has zero constructing delay and the photon is massless; the electron's halves have a gauge fold, so the joint closure has finite delay and finite rest energy.

### Run the photon–antiphoton pair

```bash
# Photon forward (massless, no gauge)
python particles.py --seed "^>" --max-depth 2 --enable-gauge False

# Antiphoton conjugate
python particles.py --seed "v<" --max-depth 2 --enable-gauge False
```

**Sample photon output:**
```text
Topology          : ^>
Classification    : massless joint-closure half
Creates local     : space (in joint closure with conjugate half)
Delay             : 0 cycles
Joint partner needed : antiphoton (forms the EM-interaction event)
No Hawking radiation
```

The two halves together close with zero free action — this is the QLF reading of every "photon" we ever detect: a joint emitter-absorber event, not a free projectile.

## 3. Electron–Proton Joint Closure (Hydrogen)

The proton is a composite Markov blanket with three-quark internal closures and gauge folds ([`Hadrons_Markov_Blankets.md`](Hadrons_Markov_Blankets.md), [`HadronicDepth.md`](HadronicDepth.md)). The electron half-loop joins the proton in a joint-ZFA bound state — **hydrogen**.

Hydrogen is the natural QLF observable: a charge-balanced, ZFA-closed joint event with mass `m(H) ≈ 938.78 MeV` and binding `E_bind ≈ 13.6 eV`. The electron's gauge-fold-depth contribution to the bound state is `m_e ≈ 0.511 MeV`; the proton contributes the rest. The binding energy is the residual joint-closure correction after the constituent rest energies.

Electron–proton **scattering** (rather than binding) is a transient joint closure that does not stabilise. Excess distinctions are emitted as photon joint closures (per §2). Hydrogen formation is the stable case.

### Run the hydrogen joint closure

```bash
python particles.py --seed "^<" --max-depth 6 --enable-gauge True --environment-block
```

**Sample interaction output:**
```text
Seed: ^< (electron half-loop) approaching proton internal closure
Merged topology   : ^<v>^+^-
Classification    : hydrogen-class joint closure (bound state)
Constructing delay: 5 cycles (joint, distributed between electron and proton halves)
Creates local     : time (in the joint hydrogen Markov blanket)
Emitted radiation : +-   ← excess distinctions released as photon joint closure
Logical density note: HIGH → time is the local axis in the bound state
```

The output describes the **joint** closure, not the electron alone. The "electron's mass" of `m_e ≈ 0.511 MeV` is its share of the constructing delay distributed across the bound system.

## 4. Quick Reference Commands

| Demonstration | Command | What you see |
|---|---|---|
| Electron half-loop (gauge-folded, awaiting joint closure) | `python particles.py --seed "^<" --max-depth 4 --enable-gauge True` | Gauge fold → contribution to bound-state mass and local time |
| Photon half (massless) | `python particles.py --seed "^>" --max-depth 2 --enable-gauge False` | Pure forward-time spatial half-closure |
| Photon + antiphoton joint closure | Run both seeds above | Net action = 0 (joint event) |
| Hydrogen joint closure (e⁻ + p) | `python particles.py --seed "^<" --max-depth 6 --enable-gauge True` | Gauge handshake + photon emission; joint hydrogen bound state |

## 5. Links to More Advanced Reading

- [`Bound_States_QLF.md`](Bound_States_QLF.md) — **the framing of this doc**: free leptons are not QLF observables; atomic systems are. Positronium, muonium, hydrogen as the natural mass observables. Reduced-mass Bohr binding structure.
- [`Delayed_Choice_Eraser.md`](Delayed_Choice_Eraser.md) — the same joint-closure framing applied to photons; the canonical "retrocausality" experiment dissolves once the photon is a Hermitian-pair handshake with no free-projectile interpretation.
- [`Collective_Electrodynamics.md`](Collective_Electrodynamics.md) — joint ZFA closures as the unit of EM interaction; vector potential as unresolved free action.
- [`HALF-SPIN-ZFA-EMBEDDING.md`](HALF-SPIN-ZFA-EMBEDDING.md) — the half-spin ZFA atom (Hermitian pair) as the minimal joint closure; the QLF unit of physical existence.
- [`Particles.md`](Particles.md) — full particle zoo and gauge-folding rule.
- [`Hadrons_Markov_Blankets.md`](Hadrons_Markov_Blankets.md) — proton as composite Markov blanket; bound-state framing at the hadronic scale.
- [`Frequency_Synchronization.md`](Frequency_Synchronization.md) — constructing delay $\Delta t = R/f$.
- [`Hydrogen.md`](Hydrogen.md) — existing Bohr derivation of hydrogen levels in QLF language.
- [`Annihilation.md`](Annihilation.md) — the photon `^>` + antiphoton `v<` joint closure; electron–positron annihilation as a positronium-class joint event.
- [`Higgs.md`](Higgs.md) — gauge-fold-depth as the QLF mechanism for the gauge-fold contribution to bound-state mass.
- [`Entropy.md`](Entropy.md) — entropy conservation in joint closures.

## Conclusion

In QLF the electron is **not a free particle with mass `m_e ≈ 0.511 MeV`**. It is the **gauge-folded half of a joint ZFA closure** — bound with a positron to form positronium, with an antimuon to form muonium, or with a proton to form hydrogen. The "electron mass" of conventional physics is the electron half-loop's gauge-fold-depth contribution to the joint closure, half of `m(positronium)` and the analogous contribution to `m(hydrogen)`.

Photons are the same structural class: joint emitter-absorber closures, not free projectiles. The difference is the gauge fold — present in the electron half-loop, absent in the photon half-loop. Hence electrons contribute mass to their joint closures and photons do not.

Most everything we experience is the chemistry, light, and electric current of these joint closures. Understanding the electron in QLF means understanding which joint closures it can participate in — and the QLF observables are those joint closures, not the constituent halves.

**Don't shut up and calculate. Run it.**

Clone the repo, run the commands above, and watch the joint closures emerge from the same QuCalc engine.

See also: [`Bound_States_QLF.md`](Bound_States_QLF.md) — the framing of this doc, made explicit and scoped across positronium, muonium, hydrogen, and the τ-decay-vertex closure.

*Last aligned with repo state 22 April 2026. Reframed 03 June 2026 to align with `Bound_States_QLF.md` — free leptons are not QLF observables; atomic systems are.*
