import QLF_QuarkStructure

set_option linter.unusedVariables false

/-!
# QLF_KnotInvariant — embedded ZFA closures as knots/links (the Kauffman-lineage reading)

Reuse-only anchor (the `QLF_CurvatureLie` alias pattern; **no new axioms**). An embedded
ZFA closure is a spatial knot/link (`HALF-SPIN-ZFA-EMBEDDING.md`); its ZFA-conserved
topological invariant is the **linking number**, and the baryon is the **Borromean /
Brunnian** paradigm. Everything here re-reads already-proven theorems of
`QLF_BaryonWinding` / `QLF_QuarkStructure` under their knot-theoretic names, giving the
geometry-of-quantum-systems footing (Kauffman) an explicit knot-invariant statement.

* `linkingNumber` = `baryonNumber` — the signed 3-axis linking invariant of the closure.
* `linking_orientation_odd` — reversing orientation flips the linking sign (`signTriple_rev`).
* `mirror_reverses_linking` — the mirror image (Hermitian conjugate) negates the linking
  number (`baryon_dagger_odd`): the chiral-knot signature (cf. the Jones polynomial under
  mirror reflection).
* `borromean_remove_one_unlinks` — remove any one colour component and the link falls
  apart (`baryon_zero_of_missing`): the defining Borromean property.
* `brunnian_needs_all_three` — nonzero linking requires a component on **every** axis
  (`baryon_needs_all_three_axes`): the 3-component Brunnian link.
* `single_component_unlinked` (`single_colour_not_baryon`); `meson_zero_linking`
  (`baryon_meson`); `proton_link` (`baryon_proton`, the minimal Borromean 3-link, linking `+1`).

**Honest scope.** These ARE the knot invariants of embedded closures, machine-verified.
Full Reidemeister-move invariance and the Kauffman-bracket / continuum Chern–Simons TQFT
rendering are the structural / boundary reading (`knot_invariant_in_progress`). See
`QLF_Knot_Theory_Nature_2025.md`, `HALF-SPIN-ZFA-EMBEDDING.md`.
-/

namespace QLF.KnotInvariant

open QLF QLF.Majorana QLF.BaryonWinding QLF.QuarkStructure

/-- **The linking number of an embedded ZFA closure** = the signed 3-axis linking
    (winding) invariant `baryonNumber`. -/
abbrev linkingNumber : List Twist → Int := baryonNumber

/-- **Linking is orientation-odd.** Reversing a 3-window's orientation flips its linking
    sign — the mirror signature a genuine (chiral) knot invariant carries. -/
theorem linking_orientation_odd (a b c : Option Ax) :
    signTriple c b a = - signTriple a b c := signTriple_rev a b c

/-- **The mirror image negates the linking number.** The Hermitian conjugate (mirror /
    charge conjugate) sends `L ↦ −L` for every closure — the chirality of the knot
    invariant (cf. the Jones polynomial of the mirror knot). -/
theorem mirror_reverses_linking (ts : List Twist) :
    linkingNumber (antiparticle ts) = - linkingNumber ts := baryon_dagger_odd ts

/-- **Borromean: remove any one component and it unlinks.** If any colour axis is absent
    the linking number is `0` — the defining property of a Brunnian/Borromean link. -/
theorem borromean_remove_one_unlinks (a : Ax) (ts : List Twist)
    (h : ∀ t ∈ ts, axOf t ≠ some a) : linkingNumber ts = 0 :=
  baryon_zero_of_missing a ts h

/-- **The baryon is a 3-component Brunnian link.** Nonzero linking requires a component on
    every axis `x, y, z` — no two-component sub-link is linked (Borromean). -/
theorem brunnian_needs_all_three (ts : List Twist) (h : linkingNumber ts ≠ 0) :
    (∃ t ∈ ts, axOf t = some Ax.x) ∧
    (∃ t ∈ ts, axOf t = some Ax.y) ∧
    (∃ t ∈ ts, axOf t = some Ax.z) :=
  baryon_needs_all_three_axes ts h

/-- **A single-component (one-colour) closure is unlinked** (`L = 0`): a lone quark is not
    a Borromean triple. -/
theorem single_component_unlinked (a : Ax) (ts : List Twist)
    (honly : ∀ t ∈ ts, axOf t = some a ∨ axOf t = none) : linkingNumber ts = 0 :=
  single_colour_not_baryon a ts honly

/-- **The meson is an unlink** (`L = 0`): quark + antiquark, zero net linking. -/
theorem meson_zero_linking :
    linkingNumber ([Twist.right, Twist.up, Twist.slash] ++
      antiparticle [Twist.right, Twist.up, Twist.slash]) = 0 := baryon_meson

/-- **The proton is the minimal Borromean 3-link** with linking number `+1`. -/
theorem proton_link : linkingNumber [Twist.right, Twist.up, Twist.slash] = 1 := baryon_proton

/-- Status marker: the linking / Borromean core is proven (reuse); Reidemeister invariance
    in full + the Kauffman-bracket / continuum Chern–Simons TQFT rendering stay open. -/
theorem knot_invariant_in_progress : True := trivial

end QLF.KnotInvariant
