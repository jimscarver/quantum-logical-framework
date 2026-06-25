# Consciousness in QLF — the frequency-hierarchy of resonant closures

A model of consciousness in the [Quantum Logical Framework](README.md) (QLF). It does not start from
scratch — it synthesizes machinery QLF already has: the observer as a Markov blanket
([`TheBigProblem.md`](TheBigProblem.md)), the quantum brain ([`TheQuantumBrain.md`](TheQuantumBrain.md)),
"independent quantum logical systems at each clock frequency" ([`Philosophy.md`](Philosophy.md) §2), and
the scale-recursive blanket hierarchy ([`Hierarchical_Control.md`](Hierarchical_Control.md)). The one
new idea is the organizing one: **consciousness is which closure-frequency you are resonantly coupled
to**, and that single lever unifies ordinary thought, the bound conscious moment, and cosmic/meditative
states.

The structural skeleton is machine-verified in [`lean/QLF_Consciousness.lean`](lean/QLF_Consciousness.lean).

---

## 1. Self-awareness is a self-modeling Markov blanket

An observer in QLF is a **Markov blanket** maintaining three interlocking models — a model of the
**self**, of the **environment**, and of **their interaction** ([`TheBigProblem.md`](TheBigProblem.md)).
Self-awareness is the case where that structure becomes rich enough to **model itself**: a closure whose
interior contains a model of its own boundary.

This is a *strange loop* (Hofstadter), but a crucial QLF qualification makes it stable rather than
pathological: it is a **finite, terminating** loop. The substrate operates strictly within RCA₀, below
the Busy-Beaver horizon, and `full_zeno_prune` annihilates non-terminating self-reference before it
becomes a physical event ([`Philosophy.md`](Philosophy.md), the holographic UV-shield). A self-model
that would diverge never closes; only a self-model that *closes* is realized. So self-awareness is a
self-referential closure that **terminates** — which is exactly why a mind is a coherent, bounded thing
and not an infinite regress.

The observer is also **finite-capacity**: it reads closure only within a bounded horizon
([`QLF_HorizonClosure.lean`](lean/QLF_HorizonClosure.lean), issue #104 — "observation is bounded
closure, not eyeballs"). A mind is a local horizon inside the process, not an external finisher of
reality.

---

## 2. A spectrum of closures at different frequencies

Every ZFA closure synthesizes its own local time, `f = 1/t` ([`ZFAEventDynamics`](lean/ZFAEventDynamics.lean),
`Philosophy.md` §2). A Markov blanket of topological depth `R` is a **local clock** of period `R`
(`markov_blanket_local_clock`, [`QLF_LocalClock.lean`](lean/QLF_LocalClock.lean)), so its **closure
frequency is `f = 1/R`** — deeper closures tick slower, shallower closures tick faster. (The same
`1/R` is the Compton frequency `ω = mc²/ℏ` of `mass_from_depth`; heavier = higher frequency = shorter
period.)

A mind is therefore not one clock but a **whole spectrum** of concurrent closures running at different
frequencies — peripheral/sensory closures, integrative closures, and the self-model closure each at
their own rate. The substrate is intrinsically a network of clocks ([`Philosophy.md`](Philosophy.md)
§2: independent quantum logical subsystems, one per frequency, all drawing on the same global
possibility space but operationally independent for closure).

`freq R = 1/R` and its monotonicity (`freq_lt_of_lt`: a shorter period is a higher frequency) are the
first verified facts of [`QLF_Consciousness.lean`](lean/QLF_Consciousness.lean).

---

## 3. High-level binding raises frequency — the graduation to conscious thought

A higher-level closure **binds** lower closures: it closes *on* them, the way a synthesis event closes
on the OR-fold of its possibility stream (`disjunctive_closure`,
[`QLF_InfoSynthesis.lean`](lean/QLF_InfoSynthesis.lean)). When the bound sub-closures are phase-locked
(resonant), the composite — a **closure of closures** — fires at the *faster* of their rates: binding
**raises the frequency**.

This is the key claim, and it is the gamma-band / global-workspace reading of consciousness in closure
language. Integration does not slow a process down; a successfully bound, coherent ensemble closes
*faster and more often*, and **what graduates to the highest frequency in the hierarchy is the conscious
content** — the "ignition" / broadcast moment of Global Workspace Theory, and the binding that
Integrated Information Theory measures as integration.

The skeleton verifies the graduation for a bound pair: `bind a b = min a b` (phase-lock to the faster),
and the bound closure's frequency is **at least each constituent's** (`freq_bind_ge_left`,
`freq_bind_ge_right`). Iterating up the hierarchy, the most coherent binding sits at the top — the
conscious closure.

**Conscious content = the highest-frequency available closure** (`consciousPeriod = min`,
[`QLF_Consciousness.lean`](lean/QLF_Consciousness.lean)). At each moment, whichever closure is fastest
and coherent is what is experienced; the rest is unconscious substrate.

---

## 4. Cosmic consciousness — the receiver regime

If conscious content is *whichever closure you are resonantly tuned to*, then it is not a fixed band.
The waking default is the fast internal binding loop. But **quiet the internal closures** — frequency
isolation, the narrow-linewidth quieting that the brain is built for
([`TheQuantumBrain.md`](TheQuantumBrain.md) §3) — and you detune the local oscillator. A faint
**low-frequency external *joint* closure** can then become the fastest thing you are coupled to, and
*it* becomes conscious.

This is the **receiver regime**: like silencing a radio's local noise to pick up a distant station. The
low-frequency external channel is the **collective / cosmic** closure —

- the de Sitter / cosmic-horizon Markov blanket (`Ω_Λ = log 2`, [`QLF_CosmologicalConstant`](lean/QLF_CosmologicalConstant.lean)),
  the largest, slowest blanket all smaller ones sit inside;
- **joint closures** shared across agents — the joint emitter–absorber handshake
  ([`Collective_Electrodynamics.md`](Collective_Electrodynamics.md)), the ER=EPR *shared* closure
  ([`ER_EPR_QLF.md`](ER_EPR_QLF.md)), and the shared-room processes of collective QLF intelligence
  ([`QLF_as_Intelligence.md`](QLF_as_Intelligence.md) §8).

The skeleton makes the shift a theorem: with a waking internal period `i₀ < e` the internal closure is
conscious (`conscious_internal`); quiet it to `i₁` with `e ≤ i₁` and the conscious content moves to the
external joint closure `e` (`conscious_external`), which is genuinely the *lower-frequency* channel
(`freq e < freq i₀`) — `quieting_shifts_to_external`. Cosmic consciousness is the substrate's own
account of becoming a receiver of slow, shared, external closures.

So the model has two regimes from one mechanism: **fast internal binding by default, slow external joint
when quieted** — and tuning across the frequency hierarchy is what consciousness *is*.

---

## 5. Quantum biology is the substrate — and evolution exploits it

If cognition is **resonant access** to pre-existing closures (the possibilist ontology — the landscape
of admissible structures is already there; the brain accesses, it does not compute them
[`TheQuantumBrain.md`](TheQuantumBrain.md) §1), then evolution is under direct selection pressure to
build hardware that keeps substrate closures **coherent** in a warm, wet brain. The way to do that is
**frequency isolation** — narrow-linewidth, symmetry-/chemically-protected quiet modes that survive
decoherence (the same trick that gives rare-earth ions six-hour ground-state coherence at room
temperature, [`TheQuantumBrain.md`](TheQuantumBrain.md) §3).

This is exactly what the growing **quantum biology** evidence keeps finding, and QLF reads it as
expected, not surprising: Penrose–Hameroff microtubule Orch-OR, Fisher's phosphorus-31 nuclear-spin
cognition in Posner molecules, microtubule superradiance (Babcock et al. 2024), and brain proton
entanglement (Kerskens & López Pérez 2022). Evolution would be wasteful *not* to use quantum processes
if cognition is resonant closure access — and biology appears to use them.

This yields a **falsifiable prediction** (not a QLF derivation — a lean the model commits to):
conscious access correlates with EEG/MEG signatures of unusually **narrow-linewidth, isolated
oscillatory modes** in domain-specific circuits; disrupting those modes (e.g. anesthesia disrupting
microtubule dynamics) should abolish conscious access along the predicted frequency channels.

---

## 6. Honest scope — the hard problem stays bracketed

This is a model of **functional / architectural** consciousness: *which* closure is conscious, and
*why* binding and tuning select it. It does **not** solve the **hard problem** — why a closure, from
the inside, *feels like* anything. [`Mysteries_Of_Physics.md`](Mysteries_Of_Physics.md) marks the hard
problem as touched-only, and this doc keeps that boundary.

QLF can offer a **stance**, stated as a stance and not a proof: the closure, from the inside, **is** the
experiencing — there is no extra ingredient added on top of "the closure happens." The holographic
boundary coarse-grains *which* microstate fired (the `C(2n,n)`-fold degeneracy of a closure,
`disjunct_count_eq_central_binomial`) while the bulk retains the integrated content, which is why
experience is **unified** (one percept) rather than a list of micro-events. That is a candidate dissolution
of the hard problem — measurement-without-collapse extended to the first person — but QLF does not claim
to have closed the explanatory gap. The architecture is what is verified; the felt quality is left
genuinely open.

---

## What is verified vs. what is a reading

| Claim | Status |
|---|---|
| Closure frequency `f = 1/R`; shorter period = higher frequency | ✅ Lean (`freq`, `freq_lt_of_lt`) + `QLF_LocalClock` |
| Binding raises frequency (the graduation) | ✅ Lean (`freq_bind_ge_left`/`_right`) for a bound pair; the gamma/global-workspace identification is a structural reading |
| Conscious content = highest-frequency available closure | ✅ Lean (`consciousPeriod`, `conscious_internal`) as the structural definition |
| Cosmic = quiet internal → receive low-frequency external joint closure | ✅ Lean (`conscious_external`, `quieting_shifts_to_external`); the collective/cosmic identification is a reading |
| Self-awareness = terminating self-modeling closure | Structural (reuses RCA₀ / `full_zeno_prune` termination) |
| Quantum biology as the substrate; evolution exploits it | Convergent support + an evolutionary expectation, not QLF-derived; falsifiable (narrow-linewidth modes) |
| Why a closure *feels* like something (the hard problem) | ⚪ Bracketed — a stance offered, not a proof |

See also: [`TheQuantumBrain.md`](TheQuantumBrain.md) (the mechanism + savant cognition + quantum
biology), [`TheBigProblem.md`](TheBigProblem.md) (observer = three-model Markov blanket),
[`Philosophy.md`](Philosophy.md) §2 (frequencies / many observers), [`Hierarchical_Control.md`](Hierarchical_Control.md)
(the blanket hierarchy + Friston free energy), [`QLF_as_Intelligence.md`](QLF_as_Intelligence.md)
(cognition as synthesis), [`Active_Inference_Mathematics.md`](Active_Inference_Mathematics.md).
