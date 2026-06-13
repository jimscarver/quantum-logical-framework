# The Pion in QLF

What can QLF say about the pion? Three things, in decreasing solidity — a structural fact,
a cosmological observation, and a mass-ratio reading (Nambu's coincidence, now anchored on
QLF's derived `α`). Lean: [`lean/QLF_PionMassRatio.lean`](lean/QLF_PionMassRatio.lean).

## 1. The pion is the minimal meson — solid

A pion is a quark–antiquark closure: a single `q q̄` Hermitian pair, color-singlet, with
**baryon number 0** (`baryon_meson`, machine-verified in [`QLF_BaryonWinding`](lean/QLF_BaryonWinding.lean)).
It is the **lightest hadron** for a reason QLF already owns: confinement keeps only
count-balanced color-singlet closures (the ZFA / `full_zeno_prune` selection), and the
`q q̄` pion is the smallest non-trivial one — the same "lightest non-vacuum closure" idea
behind the Yang–Mills gap ([`QLF_MassGap`](lean/QLF_MassGap.lean)). The strong SU(3) it
lives in is the traceless 3-axis tensor ([`QLF_StrongAlgebra`](lean/QLF_StrongAlgebra.lean)),
with `N_c = 3` from the substrate's 3 spatial axes.

## 2. The pion is the cosmologically-selected hadron — striking

QLF's cosmic-depth scaling (the Weinberg large-number relation `m³ ~ ℏ²H₀/Gc`) is satisfied
by the **pion, not the proton**: `(m_P/m_π)³ ≈ 7×10⁵⁹` is only ~10× short of the observed
cosmic depth, while the proton is ~3700× off ([HadronicDepth.md §2.1](HadronicDepth.md)). So
in QLF's substrate-depth picture the pion is the *fundamental hadronic mass scale* the
universe's ZFA depth picks out — the QCD scale, not the nucleon.

## 3. The mass ratio: `m_π±/m_e = |S₂|/α = 2/α` — a structural reading of Nambu

Nambu (1952): the charged pion is almost exactly `2/α` electron masses
(`m_π±/m_e = 273.13`, `2/α = 274.07`, **0.3%**) — two units of the `m_e/α ≈ 70 MeV` quantum.
QLF **derives** `α = 1/137` ([`QLF_FineStructureSubstrate`](lean/QLF_FineStructureSubstrate.lean)),
so it states this with no free constant and reads it against the proton:

| particle | quarks | chirality | factor | ratio to `m_e` |
|---|---|---|---|---|
| proton | 3 (`\|S₃\|=6`) | **hidden** (Borromean closure) | geometric `π⁵` | `6π⁵ = 1836` ([`QLF_LenzMassRatio`](lean/QLF_LenzMassRatio.lean)) |
| pion `±` | 2 (`\|S₂\|=2`) | **exposed** (pseudoscalar Goldstone) | EM `1/α` | `2/α = 274` |

The two are arithmetically consistent: `m_p/m_π = 6π⁵/(2/α) = 3π⁵·α = 3π⁵/137 ≈ 6.70`, vs the
measured `938.27/139.57 = 6.72` (`proton_pion_ratio_eq`).

**Honest scope.** The `|S₂| = 2` (two quarks) is the solid part — the meson analog of the
proton's `|S₃| = 6`; the single-quark counterfactual `1/α = 137` confirms the `2` *is* the
pair (`single_quark_eq`). The replacement of the proton's geometric `π⁵` by the pion's
`1/α` — hidden vs exposed chirality — is a **structural reading of Nambu's coincidence**,
made non-arbitrary by QLF's derived `α`, but **not yet a first-principles derivation** (the
status of the Lenz 5-angle count too). What is machine-verified is the arithmetic and the
0.3% experimental matches (`pion_electron_ratio_eq`); deriving the `1/α` from the
exposed-chirality EM coupling is the open mechanism (`pion_mass_ratio_in_progress`).

## The pion as a quantum black hole

Read as a Markov-blanket horizon, the pion is the **deepest hadronic horizon** (`m = E_P/R`,
lightest hadron ⟹ largest `R`) and the one whose **exposed** chirality makes its horizon
radiate — so the pion's decay *is* Hawking evaporation, where the proton's hidden-chirality
horizon stays stable. The same hidden/exposed axis behind `π⁵` vs `1/α` thus also fixes the
horizon's fate. See [Hadron_BlackHoles.md](Hadron_BlackHoles.md) and
[`lean/QLF_QuantumBlackHole.lean`](lean/QLF_QuantumBlackHole.lean).

## What's still open

No quark-flavour twist assignments, no `f_π`, no chiral anomaly (`π⁰ → γγ`), no
Gell-Mann–Oakes–Renner, no `m(π±) − m(π⁰)` electromagnetic splitting. The pieces QLF has
that bear on these — the photon as a joint closure (`Annihilation.md`), `N_c = 3`, the
LH/RH twist chirality (`CP-Violation-and-Chirality.md`) — are noted there.

## References

- Y. Nambu, *An empirical mass spectrum of elementary particles*, Prog. Theor. Phys. **7** (1952) 595 — the `m_e/α` mass quantum.
- M. Gell-Mann, R. J. Oakes & B. Renner, Phys. Rev. **175** (1968) 2195 — pion mass from the quark condensate (the standard mechanism).
- S. Weinberg, *Gravitation and Cosmology* (1972) — the large-number relation `m³ ~ ℏ²H₀/Gc`.

**See also:** [`lean/QLF_PionMassRatio.lean`](lean/QLF_PionMassRatio.lean), [`QLF_LenzMassRatio`](lean/QLF_LenzMassRatio.lean), [HadronicDepth.md](HadronicDepth.md), [YangMills_MassGap_QLF.md](YangMills_MassGap_QLF.md), [`lean/QLF_BaryonWinding.lean`](lean/QLF_BaryonWinding.lean), [`lean/QLF_StrongAlgebra.lean`](lean/QLF_StrongAlgebra.lean).
