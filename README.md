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
- Frequency doubling, conic-section polygons in Hilbert space, holographic line projections, and full path integrals emerge naturally from dimension tunneling.
- **Entropy**: logical information outside a local light-cone perspective (alternating values of variables in unsampled histories).

### Repository Files

| File                  | Description |
|-----------------------|-----------|
| `README.md`           | This file |
| `quantum_simulator.py`| Core Pauli folding, double cover, energy demo |
| `universal.py`        | Universal gate construction (H, T, CNOT from folds) |
| `doubler.py`          | Quantum-logical frequency doubler (f → 2f) |
| `holographic.py`      | 2D qubit transitions → conic-section polygon + holographic line |
| `path_integral.py`    | Full path-integral module: zero-action histories, emergent least-action, holographic projection, **and direct light-cone entropy calculation** |

### Installation & Quick Start
```bash
git clone https://github.com/jimscarver/quantum-logical-framework.git
cd quantum-logical-framework
pip install numpy matplotlib
python path_integral.py   # Capstone demo (includes entropy)
