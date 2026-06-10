# The Weak Force and the W/Z Bosons in QLF

**The weak sector, consolidated — what QLF derives, what it sketches, and what is open, with the honest three-tier discipline of the rest of the corpus.** Previously this content was scattered across [`Higgs.md`](Higgs.md) §4, [`Standard_Model.md`](Standard_Model.md), [`Majorana_Beta_Decay.md`](Majorana_Beta_Decay.md), and [`Atomic_System_QLF_Closures.md`](Atomic_System_QLF_Closures.md) §6.

**Headline:** the **group-theoretic identification of the weak-isospin SU(2) inside the 8-twist algebra is now machine-verified** (`weak_isospin_su2`, [`lean/BraKetRhoQuCalc.lean`](lean/BraKetRhoQuCalc.lean)). The **quantitative** weak sector — W/Z masses, the Weinberg-angle value, the Fermi constant, the flavor-change vertex — remains explicitly open.

---

## 1. The weak force as a gauge-fold pair-flip

The 8-twist alphabet splits `6 spatial (^v<>/\) + 2 gauge (+-)`. The gauge sector (`+`/`−` folds) is what carries charge and generates mass. In QLF the **weak force is the gauge-fold pair-flip** — the operation that flips gauge content — which is exactly what is needed to restructure one closed history into another of different charge (e.g. `n → p`-deficit, co-produced with its completing lepton — §4a). It is **chirality-mediated**: left-handed loops pair into SU(2)-like doublets, right-handed into singlets, a structure inherited from the half-spin Pauli algebra ([`Standard_Model.md`](Standard_Model.md) §3.4, [`Majorana_Beta_Decay.md`](Majorana_Beta_Decay.md)).

This is the force as an **operation**. Whether it is also carried by an explicit propagator particle in every context is subtle — see §4.

---

## 2. W and Z as charged / neutral gauge-fold closures

| Boson | charge | QLF structure | depth |
|---|---|---|---|
| W⁺ / W⁻ | ±1 | gauge fold with a **net** charge twist | `R_W` |
| Z | 0 | **balanced** (neutral) gauge fold | `R_Z` |
| photon | 0 | pure spatial fold, **no** gauge twist | `R = 0` |

Mass is the constructing delay of a gauge fold, `m = αR` ([`Higgs.md`](Higgs.md) §4, [`E_mc2_derivation.md`](E_mc2_derivation.md)). So `M_W = α R_W`, `M_Z = α R_Z`, and the photon's masslessness is immediate (`R = 0`). The Weinberg angle is reframed as a **depth ratio**:

$$\cos\theta_W = \frac{R_W}{R_Z}$$

**Honest scope.** This is a *reframing* of the tree-level Standard-Model identity `cos θ_W = M_W/M_Z` (PDG: `80.377/91.188 ≈ 0.8814`), not a derivation: `R_W` and `R_Z` are **not** computed from substrate combinatorics. The structural content QLF adds is only that the charged W carries one extra charge twist on top of the neutral gauge structure, so `R_W < R_Z` — i.e. the angle is a depth difference, not a free parameter. The *number* is open (§6).

---

## 3. SU(2)_weak ⊂ Σ₈ — machine-verified (group-theoretic)

[`Standard_Model.md`](Standard_Model.md) §3.4 listed "identify the *specific* SU(2) subgroup of the 8-twist algebra" as open. It is now closed at the **Lie-algebra / group level.**

QLF's Σ₈ algebra uses `τᵢ = i σᵢ` (the Pauli matrices scaled by `i`), giving quaternionic squares `τᵢ² = −I` and anti-cyclic products `τxτy = −τz` (machine-verified: `tau_x/y/z_sq`, `tau_xy/yz/zx_product`). Adding the reverse products (`τy τx = +τz`, …), the three generators close under the matrix **commutator** into the su(2) ≅ so(3) Lie algebra:

$$[\tau_i,\tau_j] = -2\,\varepsilon_{ijk}\,\tau_k \qquad(\text{machine-verified: } \texttt{tau\_comm\_xy/yz/zx},\ \texttt{weak\_isospin\_su2})$$

and the mixed anticommutators vanish (`{τᵢ,τⱼ} = 0`, `tau_anticomm_*`). Together with `τᵢ² = −I`, the multiplicative group they generate is the **quaternion group** `Q₈ = {±I, ±τx, ±τy, ±τz} ⊂ SU(2)` — the discrete subgroup whose continuous closure is exactly the weak-isospin SU(2).

So **the weak-isospin SU(2) is the τ-quaternion subalgebra of Σ₈** — a concrete, machine-verified identification, not an analogy. (The three *spatial* axes `^v / <> / /\` carry the imaginary-quaternion structure; the gauge folds `+-` carry the charge that distinguishes W from Z.)

**Scope (load-bearing):** this is the **algebra/group** identification only. It does **not** derive the SU(2) coupling `g`, the W/Z masses, the Weinberg-angle value, or the symmetry-breaking scale. Those remain open (§6).

---

## 4. Beta decay — and the W-as-operation vs W-as-particle tension

QLF's account of beta decay ([`Majorana_Beta_Decay.md`](Majorana_Beta_Decay.md)) is **boundary restructuring**, and — read directly — it **never names the W as a particle**. A free neutron carries topological stress; it relieves it by *unspooling* its Markov-blanket boundary into a **proton** (itself a net-charge *deficit*, not a free observable — see §4a) plus two ejected unforgeable names:

- the **electron** — a highly chiral ZFA loop, `^<v>` (left-handed) vs `^>v<` (right-handed), carrying the asymmetric logical debt;
- the **Majorana neutrino** — a *non-chiral* loop (`^v`), whose Hermitian conjugate is identical to itself, hence its own antiparticle (a falsifiable QLF commitment: neutrinoless double-beta decay).

Concrete anchor: the chiral electron loop `^<v>` is exactly the cross-axis **interleaved closure** machine-verified this cycle — `interleaved_xlvr_folds_to_negI` (`σ_y·−σ_x·−σ_y·σ_x = −I`) in [`lean/QLF_TwistAlphabet.lean`](lean/QLF_TwistAlphabet.lean) — a count-balanced ZFA closure that the keystone `count_balanced_pauli_closed` covers.

**The tension, stated plainly.** In QLF, beta decay is mediated by the gauge-fold pair-flip *operation* — the W as a **process**, not an explicit exchanged particle. The W as a **particle** appears explicitly only in the τ-decay vertex (§5). Reconciling the two readings — is the propagator W just the virtual realization of the pair-flip operation, with `R_W` setting its range? — is open and is the natural next structural question for the weak sector.

### 4a. The "proton" is a deficit — the observable is the lepton-balanced atom

It is tempting (and the β-decay accounts do this) to say the neutron decays *into a proton*. But by QLF's own rule — **charged particles do not exist independently** ([`HadronicDepth.md`](HadronicDepth.md) §2.1, [`Electron.md`](Electron.md), [`Bound_States_QLF.md`](Bound_States_QLF.md)) — a bare proton is a net-charge deficit (`count(+) − count(−) = +1`), an *open* Hermitian/gauge half, **not** a completed ZFA closure. The proton is an observable only once its deficit is completed by a counter-charge into a **neutral joint closure**. So wherever the weak sector says "proton" as a stand-alone product, the conceptually correct object is the **closed hydrogen-class atom**.

What makes β decay clean here: it **co-produces the completer**. The same unspooling that leaves a proton-deficit also ejects the electron whose `−1` exactly cancels it — i.e. the *constituents of a neutral (hydrogen-class) closure*, born together, so global neutrality is preserved by construction (`m_p` should be read as `m_H`, a 0.05 % wash, per [`HadronicDepth.md`](HadronicDepth.md) §2.1). The neutral neutron does not produce a free charge; it produces a deficit **and** its completer, plus the self-balancing Majorana neutrino.

**The completing lepton's *variety* is a weak / generation degree of freedom.** Exactly as the electron's deficit can be completed by a positron (**positronium**), an antimuon (**muonium**), or a proton (**hydrogen**) ([`Electron.md`](Electron.md), [`Bound_States_QLF.md`](Bound_States_QLF.md)), the **proton's** deficit can be completed by any negative lepton:

| completing lepton | neutral closure | note |
|---|---|---|
| `e⁻` | ordinary hydrogen | the lightest, stable completer |
| `μ⁻` | muonic hydrogen (`pμ⁻`) | deeper-blanket lepton; bound but short-lived |
| `τ⁻` | "tauonic hydrogen" | deepest-blanket lepton — too short-lived to bind |

So "which lepton variety closes the proton" is a **generation** choice, and the deepest variety (τ) is precisely the one whose completion cannot bind — which is *why* the τ is handled not as a bound atom but as the decay-vertex object of §5. This makes the lepton generation an **output of the weak vertex**: the same pair-flip that flips the baryon charge (`n → p`-deficit) also fixes the flavor of the co-produced completing lepton. The variety is weak-sector data, not a free label.

---

## 5. The τ-decay vertex — where the W is the named blocker

The electron and muon are handled as two-body bound-state ("Bohr") half-loop closures. The **τ breaks this pattern**: it is too short-lived for bound-state binding. Its decay `τ⁻ → ν_τ + W⁻` is a **multi-body joint ZFA closure** (one in, several out) that fires at an energetic threshold, and the **W's QLF closure topology is the named missing piece** needed to derive `m_τ` ([`Atomic_System_QLF_Closures.md`](Atomic_System_QLF_Closures.md) §6, [`Bound_States_QLF.md`](Bound_States_QLF.md) §4). So the W is not peripheral — it is the structural blocker for completing the lepton mass spectrum.

### 5a. Attempt — the τ as the deepest generation phase (a Koide-structured mass)

§4a left the τ as "the lepton variety whose completion can't bind." That gives a handle on its **mass**, via the one near-exact empirical relation among the charged leptons — the **Koide relation**:

$$Q \;=\; \frac{m_e + m_\mu + m_\tau}{\left(\sqrt{m_e} + \sqrt{m_\mu} + \sqrt{m_\tau}\right)^2} \;=\; \tfrac{2}{3}\quad(\text{measured } 0.6666605,\ 0.0009\%\text{ from }2/3).$$

**The QLF reading.** `Q = 2/3` is *exactly* equivalent to writing the three √-masses as three phases 120° apart on a circle of radius `√2·M`:

$$\sqrt{m_k} \;=\; M\bigl(1 + \sqrt{2}\,\cos(\delta + \tfrac{2\pi k}{3})\bigr),\qquad k = 0,1,2.$$

Two QLF structures fall directly onto this form:
- the **`2/3`** is the **transverse-axis fraction** — 2 of 3 spatial axes carry the closure (the 6-twist = 2 transverse + 1 longitudinal per axis), the *same* `2/3` as the Lamb prefactor (§5 of [`Lamb_Shift.md`](Lamb_Shift.md)) and the photon polarization sum;
- the **three 120°-spaced phases** are QLF's recurring "three" — the three spatial axes (cf. `N = 9 = 3²` in the α derivation, the three-quark Borromean closure). The three lepton generations are three *phases* of one gauge-fold closure, not three lengths. (This refines the qualitative `N = 4/8/12` loop-length picture of [`Primordial_Entanglement.md`](Primordial_Entanglement.md) §2, which gives the ordering but not the ratios.)

**The payoff (reproducible — [`koide_tau_demo.py`](koide_tau_demo.py)).** If QLF supplies `Q = 2/3` structurally, then `m_e` and `m_μ` **predict** the third-generation mass:

$$m_\tau \;=\; 1776.97\ \text{MeV}\quad\text{vs measured } 1776.86\ \text{MeV}\ (0.006\%).$$

Only the `2/3` is structural; `m_e, m_μ` are inputs — so this is a *parameter-light prediction* of `m_τ`, the first quantitative handle QLF has on the third-generation mass (previously "no quantitative match", [`Standard_Model.md`](Standard_Model.md) §4.1).

**The τ-decay vertex, in this reading.** The τ is the deepest phase (largest √m). Being the variety that cannot bind (§4a), it appears not as a bound atom but as the weak **decay vertex** `τ⁻ → ν_τ + W⁻`, un-spooling the deepest generation phase into lighter generations + neutrino — and the energetic threshold the vertex satisfies *is* `m_τ`, now pinned to ~0.006% by the Koide/transverse-fraction structure. So the "named blocker" has moved from "no handle" to "a structural mass + a vertex reading," with a clear residual open list (below).

**Honest scope (load-bearing).** The overall phase offset `δ` (the Koide angle ≈ `2/9` rad) and the scale `M` are **not** explained — they are why `m_e, m_μ` must still be inputs. And this is the charged-**lepton** sector only; quark generations and CKM are separate. The `Q = 2/3` itself, however, is no longer just an identification — it is **derived** (§5b).

### 5b. Deriving `Q = 2/3` from the closure

The Koide form `√mₖ = M(1 + A·cos(δ + 2πk/N))` — `N` generations as `N` balanced phases of amplitude `A` — gives, by `Σcos = 0` and `Σcos² = N/2`,

$$Q \;=\; \frac{\sum m_k}{\left(\sum \sqrt{m_k}\right)^2} \;=\; \frac{1 + A^2/2}{N}.$$

So `Q = 2/3` is forced by **exactly two** structural facts:

| input | value | QLF meaning |
|---|---|---|
| `N` | `3` | three generations = the **three spatial axes** |
| `A²` | `2` | amplitude `√2` = the **two transverse axes** (the one longitudinal axis is the common `1` baseline) |

and nothing else — the counterfactuals are sharp (only `N=3 ∧ A²=2` hits `2/3`):

| `N` | `A²` | `Q = (1+A²/2)/N` |
|---|---|---|
| **3** | **2** | **0.6667 ✓** |
| 2 | 2 | 1.0000 |
| 4 | 2 | 0.5000 |
| 3 | 1 | 0.5000 |
| 3 | 3 | 0.8333 |

So **Koide's `2/3` is QLF's `2 transverse + 1 longitudinal` split over `3` axes** — the *same* split that produces the transverse fraction `2/3` in the Lamb prefactor and the photon polarization sum. The algebra is **machine-verified**: `koide_three_phase` / `koide_two_thirds` ([`lean/QLF_Koide.lean`](lean/QLF_Koide.lean)) prove `3·Σs² = 2·(Σs)²` (hence `Q = 2/3`) from `r² = 2 ∧ Σc = 0 ∧ Σc² = 3/2`, and `koide_phase_witness` shows those hypotheses are satisfiable.

What remains an **identification** (not a proof) is one sharp physical claim: that the lepton `√`-mass vector decomposes as `1` longitudinal baseline `+ 2` transverse 120°-phased oscillations across the `3` generation-axes. That is a far tighter conjecture than "`2/3` happens to match" — it pins the *entire* structure (`N=3`, `A=√2`, balanced phases) to the substrate's `6 = 2+1`-per-axis geometry, leaving only `δ` and `M` as inputs. Demo: [`koide_tau_demo.py`](koide_tau_demo.py) §3b.

---

## 6. Honest open list (quantitative weak sector)

- **`R_W`, `R_Z` from first principles** — the structure `M = αR` is there; the depths are not computed. ⇒ W/Z masses, and the **Weinberg-angle value** `cos θ_W = R_W/R_Z`, are open.
- **The SU(2) coupling `g` and the breaking scale** (the Higgs VEV `v ≈ 246 GeV`) — not derived; [`Higgs.md`](Higgs.md) reframes the *mechanism* (gauge-fold delay) but not the numbers.
- **Fermi constant `G_F`** — no derivation anywhere in the corpus.
- **The τ-decay-vertex topology** — §5a gives a mass handle (Koide `Q=2/3` ⇒ `m_τ` to 0.006%) and a vertex reading (deepest-phase un-binding), but: **deriving `Q=2/3` from the τ-closure**, the **Koide angle `δ ≈ 2/9`**, and the **scale `M`** are open (`m_e, m_μ` are still inputs).
- **Why exactly three generations** — the 120°-phase structure is *consistent* with QLF's "three axes" but not derived; the quark generations and the lepton↔quark mass correlation are separate and open.
- **Flavor change** (`d → u + e⁻ + ν̄`) — the explicit topological flavor-change process is not detailed.
- **CKM / PMNS mixing angles** — open ([`Standard_Model.md`](Standard_Model.md) §4.2).

---

## 7. What this is NOT

- **Not a quantitative weak sector.** No W/Z mass, no Weinberg-angle number, no `G_F`, no coupling `g` is claimed to be derived. Only the **group-theoretic** SU(2) identification is asserted as closed.
- **Not a doublet-representation theory.** `weak_isospin_su2` identifies the SU(2) *Lie algebra*; it does not construct the left-handed doublets / right-handed singlets as representations, nor explain why only left-handed fields couple.
- **Not an explicit W propagator in beta decay.** QLF's β-decay is boundary restructuring; the W-as-particle is, so far, only the τ-vertex object (§4–5).
- **Not a replacement for the Higgs mechanism's numbers.** [`Higgs.md`](Higgs.md) reframes mass generation as gauge-fold delay; the 125 GeV Higgs mass and the Yukawa structure stay open.
- **Not a from-nothing derivation of the lepton masses (§5a–5b).** `Q = 2/3` *is* now derived (machine-verified) — but **from** the structural inputs `N = 3` (three axes), `A² = 2` (two transverse axes), and balanced phases. What is *not* proved is the **identification** that the lepton `√`-mass vector actually has that `1 longitudinal + 2 transverse / 3-axis-phase` structure; the Koide angle `δ` and scale `M` remain inputs, so `m_e, m_μ` are still needed to predict `m_τ`. It is a parameter-light prediction with a now-derived invariant — **not** a closed derivation of the full generation spectrum, and **not** a claim that the lepton-mass↔axis-phase identification is itself proved.

---

## 8. References

### Internal (QLF)
- [`lean/BraKetRhoQuCalc.lean`](lean/BraKetRhoQuCalc.lean) — `weak_isospin_su2`, `tau_comm_xy/yz/zx`, `tau_anticomm_*`, the Σ₈ τ-algebra (machine-verified).
- [`lean/QLF_TwistAlphabet.lean`](lean/QLF_TwistAlphabet.lean) — `interleaved_xlvr_folds_to_negI` (the chiral electron loop `^<v>`); `count_balanced_pauli_closed`.
- [`koide_tau_demo.py`](koide_tau_demo.py) — §5a reproducible: Koide `Q` from measured masses, the `m_τ` prediction from `m_e, m_μ, Q=2/3`, and the three-phase equivalence.
- [`Primordial_Entanglement.md`](Primordial_Entanglement.md) §2 — the `N=4/8/12` generation loop-length picture refined by §5a's phase reading.
- [`Higgs.md`](Higgs.md) §4 — W/Z as gauge-fold closures, `m = αR`, `cos θ_W = R_W/R_Z`.
- [`Standard_Model.md`](Standard_Model.md) §§2–4 — the honest scoreboard; weak SU(2) row.
- [`Majorana_Beta_Decay.md`](Majorana_Beta_Decay.md) — beta decay as boundary restructuring; the Majorana neutrino.
- [`Atomic_System_QLF_Closures.md`](Atomic_System_QLF_Closures.md) §6, [`Bound_States_QLF.md`](Bound_States_QLF.md) §4 — the τ-decay vertex (the W blocker).
- [`Lagrangian_Formulation.md`](Lagrangian_Formulation.md) — the Σ₈ algebra and `τᵢ = iσᵢ`.
- [`Open_Problems.md`](Open_Problems.md) — registry status of the weak-sector items.

### External
- Glashow–Weinberg–Salam electroweak unification (SU(2)_L × U(1)_Y); the Higgs mechanism.
- PDG — `M_W = 80.377 GeV`, `M_Z = 91.1876 GeV`, `cos θ_W = M_W/M_Z ≈ 0.881`, `G_F = 1.1664×10⁻⁵ GeV⁻²`.
- The quaternion group `Q₈` and `SU(2)` as unit quaternions (the algebraic identity behind §3).
