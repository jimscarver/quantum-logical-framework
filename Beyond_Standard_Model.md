# Beyond the Standard Model — what QLF forces, predicts, and leaves open

**The honest accounting of where QLF goes past the Standard Model — and where it doesn't.** Companion to [`Open_Problems.md`](Open_Problems.md). The Standard Model is the most precise theory in science, but it has **~19 free parameters** (≈26 once the neutrino sector is included) and **explains none of them** — α, the fermion masses, the mixing angles are measured and plugged in. "Beyond the SM" therefore means two different things, and QLF does genuinely different things in each:

- **(A) Explaining the SM's inputs** — deriving what the SM takes as given. This is *math*, and several pieces are **machine-verified**. It is retrodiction (matching known numbers), not prophecy.
- **(B) New falsifiable physics** — predictions that differ from, or go past, the SM and await experiment. These **cannot be proved** (physics is empirical); they get tested.

The bright line: ✅ **forced** (machine-verified the value is *not free* but a consequence of substrate structure) · 🔭 **predicted** (falsifiable, untested) · 🔵 **open**.

---

## 1. The SM free-parameter ledger

| SM parameter(s) | QLF status | the *forcing* / prediction |
|---|---|---|
| **α** (EM coupling) | ✅ **forced** to 0.026% | `alpha_QLF_eq` = 1/137; `only_3d_substrate_gives_137` (2D→1/132, 4D→1/144) — α requires a **3-D** substrate |
| **3 charged-lepton masses** | ✅ 1 relation forced; 🔵 2 inputs left | `koide_two_thirds`: `Q=2/3` is forced by 3 generations ∧ 2 transverse axes ⇒ `m_τ` from `m_e,m_μ` (0.006%). Scale + Koide angle remain inputs |
| **g₂, g₃** (weak, strong couplings) | 🔵 open | the gauge *algebras* are verified (`weak_isospin_su2`, `trace_commutator_zero`); the couplings are not derived |
| **6 quark masses** | 🔵 open — but *category-corrected* | quark masses are **non-observable** (confinement; scheme-dependent parameters). The observable is the mass *difference* — hadron splittings `m_n−m_p = (m_d−m_u) − EM`, the `d↔u` weak vertex. QLF *predicts* no clean quark-mass relation; the open target is the **hadron splitting spectrum** ([`Weak_Force.md`](Weak_Force.md) §5d) |
| **4 CKM angles+phase** | 🔵 open | flavor change = gauge-fold pair-flip (operation); mixing angles open |
| **Higgs mass, VEV** | 🔵 open | mechanism reframed (gauge-fold delay, [`Higgs.md`](Higgs.md)); the 125 GeV and `v=246 GeV` not derived |
| **neutrino masses, PMNS** | 🔵 open masses; 🔭 **Dirac nature predicted → no 0νββ** (§3) | — |
| **θ_QCD** (strong-CP) | 🔵 not addressed | — |

**Honest tally:** of the ~19–26 SM parameters, QLF *firmly forces* **one** fundamental coupling (α) and **one relation** among the three lepton masses (Koide). That is a handful — but the SM forces **zero**, and the difference is the whole point: see §2.

---

## 2. The machine-verified beyond-SM content — *forcing*, not fitting

The SM cannot even *formulate* "why is α 1/137" or "why is Ω_Λ ≈ 0.69." QLF's beyond-SM theorems are not the values (anyone can fit a value) — they are the **counterfactuals proving the values are forced** by substrate structure the SM leaves unexplained:

- **α requires 3 spatial dimensions.** `alpha_QLF_eq : alpha_QLF = 1/137` with `alpha_QLF_2d_counterfactual` (2D → 1/132, +4%), `alpha_QLF_4d_counterfactual` (4D → 1/144, −5%), `only_3d_substrate_gives_137` ([`lean/QLF_FineStructureSubstrate.lean`](lean/QLF_FineStructureSubstrate.lean)). The fine-structure constant *and* the 3-dimensionality of space are the same fact.
- **Koide `Q=2/3` requires 3 generations and 2 transverse axes.** `koide_two_thirds` ([`lean/QLF_Koide.lean`](lean/QLF_Koide.lean)); only `N=3 ∧ A²=2` give 2/3 ([`koide_tau_demo.py`](koide_tau_demo.py) §3b counterfactuals).
- **Ω_Λ = log 2 requires exactly the 2 gauge axes.** `Omega_Lambda_QLF = Real.log 2` with `only_2_gauge_matches_observed_Omega_Lambda` (4-gauge → 2 log 2, 0-gauge → 0) ([`lean/QLF_CosmologicalConstant.lean`](lean/QLF_CosmologicalConstant.lean)).
- **m_p/m_e = 6π⁵** (`mass_ratio_QLF_eq`, 0.002%), with counterfactuals tying it to 3-quark permutation symmetry.
- **The SM gauge group is the symmetry of the 3 axes** — all three gauge algebras machine-verified (`no_magnetic_monopoles`, `weak_isospin_su2`, `trace_commutator_zero`), dims `1+3+8=12`, `1+8=9=N` ([`Forces_From_Three_Axes.md`](Forces_From_Three_Axes.md)).

This is the real, provable "beyond SM": **the SM's unexplained constants are forced consequences of one substrate** — verified for a handful, with the *forcing* (not just the value) machine-checked.

---

## 3. The falsifiable new prediction — beyond-SM physics, awaiting experiment 🔭

You cannot *prove* new physics; you test it. QLF makes **one sharp, clean, currently-tested** commitment:

> **Neutrinos are Dirac** (`ν ≠ ν̄`); `B−L` is exactly conserved → **no neutrinoless double-beta decay** (`0νββ`).

The SM is *agnostic* (Dirac vs Majorana is open); QLF's **exact per-event signed-count balance** (the `count_balanced_pauli_closed` keystone) makes `B−L` an exactly conserved count, and 0νββ — which would create two units of lepton number from nothing (`Δ(B−L)=2`) — is exactly the imbalance ZFA closure forbids ([`Beta_Decay_Neutrino_Nature.md`](Beta_Decay_Neutrino_Nature.md) §1, [`Experimental_Consistency.md`](Experimental_Consistency.md) §10). **LEGEND, nEXO, KamLAND-Zen are testing this now**, and *every search to date is null* — consistent with the prediction. A confirmed **positive** 0νββ signal would refute QLF's exact-`B−L` account specifically — a falsifiable, distinguishable-from-the-SM claim, and a cleaner one than a Majorana claim would be: it predicts the *absence* of a signal that is, so far, absent.

Softer, also beyond-SM but less sharp:
- **Dark matter is not a particle** — emergent vacuum time-folding ([`DarkMatter.md`](DarkMatter.md)); prediction: no DM particle is found (consistent with decades of null WIMP searches).
- **Sterile neutrino**, *if* it exists, is a specific pure-gauge (no-spatial-twist) sequence.

---

## 4. Beyond the SM **and** GR

- **Gravity is emergent**, not a fundamental force — and QLF reproduces GR's first triumph: **Mercury's perihelion advance ≈ 42.98″/century** to 0.03% (`mercury_perihelion_substrate_summary`, [`lean/QLF_MercuryPerihelion.lean`](lean/QLF_MercuryPerihelion.lean)), with `G` and `c` substrate-derived.
- **The cosmological constant** — `Ω_Λ = log 2` (1.2%) closing the **10¹²² "vacuum catastrophe,"** QFT+GR's worst prediction (`QLF_CosmologicalConstant.lean`). This is the single most beyond-SM-and-GR result in the corpus.
- **Exact global `B−L` — against the QG no-global-symmetry expectation.** Mainstream quantum gravity (Banks–Seiberg, swampland, black-hole no-hair) expects *no* exact global symmetries; QLF predicts `B−L` is **exactly** conserved, because its gravity is emergent from ZFA-balanced events and so cannot violate what ZFA enforces (QLF black holes return `B−L` bit-for-bit). A distinctive, falsifiable divergence — lab signature **no 0νββ** (§3), theoretical signature "`B−L` conserved across black-hole evaporation" ([`Quantum_Gravity.md`](Quantum_Gravity.md) §8). Prediction, not theorem; clean contrast is exact-zero vs. Planck-tiny violation.

---

## 5. What QLF does **not** do (the gaps, plainly)

- It does **not** derive most of the SM: the quark masses, CKM, the weak/strong couplings, the Higgs mass and VEV, and `θ_QCD` are all 🔵 open (§1).
- The lepton sector is **constrained, not closed**: `Q=2/3` is forced, but the scale and the Koide angle are inputs ([`Weak_Force.md`](Weak_Force.md) §5c — `2/9` is a flagged coincidence, not a derivation).
- α matches at **0.026%**, not exactly — the residual (Schwinger-scale) is open.
- The new-physics predictions (§3) **cannot be proved** — the Dirac / no-0νββ prediction awaits ongoing 0νββ searches; dark-matter-as-vacuum is qualitative.
- The Riemann-hypothesis link is an **axiom** (`spectral_hilbert_polya`), not a proof.

---

## 6. The honest scorecard

| | count | nature |
|---|---|---|
| SM parameters QLF **forces** (machine-verified) | ~1 coupling (α) + 1 lepton-mass relation (Koide) | retrodiction, but the *forcing* is proved |
| Beyond-SM/GR quantities derived | Ω_Λ, Λ, Mercury perihelion, m_p/m_e | retrodiction; several Lean-anchored |
| Falsifiable **new** predictions | 1 sharp (Dirac / no 0νββ) + 2 soft (dark matter, sterile ν) | untested; physics, not proof |
| SM parameters left **open** | the large majority (quarks, CKM, couplings, Higgs numbers, ν masses, θ_QCD) | 🔵 |

**Bottom line.** Two senses of "theory of everything" must be kept apart, because QLF's honest status is opposite in each:

- **As a foundational *ontology*** — one selection principle (ZFA on the computational possibility space) from which the structure of physics is meant to emerge — QLF **is** a TOE-scope framework, and says so openly ([`Active_Inference_Mathematics.md`](Active_Inference_Mathematics.md), [`VacuumEnergy.md`](VacuumEnergy.md) §6: vacuum-alignment as the TOE-completing layer). The claim "reality is the ZFA-balanced subset of computation" is a TOE-class claim about *what everything is*.
- **As a parameter-complete *derivation*** — deriving *every* SM+gravity constant from first principles with no free inputs and matching all experiment — QLF is **not** finished, and this document is the honest ledger of the distance: it *forces* ~one coupling (α) and one lepton-mass relation (Koide), derives a handful of beyond-SM/GR quantities (§2), and leaves the large majority open (§1, §5).

So the precise status is **a TOE-scope ontology with a partial, forced-not-fitted derivation attached** — strictly more than reproducing the SM (which forces *zero* of its parameters), strictly less than deriving it. Calling it a *finished* TOE would be the overclaim; calling it *only* an SM-fit would miss the ontological scope. The line to never blur is the second sense: the open parameters in §1 are open. The one clean falsifiable *new* prediction is Dirac neutrinos / no 0νββ (§3).

---

## 7. References

- [`Open_Problems.md`](Open_Problems.md) — the open-work registry this complements.
- [`Experimental_Consistency.md`](Experimental_Consistency.md) §10 — the falsifiability section; the Dirac / no-0νββ commitment.
- [`Forces_From_Three_Axes.md`](Forces_From_Three_Axes.md) — the three machine-verified gauge algebras.
- [`Weak_Force.md`](Weak_Force.md) §5 — Koide `Q=2/3`, `m_τ`, the Koide angle.
- [`Beta_Decay_Neutrino_Nature.md`](Beta_Decay_Neutrino_Nature.md), [`DarkMatter.md`](DarkMatter.md) — the new-physics predictions.
- [`Cosmological_Constant.md`](Cosmological_Constant.md) — `Ω_Λ = log 2`, the vacuum catastrophe.
- Lean anchors: `alpha_QLF_eq`, `koide_two_thirds`, `Omega_Lambda_QLF`, `mass_ratio_QLF_eq`, `mercury_perihelion_substrate_summary`, `weak_isospin_su2`, `trace_commutator_zero`.
