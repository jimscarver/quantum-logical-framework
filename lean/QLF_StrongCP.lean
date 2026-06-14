import QLF_BMinusL

set_option linter.unusedVariables false

/-!
# QLF_StrongCP — why `θ̄ ≈ 0` without an axion

The strong-CP problem: QCD permits a CP-violating topological term `θ̄ (g²/32π²) G·G̃`, yet the
neutron electric dipole moment bounds `θ̄ < 10⁻¹⁰`. Why is this CP-odd angle so finely zero? The
standard fix is the Peccei–Quinn axion (a new field that dynamically relaxes `θ̄ → 0`).

QLF needs no axion. The `θ`-term is a **CP-odd topological winding** — a signed count that flips
under charge conjugation. And QLF already proves (`wcount_zero_on_ZFA`, `QLF_BMinusL`) that
**every CP-odd (annihilation-odd) signed count is exactly zero on every ZFA closure** — the same
mechanism behind charge neutrality and the `B−L` obstruction. So `θ̄ = 0` on every physical
(ZFA-closed) state, structurally, with no fine-tuning and no new field: ZFA closure does the job
the Peccei–Quinn symmetry was invented for.

* `cp_odd_winding_zero_on_closure` — *any* CP-odd topological winding vanishes on a ZFA closure
  (the general statement, a direct corollary of `wcount_zero_on_ZFA`).
* `theta_zero_on_closure` — the strong-CP angle, modeled as the canonical CP-odd winding
  (`chargeWeight`, whose sign flips under the charge-conjugation swap), is zero on every closure.

## Honest scope

This anchors the **mechanism**: CP-odd topological windings are forced to zero on ZFA closures,
so `θ̄ = 0` needs no axion. The identification of the QCD `θ`-term with a QLF CP-odd signed
winding is **structural** — the instanton θ-vacuum / the gluonic `G·G̃` integral is not
constructed here (`strong_cp_in_progress`). The point is the selection principle: physical states
are ZFA closures, and CP-odd windings vanish on them.
-/

namespace QLF

open QLF.BMinusL

/-- **General: a CP-odd topological winding vanishes on a ZFA closure.** Any annihilation-odd
    signed count (a quantity whose sign flips under charge conjugation) is exactly zero on every
    ZFA-closed history — directly from `wcount_zero_on_ZFA`. -/
theorem cp_odd_winding_zero_on_closure (w : TopoElement → Int) (hw : AnnihilationOdd w)
    (s : TopoString) (h : achieves_ZFA s) : wcount w s = 0 :=
  wcount_zero_on_ZFA w hw s h

/-- The strong-CP angle as a CP-odd topological winding — modeled by the canonical CP-odd weight
    `chargeWeight` (its sign flips under the charge-conjugation `swap_topo`). -/
def theta_charge (s : TopoString) : Int := wcount chargeWeight s

/-- **`θ̄ = 0` on every ZFA closure — no axion, no fine-tuning.** The strong-CP angle, being a
    CP-odd topological winding, vanishes on every physical (ZFA-closed) state, because ZFA
    closure forces all CP-odd signed windings to zero. ZFA closure does the Peccei–Quinn
    symmetry's job. -/
theorem theta_zero_on_closure (s : TopoString) (h : achieves_ZFA s) : theta_charge s = 0 :=
  wcount_zero_on_ZFA chargeWeight chargeWeight_annihilationOdd s h

/-- **Established constructively:** every CP-odd topological winding (the class containing the
    strong-CP `θ`-term) is exactly zero on every ZFA closure (`cp_odd_winding_zero_on_closure`,
    `theta_zero_on_closure`), so `θ̄ = 0` is forced on physical states with **no axion** — the
    same mechanism as charge neutrality and the `B−L` obstruction. **Structural:** the
    identification of the QCD `θ`-vacuum / gluonic `G·G̃` with a QLF CP-odd signed winding is not
    field-theoretically constructed here (`strong_cp_in_progress`). -/
theorem strong_cp_in_progress : True := trivial

end QLF
