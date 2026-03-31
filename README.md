# Quantum Logical Framework (QLF)

![Python Version](https://img.shields.io/badge/python-3.10%2B-blue)
![License](https://img.shields.io/badge/license-MIT-green)
![Status](https://img.shields.io/badge/status-Experimental-orange)
![Contributions](https://img.shields.io/badge/contributions-welcome-brightgreen)

The **Quantum Logical Framework** is a discrete, topological computational engine that models quantum mechanics without continuous continuous matrices or abstract Hilbert spaces. By executing **QuCalc** (an 8-axis directional logic based on the *Laws of Form*), the QLF simulates the **Possibilist Universe**—where quantum states are not probability distributions, but concurrent "History Strings" filtered by logical consistency.

In this framework, the fundamental conservation laws of physics (Unitarity) are not hard-coded; they emerge naturally through the geometric requirement of **Zero Free Action (ZFA)**.

## 🚀 Quick Start

Get the simulation engine running locally in seconds.

**1. Clone the repository**
```bash
git clone [https://github.com/jimscarver/quantum-logical-framework.git](https://github.com/jimscarver/quantum-logical-framework.git)
cd quantum-logical-framework
````

**2. Run the QuCalc Engine**
Generate Pauli-constrained topological possibilities from a seed twist.

```bash
python qucalc_engine.py
```

**3. Run the Topology Resolver**
Filter raw generated paths against the causal light cone and verify Hermitian closure.

```bash
python topology_resolver.py
```

## 🧠 Core Concepts

  * **QuCalc:** An 8-axis directional logic alphabet (`^v` vertical, `<>` horizontal, `/\` depth, `+-` local/temporal).
  * **Zero Free Action (ZFA):** The strict rule that a topological history string must balance to zero across all dimensions to exist as an observable, stable event.
  * **Hermitian Closure:** The computable proof that an event followed by its exact reversed, inverted sequence ($E + E^\dagger$) annihilates perfectly, guaranteeing unitary conservation.
  * **Structural Holography:** The principle that 3D "bulk" physics is constrained entirely by the requirement that 2D logical boundaries avoid topological contradictions.

## 💻 Examples

**Simulating a Sum Over Histories (`path_integral.py`)**
Instead of continuous Lagrangians, the QLF calculates the discrete phase shift of topological twists. The classical path is the stationary phase where $\delta S = 0$.

```python
from qucalc_engine import QuCalcEngine

engine = QuCalcEngine(causal_horizon=6)
# Seed the universe with an initial 'Up' fold
stable_events = engine.generate_possibilities("^")

print(f"Discovered {len(stable_events)} stable events.")
# Output: Discovered [...] stable events.
# -> ^<v> | Action Balance: (0, 0, 0, 0) (ZFA)
```

**Resolving Topological Contradictions (`topology_resolver.py`)**

```python
from topology_resolver import TopologyResolver

resolver = TopologyResolver(light_cone_limit=10)
candidate_paths = ["^<v>", "^</+-"]

results = resolver.resolve_bulk(candidate_paths)
# Output:
# [+] ^<v> (Verified Unitary)
# Filtered out 1 topological contradictions.
```

## 🗂️ Repository Structure

| File / Module | Description |
| :--- | :--- |
| **`qucalc_engine.py`** | The generative core. Concurrently traces multi-dimensional paths using Pauli exclusion logic. |
| **`topology_resolver.py`** | The holographic boundary filter. Prunes paths that violate ZFA or exceed the causal horizon. |
| **`quantum_simulator.py`** | Simulator rewriting standard quantum mechanics as QuCalc discrete possibility branching. |
| **`path_integral.py`** | Implements the sum-over-histories using discrete topological action (twist counts). |
| **`gravitational_tensor.py`** | Explores how network density relates to emergent spacetime curvature. |
| **`REVIEW.md`** | Scientific context, translating QLF terminology and mapping conceptual ancestors (Feynman, Wheeler). |
| **`Entropy.md`** | Derivation of the Bekenstein-Hawking $1/4$ bound strictly from QuCalc 4-fold topological loops. |
| **`Hermitian_Conjugacy_Proof.md`** | Computable algebraic proof that adjoint evolution is isomorphic to ZFA. |
| **`YIN_YANG_LOGIC.md`** | Theoretical mapping of recursive, base-8 logic to traditional Yin-Yang duality. |
| **`YinYangYin.png`** | Visual representation of the recursive Yin-Yang logical model. |

## 🗺️ Roadmap

The Possibilist Universe is actively expanding. We are currently looking for contributors to help build out the following frontiers:

  - [ ] **3D Network Visualization:** Map the 8-axis history strings into navigable geometric manifolds.
  - [ ] **Multi-Particle Entanglement:** Develop the logical collision and entanglement rules for independent ZFA strings.
  - [ ] **Emergent Gravity:** Complete `gravitational_tensor.py` to map twist density to spacetime curvature.
  - [ ] **Hardware Optimization:** Port the concurrent BFS path-tracing engine to GPU/TPU to support much deeper causal horizons.

## 🤝 Contributing

Contributions, issues, and feature requests are welcome\! If you are interested in discrete topology, information physics, or non-standard quantum models, check the [issues page](https://www.google.com/search?q=https://github.com/jimscarver/quantum-logical-framework/issues).

## 📜 License

Distributed under the MIT License.

```
```
