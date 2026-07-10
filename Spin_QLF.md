# How [QLF](README.md) Demystifies Spin — spin *is* the twists

> Spin is usually taught as a mystery: an electron must turn **720°** to come back to
> itself; it has a "magnetic moment" and a "charge" that seem unrelated; bosons and
> fermions behave oppositely for no visible reason. In QLF none of this is mysterious.
> **Spin is literally the twists** — the σ-matrix generators of the 8-twist alphabet —
> and every one of these facts is a short, machine-verified fold.
> Lean: [`lean/QLF_Spin.lean`](lean/QLF_Spin.lean).

## 1. The twist → matrix dictionary

Each twist *is* a Pauli generator ([`QLF_TwistAlphabet`](lean/QLF_TwistAlphabet.lean),
`Twist.toMatrix`):

| twist | `^` | `v` | `<` | `>` | `/` | `\` | `+` | `−` |
|---|---|---|---|---|---|---|---|---|
| matrix | `σ_y` | `−σ_y` | `−σ_x` | `σ_x` | `σ_z` | `−σ_z` | `I` | `−I` |

A "spin" is just a twist history; its physics is what its matrix product (its **fold**)
does. So let's fold.

## 2. The worked QuCalc folds

These are the actual products a `/qucalc` fold computes — each is a theorem in
`QLF_Spin.lean`:

- **`^v`** = `σ_y · (−σ_y)` = `−σ_y²` = **`−I`**  (`fold_up_down`).
  One Hermitian pair = one half-spin = a 360° turn → the fermion's `−1` sign.
- **`^v^v`** = `(−I)(−I)` = **`+I`**  (`fold_up_down_twice`).
  Two pairs = 720° → back to the identity. *This is why you turn twice.*
- **`^>`** = `σ_y · σ_x` = **`−i σ_z`**  (`fold_up_right`).
  Two *different* axes fold to the third (times `−i`): the chiral/winding content, not a
  scalar.
- **`+−`** = `I · (−I)` = **`−I`**  (`fold_plus_minus`).
  The gauge/charge pair: `+` carries charge `+1`, `−` carries `−1`.

Everything below is these folds, named.

## 3. The two-axis model

A particle carries **two independent 720° half-spins**:

1. a **perpendicular / chiral** component whose handedness *relative to motion* is what
   electric **charge** is;
2. a **flat** up/down component, *independent of motion*, that is **magnetism** (the
   Stern–Gerlach magnetic moment).

Reversing motion flips the first but not the second — the formal "two independent axes":
`flat_independent_of_motion` (reversing `perp` leaves `magneticMoment = flat` fixed).

## 4. 720°, SU(2) and SO(3) — the double cover, in the twists

The three spatial twist axes are the **su(2) generators**: their commutators close the
Lie algebra `[σ_i, σ_j] = 2i ε_{ijk} σ_k` (`su2_comm_xy`, `su2_comm_yz`, `su2_comm_zx`,
folded from the σ-product identities). The group they generate is **SU(2)** — the
**double cover** of the rotation group **SO(3)**.

The "720° to return" is *exactly* that cover:

- A **360°** rotation = **one** Hermitian pair → **`−I`** (`rotation_360_eq_negI`) — **not**
  the identity.
- A **720°** rotation = **two** pairs → **`+I`** (`rotation_720_eq_id`).

The fold outcomes `{+I, −I}` are precisely the **kernel** of `SU(2) → SO(3)`, and they are
distinct — `−I ≠ +I` (`spin_double_cover_nontrivial`) — so the cover is genuine. The
fermion's sign flip under one full turn is `−I`, the nontrivial kernel element. No mystery:
it is the `^v` fold.

## 5. Charge conjugation = viewing from behind

A **positron** coming toward you spins clockwise; seen **from behind** it reads
counterclockwise — i.e. an **electron** of opposite charge. In QLF "viewing from behind" is
the antiparticle operator `antiparticle = (map Twist.conj).reverse`
([`QLF_Majorana`](lean/QLF_Majorana.lean)) — conjugate each twist *and reverse the order*
(`reverse` = the back of the clock).

Under it, **charge and perpendicular-chirality co-negate** (`C_eq_motional_reversal`):

- `chiralCharge (antiparticle ts) = − chiralCharge ts` (`chiralCharge_conj`),
- `perpChirality (antiparticle ts) = − perpChirality ts` (`perpChirality_conj`, reusing the
  fully-general winding-flip `baryon_dagger_odd` of
  [`QLF_BaryonWinding`](lean/QLF_BaryonWinding.lean)).

So the positron-from-behind *is* an electron: opposite charge **and** opposite handedness,
together — **charge conjugation = motional reversal**.

## 6. The neutrino — the self-conjugate spin is neutral

The neutrino loop `^v` is its **own** antiparticle — a fixed point of conjugate-and-reverse
(`neutrino_majorana`, [`QLF_Majorana`](lean/QLF_Majorana.lean)). Viewed from behind it is the
**same** thing, so it has **no charge handedness to flip** — and a self-conjugate quantity
must vanish (`x = −x ⟹ x = 0`):

> **`neutrino_neutral`**: `chiralCharge ^v = 0 ∧ perpChirality ^v = 0`
> (from the general `majorana_is_neutral`).

The neutrino is a pure (σ_y) **flat** spin, neutral, the same from any side. The electron
`^<v>` is **not** self-conjugate (`electron_not_majorana`) — it is a charged **Dirac**
particle with a distinct positron. (This is also why the neutrino is the unique Majorana
fermion; see [`QLF_Majorana`](lean/QLF_Majorana.lean), `Beta_Decay_Neutrino_Nature.md`.)

## 7. Integer spin = a composite of half-spins

Spin-1 is **not** fundamental. Each Hermitian twist pair is a spin-½ unit folding to `−I`;
an **even** number of them folds to `+I` (a boson, integer spin), an **odd** number to `−I`
(a fermion, half-integer): `boson_even_pairs` / `fermion_odd_pairs` (the `(−1)^N` fold).

A **photon is spin 1** because it is a half-spin photon **plus** a half-spin antiphoton —
two halves, `½ + ½ = 1` — folding to `+I` (`photon_integer_spin`). The photon is the joint
emitter–absorber ZFA closure (`Collective_Electrodynamics.md`); its integer spin is two
half-spins, exactly as the substrate requires.

## 8. Exclusion and annihilation — the same folds again

- **Exclusion**: two identical fermionic processes anticommute to zero — Pauli exclusion,
  `like_spin_excludes` = `pauli_exclusion` ([`PauliExclusion`](lean/PauliExclusion.lean)).
  Like-flat-spin fermions cannot co-occupy → spatial expansion (Fermi pressure,
  `Magnetism_Spatial_Dynamics.md` §2).
- **Annihilation**: opposite-flat-spin halves form a **singlet** — `(−I)(−I) = +I`
  (`opposite_spin_singlet_closes`) — a fully closed (ZFA) pair that annihilates to vacuum →
  spatial contraction (singlet binding, `Magnetism_Spatial_Dynamics.md` §3). Note this `+I`
  is the **same** as the 720° return: **the double cover and annihilation are one fact**.

## 9. Spin-½ as horizon-relative closure

**The pre-spatial primitive is pass-counted closure, not rotation.** Stated at the substrate
level — before any geometry — spin-½ is:

> **one local pass leaves the `−I` residue; the second complementary pass closes to `+I`.**

That is a *process* rule over closure passes, with no angle and no space in it. The
`−I` / `+I` fold of §4 is the physical reading of **horizon-relative closure**
([`QLF_HorizonClosure`](lean/QLF_HorizonClosure.lean), issue #104): closure is not a
primitive yes/no — a history reads **open** to a shallow observer and **closed** to a deeper
one, `closedAtHorizon R s := boundedPrune R s = []` applying the one-pass prune only `R`
times (`horizon_relative` — the nested singlet `[+,+,−,−]` is open at horizon 1, closed at
horizon 2). Spin-½ *is* that pass-counted structure:

- **One local pass leaves a residue** → **`−I`** (`rotation_360_eq_negI`), the **nontrivial
  kernel element** of SU(2)→SO(3) (`spin_double_cover_nontrivial`, `−I ≠ +I`). At this
  resolution the closure is *not* complete — the `−1` sign is the un-pruned residue, exactly a
  history still **open at horizon 1**.
- **The complementary second pass closes** → **`+I`** (`rotation_720_eq_id`), the identity:
  the residue is cancelled, the closure **complete at horizon 2**. A second pass *is* pruning
  to the empty closure at the deeper horizon.
- **Exclusion = the "no identical friend" rule.** Two *identical* half-spins cannot close —
  they anticommute to zero (`like_spin_excludes` = `pauli_exclusion`). A copy of the open
  residue does not complete it; it obstructs it (the same no-free-copy as
  [`QLF_NoFreeDuplication`](lean/QLF_NoFreeDuplication.lean)).
- **Singlet pairing = the allowed complementary closure.** The *opposite* half-spin does
  complete it: `(−I)(−I) = +I` (`opposite_spin_singlet_closes`) — the same `+I` as the second
  pass. The complementary partner is precisely what carries the open history across its horizon
  to the empty closure.

> **Guardrail — "360°/720°" is representation-language, not the primitive.** The angle words are
> inherited from the SU(2)/SO(3) rendering *after geometry has emerged*; they are the spatial
> read-out of the pass-count, not a thing spinning in already-existing space (QLF assumes no
> background space — spacetime is synthesized, [`QLF_ReachableEvent`](lean/QLF_ReachableEvent.lean),
> `SpaceTime.md`). The substrate statement is: *spin-½ is one-pass-open / two-pass-closed;
> "360° → −I, 720° → +I" is the spatial representation of that closure process once the metric is
> rendered.* The Lean fold names carry "rotation" only because they are stated in the emerged
> Pauli/σ basis; the content they encode is the pass-count.

So **the fermion sign is an open-at-horizon-1 receipt, and the singlet (or the second pass) is
its close-at-horizon-2 completion** — one deep-horizon closure the shallow single pass cannot
see (`nestedSinglet_zfa`: the horizon-2-closed witness is also *absolutely* `achieves_ZFA`; the
deep reading is the genuine receipt, absolute closure the ideal the finite horizons approach).
Pauli exclusion and singlet pairing are the two answers to one question — *does a complementary
partner exist to carry this open half-spin to closure?* — no is exclusion, yes is the singlet.

> **Reading, not derivation (spin-statistics).** The exclusion/singlet lines are a QLF-*process*
> reading: the reused theorem (`pauli_exclusion` = `like_spin_excludes`) proves the
> commutator/self-exclusion form `[p,p] = 0`, **not** the full spin-statistics theorem. The
> missing bridge — from the closure residue to antisymmetric exchange under particle swap — is
> not yet built; until it is, "residue ⟹ Fermi statistics" stays a labelled reading, not a proof
> (tracked in [`Open_Problems.md`](Open_Problems.md), `spin_statistics_bridge_in_progress`).

## 10. Magnetism and electromagnetism

- The **flat** spin component **is** the magnetic moment (`magneticMoment`); a persistent
  vacuum spin-orientation bias is the **B**-field gradient (Stern–Gerlach,
  `Magnetism_Spatial_Dynamics.md`).
- **Charge** is the signed gauge count — `count(+) − count(−)` ([`Maxwell.md`](Maxwell.md);
  `QLF_BMinusL.wcount_chargeWeight`) — and there are no magnetic monopoles (`∇·B = 0`,
  `ZFAEventDynamics`).
- The gyromagnetic ratio **g = 2** is the Pauli-scalar return of one half-spin closure, with
  the Schwinger anomaly `a_e = α/2π` ([`QLF_GMinusTwo`](lean/QLF_GMinusTwo.lean)).

## 11. Honest scope

| Claim | Status |
|---|---|
| `^v`=−I, `^v^v`=+I, `^>`=−iσ_z, `+−`=−I (worked folds) | **Lean theorems** |
| 360°→−I, 720°→+I; `−I ≠ +I` (genuine double cover) | **Lean theorems** |
| `[σ_i,σ_j]=2iε σ_k` (twist axes close su(2)) | **Lean theorems** |
| Charge & chirality co-negate under view-from-behind | **Lean theorems** (reuse `baryon_dagger_odd`) |
| Neutrino neutral (self-conjugate ⟹ 0) | **Lean theorem** |
| Integer spin = even pair count; photon = spin 1 | **Lean theorems** |
| Exclusion `[p,p]=0`; singlet `(−I)(−I)=+I` | **Lean theorems** (reuse `pauli_exclusion`) |
| 360°→−I open at horizon 1, 720°→+I closed at horizon 2 | **Lean theorems** (reuse `horizon_relative`, `rotation_360_eq_negI`, `rotation_720_eq_id`) |
| Exclusion / singlet = no / yes complementary-partner closure | **reading** of the reused theorems (the horizon-relative *interpretation* of spin) |
| flat = magnetic moment; perp/chirality = charge sense | **naming defs** (which twist invariant we *call* charge/magnetism) |
| B-field, monopole-freedom, g=2 | **other modules / prose** |

Two facets of "charge" appear — a signed gauge **count** (`chiralCharge`, on `List Twist`;
also `chargeWeight` on the `TopoString` alphabet) and a 3-axis **winding** (`perpChirality` =
`baryonNumber`). They **co-negate** under view-from-behind but are deliberately *two*
invariants, not one function (a charged history can have zero winding and vice versa) — this
is structure, not a gap.

## References

- W. Pauli, *The connection between spin and statistics*, Phys. Rev. **58** (1940) 716 — spin-statistics.
- E. P. Wigner (1939); the SU(2) double cover of SO(3) — the `720°` structure.
- W. Gerlach & O. Stern, *Der experimentelle Nachweis der Richtungsquantelung im Magnetfeld*, Z. Phys. **9** (1922) 349 — spin orientation / magnetic moment.
- E. Majorana, *Teoria simmetrica dell'elettrone e del positrone*, Nuovo Cimento **14** (1937) 171 — the self-conjugate fermion.

**See also:** [Spin_Statistics.md](Spin_Statistics.md), [HALF-SPIN-ZFA-EMBEDDING.md](HALF-SPIN-ZFA-EMBEDDING.md), [Magnetism_Spatial_Dynamics.md](Magnetism_Spatial_Dynamics.md), [Maxwell.md](Maxwell.md), [Beta_Decay_Neutrino_Nature.md](Beta_Decay_Neutrino_Nature.md), [`lean/QLF_Majorana.lean`](lean/QLF_Majorana.lean), [`lean/QLF_BaryonWinding.lean`](lean/QLF_BaryonWinding.lean), [`lean/QLF_GMinusTwo.lean`](lean/QLF_GMinusTwo.lean), [`lean/QLF_HorizonClosure.lean`](lean/QLF_HorizonClosure.lean).
