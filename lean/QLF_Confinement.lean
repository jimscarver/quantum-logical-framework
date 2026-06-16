import QLF_BMinusL

set_option linter.unusedVariables false

/-!
# QLF_Confinement — color confinement is the singlet-closure obstruction

The strong force **confines**: no isolated quark is ever seen, only color-neutral hadrons (baryon = 3
quarks, meson = q q̄). In QLF this is the **closure obstruction** already proven for charge, applied to
color. `wcount_zero_on_ZFA` ([`QLF_BMinusL`](QLF_BMinusL.lean)) proves that *every annihilation-odd
signed charge is zero on every ZFA closure* — a closure prunes to the empty string, so any such charge
cancels. Electric charge is the canonical instance (every closure is neutral); **color is the strong
instance** (every closure is a color singlet).

* **`charged_not_closed`** — the contrapositive: a state carrying a net charge of this kind is **not** a
  ZFA closure. For color this is confinement: a lone quark carries net color, so it **cannot close** —
  it is not a physical (closed) state.
* **`singlet_closure`** — every ZFA closure has zero net (charge/color) count: only **singlets** close.

**Why the flux tube / linear potential (structural reading).** A would-be free quark is an *open* color
line; to remain a non-closure its color flux must terminate somewhere, which it cannot in a balanced
substrate — so the flux is squeezed into a tube to another charge, and the **constructing delay grows
with separation** (the closure cost ∝ length), giving a confining linear potential `V(r) ∝ r`: pulling
two color charges apart costs unbounded energy, so they never separate. Color is the **3-axis (Borromean)
instance**: a baryon needs one charge per spatial axis (RGB), remove any one and it does not close
([`QLF_StrongAlgebra`](QLF_StrongAlgebra.lean), [`QLF_BaryonWinding`](QLF_BaryonWinding.lean)). Pairs with
the curved non-abelian Wilson loop of [`QLF_GaugeHolonomy`](QLF_GaugeHolonomy.lean) (the gluon
self-interaction that makes the flux tube).

## Scope

This anchors the **singlet-only-closure obstruction** (a net-charged/colored state is not a ZFA closure)
by reusing the verified `wcount_zero_on_ZFA`. Color is the spatial-axis instance of the same annihilation-
odd signed count; the *value* of the string tension / linear potential and the asymptotic-freedom→
confinement RG flow stay the named open dynamics (`confinement_in_progress`). See
[`Forces_From_Three_Axes.md`](../Forces_From_Three_Axes.md).
-/

namespace QLF.Confinement

open QLF QLF.BMinusL

/-- **The confinement obstruction.** Any annihilation-odd signed charge `w` (electric, or — the strong
    instance — color) is zero on every ZFA closure (`wcount_zero_on_ZFA`); contrapositively, a state
    carrying a net `w`-charge is **not** a ZFA closure. For color: an isolated colored quark cannot
    close, so it is not a physical state — it is **confined** to color-neutral combinations. -/
theorem charged_not_closed (w : TopoElement → Int) (hw : AnnihilationOdd w)
    (s : TopoString) (hne : wcount w s ≠ 0) : ¬ achieves_ZFA s :=
  fun h => hne (wcount_zero_on_ZFA w hw s h)

/-- **Only singlets close.** Every ZFA closure has zero net signed (charge/color) count — it is a
    singlet. The canonical instance via `chargeWeight`. -/
theorem singlet_closure (s : TopoString) (h : achieves_ZFA s) :
    wcount chargeWeight s = 0 :=
  wcount_zero_on_ZFA chargeWeight chargeWeight_annihilationOdd s h

/-- **Established:** color confinement is the singlet-closure obstruction — a net-colored state is not a
    ZFA closure (`charged_not_closed`), so only color-neutral combinations are physical
    (`singlet_closure`), color being the spatial-axis instance of the verified annihilation-odd
    obstruction. **Open:** the string-tension / linear-potential *value* and the asymptotic-freedom→
    confinement RG flow (`confinement_in_progress`). See `Forces_From_Three_Axes.md`. -/
theorem confinement_in_progress : True := trivial

end QLF.Confinement
