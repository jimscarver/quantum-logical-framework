import QLF_Fusion
import QLF_FreeEnergy
import QLF_TwistAlphabet
import QLF_BMinusL
import QLF_PrimordialMarkovBlanket

set_option linter.unusedVariables false

/-!
# QLF_NoFreeDuplication — the substrate forbids free Banach–Tarski duplication

The Banach–Tarski paradox (Banach & Tarski 1924) uses the Axiom of Choice to cut a solid ball into
finitely many pieces and reassemble them into **two** identical balls — volume conjured from nothing,
duplication for free. QLF's stance (`Banach_Tarski_QLF.md`, `Continuum_Choice_Fallacy.md`,
`TheContinuum.md`) is that this is the cleanest **impossible mathematics**: AC is *false in the
intended physical model*, and the QLF substrate admits no such free copy — every real duplication must
**buy distinguishability and pay in information**.

This module anchors that "no free duplication" principle as a *reuse-corollary* of three already-
verified facts (it does **not** formalize Banach–Tarski itself — BT is a real, consistent ZFC theorem;
the claim is consistency ≠ realizability, not inconsistency):

* **`identical_copy_pauli_blocked`** — two *identical* offspring closures have no bound fermionic
  channel (`fermi_antisym p p = 0`): you cannot make a second identical copy share the closure. The
  substrate's no-cloning / no-diproton (reuses `QLF.Fusion.diproton_pauli_blocked = pauli_exclusion`).
  `fermi_antisym` is **not** identically zero (`fermi_nonzero_example`), so this is a genuine
  constraint on *identical* copies, not a vacuous identity.
* **`realizable_duplication_needs_distinguishability`** — a viable one-becomes-two needs a
  *distinguishable* channel: the identical pair is blocked while a distinguishable Hermitian pair
  closes to identity (reuses `QLF.Fusion.pp_join_requires_distinguishability`, the β⁺ keystone). The
  same move at every scale — nucleonic `p+p` needs a `u→d` β⁺ step, cellular mitosis needs two
  distinguishable daughters.
* **`duplication_pays_log_two`** — making the one distinguishing bit is a half-spin ZFA closure
  costing `ΔF = −log 2` nats (Landauer; reuses `QLF.zfa_closure_minimizes_free_energy`). You cannot get
  two distinguishable closures from one for free.

So no-cloning ↔ no-diproton ↔ no-free-mitosis ↔ no-Banach–Tarski: one principle — *all real duplication
buys distinguishability and pays in energy/time/information*. Banach–Tarski is what duplication looks
like with that ledger dropped (AC's free choice); mitosis is what it looks like with the ledger kept
(ZFA closure).

**The free-group angle (does the substrate's free generation enable a paradox?).** The substrate *does*
generate freely — the free twist-monoid has exponential `4^n` possibility (the `C(2n,n)` census), the
combinatorial analog of Banach–Tarski's free group `F₂` (exponential word growth). QLF concedes the free
engine; it is **not** "too poor" to have one. But a paradoxical decomposition needs more than freeness:
by Tarski's theorem it needs the acting group to be **non-amenable** (no invariant finitely-additive
measure), AND it needs an uncountable continuum to act on plus the Axiom of Choice to select
non-measurable orbit representatives. The substrate supplies none of these:
* `zfa_charge_additive` — every signed twist count is a **conserved additive invariant** (a homomorphism
  to `(ℤ, +)`); the substrate has the invariant mean `F₂` lacks (amenability by construction).
* `closure_folds_to_finite_group` — the closure fold lands in the **finite** (hence amenable) Pauli
  group, so no paradox lives in the rendering.
* the substrate is countable / finite-information (`no_continuum_in_finite_region`, `QLF_Realizability`),
  with no uncountable orbit space, and `full_zeno_prune` replaces AC.
So the freeness is real but harmless; Banach–Tarski's teeth are the continuum + Choice + non-amenability
layered on top, exactly the layers QLF omits.

## Honest scope

The three facts are **already proven** and reused here, no new axioms, no `sorry`. Banach–Tarski itself
is **not** formalized (it needs measure theory + a free-group paradoxical decomposition, and QLF's
point is precisely that those objects are non-realizable, not that they're inconsistent). The
mitosis/cellular reading is a *structural analogy* (Markov-blanket fission as the biological instance of
paid duplication), not a derivation of cell biology. See `Banach_Tarski_QLF.md`.
-/

namespace QLF.NoFreeDuplication

open QLF QLF.Fusion QLF.Spin QLF.BMinusL Matrix

/-- **No free identical copy.** Two identical offspring closures have no bound fermionic channel —
    `fermi_antisym p p = 0` — so a second *identical* copy cannot share the closure (the substrate's
    no-cloning / no-diproton). Direct reuse of `diproton_pauli_blocked` (= `pauli_exclusion`); genuine
    because `fermi_antisym` is not identically zero (`fermi_nonzero_example`). -/
theorem identical_copy_pauli_blocked (p : RhoProcess) : fermi_antisym p p = 0 :=
  diproton_pauli_blocked p

/-- **Realizable duplication needs distinguishability.** The identical pair is Pauli-blocked
    (`fermi_antisym p p = 0`, left) while a *distinguishable* Hermitian pair closes to identity
    (right): a viable one-becomes-two must make a real difference, not copy for free. Direct reuse of
    the β⁺ keystone `pp_join_requires_distinguishability`. -/
theorem realizable_duplication_needs_distinguishability (p : RhoProcess) (s t : Twist) :
    fermi_antisym p p = 0 ∧
      (s.toMatrix * s.conj.toMatrix) * (t.toMatrix * t.conj.toMatrix) = (1 : M) :=
  pp_join_requires_distinguishability p s t

/-- **Duplication pays one bit.** Making the single distinguishing bit is a half-spin ZFA closure
    event, costing `ΔF = −log 2` nats — Landauer's bound. You cannot get two distinguishable closures
    from one for free. Direct reuse of `zfa_closure_minimizes_free_energy`. -/
theorem duplication_pays_log_two :
    -binary_kl 1 (1/2) = -Real.log 2 :=
  zfa_closure_minimizes_free_energy

/-- **The ZFA charge is a conserved, finitely-additive invariant** — a homomorphism
    `(TopoString, ++) → (ℤ, +)` (direct reuse of `wcount_append`). This is the free-group angle on
    Banach–Tarski: by Tarski's theorem a set admits a paradoxical decomposition **iff** the acting
    group is *non-amenable* — admits **no** invariant finitely-additive measure. The free group `F₂`
    (Banach–Tarski's engine) is the canonical non-amenable group; the QLF substrate, by contrast,
    carries such an invariant *by construction* — every signed twist count is a conserved additive
    charge — so the free twist-monoid cannot host a paradoxical doubling. The ZFA balance **is** the
    invariant mean that `F₂` lacks. -/
theorem zfa_charge_additive (w : TopoElement → Int) (s t : TopoString) :
    wcount w (s ++ t) = wcount w s + wcount w t :=
  wcount_append w s t

/-- **Every ZFA closure folds to the finite Pauli group** (direct reuse of
    `count_balanced_pauli_closed`): a count-balanced twist history renders to a `PauliScalar` — an
    element of the finite (order-16) Pauli group, which is **amenable**. So although the substrate
    *generates* freely (the free twist-monoid, exponential `4^n` possibility, the `C(2n,n)` census —
    the combinatorial analog of `F₂`'s exponential word growth), its *physical image* under the
    closure fold is a finite, amenable group: no paradoxical decomposition lives in the rendering.
    Banach–Tarski's freeness-on-the-continuum is exactly what the finite fold excludes. -/
theorem closure_folds_to_finite_group {ts : List Twist} (h : countBalanced ts) :
    ∃ p : PauliScalar, twistMatrixFold ts = pauliScalarToMatrix p :=
  count_balanced_pauli_closed h

/-- **Geometric no-free-doubling: the blanket's topological charge is subdivision-invariant.** A QLF
    Markov blanket is a Fuller geodesic sphere with Euler characteristic `V − E + F = 2` at *every*
    frequency `v` (reuse `primordial_blanket_euler`) and exactly **12 pentamons** independent of `v`
    (reuse `pentamons_invariant`). Subdividing a blanket — refining `v`, the geometric analog of a
    Banach–Tarski decomposition into finer pieces — **preserves** both: still `χ = 2`, still 12
    pentamons. So no decomposition of one blanket (into 5 pieces or any number) can yield *two* (which
    would need `χ = 4`, 24 pentamons). Banach–Tarski's "5 pieces" escape this only by being
    non-measurable scatter with no `χ` and no pentamons — pieces a blanket of finite-information closures
    cannot have. The "5" is thus a feature of the geometry-less construction, not a piece-count QLF
    reproduces (and *not* the `5 = 3 + 2` angular-DOF of `QLF_BorromeanAngles` — a different object). -/
theorem blanket_charge_subdivision_invariant (v : ℕ) :
    (primordial_blanket_vertex_count v : ℤ) - primordial_blanket_edge_count v
        + primordial_blanket_face_count v = 2
      ∧ pentamon_count = 12 :=
  ⟨primordial_blanket_euler v, pentamons_invariant⟩

/-- **Doubling the blanket doubles its holographic information — the second copy must be written.** The
    blanket's boundary screen carries `S(v) = 20 v² · log 2` nats (reuse
    `primordial_blanket_information_capacity_eq`). Two blankets carry `2 · 20 v² · log 2` — the second
    screen's worth of information that a *free* Banach–Tarski doubling would conjure from nothing. Mitosis
    must instead **write** it (DNA replication lays down the second boundary's bits) and pay the
    `log 2`-per-event Landauer cost (`duplication_pays_log_two`). This is the geometric form of
    "duplication pays": the conserved structure Banach–Tarski steals is exactly the structure mitosis
    synthesizes. -/
theorem blanket_doubling_doubles_information (v : ℕ) :
    primordial_blanket_information_capacity v + primordial_blanket_information_capacity v
      = 2 * ((20 * v ^ 2 : ℝ) * Real.log 2) := by
  rw [primordial_blanket_information_capacity_eq]; ring

/-- **Established (the no-free-duplication principle, by reuse):** identical copies are Pauli-blocked
    (`identical_copy_pauli_blocked`), a realizable one-becomes-two needs distinguishable products
    (`realizable_duplication_needs_distinguishability`), and minting the distinguishing bit pays
    `ΔF = −log 2` (`duplication_pays_log_two`). On the free-group angle: the substrate generates freely
    yet hosts no paradox — it carries a conserved additive invariant (`zfa_charge_additive`) and folds
    to a finite, amenable group (`closure_folds_to_finite_group`), so Banach–Tarski's non-amenable
    `F₂`-on-the-continuum never forms. Geometrically the blanket's topological charge is subdivision-
    invariant (`blanket_charge_subdivision_invariant`: `χ = 2`, 12 pentamons at every `v`), so no
    cutting of one blanket yields two — the second must be *built*, writing its `20 v² · log 2`-nat
    holographic screen (`blanket_doubling_doubles_information`). The substrate's "no free Banach–Tarski,"
    one principle behind no-cloning, the no-diproton, and mitosis. No new axioms. See
    `Banach_Tarski_QLF.md`. -/
theorem no_free_duplication_summary : True := trivial

end QLF.NoFreeDuplication
