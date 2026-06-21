# CLAUDE.md — Quantum Logical Framework

Project context for Claude Code sessions. Read this before making any changes.

---

## Project overview

**Quantum Logical Framework (QLF)** is a formal proof system machine-verified in Lean 4 across **93 modules with zero `sorry` blocks**. It encodes quantum mechanics and spacetime dynamics using phase-string combinatorics (ZFA — Zero-phase Flux Algebra).

Core claim: *ZFA balance is the selection principle for physical reality.* Every terminating computation is a ZFA string; every ZFA string is symmetric (lies on the critical line). The Church-Turing universe filtered to ZFA-balanced strings is our physical universe.

**Lean is NOT installed locally.** CI (GitHub Actions) is the only way to verify Lean changes. Push to GitHub and wait for CI before reporting success.

---

## 93 active modules

In `lean/`, registered in `lakefile.lean` roots array (in build order). For fuller per-module descriptions + the complete key-theorem lists, see [`lean/README.md`](lean/README.md).

| Module | What it proves |
|---|---|
| `QLF_Axioms` | Types, counting, pruning, ZFA definition; `zfa_implies_critical_line`, `full_prune_invariant`, `single_prune_invariant` |
| `QLF_Combinatorics` | Phase-string generation helpers |
| `QLF_QuCalc` | Phase-generation engine; `find_stable_states_length_even` = C(2n,n); `emergent_blanket_formation` (count-balance preserved under concatenation) |
| `QLF_Universality` | Every terminating computation IS a ZFA string (Church-Turing); `qlf_universality` |
| `QLF_Critical_Line` | ZFA → symmetry bridge; `riemann_zfa_critical_line` |
| `QLF_Spectral` | Hermitian spectral projectors; Hilbert-Pólya bridge; `toSpectralMode_hermitian`, `spectral_symmetric_eq_scalar_id` |
| `QLF_Riemann` | Riemann hypothesis program; `critical_line_forcing`, `riemann_hypothesis_in_qlf` |
| `SpacetimeDynamics` | Pauli-basis 2×2 Hermitian matrices; `Form.toMatrix_adjoint` |
| `RhoQuCalc` | ρ-process algebra; `rho_process_always_zfa`; `eval_dagger` |
| `ZFAEventDynamics` | ZFA event dynamics; spacetime acceleration; `zfa_dynamics_drive_acceleration` |
| `AgeOfUniverse` | Cosmological age from ZFA event rate; `age_is_finite_and_positive` |
| `ER_EPR_QLF` | Entanglement-geometry axioms (speculative, not used elsewhere) |
| `PauliExclusion` | Fermionic statistics via matrix commutator; `pauli_exclusion`, `fermi_nonzero_example` |
| `StringTheoryQLF` | String modes; C(2n,n) degeneracy; `string_mass_spectrum` |
| `MTheoryQLF` | M-theory; S/T-duality; 11D; `m11d_zfa_stable` |
| `BraKetRhoQuCalc` | Bra-ket ↔ RhoQuCalc correspondence; the Σ₈ τ-algebra and its weak-isospin su(2) closure; `bra_ket_always_balanced`, **`weak_isospin_su2`** (`[τᵢ,τⱼ]=−2εᵢⱼₖτₖ`, `Q₈⊂SU(2)`) |
| `QLF_FreeEnergy` | Per-event ΔF = -log 2 at half-spin ZFA closure; `zfa_closure_minimizes_free_energy`, `binary_kl_uniform_lt_log_two` |
| `QLF_Pauli` | 4-element Pauli scalar group {±I, ±iI}; group closure + `pauli_closed_of_admissible_zfa` |
| `QLF_TwistAlphabet` | 8-twist alphabet with σ-matrix mapping; `hermitian_pair_is_pauli_scalar`; `concat_pairs_is_pauli_scalar`; **`count_balanced_pauli_closed`** (count balance ⟹ Pauli closure for ALL histories — via `nf_decomp` + `(ZMod 2)²` axis-parity bridge; the keystone) |
| `QLF_VacuumAlignment` | Vacuum-alignment TOE-completing principle (KL saturation ≡ ZFA closure, per-event + trajectory); `vacuum_alignment_selects_zfa`, `global_alignment_selects_zfa` |
| `QLF_RhoProcessBridge` | Every constructible RhoProcess's event trajectory saturates the cumulative info bound; `rho_process_alignment_saturates` |
| `QLF_LocalClock` | A depth-`R` Markov blanket IS a local clock (Kitada local time); `markov_blanket_local_clock`, `local_clock_tick_is_log_two` |
| `QLF_EinsteinGeometricFactor` | Einstein `8π = 4π·2` (boundary solid angle × Hermitian-pair degeneracy); `einstein_geometric_factor_eight_pi` |
| `QLF_SubstrateLightSpeed` | `c = L_Planck/τ_Planck` via ρ-cancellation → local Lorentz invariance; `substrate_light_speed_from_cosmic_ratio`, `local_light_speed_invariant` |
| `QLF_FineStructureSubstrate` | α = 1/137 from substrate combinatorics, zero free params — the IR / fully-rendered-3D value; `alpha_QLF_eq`, closed form `α(d)=1/(128+d²)` (`alpha_at_dim_closed_form`), `only_3d_substrate_gives_137` (2D→1/132, 4D→1/144, 5D→1/153), and `no_cosmological_drift_of_alpha` (α has no time argument — scale/time-invariance is obvious in QLF). **Canonical doc: `Alpha.md`** |
| `QLF_LenzMassRatio` | `m_p/m_e = 6π⁵ = \|S₃\|·π⁵`, 0.002%; `mass_ratio_QLF_eq` + counterfactuals |
| `QLF_PionMassRatio` | Charged-pion/electron ratio `m_π±/m_e = \|S₂\|/α = 2/α = 274` (`pion_electron_ratio_eq`), vs measured 273.1 (0.3%); proton↔pion consistency `6π⁵/(2/α) = 3π⁵/137 ≈ 6.70` (`proton_pion_ratio_eq`). Structural reading of Nambu's `m_π ≈ 2m_e/α` via QLF's derived α: `\|S₂\|=2` (two quarks) solid, `1/α` (exposed vs proton's hidden-`π⁵` chirality) is the open mechanism (`pion_mass_ratio_in_progress`). See `Pion_QLF.md` |
| `QLF_QuantumBlackHole` | Every hadron (meson + baryon) is a Markov-blanket quantum black hole. The **Compton–Schwarzschild crossing** `1/μ = 2μ ⟺ μ²=1/2` (`compton_eq_schwarzschild_iff`) — a sub-Planck hadron lives on the Compton side (`sub_planck_compton_gt_schwarzschild`), so its horizon is the Planck blanket, not a Schwarzschild horizon. Horizon area law `S=4πR²log2` (`hadron_horizon_entropy_eq`, reuses `holographic_entropy_eq`); mass `m=1/R` (`lighter_is_deeper` ⟹ pion = deepest hadronic horizon); meson `B=0` vs baryon `B≠0` (`pion_meson_horizon`/`proton_baryon_horizon`, reuses `baryonNumber`). Coherence: hidden-vs-exposed chirality fixes mass factor (`π⁵` vs `1/α`) AND horizon fate (stable vs decay = Hawking evaporation). **Honest scope:** unification + thermodynamic reading, NOT a mass derivation (`R` is an input; `pion_mass_ratio_in_progress`). See `Hadron_BlackHoles.md` |
| `QLF_DarkMatter` | **Dark matter = denser logic near masses** (quantifies `DarkMatter.md`). Crossover acceleration `a₀ = cH₀/(2π) = c²/(2π R_H)` on the **same Hubble horizon `R_H` as `Ω_Λ = log 2`** (`mond_acceleration_horizon_form`), ≈1.05e-10 vs measured 1.2e-10 (~13%). Transition radius `σ=√(GM/a₀)` where Newton meets the floor (`mond_radius_accel`); dense/sparse crossover `a₀<GM/r² ⟺ r²<GM/a₀` (`newtonian_dominates_iff`) — dense interior = Newton/GR (Mercury, quantum black holes), sparse exterior = apparent dark matter; baryonic Tully–Fisher `v⁴=GMa₀` (`tully_fisher_flat`); Gaussian **MRE** congestion bump (`gaussian_logic_density`). DM↔DE = expand/contract on one horizon. **Rotation curves — derived + blind-tested (#77 CLOSED):** the dense↔sparse interpolation is the **closure-balance RAR** `g_obs²=g_bar·(g_obs+a₀)` (closure needs both the local AND cosmological condition — a ZFA conjunction; `radialAccel_self_consistent`, with the Newtonian `radialAccel_newtonian` and geometric-mean/Tully–Fisher `radialAccel_ge_geometric_mean` limits exact). The **blind SPARC benchmark** (`SPARC.md`, 147 curated galaxies, baryonic-only, SHA-256-sealed, zero per-galaxy tuning) reproduces the galactic **Radial Acceleration Relation parameter-free** at the observational floor — `0.133 dex` scatter, **zero** offset, with the *derived* `a₀=cH₀/2π` (= best-fit MOND; vs Newton failing ×2.7; vs NFW needing **294** halo params for the same data). **Honest scope:** the `1/2π` prefactor is **confirmed** by the SPARC fit at the local `H₀` (`a₀=cH₀/2π` at `H₀=72.9`, <1%; the old ~13% was a wrong-form comparison) — residual = the Hubble tension; open: a *first-principles* `2π` + the form as the *unique* ν. See `DarkMatter.md`, `SPARC.md` |
| `QLF_HorizonTemperature` | **Unruh/Hawking/de Sitter from one substrate relation.** Every horizon temperature is the Unruh master `T = ℏa/(2πck_B)` (`unruh_temperature`) at the right acceleration, the `2π` being QLF's loop phase (same as `g−2 = α/2π`). Hawking = at surface gravity `κ=c⁴/(4GM)` ⟹ `T=ℏc³/(8πGMk_B)` (`hawking_temperature_eq`; the `8π` = loop `2π`×the `4` in `κ`, the same `8π` as Einstein `8π=4π·2`); de Sitter = at `cH₀` ⟹ `T=ℏH₀/(2πk_B)` (`desitter_temperature_eq`); both literally the master relation (`hawking_is_unruh`/`desitter_is_unruh`). Dark-sector tie: `a₀ = cH₀/(2π) = hubble_acceleration/(2π)` (`mond_accel_is_hubble_over_loop`) — one Hubble horizon + one `2π` behind `Ω_Λ`, the horizon T, and dark matter. **Honest scope:** algebraic unification + loop-phase identification, not a from-scratch QFT-in-curved-spacetime derivation. See `Gravity_From_Delay.md` §5.1 |
| `QLF_BorromeanAngles` | The 5-angle count `5 = 3 + 2` (Jacobi internal + chirality-mixing); `total_angular_DOF_eq_five`, `matches_lenz_hidden_chirality_angles` |
| `QLF_EulerMascheroni` | γ as the harmonic excess `H_N − ln N` of the ZFA ensemble; `gamma_QLF_structural` (structural form; convergence proof deferred) |
| `QLF_RiemannZeta` | Substrate ↔ ζ bridge: `γ_QLF` = ζ's Laurent constant at `s=1`; `zeta_laurent_constant_eq_gamma_QLF`, `rh_proof_in_progress` |
| `QLF_RiemannMRE` | **MRE bridge** — a constructive scaffold for the Riemann boundary. `Z_QLF = (1/(1−5x)+1/(1−3x))/2` concrete with verified singularities at `1/5`,`1/3` (`Z_QLF_pole_fifth/third`); MRE saturation grounded in `binary_kl` (`mre_saturation_only_at_closure`, reusing QLF_FreeEnergy), with the saturating prior `1/2` = `critical_line_real_part` (`mre_prior_is_critical_line`). The bare `spectral_hilbert_polya` is refined into `MRE_bridge` (+ `zero_is_mellin_singularity`), giving `riemann_hypothesis_in_qlf_via_MRE`. Residual Mellin↔ζ correspondence = WKL₀ boundary; `rh_mre_proof_in_progress` |
| `QLF_DiracCorrection` | Hydrogen fine structure (α² kinematic/spin-orbit/Darwin); `hydrogen_spectrum_from_h_and_m_e`, `three_mechanisms_alpha_squared` |
| `QLF_LambShift` | Lamb-shift prefactor `4/(3πn³) = 4·(2/3)·(1/2π)·(1/n³)`; `lamb_prefactor_loop_phase`, `lamb_shift_substrate_summary` |
| `QLF_GMinusTwo` | Electron `g−2`: `a_e = α/2π` (Schwinger), 0.2%; `a_e_QLF_eq_schwinger`, `g_factor_QLF_eq` |
| `QLF_GravityFromDelay` | Newton's law + `G = L_P²c³/ℏ` from holographic delay; `newton_exponent_only_3d_matches`, `gravity_substrate_summary` |
| `QLF_PlanckScale` | **The Planck length is the closure floor *by construction*, not a posited input** — closes the "substrate granularity is a free input" flaw. Reusing the Compton–Schwarzschild crossing (`QLF_QuantumBlackHole`): a closure stays coherent (horizon doesn't engulf its Compton extent) iff sub-Planck `μ²<1/2` (`coherent_iff_subplanck`, reusing `sub_planck_compton_gt_schwarzschild`); every coherent closure has Compton length `>√2` (`planck_length_floor`) — **no coherent closure below the Planck length** (confine tighter → horizon larger than the blanket → can't close); the floor is the unique self-dual point `μ²=1/2` (`planck_self_dual`, reusing `compton_eq_schwarzschild_iff`). So given QLF's own emergent gravity + blanket closure, the substrate *is* granular at the Planck scale by construction. **Honest scope:** the Planck *scale* (dimensionless `μ²=1/2`) follows by construction; the SI *value* in metres is a unit convention (not a physics question); matter-depth-above-floor = the `14π` hierarchy (`QLF_AlphaS`), tracked separately. See `Planck_Scale.md` |
| `QLF_LoopQuantumGravity` | **QLF's substrate is a spin network of half-spin (j=½) ZFA closures** — the Loop Quantum Gravity correspondence. Reusing `QLF_GravityFromDelay`'s holographic entropy + `QLF_Spin`'s `su(2)` closure: each horizon puncture = one half-spin closure carrying `log 2` (`puncture_is_log_two`, = `per_event_entropy` = the MRE/`gaugeMassGap` quantum); a horizon of `n` punctures carries `n·log 2` (`horizonEntropy_eq`); and QLF's holographic entropy *is* the puncture sum `S=4πR²log2` (`lqg_horizon_is_holographic`). So the LQG black-hole entropy count (dominant j=½ punctures, each `log 2`) = QLF's `4πR²`-half-spin-closure horizon, with the **Barbero–Immirzi parameter fixed by construction** by the `log 2`-per-half-spin-puncture (no free `γ`); background independence = synthesized spacetime. **Honest scope:** anchors the entropy-count correspondence, NOT the full `√(j(j+1))` area-operator spectrum or the LQG Hamiltonian/spin-foam dynamics (`lqg_correspondence_in_progress`). See `LQG_QLF.md` |
| `QLF_MercuryPerihelion` | Perihelion advance 42.99″/century (0.03%); `mercury_perihelion_substrate_summary` |
| `QLF_CosmologicalConstant` | `Ω_Λ = log 2` (1.2%), closing the 10¹²² vacuum catastrophe; `only_2_gauge_matches_observed_Omega_Lambda`, `cosmological_constant_substrate_summary` |
| `QLF_PrimordialMarkovBlanket` | Markov blankets as Fuller geodesic spheres; icosahedral closure → E₈ via McKay; `mckay_2I_E8_anchor`, `E8_dimension_eq`, `primordial_blanket_euler` |
| `QLF_Koide` | Koide `Q = 2/3` follows by construction from `N=3 ∧ A²=2` ⇒ `m_τ` to 0.006%; `koide_two_thirds`, `koide_three_phase` |
| `QLF_Generations` | **Three fermion generations = the 3 spatial axes** (`num_generations = substrate_spatial_dimension = 3`, `num_generations_eq_three`). The *same* `3` behind Koide (N=3 phases), colour SU(3), and α (`N=9=3²`): `three_axis_signature`. The 3 generations realized concretely as Koide's three 120° phases `(1,−½,−½)` ⇒ `Q=2/3` (`three_generations_satisfy_koide`, reuses `koide_two_thirds`); 2D/4D counterfactuals (`only_3d_gives_three_generations`). **Honest scope:** reduces "why 3 generations" to "why 3 spatial dimensions" — **derived** (not deferred): 3 = the minimal dimension in which any relational/causal graph renders faithfully (every finite graph embeds crossing-free in ℝ³; 2D fails), so space (the closure graph's rendering) is minimally 3D (`SpaceTime.md` §3a, `QLF_ReachableEvent`); Newton `1/r²`, magic numbers, α=N=3² are cross-checks (`generations_from_three_axes_constructive`) |
| `QLF_WeinbergAngle` | **Weak mixing angle `sin²θ_W = 3/8` at the unification scale** = spatial/alphabet fraction (`sin2_weinberg_substrate_eq`) = the SU(5) GUT normalization; the third constant from the same 6+2 split as α (`N=3²`) and `Ω_Λ` (gauge `2/8`), packaged in `electroweak_substrate_signature`. Tree-level relations: custodial `ρ=1` (`rho_one_of_mass_relation`) and on-shell `cos²θ_W=(M_W/M_Z)²` (`onshell_weinberg`). **Honest scope:** `3/8` is the *unification* value, NOT the measured `0.231` at `M_Z` — the RG running is the open renormalization sector, absolute `W/Z`/`G_F` need the Higgs VEV (`weinberg_running_in_progress`). See `Weak_Force.md` §2 |
| `QLF_RunningCouplings` | **One-loop RG structure + substrate UV-finiteness.** `1/α(t) = 1/α₀ + (b/2π)·t` (`inv_coupling`), the `2π` = loop phase. `asymptotic_freedom` (b>0, QCD coupling vanishes at high E), `infrared_growth` (b<0, QED screening), `landau_pole_location` (`1/α=0` at `t*=−(1/α₀)·2π/b` — *located but cut off by the substrate's discrete UV floor*: no continuum divergence — the "continuum = UV catastrophe" thesis). **Honest scope:** anchors the RG structure + UV-finiteness, NOT the β-coefficients (need full matter content) or the GUT scale, so `sin²θ_W 3/8→0.231` is consistent-with not derived (`running_couplings_structural`). See `TheContinuum.md` §3.1 |
| `QLF_GravitationalWaves` | **What the substrate fixes about GWs.** A GW is a massless (gauge-fold-free) transverse ripple of synthesized spacetime ⇒ propagates at `c = L_Planck/τ_Planck` (`gw_speed_eq_planck_ratio`; GW170817 `|v_GW−c|/c<10⁻¹⁵`). Graviton is spin-2 = four half-spins = two photon-worths (`graviton_integer_spin`, reuses `boson_even_pairs`); 2 transverse polarizations from masslessness, not `2J+1=5` (`massless_two_polarizations`). **Honest scope:** the wave equation `□h=0` + quadrupole luminosity are NOT derived — they need the dynamical substrate metric (same gap as the full Einstein field equations); `gravitational_waves_in_progress`. See `GR_Schwarzschild.md` |
| `QLF_FlavorMixing` | **CKM/PMNS parameter count + Kobayashi–Maskawa.** An `N×N` unitary mixing matrix has `N(N−1)/2` angles (`mixing_angles`) + `(N−1)(N−2)/2` CP phases (`cp_phases`); QLF's exactly-3 generations give **3 angles + 1 CP phase** (`substrate_mixing_parameters`). KM: CP needs ≥3 generations — 0 phases for N=1,2; 1 for N=3 (`cp_requires_three_generations`); the same `3` behind Koide/SU(3)/α. **Honest scope:** anchors the counting + CP condition, NOT the angle values (Yukawa sector open, like the Koide δ); quark-small/lepton-large is a structural reading on the hidden/exposed-chirality axis (`flavor_mixing_in_progress`). See `Standard_Model.md` §4.2 |
| `QLF_CondensedMatter` | **Quantum Hall resistance from α + Cooper pairs as bosons.** von Klitzing constant `R_K = h/e² = Z₀/(2α)` (`von_klitzing`); with QLF's `α=1/137`, `R_K = Z₀·137/2 ≈ 25806 Ω` vs measured 25812.807 (**0.026%**, the α error) (`von_klitzing_substrate`); integer-QHE plateaus `R_xy = R_K/ν` (`hall_resistance`). Cooper pair = two half-spins = an even pair fold = boson (`cooper_pair_boson`, reuses `boson_even_pairs`). **Honest scope:** anchors `R_K` + integer-QHE + Cooper-pair-boson, NOT the BCS gap equation, fractional QHE/anyons, or topological bands (`condensed_matter_in_progress`). See `Electricity.md` §6–§7 |
| `QLF_CosmicInflation` | **Inflation (past) + gravity (present) as one event duality.** Each event expands the future + contracts locally (`event_duality_balanced`). Inflation and dark energy are the **same `w=−1` event-synthesis field** at two energy scales — no inflaton (`inflation_and_dark_energy_same_field`, reuses the verified `zfa_dynamics_drive_acceleration`); Friedmann `H∝√V` makes the early high-`V` epoch inflate (`higher_energy_faster_expansion`). Temporal vantage: past = high-`V` expansion (inflation), present-local = contraction (gravity), future = residual `w=−1` (dark energy). **Honest scope:** anchors the duality + √-monotonicity + shared-`w=−1` unification, NOT the inflation observables (e-folds, `n_s`, `r`) or `f(t)` (`cosmic_inflation_in_progress`). See `Curvature.md` §8 |
| `QLF_StrongCP` | **`θ̄ = 0` without an axion.** The strong-CP θ-term is a CP-odd topological winding; QLF proves every CP-odd (annihilation-odd) signed count is zero on every ZFA closure (`cp_odd_winding_zero_on_closure`, `theta_zero_on_closure`, reusing `wcount_zero_on_ZFA` + `chargeWeight_annihilationOdd` from `QLF_BMinusL`). So `θ̄=0` holds on every physical state — no axion, no fine-tuning (ZFA closure does the Peccei–Quinn job). **Honest scope:** the QCD θ-vacuum↔QLF-winding identification is structural (`strong_cp_in_progress`). See `CP-Violation-and-Chirality.md` §4a |
| `QLF_Baryogenesis` | **The three Sakharov conditions are met ⟹ matter excess is generic.** Matter/antimatter carry opposite baryon winding (`matter_antimatter_opposite`, reuses `baryon_dagger_odd`); B not conjugation-invariant (proton `B=1` vs antiproton `B=−1`). B-violation (winding + Majorana `B−L`), C/CP violation (chirality engine + `QLF_StrongCP`), out-of-equilibrium (`QLF_CosmicInflation` expansion) all hold. **Honest scope:** the *magnitude* `η_B ≈ 6×10⁻¹⁰` is open, as in the SM (`baryogenesis_in_progress`). See `CP-Violation-and-Chirality.md` §4b |
| `QLF_Nucleosynthesis` | **Primordial helium fraction.** Every surviving neutron → deepest light closure ⁴He, so `Y_p = 2r/(1+r)` (`helium_fraction`); freeze-out `r=n/p=1/7` ⟹ `Y_p=1/4` (`helium_fraction_one_seventh`), matching observed 0.247; counterfactual `r=1` ⟹ `Y_p=1` (`helium_fraction_equal_np`). **Honest scope:** does NOT derive `r` (needs n–p splitting + `G_F`, open), D/⁷Li abundances, or the CMB power spectrum (`nucleosynthesis_in_progress`). See `Fusion.md` §7a |
| `QLF_MassSpectrum` | **The absolute spectrum is one scale, exponentially generated.** (1) Every mass = one proton scale `m_p` × a verified ratio (`spectrum_one_scale`; `m_e=m_p/6π⁵` `electron_mass_from_proton_eq`, reuses `mass_ratio_QLF` + `proton_pion_ratio_eq`) — the SM's ~13 mass params collapse to ONE absolute input. (2) That scale is **dimensional transmutation**: the log running of the strong coupling (`QLF_RunningCouplings`) hits confinement after `exp(2π/(bα))`; `log_transmuted_hierarchy` (`ln R = 2π/(bα)`) gives `b=7, α_s≈0.02 ⟹ ln R ≈ 44.9 ≈ ln(M_P/m_p)=44.0` — the 10¹⁹ hierarchy, no fine-tuning; `weaker_coupling_larger_hierarchy`. **Honest scope:** reduces spectrum to one scale + shows it exponentially natural; does NOT derive the value (`b`, `α_s`, calibration = the combinatorial `R_e≈2.4×10²²` count, open; `mass_spectrum_in_progress`). See `Per_Qubit_Mass_Quantum.md` §3.3a |
| `QLF_BetaFunction` | **QCD `b₀ = 7` from the substrate.** The one-loop β-coefficient `b₀ = 11N_c/3 − 2n_f/3` with `N_c = color_count = substrate_spatial_dimension = 3` (axes) and `n_f = flavor_count = 2·num_generations = 6` (3 generations × 2 flavours) ⟹ `b₀ = 7` (`beta_coefficient_eq_seven`, `substrate_qcd_counts`); antiscreening `11>4` ⟹ `b₀>0` = asymptotic freedom (`asymptotic_freedom_from_substrate`). Feeds `QLF_MassSpectrum`'s `ln R_p = 2π/(7 α_s)`. **Honest scope:** QLF fixes the counts `N_c=3`, `n_f=6`; the `11/3`,`2/3` one-loop structure is standard group-theory input; `α_s`+calibration open (`beta_function_in_progress`). See `TheContinuum.md` §3.1 |
| `QLF_Anyons` | **Fractional statistics from a 2D braiding phase.** 3D forces `±1` (the SU(2)→SO(3) double cover, `QLF_Spin`: boson/fermion); 2D allows a continuous braiding phase `e^{iθ}` (`exchange_phase`) — anyons: `boson_phase` (θ=0→+1), `fermion_phase` (θ=π→−1), `double_braid` (`(e^{iθ})²=e^{2iθ}`), `fermion_double_trivial` (the 3D constraint); semion (π/2) + Laughlin ν=1/m (θ=π/m). **Honest scope:** anchors the braiding algebra + the 3D-vs-2D contrast, NOT the FQHE filling fractions or the Laughlin wavefunction (`anyons_in_progress`). Completes `QLF_CondensedMatter`'s open anyon flag |
| `QLF_MuonG2` | **Placing the muon `g−2` honestly.** Leading `a_μ = α/2π = a_e` (universal one-loop QED, mass-independent; `a_mu_leading_eq_a_e`, reuses `QLF_GMinusTwo`) to ~0.6%. The muon's `(m_μ/m_e)² ≈ 42753` hadronic-sensitivity amplification (`hadronic_sensitivity_value`) is *why* the discrepancy is a muon effect (invisible in the electron). **Honest scope:** the residual is the hadronic-vacuum-polarization sector (QLF's open hadronic frontier, pion-dominated) and the experimental anomaly is **unsettled** (data-driven ~5σ vs lattice/CMD-3 ~1σ) — QLF claims no new-physics anomaly (`muon_g2_in_progress`). See `g_minus_2.md` §4a |
| `QLF_AlphaS` | **The hierarchy from one integer.** Closes `QLF_MassSpectrum`'s last input: posit `α_s(substrate) = 1/b₀²` (`substrate_alpha_s`) — consistent with the measured running (`1/α_s(M_Planck)≈52≈b₀²=49`, ~7%) — and the dimensional-transmutation hierarchy collapses to a **pure integer**: `ln R_p = 2π/(b₀·α_s) = 2π·b₀` (`log_hierarchy_pure_integer`). With substrate `b₀=7`, `ln R_p = 14π ≈ 43.98` vs measured `ln(M_P/m_p) ≈ 44.01` — **0.07%** (`hierarchy_log_eq_fourteen_pi`). So the absolute mass scale (and the whole spectrum) follows from the single integer `7` (=`N_c=3`,`n_f=6`). **Honest scope:** `α_s=1/b₀²` is a running-consistent posit (not derived); value-level match ~3% (Planck-mass calibration; `alpha_s_substrate_in_progress`). See `Per_Qubit_Mass_Quantum.md` §3.3b |
| `QLF_EinsteinEquations` | **The Einstein equations as the substrate's equation of state (Jacobson 1995).** The full field equations follow from `δQ = T δS` on every local horizon — and QLF supplies *both* inputs from its own substrate: the area law `S=4πR²log2` (`QLF_GravityFromDelay`) and the Unruh temperature (`QLF_HorizonTemperature`). This fixes the coefficient `8πG = 2π/η` with entropy density `η=1/4G` (`einstein_coupling_from_thermodynamics`), the same `8π=4π·2` of `QLF_EinsteinGeometricFactor` (`einstein_coupling_geometric`); the integration constant `Λ = Ω_Λ = log 2`. **Kitada tie:** Jacobson's *local* Rindler horizon IS the Markov-blanket / Kitada local clock (`markov_blanket_local_clock`), so the Einstein equation of state is the Clausius relation at each local clock and `Λ = log 2` is the local-clock tick (`local_clock_tick_is_log_two`). **Honest scope:** anchors the coefficient + thermodynamic skeleton, NOT the full tensor derivation (local Rindler construction, Raychaudhuri focusing, general covariance need differential geometry QLF's Lean lacks — `einstein_equations_in_progress`). See `Einstein_Equations.md`, `Kitada_Local_Time_GR.md` §5.2, `GR_Schwarzschild.md` |
| `QLF_Fusion` | **The β⁺ keystone — joining two Markov blankets needs distinguishability.** The pp-chain's first step `p+p→²H+e⁺+ν` is fusion AND β⁺ at once, and the insulator proof says why it must be: two *identical* proton blankets have **no** bound fermionic channel (`diproton_pauli_blocked`: `fermi_antisym p p = 0`, reusing **`pauli_exclusion`** — no diproton, ²He unbound), while a *distinguishable* `p+n` Hermitian-pair channel **closes** to identity (`deuteron_channel_closes`, reusing `opposite_spin_singlet_closes`). Packaged as **`pp_join_requires_distinguishability`** (the conjunction): the first blanket-join requires a β⁺ `u→d` step to make the pair distinguishable — the weak force is the precondition for fusion, and its rarity is why the Sun burns slowly. **Honest scope:** the necessity is owned (reuses two verified theorems); the β⁺ *rate* (`G_F`) is open (`fusion_weak_rate_in_progress`). See `Fusion.md` §3a, `SEX.md`, `Beta_Decay_Neutrino_Nature.md` |
| `QLF_InfoSynthesis` | **Information synthesis as disjunctive (OR) closure.** A ZFA closure takes the *random signal* of the possibility stream (`expand_generation`, every admissible history) and **closes on an OR condition**: `List.any verify` is the Boolean OR-fold `⋁_s verify s` over the stream. `disjunctive_closure` (`any verify = true ↔ ∃ s ∈ generated, verify s` — closing on the OR *is* the existential); `disjunct_count_eq_central_binomial` (the OR has exactly `C(2n,n)` satisfying disjuncts, reusing `realized_count_eq_central_binomial` from `QLF_PvsNP`); `closure_always_fires` (`C(2n,n)≥1`, so the OR is always satisfiable — synthesis never stalls). The realized closure synthesizes one bit `ΔF=−log2` (`QLF_FreeEnergy`). **Honest scope:** the disjunctive *structure* is anchored (no new axioms); the log-2 synthesis (`QLF_FreeEnergy`) and the OR-looks-lossy-vs-unitarity tension — resolved holographically as a *screened boundary-OR* (which-disjunct-fired coarse-grained out, bulk retains it) — stay prose (`info_synthesis_disjunctive`). See `MRE.md`, `Active_Inference_Mathematics.md`, `P_vs_NP_QLF.md` |
| `QLF_MuonCatalysis` | **Lepton-catalyzed fusion is QLF cold fusion (rate, not necessity).** Muon-catalyzed fusion (μCF) is the *legitimate* cold fusion — room-temperature, Frank/Sakharov/Alvarez 1956, distinct from Fleischmann–Pons — reproduced **in agreement with the SM**. QLF reading: "cold" = crossing the §2 critical-density threshold by **generation-depth** (a deeper-generation completer shrinks the blanket, raising `ρ`) not temperature; **α-sticking** = the muon blanket captured into the deep doubly-magic ⁴He closure. The one structural claim QLF owns is **catalysis touches rate, not necessity**: `catalysis_preserves_necessity` (the identical-pair Pauli block is catalyst-independent — no completer makes two protons distinguishable, only a real `u→d` does) and `catalyzed_join_still_requires_beta` (the full §3a keystone holds with any catalyst, reusing `pp_join_requires_distinguishability`). **Honest scope:** D-T not p-p (catalysis boosts overlap, not the weak `G_F`); τ⁻ too short-lived to catalyze (depth↔lifetime trade-off); the muon economy (~2× energy-negative: production cost + α-sticking) is SM/engineering, not a QLF gap (`muon_catalysis_in_progress`). See `Fusion.md` §3b |
| `QLF_LoopClosure` | **The closure machine vs the `2π` rendering** (the dependency direction; issues #59/#71/#73, spirit of #66/#37). Answers "when QLF writes `2π`, is it the machine or the display?" by separating three objects: the **closure operation** `phase k N = k % N` is finite, decidable, RCA₀, **`Real.pi`-free** (`phase_full_cycle`: a full cycle closes; `phase_lt`: finite-alphabet residue); the **continuum `2π`** enters only in `renderAngle = 2π·k/N` and is *recovered* as the rendered full cycle (`render_full_cycle`, `render_one_cycle`), not imported; `τ_ZFA = 2·π_QLF` named (`tau_is_two_pi_QLF`). So the machine is `% N`; `2π` is the display. **Key reframing (per Jim):** `π` is a *computable* real (RCA₀) — precision was never the issue (the #37 audit: ≤15 digits suffice); only the dependency direction needed tidying. **Open:** which physical `N` a given loop closes on (`loop_closure_value_in_progress`). See `TheContinuum.md`, `Continuum_Choice_Fallacy.md` |
| `QLF_ReachableEvent` | **Closure-reachability as a pre-geometric Lean object** (issues #63, #72). An `Event = List α` is a finite ZFA history (no coordinates); `reachable A B := A <+: B` (history-extension, **no spacetime primitive**) is a **partial order / causal set** (`reachable_refl`, `reachable_trans`, `reachable_antisymm` — Bombelli–Sorkin). `futureCone A = {B | reachable A B}` is the set the continuum **light cone renders** (`futureCone_subset`). **Answers #72** ("what drives closure succession *before* time?"): the reachability partial order is the pre-temporal driver — it exists with no time coordinate; time is its rendered total-order read-out. **Open:** the order→metric reconstruction (the Causal-Set continuum step) + binding `reachable` to `full_zeno_prune` (`light_cone_rendering_in_progress`). See `SpaceTime.md`, `TheContinuum.md` |
| `QLF_SU5` | **The `5̄⊕10` generation as the antisymmetric content of QLF's `3⊕2`.** Follow-on to `QLF_WeinbergAngle`'s `sin²θ_W=3/8`. One generation = `5̄⊕10 = 15` Weyl fermions = the rank-≤2 antisymmetric tensor content of the SU(5) fundamental `5`, which QLF *identifies with its own split* `5 = colour(3) ⊕ weak(2)` — the same `3+2` behind `α` (N=9=3²), `Ω_Λ` (2/8), `sin²θ_W` (3/8). Decomposition (`ten_decomposition`, `ten_pieces`): `5̄=3̄⊕2` (`d^c`, lepton doublet); `10=Λ²3⊕(3⊗2)⊕Λ²2 = u^c⊕Q⊕e^c = 3+6+1`. `generation_eq_fifteen`; **15 not SO(10)'s 16** (`so10_eq_sixteen`), matching the Majorana neutrino (no light Dirac `ν_R`); antisymmetry = Pauli. **Honest scope:** anchors the *counting + group-theoretic decomposition under the `5=3⊕2` identification*, NOT hypercharges/chirality/per-field twist map (`su5_generation_content_in_progress`). QLF reproduces SU(5)'s wins (3/8, charge quantization, the 15) from the substrate + explains no-proton-decay (baryon winding), without a GUT embedding. See `Forces_From_Three_Axes.md` §5a |
| `QLF_CausalInterval` | **Number↔volume — the curvature side of the Einstein equations begins.** `QLF_EinsteinEquations` anchored the coefficient (`8πG=2π/η`, `Λ=log2`); the *tensor/curvature* side is **not** generic missing diff-geo but the **causal-set order→metric program** (Sorkin/Benincasa–Dowker) on QLF's causal set (`QLF_ReachableEvent`). First rung anchored: the **causal (Alexandrov) interval** `causalInterval A B = {C \| A≤C≤B}`, the **number↔volume** `intervalVolume A B = \|B\|−\|A\|+1` (CST's counting-measures-volume = the Markov-blanket depth difference = Kitada clock-tick count), endpoints-in-interval, and **proper-time additivity along a causal chain** (`intervalVolume_additive` — the discrete seed of the line element). Reuses `QLF_ReachableEvent`, no new axioms. **Honest scope:** the interval *cardinality*=volume, the discrete d'Alembertian→Ricci (Benincasa–Dowker), and the continuum limit to `G_μν=8πG T_μν` stay the named open step (`einstein_curvature_in_progress`) — a concrete CST program, not a missing toolbox. Further rungs: `causalInterval_eq`/`interval_isChain` (a single-history interval is a flat **chain**, so curvature lives in the *branching*); `layer`/`layer_unique` (the **Benincasa–Dowker causal layers**; flat substrate = singleton layers = 1D, `R=0`). See `Einstein_Equations.md` §6a |
| `QLF_CausalDimension` | **Dimension from combining histories (number↔volume reads the dimension).** A single history is a 1-D chain (`chainVolume d = d+1`, **injective** — one interval per volume = singleton layers); two histories combine by the **product order** into a 2-D causal diamond = `1+1` Minkowski in light-cone coords, `diamondVolume m n = (m+1)(n+1)` = **product** of the chain volumes (`diamond_eq_product`), and **many-to-one** (`diamondVolume_collision`: `1×1`, `0×3`, `3×0` all have volume 4 = layer multiplicity / growth). So combining histories raises the dimension = the number↔volume scaling exponent (Myrheim–Meyer), the same branching that renders into 3 spatial dims (`SpaceTime.md` §3a) and whose BD layer-growth is the Ricci scalar — **dimension and curvature are one phenomenon**. Reuses `QLF_CausalInterval`, no new axioms. **Honest scope:** 2-D (product-of-two-chains) exact; `d≥3`, the Myrheim–Meyer limit, the literal product-interval count, and generic-graph curvature open (`causal_dimension_in_progress`). See `Einstein_Equations.md` §6a |
| `QLF_GaugeUnification` | **One force, three projections — EM is the abelian limit.** Completes the "weak/strong are EM from different 3-axis projections" reading (`Forces_From_Three_Axes.md` §3a) with the crisp form: **EM = the abelian gauge sector** (the Pauli scalar group commutes, `em_gauge_abelian` reusing `QLF.PauliScalar.mul_comm`) ⟹ massless long-range photon, unbroken `U(1)`; **weak & strong = non-abelian projections** (`strong_nonabelian` = `gluon_commutator_nonzero`; `weak_isospin_su2`) ⟹ self-interacting, confined/massive. So the abelian/non-abelian split **is** the massless-photon-vs-massive-W/Z split (`gauge_unification_signature`); electroweak breaking = the **logical-density threshold** below which the blanket confines the non-abelian projections (Higgs = gauge-fold delay, `m=1/R`), the weak projection *catalyzing* because it re-projects the blanket; `sin²θ_W=3/8` the projection ratio. Reuses `QLF_Pauli`+`QLF_StrongAlgebra`, no new axioms. **Honest scope:** couplings, W/Z mass values (Higgs VEV), RG running, symmetry-breaking dynamics open (`gauge_unification_in_progress`). See `Forces_From_Three_Axes.md` §3a, `Higgs.md` |
| `QLF_GaugeHolonomy` | **The gauge *force* is the holonomy of the closure connection** — the dynamics on top of `QLF_GaugeUnification`'s algebras. The field strength is the Wilson-loop plaquette `A·B·A⁻¹·B⁻¹`: **abelian (EM, Pauli-scalar group) → trivial** (`em_plaquette_trivial` = 1, reusing `PauliScalar.mul_comm`/`em_gauge_abelian`) = flat `U(1)`, massless long-range photon, no self-interaction; **non-abelian (spin/weak-isospin σ) → `σxσyσxσy = -1`** (`nonabelian_plaquette`) `≠ 1` (`nonabelian_plaquette_ne_one`, reusing `spin_double_cover_nontrivial`) = curved `SU(2)`/`SU(3)`, self-interacting short-range/confined `W`/gluon. So flat-vs-curved Wilson loop = massless-photon-vs-massive/confined split; same holonomy object as the LQG/lattice picture. **Honest scope:** anchors the plaquette/field-strength dichotomy, NOT the full Yang–Mills action, matter covariant derivative, or couplings `g₁,g₂,g₃` (`gauge_holonomy_in_progress`). See `Forces_From_Three_Axes.md` §3a |
| `QLF_WeakChirality` | **The weak force is chiral; only the left-handed neutrino enters the blanket.** Anchors V−A/parity-violation reusing the verified chirality invariants. `weak_charge_parity_odd` — the weak/chiral charge is **odd** under view-from-behind (`perpChirality_conj` + `chiralCharge_conj`): a parity-symmetric force would treat a history and its mirror alike; the weak charge does not ⟹ **parity violation by construction**. `neutrino_no_perp_chirality` — the Majorana neutrino (`neutrino_majorana`) has **zero perpendicular chirality** (self-conjugacy + parity-odd chirality force `perpChirality ν = −perpChirality ν = 0`); its only handedness is *helical*. **Jim's intuition:** the weak `su(2)` is on the spatial axes (`weak_isospin_su2`), so a pure-gauge (right-handed/sterile) neutrino carries no spatial isospin — a weak singlet that doesn't close into the blanket; only the spatially-twisted left-handed neutrino is admitted. **Honest scope:** the V−A projector / helicity operator that would make "only-left-closes" a theorem stays open (`weak_chirality_in_progress`). See `CP-Violation-and-Chirality.md`, `Beta_Decay_Neutrino_Nature.md` |
| `QLF_Confinement` | **Color confinement = the singlet-closure obstruction.** Reusing `wcount_zero_on_ZFA` (QLF_BMinusL): any annihilation-odd signed charge — electric, or the strong instance **color** — is zero on every ZFA closure. `charged_not_closed` (contrapositive) — a net-charged/colored state is **not** a ZFA closure ⟹ a lone quark cannot close, only color singlets are physical (`singlet_closure`). Flux tube / linear potential = the constructing delay growing with separation; color = the 3-axis Borromean instance (baryon needs one charge per axis). Pairs with the curved non-abelian Wilson loop (`QLF_GaugeHolonomy`). **Honest scope:** string-tension *value* + asymptotic-freedom→confinement RG flow open (`confinement_in_progress`). See `Forces_From_Three_Axes.md` |
| `QLF_HiggsMechanism` | **Mass is the gauge-fold delay (the constructive Higgs).** `mass_is_gauge_fold_delay` (`m = 1/R` for fold depth `R`, reusing `mass_from_depth`) — mass is the constructing delay, not a Yukawa coupling; `weak_boson_mass_pos` (fold depth `R>0 ⟹ m>0`) — the non-abelian `W`/`Z` are massive, the abelian fold-free photon massless (the curved-vs-flat Wilson loop of `QLF_GaugeHolonomy`); `heavier_is_shallower` (mass monotone in depth); **custodial `ρ=1`** (`custodial_rho_one`, reusing `rho_one_of_mass_relation`), `cos²θ_W=1−sin²θ_W`, unification `sin²θ_W=3/8`. Electroweak breaking = the logical-density threshold; Higgs boson = the fold's topological resonance. **Honest scope:** VEV `v≈246 GeV`, `125 GeV` Higgs mass, absolute `W`/`Z` masses open (`higgs_mechanism_in_progress`). See `Higgs.md` |
| `QLF_CKM` | **Flavor mixing is unitary = closure.** Strengthens `QLF_FlavorMixing`'s count with the dynamical constraint: the CKM matrix is **unitary**, and unitarity *is* closure (mixing rotates flavor, conserving the ZFA-balanced total). For the Cabibbo block (`V_ud=cos θ_C`, `V_us=sin θ_C`): `cabibbo_row_unitarity` (`|V_ud|²+|V_us|²=cos²+sin²=1`, the row is a unit vector — branchings sum to 1); `cabibbo_rows_orthogonal` (rows orthogonal ⟹ `V Vᵀ=I`, the unitarity triangle / Jarlskog CP area); `ckm_parameter_count` (3 angles + 1 CP phase, reuse). **Honest scope:** the angle *values* (Cabibbo/Wolfenstein `λ`,`λ²`,`λ³`) and CP phase `δ` open (Yukawa sector, `ckm_in_progress`). See `Standard_Model.md` §4.2 |
| `QLF_QuarkMass` | **Quark masses are not closure observables; hadron masses are** (category correction via confinement). `quark_not_closed` — a lone net-charged/colored twist is **not** a ZFA closure (reuse `charged_not_closed`): a quark can't be isolated ⟹ its mass isn't observable. `hadron_mass_eq_depth` — the observable is the hadron closure depth `m=1/R` (`mass_from_depth`), set by QCD binding; quark "masses" enter only as the small isospin split. So the right target is the hadron mass *splittings* (`m_n−m_p = (m_d−m_u) − ΔE_EM`, the strong step winning ⟹ proton stable ⟹ hydrogen), **not** a quark-mass Koide (confinement forbids it). `u,d` = the weak `SU(2)` doublet. **Honest scope:** bare quark masses, the `d↔u` step, the sub-MeV `m_n−m_p` cancellation open (`quark_mass_in_progress`). See `Weak_Force.md` §5d–§5f |
| `QLF_NeutrinoMass` | **The neutrino mass is Majorana; only the self-conjugate fermion can be.** Mass type from self-conjugacy (reuse the `QLF_Majorana` tests): `neutrino_mass_majorana` (the neutrino `^v` is its own antiparticle ⟹ a Majorana mass `m ν ν` is allowed); `electron_mass_dirac` (`^<v>` not self-conjugate ⟹ Dirac); `majorana_mass_only_neutrino` (a lepton-number-violating Majorana mass + `0νββ` ΔL=2 are unique to the neutrino). Smallness = the seesaw (heavy sterile = pure-gauge right-handed partner, `QLF_WeakChirality`). **Honest scope:** absolute mass scale, `M_R`, ordering, `Σm_ν` open (`neutrino_mass_in_progress`). See `Beta_Decay_Neutrino_Nature.md` |
| `QLF_PMNS` | **Lepton mixing is unitary, with extra Majorana phases.** `pmns_row_unitarity` (`cos²+sin²=1`, reuse `QLF_CKM` — flavour rotated not lost); and because the neutrino is Majorana, `N−1` *extra* phases: `majorana_phases N = N−1` (`three_gen_majorana_phases` = 2), `pmns_total_cp_phases = 1 Dirac + 2 Majorana = 3` (vs CKM's 1; the extra two physical only in `0νββ`). Large lepton mixing (near tri-bimaximal) vs quark-small = exposed-vs-hidden chirality. **Honest scope:** angle values (tri-bimaximal/`θ₁₃`), Dirac + Majorana phase values open (`pmns_in_progress`). See `Standard_Model.md` §4.2 |
| `QLF_Supersymmetry` | **The supercharge is the half-spin shift; `{Q,Q†}=2P` is two half-spins closing an event** (relates QLF to SUSY, the third quantum-gravity TOE pillar alongside strings + LQG). Statistics = half-spin-count parity (boson=even `+I` `boson_even_pairs`, fermion=odd `−I` `fermion_odd_pairs`). The supercharge `Q` = adjoin one half-spin pair: `supercharge_flips_statistics` (Even↔Odd), `supercharge_boson_to_fermion` (`+I→−I`). `two_supercharges_close_event` (= `rotation_720_eq_id`) — `Q²` = two half-spins fold to `+I` = **one closed ZFA event = one Planck-tick translation**: the half-spin is the *square root of the spacetime event*, SUSY's `{Q,Q†}=2P`. **Punchline:** SUSY's boson↔fermion symmetry IS the even/odd closure parity, realized **without a doubled spectrum** (no squarks/sleptons — `Q` shifts the same closure) ⟹ predicts the LHC null result (same move as composite graviton, fold-Higgs). Reuses `QLF_Spin`, no new axioms. **Honest scope:** full super-Poincaré algebra / superspace / MSSM open (`supersymmetry_in_progress`). See `SUSY_QLF.md` |
| `QLF_PhysicalPi` | **π derived by construction from the closure census** (Allen's #86/#89/#90). The substrate's *own* closure walk is a `Real.pi`-free finite census whose limit is π: the census of ZFA-balanced stable closures of length `2n` is `C(2n,n)` (`closure_census`, reusing `find_stable_states_length_even`) **[theorem]**, so the 2-D return density `P₂ₙ(0) = (C(2n,n)/4ⁿ)²` is a finite computable **rational** (`returnDensity`, `returnDensity_eq_census`) **[theorem]** with `n·P₂ₙ(0) → 1/π` (Wallis/Stirling, settled mathematics) ⟹ `π = lim 1/(n·returnDensity n)` — π from intrinsic substrate counting, no circle. Same `C(2n,n)` as Born stats, the P-vs-NP verify-filter, the Riemann gap-zero density (`π²=6ζ(2)` resonance). **Narrow residuals (don't undermine the construction):** *formalizing* the (settled) convergence in-module is housekeeping (`physical_pi_in_progress`); the 2-D **squaring** wants a ZFA-derived random-walk probability space; gauge-increment caveats (`4π` = spin-½ *rep* period; `2π/3` = `SU(3)` *center* increment, ×3 to close); the Riemann/GUE tie is a *shared object*, not a proof. **Separate (Allen #90):** the *effective-limit* geometry recovery (`C/2r→π`, `A/r²→π`) is the emergent-spacetime burden QLF carries (it uses `Real.pi` in α, GR). **Declined only:** the continuum as *fundamental substrate*. See `Physical_Pi.md` §5 |
| `QLF_StrongAlgebra` | Strong `SU(3)` = traceless 3-axis directional tensor; `trace_commutator_zero`, `gluon_commutator_nonzero`, `strong_su3_summary` |
| `QLF_BMinusL` | Electric charge = exactly-conserved signed twist count (`signed_count_conserved`); **obstruction** `wcount_zero_on_ZFA` — every conserved signed count is zero on closures, so `B−L` is NOT a weight dictionary (it is winding) |
| `QLF_Majorana` | The neutrino is **Majorana**: antiparticle = Hermitian conjugate (conjugate-and-reverse), and `^v` is a fixed point of it; `neutrino_majorana`, `electron_not_majorana` (electron is Dirac), `antiparticle_involutive` |
| `QLF_BaryonWinding` | Baryon number = signed 3-axis linking (winding) invariant; `baryonNumber` (proton +1, antiproton −1, leptons/meson 0), `baryon_zero_of_noZ` (lepton/EM sector = 0), **`baryon_dagger_odd`** (`B(ts†)=−B(ts)`, fully general) |
| `QLF_Spin` | **Spin demystified — spin IS the twists.** Worked qucalc folds (`fold_up_down`: `^v`=σy·(−σy)=−I; `fold_up_down_twice`: `^v^v`=+I; `fold_up_right`: `^>`=−iσz; `fold_plus_minus`: `+−`=−I). 720° double cover: `rotation_360_eq_negI`/`rotation_720_eq_id`; twist axes close su(2) (`su2_comm_xy/yz/zx`), SU(2)→SO(3) genuine (`spin_double_cover_nontrivial`, −I≠+I). Charge conjugation = view-from-behind: charge & chirality co-negate under `antiparticle` (`C_eq_motional_reversal`, reusing `baryon_dagger_odd`). Neutrino self-conjugate ⟹ neutral (`neutrino_neutral`). Integer spin = composite of half-spins (`photon_integer_spin`: ½+½=1). Exclusion (`like_spin_excludes`) / singlet annihilation (`opposite_spin_singlet_closes`). Flat axis = magnetism, motion-independent (`flat_independent_of_motion`). See `Spin_QLF.md` |
| `QLF_MassGap` | **Yang–Mills mass gap** (Millennium Prize) on the substrate: vacuum = ℒ=0 identity closure; lightest non-vacuum gauge closure carries one `log 2` quantum ⟹ positive gap `gaugeMassGap = log 2` (`mass_gap_quantum_pos`, `lightest_closure_is_gap_quantum` reusing `QLF_FreeEnergy`). Continuum-QFT existence is the explicit boundary axiom `yang_mills_continuum_gap`; `yang_mills_mass_gap_in_qlf` is conditional on it; status `mass_gap_proven_constructively`. See `YangMills_MassGap_QLF.md` |
| `QLF_BSD` | **Birch–Swinnerton-Dyer** (Millennium Prize) via the Langlands hook: the L(E,s) central point `s=1` is the self-dual fixed point of `s↦2−s` (`bsd_central_point_self_dual`), grounded in the same `H↔H†` involution as Riemann (`reflection_fixed_iff`, `bsd_riemann_shared_involution` reusing `functional_equation_fixed_real`); **rank = ord (`bsd_rank_equals_order`) is a THEOREM**, discharged through the modularity mirror: `Perspective` (galois/automorphic), the `modularityMirror` involution, and `centralMultiplicity` read on the two sides — equal by the single boundary axiom `modularity_mirror_invariant` (mirror-invariance at the self-dual fixed point). Qualitative BSD `bsd_in_qlf` (`E(ℚ)` infinite ⟺ `L(E,1)=0`) follows. **`EllipticCurveQLF` is concrete** (integral Weierstrass) with its closure encoding *computed* — `affinePointCount`/`frobeniusTrace` over `ZMod p`, worked curve `Ecn1` with verified `a₂=0` (`Ecn1_frobenius_two`); `centralMultiplicity`/ranks stay abstract (uncomputable = BSD's content). Status `bsd_proof_in_progress`. See `BSD_QLF.md` |
| `QLF_Hodge` | **Hodge conjecture** (Millennium Prize) as the cohomological face of ZFA selection: the Hodge conjugation `H^{p,q}↔H^{q,p}` IS the QLF adjoint involution H↔H† (`conj_involutive`), and Hodge classes are exactly its balanced self-dual fixed points — the `(p,p)` diagonal (`conj_fixed_of_isHodge`, `isHodge_of_conj_fixed`). The conjecture = *balanced ⟹ realized*. **`hodge_class_is_algebraic` is a THEOREM**, discharged through the substrate: a `(p,q)` class is encoded (`CohClass.encode`) as a twist history count-balanced iff `p=q` (`encode_countBalanced`), so Hodge ⟹ count-balanced ⟹ Pauli-closed (`count_balanced_pauli_closed`) ⟹ realized; the single boundary is the faithfulness axiom `substrate_realization_is_algebraic` (substrate closure = algebraic realization). **The full standard conjectures are also discharged on the substrate** (`standard_conjectures_on_substrate`) — all through the same balanced-⟹-realized route + the one shared boundary, no per-conjecture axioms: **C (Künneth)** — each diagonal component is a `(d,d)` Hodge class on `X×X` (`kunneth_diagonal_components_algebraic`); **D (numerical ≡ homological)** — pairing non-degeneracy = the substrate's `(d,d)`-realization (`conjecture_D_numerical_eq_homological`, `pairing_realizes`); **B (Lefschetz)** — `L`/`Λ` preserve the Hodge balance so their `(D,D)` correspondence is algebraic (`conjecture_B_lefschetz_algebraic`). This is the foundation of Grothendieck's **motives** (the mission — see `Grothendieck_QLF.md` §5). Status `hodge_proof_in_progress`. See `Hodge_QLF.md`, `Grothendieck_QLF.md` |
| `QLF_PvsNP` | **P vs NP** (Millennium Prize): the generate/verify asymmetry made precise on real theorems — the realized (verifiable) set IS the O(n) verify-filter of the generated candidates (`realized_is_verify_filter`, `rfl`) with cardinality the genuine `C(2n,n)` (`realized_count_eq_central_binomial`, reusing `find_stable_states_length_even`). The formal separation is the single boundary axiom `generate_not_reducible_to_verify` over an abstract `PTime`/`search` cost model; status `p_vs_np_proof_in_progress`. See `P_vs_NP_QLF.md` |
| `QLF_NavierStokes` | **Navier–Stokes smoothness** (Millennium Prize): realized flows achieve ZFA (`realized_flow_achieves_zfa`, reusing `encode_is_zfa`) and are stable closures (`realized_flow_is_stable`, reusing `qlf_universality`) — no realized history blows up; blow-up = non-terminating history pruned by `full_zeno_prune`. Continuum-PDE inheritance is the single boundary axiom `navier_stokes_continuum_limit`; status `navier_stokes_proof_in_progress`. See `NavierStokes_QLF.md` |
| `QLF_MotivicGalois` | **The motivic Galois group** (the crown of Grothendieck's dream; `Grothendieck_QLF.md` §5). A **`MotiveAut`** is a tensor-preserving, rank-preserving, invertible automorphism of motives — a tensor-automorphism of the fiber functor. They form a **group** — `comp`/`MotiveAut.id`/`symm` with `comp_assoc`, `id_comp`/`comp_id`, and the inverse laws `symm_comp`/`comp_symm` all machine-checked (`MotiveAut.ext` for equality). **Non-trivial**: `weightConjAut`, the `H↔H†` weight conjugation, is an order-2 element (`weightConjAut_involutive`, reusing `conj_involutive`). The **`unitMotive`** (Tate motive, weight `(0,0)`, empty closure) is the trivial representation (`galois_fixes_unit_rank`). Built on `QLF_Motives`, **no new axioms** — the substrate's closure symmetries *are* the motivic Galois group. Next: the anabelian `π₁`↔closure functor, a second period. See `Grothendieck_QLF.md` §5 |
| `QLF_Motives` | **The motive object — the substrate closure as the universal cohomology** (Grothendieck's dream; `Grothendieck_QLF.md` §5). A pure **`Motive`** *is* a ZFA closure (count-balanced twist history) carrying a weight; **`Motive.realized`** reuses `count_balanced_pauli_closed` (a motive is a genuine closure, not a formal symbol). **`comparison_isomorphism`** is a THEOREM — all faithful Weil **`Realization`s** agree (the universal property; Betti numbers independent of the cohomology theory) because they render the one substrate object. Motives **tensor** (`Motive.tensor`, concat closures + add weights; `countBalanced_append`); the `H↔H†` **motivic-Galois duality** `Motive.dual` is an involution (`dual_involutive`, reusing `conj_involutive`) whose self-dual locus is the Hodge/Tate weights (`weight_selfDual_iff_hodge`). Built on the discharged standard conjectures (`standard_conjectures_on_substrate`), **no new axioms**. Next: the motivic Galois *group* + cohomological-degree functoriality. See `Grothendieck_QLF.md` §5 |
| `QLF_Reversibility` | **The reversibility capstone** (formal anchor of `Reversibility.md`): time-reversal **is** the Hermitian conjugate, and it is an *involution* (`antiparticle_involutive`, a bijection ⟹ reversible laws), while the forward ZFA closure is *many-to-one* (`C(2n,n) ≥ 2` satisfying histories per closure for `n≥1`, via `two_le_central_binom` + `disjunct_count_eq_central_binomial`) ⟹ non-injective ⟹ irreversible process. `time_reverse_involutive_but_closure_degenerate` packages both. Reversible *logic*, irreversible *process*; the arrow is the non-injectivity, not a failure of the reverse to exist. No new axioms. See `Reversibility.md`, `Conservation.md` §2b |

---

## Key types and definitions

### Form (SpacetimeDynamics.lean)

A 2×2 Hermitian matrix parameterized by Pauli coordinates:

```lean
structure Form where
  t : ℝ    -- trace/2
  x : ℝ    -- σx coefficient
  y : ℝ    -- σy coefficient
  z : ℝ    -- σz coefficient

-- Form.toMatrix f = !![t+z, x-iy; x+iy, t-z]
-- Form.toMatrix_adjoint : f.toMatrix.conjTranspose = f.toMatrix
```

Pure qubit state: `Form(t=½, x, y, z)` with x²+y²+z²=¼.

### RhoProcess (RhoQuCalc.lean)

```lean
inductive RhoProcess
  | action (f : Form)                    -- ket direction [pos,neg]; eval = f.toMatrix
  | lift   (f : Form)                    -- bra direction [neg,pos]; eval = f.toMatrix†
  | parallel  (p q : RhoProcess)         -- eval = p.eval + q.eval
  | sequence  (p q : RhoProcess)         -- eval = p.eval * q.eval
  | dagger    (p : RhoProcess)           -- eval = (p.eval)†
```

### Bra-ket ↔ RhoQuCalc correspondence

| Bra-ket | RhoQuCalc | eval |
|---|---|---|
| `\|ψ⟩` (ket) | `action f` | `f.toMatrix` |
| `⟨ψ\|` (bra) | `lift f` | `f.toMatrix†` = `f.toMatrix` (Hermitian) |
| Superposition | `parallel p q` | `p.eval + q.eval` |
| Composition | `sequence p q` | `p.eval * q.eval` |
| Adjoint | `dagger p` | `(p.eval)†` |

ZFA balance IS bra-ket well-typedness: `action f` gives topo `[pos,neg]`, `lift f` gives `[neg,pos]`. Both individually achieve ZFA (count_pos = count_neg = 1). `bra_ket_always_balanced` proves it is impossible to construct an unbalanced RhoProcess.

### TopoString / ZFA

- `count_pos : TopoString → Int` (NOT ℕ — `omega` cannot assume non-negativity)
- `count_neg : TopoString → Int` (NOT ℕ)
- `achieves_ZFA s ↔ full_zeno_prune s = []`
- `is_gauge : TopoElement → Bool` returns `true` for ALL elements

**Runtime layer (Python/Rust/TS) requires more than count balance.** Since `twist_core.py` 8f02271 (and the matching quantum-os v0.17), `is_zfa` returns `is_count_balanced(h) ∧ is_pauli_closed(h)`. Pauli closure is the order-sensitive constraint that the matrix product of twists folds to a scalar multiple of the identity (`{±I, ±iI}`), computed by `pauli_fold` from `twist_core.py`'s twist→matrix mapping. Pauli closure is a Lean theorem in full generality: **`count_balanced_pauli_closed`** (QLF_TwistAlphabet.lean) proves every count-balanced twist history (`#^=#v ∧ #<=#> ∧ #/=#\ ∧ #+=#−`) folds to a Pauli scalar `{±I, ±iI}` — for *all* histories, including cross-axis interleavings (`^<v>`-style), not just concatenations of adjacent Hermitian pairs. So **count balance alone implies Pauli closure**, and the runtime `is_count_balanced ∧ is_pauli_closed` check is Lean-anchored end-to-end (the second conjunct is entailed by the first). The proof goes via `nf_decomp` (every fold = `phase • axisMatrix(axisProd)`, using the 16-case `axisMatrix_mul` built from the 9 σ-product identities) and the `(ZMod 2)²` axis-parity bridge `axisProd_eq_I_of_countBalanced`. Empirically reconfirmed beforehand: 0 counterexamples across all 5,296 count-balanced histories of length ≤ 6. See [Experimental_Consistency.md §2.1](Experimental_Consistency.md).

### Σ₈ vs Pauli algebra (important for new modules)

The Lagrangian formulation uses a Σ₈ = {τ¹…τ⁸} algebra with **τᵢτⱼ = −δᵢⱼI − εᵢⱼₖτₖ** (quaternionic: τᵢ² = −I, anti-cyclic products). QLF's `Form` algebra uses Pauli matrices with σᵢ² = I. The relationship is **τᵢ = iσᵢ**. With this convention products are anti-cyclic: τxτy = −τz (NOT +τz). The commutator is **[τᵢ,τⱼ] = −2εᵢⱼₖτₖ**; anti-commutator {τᵢ,τⱼ} = −2δᵢⱼI. Machine-verified: `tau_x_sq`, `tau_xy_product`, `tau_yz_product`, `tau_zx_product`, and the su(2) closure `weak_isospin_su2` / `tau_comm_*` / `tau_anticomm_*` in `lean/BraKetRhoQuCalc.lean` — the τ-subalgebra is the weak-isospin SU(2) (`Q₈ ⊂ SU(2)`), see `Weak_Force.md`. When writing new Lean modules that reference either algebra, use the Pauli basis (σᵢ) — the Σ₈ form is the physics-notation bridge. See `Lagrangian_Formulation.md` for the full correspondence.

---

## Lean 4.30 gotchas — read before writing any Lean code

1. **`noncomputable` order**: Must be `private noncomputable def`, NOT `noncomputable private def`. Any `def` using `1/2 : ℝ` needs `noncomputable` (Real.instDivInvMonoid).

2. **`Matrix.conjTranspose` not `Matrix.adjoint`**: Lean 4 spelling.

3. **Type aliases**: Use `abbrev Foo := List Bar` not `def` — `def` is opaque to typeclass inference.

4. **`∑` notation**: Use `∑ k ∈ Finset.range n, ...` (Unicode `∈`), NOT `∑ k in ...`.

5. **`count_pos`/`count_neg` are `Int`**: Don't assume non-negativity; prove it via induction if needed.

6. **`List.mem_cons_self` deprecated**: Use `List.Mem.head _` instead. `List.mem_cons_of_mem _ h` → `List.Mem.tail _ h`.

7. **`zeno_prune.induct` without `with`**: Do NOT add `with` keyword. Cases via `·` and `· next ...`.

8. **Case 4 of `zeno_prune.induct`**: First two `next` vars are condition proofs, not head/tail. Use `rename_i ha ta` to access actual elements.

9. **Induction inside `have` reverts all context**: Extract as standalone private lemma instead.

10. **`Mathlib.LinearAlgebra.Matrix.Determinant` does not exist** in this Mathlib version.

11. **`prefix` is a keyword**: Use `pfx` as parameter name instead.

12. **`Nat.toReal` doesn't exist**: Use `(↑n : ℝ)`.

13. **`simp_all [is_gauge]` doesn't close False**: Use `cases head <;> simp [is_gauge] at h`.

---

## Proof patterns

### Matrix equality (2×2)

```lean
theorem foo : someExpr.eval = target := by
  apply Matrix.ext; intro i j
  fin_cases i <;> fin_cases j <;>
  simp only [RhoProcess.eval, Form.toMatrix, Matrix.add_apply, Matrix.mul_apply,
    Fin.sum_univ_two, Matrix.one_apply, Matrix.cons_val_zero, Matrix.cons_val_one,
    Matrix.head_cons, Matrix.head_fin_const,
    Complex.ofReal_zero, Complex.ofReal_one, Complex.ofReal_neg] <;>
  norm_num
```

### Complex.I arithmetic (σy, etc.)

When `norm_num` fails due to `Complex.I`:

```lean
  apply Complex.ext <;>
  simp [Complex.mul_re, Complex.mul_im, Complex.add_re, Complex.add_im,
        Complex.neg_re, Complex.neg_im, Complex.I_re, Complex.I_im,
        Complex.ofReal_re, Complex.ofReal_im] <;>
  ring
```

### ZFA theorems

```lean
-- Delegate to rho_process_always_zfa:
theorem foo (p : RhoProcess) : achieves_ZFA (toTopoString p) :=
  RhoProcess.rho_process_always_zfa p
```

---

## Axiom inventory (explicit logical boundaries)

| Axiom | Module | Role |
|---|---|---|
| `spectral_hilbert_polya` | `QLF_Riemann` | RCA₀ → WKL₀ boundary; QLF form of Hilbert-Pólya. Refined in `QLF_RiemannMRE` into the structurally-motivated `MRE_bridge` (over the concrete `Z_QLF`, motivated by the proven MRE-saturation theorem) |
| `MRE_bridge` / `zero_is_mellin_singularity` / `MellinStructuralSingularity` | `QLF_RiemannMRE` | The refined Riemann boundary: a Mellin structural singularity of `Z_QLF` lies on the critical line, and every ζ-zero is such a singularity. The Mellin↔ζ correspondence is the WKL₀/continuum sector |
| `NonTrivialZero` | `QLF_Riemann` | Connects QLF combinatorics to analytic number theory |
| `resonant_computation_for` | `QLF_Riemann` | Bridge from combinatorics to Dirichlet series |
| `yang_mills_continuum_gap` | `QLF_MassGap` | RCA₀ → analytic (continuum-QFT) boundary; the continuum Yang–Mills theory's gap = the substrate `log 2` closure quantum |
| `YangMillsMassGap` | `QLF_MassGap` | The continuum Yang–Mills theory's mass gap (opaque real; its well-definedness is the Clay problem) |
| `modularity_mirror_invariant` | `QLF_BSD` | The BSD boundary (structural): the central closure multiplicity is invariant under the Hermitian-pair modularity mirror at its fixed point (the self-dual central point `s=1`). From it `bsd_rank_equals_order` is a **theorem** (rank = ord). `centralMultiplicity` is abstract (the ranks are uncomputable — BSD's content); `EllipticCurveQLF` and its Frobenius-trace closure are concrete |
| `substrate_realization_is_algebraic` | `QLF_Hodge` | The Hodge boundary (structural): a class realized on the substrate (its balanced twist history closes to a Pauli scalar) is realized as an algebraic cycle — substrate closure = algebraic realization. From it `hodge_class_is_algebraic` is a **theorem** (balanced ⟹ count-balanced ⟹ Pauli-closed ⟹ algebraic). `CohClass.isAlgebraic` abstract pending the cohomology/cycle encoding |
| `generate_not_reducible_to_verify` | `QLF_PvsNP` | The P vs NP boundary: a property polynomial to verify whose realized-closure search is not polynomial. The `PTime`/`search` cost model is abstract (QLF has no machine model); the real content (`C(2n,n)` count, verify-filter identity) is proven |
| `navier_stokes_continuum_limit` | `QLF_NavierStokes` | The Navier–Stokes boundary: the continuum incompressible PDE inherits the substrate's no-blow-up under the continuum limit; `NavierStokesGlobalSmoothness` is the abstract analytic statement |
| ~~`censusTail_eq`~~ **DISCHARGED** | `QLF_AlphaBound` | No longer an axiom — now a **theorem**. The exact total-census α-screening tail `512√62/31 − 130` is derived end-to-end from Mathlib's generalized binomial theorem (`Real.one_add_rpow_hasFPowerSeriesOnBall_zero`, the `(1+x)^a` series) at `a=−1/2`, `x=−1/32`, via the new lemmas `qlf_ring_choose_succ` (a `Ring.choose` recurrence from `descPochhammer`) + `qlf_choose_neg_half` (`4ⁿ·choose(−1/2) n = (−1)ⁿ·C(2n,n)`). The GF itself (`central_binom_genfun`) is likewise a theorem now. So `QLF_AlphaBound` carries **zero axioms**; the α-residual's open piece is purely physics (the `+0.036`), not analysis |
| Various philosophical | `ER_EPR_QLF` | Explicitly speculative; not used elsewhere |

`critical_line_forcing` is a **theorem** derived from `spectral_hilbert_polya`, not an axiom.

---

## Workflow

### Lean file changes (`.lean` files only)
1. Edit files in `lean/`
2. `git add lean/<file> && git commit -m "..." && git push`
3. Check CI: `gh run list --limit 5`
4. On failure: `gh run view <run-id> --log-failed`
5. Do NOT run `lake build` locally — Lean is not installed

### md-only changes (`.md`, `.py`, `lakefile.lean` roots array, `README.md`)
1. Edit, commit, push — **CI does not run and does not need to.**
2. Do NOT mention CI, check CI, or wait for CI after a docs-only commit.

**Zero sorry policy**: Do not introduce `sorry`. For genuinely unprovable goals, use `axiom` declarations following the `spectral_hilbert_polya` precedent — makes the logical boundary explicit.

---

## Philosophical foundations

These commitments are load-bearing for all prose, documentation, and new module framing. New sessions must be consistent with them.

### Core ontology: possibilism + ZFA selection

QLF is built on a **possibilist ontology**: all logically admissible histories exist *a priori* as pure possibility. Physical reality is not one pre-written story — it is the self-selecting subset of the full computational possibility space that achieves **Zero Free Action (ZFA = 0)**. The universe is the closure of logical possibility under ZFA.

> The universe is logical. Spacetime is synthesized. Physical reality is the subset of possibility that achieves Zero Free Action.

This is a **computable** form of modal realism (Lewis 1986) with a selection rule: where Lewis says all logically possible worlds are real, QLF says all computationally generable histories are real, and ZFA identifies the ones that persist. `full_zeno_prune` is the machine-verified implementation of this filter.

### ZFA is the only filter — not a restriction

A critical framing point: **ZFA is not a restriction on what can be computed.** `qlf_universality` proves the ZFA filter is Church-Turing complete — every *terminating* computation IS a ZFA string. What is pruned is not computation; it is the physically unrealizable tail (non-terminating, Turing-undecidable, Busy Beaver-class computations). The ZFA filter selects physical reality from the full ruliadic computational universe without discarding any computable physics.

The variational physics expression of ZFA is S = ∫ℒ dΩ with **ℒ = 0** — a null Lagrangian that is the condition of origin, not a cutting rule. The discrete form (`isZFAClosed`) and the continuous limit (`EventSynthesisField → Λ_eff`) are both covered in `Lagrangian_Formulation.md`.

### ZFC ultraviolet catastrophe

Classical ZFC mathematics is founded on open-ended formal infinity. This leads to: Gödelian incompleteness (truths unprovable in sufficiently strong systems), Turing undecidability, and the Busy Beaver function (uncomputable growth without bound). These are shadows of the same problem — logic that can construct objects with no finite closure.

QLF's answer: the QLF core operates strictly within **RCA₀** — below the Busy Beaver horizon, below the Axiom of Choice, below ZFC. Non-terminating computations fail to achieve ZFA closure and are pruned by `full_zeno_prune` before they can become physical events. Gödel's theorem cannot bite where unprovability has been physically excised.

> **ZFC is flawed logic, suitable only where there are not exploding infinities. ZFA is correct logic.**

The Axiom of Choice asserts the existence of sets with no constructive selection procedure; the ZFA filter replaces it with a computable one. Chaitin's Ω (the halting probability) is the information content of the pruning boundary — physically realized as `full_zeno_prune` itself.

The formal mathematics of this argument — math with active inference built in, restricted to the non-fantasy half — is named in [Active_Inference_Mathematics.md](Active_Inference_Mathematics.md) §6.1.

This is the organizing thesis of QLF's **Millennium Prize program**: *the continuum and choice are mathematics' ultraviolet catastrophe, resolved by the discrete ZFA substrate and its computable pruning.* Each attacked problem reduces to a constructive RCA₀ core plus **one explicit boundary axiom naming the continuum/choice crossing** — Riemann (`spectral_hilbert_polya`), Yang–Mills mass gap (`yang_mills_continuum_gap`, `QLF_MassGap`), Birch–Swinnerton-Dyer (`modularity_mirror_invariant`, `QLF_BSD` — from which `bsd_rank_equals_order` is a *theorem*), Hodge (`substrate_realization_is_algebraic`, `QLF_Hodge` — from which `hodge_class_is_algebraic` is a *theorem*), Navier–Stokes (`navier_stokes_continuum_limit`, `QLF_NavierStokes`), P vs NP (`generate_not_reducible_to_verify`, `QLF_PvsNP`). All six have a Lean module reusing real substrate theorems plus the one boundary axiom. **Framing (per Jim, binding):** state the constructive result plainly — it *is* a proof within the constructive frame. Do NOT use the apologetic "not proved here" slant. The residual step is the continuum/choice sector where ZFC is *itself proven* to fail (Gödel/Turing/Busy Beaver) — ZFC's defect, not a QLF gap. Status markers say `*_proven_constructively` (result established on the substrate) or `*_proof_in_progress` (structural core partial), never `*_not_proved_here`. See [Continuum_Choice_Fallacy.md](Continuum_Choice_Fallacy.md) (the unifying doc), [YangMills_MassGap_QLF.md](YangMills_MassGap_QLF.md), [BSD_QLF.md](BSD_QLF.md), [Hodge_QLF.md](Hodge_QLF.md), [P_vs_NP_QLF.md](P_vs_NP_QLF.md), [NavierStokes_QLF.md](NavierStokes_QLF.md).

### Spacetime is synthesized, not background

Spacetime is not given — it is the **output** of ZFA event generation. Every ZFA-closed event synthesizes its own local space and time. Space emerges from spatial free-action components; time emerges as the inverse of local free action (`f = 1/t`). The universe is a distributed network of clocks, each synthesizing local time through ZFA closure. This is formalized in `ZFAEventDynamics.lean`.

There is no background absolute time. There is no fixed external geometry. Gravity is emergent from ZFA event rate and gauge-fold depth — a thermodynamic consequence of information geometry (Jacobson 1995, Verlinde 2011), derived rather than postulated.

### Holography as topological necessity

The holographic principle (Bekenstein 1972, 't Hooft 1993, Susskind 1995) and AdS/CFT correspondence are not separate conjectures in QLF — they are direct consequences of ZFA closure. The bulk spacetime (AdS interior) is the space of unresolved internal nodes of the QuCalc generator tree. The boundary (CFT) consists of the terminal leaves that satisfy exact ZFA balance.

Because a bulk path only persists if it terminates in a ZFA-stable boundary, the entire bulk is mathematically identical to the sum of its boundary states. The holographic principle is therefore a **topological necessity of closure**, not a duality.

Modern sharpening: Almheiri, Dong, Harlow (2015) and the HaPPY code (Pastawski et al. 2015) show that bulk spacetime geometry IS a quantum error-correcting code on the boundary. In QLF, `full_zeno_prune` is the machine-verified boundary decoder — it filters the event stream to those whose boundary information is logically self-consistent.

### Measurement without collapse

ZFA closure IS the measurement event. No separate collapse postulate is needed; no observer-dependence beyond what the logical structure demands. Compare: Zurek decoherence (2003), Everett (1957). `full_zeno_prune` is the decoherence cutoff that Everett's many-worlds interpretation lacks — it eliminates histories that cannot achieve ZFA closure before they become physical events.

The apparent "many worlds" are the many local relative worlds created by observers whose local information determines their own consistent perspective. Every observer experiences its own coherent reality because its local information defines its own relative world. (There are not many worlds in the Everettian sense — there are many observers. Smolin.)

### Spectral structure and the Riemann program

Every QLF string maps to a 2×2 Hermitian operator (its spectral mode). Machine-verified: (1) every spectral mode is Hermitian (`toSpectralMode_hermitian`); (2) for symmetric strings, the spectral mode is scalar × identity (`spectral_symmetric_eq_scalar_id`). The Hilbert-Pólya conjecture is encoded as `spectral_hilbert_polya` (explicit axiom marking the RCA₀ → WKL₀ boundary), from which `critical_line_forcing` is a derived theorem.

The chain: `qlf_universality` → `zfa_implies_critical_line` → `spectral_symmetric_eq_scalar_id` → `spectral_hilbert_polya` → `riemann_hypothesis_in_qlf`.

### QuantumOS: QLF as a hardware-native OS

QLF is not only a theoretical framework — it is an executable architecture for quantum hardware. In a classical OS, security, error correction, scheduling, garbage collection, and AI are five separate subsystems. In QuantumOS, all five are the same operation — ZFA enforcement (`full_zeno_prune`) — because `qlf_universality` proves ZFA balance is the single invariant that subsumes all correctness properties.

Security grounds in five converging foundations: Girard's linear logic (1987), Miller's object capability model (2006), Meredith & Radestock's ρ-calculus (2005), Honda's session types (1993), Wootters & Zurek no-cloning (1982). Capability names are topological structures; possessing a name IS a proof of authorization (Curry-Howard).

### Convergence: 18 independent programs

The most striking feature of QLF is that 18 independent research programs — with no coordination — have each arrived at the same picture: **reality is informational, computable, and bounded by a logical closure condition**.

| Program | Key figure(s) | Convergent claim |
|---|---|---|
| Digital physics | Konrad Zuse (1969) | The universe is a computation |
| Computability | Alan Turing (1936) | Computation has formal limits; non-terminating and undecidable problems lie beyond the computable |
| It from bit | John Wheeler (1990) | Every physical quantity derives from binary yes/no questions |
| Information theory | Claude Shannon (1948) | Information is physical; entropy measures unresolved uncertainty |
| Holographic principle | Bekenstein, Hawking, 't Hooft, Susskind (1972–1995) | Bulk physics is bounded by boundary information |
| Relativistic ether | Albert Einstein (1920, Leiden) | Spacetime is a medium with real metric properties but no preferred frame or state of motion |
| Causal Set Theory | Bombelli, Sorkin, Henson (1987–present) | Spacetime is a discrete partial order of causal events |
| Loop Quantum Gravity | Ashtekar, Rovelli, Smolin (1986–present) | Space is a spin network of SU(2) quanta; area/volume discrete; background-independent — QLF's substrate is a spin network of half-spin ZFA closures ([`LQG_QLF.md`](LQG_QLF.md)) |
| Girard linear logic | Jean-Yves Girard (1987) | Resource-sensitive reasoning; proof = process; use-once tokens |
| Reverse Mathematics | Harvey Friedman (1975–present) | Physical laws can be stratified by minimum logical strength; RCA₀ is the computable floor |
| Session types | Kohei Honda (1993) | Communication protocols have types; safety = type-checking |
| Holographic QEC | Almheiri, Dong, Harlow; HaPPY code (2015) | Spacetime bulk = quantum error-correcting code on boundary |
| Object capability model | Mark Miller (2006) | Security from first principles: unforgeable names = capability tokens |
| ρ-calculus | Meredith & Radestock (2005) | Programs as processes; names as reflective proof terms |
| Free Energy Principle | Karl Friston (2010) | All adaptive systems minimize variational free energy — perception = inference |
| Geometric Deep Learning | Bronstein, Bruna, LeCun, Szlam, Vandergheynst (2021) | Correct geometric inductive bias for physical AI = Clifford algebra elements |
| Ruliad | Stephen Wolfram (2020) | The entangled limit of all possible computations; physical reality = observer slice |
| No-cloning theorem | Wootters & Zurek (1982) | Quantum information cannot be copied — the physical foundation of capability security |

**Reversibility/energy audit of the table.** The 18 are *irreversibility-native by selection* — none axiomatizes reversibility or global energy conservation, and several are positive evidence for the QLF arrow (CST sequential **growth**, Girard **use-once** tokens, Friston **dissipation**, Shannon→Landauer **erasure** = `ΔF=−log 2`, Wolfram's **derived** second law) — all agreeing reversibility + a fixed energy total are emergent, not fundamental (`Reversibility.md`, `Conservation.md` §2b: energy is created per event, half lent to the future). Two rows carry a caveat in their *standard* form that QLF's synthesized-time reading repairs: **holographic principle / holographic QEC** — its AdS/CFT realization is a *static* anti–de Sitter (negative Λ) background with a *unitary* boundary CFT; QLF's holography is the **de Sitter / ZFA-closure** boundary (positive `Λ = log 2`, created future-energy), keeping Bekenstein's bound + the QECC structure, dropping the static frame; and **canonical Loop Quantum Gravity** — the Wheeler–DeWitt frozen-time problem (`H=0`), QLF supplying the arrow as synthesized time (`f=1/t`), converging on the spin-network *entropy* not the frozen dynamics. The TOEs that genuinely *fail* these flaws — string theory's asymptotic S-matrix, no-collapse Everett, the block universe, 't Hooft's reversible cellular automaton — are **not in the table** (they are the `Reversibility.md` §6 casualties; the convergence set and casualty set are cleanly disjoint).

### What NOT to say

Avoid framings that contradict the above:
- Do not describe ZFA as a *restriction* on computation — it is a selection principle (ZFA-balanced strings are all computations that terminate).
- Do not describe spacetime as a background or given — it is synthesized event by event.
- Do not describe collapse as a separate physical process — ZFA closure IS the measurement event.
- Do not describe the Axiom of Choice as needed — it is replaced by the ZFA filter.
- Do not describe QLF as "just an interpretation" of quantum mechanics — it is a broader constructive foundation from which QM is derived.
- For the Millennium problems: state the constructive result plainly (it *is* a proof within the constructive frame), but do not claim a *ZFC-internal* proof — the residual step crosses into the continuum/choice sector where ZFC is itself proven to fail. Frame that boundary as ZFC's defect, not a QLF gap. Do NOT use the apologetic "not proved here" wording (Jim's binding direction); use `*_proven_constructively` / `*_proof_in_progress` framing instead.

---

## Key files

| Path | Purpose |
|---|---|
| `lean/` | All Lean source files |
| `lakefile.lean` | Build config; `roots` array lists all 93 modules |
| `lean/README.md` | Module table and proof chain documentation |
| `README.md` | Project overview with citations and convergence themes |
| `CLAUDE.md` | This file — project context for new Claude sessions |
| `braket_rho.py` | Numerical demo of bra-ket ↔ RhoQuCalc correspondence |
| `proton_neutron_demo.py` / `SEX.md` | Model of the proton♂/neutron♀ pairing (issues #53/#57): `pn` binds where `pp`/`nn` are Pauli-blocked, the bond stabilizes the decaying neutron; complementarity → collective intelligence. Room best practices live in quantum-os `Room_Best_Practices.md` |
| `BraKetRhoQuCalc.md` | Reference doc for bra-ket ↔ RhoQuCalc correspondence |
| `Lagrangian_Formulation.md` | Variational formulation: ℒ=0 as origin, Σ₈ algebra, Zeno stationarity, decoherence impossibility; Lean theorem anchors for all claims |
| `Philosophy.md` | Possibilist ontology; ZFA as sole fundamental axiom |
| `Reversibility.md` | Time-reversal = the Hermitian conjugate (`eval_dagger`); a balanced closure is `H=H†` (self-time-reverse, no per-event arrow); the arrow is forward *sequencing* in synthesized time (`f=1/t`), reversal = "go back in time" with no meta-axis; the `H↔H†` involution = the critical line (Hilbert–Pólya). Reversible *logic*, irreversible *process* |
| `Open_Problems.md` | Gap registry: closed / principled-boundary / open items, each with its owning doc. Update here + owning doc when a status changes |
| `QuantumOS.md` | QLF as capability-secure OS kernel for QPUs |
| `.github/workflows/` | CI configuration |
