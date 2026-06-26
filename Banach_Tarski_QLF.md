# Banach–Tarski in QLF — impossible duplication, model-explosion, and mitosis as the possible version

In 1924 Stefan Banach and Alfred Tarski proved that, using the **Axiom of Choice**, a solid ball can
be cut into finitely many pieces and reassembled — by rigid motions alone — into **two** balls each
identical to the original. Volume conjured from nothing. It is the most vivid theorem in mathematics
that says: *something here is not physics.*

The [Quantum Logical Framework](README.md) (QLF) takes Banach–Tarski as a touchstone, and three of its
commitments meet in it:

1. it is the cleanest example of **impossible mathematics** — the continuum-and-choice "ultraviolet
   catastrophe" QLF is built to avoid ([`Continuum_Choice_Fallacy.md`](Continuum_Choice_Fallacy.md),
   [`TheContinuum.md`](TheContinuum.md));
2. it is the textbook case of **a false axiom certifying an absurdity** — stated *precisely*, the
   ontological (model) version of *ex falso*, not the syntactic one;
3. it is the *impossible* twin of an entirely **possible** duplication — **mitosis**, one cell becoming
   two — and the gap between them is exactly the gap QLF draws between fantasy and the realizable
   substrate.

---

## 1. Banach–Tarski as impossible mathematics

QLF's organizing thesis is that **the continuum and the Axiom of Choice are mathematics' ultraviolet
catastrophe** — formal infinity admitted without a closure condition, the way classical physics once
admitted arbitrarily fine modes until the blackbody spectrum diverged. The fix in both cases is a
cutoff: in physics, the quantum of action; in QLF, the requirement that an object be **constructible in
finite time** — admitted only if it has a finite ZFA closure ([`Philosophy.md`](Philosophy.md),
[`Continuum_Choice_Fallacy.md`](Continuum_Choice_Fallacy.md)).

Banach–Tarski is the cleanest thing that cutoff excludes. The decomposition is built from a **free group
`F₂`** of rotations whose paradoxical self-partition (`F₂` is equidecomposable with two copies of
itself) is transported onto the sphere; the resulting pieces are **non-measurable** — they have no
volume, no finite description, no procedure that produces them. They exist only because AC *asserts* a
selection (one point from each orbit) with **no construction**. Drop in those pieces and the volume
bookkeeping breaks: five pieces with "no volume" reassemble into twice the ball.

QLF's reading: these pieces are not realizable. A bounded region holds only finite information
(Bekenstein), so it has only finitely many distinguishable states — and an infinite, non-finitely-
describable point-set cannot be faithfully placed inside it. This is machine-checked in
[`lean/QLF_Realizability.lean`](lean/QLF_Realizability.lean): `no_continuum_in_finite_region` (no
injection from an infinite state space into a finite one) and `real_continuum_not_realizable` (its
Bekenstein concretization). The Banach–Tarski pieces are exactly the "gratuitous tail" QLF declines to
make physical ([`Mathematics_From_QLF.md`](Mathematics_From_QLF.md): Tegmark makes *all* structures
real, including the Banach–Tarski pathologies; QLF makes only the **realizable** subset real).

**The replacement for Choice.** QLF does not argue with AC on its own ground; it *refuses* it and
substitutes a computable filter. Where AC posits a selection function with no procedure, QLF uses
**`full_zeno_prune`** — a decidable, RCA₀-level selection that keeps exactly the ZFA-closed histories.
No non-constructive choice, no non-measurable set, no paradoxical decomposition: the explosion never
starts.

---

## 2. Is it "a false axiom proving anything"? — yes, but precisely

It is tempting to say Banach–Tarski shows ZFC is broken — "from a false axiom you can prove anything,"
*ex falso quodlibet*. That is the right intuition stated the wrong way, and the wrong way is a crank
trap. The precise version:

**Banach–Tarski is *ontological* (model) explosion, not *syntactic* explosion.** ZFC is **consistent**
(as far as anyone knows): it does **not** prove `0 = 1`, so it does not literally prove *every*
sentence. What Banach–Tarski exhibits is different and sharper — the Axiom of Choice is **false in the
intended model**, the physical world, and *an axiom false in the intended model certifies theorems that
are false in that model*: a ball that is two balls. The unsoundness is with respect to the **physical
interpretation**, not with respect to ZFC's own consistency.

QLF states it this way deliberately ([`Millennium.md`](Millennium.md): "by *ex falso quodlibet* an
axiom false-in-the-model makes everything provable; ZFC's Banach–Tarski is the visible symptom";
[`Philosophy.md`](Philosophy.md) §"Unsoundness and Consistency": "a system that proves a falsehood
certifies nothing"). The **binding precision**, load-bearing for every QLF claim about foundations:

> The claim is **consistency ≠ realizability**, *never* "ZFC is inconsistent" or "ℝ is false."

`ℝ` is a consistent structure; one can write endless consistent theories that describe nothing
realizable. Banach–Tarski is the demonstration that *consistent* and *sound-for-physics* are different
properties, and that AC has the first without the second. QLF's quarrel is with **soundness for
physics** — it keeps its own axioms true *in the intended model* by admitting only constructible
objects, so its proofs stay physically sound and no absurdity is certified. (This "false" is
**ontological**, not syntactic — the standard, defensible reading; see
[`Continuum_Choice_Fallacy.md`](Continuum_Choice_Fallacy.md), [`TheContinuum.md`](TheContinuum.md) §2,
the "five converging strikes": Löwenheim–Skolem, Gödel–Cohen, reverse-math conservativity,
unrealizable, unneeded.)

---

## 3. The possible twin — mitosis pays for what Banach–Tarski steals

Banach–Tarski and **mitosis** are the two faces of one coin: duplication. One ball becomes two; one cell
becomes two. The difference is the entire content of QLF's foundations.

Banach–Tarski duplicates **for free**: no information is copied, no energy is spent, no time passes — the
second ball is conjured by re-labeling non-measurable pieces. It is the duplication you get when you
**drop the cost ledger** (AC's free choice).

Mitosis duplicates by **paying**:

- it **copies the information** — DNA is replicated base-by-base, the daughter's genome is *built*, not
  conjured (no second copy appears without first laying down its bits);
- it **spends free energy** — ATP hydrolysis drives replication, spindle assembly, and division; the
  cell does thermodynamic work;
- it **supplies the mass** — the second cell's material is synthesized from nutrients, not summoned from
  the first;
- it **takes time** — division is a sequence of closures, and in QLF time is *synthesized* by closure
  (`f = 1/t`, [`Reversibility.md`](Reversibility.md)); there is no instantaneous copy.

That is duplication with the **ledger kept** — ZFA-closed, conservation-obeying. The per-event price is
exact: each half-spin ZFA closure decrements free energy by `ΔF = −log 2` nats
([`lean/QLF_FreeEnergy.lean`](lean/QLF_FreeEnergy.lean), `zfa_closure_minimizes_free_energy`), which *is*
Landauer's `k_BT ln 2` — the irreducible cost of fixing one bit ([`Conservation.md`](Conservation.md),
[`Reversibility.md`](Reversibility.md)). You cannot get two distinguishable closures out of one for
free; you must mint, and pay for, the bits that tell them apart.

So mitosis is precisely the duplication Banach–Tarski is *not*: it buys its second copy in information,
energy, mass, and time. Banach–Tarski is what duplication would look like if those bills never came due
— which is to say, it is not physics.

---

## 4. One principle, four scales — "no free duplication"

The substrate does not merely *fail* to permit free duplication; it **actively forbids** it, and the
prohibition is the same theorem wearing four costumes. (The Lean anchor is
[`lean/QLF_NoFreeDuplication.lean`](lean/QLF_NoFreeDuplication.lean), a reuse-corollary of three already-
verified facts.)

| Scale | "No free copy" | "Must pay / distinguish" |
|---|---|---|
| **Quantum** | No-cloning (Wootters–Zurek 1982): an unknown state can't be copied | Copying a capability is a linear-logic type error / ZFA asymmetry ([`QuantumOS.md`](QuantumOS.md)) |
| **Substrate** | Identical ρ-processes are Pauli-blocked: `fermi_antisym p p = 0` (`identical_copy_pauli_blocked`, reusing `pauli_exclusion`) | `fermi_antisym` is *not* identically zero — distinct processes can differ (`fermi_nonzero_example`) |
| **Nucleonic** | Two *identical* proton blankets can't bind — no diproton (`diproton_pauli_blocked`) | A β⁺ `u→d` step makes them distinguishable so the deuteron closes (`pp_join_requires_distinguishability`, [`Fusion.md`](Fusion.md), [`SEX.md`](SEX.md)) |
| **Cellular** | Two daughters cannot be the *same* instance | Mitosis copies DNA + spends ATP to make distinguishable daughters (structural analogy) |
| **Mathematical** | Banach–Tarski "free" ball-from-nothing is excluded | Realizable duplication pays `ΔF = −log 2` per distinguishing bit (`duplication_pays_log_two`) |

Read top to bottom, it is one statement: **no free identical copy** — the Pauli/no-cloning floor — and
its corollary **realizable duplication needs distinguishability, bought at a cost**. The quantum
no-cloning theorem is the *quantum* form of "no free Banach–Tarski"; the no-diproton is its *nuclear*
form; mitosis is its *biological* form. QLF already proves the substrate and nuclear forms (no new
axioms — `QLF_NoFreeDuplication` just reuses `pauli_exclusion`, `pp_join_requires_distinguishability`,
and `zfa_closure_minimizes_free_energy`); the cellular form is the natural extension stated as an
analogy.

---

## 5. The unifying statement

> **Banach–Tarski is what duplication looks like when you drop the cost ledger; mitosis is what it looks
> like when you keep it.**

The free, identical, instantaneous copy is exactly the object QLF's finite-construction filter excludes
— the same filter that excludes non-measurable sets, the continuum's uncountable tail, and the
Busy-Beaver horizon. The paid, distinguishable, time-taking copy is exactly what ZFA closure produces —
the same closure behind the half-spin atom, the deuteron, and the local clock. The line between
impossible and possible *duplication* is the line between the **continuum/choice fantasy** and the
**realizable substrate**, drawn one more time, now through the most famous "paradox" in mathematics.

A cell could not perform Banach–Tarski if it tried: the substrate has no free identical copy to give it.
What it can do — and does, every division — is pay the bill. That it must pay is not a limitation
biology happened to inherit; it is the same fact that keeps the universe consistent with itself.

---

## Honest scope

- **Banach–Tarski is a real, consistent ZFC theorem.** The claim throughout is **consistency ≠
  realizability / soundness-for-physics** — *not* "ZFC is inconsistent" or "ℝ is false." The *ex falso*
  point is **ontological (model) explosion** (an axiom false in the intended model certifies absurd
  objects), never syntactic explosion. Banach–Tarski is **not** formalized in Lean — QLF's point is that
  its objects are non-realizable, not that they are inconsistent, so there is nothing to verify and
  much to *decline to import*.
- **The mitosis reading is a structural analogy** — Markov-blanket fission as the biological instance of
  paid duplication — **not** a derivation of cell biology. QLF has no cellular dynamics; this doc
  introduces the analogy and says so. What *is* machine-verified is the substrate/nuclear core
  ([`lean/QLF_NoFreeDuplication.lean`](lean/QLF_NoFreeDuplication.lean), reusing
  [`PauliExclusion.lean`](lean/PauliExclusion.lean), [`QLF_Fusion.lean`](lean/QLF_Fusion.lean),
  [`QLF_FreeEnergy.lean`](lean/QLF_FreeEnergy.lean)).
- The **"no free duplication" principle across scales** is a synthesis/reading, anchored where Lean
  exists (the quantum no-cloning, the no-diproton, the `−log 2` cost) and stated as analogy where it does
  not (the cellular scale).

## See also

- [`Continuum_Choice_Fallacy.md`](Continuum_Choice_Fallacy.md) · [`TheContinuum.md`](TheContinuum.md) ·
  [`Philosophy.md`](Philosophy.md) — the continuum/choice = UV-catastrophe thesis and the five strikes.
- [`Millennium.md`](Millennium.md) — the *ex falso*/false-in-the-model framing and the 1924 citation.
- [`Mathematics_From_QLF.md`](Mathematics_From_QLF.md) — realizable math vs the gratuitous (Banach–Tarski)
  tail; QLF vs Tegmark.
- [`SEX.md`](SEX.md) · [`Fusion.md`](Fusion.md) — the nucleonic "one becomes two needs distinguishability."
- [`Conservation.md`](Conservation.md) · [`Reversibility.md`](Reversibility.md) — the `−log 2` ledger,
  Landauer, synthesized time.
- [`QuantumOS.md`](QuantumOS.md) — no-cloning as linear-logic / capability security.
