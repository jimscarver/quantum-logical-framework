# Quantum Field Theory in [QLF](README.md): the continuum limit of discrete event combinatorics

Quantum field theory is the most accurate framework physics has — and the most troubled at its foundations: its calculations require subtracting infinities (renormalization), its perturbation series diverge, and a rigorous continuum construction in four dimensions is an open Clay problem. QLF's reading explains both the success and the trouble in one stroke: **QFT is the continuum/statistical limit of the substrate's discrete ZFA-event combinatorics.** The machinery works because the substrate really is doing sum-over-histories; the infinities appear only when you push that sum to a *continuum* of modes — and the continuum is exactly where QLF says the catastrophe lives.

> "The left side (QLF) is the exact, finite, discrete combinatorial generation of phase states. The right side (Dirichlet/Zeta, and here the QFT amplitude) is the classical analytic shadow of that same generation." — [`Riemann-Conjecture-Proof.md`](Riemann-Conjecture-Proof.md)

---

## 1. The correspondence at a glance

| QFT construct | QLF substrate object |
|---|---|
| Path integral / sum over histories | the **possibility tree** of admissible ZFA-closed histories (`expand_generation`), phase-weighted ([`Born_Rule.md`](Born_Rule.md) §2) |
| Probability amplitude `⟨φ\|ψ⟩` | `∑_{h} e^{iθ(h)}` over admissible Pauli-closed paths `ψ→φ` |
| Creation operator (ket) | RhoQuCalc `action f` — a `[pos,neg]` ket-direction event |
| Annihilation operator (bra) | RhoQuCalc `lift f` — a `[neg,pos]` bra-direction event ([`BraKetRhoQuCalc.md`](BraKetRhoQuCalc.md)) |
| Superposition | `parallel p q` — `eval = p.eval + q.eval` |
| Composition / time-ordering | `sequence p q` — `eval = p.eval * q.eval` |
| Adjoint / conjugation | `dagger p` — `(p.eval)†` (the antiunitary time-reverse, [`Reversibility.md`](Reversibility.md)) |
| Fock space | the generated multi-history tree (many parallel closures) |
| Vacuum `\|0⟩` | the empty / `ℒ=0` identity closure ([`Lagrangian_Formulation.md`](Lagrangian_Formulation.md)) |
| Pair creation / annihilation | a Hermitian-pair build / unwind, `±log 2` per atom ([`MRE.md`](MRE.md) ↔ [`Annihilation.md`](Annihilation.md)) |
| One-loop factor | the substrate **loop phase `2π`** (`g−2 = α/2π`, Lamb `4/3πn³`) |
| Renormalization-group running | `1/α(t) = 1/α₀ + (b/2π)t` ([`lean/QLF_RunningCouplings.lean`](lean/QLF_RunningCouplings.lean)) |
| UV cutoff / regulator | the **discrete Planck closure floor** — intrinsic, not imposed |

---

## 1a. The priority — quantum truth is prior to space and time

The load-bearing move, under everything below, is an **ordering of priority**. In QLF a proposition is a
phase-string distinction, and its truth is decided by **ZFA closure** — balanced or not. That is a *logical
fact about the history*, and it does **not** presuppose a location in a pre-existing continuum: a substrate
event is a finite list of closure steps with **no coordinates** (`Event = List α`, `reachable A B := A <+: B`
— a pre-geometric causal set, [`lean/QLF_ReachableEvent.lean`](lean/QLF_ReachableEvent.lean)), and the logic
of those closures is an orthomodular lattice that needs no metric (the minimal quantum logic `MO2`,
[`lean/QLF_QuantumLogic.lean`](lean/QLF_QuantumLogic.lean)). Spacetime is **not** the stage on which truth is
evaluated; it is the *rendering* of the pattern of closures that have already been decided — local time is
constructing delay, spatial structure is the mutual relation of closed events, and there is no global time
line the whole cosmos shares (`causal_order_not_total`, [`lean/QLF_LogicalBang.lean`](lean/QLF_LogicalBang.lean)).
Both appear *after* the logical selection, not before it.

**This priority is exactly what lets QLF read QFT as a derived continuum shadow rather than a fundamental
continuum theory.** Standard QFT writes fields `φ(x)` on a manifold and integrates over all modes at every
point — the ultraviolet divergences are the price of assuming spacetime is already there, with infinitely
many degrees of freedom at every point. QLF reverses the order:

1. Truth is decided by discrete ZFA closure — **independent of continuum coordinates**.
2. **Only closed histories are realized** (`QLF_Firebreak`: the possibility tree generates all `4ⁿ` paths,
   ZFA closure is the firebreak; the realized sum is finite at every causal horizon).
3. The continuum fields and their path integral are the **statistical limit** of those closed histories.
4. Because the underlying decisions were **never continuum-indexed**, there is no infinite tower of modes to
   integrate — the Planck-scale closure floor is intrinsic, not imposed.

So the independence of quantum truth from time and space is the premise; "the path integral is a sum over
already-decided closed histories" (§2), "renormalization is bookkeeping for a continuum that was never
fundamental" (§4), and "local field operators are coarse-grained descriptions of patterns of closures" (§3)
are its consequences. Without this priority, fields would have to be fundamental on a manifold and the
discrete substrate would be only an approximation; with it, the discrete logic is prior and the continuum is
the approximation.

> Quantum truth is independent of time and space because truth *is* ZFA closure, and spacetime is
> synthesized *from* closures. That priority is what allows QLF to keep the empirical content of quantum
> field theory while reading its ultraviolet divergences as continuum artifacts rather than physical
> necessities.

---

## 2. The path integral *is* the possibility tree

Feynman's sum over histories is, in QLF, literal and primary: the amplitude is the phase-weighted sum over admissible ZFA-closed micro-histories, with the path space **restricted to Pauli-closed strings and finite at each causal horizon** (the BFS saturation of [`MRE.md`](MRE.md) §2.2, [`Born_Rule.md`](Born_Rule.md)):

$$\langle \varphi \mid \psi \rangle = \sum_{h \,\in\, \mathcal{T}_{\psi\to\varphi}} e^{\,i\,\theta(h)}, \qquad P(\varphi\mid\psi) \propto |\langle\varphi\mid\psi\rangle|^2.$$

The squared modulus, the interference, and the propagator are all read off this sum (the double slit is the cleanest case, [`Double_Slit.md`](Double_Slit.md)). QFT's continuous path integral `∫ 𝒟φ e^{iS[φ]/ℏ}` is the thermodynamic limit of this discrete, combinatorially finite sum.

This is QLF's Millennium **engine**: *generate every history, then select the invariant* — the possibility tree generates all `4ⁿ` paths, **ZFA closure is the firebreak** ([`QLF_Firebreak`](lean/QLF_Firebreak.lean), `not_all_paths_close`) that plays the role of stationary phase, and the continuous `∫ 𝒟φ e^{iS/ℏ}` is its continuum *rendering*. The same generate-then-select move that Witten 1988 ran as the Chern–Simons path integral to compute the Jones polynomial (discharged by Reshetikhin–Turaev) underlies each Millennium attack — see [`Millennium.md`](Millennium.md) § *The engine*.

## 3. Second quantization without a new layer

QFT's creation/annihilation operators and Fock space are not an extra postulate in QLF — they are already the RhoQuCalc algebra ([`BraKetRhoQuCalc.md`](BraKetRhoQuCalc.md)). A **ket** (`action`, contributing `[pos,neg]`) creates; a **bra** (`lift`, `[neg,pos]`) annihilates; `parallel` superposes; `sequence` time-orders; `dagger` conjugates. Pair creation is a Hermitian-pair build (`+log 2`), pair annihilation its unwind (`−log 2`, [`Annihilation.md`](Annihilation.md)). The vacuum is the `ℒ=0` identity closure — not an infinitely-energetic sea but the balanced ground state, with a **discrete, bounded** zero-point spectrum (flat per log-frequency, no ultraviolet pile-up; [`VacuumEnergy.md`](VacuumEnergy.md)) whose cosmological residue is `Ω_Λ = log 2` ([`QLF_CosmologicalConstant`](lean/QLF_CosmologicalConstant.lean)).

## 4. Renormalization, and why the infinities are a continuum artifact

This is the load-bearing point. Standard QFT's ultraviolet divergences come from integrating over a **continuum** of field modes up to arbitrarily high frequency; renormalization is the elaborate bookkeeping that subtracts those continuum infinities to extract finite answers. QLF has the same **one-loop RG structure** — `1/α(t) = 1/α₀ + (b/2π)·t`, asymptotic freedom for `b>0`, infrared screening for `b<0`, and a located Landau pole ([`lean/QLF_RunningCouplings.lean`](lean/QLF_RunningCouplings.lean)) — but **the substrate has a discrete Planck-scale closure floor** ([`QLF_PlanckScale`](lean/QLF_PlanckScale.lean)), so the running is **cut off intrinsically**:

> the Landau pole is *located but cut off by the substrate's discrete UV floor — no continuum divergence* — the "continuum is the UV catastrophe" thesis ([`TheContinuum.md`](TheContinuum.md) §3.1).

So renormalization is not a fundamental operation; it is a **continuum artifact**. On a discrete substrate the divergent integrals never arise — there is a smallest closure, a largest frequency, and the sums are finite. The infinities QFT spends so much machinery removing are the signature that it is computing on a continuum that is not physically there. (The `2π` that dresses every loop — `g−2 = α/2π`, the Lamb prefactor `4/3πn³` — is the substrate's loop phase, the same `2π` behind `Ω_Λ` and the horizon temperatures, not a regulator.)

## 5. The one explicit bridge

What QLF does **not** do is construct the rigorous continuum QFT (a Wightman/Osterwalder–Schrader field theory on ℝ⁴) and prove its properties. That step — the Clay Yang–Mills problem — is the single named boundary axiom `yang_mills_continuum_gap` ([`lean/QLF_MassGap.lean`](lean/QLF_MassGap.lean), [`YangMills_MassGap_QLF.md`](YangMills_MassGap_QLF.md)): the substrate proves the gap is `log 2 > 0` on the discrete side, and the axiom carries it to the continuum theory. Contrast-then-focus: QLF does not claim the constructive-QFT continuum is built; it claims the discrete substrate that the continuum is the *limit of*, plus the one explicit crossing.

## 6. Honest scope, and the anti-continuum reading

- **Proven / structural:** the path-integral amplitude and interference ([`Born_Rule.md`](Born_Rule.md)); the RhoQuCalc creation/annihilation algebra ([`BraKetRhoQuCalc.md`](BraKetRhoQuCalc.md)); the one-loop RG structure and UV-finiteness-by-floor ([`QLF_RunningCouplings`](lean/QLF_RunningCouplings.lean), [`QLF_PlanckScale`](lean/QLF_PlanckScale.lean)); the loop-phase `2π` (`g−2`, Lamb); the discrete bounded vacuum ([`VacuumEnergy.md`](VacuumEnergy.md)); the mass-gap quantum ([`QLF_MassGap`](lean/QLF_MassGap.lean)).
- **Open:** the β-coefficients beyond the substrate-fixed `b₀=7` need full matter content; absolute couplings need the Higgs VEV; and the rigorous continuum construction is the `yang_mills_continuum_gap` boundary.

**Does this strengthen the case against the continuum?** Yes — concretely. (i) QFT's UV divergences, the literal *ultraviolet catastrophe*, are produced by the continuum of modes; the discrete substrate removes them *by construction*, so renormalization is revealed as continuum bookkeeping rather than physics. (ii) The wavefunction/amplitude is the statistical limit of a *finite, phase-weighted path count* ([`Born_Rule.md`](Born_Rule.md)) — the continuous field is a rendering of discrete combinatorics. (iii) The uncertainty principle is the price of mapping a continuum onto integer counts ([`UncertaintyPrinciple.md`](UncertaintyPrinciple.md)) — the empirical signature that there is no continuum underneath, only counts and phases. These are corroborating evidence for the load-bearing thesis ([`Continuum_Choice_Fallacy.md`](Continuum_Choice_Fallacy.md)) that **the continuum is mathematics' ultraviolet catastrophe and the discrete computable substrate is the quantum that resolves it** — not a new proof, but a sharper one: QFT is where the catastrophe is most visible, and the substrate is where it disappears.

## See also

- [`Perturbation_Theory_QLF.md`](Perturbation_Theory_QLF.md) — the perturbation series as the closure-order expansion, the search event registry computing it, and the capacity-horizon renormalization (Wilsonian, finite by the Kraft bound).
- [`Continuum_Choice_Fallacy.md`](Continuum_Choice_Fallacy.md) · [`TheContinuum.md`](TheContinuum.md) — the continuum/UV-catastrophe thesis.
- [`Born_Rule.md`](Born_Rule.md) · [`Double_Slit.md`](Double_Slit.md) · [`Shannon_And_Phase.md`](Shannon_And_Phase.md) — amplitudes, interference, count vs phase.
- [`BraKetRhoQuCalc.md`](BraKetRhoQuCalc.md) · [`Lagrangian_Formulation.md`](Lagrangian_Formulation.md) — the bra/ket process algebra and the `ℒ=0` continuum limit.
- [`VacuumEnergy.md`](VacuumEnergy.md) · [`YangMills_MassGap_QLF.md`](YangMills_MassGap_QLF.md) · [`lean/QLF_RunningCouplings.lean`](lean/QLF_RunningCouplings.lean) — vacuum, mass gap, RG.
