import QLF_Majorana

set_option linter.unusedVariables false

/-!
# QLF_BaryonWinding — baryon number as a signed 3-axis linking (winding) invariant

We proved B−L is **not** a weight dictionary (it is winding, not a count;
`QLF_BMinusL`). Baryon number is the concrete realisation: a **signed 3-axis
linking number**. Slide a 3-element window along a twist history and add an
oriented sign for each window that spans **all three** spatial axes
(`x = </>`, `y = ^/v`, `z = //\`): `+1` for a cyclic `(x,y,z)` triple, `−1` for an
anticyclic one, `0` otherwise (gauge twists carry no axis, so any window touching
one contributes 0).

This is a **winding** invariant, not a signed count: it is non-zero on closures and
sequence-dependent. It behaves like baryon number:

* `baryon_proton` / `baryon_antiproton` — a minimal Borromean 3-axis loop has
  `B = +1`; its antiparticle (Hermitian conjugate, `QLF_Majorana`) has `B = −1`.
* `baryon_electron`, `baryon_neutrino` — leptons (≤ 2 axes) have `B = 0`.
* `baryon_meson` — a quark loop with its antiparticle (q q̄) cancels to `B = 0`.
* `signTriple_noZ` / `baryon_zero_of_noZ` — **general**: any history with no
  `z`-axis (`/`,`\`) twist has `B = 0`, so the entire lepton / electromagnetic
  sector (built from `^v<>` and the gauge folds) is baryon-neutral.

Conditional on the twist→axis dictionary; the proton calibration `B(minimal
Borromean triple)=1` is an assignment (quark twist strings remain open). The
exhaustively-checked properties (dagger-oddness `B(†ts)=−B(ts)`; no-z ⟹ 0) are in
[`baryon_winding_demo.py`](../baryon_winding_demo.py); `baryon_zero_of_noZ` anchors
the second here. The general dagger-oddness theorem is the remaining Lean target.
-/

namespace QLF.BaryonWinding

open QLF QLF.Majorana

/-- The three spatial axes. -/
inductive Ax | x | y | z
  deriving DecidableEq, Fintype

/-- Spatial axis of a twist; gauge twists (`+`,`−`) have none. -/
def axOf : Twist → Option Ax
  | Twist.left      => some Ax.x
  | Twist.right     => some Ax.x
  | Twist.up        => some Ax.y
  | Twist.down      => some Ax.y
  | Twist.slash     => some Ax.z
  | Twist.backslash => some Ax.z
  | Twist.plus      => none
  | Twist.minus     => none

/-- Oriented all-three-axes sign: `+1` cyclic `(x,y,z)`, `−1` anticyclic, `0` else. -/
def signTriple : Option Ax → Option Ax → Option Ax → Int
  | some Ax.x, some Ax.y, some Ax.z => 1
  | some Ax.y, some Ax.z, some Ax.x => 1
  | some Ax.z, some Ax.x, some Ax.y => 1
  | some Ax.x, some Ax.z, some Ax.y => -1
  | some Ax.z, some Ax.y, some Ax.x => -1
  | some Ax.y, some Ax.x, some Ax.z => -1
  | _, _, _ => 0

/-- **Baryon number** = signed 3-axis linking: sum the oriented all-three-axes
    triples over every consecutive 3-window. -/
def baryonNumber : List Twist → Int
  | a :: b :: c :: rest => signTriple (axOf a) (axOf b) (axOf c) + baryonNumber (b :: c :: rest)
  | _ => 0

-- ===== Calibration =====

/-- A minimal Borromean 3-axis loop (`>^/` = `x,y,z`) has baryon number `+1`. -/
theorem baryon_proton : baryonNumber [Twist.right, Twist.up, Twist.slash] = 1 := by decide

/-- Its antiparticle (Hermitian conjugate) has baryon number `−1`. -/
theorem baryon_antiproton :
    baryonNumber (antiparticle [Twist.right, Twist.up, Twist.slash]) = -1 := by decide

/-- The electron loop `^<v>` (two axes) has baryon number `0`. -/
theorem baryon_electron :
    baryonNumber [Twist.up, Twist.left, Twist.down, Twist.right] = 0 := by decide

/-- The neutrino loop `^v` has baryon number `0`. -/
theorem baryon_neutrino : baryonNumber [Twist.up, Twist.down] = 0 := by decide

/-- A quark loop with its antiparticle (`q q̄`, a meson) cancels to baryon number `0`. -/
theorem baryon_meson :
    baryonNumber ([Twist.right, Twist.up, Twist.slash] ++
                  antiparticle [Twist.right, Twist.up, Twist.slash]) = 0 := by decide

-- ===== General: the lepton / electromagnetic sector is baryon-neutral =====

/-- Without a `z`-axis twist, no window spans all three axes, so the sign is `0`. -/
theorem signTriple_noZ : ∀ (oa ob oc : Option Ax),
    oa ≠ some Ax.z → ob ≠ some Ax.z → oc ≠ some Ax.z → signTriple oa ob oc = 0 := by
  decide

/-- **Any history with no `z`-axis (`/`,`\`) twist has baryon number `0`.** Covers
    the whole lepton / EM sector (built from `^v<>` and the gauge folds). -/
theorem baryon_zero_of_noZ :
    ∀ (ts : List Twist), (∀ t ∈ ts, axOf t ≠ some Ax.z) → baryonNumber ts = 0
  | [], _ => rfl
  | [_], _ => rfl
  | [_, _], _ => rfl
  | a :: b :: c :: rest, h => by
      have hs := signTriple_noZ (axOf a) (axOf b) (axOf c)
        (h a (List.Mem.head _))
        (h b (List.Mem.tail _ (List.Mem.head _)))
        (h c (List.Mem.tail _ (List.Mem.tail _ (List.Mem.head _))))
      have ih := baryon_zero_of_noZ (b :: c :: rest) (fun t ht => h t (List.Mem.tail _ ht))
      rw [baryonNumber, hs, zero_add]; exact ih

end QLF.BaryonWinding
