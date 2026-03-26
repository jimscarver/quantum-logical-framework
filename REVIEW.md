
#Review of the Quantum Logical Framework Simulator

**Author**: Jim Scarver  
**Date**: March 2026  
**Repository**: https://github.com/jimscarver/quantum-logical-framework

## Abstract
This framework treats the universe as a quantum logical system built from zero-free-action balanced distinctions (primordial qubits). All familiar physics — least action, spin, energy, entropy, holography, frequency doubling, and classical trajectories — emerges from non-commutative Pauli folding and dimension tunneling. The accompanying Python simulator (`path_integral.py` and supporting modules) makes these ideas runnable and visual. Entropy is explicitly the logical information outside any observer’s local light-cone perspective.

## Core Concepts Realized in Code
- **Zero free action**: Every primitive fold (Pauli rotation) has net action S = 0.
- **Non-commutative folding**: Pauli multiplication ≡ unit-quaternion algebra → double cover → 720° closure (half-integer spin).
- **Dimension tunneling**: Inconsistent fold directions add tensor factors → entanglement and higher-dimensional Hilbert space.
- **Energy**: E = d × h × f with d = 2^N.
- **Path integral**: Sum over all zero-action histories; least action emerges via coarse-graining missing distinctions.
- **Entropy**: Computed as von Neumann entropy S = –Tr(ρ ln ρ) of the mixed state formed by sampled paths — exactly the “alternating values of variables” outside the observer’s local light cone (see `compute_light_cone_entropy` in `path_integral.py`).
- **Holography**: Bulk path integral projects to a 1D boundary line (mirrors `holographic.py`).

## Comparison with Other Quantum Simulations (2026)
(See table in README.md for compact version.)

The simulator is **educational and foundational**, not production-scale. It uniquely starts from pure logic and derives the rest. Standard tools (Qiskit, ITensor, PIMC) assume a pre-existing Hilbert space and Hamiltonian; this framework *constructs* the Hilbert space itself.

## Scientific References
1. Wheeler, J. A. (1990). “Information, Physics, Quantum: The Search for Links.” In *Complexity, Entropy and the Physics of Information*.  
2. Zeilinger, A. (1999). “A Foundational Principle for Quantum Mechanics.” *Foundations of Physics*, 29(4), 631–643.  
3. Mead, C. A. (2000). *Collective Electrodynamics*. MIT Press.  
4. Cramer, J. G. (1986). “The Transactional Interpretation of Quantum Mechanics.” *Reviews of Modern Physics*, 58, 647–687.  
5. Feynman, R. P. (1948). “Space-Time Approach to Non-Relativistic Quantum Mechanics.” *Reviews of Modern Physics*, 20, 367–387. (path-integral formulation)  
6. ’t Hooft, G. (1993). “Dimensional Reduction in Quantum Gravity.” arXiv:gr-qc/9310026.  
7. Susskind, L. (1995). “The World as a Hologram.” *Journal of Mathematical Physics*, 36, 6377–6396.  
8. Maldacena, J. (1999). “The Large N Limit of Superconformal Field Theories and Supergravity.” *International Journal of Theoretical Physics*, 38, 1113–1133. (AdS/CFT holography)  
9. Rovelli, C. (1996). “Relational Quantum Mechanics.” *International Journal of Theoretical Physics*, 35, 1637–1678. (light-cone / observer-dependent information)  
10. Griffiths, R. B. (1984). “Consistent Histories and the Interpretation of Quantum Mechanics.” *Journal of Statistical Physics*, 36, 219–272. (alternating histories and entropy)

## How to Explore
Run `python path_integral.py` to see the light-cone entropy calculation live.  
Import anywhere with:  
```python
from path_integral import run_path_integral_simulation, compute_light_cone_entropy
