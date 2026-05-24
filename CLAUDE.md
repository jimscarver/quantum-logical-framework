# CLAUDE.md — Quantum Logical Framework

Project context for Claude Code sessions. Read this before making any changes.

---

## Project overview

**Quantum Logical Framework (QLF)** is a formal proof system machine-verified in Lean 4 across **16 modules with zero `sorry` blocks**. It encodes quantum mechanics and spacetime dynamics using phase-string combinatorics (ZFA — Zero-phase Flux Algebra).

Core claim: *ZFA balance is the selection principle for physical reality.* Every terminating computation is a ZFA string; every ZFA string is symmetric (lies on the critical line). The Church-Turing universe filtered to ZFA-balanced strings is our physical universe.

**Lean is NOT installed locally.** CI (GitHub Actions) is the only way to verify Lean changes. Push to GitHub and wait for CI before reporting success.

---

## 16 active modules

In `lean/`, registered in `lakefile.lean` roots array:

| Module | What it proves |
|---|---|
| `QLF_Axioms` | Types, counting, pruning, ZFA definition; `zfa_implies_critical_line` |
| `QLF_Combinatorics` | Phase-string generation helpers |
| `QLF_QuCalc` | Phase-generation engine; `find_stable_states_length_even` = C(2n,n) |
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

1. Edit Lean files in `lean/`
2. Push to GitHub: `git add lean/<file> && git commit -m "..." && git push`
3. Check CI: `gh run list --limit 5` or view at GitHub Actions
4. Read CI logs on failure: `gh run view <run-id> --log-failed`
5. Do NOT run `lake build` locally — Lean is not installed

**md-only changes** (README.md, .md files, Python scripts) do not need CI verification.

**Zero sorry policy**: Do not introduce `sorry`. For genuinely unprovable goals, use `axiom` declarations following the `spectral_hilbert_polya` precedent — makes the logical boundary explicit.

---

## Key files

| Path | Purpose |
|---|---|
| `lean/` | All Lean source files |
| `lakefile.lean` | Build config; `roots` array lists all 16 modules |
| `lean/README.md` | Module table and proof chain documentation |
| `README.md` | Project overview with citations and convergence themes |
| `braket_rho.py` | Numerical demo of bra-ket ↔ RhoQuCalc correspondence |
| `BraKetRhoQuCalc.md` | Reference doc for the correspondence |
| `.github/workflows/` | CI configuration |
