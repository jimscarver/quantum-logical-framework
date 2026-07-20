import SpacetimeDynamics
import Mathlib

/-!
# QLF_ProperInvolution — the substrate dagger is a proper involution

The **(a1) rung** of the orthomodular reduction (`Completeness_Evidence.md` §6c). The reconstruction
target's residue narrows to *"the dagger is a proper involution + the projection-lattice bridge"*; this
module lands the proven half.

The substrate dagger is the conjugate-transpose (`SpacetimeDynamics`'s `Form.toMatrix_adjoint`,
`QLF_Minkowski`, `QLF_StateSpace`). It is a **proper** involution: `Mᴴ * M = 0 ⟹ M = 0` — the
positive-definiteness of the complex / Gaussian-integer inner product. This is exactly the property
from which the **projection lattice of the substrate `*`-structure is orthomodular** (Kaplansky /
Berberian, the Baer-`*`-ring theorem — the settled-math bridge Mathlib lacks assembled): on the
non-distributive (rendered) layer, the orthomodular law follows from a proper involution. Reuse-only;
no new axioms.
-/

namespace QLF.ProperInvolution

-- ℂ has no *global* order; the `StarOrderedRing ℂ` / `PartialOrder ℂ` instances the
-- positive-definiteness lemma needs live behind the `ComplexOrder` scope.
open scoped ComplexOrder

/-- **The substrate dagger is a proper involution.** On the complex matrices carrying the substrate
    state, `Mᴴ * M = 0 ⟹ M = 0` — positive-definiteness of the inner product. The property from which
    orthomodularity follows via the projection-lattice theorem (`Completeness_Evidence.md` §6c). -/
theorem substrate_dagger_proper {n : ℕ} {M : Matrix (Fin n) (Fin n) ℂ}
    (h : M.conjTranspose * M = 0) : M = 0 :=
  Matrix.conjTranspose_mul_self_eq_zero.mp h

/-- **Corollary for the 2×2 Hermitian `Form`** — the Minkowski / Pauli-coordinate substrate matrix
    (`SpacetimeDynamics`): its dagger is proper too. -/
theorem form_dagger_proper {f : Form}
    (h : f.toMatrix.conjTranspose * f.toMatrix = 0) : f.toMatrix = 0 :=
  substrate_dagger_proper h

/-- **Status — the (a1) rung landed.** The substrate dagger is a proper involution; given the
    projection-lattice bridge (Baer-`*`-ring→orthomodular, which Mathlib lacks assembled), the
    orthomodular law follows on the rendered layer, narrowing #118's residue. See
    `Completeness_Evidence.md` §6c. -/
theorem proper_involution_summary : True := trivial

end QLF.ProperInvolution
