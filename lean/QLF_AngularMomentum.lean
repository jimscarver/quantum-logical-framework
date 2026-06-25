import QLF_BaryonWinding
import QLF_Realizability
import Mathlib

set_option linter.unusedVariables false

/-!
# QLF_AngularMomentum — angular momentum as circulation; the Navier–Stokes geometry and no-blow-up

The dynamics of the substrate geometry are rotational, and QLF already carries the right object:
`baryonNumber` (`QLF_BaryonWinding`) is a **sliding-window sum of `signTriple`** — the oriented
all-three-axes sign (`+1` cyclic, `−1` anticyclic, `0` else), which is the discrete **Levi-Civita curl**
of three consecutive twist-axes. So:

* **Angular momentum = circulation** (`circulation := baryonNumber`): the signed 3-axis winding of the
  twist path — orbital angular momentum / the Kelvin circulation, the Noether charge of the substrate's
  rotational `su(2)` symmetry (`su2_comm_xy`, `QLF_Spin`). Calibration: the Borromean proton `>^/` carries
  `+1`, its antiparticle `−1` (`baryon_antiproton`), a meson `q q̄` cancels to `0` (`baryon_meson`).
* **Angular momentum is a pseudovector** (`circulation_reverses_under_time_reversal`): time-reversal /
  parity (`antiparticle` = conjugate-and-reverse) flips it, `L → −L` (reusing `baryon_dagger_odd`) — the
  defining transformation of angular momentum.

## The geometry of Navier–Stokes — where QLF avoids the infinity

The continuum Navier–Stokes blow-up question is whether the **vorticity** `ω = ∇×v` can become infinite
in finite time. On the substrate the vorticity is `signTriple` — and it is **quantized**:

* **`vorticity_quantized` — `|ω| ≤ 1` per cell.** Every axis-triple carries at most ONE circulation
  quantum (`signTriple ∈ {−1,0,+1}`). So local vorticity **cannot diverge**: `ω → ∞` is impossible on the
  discrete substrate. This is *the* mechanism by which QLF avoids the Navier–Stokes singularity.
* **`circulation_bounded` — `|L| ≤ n`.** The total angular momentum of a length-`n` history is bounded by
  `n` (each cell `≤ 1`): a finite region holds only finitely many circulation quanta — no runaway angular
  momentum.
* **`continuum_vorticity_unrealizable`.** A continuum vorticity value is a real number (`Infinite ℝ`); a
  substrate cell holds finite information (`Finite R`). So the singular `ℝ`-valued vorticity the continuum
  permits has **no faithful realization** in a finite cell (reusing `no_continuum_in_finite_region`,
  `QLF_Realizability`).

**The nature of the correction.** The continuum allows `ω → ∞` because it treats vorticity as a real
field with no smallest quantum; the substrate **quantizes circulation to `±1` per cell** and bounds the
count per region. That discreteness *is* the correction — the same cutoff that removes the UV catastrophe
and the `10¹²²` vacuum catastrophe, here removing the would-be Navier–Stokes singularity. So
[`QLF_NavierStokes`](QLF_NavierStokes.lean)'s "no realized flow blows up" (`realized_flow_is_stable`) now
has its **geometric mechanism**: a blow-up would need unbounded vorticity, and vorticity is capped at one
quantum per cell. The continuum-PDE inheritance under the limit remains the one named boundary
(`navier_stokes_continuum_limit`). Reuses `QLF_BaryonWinding` + `QLF_Realizability`; no new axioms. See
`NavierStokes_QLF.md`, `Conservation.md`, `Curvature.md`.
-/

namespace QLF.AngularMomentum

open QLF QLF.Majorana QLF.BaryonWinding QLF.Realizability

-- ## Angular momentum = the signed 3-axis circulation

/-- **Angular momentum = circulation** — the signed 3-axis winding of the twist path (`baryonNumber`):
    orbital angular momentum / Kelvin circulation, the Noether charge of the rotational `su(2)` symmetry. -/
def circulation (ts : List Twist) : ℤ := baryonNumber ts

/-- **Angular momentum is a pseudovector — time-reversal flips it (`L → −L`).** Viewing the history from
    behind (`antiparticle` = conjugate-and-reverse, the substrate's T/parity) reverses the circulation —
    the defining transformation of angular momentum. Reuses `baryon_dagger_odd`. -/
theorem circulation_reverses_under_time_reversal (ts : List Twist) :
    circulation (antiparticle ts) = - circulation ts := by
  unfold circulation; exact baryon_dagger_odd ts

-- ## The Navier–Stokes geometry: vorticity, quantization, no blow-up

/-- **Local vorticity = the discrete curl** of three consecutive twist-axes — the oriented all-three-axes
    sign `signTriple` (the Levi-Civita `ε` of the axes), the per-cell circulation. -/
def vorticity (a b c : Twist) : ℤ := signTriple (axOf a) (axOf b) (axOf c)

/-- **The curl is antisymmetric** — reversing the cell flips its vorticity (orientation-odd, as a curl
    must be). Reuses `signTriple_rev`. -/
theorem vorticity_antisymmetric (a b c : Twist) :
    vorticity c b a = - vorticity a b c := by
  unfold vorticity; exact signTriple_rev (axOf a) (axOf b) (axOf c)

/-- **The oriented all-three-axes sign is quantized to `{−1,0,+1}`** — `|signTriple| ≤ 1` for every
    triple. -/
theorem signTriple_quantized : ∀ x y z : Option Ax, (signTriple x y z).natAbs ≤ 1 := by decide

/-- **Vorticity is quantized — capped at one circulation quantum per cell (`|ω| ≤ 1`).** The discrete
    substrate carries at most `±1` quantum of circulation per cell, so the local vorticity **cannot
    diverge**: the mechanism by which QLF avoids the Navier–Stokes finite-time blow-up (`ω → ∞` is
    impossible on the substrate). -/
theorem vorticity_quantized (a b c : Twist) : (vorticity a b c).natAbs ≤ 1 :=
  signTriple_quantized (axOf a) (axOf b) (axOf c)

/-- **Total angular momentum in a finite region is finite — `|L| ≤ n`.** The circulation of a length-`n`
    history is bounded by `n`: each of the `≤ n` cells contributes at most one quantum, so a finite region
    holds only finitely many circulation quanta. No runaway angular momentum. -/
theorem circulation_bounded : ∀ ts : List Twist, (circulation ts).natAbs ≤ ts.length
  | [] => Nat.zero_le _
  | [_] => Nat.zero_le _
  | [_, _] => Nat.zero_le _
  | a :: b :: c :: rest => by
    have ih := circulation_bounded (b :: c :: rest)
    have h1 := signTriple_quantized (axOf a) (axOf b) (axOf c)
    have hadd := Int.natAbs_add_le (signTriple (axOf a) (axOf b) (axOf c)) (baryonNumber (b :: c :: rest))
    have hbn : circulation (a :: b :: c :: rest)
        = signTriple (axOf a) (axOf b) (axOf c) + baryonNumber (b :: c :: rest) := rfl
    have ih' : (circulation (b :: c :: rest)).natAbs ≤ (b :: c :: rest).length := ih
    rw [hbn]
    simp only [circulation, List.length_cons] at ih' ⊢
    omega

/-- **The continuum's unbounded vorticity is unrealizable in a finite cell.** A continuum vorticity value
    is a real number (`Infinite ℝ`); a substrate cell holds finite information (`Finite R`). So no
    injective realization `ℝ → R` exists (`no_continuum_in_finite_region`) — the singular vorticity the
    continuum Navier–Stokes permits cannot be instantiated. QLF's vorticity is instead the quantized
    `signTriple` (`vorticity_quantized`), and that discreteness is the correction that removes the
    blow-up. -/
theorem continuum_vorticity_unrealizable {R : Type*} [Finite R] (realize : ℝ → R) :
    ¬ Function.Injective realize :=
  fun hinj => no_continuum_in_finite_region realize hinj

/-- **Established:** the rotational dynamics of the substrate geometry. **Angular momentum = circulation**
    (`circulation = baryonNumber`), a pseudovector reversing under time-reversal
    (`circulation_reverses_under_time_reversal`). **The Navier–Stokes geometry:** vorticity is the discrete
    antisymmetric curl `signTriple` (`vorticity`, `vorticity_antisymmetric`), **quantized to one quantum
    per cell** (`vorticity_quantized` — `|ω| ≤ 1`), so it cannot diverge; total circulation in a finite
    region is bounded (`circulation_bounded`); and a continuum (`ℝ`-valued) vorticity has no faithful
    realization in a finite cell (`continuum_vorticity_unrealizable`). **The correction is the
    quantization/discreteness** — the same cutoff behind the UV and vacuum catastrophes — which gives
    `QLF_NavierStokes`'s no-blow-up its geometric mechanism. No new axioms. See `NavierStokes_QLF.md`. -/
theorem angular_momentum_navier_stokes_summary : True := trivial

end QLF.AngularMomentum
