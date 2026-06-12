# CLAUDE.md — Quantum Logical Framework

Project context for Claude Code sessions. Read this before making any changes.

---

## Project overview

**Quantum Logical Framework (QLF)** is a formal proof system machine-verified in Lean 4 across **47 modules with zero `sorry` blocks**. It encodes quantum mechanics and spacetime dynamics using phase-string combinatorics (ZFA — Zero-phase Flux Algebra).

Core claim: *ZFA balance is the selection principle for physical reality.* Every terminating computation is a ZFA string; every ZFA string is symmetric (lies on the critical line). The Church-Turing universe filtered to ZFA-balanced strings is our physical universe.

**Lean is NOT installed locally.** CI (GitHub Actions) is the only way to verify Lean changes. Push to GitHub and wait for CI before reporting success.

---

## 47 active modules

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
| `QLF_FineStructureSubstrate` | α = 1/137 from substrate combinatorics, zero free params; `alpha_QLF_eq`, `only_3d_substrate_gives_137` (2D→1/132, 4D→1/144) |
| `QLF_LenzMassRatio` | `m_p/m_e = 6π⁵ = \|S₃\|·π⁵`, 0.002%; `mass_ratio_QLF_eq` + counterfactuals |
| `QLF_BorromeanAngles` | The 5-angle count `5 = 3 + 2` (Jacobi internal + chirality-mixing); `total_angular_DOF_eq_five`, `matches_lenz_hidden_chirality_angles` |
| `QLF_EulerMascheroni` | γ as the harmonic excess `H_N − ln N` of the ZFA ensemble; `gamma_QLF_structural` (structural form; convergence proof deferred) |
| `QLF_RiemannZeta` | Substrate ↔ ζ bridge: `γ_QLF` = ζ's Laurent constant at `s=1`; `zeta_laurent_constant_eq_gamma_QLF`, `rh_proof_in_progress` |
| `QLF_RiemannMRE` | **MRE bridge** — a constructive scaffold for the Riemann boundary. `Z_QLF = (1/(1−5x)+1/(1−3x))/2` concrete with verified singularities at `1/5`,`1/3` (`Z_QLF_pole_fifth/third`); MRE saturation grounded in `binary_kl` (`mre_saturation_only_at_closure`, reusing QLF_FreeEnergy), with the saturating prior `1/2` = `critical_line_real_part` (`mre_prior_is_critical_line`). The bare `spectral_hilbert_polya` is refined into `MRE_bridge` (+ `zero_is_mellin_singularity`), giving `riemann_hypothesis_in_qlf_via_MRE`. Residual Mellin↔ζ correspondence = WKL₀ boundary; `rh_mre_proof_in_progress` |
| `QLF_DiracCorrection` | Hydrogen fine structure (α² kinematic/spin-orbit/Darwin); `hydrogen_spectrum_from_h_and_m_e`, `three_mechanisms_alpha_squared` |
| `QLF_LambShift` | Lamb-shift prefactor `4/(3πn³) = 4·(2/3)·(1/2π)·(1/n³)`; `lamb_prefactor_loop_phase`, `lamb_shift_substrate_summary` |
| `QLF_GMinusTwo` | Electron `g−2`: `a_e = α/2π` (Schwinger), 0.2%; `a_e_QLF_eq_schwinger`, `g_factor_QLF_eq` |
| `QLF_GravityFromDelay` | Newton's law + `G = L_P²c³/ℏ` from holographic delay; `newton_exponent_only_3d_matches`, `gravity_substrate_summary` |
| `QLF_MercuryPerihelion` | Perihelion advance 42.99″/century (0.03%); `mercury_perihelion_substrate_summary` |
| `QLF_CosmologicalConstant` | `Ω_Λ = log 2` (1.2%), closing the 10¹²² vacuum catastrophe; `only_2_gauge_matches_observed_Omega_Lambda`, `cosmological_constant_substrate_summary` |
| `QLF_PrimordialMarkovBlanket` | Markov blankets as Fuller geodesic spheres; icosahedral closure → E₈ via McKay; `mckay_2I_E8_anchor`, `E8_dimension_eq`, `primordial_blanket_euler` |
| `QLF_Koide` | Koide `Q = 2/3` forced by `N=3 ∧ A²=2` ⇒ `m_τ` to 0.006%; `koide_two_thirds`, `koide_three_phase` |
| `QLF_StrongAlgebra` | Strong `SU(3)` = traceless 3-axis directional tensor; `trace_commutator_zero`, `gluon_commutator_nonzero`, `strong_su3_summary` |
| `QLF_BMinusL` | Electric charge = exactly-conserved signed twist count (`signed_count_conserved`); **obstruction** `wcount_zero_on_ZFA` — every conserved signed count is zero on closures, so `B−L` is NOT a weight dictionary (it is winding) |
| `QLF_Majorana` | The neutrino is **Majorana**: antiparticle = Hermitian conjugate (conjugate-and-reverse), and `^v` is a fixed point of it; `neutrino_majorana`, `electron_not_majorana` (electron is Dirac), `antiparticle_involutive` |
| `QLF_BaryonWinding` | Baryon number = signed 3-axis linking (winding) invariant; `baryonNumber` (proton +1, antiproton −1, leptons/meson 0), `baryon_zero_of_noZ` (lepton/EM sector = 0), **`baryon_dagger_odd`** (`B(ts†)=−B(ts)`, fully general) |
| `QLF_MassGap` | **Yang–Mills mass gap** (Millennium Prize) on the substrate: vacuum = ℒ=0 identity closure; lightest non-vacuum gauge closure carries one `log 2` quantum ⟹ positive gap `gaugeMassGap = log 2` (`mass_gap_quantum_pos`, `lightest_closure_is_gap_quantum` reusing `QLF_FreeEnergy`). Continuum-QFT existence is the explicit boundary axiom `yang_mills_continuum_gap`; `yang_mills_mass_gap_in_qlf` is conditional on it; status `mass_gap_proven_constructively`. See `YangMills_MassGap_QLF.md` |
| `QLF_BSD` | **Birch–Swinnerton-Dyer** (Millennium Prize) via the Langlands hook: the L(E,s) central point `s=1` is the self-dual fixed point of `s↦2−s` (`bsd_central_point_self_dual`), grounded in the same `H↔H†` involution as Riemann (`reflection_fixed_iff`, `bsd_riemann_shared_involution` reusing `functional_equation_fixed_real`); **rank = ord (`bsd_rank_equals_order`) is now a THEOREM**, discharged through the modularity mirror: `Perspective` (galois/automorphic), the `modularityMirror` involution, and `centralMultiplicity` read on the two sides — equal by the single boundary axiom `modularity_mirror_invariant` (mirror-invariance at the self-dual fixed point). Qualitative BSD `bsd_in_qlf` (`E(ℚ)` infinite ⟺ `L(E,1)=0`) follows. **`EllipticCurveQLF` is concrete** (integral Weierstrass) with its closure encoding *computed* — `affinePointCount`/`frobeniusTrace` over `ZMod p`, worked curve `Ecn1` with verified `a₂=0` (`Ecn1_frobenius_two`); `centralMultiplicity`/ranks stay abstract (uncomputable = BSD's content). Status `bsd_proof_in_progress`. See `BSD_QLF.md` |
| `QLF_Hodge` | **Hodge conjecture** (Millennium Prize) as the cohomological face of ZFA selection: the Hodge conjugation `H^{p,q}↔H^{q,p}` IS the QLF adjoint involution H↔H† (`conj_involutive`), and Hodge classes are exactly its balanced self-dual fixed points — the `(p,p)` diagonal (`conj_fixed_of_isHodge`, `isHodge_of_conj_fixed`). The conjecture = *balanced ⟹ realized*, the cohomological lift of the substrate theorem `count_balanced_pauli_closed` (now embedded as `hodge_pattern_substrate_witness`), reduced to the single boundary axiom `hodge_class_is_algebraic` (`non_algebraic_not_hodge` derived). Status `hodge_proof_in_progress`. See `Hodge_QLF.md` |
| `QLF_PvsNP` | **P vs NP** (Millennium Prize): the generate/verify asymmetry made precise on real theorems — the realized (verifiable) set IS the O(n) verify-filter of the generated candidates (`realized_is_verify_filter`, `rfl`) with cardinality the genuine `C(2n,n)` (`realized_count_eq_central_binomial`, reusing `find_stable_states_length_even`). The formal separation is the single boundary axiom `generate_not_reducible_to_verify` over an abstract `PTime`/`search` cost model; status `p_vs_np_proof_in_progress`. See `P_vs_NP_QLF.md` |
| `QLF_NavierStokes` | **Navier–Stokes smoothness** (Millennium Prize): realized flows achieve ZFA (`realized_flow_achieves_zfa`, reusing `encode_is_zfa`) and are stable closures (`realized_flow_is_stable`, reusing `qlf_universality`) — no realized history blows up; blow-up = non-terminating history pruned by `full_zeno_prune`. Continuum-PDE inheritance is the single boundary axiom `navier_stokes_continuum_limit`; status `navier_stokes_proof_in_progress`. See `NavierStokes_QLF.md` |

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

**Runtime layer (Python/Rust/TS) requires more than count balance.** Since `twist_core.py` 8f02271 (and the matching quantum-os v0.17), `is_zfa` returns `is_count_balanced(h) ∧ is_pauli_closed(h)`. Pauli closure is the order-sensitive constraint that the matrix product of twists folds to a scalar multiple of the identity (`{±I, ±iI}`), computed by `pauli_fold` from `twist_core.py`'s twist→matrix mapping. Pauli closure is now a Lean theorem in full generality: **`count_balanced_pauli_closed`** (QLF_TwistAlphabet.lean) proves every count-balanced twist history (`#^=#v ∧ #<=#> ∧ #/=#\ ∧ #+=#−`) folds to a Pauli scalar `{±I, ±iI}` — for *all* histories, including cross-axis interleavings (`^<v>`-style), not just concatenations of adjacent Hermitian pairs. So **count balance alone implies Pauli closure**, and the runtime `is_count_balanced ∧ is_pauli_closed` check is Lean-anchored end-to-end (the second conjunct is entailed by the first). The proof goes via `nf_decomp` (every fold = `phase • axisMatrix(axisProd)`, using the 16-case `axisMatrix_mul` built from the 9 σ-product identities) and the `(ZMod 2)²` axis-parity bridge `axisProd_eq_I_of_countBalanced`. Empirically reconfirmed beforehand: 0 counterexamples across all 5,296 count-balanced histories of length ≤ 6. See [Experimental_Consistency.md §2.1](Experimental_Consistency.md).

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
| `modularity_mirror_invariant` | `QLF_BSD` | The BSD boundary (now structural): the central closure multiplicity is invariant under the Hermitian-pair modularity mirror at its fixed point (the self-dual central point `s=1`). From it `bsd_rank_equals_order` is a **theorem** (rank = ord). `centralMultiplicity` is abstract (the ranks are uncomputable — BSD's content); `EllipticCurveQLF` and its Frobenius-trace closure are now concrete |
| `hodge_class_is_algebraic` | `QLF_Hodge` | The Hodge boundary: every Hodge (balanced, conjugation-fixed (p,p)) class is algebraic — *balanced ⟹ realized*, over the complex-analytic continuum; `CohClass.isAlgebraic` is abstract pending the constructive cohomology/cycle encoding (the pattern itself is proven on the substrate, `hodge_pattern_substrate_witness`) |
| `generate_not_reducible_to_verify` | `QLF_PvsNP` | The P vs NP boundary: a property polynomial to verify whose realized-closure search is not polynomial. The `PTime`/`search` cost model is abstract (QLF has no machine model); the real content (`C(2n,n)` count, verify-filter identity) is proven |
| `navier_stokes_continuum_limit` | `QLF_NavierStokes` | The Navier–Stokes boundary: the continuum incompressible PDE inherits the substrate's no-blow-up under the continuum limit; `NavierStokesGlobalSmoothness` is the abstract analytic statement |
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

This is the organizing thesis of QLF's **Millennium Prize program**: *the continuum and choice are mathematics' ultraviolet catastrophe, resolved by the discrete ZFA substrate and its computable pruning.* Each attacked problem reduces to a constructive RCA₀ core plus **one explicit boundary axiom naming the continuum/choice crossing** — Riemann (`spectral_hilbert_polya`), Yang–Mills mass gap (`yang_mills_continuum_gap`, `QLF_MassGap`), Birch–Swinnerton-Dyer (`bsd_rank_equals_order`, `QLF_BSD`), Hodge (`hodge_class_is_algebraic`, `QLF_Hodge`), Navier–Stokes (`navier_stokes_continuum_limit`, `QLF_NavierStokes`), P vs NP (`generate_not_reducible_to_verify`, `QLF_PvsNP`). All six now have a Lean module reusing real substrate theorems plus the one boundary axiom. **Framing (per Jim, binding):** state the constructive result plainly — it *is* a proof within the constructive frame. Do NOT use the apologetic "not proved here" slant. The residual step is the continuum/choice sector where ZFC is *itself proven* to fail (Gödel/Turing/Busy Beaver) — ZFC's defect, not a QLF gap. Status markers say `*_proven_constructively` (result established on the substrate) or `*_proof_in_progress` (structural core partial), never `*_not_proved_here`. See [Continuum_Choice_Fallacy.md](Continuum_Choice_Fallacy.md) (the unifying doc), [YangMills_MassGap_QLF.md](YangMills_MassGap_QLF.md), [BSD_QLF.md](BSD_QLF.md), [Hodge_QLF.md](Hodge_QLF.md), [P_vs_NP_QLF.md](P_vs_NP_QLF.md), [NavierStokes_QLF.md](NavierStokes_QLF.md).

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

### Convergence: 17 independent programs

The most striking feature of QLF is that 17 independent research programs — with no coordination — have each arrived at the same picture: **reality is informational, computable, and bounded by a logical closure condition**.

| Program | Key figure(s) | Convergent claim |
|---|---|---|
| Digital physics | Konrad Zuse (1969) | The universe is a computation |
| Computability | Alan Turing (1936) | Computation has formal limits; non-terminating and undecidable problems lie beyond the computable |
| It from bit | John Wheeler (1990) | Every physical quantity derives from binary yes/no questions |
| Information theory | Claude Shannon (1948) | Information is physical; entropy measures unresolved uncertainty |
| Holographic principle | Bekenstein, Hawking, 't Hooft, Susskind (1972–1995) | Bulk physics is bounded by boundary information |
| Relativistic ether | Albert Einstein (1920, Leiden) | Spacetime is a medium with real metric properties but no preferred frame or state of motion |
| Causal Set Theory | Bombelli, Sorkin, Henson (1987–present) | Spacetime is a discrete partial order of causal events |
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
| `lakefile.lean` | Build config; `roots` array lists all 47 modules |
| `lean/README.md` | Module table and proof chain documentation |
| `README.md` | Project overview with citations and convergence themes |
| `CLAUDE.md` | This file — project context for new Claude sessions |
| `braket_rho.py` | Numerical demo of bra-ket ↔ RhoQuCalc correspondence |
| `BraKetRhoQuCalc.md` | Reference doc for bra-ket ↔ RhoQuCalc correspondence |
| `Lagrangian_Formulation.md` | Variational formulation: ℒ=0 as origin, Σ₈ algebra, Zeno stationarity, decoherence impossibility; Lean theorem anchors for all claims |
| `Philosophy.md` | Possibilist ontology; ZFA as sole fundamental axiom |
| `Open_Problems.md` | Gap registry: closed / principled-boundary / open items, each with its owning doc. Update here + owning doc when a status changes |
| `QuantumOS.md` | QLF as capability-secure OS kernel for QPUs |
| `.github/workflows/` | CI configuration |
