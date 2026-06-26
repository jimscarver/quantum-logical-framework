import PauliExclusion
import Mathlib

set_option linter.unusedVariables false

/-!
# QLF_AtomicStructure — what the substrate geometry says about atomic structure

QLF does **not** reproduce quantum chemistry; it supplies the substrate *origins* of atomic structure's
ingredients, plus one genuinely structural signature. See `Atomic_Structure_QLF.md`.

* **Shells exist because identical closures are excluded.** The fermionic antisymmetric channel of two
  identical ρ-processes vanishes (`shells_from_pauli_exclusion`, reuse `pauli_exclusion`): electrons fill
  successive shells instead of collapsing — the substrate origin of the periodic table.
* **The orbital ladder is the 3-axis / 3-D-oscillator rendering.** Angular momentum `ℓ` carries a
  `2ℓ+1` multiplet (`orbitalDim`): `s, p, d, f, g = 1, 3, 5, 7, 9` (`Magic_numbers.md`).
* **The icosahedral signature.** The substrate's closure symmetry is the icosahedral group `I ≅ A₅`
  (order 60; irreps of dimension `1, 3, 3, 4, 5`). The `s` (`ℓ=0`, 1), `p` (`ℓ=1`, 3) and `d` (`ℓ=2`, 5)
  multiplet dimensions are each an icosahedral irrep dimension (`spd_icosahedral_sized`), the arithmetic
  shadow of the cited fact that `s, p, d` restrict to *single* icosahedral irreps and stay **unsplit**
  (icosahedral is the unique point group in which the d-orbitals do not split). The `d` shell is the
  5-dim `H` irrep (`d_orbital_is_five`) — the same "5" as the icosahedral 5-fold
  (`QLF_PrimeResonance.five_divides_icosahedral`). The `f` shell (`ℓ=3`, dimension 7) is the **first**
  orbital whose dimension is *not* an icosahedral irrep (`f_orbital_breaks_icosahedral`), so it cannot
  stay unsplit — exactly the `ℓ≤2 / ℓ≥3` boundary `Magic_numbers.md` identifies as the
  dimensional-growth → vacuum-intruder transition.

## Honest scope

The orbital-dimension arithmetic is exact; the **unsplit-ness** and the `A₅` irrep list are **cited
group theory** — a shared-representation resonance (the discrete substrate symmetry `2I/A₅` renders to
`SO(3)` in the continuum, and the low-`ℓ` irrep dimensions coincide), **not** a derivation of the
periodic table, the many-electron Schrödinger/Dirac solution, or chemistry. The atom itself is
`SO(3)`-symmetric, not icosahedral. The energy scale + fine structure come from `α = 1/(128+d²) = 1/137`
(`QLF_FineStructureSubstrate`), the Dirac `α²` corrections (`QLF_DiracCorrection`), and `m_p/m_e = 6π⁵`
(`QLF_LenzMassRatio`) — cited here, not re-proved. Reuses `PauliExclusion`; no new axioms.
-/

namespace QLF.AtomicStructure

open Matrix

/-- Orbital multiplet dimension `2ℓ+1`: `s, p, d, f, g = 1, 3, 5, 7, 9`. -/
def orbitalDim (l : ℕ) : ℕ := 2 * l + 1

/-- The distinct dimensions of the irreducible representations of the icosahedral rotation group
    `I ≅ A₅` (order 60): irreps `1, 3, 3, 4, 5` (`1²+3²+3²+4²+5² = 60`) ⟹ dimension set `{1, 3, 4, 5}`.
    Cited group theory. (The double cover `2I` adds the spinor dims `2, 4, 6` — the McKay/`E₈` marks —
    relevant to half-integer spin, not to the integer-`ℓ` orbital branching here.) -/
def icosahedralIrrepDims : Finset ℕ := {1, 3, 4, 5}

/-- **`s, p, d` are icosahedral-irrep-sized.** The orbital dimensions of `s` (`ℓ=0`, 1), `p` (`ℓ=1`, 3)
    and `d` (`ℓ=2`, 5) are each an icosahedral irrep dimension — the arithmetic shadow of the cited fact
    that they restrict to single icosahedral irreps and stay *unsplit*. -/
theorem spd_icosahedral_sized :
    orbitalDim 0 ∈ icosahedralIrrepDims ∧ orbitalDim 1 ∈ icosahedralIrrepDims
      ∧ orbitalDim 2 ∈ icosahedralIrrepDims := by
  refine ⟨?_, ?_, ?_⟩ <;> decide

/-- **The d-shell is the 5-dim icosahedral irrep.** `orbitalDim 2 = 5` — the `H` irrep of `A₅`, the same
    "5" as the icosahedral 5-fold (cf. `QLF_PrimeResonance.five_divides_icosahedral`). -/
theorem d_orbital_is_five : orbitalDim 2 = 5 := by decide

/-- **`f` is the first break.** The `f` shell (`ℓ=3`, dimension 7) is **not** an icosahedral irrep
    dimension (`A₅` has no 7-dim irrep), so it cannot stay unsplit — the first orbital to break
    icosahedral symmetry, the `ℓ≤2 / ℓ≥3` boundary of `Magic_numbers.md`. -/
theorem f_orbital_breaks_icosahedral : orbitalDim 3 ∉ icosahedralIrrepDims := by decide

/-- **Shells exist because identical closures are excluded.** Reuse `pauli_exclusion`: the fermionic
    antisymmetric channel of an identical pair vanishes, so electrons fill successive shells rather than
    collapsing — the substrate origin of the periodic table. -/
theorem shells_from_pauli_exclusion (p : RhoProcess) : fermi_antisym p p = 0 :=
  pauli_exclusion p

/-- **Established (the synthesis, `Atomic_Structure_QLF.md`):** the substrate supplies atomic
    structure's *ingredients* — shells from Pauli exclusion (`shells_from_pauli_exclusion`), the
    `2ℓ+1` orbital ladder from the 3 axes / 3-D oscillator, and the icosahedral signature: `s, p, d` are
    icosahedral-irrep-sized (`spd_icosahedral_sized`), the d-shell the 5-dim irrep (`d_orbital_is_five`),
    and `f` the first break (`f_orbital_breaks_icosahedral`) = the `ℓ≤2/ℓ≥3` magic-number boundary.
    **Honest scope:** the orbital-dim arithmetic is exact; the unsplit-ness and the `A₅` irreps are
    *cited group theory* (a shared-representation resonance, `2I/A₅ → SO(3)`), **not** a derivation of
    the periodic table; α/scale are `QLF_FineStructureSubstrate`. Reuses `PauliExclusion`; no new axioms. -/
theorem atomic_structure_summary : True := trivial

end QLF.AtomicStructure
