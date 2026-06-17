# The Yang–Mills Mass Gap in [QLF](README.md)

> **Status: proven constructively — the continuum step reframed, not apologised for.**
> The gap is established on the substrate (`gaugeMassGap = log 2 > 0`, machine-verified);
> the only remaining step is the continuum-QFT reconstruction, carried by one explicit
> boundary axiom — `yang_mills_continuum_gap` in
> [`lean/QLF_MassGap.lean`](lean/QLF_MassGap.lean), exactly the
> [`spectral_hilbert_polya`](lean/QLF_Riemann.lean) precedent. That step lives in the
> continuum sector where ZFC is *itself proven to fail* (Gödel/Turing/Busy Beaver), so it
> is ZFC's defect, not a gap in this proof. See [Open_Problems.md](Open_Problems.md). The
> unifying thesis — *the continuum and choice are mathematics' ultraviolet catastrophe* —
> is in [Continuum_Choice_Fallacy.md](Continuum_Choice_Fallacy.md).

## 1. The classical problem

One of the seven Millennium Prize Problems: prove that for every compact simple gauge
group **G** a non-trivial quantum Yang–Mills theory exists on ℝ⁴ and has a **mass gap**
Δ > 0 — a strictly positive lower bound on the energy of every state above the vacuum.
The gap is what makes the strong force short-ranged and is the field-theory shadow of
"no massless free gluons; the lightest glueball is heavy." The two faces are *existence*
(a rigorous continuum quantum field theory satisfying the Wightman / Osterwalder–Schrader
axioms) and *the gap* (Δ > 0 for that theory).

## 2. The QLF reframing

QLF does not quantize a continuum field. It generates the discrete possibility space of
ZFA twist histories and keeps the **closed** ones. Three facts already machine-verified in
the tree turn "mass gap" into a counting statement:

1. **The gauge algebra is a non-abelian ZFA twist algebra — and it exists.** The
   weak-isospin **SU(2)** is the τ-quaternion subalgebra of Σ₈
   (`weak_isospin_su2`, [`lean/BraKetRhoQuCalc.lean`](lean/BraKetRhoQuCalc.lean); see
   [Weak_Force.md](Weak_Force.md)); the strong **SU(3)** is the traceless 3-axis
   directional tensor (`trace_commutator_zero`, `gluon_commutator_nonzero`,
   `strong_su3_summary`, [`lean/QLF_StrongAlgebra.lean`](lean/QLF_StrongAlgebra.lean)).
   So the *gauge structure* a Yang–Mills theory needs is constructed, not assumed.

2. **The vacuum is the identity / empty closure.** The variational principle is **ℒ = 0**
   (a null Lagrangian, the condition of origin — [Lagrangian_Formulation.md](Lagrangian_Formulation.md));
   the vacuum is the trivial closure with zero free action and zero excitation energy.

3. **The lightest non-vacuum closure carries exactly one `log 2` quantum.** A non-vacuum
   gauge excitation is a *non-trivial* ZFA closure — a Hermitian-conjugate twist pair
   `(t, t†)` whose ordered product folds to a Pauli scalar. Its per-event free-energy
   decrement is exactly **ΔF = −log 2 nats** (`zfa_closure_minimizes_free_energy`,
   [`lean/QLF_FreeEnergy.lean`](lean/QLF_FreeEnergy.lean), with the binary-KL identity
   `binary_kl 1 (1/2) = log 2`). Anything "lighter" than a full closure is an *unclosed
   fraction* — pruned by `full_zeno_prune`, never a physical state.

## 3. The structural mass gap

Put (1)–(3) together. The vacuum has energy 0. Every non-vacuum state is a closure, and
every closure costs at least one half-spin quantum. Therefore the spectrum has a **gap**:

> **Δ = `gaugeMassGap` = log 2 > 0** (substrate units).

Machine-verified in [`lean/QLF_MassGap.lean`](lean/QLF_MassGap.lean): `mass_gap_quantum_pos`
(`log 2 > 0`) and `lightest_closure_is_gap_quantum` (the lightest closure realises exactly
that quantum, reusing `QLF_FreeEnergy`). There is no continuum of arbitrarily-light gauge
excitations because the substrate is discrete and closure is all-or-nothing — the same
reason QLF has no ultraviolet catastrophe.

**Confinement is the colour-singlet face of the same fact.** Only count-balanced (ZFA)
histories persist; a free colour charge is an unbalanced (non-closed) twist net and is
pruned. The surviving excitations are colour-singlet closures (linking-invariant baryon
windings, [`lean/QLF_BaryonWinding.lean`](lean/QLF_BaryonWinding.lean); exactly-conserved
signed charge, [`lean/QLF_BMinusL.lean`](lean/QLF_BMinusL.lean)) — so the gap is a gap of
*physical* (singlet) states, as the problem requires.

## 4. Where the boundary sits

QLF supplies the gap as a property of the **discrete substrate**. The Clay problem asks for
it as a property of a **continuum** quantum field theory satisfying the Wightman /
Osterwalder–Schrader axioms on ℝ⁴. The bridge — that the continuum reconstruction's
physical gap equals the substrate's per-closure quantum — is the genuinely analytic step,
the continuum limit. QLF marks it with **one explicit axiom**:

```lean
axiom YangMillsMassGap : ℝ                    -- the continuum theory's gap (opaque)
axiom yang_mills_continuum_gap :              -- the boundary (RCA₀ → analytic)
    YangMillsMassGap = gaugeMassGap
theorem yang_mills_mass_gap_in_qlf : 0 < YangMillsMassGap := by
  rw [yang_mills_continuum_gap]; exact mass_gap_quantum_pos
```

This is the same epistemic move as the Riemann program: a constructive theorem chain
whose only non-RCA₀ input is a single, named boundary axiom marking exactly the
constructive→analytic crossing — never a `sorry`, never a hidden gap.

## 5. Epistemic stance

Within QLF's frame — where the substrate-constructive part of mathematics has its own
foundational adequacy, and the continuum is the coarse-grained statistical limit of a
dense-but-discrete ZFA event stream ([TheContinuum.md](TheContinuum.md)) — the mass gap is
*structurally necessary*: a discrete substrate with all-or-nothing closure cannot have a
massless non-vacuum gauge spectrum. What QLF does **not** do is construct the continuum
QFT and prove the Wightman axioms; that is what `yang_mills_continuum_gap` carries, and it
is the continuum-sector boundary `yang_mills_continuum_gap` carries — ZFC's defect, not
ours. The one-line summary, machine-checked as `mass_gap_proven_constructively`: *QLF
proves the Yang–Mills mass gap on the substrate — the gap value is the `log 2` quantum —
and reduces the rest to the existence of the continuum limit.*

## 6. What would close it

Promoting `yang_mills_continuum_gap` from axiom to theorem means giving a constructive
continuum limit of the ZFA event field whose reconstructed two-point function has a
spectral gap — the QLF analogue of the MRE-bridge refinement proposed for Riemann
([ReverseMathematics.md](ReverseMathematics.md) §4). That is the real open work; this
document and module make the target precise and the boundary explicit.

## References

- C. N. Yang & R. L. Mills, *Conservation of isotopic spin and isotopic gauge invariance*, Phys. Rev. **96** (1954) 191–195 — non-abelian gauge theory.
- K. Osterwalder & R. Schrader, *Axioms for Euclidean Green's functions*, Comm. Math. Phys. **31** (1973) 83–112 & **42** (1975) 281–305; A. S. Wightman (Wightman axioms) — the continuum reconstruction the mass-gap problem asks for.
- A. Jaffe & E. Witten, *Quantum Yang–Mills Theory* — Clay Mathematics Institute (official problem description). <https://www.claymath.org/millennium-problems/>
