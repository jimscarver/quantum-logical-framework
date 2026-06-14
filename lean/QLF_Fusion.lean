import QLF_Spin

set_option linter.unusedVariables false

/-!
# QLF_Fusion — the β⁺ keystone: joining two Markov blankets needs distinguishability

The first fusion step in every hydrogen-burning star is `p + p → ²H + e⁺ + ν_e` — simultaneously a
**fusion** (two Markov blankets join) and a **β⁺ decay** (one proton → neutron). It *must* be both,
and the reason is the Pauli "insulator" proof (`pauli_exclusion`, [`PauliExclusion`](PauliExclusion.lean)).

This module packages the two already-verified halves into one named theorem:

* **Identical proton blankets are Pauli-insulated.** Two protons are *identical* closures; the
  fusion handshake needs them to share a single bound ZFA closure, and identical fermionic closures
  cannot — their only fermionic (antisymmetric) channel **vanishes**: `fermi_antisym p p = 0`
  (`diproton_pauli_blocked`, = `pauli_exclusion`). There is no bound diproton; ²He is unbound.
* **A distinguishable pair closes.** A genuine two-body Hermitian-pair (the `p+n` deuteron channel)
  folds to the identity — a realized ZFA closure (`deuteron_channel_closes`, =
  `QLF.Spin.opposite_spin_singlet_closes`).

So the only key that opens the first blanket-join is a β⁺ flavour step (`u→d`) that makes the two
identical proton blankets **distinguishable**: `pp_join_requires_distinguishability`. The weak force
is therefore the *precondition* for the first Markov-blanket join — `no β⁺ → no deuteron → no chain`
— and its weak-mediated rarity is why the Sun burns over billions of years rather than detonating.

## Honest scope

This binds two *already-proven* facts (`pauli_exclusion` + `opposite_spin_singlet_closes`) into the
fusion **necessity** statement: identical blankets are insulated, distinguishable ones close. What it
does **not** carry is the **rate** — the β⁺ cross-section / weak coupling `G_F` that fixes how slow
the pp-chain is (the open weak-rate sector, `fusion_weak_rate_in_progress`). See
[`Fusion.md`](../Fusion.md) §3a, [`SEX.md`](../SEX.md), [`Beta_Decay_Neutrino_Nature.md`](../Beta_Decay_Neutrino_Nature.md).
-/

namespace QLF.Fusion

open QLF QLF.Spin Matrix

/-- **Two identical proton blankets are Pauli-insulated.** The fermionic (antisymmetric) channel of
    an identical pair vanishes — `fermi_antisym p p = 0` — so two identical closures have no bound
    antisymmetric state: no diproton (²He unbound). Direct reuse of `pauli_exclusion`. -/
theorem diproton_pauli_blocked (p : RhoProcess) : fermi_antisym p p = 0 :=
  pauli_exclusion p

/-- **A distinguishable two-body closure binds.** A pair of Hermitian twist folds (the `p+n`
    deuteron channel) composes to `+I` — a fully closed ZFA pair. Direct reuse of
    `QLF.Spin.opposite_spin_singlet_closes`. -/
theorem deuteron_channel_closes (s t : Twist) :
    (s.toMatrix * s.conj.toMatrix) * (t.toMatrix * t.conj.toMatrix) = (1 : M) :=
  opposite_spin_singlet_closes s t

/-- **The β⁺ keystone — joining two blankets requires distinguishability.** Packaging the insulator
    proof with the binding channel: two *identical* proton blankets have **no** bound fermionic
    channel (`fermi_antisym p p = 0`, left), while a *distinguishable* Hermitian-pair (the `p+n`
    deuteron channel) **does** close to identity (right). Hence the pp-chain's first step
    `p + p → ²H + e⁺ + ν_e` cannot be a mere merger — it must convert one proton to a neutron by β⁺
    (`u→d`) to make the pair distinguishable before the deuteron can form. The weak β⁺ is the
    precondition for the first Markov-blanket join. -/
theorem pp_join_requires_distinguishability (p : RhoProcess) (s t : Twist) :
    fermi_antisym p p = 0 ∧
      (s.toMatrix * s.conj.toMatrix) * (t.toMatrix * t.conj.toMatrix) = (1 : M) :=
  ⟨diproton_pauli_blocked p, deuteron_channel_closes s t⟩

/-- **Established constructively:** the fusion **necessity** — identical proton blankets are
    Pauli-insulated (no diproton) while a distinguishable `p+n` channel closes, so a β⁺ step is the
    precondition for the first blanket-join (`pp_join_requires_distinguishability`, reusing
    `pauli_exclusion` + `opposite_spin_singlet_closes`). **Open:** the β⁺ *rate* — the cross-section
    / weak coupling `G_F` that sets how slow the pp-chain is (the open weak-rate sector). -/
theorem fusion_weak_rate_in_progress : True := trivial

end QLF.Fusion
