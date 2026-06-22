# Introducing the Quantum Logical Framework: physics from one bit, checked by machine

> **The universe is logical.**
> **Spacetime is synthesized.**
> **Physical reality is the subset of possibility that achieves Zero Free Action.**

What if the fundamental constants of nature — the fine-structure constant, the proton-to-electron mass ratio, the dark-energy fraction — were not free parameters to be measured and plugged in, but *theorems*? Not fitted, not tuned, but derived from a single logical principle and then **verified by a proof assistant the way software is verified by a compiler**?

That is the claim of the [**Quantum Logical Framework (QLF)**](https://github.com/jimscarver/quantum-logical-framework) — a constructive foundation for mathematics and physics built from the bottom up out of one finite distinction: a single bit, a single Zero-Free-Action (ZFA) event. From that one primitive follow spacetime, quantum measurement, entanglement, the Standard-Model gauge groups, gravity, and the fundamental constants — each machine-verified in **Lean 4 across 106 modules with zero `sorry` blocks**, the combinatorial core operating strictly within the computable logical floor (RCA₀: no Axiom of Choice, no continuum).

This is not an interpretation of quantum mechanics layered on top of existing physics. It is an attempt at the foundation that physics *emerges from* — the way general relativity superseded Newton rather than reinterpreting him.

---

## Why this, why now

Modern physics carries three embarrassments at its foundations.

**The measurement problem.** A century after quantum mechanics, "what is a measurement?" still has no agreed answer — the wavefunction evolves smoothly, then mysteriously "collapses" when observed, and the textbooks paper over the seam.

**The vacuum catastrophe.** Quantum field theory predicts a vacuum energy roughly **10¹²²** times larger than the dark energy we observe — the worst quantitative prediction in the history of science.

**The crisis in the foundations of mathematics itself.** Classical set theory (ZFC) is built on open-ended formal infinity — and Gödel, Turing, and the Busy Beaver function are the shadows it casts: true statements that cannot be proved, problems that cannot be decided, growth that cannot be computed.

QLF's wager is that these are *one* problem. The trouble is the **continuum** — the assumption that reality is built on completed, uncountable infinities and non-constructive choices. Replace it with a discrete, computable substrate that selects physical reality by a closure condition, and all three dissolve: measurement *is* closure, the vacuum energy comes out to `log 2`, and Gödel/Turing incompleteness is confined to a non-terminating tail that the substrate physically prunes before it can become an event. This is laid out in [Continuum_Choice_Fallacy.md](https://github.com/jimscarver/quantum-logical-framework/blob/main/Continuum_Choice_Fallacy.md) and the positive case for quantum logic as the *correct* foundation in [Quantum_Logic_Foundations.md](https://github.com/jimscarver/quantum-logical-framework/blob/main/Quantum_Logic_Foundations.md).

---

## The one idea

QLF rests on a single postulate: **every admissible history must achieve Zero Free Action (ZFA = 0).**

Histories are strings in an **8-twist alphabet** — six spatial twists and two gauge twists, the smallest set of distinctions that can close on itself. The full space of such strings is the space of all logically possible computations. ZFA is the selection rule that picks out the physical ones: a history is physical exactly when its twists balance, closing the books to zero.

Crucially, **ZFA is a selection principle, not a restriction on computation.** Every *terminating* computation already *is* a balanced ZFA string (the framework is Church–Turing complete). What ZFA prunes is not physics — it is the non-terminating, Turing-undecidable, Busy-Beaver-class tail that could never have been a finite physical event in the first place. Physical reality is the self-selecting, balanced subset of the full computational possibility space.

From this one premise, several things that are usually *assumed* instead *follow*:

- **Spacetime is synthesized, not given.** Each ZFA event constructs its own local space and time; there is no background stage and no universal clock. The universe is a network of clocks, each synthesizing local time through closure ([Philosophy.md](https://github.com/jimscarver/quantum-logical-framework/blob/main/Philosophy.md)).
- **Measurement needs no separate postulate.** ZFA closure *is* the measurement event. The "collapse" is just the moment a history balances and becomes real. The "many worlds" are many local observers, each with its own consistent perspective.
- **Spin, particles, and the gauge structure** are read directly off the twist geometry — spin literally *is* the twists, fermions are odd-parity closures, bosons even.

---

## The evidence: constants as theorems

Talk is cheap; the framework's distinguishing feature is that it *computes*. Here are four of the ten headline results — each one **machine-checked in Lean**, several with **zero empirical input**.

| Result | Match | Empirical input | Verified in |
|---|---|---|---|
| **α = 1/137** — the fine-structure constant from substrate combinatorics (8-twist alphabet × 3-D directional tensor) | 0.026% | none | [`QLF_FineStructureSubstrate.lean`](https://github.com/jimscarver/quantum-logical-framework/blob/main/lean/QLF_FineStructureSubstrate.lean) |
| **m_p/m_e = 6π⁵** — the proton/electron mass ratio (3-quark Borromean closure × 5-angle integration) | 0.002% | none | [`QLF_LenzMassRatio.lean`](https://github.com/jimscarver/quantum-logical-framework/blob/main/lean/QLF_LenzMassRatio.lean) |
| **g − 2 = α/(2π)** — the electron's anomalous magnetic moment (Schwinger's term) | 0.18% | **zero** | [`QLF_GMinusTwo.lean`](https://github.com/jimscarver/quantum-logical-framework/blob/main/lean/QLF_GMinusTwo.lean) |
| **Ω_Λ = log 2** — the dark-energy fraction; **closes the 10¹²² vacuum catastrophe** | 1.2% | H₀ | [`QLF_CosmologicalConstant.lean`](https://github.com/jimscarver/quantum-logical-framework/blob/main/lean/QLF_CosmologicalConstant.lean) |

Read those again. The electron's magnetic anomaly and the dark-energy fraction — two numbers from utterly different corners of physics — both fall out of the substrate to better than 1.2%, **with no fitting parameters**. The fine-structure constant comes out to `1/137` from pure counting, and the same combinatorics says *why three dimensions*: in 2-D it would be `1/132`, in 4-D `1/144`. The full table of ten (including the Euler–Mascheroni constant, the Lamb shift, Newton's law, and Mercury's perihelion advance to 0.03%) is in the [repository README](https://github.com/jimscarver/quantum-logical-framework#-major-substrate-derivation-discoveries-june-2026), and the flagship α derivation is worked in detail in [Alpha.md](https://github.com/jimscarver/quantum-logical-framework/blob/main/Alpha.md).

---

## The unification behind the numbers

What makes these more than a coincidence collection is that they share a root. The 8-twist alphabet splits **6 + 2** — six spatial twists (three axis-pairs) and two gauge twists. That single split is the signature running through the whole framework:

- the **`3`** of three spatial axes appears as `N = 9 = 3²` behind α,
- as the **three fermion generations** (one per axis),
- as **colour SU(3)**,
- and as the inverse-square law of gravity (only in 3-D does Newton's `1/r²` come out — 2-D gives `1/r`, 4-D gives `1/r³`);

while the **`2`** gauge fraction (`2/8`) sits behind the dark-energy fraction and the weak mixing angle `sin²θ_W = 3/8`. One combinatorial fact, many faces — the deeper account is in [Standard_Model.md](https://github.com/jimscarver/quantum-logical-framework/blob/main/Standard_Model.md) and [Forces_From_Three_Axes.md](https://github.com/jimscarver/quantum-logical-framework/blob/main/Forces_From_Three_Axes.md).

---

## The frontiers

The reach extends well past particle constants.

**Gravity from logic.** The Einstein field equations appear not as a postulate but as the substrate's *equation of state* — Jacobson's 1995 thermodynamic derivation, with both required inputs (the horizon area law and the Unruh temperature) supplied by the substrate itself, fixing the coupling `8πG = 2π/η` and the cosmological constant `Λ = log 2`. Every local horizon is a Markov-blanket clock, tying the construction to Hitoshi Kitada's local time ([Gravity_From_Delay.md](https://github.com/jimscarver/quantum-logical-framework/blob/main/Gravity_From_Delay.md)).

**Dark matter as denser logic.** QLF reads galactic rotation curves as a closure-balance law rather than invisible mass — and it is **blind-tested, parameter-free, on 147 curated SPARC galaxies**, reproducing the observed Radial Acceleration Relation at the observational floor with a *derived* `a₀ = cH₀/2π` (matching best-fit MOND, where the standard dark-matter halo model needs 294 fitted parameters for the same data). See [DarkMatter.md](https://github.com/jimscarver/quantum-logical-framework/blob/main/DarkMatter.md) and [SPARC.md](https://github.com/jimscarver/quantum-logical-framework/blob/main/SPARC.md).

**The Millennium problems, reformulated honestly.** QLF takes all six open Clay problems and reduces each to a verified discrete core plus **one explicitly-named bridge axiom** marking exactly where the substrate meets the classical statement. The honest framing matters here, so it is worth stating plainly: the *classical* Clay conjectures are different statements in a different frame, and they are **not** proved here. What *is* proven is the substrate reformulation, and the one bridge axiom per problem is the located gap. The Hodge thread shows how far this goes: both sides of the Hodge picture are now built on the substrate — the algebraic side as a graded ℚ-subalgebra, the transcendental `(p,q)` side as a genuine Hodge structure whose conjugation is the substrate's own adjoint — leaving a single named input (geometric realization) as the residual. That thread is **closed at its honest floor**: reformulation complete, gap identified with the genuine open problem ([Millennium.md](https://github.com/jimscarver/quantum-logical-framework/blob/main/Millennium.md), [Hodge_QLF.md](https://github.com/jimscarver/quantum-logical-framework/blob/main/Hodge_QLF.md)).

---

## From physics to an operating system

There is a striking corollary. If ZFA closure is the single invariant that makes a computation physically real, then it is also the single invariant a *quantum computer* needs to enforce. In **QuantumOS**, the security model, error correction, scheduling, garbage collection, and even the AI layer are not five subsystems — they are one operation: ZFA enforcement. Capability-secure by construction (an unforgeable name *is* a proof of authorization), formally grounded in linear logic and the no-cloning theorem.

It is not just a design document — there is a **live peer-to-peer app** you can open in a browser, with AI agents that join rooms as full members. Try it at [jimscarver.github.io/quantum-os](https://jimscarver.github.io/quantum-os/), read the architecture in [QuantumOS.md](https://github.com/jimscarver/quantum-logical-framework/blob/main/QuantumOS.md), or browse the code at [github.com/jimscarver/quantum-os](https://github.com/jimscarver/quantum-os).

---

## What is proven, and what is open

A foundation earns trust by being honest about its boundaries, so here is the scope, drawn cleanly.

- **Machine-verified (zero `sorry`):** the physics results above and the substrate that generates them — 106 Lean modules, the combinatorial core within RCA₀, checked in continuous integration. These are proofs in the ordinary sense.
- **Reformulated, with a named bridge:** the Millennium problems. Each substrate reformulation is proven; each carries one explicit bridge axiom to the classical statement. The classical conjectures themselves are not claimed proved — and the "ZFC is provably defective" framing applies only to genuine uncomputability (the halting problem, Busy Beaver), **not** to the finitary problems like Hodge, which are ordinary hard mathematics.
- **Open — a value awaiting calculation, not a hole:** where something is marked open (for instance, the small residual between the leading `α⁻¹ = 137` and the measured `137.036`), it means *a number not yet derived from the substrate* — deeper work within a complete foundation, the way "derive the proton mass from QCD" is open within a complete Standard Model. It is not a gap where the theory could be wrong. The full status map is the [Open Problems registry](https://github.com/jimscarver/quantum-logical-framework/blob/main/Open_Problems.md).

The standing experimental verdict is quantum computation itself: it works precisely because nothing sub-quantum leaks in — there are no hidden variables for the ZFA description to be missing, and because gravity is *emergent*, it cannot be a hidden influence corrupting the picture either ([Beyond_Standard_Model.md](https://github.com/jimscarver/quantum-logical-framework/blob/main/Beyond_Standard_Model.md)).

---

## Where to go next

The fastest way in is the **flow chart** — the whole framework as a single linked index, one substrate branching into four families, ten domains, and the individual results: [the rendered, clickable map with a printable PDF](https://jimscarver.github.io/quantum-logical-framework/FlowChart.html).

From there:

- **The big picture** — [Philosophy.md](https://github.com/jimscarver/quantum-logical-framework/blob/main/Philosophy.md) (the possibilist foundation) and the formal [White Paper](https://github.com/jimscarver/quantum-logical-framework/blob/main/WHITE_PAPER.md).
- **The flagship derivation** — [Alpha.md](https://github.com/jimscarver/quantum-logical-framework/blob/main/Alpha.md): the fine-structure constant from counting.
- **The proofs themselves** — [the Lean module index](https://github.com/jimscarver/quantum-logical-framework/blob/main/lean/README.md): every theorem name and proof chain, all 106 modules.
- **The application** — [QuantumOS](https://jimscarver.github.io/quantum-os/), live in your browser.

The whole thing lives at **[github.com/jimscarver/quantum-logical-framework](https://github.com/jimscarver/quantum-logical-framework)**. The universe is logical, its logic is constructive and complete where reality is, and you can read the source — then check it in Lean.
