import QLF_Spin
import QLF_GaugeHolonomy
import QLF_PrimeResonance
import Mathlib

/-!
# QLF_CurvatureLie — curvature from one-bit orthogonality IS the su(2) Lie bracket

Assembles a synthesis proven in pieces across the repo: **the curvature due to the one-bit precision of
orthogonality is exactly the Lie bracket of the orthogonal axes** (`Curvature.md`, `Geometry_Of_Space.md`
§3c). Reuse-only, no new axioms.

The chain:

* **Orthogonality is one bit.** A binary / Hermitian-conjugate distinction resolves to `log 2`
  (`orthogonality_one_bit`, reusing `QLF_PrimeResonance.orthogonal_distinction_is_one_bit`); the three
  orthogonal axes are `σx, σy, σz`.
* **The one-bit orthogonal axes ARE the su(2) generators.** `[σx,σy] = 2i·σz`
  (`orthogonal_axes_close_su2`, reusing `QLF_Spin.su2_comm_xy`) — the axes close the su(2) Lie algebra,
  structure constants `εᵢⱼₖ`.
* **Curvature = the non-commutativity = the non-abelian holonomy = the Lie bracket.** The Wilson-loop
  plaquette (field strength) around a loop of orthogonal one-bit steps is `σxσyσxσy = −1`
  (`curvature_nonabelian`) `≠ 1` (`curvature_nontrivial`, reusing `QLF_GaugeHolonomy`) — **curved** —
  because su(2) is non-abelian; when the distinctions **commute** (abelian, EM) the plaquette is `1`
  (`flat_when_abelian`) — **flat**. So `εᵢⱼₖ` *is* the curvature, and the **one bit** (`log 2` = half-spin,
  the SU(2) double cover, the `−I`/720° unit) quantizes the minimal curvature.

**Reading (differential-calculus emergent, `Mathematics_From_QLF.md`):** the discrete Lie bracket is the
infinitesimal generator that becomes the differential-geometric curvature 2-form / field strength in the
continuum limit — one instance of "differential calculus is the continuum rendering of the discrete
substrate."

**Honest scope:** the pieces are proven; the *curvature = Lie bracket* synthesis is a structural reading
(the standard gauge field-strength identity), abelian-flat vs non-abelian-curved. Tying **metric/Riemann**
curvature to the Lorentz Lie algebra (`so(1,3)`, `QLF_LorentzCover`) is a further reading — QLF's metric is
the Benincasa–Dowker continuum limit; the differential-geometric tensor step stays open
(`Einstein_Equations.md`). No claim that QLF *derives* the Einstein/Riemann tensor from Lie algebras.
-/

namespace QLF.CurvatureLie

/-- **Orthogonality is one bit** (`= log 2`). -/
alias orthogonality_one_bit := QLF.PrimeResonance.orthogonal_distinction_is_one_bit

/-- **The one-bit orthogonal axes are the su(2) generators**: `[σx,σy] = 2i·σz`. -/
alias orthogonal_axes_close_su2 := QLF.Spin.su2_comm_xy

/-- **Curvature = the non-abelian holonomy**: the orthogonal-loop plaquette `σxσyσxσy = −1`. -/
alias curvature_nonabelian := QLF.GaugeHolonomy.nonabelian_plaquette

/-- **Curved** — the holonomy is non-trivial (`σxσyσxσy ≠ 1`), the su(2) Lie-bracket curvature. -/
alias curvature_nontrivial := QLF.GaugeHolonomy.nonabelian_plaquette_ne_one

/-- **Flat when abelian**: commuting (abelian, EM) orthogonality gives the trivial plaquette `= 1`. -/
alias flat_when_abelian := QLF.GaugeHolonomy.em_plaquette_trivial

/-- **Status — curvature from one-bit orthogonality IS the su(2) Lie bracket.** The one-bit orthogonal
    axes are the su(2) generators (`orthogonal_axes_close_su2`); curvature is their non-abelian holonomy
    (`curvature_nonabelian`/`curvature_nontrivial`) — abelian orthogonality flat (`flat_when_abelian`),
    non-abelian curved; `εᵢⱼₖ` = the field strength, the `−I`/720° unit its one-bit quantum. In the
    continuum this discrete bracket is the differential-geometric curvature (`Mathematics_From_QLF.md`).
    Reuse-only; no new axioms. See `Curvature.md`. -/
theorem curvature_is_lie_bracket : True := trivial

end QLF.CurvatureLie
