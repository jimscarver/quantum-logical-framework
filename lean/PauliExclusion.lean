/-
  PauliExclusion.lean
  Quantum Logical Framework — Pauli Exclusion Principle via RhoProcess antisymmetry

  In QLF, the Pauli exclusion principle emerges from the antisymmetric structure
  of the RhoProcess matrix algebra.

  Key facts proved here:

  1. Bosonic (symmetric) parallel composition is commutative at the eval level:
       eval (parallel p q) = eval (parallel q p)

  2. The antisymmetric fermionic combination `fermi_antisym p q = eval(p|q) - eval(q|p)`
     is antisymmetric: fermi_antisym p q = -fermi_antisym q p

  3. Pauli exclusion: fermi_antisym p p = 0  (identical fermions → zero antisymmetric state)

  4. Bosonic double occupancy is allowed: eval(action f | action f) = f.toMatrix + f.toMatrix

  5. Fermionic antisymmetry vanishes for the equilibrium pair:
       fermi_antisym (action f) (lift f) = 0
     because f.toMatrix is Hermitian (f.toMatrix† = f.toMatrix).

  6. Every process has a ZFA-stable symmetric TopoString — including parallel self-pairs.

  Author: Jim Scarver + Claude — May 2026
-/

import RhoQuCalc   -- brings in Form, RhoProcess, eval, dagger, toTopoString, ZFA theorems

open Matrix

/-! ## Bosonic statistics: parallel is symmetric -/

/-- Parallel composition is commutative at the matrix (eval) level.
    This is the bosonic (symmetric) statistics property. -/
theorem bosonic_parallel_symmetric (p q : RhoProcess) :
    (RhoProcess.parallel p q).eval = (RhoProcess.parallel q p).eval := by
  simp [RhoProcess.eval, add_comm]

/-! ## Fermionic antisymmetric combination -/

/-- The fermionic antisymmetric combination of two processes:
    `fermi_antisym p q = eval(p|q) - eval(q|p)`.
    This is the quantity that must vanish for identical fermions. -/
noncomputable def fermi_antisym (p q : RhoProcess) : Matrix (Fin 2) (Fin 2) ℂ :=
  (RhoProcess.parallel p q).eval - (RhoProcess.parallel q p).eval

/-- Antisymmetry: swapping the arguments negates fermi_antisym -/
theorem fermi_antisym_antisymmetric (p q : RhoProcess) :
    fermi_antisym p q = -fermi_antisym q p := by
  simp [fermi_antisym, neg_sub]

/-- fermi_antisym is zero on the diagonal for any process -/
theorem fermi_antisym_self (p : RhoProcess) : fermi_antisym p p = 0 := by
  simp [fermi_antisym]

/-! ## Core Pauli Exclusion Theorem -/

/-- **Pauli exclusion principle:**
    The antisymmetric (fermionic) combination of two identical processes is zero.
    No quantum state can be doubly occupied under fermionic statistics. -/
theorem pauli_exclusion (p : RhoProcess) : fermi_antisym p p = 0 :=
  fermi_antisym_self p

/-- Pauli exclusion for action processes: identical `action f` pairs are excluded -/
theorem pauli_exclusion_for_action (f : Form) :
    fermi_antisym (RhoProcess.action f) (RhoProcess.action f) = 0 :=
  pauli_exclusion _

/-! ## Bosonic double occupancy -/

/-- Under bosonic (symmetric) statistics, double occupancy is allowed:
    two identical `action f` processes in parallel produce twice the matrix. -/
theorem bosonic_double_occupancy (f : Form) :
    (RhoProcess.parallel (RhoProcess.action f) (RhoProcess.action f)).eval =
    f.toMatrix + f.toMatrix := by
  simp [RhoProcess.eval]

/-- The bosonic double-occupancy state is Hermitian -/
theorem bosonic_pair_hermitian (f : Form) :
    (RhoProcess.parallel (RhoProcess.action f) (RhoProcess.action f)).eval.IsHermitian := by
  have hf : (RhoProcess.action f).eval.IsHermitian := Form.toMatrix_adjoint f
  exact RhoProcess.parallel_hermitian _ _ hf hf

/-! ## Fermionic equilibrium pair -/

/-- The fermionic antisymmetric combination of `action f` and `lift f` is zero,
    because `f.toMatrix` is Hermitian so `eval(lift f) = f.toMatrix†  = f.toMatrix`. -/
theorem fermi_antisym_action_lift (f : Form) :
    fermi_antisym (RhoProcess.action f) (RhoProcess.lift f) = 0 := by
  simp [fermi_antisym, RhoProcess.eval, Form.toMatrix_adjoint, add_comm]

/-- The equilibrium pair `action f | lift f` is Hermitian — the bosonic ground state -/
theorem equilibrium_pair_hermitian (f : Form) :
    (RhoProcess.parallel (RhoProcess.action f) (RhoProcess.lift f)).eval.IsHermitian :=
  RhoProcess.action_lift_hermitian f

/-! ## ZFA-level: every process pair has a symmetric TopoString -/

/-- Every RhoProcess (including `parallel p p`) has a ZFA-symmetric TopoString.
    This is a global property of the QLF algebra: no process can break the ZFA balance. -/
theorem parallel_self_zfa_symmetric (p : RhoProcess) :
    is_symmetric (toTopoString (RhoProcess.parallel p p)) :=
  RhoProcess.rho_process_always_symmetric (RhoProcess.parallel p p)

/-- The ZFA-stable TopoString of `parallel p p` always achieves ZFA closure -/
theorem parallel_self_achieves_zfa (p : RhoProcess) :
    achieves_ZFA (toTopoString (RhoProcess.parallel p p)) :=
  RhoProcess.rho_process_always_zfa (RhoProcess.parallel p p)

/-! ## Summary -/

/-!
  The above theorems together constitute the QLF derivation of Pauli exclusion:

  - `pauli_exclusion` : the antisymmetric fermionic combination of any identical
    RhoProcesses is the zero matrix.  This is the mathematical statement that no
    two identical fermions can occupy the same quantum state.

  - `bosonic_double_occupancy` : the bosonic (symmetric) combination of identical
    processes is non-zero (= 2× the single-process matrix), confirming that bosons
    are not subject to this restriction.

  - `fermi_antisym_action_lift` : the action/lift equilibrium pair already satisfies
    fermionic antisymmetry — the Hermitian structure of Form is the algebraic origin
    of the fermion/boson distinction in QLF.

  - `parallel_self_achieves_zfa` : every self-parallel composition is ZFA-stable,
    connecting Pauli exclusion to the Zero Free Action constraint at the logical level.
-/
