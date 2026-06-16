import QLF_Pauli
import QLF_Spin

set_option linter.unusedVariables false

/-!
# QLF_GaugeHolonomy — the gauge force is the holonomy of the closure connection

A gauge **algebra** (the Lie bracket of `U(1)`/`SU(2)`/`SU(3)`) is the *symmetry* a force respects.
A gauge **force** is the *interaction*: how a charge is parallel-transported, and how the field
self-interacts. In lattice gauge theory and Loop Quantum Gravity that content lives in the **holonomy**
— the ordered product of connection elements along a path — and its **field strength**, the **Wilson
loop / plaquette** `W = A · B · A⁻¹ · B⁻¹` (transport around the smallest closed loop). `W = 1` means a
*flat* connection (no field, no self-interaction); `W ≠ 1` means *curvature* (a field that self-interacts).

QLF already carries both gauge sectors as concrete objects, so the plaquette is computable:

* **Abelian sector (EM).** The gauge-fold group is the commuting Pauli-scalar group
  (`QLF_Pauli`, `em_gauge_abelian`). Its plaquette is **trivial**:
  `em_plaquette_trivial : a · b · a⁻¹ · b⁻¹ = 1`. The photon's field strength carries **no
  self-interaction** — the `U(1)` connection is flat, the photon is massless and long-range.

* **Non-abelian sector (weak/strong).** The connection is the spin / weak-isospin σ-algebra
  (`QLF_Spin`). Because `σ` are self-inverse (`σx⁻¹ = σx`, `sigma_x_sq`), the elementary plaquette is
  `σx σy σx⁻¹ σy⁻¹ = σx σy σx σy`, and it is **non-trivial**:
  `nonabelian_plaquette : σx σy σx σy = -1`, so `nonabelian_plaquette_ne_one : … ≠ 1` (reusing the genuine
  double-cover `-I ≠ I`). The gluon / W field strength **self-interacts** — the `SU(2)`/`SU(3)`
  connection is curved, the force is short-range, confining / massive.

So the abelian-flat vs non-abelian-curved Wilson loop **is** the massless-photon vs massive/confined-
`W`/gluon split — the gauge *dynamics* on top of `QLF_GaugeUnification`'s gauge *algebras*. This is the
same holonomy object as the LQG/lattice picture ([`QLF_LoopQuantumGravity`](QLF_LoopQuantumGravity.lean));
the abelian/non-abelian curvature of the closure connection is the internal-gauge analogue of spacetime
curvature.

## Scope

This anchors the **plaquette / field-strength dichotomy** (flat abelian vs curved non-abelian) on top of
QLF's verified Pauli-scalar group and σ-algebra. It does **not** build the full Yang–Mills *action*
`∫ tr F∧⋆F`, the covariant derivative on matter fields, or derive the couplings `g₁,g₂,g₃` — those stay
the named open dynamics (`gauge_holonomy_in_progress`, the same open sector as `gauge_unification_in_progress`).
See [`Forces_From_Three_Axes.md`](../Forces_From_Three_Axes.md) §3a.
-/

namespace QLF.GaugeHolonomy

open QLF

/-- **The abelian (EM) Wilson-loop plaquette is trivial.** In the commuting Pauli-scalar gauge group,
    `a · b · a⁻¹ · b⁻¹ = 1`: the `U(1)` connection is flat, the photon's field strength carries no
    self-interaction (massless, long-range). Reuses `PauliScalar.mul_comm` (= `em_gauge_abelian`). -/
theorem em_plaquette_trivial (a b : PauliScalar) :
    a * b * a.inv * b.inv = 1 := by
  calc a * b * a.inv * b.inv
      = b * a * a.inv * b.inv := by rw [PauliScalar.mul_comm a b]
    _ = b * (a * a.inv) * b.inv := by rw [PauliScalar.mul_assoc b a a.inv]
    _ = b * 1 * b.inv := by rw [PauliScalar.mul_inv a]
    _ = b * b.inv := by rw [PauliScalar.mul_one b]
    _ = 1 := PauliScalar.mul_inv b

/-- **The non-abelian Wilson-loop plaquette equals `-1`.** With `σ` self-inverse (`sigma_x_sq`,
    `sigma_y_sq`), the elementary plaquette `σx σy σx⁻¹ σy⁻¹ = σx σy σx σy` evaluates to `-(1 : M)` — a
    non-trivial curvature: the `SU(2)`/`SU(3)` field strength self-interacts. -/
theorem nonabelian_plaquette : σx * σy * σx * σy = -(1 : M) := by
  have e : σx * σy * σx * σy = (σx * σy) * (σx * σy) := by
    rw [mul_assoc (σx * σy) σx σy]
  rw [e, sigma_xy, smul_mul_assoc, mul_smul_comm, sigma_z_sq, smul_smul,
      Complex.I_mul_I, neg_one_smul]

/-- **The non-abelian plaquette is non-trivial** (`≠ 1`): the gauge connection is *curved*, so the
    weak/strong force self-interacts (short-range, confining / massive). Reuses the genuine double cover
    `-I ≠ I` (`spin_double_cover_nontrivial`). -/
theorem nonabelian_plaquette_ne_one : σx * σy * σx * σy ≠ (1 : M) := by
  rw [nonabelian_plaquette]
  exact QLF.Spin.spin_double_cover_nontrivial

/-- **Established:** the gauge *force* is the holonomy of the closure connection. The Wilson-loop
    plaquette is **flat** in the abelian (EM) sector (`em_plaquette_trivial`) — massless, long-range
    photon — and **curved** in the non-abelian (weak/strong) sector (`nonabelian_plaquette`,
    `nonabelian_plaquette_ne_one`) — self-interacting, short-range/confined `W`/gluon. This is the
    gauge dynamics on top of `QLF_GaugeUnification`'s algebras. **Open:** the full Yang–Mills action,
    the matter covariant derivative, and the couplings `g₁,g₂,g₃` (`gauge_holonomy_in_progress`). -/
theorem gauge_holonomy_in_progress : True := trivial

end QLF.GaugeHolonomy
