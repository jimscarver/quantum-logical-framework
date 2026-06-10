# Forces from the three axes — a gauge-structure synthesis

**A structural conjecture: the Standard-Model gauge group `U(1) × SU(2) × SU(3)` is the symmetry algebra of QLF's three spatial axes.** This collects pieces QLF has *separately* (U(1) electromagnetism, the machine-verified weak `SU(2)`, the `N = 9 = 3²` directional-coupling tensor that fixes α) into one reading, motivated by the intuition that **the weak and strong forces are the electromagnetic gauge-twist mechanism seen from different projections of the same 3-axis structure**.

**Read this as a program, not a result.** The verified anchors are marked ✓; the synthesis itself is a conjecture (🔶); what it does *not* do is marked in §6. It derives no coupling constants, no chiral structure, and no masses.

---

## 1. The verified anchors (what QLF already has, separately)

| force | QLF object | algebra | status |
|---|---|---|---|
| **EM** | the `+`/`−` gauge fold (`U(1)` gauge swap) | `u(1)`, dim **1** | ✓ derived; `no_magnetic_monopoles` Lean-verified |
| **weak** | the Σ₈ τ-quaternion subalgebra of the 3 spatial axes (`τᵢ = iσᵢ`) | `su(2)`, dim **3** | ✓ Lie algebra machine-verified — `weak_isospin_su2` ([`lean/BraKetRhoQuCalc.lean`](lean/BraKetRhoQuCalc.lean), [`Weak_Force.md`](Weak_Force.md) §3) |
| **EM coupling α** | the `3 × 3` **directional-coupling tensor**, `N = 9 = 3²` | (of the 3 axes) | ✓ `α = 1/137` to 0.026%, `N = 9` Lean-anchored ([`Magnetism_Spatial_Dynamics.md`](Magnetism_Spatial_Dynamics.md) §6.1, `QLF_FineStructureSubstrate.lean`) |
| **strong** | three-quark **Borromean** three-fold binding | `su(3)`? | ⚠ structural only; Lie-group identification open ([`Hadrons_Markov_Blankets.md`](Hadrons_Markov_Blankets.md), [`Standard_Model.md`](Standard_Model.md) §3.4) |

Each is tied to the **three spatial axes** `^v / <> / /\` (or the gauge fold `+-`). They have never been tied *together*. This doc does that.

---

## 2. The dimension alignment 🔶

The Standard-Model gauge group has

$$\dim\bigl(U(1) \times SU(2) \times SU(3)\bigr) \;=\; 1 + 3 + 8 \;=\; \mathbf{12}.$$

Every one of these dimensions is a feature of the **three-axis directional structure**:

- The `3 × 3` directional-coupling tensor of the three spatial axes is `u(3)`, of dimension `3² = 9` — this is exactly the **`N = 9`** that fixes α. It splits canonically:
  $$u(3) \;=\; \underbrace{u(1)}_{\text{trace} = 1} \;\oplus\; \underbrace{su(3)}_{\text{traceless} = 3^2 - 1 = 8}.$$
  The **trace** is the single scalar direction — **electromagnetism** `U(1)`. The **traceless** part has dimension **8** — the **eight gluons** of **`SU(3)`**, i.e. the strong force as the traceless directional couplings among the three axes (the same axes whose Borromean three-fold binding is the proton).
- The remaining `su(2)`, dimension **3**, is the **half-spin / τ-quaternion** algebra of the same three axes (`iσₓ, iσᵧ, iσ_z`) — the **weak** force, already machine-verified as `weak_isospin_su2`.

So
$$12 \;=\; \underbrace{9}_{u(3)\ =\ \text{EM}\,\oplus\,\text{color, the }N=9\text{ α tensor}} \;+\; \underbrace{3}_{su(2)\ =\ \text{weak, half-spin}}.$$

The dimensions are not adjustable: `dim u(3) = 9` (the α tensor), `dim su(2) = 3` (verified), `dim su(3) = 9 − 1 = 8`. They add to the SM's 12 with nothing left over.

---

## 3. The reading — "weak & strong are EM from different 3-axis projections" 🔶

Under this synthesis, there is **one** mechanism — the **gauge-twist closure** on the three spatial axes — and the three "forces" are which component of the `3 × 3` directional structure the closure rotates:

- **EM** = the **trace** (`U(1)`): the overall scalar gauge phase (the `+−` fold).
- **strong** = the **traceless** part (`SU(3)`, 8 gluons): the directional couplings *among* the three axes — the same three-foldness that confines quarks Borromean-style.
- **weak** = the **half-spin `SU(2)`** (τ-quaternion): the spinor rotations of the axes — the chirality-mediated pair-flip.

This is precisely the intuition that *the weak and strong forces are electromagnetism seen from different 3-D perspectives*: same gauge-twist closure, different projection (scalar / spinor / tensor) of the one three-axis object. The universal mediator is the **gauge-twist vertex** that already produces α; the gauge *group* is the projection it acts through.

---

## 4. Quark flavors, honestly

The synthesis says **color `SU(3)` = the traceless 3-axis directional tensor**, consistent with the existing Borromean three-quark picture (the three "colors" = the three axes). But the flavor sector is almost entirely open in QLF:

- ✗ **No twist assignments** for the six quark flavors (only the electron `^<v>`, neutrino `^v`, photon `^>` have signatures).
- ✗ **No individual quark masses.**
- ⚠ **Flavor change** (`d → u`) is the gauge-fold pair-flip *operation* ([`Weak_Force.md`](Weak_Force.md) §4); the explicit vertex topology is open.
- ✗ **CKM mixing angles** — open ([`Standard_Model.md`](Standard_Model.md) §4.2).
- ✓ **Confinement** — derived (quarks are fractional ZFA; only Borromean triples close).

So the synthesis upgrades the *gauge* picture (color = traceless 3-axis tensor) but leaves the *flavor* picture where it was: open.

---

## 5. Leptons mirroring quark structure — the "three" 🔶

The companion intuition — *lepton masses mirror proton processes at different frequencies* — finds partial support:

- The three **lepton** generations are three **phases** (120° apart) of one gauge-fold closure ([`Weak_Force.md`](Weak_Force.md) §5b, `koide_two_thirds` machine-verified) — "different frequencies of one closure" made precise.
- The **proton** is three **quarks** (Borromean), with `m_p/m_e = 6π⁵` carrying `|S₃| = 6` (the three-quark permutation) and `π⁵` (a 5-angle hidden-chirality integration) ([`Proton_Resonance_R_e.md`](Proton_Resonance_R_e.md), `mass_ratio_QLF_eq`).

Both are a **"three"** of the three axes — three lepton phases, three quark colors. Whether the lepton 3-phase structure and the quark 3-color structure are the *same* three-axis "three" (so that the lepton spectrum literally mirrors the three-quark hadronic structure at scaled frequency/depth) is an open, testable conjecture — the natural next probe of intuition #2. It is **not** established here.

---

## 6. What this is NOT

- **Not a derivation of the Standard Model.** This is a **dimension/structure alignment** (`12 = 1 + 3 + 8`, with `1 + 8 = 9 = N`) plus a conjecture that the gauge group *is* the three-axis symmetry. It derives **no** coupling constants, **no** running, **no** chiral structure (why `SU(2)_L` is left-handed), **no** hypercharge assignments, and **no** masses.
- **Not a Lie-group identification of `SU(3)`.** Only `U(1)` and `SU(2)` are Lean-verified; the `su(3) = traceless 3-axis tensor` claim is structural (the dimension count `8 = 3² − 1` is correct, the algebra identification is not yet proved).
- **Not electroweak unification or a GUT.** No symmetry-breaking scale, no unification of couplings, no proton-decay prediction.
- **Not a quark-flavor theory.** Flavors, masses, and CKM stay open (§4).

The defensible claim is narrow and worth stating plainly: **the dimensions and the two verified gauge algebras (`U(1)`, `SU(2)`) plus the α directional tensor (`N = 9`) line up exactly with the Standard-Model gauge group as the symmetry of the three spatial axes** — which makes "all three forces from the three axes" a sharp, falsifiable target rather than a slogan.

---

## 7. References

### Internal (QLF)
- [`lean/BraKetRhoQuCalc.lean`](lean/BraKetRhoQuCalc.lean) — `weak_isospin_su2` (the `SU(2)` anchor).
- [`Weak_Force.md`](Weak_Force.md) — the weak sector; §3 (SU(2)⊂Σ₈), §5b (lepton 3-phases / Koide).
- [`Magnetism_Spatial_Dynamics.md`](Magnetism_Spatial_Dynamics.md) §6.1 — α from the `N = 9 = 3²` directional-coupling tensor; `QLF_FineStructureSubstrate.lean`.
- [`Standard_Model.md`](Standard_Model.md) §3.4, §6 — U(1)/SU(2)/SU(3) status; gauge-group identification as open work.
- [`Hadrons_Markov_Blankets.md`](Hadrons_Markov_Blankets.md), [`Proton_Resonance_R_e.md`](Proton_Resonance_R_e.md) — the three-quark Borromean proton; `m_p/m_e = 6π⁵`.
- [`Conservation.md`](Conservation.md) §8 — the "every ZFA-preserving symmetry → conservation law" methodology (which this synthesis instantiates for the gauge sector).
- [`Open_Problems.md`](Open_Problems.md) — registry status.

### External
- The Standard Model gauge group `SU(3)_c × SU(2)_L × U(1)_Y` (dim 8 + 3 + 1 = 12); the eight gluons of `SU(3)`; `su(N)` has dimension `N² − 1`.
- Grand-unified theories (SU(5), SO(10)) — the standard *high-energy* unification this does **not** reproduce.
