# Quantum Logical Framework Simulator

A Python-based educational and exploratory simulator demonstrating a radical information-first view of quantum mechanics:

**All physics emerges from zero-free-action balanced distinctions (primordial qubits) in Hilbert space.**

### Core Ideas
- **Zero free action** as the foundational layer: every primitive event is a perfectly balanced distinction with net action = 0.
- **Non-commutative folding** via Pauli matrices (equivalent to unit-quaternion multiplication).
- **Double cover (SU(2) ≅ unit quaternions)**: logical closure requires 720° (half-integer spin as the minimal persistent structure).
- **Energy = Hilbert-space dimensionality**: \( E = d \times h \times f \), where \( d = 2^N \) for \( N \) qubits.
- **Holographic emergence**: spin-1 (gauge fields, classical waves) is composite, not fundamental → bulk physics is a holographic projection from a lower-dimensional boundary of spin-1/2 distinctions.
- **Universality**: primitive local and non-local folds construct **all possible quantum-logical systems**.
- Frequency doubling, conic-section polygons in Hilbert space, and holographic line projections emerge naturally from dimension tunneling.

### Repository Files

| File                        | Description |
|----------------------------|-----------|
| `README.md`                | This file – overview, theory, installation, and usage. |
| `quantum_simulator.py`     | Core simulator: Pauli folding, double cover (360° vs 720°), Bloch sphere, energy-dimensionality relation, and basic non-commutativity demonstrations. **Start here.** |
| `universal.py.`            | Demonstrates construction of universal quantum gate sets (H, T, CNOT-style) from primitive folds. Shows how **all possible logical systems** can be synthesized. |
| `doubler.py`               | Quantum-logical frequency doubler: builds a frequency-doubler gate via controlled dimension tunneling. Includes time-domain simulation and FFT confirmation of f → 2f. |
| `holographic.py`           | 2D qubit transition → discrete conic-section polygon in projected Hilbert space, with holographic 1D line projection on the boundary. Visualizes bulk-to-boundary mapping. |

*(Note: `universal.py.` has a trailing dot in the filename – you may want to rename it to `universal.py` for clarity.)*

All scripts require only **NumPy** (and Matplotlib for visualization in `doubler.py` and `holographic.py`).

### Installation

```bash
git clone https://github.com/jimscarver/quantum-logical-framework.git
cd quantum-logical-framework
pip install numpy matplotlib   # matplotlib optional for plots
```bash
git clone https://github.com/jimscarver/quantum-logical-framework.git
cd quantum-logical-framework
pip install numpy
```

## Quick Start

```bash
python quantum_simulator.py
```

## Key Concepts

### 1. Hilbert Space Foundation
All physics emerges in ℂ² (2D complex space). A single qubit encodes one independent yes/no distinction.

### 2. Pauli Matrices as Folding Operators
The Pauli matrices {σₓ, σᵧ, σᵤ} generate su(2) — the unique non-commutative algebra that closes under 3D rotations while preserving zero net action.

### 3. Double Cover & Half-Integer Spin
- **360° rotation**: U(360°) = -I (phase flip, no logical closure)
- **720° rotation**: U(720°) = +I (full closure, persistent structure)

### 4. Energy = Hilbert-Space Dimensionality
```
E = d × h × f
```

### 5. Holographic Emergence
Spin-1 is emergent (not fundamental) ⟹ true information lives on lower-dimensional boundary

## References

### Foundational Quantum Mechanics
- **Dirac, P. A. M.** (1958). *The Principles of Quantum Mechanics*. 4th ed., Oxford University Press.
- **Zeilinger, A.** (1999). *A Foundational Principle for Quantum Mechanics*. Foundations of Physics, 29(4), 631-643.

### Pauli Matrices & SU(2)
- **Pauli, W.** (1927). *Zur Quantenmechanik des magnetischen Elektrons*. Zeitschrift für Physik, 43, 601-623.
- **Sakurai, J. J.** (1994). *Modern Quantum Mechanics*. Revised ed., Addison-Wesley.

### Quaternions & Double Cover
- **Hamilton, W. R.** (1843). *Theory of Conjugate Functions*. Transactions of the Royal Irish Academy, 17, 293-422.
- **Kustaanheimo, P., & Stiefel, E.** (1965). *Perturbation Theory of Kepler Motion Based on Spinor Regularization*. Journal für die Reine und Angewandte Mathematik, 218, 204-219.

### Holographic Principle
- **'t Hooft, G.** (1993). *Dimensional Reduction in Quantum Gravity*. arXiv:gr-qc/9310026.
- **Maldacena, J.** (1997). *The Large N Limit of Superconformal Field Theories and Supergravity*. Advances in Theoretical and Mathematical Physics, 2, 231-252.
- **Susskind, L.** (1995). *The World as a Hologram*. Journal of Mathematical Physics, 36(11), 6377-6396.

### Spin & Angular Momentum
- **Messiah, A.** (1961). *Quantum Mechanics* (Vol. II). North-Holland Publishing.
- **Landau, L. D., & Lifshitz, E. M.** (1977). *Quantum Mechanics: Non-Relativistic Theory*. 3rd ed., Pergamon Press.

### Quantum Field Theory & Emergent Bosons
- **Weinberg, S.** (1995). *The Quantum Theory of Fields* (Vol. I). Cambridge University Press.
- **Peskin, M. E., & Schroeder, D. V.** (1995). *An Introduction to Quantum Field Theory*. Addison-Wesley.

## Citation

```bibtex
@software{scarver2026qlf,
  title={Quantum Logical Framework Simulator},
  author={Scarver, Jim},
  year={2026},
  url={https://github.com/jimscarver/quantum-logical-framework}
}
```

## Contributing

Contributions welcome!

## License

MIT License
