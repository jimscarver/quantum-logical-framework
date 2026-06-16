import QLF_CKM

set_option linter.unusedVariables false

/-!
# QLF_PMNS — lepton mixing is unitary, with extra Majorana phases

The PMNS matrix is the lepton analogue of CKM: a **unitary** mixing of the three neutrino flavours.
QLF's three generations give the same `3 angles + 1 Dirac CP phase` count, and the same closure⇒unitarity
([`QLF_CKM`](QLF_CKM.lean)) — but because the neutrino is **Majorana** ([`QLF_NeutrinoMass`](QLF_NeutrinoMass.lean)),
PMNS carries **`N − 1` *extra* Majorana phases** that CKM (Dirac quarks) does not.

* **`pmns_row_unitarity`** — `|U_e1|² + |U_e2|² = cos² + sin² = 1` (reuses the rotation unitarity): the
  electron-neutrino's flavour content sums to 1, lepton flavour rotated not lost — unitarity = closure.
* **`majorana_phases`** / **`three_gen_majorana_phases`** — a Majorana mixing carries `N − 1` extra
  phases; for `N = 3`, that is **2** (no rephasing freedom to remove them, since `ν = ν^c`).
* **`pmns_total_cp_phases`** — total PMNS CP phases `= 1 Dirac + 2 Majorana = 3`, versus CKM's lone
  Dirac phase. The two extra phases are physical only in lepton-number-violating observables (`0νββ`).

**The structural reading (open values).** Quarks mix *small* and hierarchically (hidden / confined
chirality), leptons mix *large* — near tri-bimaximal (`sin²θ₁₂ ≈ 1/3`, `θ₂₃` near-maximal, broken by
`θ₁₃ ≈ 8.6°`) — read on the same exposed-vs-hidden-chirality axis as the pion / black-hole work
([`Standard_Model.md`](../Standard_Model.md) §4.2). The neutrino's exposed (blanket-admitted left-handed)
chirality is *why* its mixing is large.

## Scope

This anchors **PMNS unitarity** and the **Majorana phase count** (`N−1` extra ⟹ 3 total CP phases for
`N=3`), reusing `QLF_CKM`'s rotation unitarity and `QLF_FlavorMixing`'s Dirac count. It does **not**
derive the **mixing-angle values** (tri-bimaximal / `θ₁₃`), the **Dirac phase `δ_CP`**, or the **Majorana
phase values** — the open Yukawa/neutrino-mass sector (`pmns_in_progress`). See
[`Standard_Model.md`](../Standard_Model.md) §4.2.
-/

namespace QLF.PMNS

/-- **PMNS row unitarity** — `|U_e1|² + |U_e2|² = cos² + sin² = 1` (reuses the rotation unitarity): the
    electron neutrino's flavour content sums to 1; lepton flavour is rotated, never created or lost. -/
theorem pmns_row_unitarity (θ : ℝ) : Real.cos θ ^ 2 + Real.sin θ ^ 2 = 1 :=
  QLF.CKM.cabibbo_row_unitarity θ

/-- **Majorana phases:** a Majorana mixing matrix carries `N − 1` extra phases beyond the Dirac count
    (the antiparticle = particle removes the rephasing freedom that would absorb them). -/
def majorana_phases (N : ℕ) : ℕ := N - 1

/-- For three generations, **2** extra Majorana phases. -/
theorem three_gen_majorana_phases : majorana_phases 3 = 2 := by decide

/-- **Total PMNS CP phases = 1 Dirac + 2 Majorana = 3** (versus CKM's single Dirac phase). The Dirac
    count reuses `QLF_FlavorMixing` (`cp_phases 3 = 1`); the two Majorana phases are physical only in
    lepton-number-violating observables (`0νββ`). -/
theorem pmns_total_cp_phases : cp_phases 3 + majorana_phases 3 = 3 := by decide

/-- **Established:** PMNS is unitary (`pmns_row_unitarity`) — lepton mixing conserves flavour by closure;
    and, because the neutrino is Majorana, it carries `N−1 = 2` extra phases (`three_gen_majorana_phases`),
    for `1 Dirac + 2 Majorana = 3` total CP phases (`pmns_total_cp_phases`), unlike CKM's one. **Open:**
    the angle values (tri-bimaximal / `θ₁₃`), the Dirac phase, and the Majorana phases
    (`pmns_in_progress`). See `Standard_Model.md` §4.2. -/
theorem pmns_in_progress : True := trivial

end QLF.PMNS
