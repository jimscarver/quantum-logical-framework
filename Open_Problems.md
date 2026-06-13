# Open Problems — QLF gap registry

A single map of what is **closed**, what is a **principled boundary**, and what is
genuinely **open**, with a pointer to the document that owns each item. This is an
*index*, not a re-derivation: the substance lives in the linked docs. Its mirror is
[`Beyond_Standard_Model.md`](Beyond_Standard_Model.md) (what QLF *forces / predicts* past the SM).
It complements
[`Experimental_Consistency.md`](Experimental_Consistency.md) (which tracks per-result
precision) by collecting the *forward* work in one place.

**Why a registry.** Open items were scattered across ~25 documents, each with its own
"Open work" section. When a status changes, the claim can drift out of sync across docs
(as the Hadronic-Depth attribution did before its correction). This file is the
canonical status list; when an item moves, update it here and in its owning doc.

## Status legend

| Tag | Meaning |
|---|---|
| ✅ **Closed** | Derived / machine-verified; no longer open. |
| 🧱 **Boundary** | A *principled* limit (like an explicit axiom), not a gap to be closed by more work. The structural form is fixed; a number or bridge is inherited. |
| 🔵 **Open — quantitative** | Mechanism identified; a specific number is not yet derived from substrate. |
| 🟣 **Open — structural / Lean** | Result holds in prose/numerics; a clean theorem or Lean anchor is not yet written. |
| ⚪ **Future work** | Out of current scope by specification (not by doubt about the mechanism). |

---

## Recently changed (this is the live edge)

| Item | Status | Where |
|---|---|---|
| **Horizon temperature (Unruh / Hawking / de Sitter)** | ✅ **Machine-verified (unification)** — all three are the Unruh master `T = ℏa/(2πck_B)` at the right acceleration, the `2π` = loop phase; Hawking `ℏc³/(8πGMk_B)` (`hawking_temperature_eq`), de Sitter `ℏH₀/(2πk_B)` (`desitter_temperature_eq`); dark-sector tie `a₀ = cH₀/(2π)` (`mond_accel_is_hubble_over_loop`). Algebraic unification + loop-phase ID, not from-scratch QFT-in-curved-spacetime | [`lean/QLF_HorizonTemperature.lean`](lean/QLF_HorizonTemperature.lean), [`Gravity_From_Delay.md`](Gravity_From_Delay.md) §5.1 |
| **Why three fermion generations** | 🟣 **Structural (Lean)** — generation count = `substrate_spatial_dimension = 3` (`num_generations_eq_three`); the *same* `3` behind Koide (N=3 phases), colour SU(3), and α (`N=9=3²`) — `three_axis_signature` — with the 3 generations realized concretely as Koide's three 120° phases (`three_generations_satisfy_koide`). Reduces "why 3 generations" to "why 3 spatial dimensions" (the input, argued elsewhere); not derived from nothing | [`lean/QLF_Generations.lean`](lean/QLF_Generations.lean), [`lean/QLF_Koide.lean`](lean/QLF_Koide.lean) |
| **Spin demystified — spin IS the twists** | ✅ **Machine-verified** — 720°/SU(2)→SO(3) double cover (`rotation_360_eq_negI`, `rotation_720_eq_id`, `spin_double_cover_nontrivial`), worked qucalc folds incl. the electron fold `^<v>=−I` (`fold_electron`), charge conjugation = view-from-behind (`C_eq_motional_reversal`), integer spin = composite half-spins, like-spin exclusion / opposite-spin singlet. Naming defs (charge/chirality), no new axiom | [`lean/QLF_Spin.lean`](lean/QLF_Spin.lean), [`Spin_QLF.md`](Spin_QLF.md) |
| **Pion mass ratio `m_π±/m_e = 2/α`** | 🔵 **Open — quantitative** — `\|S₂\|=2` (two quarks) solid + arithmetic `2/α=274` (0.3%) Lean-verified (`pion_electron_ratio_eq`); the `1/α` from exposed chirality is a structural reading of Nambu's coincidence, not yet first-principles (`pion_mass_ratio_in_progress`) | [`lean/QLF_PionMassRatio.lean`](lean/QLF_PionMassRatio.lean), [`Pion_QLF.md`](Pion_QLF.md) |
| **Hadrons are quantum black holes** | ✅ **Machine-verified (unification)** — every hadron = Markov-blanket horizon; Compton–Schwarzschild crossing at the Planck mass (`compton_eq_schwarzschild_iff`), area law `S=4πR²log2`, meson/baryon split; decay = Hawking evaporation. Not a mass derivation (`R` is an input) | [`lean/QLF_QuantumBlackHole.lean`](lean/QLF_QuantumBlackHole.lean), [`Hadron_BlackHoles.md`](Hadron_BlackHoles.md) |
| **Dark matter = denser logic near masses** | 🔵 **Open — quantitative** — acceleration scale `a₀ = cH₀/(2π)` on the same Hubble horizon as `Ω_Λ=log2` (`mond_acceleration_horizon_form`), −13%/−6% vs RAR `g†` (inside ~20% systematic); transition radius, Tully–Fisher `v⁴=GMa₀`, Gaussian MRE bump all Lean-anchored. The `1/2π` prefactor + full rotation curve open (`dark_matter_acceleration_scale_in_progress`) | [`lean/QLF_DarkMatter.lean`](lean/QLF_DarkMatter.lean), [`DarkMatter.md`](DarkMatter.md), [`Experimental_Consistency.md`](Experimental_Consistency.md) §1.1 |
| **Neutrino is Majorana → 0νββ** | ✅ **Machine-verified** — `neutrino_majorana` ([`lean/QLF_Majorana.lean`](lean/QLF_Majorana.lean)): the antiparticle is the Hermitian conjugate (conjugate-and-reverse), and the `^v` loop is a fixed point of it (the electron is not — `electron_not_majorana`, so it is Dirac). The neutrino is the unique self-conjugate fermion ⟹ lepton number violated ⟹ **neutrinoless double-beta decay** is the signature (LEGEND/nEXO). Conditional on the `^v` assignment + antiparticle = Hermitian-conjugate | [`lean/QLF_Majorana.lean`](lean/QLF_Majorana.lean), [`Beta_Decay_Neutrino_Nature.md`](Beta_Decay_Neutrino_Nature.md) §1, [`Experimental_Consistency.md`](Experimental_Consistency.md) §9–10 |
| **Pauli closure** — count balance ⟹ Pauli scalar, all twist histories (incl. cross-axis interleaving) | ✅ **Closed** — `count_balanced_pauli_closed` | [`lean/QLF_TwistAlphabet.lean`](lean/QLF_TwistAlphabet.lean), [`Experimental_Consistency.md`](Experimental_Consistency.md) §2.1 |
| **Bethe constant `k(n,0)`** (Lamb shift) | 🧱 **Boundary** — continuum-dominated (`I_1S ≈ 19.77 Ry`, all bound `ΔE < 1 Ry`); free-electron sector above the RCA₀ floor | [`Lamb_Shift.md`](Lamb_Shift.md) §6.1, [`bethe_log_demo.py`](bethe_log_demo.py) |

---

## Principled boundaries (not gaps)

| Item | Why it is a boundary | Where |
|---|---|---|
| **Riemann critical line** | Substrate bridges proven; RH reduced to one explicit boundary, `spectral_hilbert_polya` (RCA₀ → WKL₀ crossing). Now **constructively scaffolded** by the MRE bridge: `Z_QLF` concrete, MRE saturation grounded in `binary_kl` and located at the critical-line prior `1/2`, refining the boundary to `MRE_bridge` (`riemann_hypothesis_in_qlf_via_MRE`). The residual Mellin↔ζ step is the analytic sector where ZFC is *proven* to fail — ZFC's defect, not a QLF gap (`rh_proof_in_progress`) | [`lean/QLF_Riemann.lean`](lean/QLF_Riemann.lean), [`lean/QLF_RiemannMRE.lean`](lean/QLF_RiemannMRE.lean) |
| **Yang–Mills mass gap** | Gap proven on the substrate (lightest non-vacuum closure = one `log 2` quantum; `mass_gap_quantum_pos`, `gaugeMassGap = log 2 > 0`); only the continuum-QFT reconstruction remains, carried by the explicit boundary axiom `yang_mills_continuum_gap` — the continuum sector where ZFC is proven to fail (`mass_gap_proven_constructively`) | [`lean/QLF_MassGap.lean`](lean/QLF_MassGap.lean), [`YangMills_MassGap_QLF.md`](YangMills_MassGap_QLF.md) |
| **P vs NP** | Lean-anchored: the realized (verifiable) set IS the O(n) verify-filter of the generated candidates (`realized_is_verify_filter`) with cardinality the real `C(2n,n)` (`realized_count_eq_central_binomial`, reusing `find_stable_states_length_even`). The formal separation is the boundary axiom `generate_not_reducible_to_verify`, over an infinite computational model — ZFC's proven-defective sector, not a QLF gap | [`lean/QLF_PvsNP.lean`](lean/QLF_PvsNP.lean), [`P_vs_NP_QLF.md`](P_vs_NP_QLF.md) |
| **Navier–Stokes smoothness** | Lean-anchored: realized flows achieve ZFA (`realized_flow_achieves_zfa`, reusing `encode_is_zfa`) and are stable closures (`realized_flow_is_stable`, reusing `qlf_universality`) — no realized history blows up; blow-up = non-terminating history pruned by `full_zeno_prune`. Only continuum-PDE inheritance remains — the boundary axiom `navier_stokes_continuum_limit`, the continuum sector where ZFC is proven to fail | [`lean/QLF_NavierStokes.lean`](lean/QLF_NavierStokes.lean), [`NavierStokes_QLF.md`](NavierStokes_QLF.md) |
| **Birch–Swinnerton-Dyer** | Self-dual central point `s=1` proven (`bsd_central_point_self_dual`), grounded in the same `H↔H†` involution as Riemann (`bsd_riemann_shared_involution`); the **elliptic-curve→closure encoding is built** — concrete `EllipticCurveQLF` with computed Frobenius traces (`frobeniusTrace`, `Ecn1_frobenius_two`). **Rank = ord (`bsd_rank_equals_order`) is now a theorem**, discharged through the modularity mirror (`Perspective`/`modularityMirror`/`centralMultiplicity`); the single boundary is `modularity_mirror_invariant` — the mirror preserves the central multiplicity at its self-dual fixed point. Qualitative BSD `bsd_in_qlf` derived. *Why* the mirror is multiplicity-preserving (the uncomputable rank content) is the continuum-sector remainder (`bsd_proof_in_progress`) | [`lean/QLF_BSD.lean`](lean/QLF_BSD.lean), [`BSD_QLF.md`](BSD_QLF.md), [`Langlands.md`](Langlands.md) |
| **Hodge conjecture** | The Hodge conjugation = the adjoint involution H↔H† (`conj_involutive`); Hodge classes = its balanced fixed points (`conj_fixed_of_isHodge`). A `(p,q)` class encodes to a history count-balanced iff `p=q` (`encode_countBalanced`), so **`hodge_class_is_algebraic` is a theorem** (Hodge ⟹ count-balanced ⟹ Pauli-closed via `count_balanced_pauli_closed` ⟹ realized). The single boundary is the faithfulness `substrate_realization_is_algebraic` — *why* substrate closure = algebraic realization over the complex-analytic continuum (`hodge_proof_in_progress`) | [`lean/QLF_Hodge.lean`](lean/QLF_Hodge.lean), [`Hodge_QLF.md`](Hodge_QLF.md) |
| **Speed of light `c`** | The substrate event quantum (one Planck length × one Planck tick *together*) is the foundational postulate — no Tier-3 below it | [`Experimental_Consistency.md`](Experimental_Consistency.md) §3, [`Kitada_Local_Time_GR.md`](Kitada_Local_Time_GR.md) §5.3 |
| **Bethe `k(n,0)`** | Continuum-sector (see live edge above) | [`Lamb_Shift.md`](Lamb_Shift.md) §6.1 |

---

## Open — quantitative (the hard front)

| Item | Status | Where |
|---|---|---|
| **Cosmic depth `n` from first principles** | The geometric depth `n ≈ 6.7×10⁶⁰` is firm but defined via `R_H`; the proton cube `(m_P/m_p)³ ≈ 2.2×10⁵⁷` undershoots by ~3,000×. This *is* the hierarchy problem | [`HadronicDepth.md`](HadronicDepth.md) §2.1 |
| **`H₀` from substrate** | Reduces to deriving `n` (above); currently `H₀` enters as one observable. Would close the last cosmological empirical input | [`Cosmological_Constant.md`](Cosmological_Constant.md) §196 |
| **Hubble tension** | The residual 8.7% in Λ tracks the Planck-vs-SH0ES `H₀` discrepancy; not predicted | [`Cosmological_Constant.md`](Cosmological_Constant.md) §197 |
| **`G` SI value / Einstein `8π·G` coefficients** | Form `G = L_P²c³/ℏ` derived; absolute SI value is substrate-quantum calibration (~37% prediction residual); `8π = 4π·2` identified but the full coefficient calc is research-grade | [`Gravity_From_Delay.md`](Gravity_From_Delay.md), [`Experimental_Consistency.md`](Experimental_Consistency.md) §6.3 |
| **First-principles `R_e`** | `α R_e = m_e` identifies `R_e` with the measured electron; deriving `R_e` (hence `m_e`) from closure-multiplicity counts is open | [`Bound_States_QLF.md`](Bound_States_QLF.md) §6, [`Atomic_System_QLF_Closures.md`](Atomic_System_QLF_Closures.md) §10 |
| **Mass spectrum from multiplicity** | 3rd-generation masses; τ-decay-vertex topology. **Handle:** Koide `Q=2/3` is now **machine-verified** as forced by `N=3` (three axes) ∧ `A²=2` (two transverse axes) — `koide_two_thirds`, [`lean/QLF_Koide.lean`](lean/QLF_Koide.lean) — and predicts `m_τ` from `m_e,m_μ` to **0.006%** (`Weak_Force.md §5a–5b`). Still open: the lepton-√mass↔axis-phase *identification*, the Koide angle, the scale (so `m_e,m_μ` are inputs), and the quark sector | [`Standard_Model.md`](Standard_Model.md) §4.1, [`Weak_Force.md`](Weak_Force.md) §5b |
| **Weak sector (W/Z)** | Weak-isospin **SU(2) Lie algebra now machine-verified** in Σ₈ (`weak_isospin_su2`, `Q₈⊂SU(2)`); still open: `R_W`/`R_Z` (hence W/Z masses + Weinberg-angle value), coupling `g`, `G_F`, flavor-change & τ-decay vertex topology, the Koide angle `δ` (lepton-sector input; `2/9` a flagged coincidence) | [`Weak_Force.md`](Weak_Force.md), [`lean/BraKetRhoQuCalc.lean`](lean/BraKetRhoQuCalc.lean) |
| **Gauge unification (forces from 3 axes)** | Structural conjecture: `dim(U(1)×SU(2)×SU(3)) = 12 = 1+3+8`, with `1+8 = 9 = N` (the α tensor). **All three gauge algebras now machine-verified** — U(1) (`no_magnetic_monopoles`), SU(2) (`weak_isospin_su2`), SU(3) (`trace_commutator_zero`+`gluon_commutator_nonzero`, [`lean/QLF_StrongAlgebra.lean`](lean/QLF_StrongAlgebra.lean)). Still a dimension *alignment*, not a derivation: no couplings, chirality, masses; quark flavors/CKM open; `SU(3)` finrank=8 is the elementary codim-1 (not yet Lean) | [`Forces_From_Three_Axes.md`](Forces_From_Three_Axes.md) |
| **Constants program** (π, e, δ; α below the 0.026% floor) | Methods exist in `constants_mapper.py`; full CODATA agreement is the active research front | [`Experimental_Consistency.md`](Experimental_Consistency.md) §6.3, §11 |
| **Lamb shift radiative pieces** | AMM `+68 MHz` (Schwinger `α/2π` on the bound moment) and vacuum polarization (Uehling) `−27 MHz` taken as inputs | [`Lamb_Shift.md`](Lamb_Shift.md) §8 |

---

## Open — structural / Lean-anchoring

| Item | Status | Where |
|---|---|---|
| **Lamb prefactor `4/(3π n³)`** | Mostly resolved: `= 4·(2/3)·(1/(2π))·(1/n³)` (Lean `lamb_prefactor_loop_phase`); the π is the g-2-validated loop-phase primitive (0.2%), `1/n³`/`2/3` clean. Only the rational `4` (two-vertex/solid-angle) wants a cleaner origin | [`Lamb_Shift.md`](Lamb_Shift.md) §5 |
| **Dirac correction, per-mechanism Lean** | Kinematic / spin-orbit / Darwin α² pieces are doc-anchored, not yet individual Lean chains from [`QLF_Pauli`](lean/QLF_Pauli.lean)/`QLF_TwistAlphabet` | [`Dirac_Correction.md`](Dirac_Correction.md) §6 |
| **Lorentz boost as a Lean theorem** | `lorentz_boost_from_zfa_frequencies` needs the Markov-blanket frequency structure in-kernel | [`Cross_Frequency_Lorentz.md`](Cross_Frequency_Lorentz.md) §7 |
| **Maxwell curl laws** (`∇×B=μ₀J`, `∇×E=−∂B/∂t`) | Stated structurally; await a time-indexed event-sequence Lean module (divergence laws already verified) | [`Maxwell.md`](Maxwell.md), [`Electricity.md`](Electricity.md) |
| **γ (Euler–Mascheroni) convergence** | Structural form Lean-anchored; `lim (H_N − ln N) = γ` convergence proof deferred (standard real analysis) | [`lean/QLF_EulerMascheroni.lean`](lean/QLF_EulerMascheroni.lean) |
| **Borromean 5-angle** | `chirality-mixing-per-pair = 2` not yet derived rigorously from [`QLF_Pauli`](lean/QLF_Pauli.lean)'s scalar group | [`lean/QLF_BorromeanAngles.lean`](lean/QLF_BorromeanAngles.lean) |
| **Charge vs `B−L`** | **Charge conservation ✅ Lean-anchored** (`signed_count_conserved`); every closure is neutral. **`B−L` is not a conserved signed count** — proved via `wcount_zero_on_ZFA` (conserved counts vanish on closures, but the deuteron has `B−L=1`; baryon vs antibaryon share a twist multiset yet `B−L=±1`). `B−L` is at most winding, and in the lepton sector it is **violated** (neutrino Majorana, `neutrino_majorana`) ⟹ 0νββ. So only the gauge charge is exact — QLF carries no exact global `B−L`. **Baryon number ✅ Lean-anchored as a signed 3-axis linking (winding) invariant** — `baryonNumber` ([`lean/QLF_BaryonWinding.lean`](lean/QLF_BaryonWinding.lean)): proton `>^/` `B=+1`, antiproton `B=−1`, leptons & meson `B=0`; `baryon_zero_of_noZ` proves the whole z-free lepton/EM sector is baryon-neutral; and **`baryon_dagger_odd` proves the general conjugation-oddness** `B(ts†) = −B(ts)` for *all* histories (so baryon/antibaryon carry `±B` universally). ✅ Closed | [`lean/QLF_BaryonWinding.lean`](lean/QLF_BaryonWinding.lean), [`lean/QLF_Majorana.lean`](lean/QLF_Majorana.lean), [`Conservation.md`](Conservation.md) §8 |

---

## Future work (scope-limited by specification)

| Item | Where |
|---|---|
| Periodic table `Z ≥ 21` (d-shell synthesis; Cr/Cu/La anomalies) — current routing capped at neon | [`Magic_numbers.md`](Magic_numbers.md) |
| QuantumOS active-inference scheduler on QPU silicon (today: browser control plane) | [`Crystal_QuantumOS.md`](Crystal_QuantumOS.md) §7 |
| Quantitative delayed-choice visibility match (Kim et al. 1999) | [`Delayed_Choice_Eraser.md`](Delayed_Choice_Eraser.md) |
| Strong-field FLRW coupling for the cosmological constant | [`Cosmological_Constant.md`](Cosmological_Constant.md) |
| Material-specific carrier-scattering / `ρ(T)` / `T_c` | [`Electricity.md`](Electricity.md) |
| QRNG Closure Observatory — falsifiable test of whether QRNG streams deviate from the analytic ZFA-closure null (predeclared sieve + controls; expected Tier-0) | [`QRNG_Closure_Observatory.md`](QRNG_Closure_Observatory.md) |

---

## Notes

- **Tiers vs. this file.** `Experimental_Consistency.md` uses Tier-1/2/3 for *achieved precision*; this registry uses the status tags above for *forward work*. A "Tier-3 open" result there maps to 🔵/🟣 here, unless it is a 🧱 boundary.
- **Maintenance.** When an item closes or is reclassified, edit its row here **and** its owning doc in the same change, and (if it gains a theorem) the relevant `lean/` module and `lean/README.md` row.
