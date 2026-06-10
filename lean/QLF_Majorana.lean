import QLF_TwistAlphabet

set_option linter.unusedVariables false

/-!
# QLF_Majorana — the neutrino is its own antiparticle (Majorana), the electron is not (Dirac)

In QLF the **antiparticle** of a configuration is its **Hermitian conjugate**
([`Annihilation.md`](../Annihilation.md)): conjugate every twist (`Twist.conj`,
`QLF_TwistAlphabet`) and **reverse the order**, since the adjoint of a product
reverses it, `(A·B·C)† = C†·B†·A†`. A particle is **Majorana** (its own
antiparticle) exactly when its twist history is a *fixed point* of this operation —
a decidable property of the string.

* `neutrino_majorana`     — the neutrino loop `^v` **is** a fixed point ⇒ Majorana.
* `electron_not_majorana` — the electron loop `^<v>` is **not** ⇒ Dirac (a distinct
  positron). So the test is not vacuous: it separates the unique self-conjugate
  fermion from the rest.
* `antiparticle_involutive` — `(A†)† = A`, as a particle/antiparticle relation must be.

This is why the neutrino is the *unique* Majorana fermion: being the only fermion
with neither charge nor a chiral/linked structure, its minimal non-chiral loop is
the only one symmetric under conjugate-and-reverse. (Charged/chiral histories pick
up an order they cannot match after reversal.) The result is **conditional** on two
QLF inputs — the assignment neutrino `= ^v`, and antiparticle `=` Hermitian
conjugate — but *given* those it is proved, not merely argued. It also forces zero
net winding on the neutrino (a fixed point of an orientation-odd map has winding 0),
matching [`winding_invariant_demo.py`](../winding_invariant_demo.py).
-/

namespace QLF.Majorana

open QLF

/-- The **antiparticle** of a twist history: Hermitian conjugate = conjugate each
    twist and reverse the order (`(A·B·C)† = C†·B†·A†`). -/
def antiparticle (ts : List Twist) : List Twist := (ts.map Twist.conj).reverse

/-- **Majorana** = its own antiparticle = a fixed point of the Hermitian conjugate. -/
abbrev Majorana (ts : List Twist) : Prop := antiparticle ts = ts

/-- Conjugating a single twist twice is the identity. -/
theorem Twist.conj_conj (t : Twist) : Twist.conj (Twist.conj t) = t := by
  cases t <;> rfl

/-- **The neutrino loop `^v` is Majorana** — its own Hermitian conjugate. -/
theorem neutrino_majorana : Majorana [Twist.up, Twist.down] := by decide

/-- **The electron loop `^<v>` is NOT Majorana** — its Hermitian conjugate is a
    distinct history (the positron); the charged lepton is Dirac. -/
theorem electron_not_majorana :
    ¬ Majorana [Twist.up, Twist.left, Twist.down, Twist.right] := by decide

/-- The antiparticle map is an involution: `(A†)† = A`. -/
theorem antiparticle_involutive (ts : List Twist) :
    antiparticle (antiparticle ts) = ts := by
  unfold antiparticle
  rw [List.map_reverse, List.reverse_reverse, List.map_map]
  have hcc : (Twist.conj ∘ Twist.conj) = id := by
    funext t; exact Twist.conj_conj t
  rw [hcc, List.map_id]

end QLF.Majorana
