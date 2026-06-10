# CLAUDE.md — Quantum Logical Framework

Project context for Claude Code sessions. Read this before making any changes.

---

## Project overview

**Quantum Logical Framework (QLF)** is a formal proof system machine-verified in Lean 4 across **19 modules with zero `sorry` blocks**. It encodes quantum mechanics and spacetime dynamics using phase-string combinatorics (ZFA — Zero-phase Flux Algebra).

Core claim: *ZFA balance is the selection principle for physical reality.* Every terminating computation is a ZFA string; every ZFA string is symmetric (lies on the critical line). The Church-Turing universe filtered to ZFA-balanced strings is our physical universe.

**Lean is NOT installed locally.** CI (GitHub Actions) is the only way to verify Lean changes. Push to GitHub and wait for CI before reporting success.

---

## 19 active modules

In `lean/`, registered in `lakefile.lean` roots array:

| Module | What it proves |
|---|---|
| `QLF_Axioms` | Types, counting, pruning, ZFA definition; `zfa_implies_critical_line` |
| `QLF_Combinatorics` | Phase-string generation helpers |
| `QLF_QuCalc` | Phase-generation engine; `find_stable_states_length_even` = C(2n,n); `emergent_blanket_formation` (count-balance preserved under concatenation) |
| `QLF_Universality` | Every terminating computation IS a ZFA string (Church-Turing) |
| `QLF_Critical_Line` | ZFA → symmetry bridge |
| `QLF_Spectral` | Hermitian spectral projectors; Hilbert-Pólya bridge |
| `QLF_Riemann` | Riemann hypothesis program; `riemann_hypothesis_in_qlf` |
| `SpacetimeDynamics` | Pauli-basis 2×2 Hermitian matrices; `Form.toMatrix_adjoint` |
| `RhoQuCalc` | ρ-process algebra; `rho_process_always_zfa`; `eval_dagger` |
| `ZFAEventDynamics` | ZFA event dynamics; spacetime acceleration |
| `AgeOfUniverse` | Cosmological age from ZFA event rate |
| `ER_EPR_QLF` | Entanglement-geometry axioms (speculative, not used elsewhere) |
| `PauliExclusion` | Fermionic statistics via matrix commutator; `fermi_nonzero_example` |
| `StringTheoryQLF` | String modes; C(2n,n) degeneracy; `string_mass_spectrum` |
| `MTheoryQLF` | M-theory; S/T-duality; 11D; `m11d_zfa_stable` |
| `BraKetRhoQuCalc` | Bra-ket ↔ RhoQuCalc correspondence; `bra_ket_always_balanced` |
| `QLF_FreeEnergy` | Per-event ΔF = -log 2 at half-spin ZFA closure; `zfa_closure_minimizes_free_energy` |
| `QLF_Pauli` | 4-element Pauli scalar group {±I, ±iI}; group closure + `pauli_closed_of_admissible_zfa` |
| `QLF_TwistAlphabet` | 8-twist alphabet with σ-matrix mapping; `hermitian_pair_is_pauli_scalar` (every Hermitian pair folds to -I); `concat_pairs_is_pauli_scalar` (N-pair concatenations land in {+I, -I}); **`count_balanced_pauli_closed`** (count balance ⟹ Pauli closure for ALL histories — general, via `nf_decomp` + `(ZMod 2)²` axis-parity bridge; the keystone) |

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
| `spectral_hilbert_polya` | `QLF_Riemann` | RCA₀ → WKL₀ boundary; QLF form of Hilbert-Pólya |
| `NonTrivialZero` | `QLF_Riemann` | Connects QLF combinatorics to analytic number theory |
| `resonant_computation_for` | `QLF_Riemann` | Bridge from combinatorics to Dirichlet series |
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
- Do not describe the Riemann hypothesis as proved — `spectral_hilbert_polya` is an explicit axiom marking an open logical boundary, not a proof.

---

## Key files

| Path | Purpose |
|---|---|
| `lean/` | All Lean source files |
| `lakefile.lean` | Build config; `roots` array lists all 19 modules |
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
