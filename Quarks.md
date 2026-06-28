# Quarks in QLF — colour, charge, flavour, and confinement

What the [Quantum Logical Framework](README.md) (QLF) can and cannot say about quarks, read off the
**nucleon knot** of [`Atomic_Structure_QLF.md`](Atomic_Structure_QLF.md) §7: a baryon is a 3-axis
Borromean closure whose three internal qubits are the three colour directions, threaded by charge. This
doc collects the proven core, the dynamical reading, the open frontier, and the predictions — with the
standard three-tier scope (✓ proven / ⚠ structural reading / ✗ open).

A quark in QLF is not a standalone particle — only hadrons are closure observables
([`QLF_QuarkMass`](lean/QLF_QuarkMass.lean), `quark_not_closed`). In the knot picture a quark is a
**junction** where two internal colour dimensions meet and the closure turns — interior to one closure,
with no free end. That single fact is most of confinement.

---

## 1. Colour — the three axes (essentially complete ✓)

- **Colour = the three spatial axes.** `axOf` ([`QLF_BaryonWinding`](lean/QLF_BaryonWinding.lean)):
  `<>`→x, `^v`→y, `/\`→z; gauge `+−` carries no axis. R/G/B = (x,y,z).
- **SU(3) = the traceless 3-axis directional tensor** ([`QLF_StrongAlgebra`](lean/QLF_StrongAlgebra.lean):
  `trace_commutator_zero`, `gluon_commutator_nonzero`); the eight gluons are its off-diagonal couplings —
  i.e. the **connectors** where the closure hops between colour axes.
- **The Borromean three-colour necessity** ([`QLF_QuarkStructure`](lean/QLF_QuarkStructure.lean),
  `baryon_needs_all_three_axes`): `B ≠ 0` requires a twist on **every** colour axis; remove any one colour
  and `B = 0`. So a baryon needs all three quarks/axes — no one- or two-colour baryon. The minimal baryon
  `>^/` carries exactly one twist per axis (`minimal_baryon_one_per_axis`): three quarks = three axes.

This is a genuine proof of the colour structure (three colours, SU(3), Borromean closure, singlets).

## 2. Confinement — the singlet-closure obstruction (proven ✓)

Confinement is **proven**, as the closure obstruction already established for charge, applied to colour
([`QLF_Confinement`](lean/QLF_Confinement.lean)):

- **`charged_not_closed`** — a state carrying a net annihilation-odd charge (electric, or the strong
  instance **colour**) is **not** a ZFA closure. A lone quark carries net colour ⟹ it **cannot close** ⟹
  it is not a physical state.
- **`singlet_closure`** — every ZFA closure has zero net charge/colour: **only singlets close**.
- **`baryon_needs_all_three_axes`** — and the only nonzero-baryon closure is the three-axis Borromean
  triple. Together: physical hadrons are colour-neutral, and a baryon is exactly the three-colour lock.

**The dynamical reading — confinement as the 3-body threshold (⚠ cited dynamics, QLF-native bridge).**
The closure ladder is the n-body integrability ladder:

| internal dimensions | n-body | behaviour |
|---|---|---|
| 1 (neutrino) | 1-body | trivially closes |
| 2 (electron, positronium, muonium) | 2-body, **integrable** | always closes — leptons are free, **no confinement** |
| 3 (baryon) | 3-body, **chaotic** (Poincaré) | closes **only** in the special Borromean lock |

A *generic* 3-axis history is chaotic ⇒ non-terminating ⇒ **pruned** (`full_zeno_prune`; a terminating
computation is exactly a ZFA closure, `qlf_universality`). So a lone or perturbed quark configuration is
chaotic and never closes — you cannot pull a quark out. Confinement = the onset of three-body chaos; the
Borromean triple is the integrable island (the prime-3 lock, [`QLF_PrimeResonance`](lean/QLF_PrimeResonance.lean),
"balanced and prime"). The **flux tube / linear potential `V(r) ∝ r`** is the structural reading (the
closure cost grows with separation); its *value* and the asymptotic-freedom→confinement RG flow stay open
(`confinement_in_progress`).

## 3. Charge — conservation, neutrality, quantisation

- **Proven ✓:** electric charge = signed gauge-phase count (`chargeWeight`,
  [`QLF_BMinusL`](lean/QLF_BMinusL.lean)); conserved (`signed_count_conserved`); **zero on every closure**
  (`wcount_zero_on_ZFA`) — global neutrality; annihilation-odd; `charged_not_closed` (a bare charge needs
  its completer — the proton needs its electron, [`Weak_Force.md`](Weak_Force.md) §4a).
- **Quantisation in thirds, from colour (⚠ structural reading).** The fractional `±1/3`, `±2/3` are the
  unit gauge fold shared over the three colour axes — a `1/3` quantum per colour. Equivalently the SU(5)
  charge-quantisation argument ([`QLF_SU5`](lean/QLF_SU5.lean)): three equal-charge colour states + an
  integer-charge lepton in one multiplet + tracelessness `Σ charge = 0` force the colour-state charge to
  `1/3`. So **the thirds track the three colours**. (Beyond the integer `chargeWeight` model; the absolute
  value is then the up/down split, §4.)

## 4. Flavour (u/d) — the open frontier (✗)

- **Structural ✓:** two flavours per generation = the weak `SU(2)` doublet
  ([`QLF_QuarkMass`](lean/QLF_QuarkMass.lean)); `u` and `d` differ by **one** `u↔d` gauge-fold pair-flip
  (the weak vertex), so their charge differs by exactly 1 (`uud = +1`, `udd = 0`, §7).
- **Open ✗:** the **per-flavour twist signature** — *which* twist string is the up vs the down, and why
  one is `+2/3` — is not derivable yet (only the electron `^<v>`, neutrino `^v`, photon `^>` have
  signatures, [`Forces_From_Three_Axes.md`](Forces_From_Three_Axes.md) §4). Positing it would be
  arithmetic, not a derivation; the mass *difference* `m_n−m_p` is the well-posed target (the d↔u step is
  **not** the charge difference — the down is *less* charged yet *heavier*, [`Weak_Force.md`](Weak_Force.md) §5e).

## 5. Predictions

Graded honestly — what is a **genuine/falsifiable** prediction vs a **reproduction with a new reason**.

1. **Dimensional confinement — the 3-body threshold (falsifiable).** No confined sub-three-colour state
   (no stable diquark baryon); confinement turns on at *exactly* three axes = three spatial dimensions.
   *Skeleton proven* (`baryon_needs_all_three_axes`, `baryon_zero_of_missing`: fewer than three colours ⟹
   `B=0`); the chaos cause is cited. **Falsifier:** a stable two-colour bound state, or confinement in a
   genuinely 2D system.
2. **Exotic hadrons are molecular, not fundamental (falsifiable).** The only nonzero-`B` Borromean closure
   is the three-axis triple, so tetra-/penta-quark states must be two colour-singlets loosely bound, not
   new fundamental closures — matching the emerging experimental "molecular" reading. **Falsifier:** a
   compact, deeply-bound exotic with no two-singlet substructure.
3. **No fourth generation — exactly three (proven prediction).** Three axes ⟹ three generations
   ([`QLF_Generations`](lean/QLF_Generations.lean), `num_generations_eq_three`) — the same "3" as colour.
4. **The charge quantum tracks the three colours.** The `1/3` is the share over three colours; the sharp
   counterfactual ("`1/d` in `d` spatial dimensions") is **speculative** — stated as the soft form: the
   thirds exist *because* there are three colours = three spatial axes, not as a free fact.

The strongest *new* ones are **1** (proven skeleton + falsifiable) and **2** (current experimental
relevance). **3** is a standing QLF prediction; **4** is a structural link, soft.

---

## Honest scope

- ✓ **Proven:** colour = 3 axes + SU(3); the Borromean three-colour necessity; confinement (only singlets
  close, `charged_not_closed`/`singlet_closure`); charge conservation, neutrality, and `charged_not_closed`;
  three generations.
- ⚠ **Structural reading:** charge quantisation in thirds from colour (SU(5) tracelessness); the
  integrability/chaos cause of confinement (the bridge *chaotic ⇒ non-terminating ⇒ pruned* is QLF-native;
  3-body chaos itself is cited Poincaré); the flux-tube linear potential; the quark-as-junction picture.
- ✗ **Open:** the per-flavour (u/d) twist signature and quark masses; the string-tension value and the
  asymptotic-freedom→confinement RG flow.

## See also

- [`Atomic_Structure_QLF.md`](Atomic_Structure_QLF.md) §7 — the nucleon knot the quark reading comes from;
  [`diagrams/hydrogen_proton_quarks.svg`](diagrams/hydrogen_proton_quarks.svg).
- [`Forces_From_Three_Axes.md`](Forces_From_Three_Axes.md) — colour = the 3 axes; the open flavour sector.
- [`Weak_Force.md`](Weak_Force.md) §5 — the `d↔u` step, `m_n−m_p`, electron-out vs electron-in.
- Lean: [`QLF_QuarkStructure`](lean/QLF_QuarkStructure.lean), [`QLF_Confinement`](lean/QLF_Confinement.lean),
  [`QLF_BaryonWinding`](lean/QLF_BaryonWinding.lean), [`QLF_StrongAlgebra`](lean/QLF_StrongAlgebra.lean),
  [`QLF_QuarkMass`](lean/QLF_QuarkMass.lean), [`QLF_BMinusL`](lean/QLF_BMinusL.lean).
