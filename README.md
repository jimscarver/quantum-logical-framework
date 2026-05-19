# Quantum Logical Framework (QLF)

**The universe is logical.**  
**Spacetime is synthesized.**  
**Physical reality is the subset of possibility that achieves Zero Free Action.**

The **Quantum Logical Framework (QLF)** is a constructive research program that treats physics as a problem of **logical generation and closure** rather than one of brute-force formalism or fixed background geometry.

At its core is a simple claim:

> **Only histories that achieve Zero Free Action (ZFA) persist.**

From that starting point, QLF explores how spacetime, measurement, entanglement, symmetry, gravity, and computation can emerge from finite local logical distinction.

---

## What QLF Is

QLF is not just an interpretation of quantum mechanics. It is a broader attempt to build a unified framework in which:

- **logical distinction is fundamental**
- **spacetime is synthesized event by event**
- **symmetry is enforced by Zero Free Action**
- **measurement is closure, not mystery**
- **gravity is emergent, not primitive**
- **formal infinities are replaced by constructive finite generation**

The repository combines:

- **conceptual essays**
- **Python experiments and demonstrations**
- **Lean 4 formalization of key structural claims**
- **mathematical and physical speculation under active development**

---

## Why This Repo Exists

Standard physics is extraordinarily successful, but its foundations remain unsettled:

- the measurement problem
- the role of the observer
- the status of spacetime
- quantum gravity
- the relation between information and physics
- the limits of classical formalism

QLF approaches these problems from the bottom up. Instead of starting with continuum fields, collapse postulates, or open-ended formal infinities, it starts with **finite logical possibilities** and asks which histories can actually close.

That makes QLF both a physical proposal and a foundational proposal about mathematics, computation, and explanation.

---

## Start Here

### 1. Big-picture orientation
- [**Philosophy.md**](Philosophy.md) — the possibilist foundation of QLF, Zero Free Action, local time synthesis, active inference, holography, and the critique of ZFC-style infinity
- [**TheBigProblem.md**](TheBigProblem.md) — how QLF addresses the measurement problem, entanglement, spacetime, time, and consciousness
- [**GodCreatedTheIntegers.md**](GodCreatedTheIntegers.md) — a broad framing of QLF in relation to Kronecker, Einstein, Wheeler, Gödel, Bohm, Bell, Penrose, Mead, Cramer, Wolfram, ’t Hooft, Hawking, and Susskind

### 2. Core theoretical claims
- [**Universality.md**](Universality.md) — the claim that QLF generates finite local logical closures
- [**Riemann-Conjecture-Proof.md**](Riemann-Conjecture-Proof.md) — the current QLF program relating ZFA symmetry, universality, and the critical line
- [**Measurement_Problem.md**](Measurement_Problem.md) — QLF treatment of measurement and observer-dependent closure
- [**UniversalRelativity.md**](UniversalRelativity.md) — emergent relativity and spacetime interpretation inside QLF

### 3. Physics and experiments
- [**Experimental_Consistency.md**](Experimental_Consistency.md) — numerical and conceptual links between QLF and known physics
- [**SpaceTime.md**](SpaceTime.md) — event-synthesized space and time
- [**Gravity.md**](Gravity.md) — emergent gravity in the QLF picture
- [**ER_EPR_QLF.md**](ER_EPR_QLF.md) — entanglement, geometry, and logical structure
- [**VacuumEnergy.md**](VacuumEnergy.md), [**BLACK-HOLES.md**](BLACK-HOLES.md), [**Entropy.md**](Entropy.md) — topic-specific extensions

### 4. Formal and executable work
- [**lean/README.md**](lean/README.md) — Lean 4 formalization directory
- `lean/QLF_Axioms.lean` — core counting, pruning, and ZFA machinery
- `lean/QLF_QuCalc.lean` — phase-generation engine and stable-state filter
- `lean/QLF_Universality.lean` — current universality formalization
- `lean/QLF_Critical_Line.lean` — wrapper around the ZFA-to-symmetry bridge
- `lean/SpacetimeDynamics.lean` — spacetime/logical-form matrix layer
- `qucalc_engine.py`, `spacetime_dynamics.py`, `constants_mapper.py`, `path_integral.py` — executable experiments

---

## Newer Themes Now Central to the Repo

Several themes now deserve to be front-and-center in the README because they tie the repo together:

### Possibilism
Reality is not one pre-written story. QLF treats all admissible logical histories as possible, with physical reality emerging from those that close under ZFA.

### Universality
QLF is not framed merely as a simulator. It is framed as a generator of finite local logical closure structures.

### Gödel, Busy Beaver, and the limits of classical formalism
The newer philosophical documents argue that unconstrained self-reference and open-ended formal infinity create a kind of mathematical ultraviolet catastrophe. QLF answers this by restricting realized structure to finite local closure.

### Holography, information, and logical boundary conditions
The repo increasingly treats bulk structure as constrained by closure at the boundary, linking QLF to Shannon, Wheeler, holography, and error-correction style thinking.

---

## Current Status

This repository is a mix of:

- **core ideas that are stable**
- **formalization that is actively being repaired and strengthened**
- **executable demonstrations**
- **speculative extensions that are clearly broader than the currently proved core**

The Lean side has seen recent build and tooling updates. The repo should be read as an actively evolving formal-executable research program, not as a finished closed theory.

---

## How to Explore the Repo

### Read
Start with:

1. `Philosophy.md`
2. `TheBigProblem.md`
3. `Universality.md`
4. `Experimental_Consistency.md`

Then go deeper into the Lean files and topic documents.

### Run
Examples:

```bash
git clone https://github.com/jimscarver/quantum-logical-framework.git
cd quantum-logical-framework

python spacetime_dynamics.py
python constants_mapper.py
python path_integral.py
````

### Build Lean

```bash
lake update
lake exe cache get
lake build
```

---

## Recommended Reading Paths

### If you care most about foundations

`Philosophy.md` → `GodCreatedTheIntegers.md` → `Universality.md`

### If you care most about physics

`TheBigProblem.md` → `Measurement_Problem.md` → `SpaceTime.md` → `Gravity.md`

### If you care most about formal structure

`lean/README.md` → `lean/QLF_Axioms.lean` → `lean/QLF_QuCalc.lean` → `lean/QLF_Universality.lean`

### If you care most about the Riemann program

`Universality.md` → `Riemann-Conjecture-Proof.md` → `lean/QLF_Riemann.lean`

---

## What Makes QLF Different

QLF is unusual because it tries to hold all of these together at once:

* a constructive ontology
* a finite logical generator
* a physical interpretation of information and symmetry
* an executable engine
* a formal proof program
* a critique of classical foundational assumptions

Whether one ultimately accepts the framework or not, the repo is built around a single unifying question:

> **What if physics is the closure of logical possibility under Zero Free Action?**

---

## Contributing

The most useful contributions right now are:

* tightening README and document consistency
* aligning prose claims with current Lean status
* improving the Lean build and theorem structure
* adding small executable examples that clarify one claim at a time
* opening issues where a document overstates, understates, or mismatches the code

---

## Repository

**GitHub:** [jimscarver/quantum-logical-framework](https://github.com/jimscarver/quantum-logical-framework)

If the universe is ultimately logical, then physics is not just something to describe.

It is something to generate.

```

I can also compress this into a shorter, more declarative README if you want.
```
