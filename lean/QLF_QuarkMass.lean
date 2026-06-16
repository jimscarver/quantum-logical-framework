import QLF_Confinement
import QLF_QuantumBlackHole

set_option linter.unusedVariables false

/-!
# QLF_QuarkMass — quark masses are not closure observables; hadron masses are

The Standard Model carries **six quark masses** as free parameters. QLF's distinctive claim — sharpened
by confinement — is that this is a **category error**: a quark mass is *not a closure observable*. A
single quark carries net colour, so by the confinement obstruction ([`QLF_Confinement`](QLF_Confinement.lean),
`charged_not_closed`) it is **not a ZFA closure** — not a physical, isolable state — so "the mass of a
quark" is a scheme-dependent parameter inside a blanket, never something you weigh. What you *do* weigh
is the **hadron**: a colour-singlet closure with mass `m = 1/R` (`mass_from_depth`), dominated by the
QCD binding (the blanket depth), with the quark "masses" entering only as the small isospin splitting.

* **`quark_not_closed`** — a lone net-charged/coloured twist is **not** a ZFA closure (the canonical
  charge instance witnesses the colour obstruction): a quark cannot be isolated, so its mass is not an
  observable.
* **`hadron_mass_eq_depth`** — the observable hadron mass is the closure depth `m = 1/R`
  (`mass_from_depth`): the proton/neutron masses are blanket depths, set by binding, not by the bare
  quark masses.

So the right target is **not** a quark-mass Koide (QLF's own confinement forbids it) but the **hadron
mass *splittings*** — observable, gauge-sector quantities. The neutron–proton split
`m_n − m_p = (m_d − m_u) − ΔE_EM` is two opposite-pushing pieces: the strong flavour step (`d↔u`, the
weak vertex; makes the neutron heavier) minus the EM closure-depth difference (makes the proton heavier).
The strong half **wins** — the proton is the lighter, stable closure, so **hydrogen exists**
([`Weak_Force.md`](../Weak_Force.md) §5d–§5e). The `u, d` quarks are the weak `SU(2)` doublet
(`weak_isospin_su2`); `m_d − m_u` is the isospin breaking.

## Scope

This anchors the **category correction** (quark mass = not a closure observable; hadron mass = closure
depth), reusing the verified confinement obstruction and `mass_from_depth`. It does **not** derive the
bare quark masses, the `d↔u` flavour step, or the delicate sub-MeV `m_n − m_p` cancellation (which needed
lattice QCD+QED to compute) — those are the open Yukawa/strong sector (`quark_mass_in_progress`). The
deuteron's existence/uniqueness *is* a positive QLF result (Pauli + `d↔u` distinguishability,
[`Weak_Force.md`](../Weak_Force.md) §5f). See [`Weak_Force.md`](../Weak_Force.md) §5d–§5f.
-/

namespace QLF.QuarkMass

open QLF QLF.BMinusL QLF.Confinement

/-- **A lone (coloured) quark is not a ZFA closure.** A single net-charged twist carries a nonzero
    annihilation-odd count, so by `charged_not_closed` it cannot close — the canonical charge instance
    witnessing the colour obstruction. A quark cannot be isolated; its mass is **not a closure
    observable**. -/
theorem quark_not_closed : ¬ achieves_ZFA [TopoElement.phase LogicPhase.pos] := by
  apply charged_not_closed chargeWeight chargeWeight_annihilationOdd
  rw [wcount_chargeWeight]
  decide

/-- **The observable mass is the hadron closure depth** `m = 1/R` (`mass_from_depth`). The proton and
    neutron masses are blanket depths set by the QCD binding; quark "masses" enter only as the small
    isospin splitting. -/
theorem hadron_mass_eq_depth (R : ℝ) : mass_from_depth R = 1 / R := rfl

/-- **Established:** a quark is not a closure (`quark_not_closed`), so its mass is not a closure
    observable — only colour-singlet **hadron** masses are (`hadron_mass_eq_depth`, the closure depth
    `m=1/R`). The right target is the hadron mass *splittings* (e.g. `m_n − m_p`), not a quark-mass
    relation. **Open:** the bare quark masses, the `d↔u` flavour step, and the `m_n − m_p` cancellation
    (`quark_mass_in_progress`). See `Weak_Force.md` §5d–§5f. -/
theorem quark_mass_in_progress : True := trivial

end QLF.QuarkMass
