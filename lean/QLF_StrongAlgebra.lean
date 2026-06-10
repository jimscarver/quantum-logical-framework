/-
QLF_StrongAlgebra.lean — su(3) as the traceless 3-axis directional tensor.

In the Forces_From_Three_Axes synthesis, the strong force is the TRACELESS part
of the 3×3 directional-coupling tensor of the three spatial axes:

    u(3)  =  u(1)        ⊕   su(3)
    9     =  1 (trace)   +   8 (traceless = 3² − 1, the eight gluons).

This module machine-verifies the two defining properties of that traceless part
as a Lie algebra (the same rigor level as the weak `weak_isospin_su2`):

  • CLOSURE: the commutator of any two 3×3 matrices is traceless, so the
    traceless matrices are closed under the Lie bracket — they are a Lie
    subalgebra (the strong gauge algebra su(3), ≅ the traceless sl(3)).
  • NON-ABELIAN: there are traceless 3×3 matrices that do not commute, so this
    is a genuine non-abelian gauge algebra, not a stack of commuting U(1)s.

DIMENSION: `8 = 3² − 1` is the codimension-1 trace constraint on the
9-dimensional space of 3×3 matrices (one linear equation `trace = 0`). The
explicit `g1, g3` below are two of those 8 traceless generators.

SCOPE: this is the Lie-algebra identification only — it does NOT derive the
strong coupling, the confinement scale, or asymptotic freedom (those stay open;
see Standard_Model.md §3.4 and Forces_From_Three_Axes.md §6).
-/

import Mathlib.LinearAlgebra.Matrix.Trace
import Mathlib.LinearAlgebra.Matrix.Hermitian
import Mathlib.Data.Complex.Basic

namespace QLF

/-- 3×3 complex matrices — the directional-coupling tensor of the three axes. -/
abbrev M3 := Matrix (Fin 3) (Fin 3) ℂ

/-- **Closure: the Lie bracket of any two 3×3 matrices is traceless.**
    Hence the traceless 3×3 matrices are closed under the commutator and form a
    Lie subalgebra — the strong gauge algebra su(3) (≅ the traceless sl(3) part
    of the 3×3 directional tensor). -/
theorem trace_commutator_zero (A B : M3) : (A * B - B * A).trace = 0 := by
  rw [Matrix.trace_sub, Matrix.trace_mul_comm, sub_self]

/-- A traceless generator (`λ₁`-style). -/
def g1 : M3 := !![0, 1, 0; 1, 0, 0; 0, 0, 0]

/-- A traceless generator (`λ₃`-style). -/
def g3 : M3 := !![1, 0, 0; 0, -1, 0; 0, 0, 0]

theorem g1_traceless : g1.trace = 0 := by
  simp [g1, Matrix.trace_fin_three]

theorem g3_traceless : g3.trace = 0 := by
  simp [g3, Matrix.trace_fin_three]

/-- **Non-abelian: `[g₁, g₃] ≠ 0`.** Two traceless generators that do not
    commute — so the traceless 3×3 algebra is a genuine non-abelian gauge
    algebra. (The bracket is itself traceless by `trace_commutator_zero`.) -/
theorem gluon_commutator_nonzero : g1 * g3 - g3 * g1 ≠ 0 := by
  intro h
  have h01 : (g1 * g3 - g3 * g1) 0 1 = (0 : M3) 0 1 := by rw [h]
  simp [g1, g3, Matrix.mul_apply, Fin.sum_univ_three, Matrix.sub_apply,
        Matrix.zero_apply] at h01

/-- **su(3) as the traceless 3-axis tensor**: the traceless 3×3 matrices are
    closed under the Lie bracket (`trace_commutator_zero`) and non-abelian
    (`gluon_commutator_nonzero`) — the eight-dimensional (`3² − 1`) gauge
    algebra of the strong force, sitting in the `u(3) = u(1) ⊕ su(3)` split of
    the directional-coupling tensor. -/
theorem strong_su3_summary :
    (∀ A B : M3, (A * B - B * A).trace = 0) ∧ (g1 * g3 - g3 * g1 ≠ 0) :=
  ⟨trace_commutator_zero, gluon_commutator_nonzero⟩

end QLF
