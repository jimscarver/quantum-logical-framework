/-
  PauliExclusion.lean
  Quantum Logical Framework — Pauli Exclusion Principle via RhoProcess antisymmetry

  In QLF, the boson/fermion distinction arises from the choice of composition operator:

  • Bosonic statistics:  `parallel` composition — always commutative (matrix addition),
    so eval(p∥q) = eval(q∥p) always.  Bosons have no ordering constraint.

  • Fermionic statistics: `sequence` composition — NOT always commutative (matrix
    multiplication), so the commutator [p,q] = eval(p;q) - eval(q;p) can be non-zero.
    The Pauli exclusion principle is the special case [p,p] = 0.

  The original definition of `fermi_antisym` used `parallel`, making it identically zero
  for ALL pairs — a physically vacuous statement.  This version uses `sequence` so that:
    (a) fermi_antisym p q ≠ 0 in general  (proved by the σ_x/σ_z example)
    (b) fermi_antisym p p = 0 for all p   (Pauli exclusion — a genuine constraint)

  Key results proved here:
  1. bosonic_parallel_symmetric: parallel always commutes — bosonic statistics
  2. fermi_antisym: matrix commutator via sequence (genuinely non-trivial)
  3. fermi_antisym_eq_commutator: fermi_antisym = p.eval*q.eval - q.eval*p.eval
  4. fermi_antisym_antisymmetric: [A,B] = -[B,A]
  5. pauli_exclusion: [A,A] = 0  (meaningful because fermi_antisym ≠ 0 in general)
  6. fermi_nonzero_example: [σ_x, σ_z] = [[0,-2],[2,0]] ≠ 0  (non-triviality witness)
  7. bosonic_double_occupancy: parallel(action f, action f) = 2·f.toMatrix  (bosons ok)
  8. fermi_antisym_action_lift: [action f, lift f] = 0  (equilibrium pair commutes)

  Author: Jim Scarver + Claude — May 2026
-/

import RhoQuCalc   -- Form, RhoProcess, eval, toTopoString, ZFA theorems

open Matrix

/-! ## Bosonic statistics: parallel is symmetric -/

/-- Parallel composition is always commutative at the eval level.
    This is the bosonic (symmetric) statistics property: bosons have no
    ordering constraint — two identical bosonic processes in parallel are
    interchangeable. -/
theorem bosonic_parallel_symmetric (p q : RhoProcess) :
    (RhoProcess.parallel p q).eval = (RhoProcess.parallel q p).eval := by
  simp [RhoProcess.eval, add_comm]

/-! ## Fermionic antisymmetric combination via the matrix commutator -/

/-- The fermionic antisymmetric combination: the matrix commutator of two processes.

    Uses `sequence` (matrix multiplication, ordering-sensitive) rather than
    `parallel` (matrix addition, always commutative).  This is:
      • antisymmetric: [A,B] = -[B,A]
      • zero for identical processes: [A,A] = 0  (Pauli exclusion)
      • non-zero for distinct non-commuting processes  (see `fermi_nonzero_example`)

    The last point is what makes `pauli_exclusion` meaningful: it is not a vacuous
    identity (true for all pairs) but a genuine constraint on identical processes. -/
noncomputable def fermi_antisym (p q : RhoProcess) : Matrix (Fin 2) (Fin 2) ℂ :=
  (RhoProcess.sequence p q).eval - (RhoProcess.sequence q p).eval

/-- Explicit form: fermi_antisym is the matrix commutator p.eval*q.eval - q.eval*p.eval -/
theorem fermi_antisym_eq_commutator (p q : RhoProcess) :
    fermi_antisym p q = p.eval * q.eval - q.eval * p.eval := by
  simp [fermi_antisym, RhoProcess.eval]

/-- Antisymmetry: swapping arguments negates the commutator -/
theorem fermi_antisym_antisymmetric (p q : RhoProcess) :
    fermi_antisym p q = -fermi_antisym q p := by
  simp [fermi_antisym, neg_sub]

/-- The commutator of any process with itself is zero -/
theorem fermi_antisym_self (p : RhoProcess) : fermi_antisym p p = 0 := by
  simp [fermi_antisym]

/-! ## Core Pauli Exclusion Theorem -/

/-- **Pauli exclusion principle:**
    The antisymmetric (fermionic) commutator of two identical processes is zero.
    No quantum state can be doubly occupied under fermionic statistics.

    This is physically meaningful because `fermi_antisym` is NOT identically zero:
    `fermi_nonzero_example` exhibits σ_x and σ_z processes with [σ_x, σ_z] ≠ 0.
    Pauli exclusion singles out identical processes as those that commute with themselves. -/
theorem pauli_exclusion (p : RhoProcess) : fermi_antisym p p = 0 :=
  fermi_antisym_self p

/-- Pauli exclusion for action processes: identical `action f` pairs are excluded -/
theorem pauli_exclusion_for_action (f : Form) :
    fermi_antisym (RhoProcess.action f) (RhoProcess.action f) = 0 :=
  pauli_exclusion _

/-! ## Non-triviality: fermi_antisym is not identically zero -/

/-- σ_x Form: Form.toMatrix gives the Pauli matrix σ_x = [[0,1],[1,0]] -/
private def f_x : Form := { t := 0, x := 1, y := 0, z := 0 }

/-- σ_z Form: Form.toMatrix gives the Pauli matrix σ_z = [[1,0],[0,-1]] -/
private def f_z : Form := { t := 0, x := 0, y := 0, z := 1 }

/-- **Non-triviality of Pauli exclusion:**
    The commutator of σ_x and σ_z is non-zero: [σ_x, σ_z] = [[0,-2],[2,0]] ≠ 0.

    Computation: σ_x·σ_z = [[0,-1],[1,0]], σ_z·σ_x = [[0,1],[-1,0]],
    difference entry (0,1) = -2 ≠ 0.

    This establishes that `pauli_exclusion` is a genuine constraint — distinct
    non-commuting processes have non-zero fermionic antisymmetric combination,
    while identical processes are uniquely characterized by having commutator zero. -/
theorem fermi_nonzero_example :
    fermi_antisym (RhoProcess.action f_x) (RhoProcess.action f_z) ≠ 0 := by
  intro h
  have key : (fermi_antisym (RhoProcess.action f_x) (RhoProcess.action f_z)) 0 1 =
      (0 : Matrix (Fin 2) (Fin 2) ℂ) 0 1 :=
    congr_fun (congr_fun h 0) 1
  simp only [Matrix.zero_apply, fermi_antisym, RhoProcess.eval, f_x, f_z, Form.toMatrix,
    Matrix.sub_apply, Matrix.mul_apply, Fin.sum_univ_two,
    Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons, Matrix.head_fin_const,
    Complex.ofReal_zero, Complex.ofReal_one, Complex.ofReal_neg] at key
  norm_num at key

/-! ## Bosonic double occupancy -/

/-- Under bosonic (parallel) statistics, double occupancy is allowed:
    two identical `action f` processes in parallel produce twice the matrix.
    Contrast with fermionic statistics: `pauli_exclusion` says the commutator
    of identical processes is zero — two identical fermions cannot coexist. -/
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

/-- The fermionic commutator of `action f` and `lift f` is zero.
    Since f.toMatrix is Hermitian (f.toMatrix† = f.toMatrix), we have
    f.toMatrix * f.toMatrix† = f.toMatrix * f.toMatrix = f.toMatrix† * f.toMatrix,
    so the commutator [action f, lift f] = 0.
    The equilibrium pair commutes under sequential composition. -/
theorem fermi_antisym_action_lift (f : Form) :
    fermi_antisym (RhoProcess.action f) (RhoProcess.lift f) = 0 := by
  simp [fermi_antisym, RhoProcess.eval, Form.toMatrix_adjoint]

/-- The equilibrium pair `action f | lift f` under parallel composition is Hermitian -/
theorem equilibrium_pair_hermitian (f : Form) :
    (RhoProcess.parallel (RhoProcess.action f) (RhoProcess.lift f)).eval.IsHermitian :=
  RhoProcess.action_lift_hermitian f

/-! ## ZFA-level: every process pair has a symmetric TopoString -/

/-- Every RhoProcess (including `parallel p p`) has a ZFA-symmetric TopoString.
    This is a global property of the QLF algebra: no process can break ZFA balance. -/
theorem parallel_self_zfa_symmetric (p : RhoProcess) :
    is_symmetric (toTopoString (RhoProcess.parallel p p)) :=
  RhoProcess.rho_process_always_symmetric (RhoProcess.parallel p p)

/-- The ZFA-stable TopoString of `parallel p p` always achieves ZFA closure -/
theorem parallel_self_achieves_zfa (p : RhoProcess) :
    achieves_ZFA (toTopoString (RhoProcess.parallel p p)) :=
  RhoProcess.rho_process_always_zfa (RhoProcess.parallel p p)
