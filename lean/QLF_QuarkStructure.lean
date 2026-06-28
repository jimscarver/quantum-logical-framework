import QLF_BaryonWinding

set_option linter.unusedVariables false

/-!
# QLF_QuarkStructure — what the nucleon knot proves about quarks

The `Atomic_Structure_QLF.md` §7 / `Quarks.md` reading of the baryon as a knot of
closures across three colour axes is anchored here. `QLF_BaryonWinding` showed a
single missing axis (no `z`) forces `baryonNumber = 0`. We generalise that to **any**
axis and read off the **Borromean three-colour necessity**:

* `signTriple_missing` — a 3-window missing any one axis cannot span all three, so its
  oriented sign is `0` (the `signTriple_noZ` fact, for every axis at once).
* `baryon_zero_of_missing` — if some colour axis never appears in a history, its baryon
  number is `0` (generalises `baryon_zero_of_noZ`).
* `baryon_needs_axis` / `baryon_needs_all_three_axes` — **the keystone**: a non-zero
  baryon number requires a twist on *every* colour axis. Remove any one colour and
  `B = 0` — no two-colour (or one-colour) state is a baryon. This is confinement as a
  Borromean necessity: the three quarks are the three axes, all three required to close.
* `minimal_baryon_one_per_axis` — the minimal baryon `>^/` carries exactly one twist on
  each axis: three quarks = the three axes.

Reuse-only (no new axioms): everything follows from `signTriple`/`baryonNumber`
(`QLF_BaryonWinding`). The per-flavour (u/d) twist assignment and quark masses stay
open (`Forces_From_Three_Axes.md` §4). See `Quarks.md`.
-/

namespace QLF.QuarkStructure

open QLF QLF.BaryonWinding

/-- A 3-window missing any single axis `a` cannot span all three axes, so its oriented
    linking sign is `0`. (The `signTriple_noZ` fact, uniformly over every axis.) -/
theorem signTriple_missing : ∀ (a : Ax) (oa ob oc : Option Ax),
    oa ≠ some a → ob ≠ some a → oc ≠ some a → signTriple oa ob oc = 0 := by decide

/-- **If some colour axis never appears, baryon number is `0`.** Generalises
    `baryon_zero_of_noZ` from the `z` axis to any axis. -/
theorem baryon_zero_of_missing (a : Ax) :
    ∀ (ts : List Twist), (∀ t ∈ ts, axOf t ≠ some a) → baryonNumber ts = 0
  | [], _ => rfl
  | [_], _ => rfl
  | [_, _], _ => rfl
  | t0 :: b :: c :: rest, h => by
      have hs := signTriple_missing a (axOf t0) (axOf b) (axOf c)
        (h t0 (List.Mem.head _))
        (h b (List.Mem.tail _ (List.Mem.head _)))
        (h c (List.Mem.tail _ (List.Mem.tail _ (List.Mem.head _))))
      have ih := baryon_zero_of_missing a (b :: c :: rest) (fun t ht => h t (List.Mem.tail _ ht))
      rw [baryonNumber, hs, zero_add]; exact ih

/-- A non-zero baryon number requires a twist on the given colour axis `a`: if `a` were
    absent, `B` would be `0`. -/
theorem baryon_needs_axis (a : Ax) (ts : List Twist) (h : baryonNumber ts ≠ 0) :
    ∃ t ∈ ts, axOf t = some a := by
  by_contra hcon
  push_neg at hcon
  exact h (baryon_zero_of_missing a ts hcon)

/-- **The Borromean three-colour necessity (confinement, geometric).** A non-zero
    baryon number requires a twist on *every* colour axis `x, y, z` — remove any one
    colour and `B = 0`. So a baryon needs all three quarks/axes; no two-colour or
    one-colour state is a baryon. -/
theorem baryon_needs_all_three_axes (ts : List Twist) (h : baryonNumber ts ≠ 0) :
    (∃ t ∈ ts, axOf t = some Ax.x) ∧
    (∃ t ∈ ts, axOf t = some Ax.y) ∧
    (∃ t ∈ ts, axOf t = some Ax.z) :=
  ⟨baryon_needs_axis Ax.x ts h, baryon_needs_axis Ax.y ts h, baryon_needs_axis Ax.z ts h⟩

/-- The minimal baryon `>^/` carries exactly one twist on each colour axis:
    three quarks = the three axes. -/
theorem minimal_baryon_one_per_axis :
    axOf Twist.right = some Ax.x ∧ axOf Twist.up = some Ax.y ∧ axOf Twist.slash = some Ax.z := by
  decide

/-- **No single-colour baryon (the lone quark, confined).** A history living on one
    colour axis `a` (plus gauge) has `baryonNumber = 0`: the other two axes are absent,
    so by `baryon_zero_of_missing` it is not a baryon. A lone quark's colour content
    cannot be a baryon — only the full three-colour Borromean triple can. -/
theorem single_colour_not_baryon (a : Ax) (ts : List Twist)
    (honly : ∀ t ∈ ts, axOf t = some a ∨ axOf t = none) : baryonNumber ts = 0 := by
  obtain ⟨b, hb⟩ : ∃ b : Ax, b ≠ a := by
    cases a
    · exact ⟨Ax.y, by decide⟩
    · exact ⟨Ax.x, by decide⟩
    · exact ⟨Ax.x, by decide⟩
  refine baryon_zero_of_missing b ts (fun t ht => ?_)
  rcases honly t ht with h | h
  · rw [h]; simp only [ne_eq, Option.some.injEq]; exact hb.symm
  · rw [h]; simp

/-! ## Charge quantisation in thirds, from the three colours

The SU(5)-style charge-quantisation argument: in a multiplet the charges are traceless
(sum to `0`). With `n` equal colour copies of charge `q` and an integer-charge remainder
`L`, tracelessness forces `q = −L/n` — the **charge quantum is `1/n`**. QLF has `n = 3`
colours (= the 3 spatial axes), so quark charge is a multiple of `1/3`. The multiplet
content (the lepton charges) is the SU(5) input; what the three colours force is the
*thirds*. -/

/-- **The charge quantum is `1/n` for `n` colours.** Tracelessness `n·q + L = 0` with an
    integer-charge remainder `L` forces `q = −L/n`. (Charge quantisation from the colour
    count; QLF's `n = 3` gives thirds.) -/
theorem charge_quantum_from_colours (n : ℕ) (hn : (n : ℚ) ≠ 0) (q L : ℚ)
    (traceless : (n : ℚ) * q + L = 0) : q = - L / n := by
  rw [eq_div_iff hn]; linear_combination traceless

/-- **The down quark is `−1/3`, forced by the three colours.** The SU(5) `5̄` = three
    colour copies of `d^c` (charge `q`) + a lepton doublet of net charge `−1`;
    tracelessness `3·q + (−1) = 0` forces `q = 1/3` (so the down quark is `−1/3`). The
    thirds come from the **three** colours. -/
theorem down_quark_charge_third (q : ℚ) (traceless : (3 : ℚ) * q + (-1) = 0) : q = 1/3 := by
  linarith

end QLF.QuarkStructure
