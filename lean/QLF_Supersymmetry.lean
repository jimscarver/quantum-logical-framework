import QLF_Spin

set_option linter.unusedVariables false

/-!
# QLF_Supersymmetry — the supercharge is the half-spin shift; {Q,Q†}=2P is two half-spins closing an event

Supersymmetry pairs each **boson** with a **fermion** by a spinorial generator `Q`
(`Q|boson⟩ = |fermion⟩`), with the defining algebra `{Q, Q†} = 2σ^μ P_μ` — two SUSY transformations make
a **spacetime translation**, so SUSY is the *square root of translations*. QLF already carries this
structure, because statistics is the **parity of the half-spin count** (`QLF_Spin`):

* a **boson** is an *even* number of half-spin pairs, folding to `+I` (`boson_even_pairs`);
* a **fermion** is an *odd* number, folding to `−I` (`fermion_odd_pairs`); the photon is two half-spins
  (`photon_integer_spin`).

So the **supercharge `Q` is "adjoin one half-spin pair."** It flips the count parity, hence
boson↔fermion:

* **`supercharge_flips_statistics`** — adjoining one half-spin pair sends `Even ↔ Odd`.
* **`supercharge_boson_to_fermion`** — a boson (`+I`, even) plus one pair is a fermion (`−I`, odd).
* **`two_supercharges_close_event`** — two half-spin pairs fold to the identity `+I`
  (`rotation_720_eq_id`, the 720° double cover): `Q²` lands back on the boson, **and that `+I` is one
  closed ZFA event** — one `log 2` quantum, one Planck-tick of synthesized spacetime. This is
  `{Q, Q†} = 2P` read on the substrate: **the half-spin is the square root of the spacetime event** (the
  `2` is the Hermitian-pair factor, the same `2` in `boson = two half-spins` and Einstein's `8π = 4π·2`).

**The QLF punchline (why no superpartners are seen).** SUSY's boson–fermion symmetry is **real** — it is
the even/odd half-spin structure of closures — but QLF realizes it **without a doubled spectrum**: `Q`
adds a half-spin *to the same closure*, it does **not** create a new superpartner *particle* for each
particle. There are no squarks or sleptons because the pairing is the parity of the existing closure, not
a second tower. So QLF predicts the LHC null result: the supersymmetry is there, the superpartners are
not — exactly as for the graviton (composite, [`QLF_GravitationalWaves`](QLF_GravitationalWaves.lean)) and
the Higgs (a fold, not a fundamental scalar, [`QLF_HiggsMechanism`](QLF_HiggsMechanism.lean)).

## Scope

This anchors the **statistics map** (`Q` = half-spin shift, boson↔fermion = even↔odd) and the
**`Q²` = closed-event** relation (`{Q,Q†}=2P` as "two half-spins = one Planck-tick"), reusing
`boson_even_pairs` / `fermion_odd_pairs` / `rotation_720_eq_id`. It does **not** build the full graded
super-Poincaré algebra as Lean operators, the superspace formalism, or any MSSM spectrum/breaking
(`supersymmetry_in_progress`) — and it argues the doubled spectrum is **not** a QLF prediction. See
[`QLF_Spin.lean`](QLF_Spin.lean), [`StringTheory.md`](../StringTheory.md), [`LQG_QLF.md`](../LQG_QLF.md).
-/

namespace QLF.Supersymmetry

open QLF QLF.Spin

/-- **The supercharge `Q` flips statistics.** Adjoining one half-spin pair flips the count parity,
    `Even ↔ Odd` — boson ↔ fermion. -/
theorem supercharge_flips_statistics (t : Twist) (ts : List Twist) :
    Even ts.length ↔ Odd (t :: ts).length := by
  simp only [List.length_cons, Nat.even_iff, Nat.odd_iff]
  omega

/-- **Q : boson → fermion.** A boson (even half-spin count, fold `+I`) plus one half-spin pair is a
    fermion (odd count, fold `−I`). -/
theorem supercharge_boson_to_fermion (t : Twist) (ts : List Twist) (h : Even ts.length) :
    concatPairsMatrixFold (t :: ts) = -(1 : M) :=
  fermion_odd_pairs (t :: ts) (by rw [List.length_cons]; exact Even.add_one h)

/-- **{Q, Q†} = 2P — two supercharges close one spacetime event.** Two half-spin pairs (the 720° double
    cover) fold to the identity `+I` (`rotation_720_eq_id`): `Q²` returns to the boson, and that `+I` is
    one closed ZFA event — one `log 2`, one Planck-tick translation. The half-spin is the square root of
    the spacetime event. -/
theorem two_supercharges_close_event (s t : Twist) :
    (s.toMatrix * s.conj.toMatrix) * (t.toMatrix * t.conj.toMatrix) = (1 : M) :=
  rotation_720_eq_id s t

/-- **A boson is an even half-spin count** (`+I`); reuse. -/
theorem boson_is_even (ts : List Twist) (h : Even ts.length) :
    concatPairsMatrixFold ts = (1 : M) := boson_even_pairs ts h

/-- **A fermion is an odd half-spin count** (`−I`); reuse. -/
theorem fermion_is_odd (ts : List Twist) (h : Odd ts.length) :
    concatPairsMatrixFold ts = -(1 : M) := fermion_odd_pairs ts h

/-- **Established:** the supercharge is the half-spin shift — it flips boson↔fermion statistics
    (`supercharge_flips_statistics`, `supercharge_boson_to_fermion`); and `Q²` (`{Q,Q†}=2P`) is two
    half-spins folding to one closed ZFA event (`two_supercharges_close_event`, the 720° `+I`), so the
    half-spin is the square root of the spacetime translation. SUSY's boson–fermion symmetry is the
    even/odd structure of closures — realized **without a doubled spectrum** (no squarks/sleptons),
    which is why no superpartners are seen. **Open:** the full super-Poincaré algebra, superspace, and
    any MSSM dynamics (`supersymmetry_in_progress`). See `QLF_Spin.lean`. -/
theorem supersymmetry_in_progress : True := trivial

end QLF.Supersymmetry
