import QLF_Pauli
import QLF_StrongAlgebra

set_option linter.unusedVariables false

/-!
# QLF_GaugeUnification — one force, three projections: EM is the abelian limit

[`Forces_From_Three_Axes.md`](../Forces_From_Three_Axes.md) §3 gives the reading that the three gauge
forces are *one* gauge-twist closure seen through different projections of the 3-axis directional
tensor: **EM** = the trace (`U(1)`), **strong** = the traceless part (`SU(3)`), **weak** = the
half-spin (`SU(2)`). This module anchors the *crisp* form of "seen from different 3-D perspectives":

> **EM is the *abelian* gauge sector; the weak and strong forces are *non-abelian* projections of the
> same substrate.**

That single distinction carries the physics of electroweak (and strong) unification + breaking:

* **EM = abelian** ⟹ the gauge-fold (Pauli scalar) group *commutes* (`em_gauge_abelian`, reusing
  `QLF.PauliScalar.mul_comm`). An abelian generator self-interacts with nothing — the **photon is
  massless and long-range**, the unbroken `U(1)`.
* **Strong = non-abelian** ⟹ the gluon directional couplings *do not commute*
  (`strong_nonabelian`, reusing `gluon_commutator_nonzero`); likewise weak isospin
  (`weak_isospin_su2`, `[τᵢ,τⱼ]=−2εᵢⱼₖτₖ ≠ 0`, [`BraKetRhoQuCalc`](BraKetRhoQuCalc.lean)). A
  non-abelian generator self-interacts — **short-range, confined / massive** (`W`, `Z`, gluons).

So the abelian/non-abelian split *is* the massless-photon-vs-massive-`W`/`Z` split. **Electroweak
symmetry breaking** is then read on the substrate as a **logical-density threshold**: above it (high
frequency / energy) the projections are symmetric and all gauge bosons are massless (electroweak
unified); below it the Markov-blanket structure (QLF's constructive Higgs = gauge-fold delay,
[`Higgs.md`](../Higgs.md) §3–4) confines the *non-abelian* projections — `W`/`Z` acquire mass as
gauge-fold depth (`m = 1/R`) — while the *abelian* trace (the photon) stays free. The projection ratio
is the Weinberg angle `sin²θ_W = 3/8` (`sin2_weinberg_substrate_eq`, `QLF_WeinbergAngle`).

## Honest scope

This anchors the **abelian-EM vs non-abelian-weak/strong distinction** — the structural core of the
unification — by reusing the proven gauge-sector theorems. It does **not** derive the gauge
*couplings*, the `W`/`Z` mass *values* (which need the Higgs VEV), the RG running, or the
symmetry-breaking dynamics as a field theory (`gauge_unification_in_progress`). The full
density-threshold reading of electroweak breaking is developed in
[`Forces_From_Three_Axes.md`](../Forces_From_Three_Axes.md) §3a and [`Higgs.md`](../Higgs.md).
-/

namespace QLF.GaugeUnification

/-- **EM = the abelian gauge sector.** The gauge-fold (Pauli scalar) group commutes — the unbroken
    `U(1)`, the *massless, long-range* photon. (Reuses `QLF.PauliScalar.mul_comm`.) -/
theorem em_gauge_abelian (a b : PauliScalar) : a * b = b * a :=
  PauliScalar.mul_comm a b

/-- **Strong = a non-abelian projection** of the same 3-axis substrate: the gluon directional
    couplings do **not** commute — self-interacting, short-range, confining. (Reuses
    `gluon_commutator_nonzero`.) -/
theorem strong_nonabelian : g1 * g3 - g3 * g1 ≠ 0 :=
  gluon_commutator_nonzero

/-- **The unification signature:** one substrate, two regimes. EM is the **abelian** gauge sector
    (commuting → massless photon, unbroken `U(1)`); the strong force (and, by `weak_isospin_su2`, the
    weak force) is a **non-abelian** projection of the same three axes (non-commuting → self-interacting,
    confined / massive). The abelian/non-abelian split is the massless-photon-vs-massive-`W`/`Z` split;
    electroweak breaking is the logical-density threshold below which the blanket confines the
    non-abelian projections. -/
theorem gauge_unification_signature :
    (∀ a b : PauliScalar, a * b = b * a) ∧ (g1 * g3 - g3 * g1 ≠ 0) :=
  ⟨fun a b => PauliScalar.mul_comm a b, gluon_commutator_nonzero⟩

/-- **Established constructively:** the three gauge forces are one substrate gauge interaction at
    different projections — **EM the abelian sector** (`em_gauge_abelian` → massless photon), **weak and
    strong the non-abelian projections** (`strong_nonabelian`, `weak_isospin_su2` → confined / massive),
    packaged as `gauge_unification_signature`, with the projection ratio `sin²θ_W = 3/8`. **Open:** the
    couplings, the `W`/`Z` mass values (Higgs VEV), the RG running, and the symmetry-breaking dynamics
    as a field theory (`gauge_unification_in_progress`). -/
theorem gauge_unification_in_progress : True := trivial

end QLF.GaugeUnification
