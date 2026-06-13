import QLF_BaryonWinding
import PauliExclusion

set_option linter.unusedVariables false

/-!
# QLF_Spin — spin demystified: spin IS the QLF twists

Standard spin is opaque: a 720° turn to return, a "magnetic moment" tangled up with a
"charge". QLF dissolves the mystery by showing spin is *literally* the twists — the
σ-matrix generators of the 8-twist alphabet (`^v = ±σ_y`, `<> = ∓σ_x`, `/\ = ±σ_z`,
`+− = ±I`, `QLF_TwistAlphabet`). A particle carries **two independent 720° half-spins**:

* a **perpendicular / chiral** component whose handedness *relative to motion* is what
  electric charge *is* — a positron coming toward you reads clockwise, but seen from
  behind it is counterclockwise, i.e. an electron of opposite charge. So **charge
  conjugation = viewing from behind = reversal**, the antiparticle map
  `(ts.map Twist.conj).reverse` (`QLF_Majorana`). Under it BOTH a winding/chirality
  invariant and the charge **negate together** (`C_eq_motional_reversal`).
* a **flat up/down** component, *independent of motion*, that is the magnetic moment
  (`magneticMoment`) — Stern–Gerlach, magnetism (`Magnetism_Spatial_Dynamics.md`).
  Reversing motion flips the chiral/charge component but leaves the flat one fixed
  (`flat_independent_of_motion`): the formal statement of "two independent axes".

The 720° double cover is the `−I` fold of one Hermitian twist pair
(`hermitian_pair_folds_to_negI`): 360° = one pair = `−I`, 720° = two pairs = `+I`. Same
`+I` closure is the opposite-spin **singlet** (annihilation), and like-spin fermions
**exclude** (`pauli_exclusion`). The **neutrino** `^v` is the self-conjugate (Majorana)
spin — the same from behind — hence **neutral** (`neutrino_neutral`); the electron is
Dirac (`electron_not_majorana`).

Every dynamical claim below reduces to an already-proven theorem. The physical
identifications (`perpChirality`, `chiralCharge`, `magneticMoment`) are *naming* defs —
which twist invariant we call charge / chirality / magnetic moment — not axioms. See
`Spin_QLF.md`.
-/

namespace QLF.Spin

open QLF QLF.Majorana QLF.BaryonWinding

-- ==========================================================================
-- 1. The 720° double cover — spin's "turn twice to return"
-- ==========================================================================

/-- **360° = one Hermitian twist pair folds to `−I`** — the fermion's sign flip under a
    single full turn. Direct reuse of `hermitian_pair_folds_to_negI`. -/
theorem rotation_360_eq_negI (t : Twist) :
    t.toMatrix * t.conj.toMatrix = -(1 : M) :=
  hermitian_pair_folds_to_negI t

/-- **720° = two Hermitian pairs fold to `+I`** — identity restored only after a double
    turn. This `+I` is also the opposite-spin singlet closure (see
    `opposite_spin_singlet_closes`): the double cover and annihilation are one fact. -/
theorem rotation_720_eq_id (s t : Twist) :
    (s.toMatrix * s.conj.toMatrix) * (t.toMatrix * t.conj.toMatrix) = (1 : M) := by
  rw [hermitian_pair_folds_to_negI s, hermitian_pair_folds_to_negI t, neg_mul_neg, one_mul]

/-- The same `+I` via the canonical even-pair fold (`concat_pairs_even`, N = 2 pairs). -/
theorem rotation_720_concat (s t : Twist) :
    concatPairsMatrixFold [s, t] = (1 : M) :=
  concat_pairs_even [s, t] (by decide)

-- ==========================================================================
-- 2. Charge conjugation = viewing from behind = reversal
-- ==========================================================================

/-- **Perpendicular-spin chirality** = the 3-axis winding sign (`baryonNumber`). The
    "handedness relative to the observer" is an orientation-odd winding; viewing from
    behind reverses it. A naming def. -/
def perpChirality (ts : List Twist) : Int := baryonNumber ts

/-- Viewing from behind (the antiparticle = conjugate-and-reverse) **flips the
    perpendicular chirality**. Direct reuse of `baryon_dagger_odd`. -/
theorem perpChirality_conj (ts : List Twist) :
    perpChirality (antiparticle ts) = - perpChirality ts := by
  unfold perpChirality; exact baryon_dagger_odd ts

/-- **Electric-charge weight on a twist**: the gauge pair carries the sign (`+` = +1,
    `−` = −1); spatial twists are charge-neutral. The twist-alphabet analog of
    `QLF_BMinusL.chargeWeight`. -/
def twistCharge : Twist → Int
  | Twist.plus  => 1
  | Twist.minus => -1
  | _ => 0

/-- **Charge** of a twist history = the signed gauge count. -/
def chiralCharge (ts : List Twist) : Int := (ts.map twistCharge).sum

/-- Conjugating a twist negates its charge (`+ ↔ −`). -/
theorem twistCharge_conj (t : Twist) : twistCharge (Twist.conj t) = - twistCharge t := by
  cases t <;> decide

private theorem chiralCharge_append (l : List Twist) (x : Twist) :
    chiralCharge (l ++ [x]) = chiralCharge l + twistCharge x := by
  simp [chiralCharge, List.map_append, List.sum_append, List.map_cons, List.map_nil,
    List.sum_cons, List.sum_nil]

private theorem antiparticle_cons (a : Twist) (rest : List Twist) :
    antiparticle (a :: rest) = antiparticle rest ++ [Twist.conj a] := by
  simp [antiparticle, List.map_cons, List.reverse_cons]

/-- Viewing from behind **negates the charge** — a positron read from behind carries the
    electron's charge. (`reverse` preserves the sum; `conj` negates each term.) -/
theorem chiralCharge_conj (ts : List Twist) :
    chiralCharge (antiparticle ts) = - chiralCharge ts := by
  induction ts with
  | nil => simp [chiralCharge, antiparticle]
  | cons a rest ih =>
    rw [antiparticle_cons, chiralCharge_append, ih, twistCharge_conj]
    simp only [chiralCharge, List.map_cons, List.sum_cons]
    ring

/-- **Charge conjugation = motional reversal.** Under "viewing from behind"
    (`antiparticle` = conjugate-and-reverse) the **charge and the perpendicular
    chirality co-negate** — a positron coming toward you reads, from behind, as an
    electron: opposite charge *and* opposite handedness, together. -/
theorem C_eq_motional_reversal (ts : List Twist) :
    chiralCharge (antiparticle ts) = - chiralCharge ts ∧
    perpChirality (antiparticle ts) = - perpChirality ts :=
  ⟨chiralCharge_conj ts, perpChirality_conj ts⟩

-- ==========================================================================
-- 3. The neutrino — the self-conjugate spin is neutral
-- ==========================================================================

/-- **A Majorana spin (its own antiparticle) is neutral**: self-conjugacy forces both
    its charge and its perpendicular chirality to vanish (`x = −x ⟹ x = 0`). Looking
    the same from behind leaves no charge handedness. -/
theorem majorana_is_neutral (ts : List Twist) (h : Majorana ts) :
    chiralCharge ts = 0 ∧ perpChirality ts = 0 := by
  have hc := chiralCharge_conj ts
  have hp := perpChirality_conj ts
  rw [h] at hc hp
  exact ⟨by omega, by omega⟩

/-- **The neutrino `^v` is neutral** — it is the Majorana fixed point
    (`neutrino_majorana`), so it has no charge and no perpendicular chirality: a pure
    (σ_y) flat spin, the same viewed from behind. The electron is *not* self-conjugate
    (`electron_not_majorana`), so it is a charged Dirac particle. -/
theorem neutrino_neutral :
    chiralCharge [Twist.up, Twist.down] = 0 ∧ perpChirality [Twist.up, Twist.down] = 0 :=
  majorana_is_neutral _ neutrino_majorana

-- ==========================================================================
-- 4. Exclusion and annihilation
-- ==========================================================================

/-- **Like-spin exclusion**: two identical fermionic processes anticommute to zero — the
    Pauli exclusion principle, reused verbatim (`pauli_exclusion`). Same-flat-spin
    fermions cannot co-occupy. -/
theorem like_spin_excludes (p : RhoProcess) : fermi_antisym p p = 0 :=
  pauli_exclusion p

/-- **Opposite-spin singlet closes (annihilation)**: two `−I` half-spin folds compose to
    `+I` — a fully closed (ZFA) pair that annihilates to vacuum. The same `+I` as the
    720° return (`rotation_720_eq_id`): annihilation and the double cover are one fact. -/
theorem opposite_spin_singlet_closes (s t : Twist) :
    (s.toMatrix * s.conj.toMatrix) * (t.toMatrix * t.conj.toMatrix) = (1 : M) := by
  rw [hermitian_pair_folds_to_negI s, hermitian_pair_folds_to_negI t, neg_mul_neg, one_mul]

-- ==========================================================================
-- 5. Magnetism — the flat axis, independent of motion
-- ==========================================================================

/-- A ± orientation. -/
inductive Sign | plus | minus
deriving DecidableEq, Repr

def Sign.neg : Sign → Sign
  | Sign.plus => Sign.minus
  | Sign.minus => Sign.plus

/-- The two-axis spin descriptor: a **chiral** sign (relative to motion → charge sense)
    and a **flat** up/down sign (independent of motion → magnetic moment). -/
structure Spin where
  perp : Sign
  flat : Sign
deriving DecidableEq, Repr

/-- The **magnetic moment** is the flat spin component (Stern–Gerlach up/down). -/
def magneticMoment (sp : Spin) : Sign := sp.flat

/-- **The flat axis is independent of motion.** Reversing motion flips the chiral/charge
    component (`perp`, cf. `C_eq_motional_reversal`) but leaves the magnetic moment
    fixed — the formal content of "two independent spin axes". -/
theorem flat_independent_of_motion (sp : Spin) :
    magneticMoment { perp := sp.perp.neg, flat := sp.flat } = magneticMoment sp := rfl

end QLF.Spin
