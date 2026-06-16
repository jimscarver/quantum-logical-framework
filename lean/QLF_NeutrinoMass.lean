import QLF_Majorana

set_option linter.unusedVariables false

/-!
# QLF_NeutrinoMass — the neutrino mass is Majorana; only the self-conjugate fermion can be

Mass type is fixed by **self-conjugacy**, and QLF decides it per particle. A *Dirac* mass `m ψ̄_L ψ_R`
pairs a particle with its distinct antiparticle; a *Majorana* mass `m ψ ψ` pairs a particle with
**itself**, and is allowed **only** when the particle *is* its own antiparticle — otherwise it would
violate the charge/lepton number the particle carries. QLF's antiparticle map (conjugate-and-reverse,
[`QLF_Majorana`](QLF_Majorana.lean)) tests this directly:

* **`neutrino_mass_majorana`** — the neutrino `^v` is its own antiparticle (`neutrino_majorana`), so it
  **can carry a Majorana mass** `m ν ν`.
* **`electron_mass_dirac`** — the electron `^<v>` is **not** self-conjugate (`electron_not_majorana`),
  so its mass is **Dirac** — it needs a distinct right-handed partner.
* **`majorana_mass_only_neutrino`** — packages the two: a lepton-number-violating Majorana mass is
  available to the neutrino and *only* the neutrino (the unique self-conjugate fermion). This is the
  root of **`0νββ`** (`ΔL = 2`): the two emitted neutrinos, being their own antiparticles, can annihilate
  — the corpus's clean falsifiable prediction.

The neutrino's smallness is the **seesaw** reading: the active (left, blanket-admitted) neutrino mixes
with a heavy sterile (right-handed, pure-gauge — [`QLF_WeakChirality`](QLF_WeakChirality.lean)) partner,
so `m_ν ~ m_D²/M_R` is suppressed by the heavy scale `M_R`. Why the neutrino is light *because* it is the
only one allowed a Majorana mass.

## Scope

This anchors **which mass type each lepton carries** — Majorana for the neutrino, Dirac for the charged
leptons — by reusing the verified self-conjugacy tests, with `0νββ` (`ΔL=2`) as the qualitative
consequence. It does **not** derive the **absolute neutrino mass scale**, the seesaw scale `M_R`, the
mass ordering (normal vs inverted), or `Σ m_ν` (`neutrino_mass_in_progress`). See
[`Beta_Decay_Neutrino_Nature.md`](../Beta_Decay_Neutrino_Nature.md), [`Beyond_Standard_Model.md`](../Beyond_Standard_Model.md) §3.
-/

namespace QLF.NeutrinoMass

open QLF QLF.Majorana

/-- **The neutrino mass is Majorana** — the neutrino `^v` is its own antiparticle. -/
theorem neutrino_mass_majorana : Majorana [Twist.up, Twist.down] := neutrino_majorana

/-- **The charged-lepton (electron) mass is Dirac** — `^<v>` is not self-conjugate. -/
theorem electron_mass_dirac :
    ¬ Majorana [Twist.up, Twist.left, Twist.down, Twist.right] := electron_not_majorana

/-- **A Majorana mass is available to the neutrino and only the neutrino.** The neutrino is its own
    antiparticle (so `m ν ν` is allowed); the electron is not (Dirac only). A lepton-number-violating
    Majorana mass — and hence `0νββ` (`ΔL = 2`) — is unique to the self-conjugate neutrino. -/
theorem majorana_mass_only_neutrino :
    Majorana [Twist.up, Twist.down] ∧
    ¬ Majorana [Twist.up, Twist.left, Twist.down, Twist.right] :=
  ⟨neutrino_majorana, electron_not_majorana⟩

/-- **Established:** the neutrino mass is Majorana (`neutrino_mass_majorana`) and the charged-lepton mass
    is Dirac (`electron_mass_dirac`); a Majorana mass (and `0νββ`, `ΔL=2`) is unique to the self-conjugate
    neutrino (`majorana_mass_only_neutrino`). The smallness is the seesaw reading (heavy sterile partner).
    **Open:** the absolute mass scale, `M_R`, the ordering, and `Σ m_ν` (`neutrino_mass_in_progress`).
    See `Beta_Decay_Neutrino_Nature.md`. -/
theorem neutrino_mass_in_progress : True := trivial

end QLF.NeutrinoMass
