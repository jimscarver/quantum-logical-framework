# Quantum Logical Framework Python Refactor

This refactor applies the core cleanup discussed in chat:

## What changed

1. **One canonical core**
   - `twist_core.py` is now the single source of truth for:
     - the 8-twist alphabet
     - conjugation
     - admissible successor generation
     - action measurement
     - zero-free-action checks

2. **Duplicate engines removed logically**
   - `qucalc_engine.py`
   - `quantum_simulator.py`
   - `QuCalc.py`
   - `doubler.py`

   They now delegate to the same primitives instead of redefining slightly different rules.

3. **Hermitian closure strengthened**
   - `hermitian.py` now checks:
     - canonical syntax
     - admissible step sequence
     - adjoint closure
     - cycle ZFA

4. **Particle generator upgraded to full 8-twist space**
   - `particles.py` now includes the depth axis `/ \`.

5. **Spacetime bookkeeping now uses the same action vector as the core**
   - `SpaceTime.py` no longer redefines action independently.

6. **Path integral connected to the actual generator**
   - `path_integral.py` now gets histories from the canonical branching law.

## Recommended repo-side follow-up

- Keep `holographic.py` and similar Hilbert/Pauli demos, but place them under a `bridges/` folder or relabel them as bridge modules rather than primitive engine files.
- Update imports elsewhere to use `twist_core.py`.
- Add tests for:
  - known admissible histories
  - conjugation
  - ZFA closure
  - generator determinism
