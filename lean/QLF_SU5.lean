import Mathlib.Data.Nat.Choose.Basic

set_option linter.unusedVariables false

/-!
# QLF_SU5 — the SU(5) fundamental and the `5̄ ⊕ 10` generation as QLF's `3 ⊕ 2` substrate

QLF already reproduces SU(5)'s one robust, parameter-free success — `sin²θ_W = 3/8` — as the
**spatial fraction** of the 8-twist alphabet (`QLF_WeinbergAngle`), with the SU(5) "`5 = 3 colour +
2 weak`" being QLF's "3 spatial axes + 2 gauge twists." This module anchors the *next* SU(5) datum:
the **fermion content of one generation**.

In SU(5) a generation is `5̄ ⊕ 10 = 15` left-handed Weyl fermions. That `15` is **not** an extra
input — it is exactly the **antisymmetric tensor content of rank ≤ 2 over the fundamental `5`**:

* rank 1 → the `5` (conjugated to `5̄`), and
* rank 2 → `Λ²(5)`, the antisymmetric pairs, of dimension `C(5,2) = 10`.

QLF identifies that fundamental with its own substrate split **`5 = 3 ⊕ 2`** (3 spatial/colour axes
⊕ 2 gauge/weak), the *same* `3+2` that fixes `α` (`N=3²=9`), `Ω_Λ` (gauge `2/8`), and `sin²θ_W`
(`3/8`). Then the whole generation decomposes from that split alone:

* **`5̄ = 3̄ ⊕ 2`** — `d^c` (anti-down colour triplet) ⊕ `(ν, e)` lepton doublet  ⇒ `3 + 2 = 5`.
* **`10 = Λ²(3⊕2) = Λ²3 ⊕ (3⊗2) ⊕ Λ²2`** — `u^c` (`Λ²3 = 3̄`, `C(3,2)=3`) ⊕ `Q` (`3⊗2`, `3·2=6`) ⊕
  `e^c` (`Λ²2 = 1`, `C(2,2)=1`)  ⇒ `3 + 6 + 1 = 10`.
* **Total `5̄ ⊕ 10 = 5 + 10 = 15`.**

Two QLF readings ride along: the antisymmetry of the `10` **is the Pauli/fermionic antisymmetrisation**
(`pauli_exclusion`) — fermions wedge — so a generation is literally the *fermionic* tensor content of
the `3⊕2` substrate; and the count is **15, not SO(10)'s 16** (the extra singlet is `ν_R`), which is
exactly what QLF's **Majorana neutrino** wants — no independent light Dirac `ν_R` (any `ν_R` is the
heavy Majorana/seesaw partner, a sterile pure-gauge sequence).

## Honest scope

This anchors the **counting and the group-theoretic decomposition** of one generation *under the
`5 = 3 ⊕ 2` identification* — `15 = 5 + C(5,2)`, with `C(5,2) = C(3,2) + 3·2 + C(2,2) = 3+6+1`. It
does **not** derive the hypercharges, the chirality (why all left-handed Weyl), or map each of the 15
states to a specific twist closure (`su5_generation_content_in_progress`). The `5̄⊕10 = Λ^{≤2}(5)` is
standard SU(5) representation theory; QLF's content is the *identification of the 5 with its own 3+2
substrate*, making the generation content the antisymmetric tensor algebra of the same split behind
the constants. See `Forces_From_Three_Axes.md`, `Weak_Force.md` §2, `Standard_Model.md`.
-/

namespace QLF.SU5

/-- The 3 spatial / colour axes of the substrate. -/
def colour : ℕ := 3

/-- The 2 gauge / weak directions of the substrate. -/
def weak : ℕ := 2

/-- **The SU(5) fundamental is QLF's `3 ⊕ 2`**: `5 = colour + weak`. -/
def fundamental : ℕ := colour + weak

theorem fundamental_eq_five : fundamental = 5 := by decide

/-- The antisymmetric rank-2 tensor `Λ²(5)` — the `10` of SU(5). -/
def antisym2 : ℕ := Nat.choose fundamental 2

theorem antisym2_eq_ten : antisym2 = 10 := by decide

/-- **One generation = `5̄ ⊕ 10`** = the rank-≤2 antisymmetric content of the fundamental. -/
def generation : ℕ := fundamental + antisym2

/-- **`5̄ ⊕ 10 = 15`** — the Standard-Model Weyl-fermion count of one generation, from `5 = 3⊕2`. -/
theorem generation_eq_fifteen : generation = 15 := by decide

/-- **The `10` decomposes under `5 = 3⊕2` as `Λ²3 ⊕ (3⊗2) ⊕ Λ²2`** = `u^c ⊕ Q ⊕ e^c` =
    `3 + 6 + 1`. -/
theorem ten_decomposition :
    Nat.choose colour 2 + colour * weak + Nat.choose weak 2 = antisym2 := by decide

/-- The pieces named: `u^c = Λ²3 = C(3,2) = 3`, `Q = 3⊗2 = 6`, `e^c = Λ²2 = C(2,2) = 1`. -/
theorem ten_pieces :
    Nat.choose colour 2 = 3 ∧ colour * weak = 6 ∧ Nat.choose weak 2 = 1 := by decide

/-- **`5̄` decomposes as `3̄ ⊕ 2`** = `d^c ⊕ (ν,e)` = `3 + 2`. -/
theorem fivebar_decomposition : colour + weak = fundamental := by decide

/-- The SO(10) generation adds one singlet (`ν_R`): `16 = 15 + 1`. QLF's **Majorana** neutrino means
    no independent *light* Dirac `ν_R`, so QLF's observable generation is the SU(5) **15**, not the
    SO(10) 16 (any `ν_R` is the heavy seesaw partner). -/
def so10_generation : ℕ := generation + 1

theorem so10_eq_sixteen : so10_generation = 16 := by decide

/-- **Established constructively:** one fermion generation is `5̄ ⊕ 10 = 15` (`generation_eq_fifteen`),
    the rank-≤2 antisymmetric tensor content of the SU(5) fundamental `5`, which QLF *identifies with
    its own substrate split* `5 = colour(3) ⊕ weak(2)` (`fundamental_eq_five`) — the same `3+2` behind
    `α`, `Ω_Λ`, and `sin²θ_W = 3/8`. The `10` decomposes as `u^c ⊕ Q ⊕ e^c = 3+6+1`
    (`ten_decomposition`, `ten_pieces`); the antisymmetry is Pauli; the count is 15 (not SO(10)'s 16),
    matching the Majorana neutrino. **Open:** hypercharges, chirality, and the per-field twist-closure
    map (`su5_generation_content_in_progress`). -/
theorem su5_generation_content_in_progress : True := trivial

end QLF.SU5
