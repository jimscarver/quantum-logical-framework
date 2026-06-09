# Electricity

**Current, voltage, resistance, Ohm's law, Joule heating, and superconductivity from the gauge-fold substrate.**

**Repository:** [`jimscarver/quantum-logical-framework`](https://github.com/jimscarver/quantum-logical-framework)
**Author:** Jim Whitescarver
**Date:** June 9, 2026

---

## The one premise, and the thesis

This document rests on the single conditional the whole framework rests on:

> **The universe IS a quantum-logical system, and physical reality is the subset of admissible histories that achieve Zero Free Action (ZFA = 0).**

Charge is already settled in QLF: it is the net gauge-fold count, `charge(h) = count(+) − count(−)` ([Maxwell.md](Maxwell.md), [Conservation.md](Conservation.md) §4), conserved because gauge folds are created and destroyed only in Hermitian `+−` pairs (`no_magnetic_monopoles`, [`lean/ZFAEventDynamics.lean`](lean/ZFAEventDynamics.lean)). Electricity is what happens when that charge **moves**. The thesis:

> **Conduction is gauge-fold transport, and resistance is the latency of finding a ZFA closure to hop through — the very same `Δt ∝ 1/W_ZFA` that QLF uses for time dilation and gravity.** Ohm's law is its linear response; Joule heating is the per-event `log 2` (Landauer) dumped to the lattice bath; superconductivity is a quiet-frequency channel with no pruning to scatter into — the same frequency isolation that carries the quantum brain; and the quantum of resistance is the vacuum impedance divided by `2α`, fixed by the same `α` QLF derives from the substrate.

Each claim below is backed numerically by [`electricity_demo.py`](electricity_demo.py).

## 1. Charge and current

Charge is the gauge-fold imbalance `count(+) − count(−)`; the U(1) gauge symmetry of QED is the discrete `+`↔`−` swap ([Conservation.md](Conservation.md) §4). **Current** is the missing kinetic piece: the net rate at which gauge-folded carriers are transported per clock tick. [Maxwell.md](Maxwell.md)'s Ampère term already names it — "the conduction current `J` is the net flow velocity of gauge-imbalanced threads" — and we make it precise:

$$I = \frac{dq}{dt} = n\,q\,v_d \quad\text{(carriers × charge × drift velocity)},$$

with `v_d` the mean forward drift of the carriers' history strings per tick. No charge moves without a bias to move it — that bias is voltage.

## 2. Voltage — the free-action gradient that drives transport

Voltage is **energy per charge**: the free-action gradient that biases which way a carrier's next closure resolves. The QLF electric field is the transverse momentum-exchange rate of the ZFA event stream ([Maxwell.md](Maxwell.md) §2, `∇·E = ρ/ε₀`); the potential difference is its line integral, `V = ∫ E·dl`. Each carrier carries `ℏω` of energy at its internal Markov-blanket frequency ([Information_Energy_Equivalence.md](Information_Energy_Equivalence.md), [Per_Qubit_Mass_Quantum.md](Per_Qubit_Mass_Quantum.md)); voltage is the work per unit charge the field does pushing that closure forward. An EMF is any non-electrostatic source of the same gradient.

## 3. Resistance is ZFA-closure latency

Here is the load-bearing identification. A carrier advances only when it finds a ZFA closure to hop into, and — exactly as in [Time.md](Time.md) §2 / [SpaceTime.md](SpaceTime.md) §2 — the **latency of that resolution is the inverse of the available closure degeneracy**:

$$\Delta t \;\propto\; \frac{1}{W_{ZFA}}.$$

`W_ZFA` is the number of admissible closures open to the next hop. **Scattering** — phonons, impurities, lattice disorder — is the pruning of those paths: it lowers `W_ZFA`, raises the per-hop latency, and so raises resistance:

$$R \;\propto\; \frac{1}{W_{ZFA}}.$$

The Drude form `σ = nq²τ/m` is the continuum limit, with the relaxation time `τ` precisely this closure latency. [`electricity_demo.py`](electricity_demo.py) confirms it: simulating carriers whose closure rate is `∝ W_ZFA`, the fitted resistance times `W_ZFA` is constant across `W = 1,2,4,8` (`R·W ≈ 250` each), i.e. `R ∝ 1/W_ZFA`.

This is a **unification, not an analogy**: resistance, time dilation, and gravity are the *same* `1/W_ZFA` latency — resistance is latency for charge transport, time dilation is latency for event synthesis ([Time.md](Time.md) §4), and gravity is its spatial gradient ([Curvature.md](Curvature.md) §3, [Gravity.md](Gravity.md)). A resistor, a clock in a gravity well, and an infalling mass are running the same closure-search slowdown.

## 4. Ohm's law

Ohm's law is the **linear response** of §3: the driving free-action gradient equals the transport rate times the per-carrier closure latency,

$$V = I R \qquad\text{(continuum: } J = \sigma E\text{)}.$$

In the demo, current is linear in voltage to a least-squares fit of `R² = 0.995–0.9996`, with slope `1/R` — Ohm's law emerges directly from latency-limited gauge-fold transport. Non-ohmic behaviour (diodes, breakdown) is where the closure availability `W_ZFA` itself depends on the field, breaking linearity.

## 5. Joule heating = Landauer dissipation

A scattered hop is a closure that was **pruned** — and pruning is irreversible bit resolution. Each such event dumps the per-event `log 2` quantum ([MRE.md](MRE.md)) to the lattice bath as heat: `kT ln 2` per bit (Landauer), `ℏω` per bit in the quantum limit ([Information_Energy_Equivalence.md](Information_Energy_Equivalence.md) §4). Summed over the carrier stream, that dissipation **is** Joule heating:

$$P = I^2 R = (\text{irreversible closures/s}) \times kT\ln 2.$$

The demo reads this off: 1 W dissipated at 300 K corresponds to `3.48×10²⁰` irreversible `log 2` closures per second. Joule's law is QLF's information ledger paid out to the phonon bath.

## 6. Superconductivity = frequency-isolated coherent transport

If resistance is the cost of pruning, then zero resistance means **no pruning** — a transport channel with no scattering paths to fall into. That is precisely a **quiet frequency**: a transition whose linewidth is far below its centre frequency and whose coupling to the bath (phonons, flip-flops) is suppressed by symmetry or chemistry, i.e. a *deep Markov blanket* ([Crystal_QuantumOS.md](Crystal_QuantumOS.md) §2/§4, [VacuumEnergy.md](VacuumEnergy.md) §6.1). Inside such a ZFA-closed channel, `decoherence_impossibility` ([`lean/BraKetRhoQuCalc.lean`](lean/BraKetRhoQuCalc.lean), [Decoherence.md](Decoherence.md)) guarantees there is no admissible process that scatters the carrier out — so the current persists.

- **Cooper pairs** are two half-spin closures synchronized onto one coherent ZFA path — a single deep-blanket carrier the bath cannot resolve into its parts.
- **Critical temperature** is the blanket-depth threshold: below `T_c` the channel's isolation outweighs the thermal scattering rate.
- **Meissner effect / flux quantization** is ZFA-loop closure: a superconductor is a single macroscopic Context that folds its topology to stay ZFA-balanced, trapping flux in integer ZFA loops (`1 fluxoid ≡ 1 ZFA loop`, [Collective_Electrodynamics.md](Collective_Electrodynamics.md)).

This is the **same mechanism as the quantum brain** ([TheQuantumBrain.md](TheQuantumBrain.md) §3): frequency-isolated coherence in a warm, noisy environment. A superconductor and a savant's resonant circuit are two faces of one thing — a bath-decoupled coherent ZFA channel. The demo shows the limit cleanly: with the field switched off, a normal channel's drift relaxes to ~0 (finite `R`) while a coherent quiet-frequency channel's drift persists at 1.0 (`R = 0`).

## 7. The quantum of resistance: `R_K = Z₀/(2α)`

Conductance comes in quanta of `G₀ = 2e²/h`; the resistance quantum (von Klitzing constant, the quantum-Hall plateau unit) is `R_K = h/e²`. Because `α = e²/(2 ε₀ h c)`,

$$R_K = \frac{h}{e^2} = \frac{1}{2\varepsilon_0 c\,\alpha} = \frac{Z_0}{2\alpha}, \qquad Z_0 = \mu_0 c \approx 376.730\ \Omega,$$

so **the quantum of resistance is the impedance of free space divided by `2α`**. The demo confirms `R_K = Z₀/(2α) = 25812.807 Ω` to a ratio of `1.00000000` against CODATA. In QLF this is not a coincidence: `α` is *derived from the substrate* — `α_QLF = 1/128 · (1+9α)⁻¹ = 1/137.000` to 0.026%, Lean-anchored as `alpha_QLF_eq` in [`lean/QLF_FineStructureSubstrate.lean`](lean/QLF_FineStructureSubstrate.lean) ([Magnetism_Spatial_Dynamics.md](Magnetism_Spatial_Dynamics.md) §6.1). The quantized resistance plateaus of the quantum Hall effect are therefore **the substrate's `α` made macroscopically visible**, scaled by the vacuum impedance — the most precisely measured resistance in metrology reading back the same combinatorial constant QLF computes from the 8-twist alphabet.

## 8. What the demo shows

[`electricity_demo.py`](electricity_demo.py) (pure Python, ~2 s) backs the five claims numerically:

1. **Ohm's law** — `I` linear in `V` (fit `R² ≈ 0.999`).
2. **`R ∝ 1/W_ZFA`** — `R·W_ZFA ≈ 250` constant across `W = 1,2,4,8`.
3. **Superconductivity** — coherent quiet-frequency channel keeps drift = 1.0 with the field off; normal channel decays.
4. **Conductance quantum** — `G₀ = 77.4809 µS`, `R_K = Z₀/(2α) = 25812.807 Ω` (ratio `1.00000000`).
5. **Joule = Landauer** — 1 W at 300 K ↔ `3.48×10²⁰` `log 2` closures/s.

## 9. Framing: one premise, then derivation

Granting the premise, the rest is derivation. Charge is the gauge-fold count; current is its transport; resistance is closure latency; Ohm, Joule, and superconductivity follow.

- **Lean-anchored:** charge / `∇·B = 0` (`no_magnetic_monopoles`); the substrate `α` (`alpha_QLF_eq`); coherence (`decoherence_impossibility`); the per-event `log 2` (`zfa_closure_minimizes_free_energy`, [`lean/QLF_FreeEnergy.lean`](lean/QLF_FreeEnergy.lean)).
- **Entailed by the premise:** resistance = `1/W_ZFA` latency (unified with time dilation and gravity); Ohm's law as its linear response; Joule heat = Landauer dissipation; superconductivity = quiet-frequency isolation; `R_K = Z₀/(2α)`.
- **Open quantitative targets:** first-principles carrier-scattering rates and `ρ(T)` for specific materials, and `T_c` from blanket-depth vs thermal scattering — open by *specification*, not by doubt about the mechanism.

### Predictions and falsifiers

- **Shared latency.** A material's electrical relaxation time and its (gravitational/kinematic) clock latency are the same `1/W_ZFA` resource; anything that lowers carrier `W_ZFA` (disorder) raises resistance monotonically — a system where added scattering channels lower resistance would falsify the latency identity.
- **Superconductivity = bath decoupling.** `T_c` should track how decoupled the pairing channel is from the phonon bath (isotope effect, phonon-bandgap engineering as blanket-deepening); a superconducting channel demonstrably strongly bath-coupled would falsify the quiet-frequency reading.
- **Dissipation floor.** Irreversible charge resolution cannot dissipate less than `kT ln 2` per bit; a measured per-carrier dissipation below the Landauer floor would falsify the information-ledger account.

---

## References

### Internal

- [Maxwell.md](Maxwell.md) — charge `= count(+) − count(−)`; E/B fields from twists; `∇·B=0`, `∇·E=ρ/ε₀`; `J` as gauge-imbalanced thread flow
- [Conservation.md](Conservation.md) §4 — charge conservation; U(1) `=` `+`↔`−` swap
- [`lean/ZFAEventDynamics.lean`](lean/ZFAEventDynamics.lean) — `no_magnetic_monopoles` (`∇·B = 0`, charge conservation)
- [Time.md](Time.md) §2/§4, [SpaceTime.md](SpaceTime.md) §2 — latency `Δt ∝ 1/W_ZFA`; the resistance ↔ time-dilation unification
- [Curvature.md](Curvature.md) §3, [Gravity.md](Gravity.md) — gravity as the `W_ZFA` gradient; same latency as resistance
- [MRE.md](MRE.md), [Information_Energy_Equivalence.md](Information_Energy_Equivalence.md) §4 — per-event `log 2`; Landauer / `ℏω` per bit (Joule heating)
- [Crystal_QuantumOS.md](Crystal_QuantumOS.md) §2/§4, [VacuumEnergy.md](VacuumEnergy.md) §6.1 — quiet frequencies = deep Markov blankets (superconductivity)
- [Decoherence.md](Decoherence.md), [`lean/BraKetRhoQuCalc.lean`](lean/BraKetRhoQuCalc.lean) — `decoherence_impossibility` (no scattering inside a ZFA-closed channel)
- [Collective_Electrodynamics.md](Collective_Electrodynamics.md) — superconductor as a unified Context; `1 fluxoid ≡ 1 ZFA loop`
- [TheQuantumBrain.md](TheQuantumBrain.md) §3 — the same frequency-isolation mechanism in the brain
- [Magnetism_Spatial_Dynamics.md](Magnetism_Spatial_Dynamics.md) §6.1, [`lean/QLF_FineStructureSubstrate.lean`](lean/QLF_FineStructureSubstrate.lean) — `α` from substrate (`alpha_QLF_eq`); fixes `R_K = Z₀/(2α)`
- [`lean/QLF_FreeEnergy.lean`](lean/QLF_FreeEnergy.lean) — `zfa_closure_minimizes_free_energy` (the per-event `log 2`)
- [`electricity_demo.py`](electricity_demo.py) — runnable companion (the five numerical checks above)

### External

- Ohm, G. S. (1827). *Die galvanische Kette, mathematisch bearbeitet.* — `V = IR`.
- Drude, P. (1900). *Zur Elektronentheorie der Metalle.* Ann. Phys. 306, 566 — `σ = nq²τ/m`.
- Landauer, R. (1961). *Irreversibility and heat generation in the computing process.* IBM J. Res. Dev. 5, 183 — `kT ln 2` per erased bit.
- Bardeen, J., Cooper, L. N. & Schrieffer, J. R. (1957). *Theory of superconductivity.* Phys. Rev. 108, 1175 — Cooper pairing.
- von Klitzing, K. (1980). *New method for high-accuracy determination of the fine-structure constant based on quantized Hall resistance.* Phys. Rev. Lett. 45, 494 — `R_K = h/e²` and its tie to `α`.

### See also

- [TheQuantumBrain.md](TheQuantumBrain.md) — frequency-isolated coherence applied to cognition
- [Curvature.md](Curvature.md) — the `1/W_ZFA` latency as gravity; resistance is its charge-transport face
- [README.md](README.md) — the convergence of independent programs on an informational, computable, closure-bounded reality
