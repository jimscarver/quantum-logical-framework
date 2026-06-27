# Atomic structure in QLF — what the substrate geometry tells us

The [Quantum Logical Framework](README.md) (QLF) does not reproduce quantum chemistry. It tells you where
atomic structure's *ingredients* come from — and it adds one genuinely structural signature that ties the
orbital ladder to the substrate's icosahedral closure geometry. This doc collects what the geometry says,
from most-solid (machine-verified) to most-speculative (a cited representation resonance), with the
honest scope stated plainly.

The Lean anchor is [`lean/QLF_AtomicStructure.lean`](lean/QLF_AtomicStructure.lean) (reuse-only, no new
axioms).

---

## 1. Why atoms have shells at all — Pauli exclusion

The periodic table exists because electrons cannot pile into one state. In QLF that is the fermionic
antisymmetry: the antisymmetric channel of two **identical** ρ-processes vanishes,
`fermi_antisym p p = 0` (`shells_from_pauli_exclusion`, reusing `pauli_exclusion`,
[`PauliExclusion.lean`](lean/PauliExclusion.lean)). Identical closures are excluded, so electrons fill
successive shells instead of collapsing into the ground state. This is the *same* substrate fact behind
the no-diproton ([`Fusion.md`](Fusion.md)) and quantum no-cloning ([`Banach_Tarski_QLF.md`](Banach_Tarski_QLF.md)) —
**no free identical copy**, now read as the foundation of chemistry. Machine-verified.

## 2. The orbital ladder — the 3-axis / 3-D-oscillator rendering

The 8-twist alphabet splits **6 + 2** ([`Magic_numbers.md`](Magic_numbers.md)): the six spatial twists
organize into **3 axes**, giving three spatial dimensions. Orbital angular momentum `ℓ` then carries the
`2ℓ + 1` multiplet — `s, p, d, f, g = 1, 3, 5, 7, 9` (`orbitalDim`) — and the shell-filling **magic
numbers** follow from the 6 + 2 split together with the 3-D harmonic-oscillator degeneracy
(`Magic_numbers.md` derives the nuclear sequence `2, 8, 20, 28, 50, 82, 126`, with the `ℓ`/`j`-coupling
multiplets). So the *shape* of the orbital ladder is the three-axis geometry seen at one-bit-per-axis
(3-D) resolution — the rendered perspective of [`Geometry_Of_Space.md`](Geometry_Of_Space.md) §3c.

## 3. The scale and the fine structure — α from the substrate

The size of atoms and their spectral fine structure are fixed by the fine-structure constant, which QLF
derives with zero free parameters: `α(d) = 1/(128 + d²) = 1/137` at `d = 3`
([`QLF_FineStructureSubstrate`](lean/QLF_FineStructureSubstrate.lean), `only_3d_substrate_gives_137`).
From it follow the hydrogen fine structure — the `α²` kinematic, spin-orbit, and Darwin corrections
([`QLF_DiracCorrection`](lean/QLF_DiracCorrection.lean), `three_mechanisms_alpha_squared`) — the Lamb
shift ([`QLF_LambShift`](lean/QLF_LambShift.lean)), and `g − 2` ([`QLF_GMinusTwo`](lean/QLF_GMinusTwo.lean)).
The nucleus-versus-cloud separation (a tiny dense nucleus, a diffuse electron cloud) is the proton/electron
mass ratio `m_p/m_e = 6π⁵` ([`QLF_LenzMassRatio`](lean/QLF_LenzMassRatio.lean)). So the *energy scale* of
atomic structure is substrate-combinatorial, set by the same three axes (`N = 9 = 3²`) behind `α`.

## 4. The icosahedral signature — why s, p, d are special, and where it breaks

This is the part the prime-ladder / icosahedral thread ([`Geometry_Of_Space.md`](Geometry_Of_Space.md)
§3c) surfaces, and it is the one genuinely new claim. The substrate's closure symmetry is the icosahedral
group `I ≅ A₅` (order 60; irreps of dimension `1, 3, 3, 4, 5`, since `1² + 3² + 3² + 4² + 5² = 60`). Set
the orbital dimensions beside the icosahedral irrep dimensions `{1, 3, 4, 5}`:

| Shell | `ℓ` | dim `2ℓ+1` | icosahedral irrep? |
|---|---|---|---|
| **s** | 0 | **1** | ✓ (the trivial `A`) |
| **p** | 1 | **3** | ✓ (`T₁`) |
| **d** | 2 | **5** | ✓ (`H` — the 5-fold) |
| **f** | 3 | **7** | ✗ — no 7-dim icosahedral irrep |
| **g** | 4 | **9** | ✗ |

So **s, p, d each match a single icosahedral irrep** (`spd_icosahedral_sized`), and the `d` shell *is*
the 5-dimensional `H` irrep (`d_orbital_is_five`) — the same "5" as the icosahedral 5-fold and the d-orbital
`A₅` link of `QLF_PrimeResonance.five_divides_icosahedral`. This is the arithmetic shadow of a sharper,
**cited** group-theory fact: under icosahedral symmetry `s, p, d` restrict to single irreps and stay
**unsplit** — *icosahedral is the unique point group in which the d-orbitals do not split* (a standard
crystal-field result). The **f** shell (`ℓ = 3`, dimension 7) is the **first** orbital with no icosahedral
irrep dimension (`f_orbital_breaks_icosahedral`), so it cannot stay unsplit — it is the first to break
icosahedral symmetry.

And that break lands exactly where `Magic_numbers.md` already places a phase boundary: the `ℓ ≤ 2`
(`s, p, d`) **dimensional-growth** régime versus the `ℓ ≥ 3` (`f` and up) **vacuum-intruder** régime. So
QLF's icosahedral closure geometry *resonates with* why the low shells are clean and the f-block is where
the regularities strain — the same `ℓ ≤ 2 / ℓ ≥ 3` line, read as "where the substrate's icosahedral
irreps run out."

At the **cluster** scale the same geometry returns as the icosahedral magic numbers: `13 = 1` centre
`+ 12` shell (the first Mackay number, the densest small cluster — `QLF_PrimeResonance.centered_icosahedron_is_thirteen`),
then `55, 147, …`. Atomic matter, where local packing dominates, adopts the icosahedral order of the
substrate blanket.

## 5. The constituents — particles by number of differences

Below the shells are the particles the atom is built from, and QLF reads each as a closure of
distinguishable **twist pairs** — its **number of differences**. Each difference is one orthogonal
distinction = **one bit** (the orthogonality-is-one-bit quantum of §3c above). The ladder runs
**neutrino (1) → electron (2) → muon (3) → tau (4) → proton (5)**, and the three *kinds* of difference are
**charge** (lateral), **spin** (transverse), and **colour** (internal — the three Borromean axes). The
charged leptons `e, μ, τ` at 2, 3, 4 are exactly the **three generations** (`QLF_Generations`, the 3
axes); the proton's **5 = 3 colour + charge + spin** is the **`π⁵`** of `m_p/m_e = |S₃|·π⁵`
(`QLF_BorromeanAngles`/`QLF_LenzMassRatio`).

<img src="diagrams/particle_differences.svg" alt="Particles by number of differences: neutrino (1, stable), electron/positron (2, stable), muonium μ⁺e⁻ (3, decays), tau atom τ⁻e⁺ (4, balanced but unstable — falls to a neutron then β-decays to a proton), hydrogen p⁺e⁻ (5, stable, = 3 colour + charge + spin). Each difference is an orthogonal twist pair: charge lateral, spin transverse, colour internal" width="100%">

Bound states (atoms) join a heavy closure to a light partner, balanced. Leptons are **unlinked** twist-pair
loops (baryon number 0); the **proton is Borromean-linked** — three colour twist pairs, no two linked but
all three locked (baryon number 1, `QLF_BaryonWinding`), the stable nucleus. The stable rungs are the
neutrino, the electron, and the proton; the heavier leptons decay — the τ is too short-lived to bind, so
its balanced `τ⁻ e⁺` closure relaxes via a neutron that β-decays to the proton
([`Atomic_System_QLF_Closures.md`](Atomic_System_QLF_Closures.md) §6).

<img src="diagrams/atom_closures.svg" alt="Atom folds: a twist is two symbols, ^> leaving the electron and v< returning to close. positronium = e⁻ ^> v< (out and back to the positron); muonium = e⁻ ^> /v >\ v< (the muon is the two nucleus twists /v and >\); hydrogen = e⁻ ^> /v >\ +− v< (the nucleus extends the muon with the gauge/charge twist +−). Each added qubit adds a new direction; the fold opens and closes at the electron" width="100%">

The *number-of-differences* classification is a structural reading; the verified anchors are the three
generations, the proton's `π⁵`, and the Borromean baryon.

---

## Honest scope

- **Verified:** shells from Pauli exclusion; the `2ℓ+1` orbital dimensions; that `s, p, d` (1, 3, 5) are
  icosahedral-irrep-sized and `f` (7) is the first that is not. These are exact.
- **Cited (standard group theory), not derived here:** that `s, p, d` stay *unsplit* under icosahedral
  symmetry (the d-orbital non-splitting), and the `A₅` irrep list. The arithmetic match is *necessary,
  not sufficient*, for the unsplit-ness; the physics content is the cited branching.
- **A shared-representation resonance, NOT "atoms are icosahedral."** The actual atom is `SO(3)`-symmetric
  (fully rotational). The connection is that the discrete substrate symmetry `2I / A₅` renders to `SO(3)`
  in the continuum, and the low-`ℓ` irrep dimensions coincide — a resonance between the discrete substrate
  and the continuum orbital structure, not a replacement for quantum chemistry.
- **Cited, not re-proved here:** the α / fine-structure / mass-ratio results live in their own modules
  (`QLF_FineStructureSubstrate`, `QLF_DiracCorrection`, `QLF_LambShift`, `QLF_GMinusTwo`,
  `QLF_LenzMassRatio`).
- **Open:** the full periodic table, the many-electron Schrödinger/Dirac solution, electron correlation,
  and chemistry. QLF supplies the *origins* (exclusion, three axes, α, spin, the icosahedral irrep
  resonance), not the worked-out atomic physics.

## See also

- [`Magic_numbers.md`](Magic_numbers.md) — the `ℓ`/`j` shell model, magic numbers, the `ℓ≤2 / ℓ≥3`
  boundary.
- [`Geometry_Of_Space.md`](Geometry_Of_Space.md) §3c — orthogonality is one bit; the prime ladder
  (2, 3, 5, 7, 11, 13), where the d-orbital `ℓ=2` = `A₅`'s 5-dim irrep first appears.
- [`Alpha.md`](Alpha.md) — `α = 1/137` from the substrate.
- [`Primordial_Markov_Blankets.md`](Primordial_Markov_Blankets.md) — the icosahedral geodesic blanket and
  `2I → E₈`.
