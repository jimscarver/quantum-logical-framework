# Quantum Logical Framework (QLF)

![Python Version](https://img.shields.io/badge/python-3.10%2B-blue)
![License](https://img.shields.io/badge/license-MIT-green)
![Status](https://img.shields.io/badge/status-Experimental-orange)

This project begins from a simple claim: physical reality is fundamentally quantum-logical.

Nothing is created in isolation. The minimal creation event is a complementary entangled pair. Nothing happens except through local distinctions expressible by Pauli operations. Only zero-free-action events persist physically. Everything else is excluded by contradiction.

From these assumptions, the framework treats physical events not as particles moving through a preexisting spacetime, but as stable closures of complementary quantum logic. Spacetime, persistence, and measurable structure are emergent consequences of recursively stable zero-free-action relations.

The Pauli algebra is fundamental here because it expresses the minimal grammar of binary quantum distinction: orthogonality, inversion, noncommutation, and half-spin closure. In this view, Pauli-structured transformation is not merely a representation of physics. It is the primitive form of physical process.

The purpose of this repository is to formalize, justify, and simulate that claim: that a universe built only from entangled qubit pairs, Pauli-structured distinctions, and zero-free-action closure is sufficient to generate stable quantum structure and the emergent order we call physical reality.

The **Quantum Logical Framewormk** is a discrete, topological computational engine that models quantum mechanics without continuous matrices or abstract Hilbert spaces. **QuCalc is a quantum rho-calculus built from an 8-twist relational alphabet whose symbols encode local directions relative to context rather than absolute directions in a predefined space.**

In this framework, the fundamental conservation laws of physics (Unitarity) are not hard-coded; they emerge naturally through the geometric requirement of **Zero Free Action (ZFA)**.

## 🧠 Core Concepts

* **QuCalc:** An 8-twist relational alphabet of local directional distinctions (`^v`, `<>`, `/\`, `+-`). These symbols do not refer to absolute directions in a background space. They represent local orientations relative to the current context of folds in a history string.
* **The Generative History String:** A history string is not a path through a preexisting space, but a sequence of context-relative fold operations whose net closure may synthesize an event. 
* **Zero Free Action (ZFA):** Observable structure arises only when such context-relative twists close to zero free action—the strict requirement that a topological history string must balance to zero across all relational distinctions to exist as a stable event.
* **Hermitian Closure:** The computable proof that an event followed by its exact reversed, inverted sequence ($E + E^\dagger$) annihilates perfectly, guaranteeing unitary conservation.


## 🚀 Quick Start
The Quantum Logical Framework (QLF) is built purely on Python's standard libraries, ensuring the discrete logic engine runs without heavy external dependencies.
**1. Clone the repository:**
```bash
git clone https://github.com/jimscarver/quantum-logical-framework.git
cd quantum-logical-framework

```
**2. Requirements:**
 * Python 3.10 or higher.
 * No external packages (like numpy or scipy) are required; QLF relies entirely on discrete combinatorial logic (math, cmath, hashlib, collections).
**3. Run a simulation:**
You can execute any of the core physical modules directly from the command line to see the Possibilist Universe in action.
```bash
python SpaceTime.py

```
## 💻 Key Examples of Invocations & Output
The following examples demonstrate how the discrete relational alphabet of QuCalc generates macroscopic physical properties.
### 1. Generating Emergent Spacetime (SpaceTime.py)
This module proves that spacetime is not a background grid, but an emergent property of un-canceled logical action (x = E_{free}/h) and oscillating closed loops (t = h/E_{bound}).
**Command:**
```bash
python SpaceTime.py

```
**Output:**
```text
--- Simulating Free Spatial Propagation (Photon) ---
History String: ^^^^<<<<////
Total Logical Action: 12
Free Action (E_free): 12.0
Bound Action (E_bound): 0.0
Generated Space (x = E_free / h): 3.000
Local Time Interval (t = h / E_bound): inf
Oscillation Frequency (Clock Speed): 0.000

--- Simulating Oscillating ZFA Clock (Fermion) ---
History String: ^>v<^>v<^^>><<vv
Total Logical Action: 16
Free Action (E_free): 0.0
Bound Action (E_bound): 16.0
Generated Space (x = E_free / h): 0.000
Local Time Interval (t = h / E_bound): 0.250
Oscillation Frequency (Clock Speed): 4.000

```
*Observation: The framework mechanically proves that a photon experiences no internal time, while localized mass acts as a high-frequency clock.*
### 2. Bridging to Standard Physics (constants_mapper.py)
This module acts as the laboratory translation layer, mapping the dimensionless topological twists of QuCalc into standard SI units (Kilograms, Meters, Seconds) using the Planck scale as the fundamental boundary.
**Command:**
```bash
python constants_mapper.py

```
**Output:**
```text
--- QLF Laboratory Translation Report ---
History String : ^>v<^>v<^^>><<vv
Logical Steps  : 16

[Spatial Dimensions]
  Free Action  : 0.0 twists
  Length (SI)  : 0.000000e+00 meters

[Temporal Dimensions]
  Execution    : 8.625600e-44 seconds

[Mass & Energy (E=mc^2)]
  Bound Action : 16.0 twists
  Mass (SI)    : 3.407722e-08 kg
  Mass (eV)    : 1.911666e+28 eV/c^2

[Thermodynamics]
  Information  : 4.0 bits
  Entropy (SI) : 3.827768e-23 J/K
-----------------------------------------

```
### 3. Simulating Entanglement (MultiParticle.py)
QLF models multi-particle entanglement geometrically. Instead of calculating complex tensor products, it searches for overlapping causal light cones and attempts to resolve a **Joint Zero Free Action** between two independent history strings.
**Command:**
```bash
python MultiParticle.py

```
**Output:**
```text
--- Initiating Entanglement Search ---
Particle A: Origin (-2, 0), Seed: '^'
Particle B: Origin (2, 0), Seed: 'v'

[t=1] Horizons expanding. No intersection yet. (Distance > 2ct)
[t=2] ⚠️ CAUSAL INTERSECTION DETECTED ⚠️
        Interaction Manifold encompasses 1 logical units.
        Initiating Joint Resolution Search...

SUCCESS: System stabilized into an Entangled State!
Discovered 4 valid Joint ZFA combinations.
Sample Entangled State:
  |Psi>_A : ^<
  |Psi>_B : v>

```
### 4. Hierarchical Component Assembly (environmental_context.py)
Demonstrates how QuCalc handles macroscopic scaling. Stable Zero Free Action loops are "quoted" into **Unforgeable Names** and bound into macroscopic Contexts (like a Proton) using discrete Gauge Transformations (Environments).
**Command:**
```bash
python environmental_context.py

```
**Output:**
```text
Generated Unforgeable Names:
 Q1: @a7f8b9c2
 Q2: @d3e4f5a1
 Q3: @b2c3d4e5

Bound component @a7f8b9c2 to Context 'Proton_Nucleon'.
Bound component @d3e4f5a1 to Context 'Proton_Nucleon'.
Bound component @b2c3d4e5 to Context 'Proton_Nucleon'.

--- Evaluating Assembly: Proton_Nucleon ---
 Component @a7f8b9c2 evaluated as: ^<v>
 Component @d3e4f5a1 evaluated as: <v>^
 Component @b2c3d4e5 evaluated as: v>^<

Macroscopic Topological State: ^<v><v>^v>^<

```
