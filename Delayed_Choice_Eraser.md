# Delayed-Choice Quantum Eraser in QLF

The delayed-choice quantum eraser (Scully & Drühl 1982; Kim et al. 1999; Walborn et al. 2002) is the textbook "retrocausality paradox" of quantum optics: a choice made *after* a signal photon has been detected appears to determine whether that already-detected signal exhibits interference. QLF resolves it without retrocausality, without wavefunction collapse, and without observer-dependent reality — because in QLF the photon is **not an object that travels and gets measured**, it is a **joint ZFA closure across two causal diamonds**, and the closure has no preferred temporal direction.

This document treats the eraser as the cleanest experimental witness that photons in QLF are the most observer-relative objects in the theory — fully relational, fully transactional, and fully consistent with the existing transactional framing of [Collective_Electrodynamics.md §2](Collective_Electrodynamics.md).

---

## 1. The experiment

The canonical Walborn 2002 / Kim 1999 setup:

1. A pump photon excites a nonlinear crystal, producing an entangled signal-idler pair via spontaneous parametric down-conversion (SPDC).
2. The **signal** photon passes through a double-slit-like apparatus and lands on a position-resolving detector `D_s`.
3. The **idler** photon is routed to one of several detectors that can:
   - **Erase** which-path information (combining the two slit-correlated paths into a single detector `D_e`),
   - **Preserve** which-path information (separating them into `D_p1` and `D_p2`).
4. The choice of which idler detector to use can be made *after* the signal photon has already been recorded — sometimes by many nanoseconds, sometimes by light-travel times across the lab.

**The observed pattern**:

- The total signal distribution at `D_s`, ignoring which idler detector fired, shows **no interference** — a blur, no fringes.
- The subset of signal events at `D_s` coincident with the eraser detector `D_e` shows **clear interference fringes**.
- The subset coincident with `D_p1` or `D_p2` shows **no interference** (which-path-preserved).
- The interference appears only when one **sorts post hoc** by which idler detector fired.

The standard puzzle: *the idler choice was made after the signal hit `D_s`; how can the signal "know" whether to make fringes or not?*

---

## 2. The retrocausality reading and why it is wrong

A naive reading: the idler measurement retroactively reaches back through time and "decides" how the signal photon behaves at `D_s`. This is the version popular in pop-science treatments.

This reading is wrong even within standard QM, because **no signal-marginal interference pattern changes regardless of what the idler experimenter does**. The full signal histogram at `D_s` is identical whether the eraser is on, off, or never installed. The fringes appear only in coincidence-sorted subsets. There is no signalling, no retrocausal influence on any locally measurable quantity. The puzzle exists only if one insists the signal photon "had" a definite behaviour at `D_s` independent of the joint state.

QLF makes this explicit by denying the premise.

---

## 3. The QLF resolution: joint ZFA closure across two causal diamonds

In QLF the photon is not a thing that travels. From [Collective_Electrodynamics.md §2](Collective_Electrodynamics.md):

> A photon is the macroscopic observation of **joint Zero Free Action (ZFA)** — a Hermitian-conjugate handshake between an emitter and an absorber when their causal light cones intersect.

For the SPDC pair, the constructive picture is:

- The pump-crystal emission opens **two simultaneously-unresolved Hermitian deficits**, one in the signal channel and one in the idler channel. They are not "two photons" — they are **one joint deficit** with two unresolved boundaries.
- The signal "detection" at `D_s` is one half of the closure: it pins down where one boundary of the joint deficit lands on the signal-side causal frontier, but does **not** by itself close the joint ZFA — the idler boundary is still unresolved.
- The idler detection (`D_e` or `D_p1`/`D_p2`) closes the other boundary. **Only after both boundaries close does the joint ZFA event exist**.
- Until both close, there is no "photon" in the ledger — only an unresolved possibility tree expanding in both causal directions ([Collective_Electrodynamics.md §1](Collective_Electrodynamics.md) — vector potential = unresolved free action).

This is exactly the [Cramer 1986 transactional](#references) reading, but constructive: the joint state is a topological deficit, not an offer-wave / confirmation-wave amplitude pair. The deficit is **literally the same object** as the unresolved Hermitian pair in [HALF-SPIN-ZFA-EMBEDDING.md §2](HALF-SPIN-ZFA-EMBEDDING.md).

**Why interference appears in coincidence-sorted subsets.** The two SPDC paths through the crystal contribute distinct topological histories. The signal-marginal distribution sums over both, washing them out. The eraser detector `D_e` realises only joint closures whose idler boundary is in the path-erased subspace — selecting a subset of joint events whose topological histories interfere coherently. The which-path detectors `D_p1`/`D_p2` realise only joint closures in the path-distinguished subspace — selecting non-interfering subsets. The "fringes" are a property of the joint closure subset, not of the signal photon's "behaviour."

**Why the delay is irrelevant.** The joint ZFA closure is a relational event between two causal-frontier intersections. It has no temporal ordering — the two boundaries are linked algebraically, not causally. The signal "event" at `D_s` is not a complete closure; it is half a closure that becomes part of the ledger only when its partner closes. The ledger doesn't care which boundary closes first in any single observer's frame.

This is the same null-geodesic invariance that says light has no rest frame: the joint ZFA closure is a null logical loop, [zero proper-time in the emergent spacetime manifold](UniversalRelativity.md).

---

## 4. Why there is no retrocausality

The retrocausality narrative requires a thing — the signal photon — that "had" a definite state at `D_s` before the idler choice. QLF denies the antecedent: at `D_s` what was recorded was a *half-closure*, not a photon. The half-closure does not have an interference vs. no-interference attribute. The attribute is a property of the joint closure subset, which only becomes a fact once the partner boundary closes.

Compare with standard QM: until the idler is measured, the joint state is `(|path₁_s⟩|path₁_i⟩ + |path₂_s⟩|path₂_i⟩)/√2`. The signal-marginal density matrix is `(|path₁_s⟩⟨path₁_s| + |path₂_s⟩⟨path₂_s|)/2` — diagonal, no interference. Measuring the idler in the path basis preserves this; measuring the idler in an erased basis projects the joint state onto an interfering combination. **No signal-marginal observable depends on the idler choice.** The "interference" lives in the conditional distribution given the idler outcome.

QLF reads this constructive: the conditional distribution is the subset of joint ZFA closures whose idler boundary landed in a specific topological class. Conditioning on the idler outcome is selecting a subset of the joint ledger — a perfectly local operation on records.

This is also why Wheeler's classic 1978 "delayed-choice" thought experiment (insert/remove the second beamsplitter after the photon has entered the interferometer) is non-paradoxical in QLF: the photon is not a thing that "chose" wave vs. particle behaviour at the first beamsplitter and now retroactively re-chooses. The closure event is the second-beamsplitter intersection. The first beamsplitter contributes an open Hermitian deficit; the second-beamsplitter configuration determines which closure topology is realised.

---

## 5. Predictions and falsifiability

The QLF reading makes specific predictions that distinguish it from purely instrumentalist or many-worlds readings:

| QLF reads the eraser as ... | Distinguishes from |
|---|---|
| Joint ZFA closure, no signal-marginal change | Strong retrocausal interpretations that predict signal-marginal interference would shift if the eraser were toggled |
| Hermitian-pair half-closure at `D_s` | Collapse interpretations that require a definite signal state before idler measurement |
| Topological closure subset selects fringes | Many-worlds readings where every outcome is realised in some branch (QLF retains a single ledger) |
| Null logical loop, no temporal ordering | Hidden-variable theories with a preferred frame |

**A concrete falsifier**: the QLF reading requires the joint ZFA closure to be a topological identity between the signal and idler legs. If a future experiment demonstrated **signal-marginal interference modulation** by an idler-side configuration choice — i.e., any signalling-class result — QLF's joint-ZFA framing would be falsified. The existing 40+ years of eraser experiments have not seen this; the prediction is *consistency* with that null result, not a new effect.

A more aggressive falsifier (open work): the joint ZFA closure should impose a specific information-theoretic constraint on the coincidence-sorted distributions. The Born-rule path-counting argument ([Born_Rule.md](Born_Rule.md)) predicts that the conditional fringe visibility is bounded by `|<path₁|path₂>|`-like overlap — same as standard QM, but derived from possibility-tree multiplicity ratios rather than postulated. A quantitative match against tabulated visibility curves for the Kim et al. 1999 setup would tighten this; that comparison is open work.

---

## 6. Why this is the cleanest experimental witness of the relational-photon picture

The delayed-choice quantum eraser is the experiment most aggressively designed to make the photon look like a thing with retrocausal access to its own past. QLF's joint-ZFA reading dissolves the puzzle without invoking retrocausality, collapse, branching universes, or hidden variables — only by denying that the photon is a separate object from its emitter-absorber pair. Every observation in the eraser literature is consistent with the relational-photon ledger; no observation requires anything more.

This is the same intellectual move that the meta-doc ([Active_Inference_Mathematics.md §3](Active_Inference_Mathematics.md)) makes for mathematical objects in general: the "thing" is the admissible trajectory of a joint closure event, not an object that persists between events. The eraser is the experimental face of that math.

---

## References

### Internal

- [Collective_Electrodynamics.md §2](Collective_Electrodynamics.md) — the photon-as-joint-ZFA framing this doc applies to the eraser
- [Maxwell.md](Maxwell.md) — Maxwell's equations from the 8-twist algebra; the field side of the photon picture
- [Entanglement.md](Entanglement.md) — entangled-pair handling in QLF
- [Measurement_Problem.md](Measurement_Problem.md) — the broader "no collapse" reading of measurement events
- [HALF-SPIN-ZFA-EMBEDDING.md §2](HALF-SPIN-ZFA-EMBEDDING.md) — unresolved Hermitian deficit as the joint state
- [UniversalRelativity.md](UniversalRelativity.md) — null logical loops and the absence of preferred temporal ordering
- [Born_Rule.md](Born_Rule.md) — multiplicity-ratio derivation that bounds conditional-fringe visibility
- [Active_Inference_Mathematics.md §3](Active_Inference_Mathematics.md) — the relational-trajectory math substrate

### External

- Scully, M. O., & Drühl, K. (1982). *Quantum eraser*. Phys. Rev. A 25, 2208–2213.
- Kim, Y.-H., Yu, R., Kulik, S. P., Shih, Y., & Scully, M. O. (1999). *Delayed-choice quantum eraser*. Phys. Rev. Lett. 84, 1–5. arXiv:quant-ph/9903047.
- Walborn, S. P., Terra Cunha, M. O., Pádua, S., & Monken, C. H. (2002). *Double-slit quantum eraser*. Phys. Rev. A 65, 033818.
- Wheeler, J. A. (1978). *The "past" and the "delayed-choice" double-slit experiment*. In *Mathematical Foundations of Quantum Theory*, A.R. Marlow (ed.), 9–48.
- Cramer, J. G. (1986). *The transactional interpretation of quantum mechanics*. Rev. Mod. Phys. 58, 647–687.

### See also

- [Collective_Electrodynamics.md](Collective_Electrodynamics.md) — the photon's relational-handshake reading that this doc applies to a specific experiment.
- [Active_Inference_Mathematics.md §5](Active_Inference_Mathematics.md) — the scoreboard upgrade adds this experiment as a derived row.
