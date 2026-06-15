# Physical Pi — a π-convergent closure census (and what is, and isn't, a QLF gap)

**Module:** [`lean/QLF_PhysicalPi.lean`](lean/QLF_PhysicalPi.lean)
**Companions:** [`lean/QLF_LoopClosure.lean`](lean/QLF_LoopClosure.lean) (the closure machine vs the *chosen* `2π` rendering), [`TheContinuum.md`](TheContinuum.md), [`Continuum_Choice_Fallacy.md`](Continuum_Choice_Fallacy.md) (`π` is a *computable* real; the continuum is the fallacy, not the target).
**Origin:** Allen's issues [#86](https://github.com/jimscarver/quantum-logical-framework/issues/86) / [#89](https://github.com/jimscarver/quantum-logical-framework/issues/89) and his [`fundamentalPi.md`](https://github.com/lightrock/CharacteristicImpedancePython/blob/main/docs/references/fundamentalPi.md) — *"stop worshiping the notation, find the machine**s**."*

> **Status (after Allen's #89 review).** Allen's review has two kinds of points, and QLF answers them
> differently.
> **(a) Honest-scope/technical — correct, adopted in full below:** the *convergence* theorem is not yet
> wired into the Lean module; the 2-D *squaring* presupposes a random-walk model; the gauge phase
> increments need group-theory caveats (`4π` is representation-dependent, `2π/3` is a center increment);
> and the Riemann/GUE tie is a *shared object*, not a proof. Those are real and are fixed here.
> **(b) The headline framing — declined on QLF grounds:** the demand "*recover the continuum geometric
> `π` (circumference/area) from isotropy, or you have failed*" assumes there **is** a continuum `π` out
> there to recover. QLF's foundational thesis is that there is **not** — the continuum is mathematics'
> ultraviolet catastrophe ([`Continuum_Choice_Fallacy.md`](Continuum_Choice_Fallacy.md),
> [`TheContinuum.md`](TheContinuum.md)). `π` is the **limit/rendering of the discrete closure machine**,
> with no deeper continuum referent. So the honest QLF claim is: *a `Real.pi`-free, π-convergent closure
> census, with its count Lean-anchored and its convergence a settled classical theorem (cited)* — **not**
> "`π` recovered from the continuum," because under QLF's ontology that is not a coherent target.

---

## §0 The thesis

`π` is **not a stored primitive**; it is the **signature of closure detection** — what you get when a
process "goes around, compares with where it started, and asks whether the state actually closed"
(Allen). QLF exhibits a *substrate-native* finite object — the ZFA closure census — whose limit is `π`,
and shows it is the *same* `C(2n,n)` that runs the Born statistics, the P-vs-NP verify-filter, and the
Riemann gap-zero density. `π` is a **computable** real (a finite algorithm yields any precision — it was
never the continuum fallacy). The machine is the discrete census; `Real.pi` is its **limit/rendering**,
never a substrate primitive — and, crucially, never a hidden continuum the census is merely
*approximating*. There is nothing "behind" the census to recover.

## §1 The closure census (count Lean-anchored; convergence a cited classical theorem)

Allen's strongest generator is the **path-counting return walk**. In QLF the count is the substrate's
own closure census: the number of ZFA-balanced stable closures of length `2n` is exactly the central
binomial coefficient — **a QLF theorem**:

$$
\#\{\text{stable closures of length } 2n\} = \binom{2n}{n}
\qquad(\texttt{closure\_census},\ \texttt{find\_stable\_states\_length\_even})
$$

— the same `C(2n,n)` behind the Born statistics, the P-vs-NP verify-filter
(`realized_count_eq_central_binomial`), and the Riemann gap-zero density. Form the rational

$$
P_{2n}(0) = \left(\frac{\binom{2n}{n}}{4^{n}}\right)^{2}
\qquad(\texttt{returnDensity},\ \texttt{returnDensity\_eq\_census})
$$

a finite, computable **rational** with no `Real.pi` in it — also Lean-anchored. The classical asymptotic
`C(2n,n) ~ 4ⁿ/√(πn)` (Wallis/Stirling) gives `n·P₂ₙ(0) → 1/π`, i.e.

$$
\pi \;=\; \lim_{n\to\infty}\frac{1}{n\,P_{2n}(0)}.
$$

**Two honest caveats (Allen #89):**

1. **The convergence is not yet a *QLF* theorem — but it is not in doubt.** `closure_census`,
   `returnDensity`, `returnDensity_eq_census` are proven; the limit `n·returnDensity → 1/π` is the
   central-binomial Wallis/Stirling asymptotic, a **settled theorem already in Mathlib** — it simply has
   not been *imported and discharged* in this module (`physical_pi_in_progress` is a marker, not the
   proof). This is a wiring task, not a conceptual gap. Until it is wired, the right verb is *converges
   to* (cited), not *is proven by QLF to converge to*.
2. **The 2-D *squaring* presupposes a walk model.** Counting balanced strings gives `C(2n,n)`; squaring
   `(C(2n,n)/4ⁿ)²` for a 2-D return probability models the substrate as **two independent, equally-weighted
   1-D walks** (one per axis). That Pólya-walk model is *imposed on* the census; QLF has not yet
   constructed the probability space and proven the equivalence. (Honest gap — but see §5: this is about
   *which* discrete model, not about a continuum.)

## §2 Three classical machines, as closure processes

`π` is the limit of several finite, computable processes — each a "go around and test closure" (classical
convergence facts QLF *reads*):

- **Signed-residue sum (Leibniz–Gregory).** `π/4 = 1 − 1/3 + 1/5 − 1/7 + …` — an alternating signed
  count over odd residues, the same `count_pos − count_neg` structure QLF uses, on the odd lattice.
- **Pairing product (Wallis).** `π/2 = ∏ₙ (2n)²/((2n−1)(2n+1))` — the product form of the same
  central-binomial ratio as §1 (the Mathlib Wallis product underlying §1's asymptotic).
- **Inverse-square sum (Basel / ζ).** `π² = 6·∑_{n≥1} 1/n² = 6·ζ(2)` — `π` from a sum over the integers,
  no circle. The honest bridge to §4.

Each is RCA₀ and converges to `π`; none assumes a circle. That `π` has *many* discrete generators and
*no* canonical circle behind them is exactly the QLF reading: `π` is what these machines converge to, not
a continuum object they sample.

## §3 Phase increments per sector — 2π, 4π, 2π/3 (with the group-theory caveats)

Allen's families correspond to QLF's gauge sectors
([`Forces_From_Three_Axes.md`](Forces_From_Three_Axes.md) §3a) — but, per #89, these are **characteristic
phase increments**, not all "group periods," and the table must say so:

| increment | sector | precise statement |
|---|---|---|
| `2π` | `U(1)` / ordinary rotation | full cycle; returns to the identity. The abelian gauge-fold period (EM, the photon). |
| `4π` | `SU(2)`, **spin-½ representation** | the 720° period **of the fundamental (spin-½) representation** — *representation-dependent*: integer-spin reps already close at `2π`. Not a universal `SU(2)` period (`QLF_Spin`). |
| `2π/3` | `SU(3)` **center** `Z₃` | a center **phase increment**, *not* a return to the identity — **three** applications close it (`(e^{2πi/3})³ = 1`). |

And the `2π` itself is a **chosen continuum rendering** of the finite cycle `phase = · % N`, not a
quantity *recovered* from it: `renderAngle := 2·Real.pi·k/N` *inserts* `2π`, and `render_full_cycle` is
algebraic bookkeeping ([`QLF_LoopClosure`](lean/QLF_LoopClosure.lean)). The machine is `% N`; `2π` is the
display we choose. (Allen and QLF agree here — that `2π` is a rendering, not a recovery, is QLF's *own*
thesis, not a concession.)

## §4 The Riemann *resonance* — a shared object, not yet a shared theorem

What is true is a **structural resonance**, stated without overreach:

- **`π` and `ζ` share the census `C(2n,n)`.** `π² = 6·ζ(2)` (§2) ties `π` to `ζ`, and the `π`-census
  `C(2n,n)` is the *same* object in the QLF Riemann gap-zero density `C(2n,n)/4ⁿ ~ 1/√(πn)`
  ([`ReverseMathematics.md`](ReverseMathematics.md) §4.7, [`SpectralGap.md`](SpectralGap.md),
  [`QLF_RiemannMRE`](lean/QLF_RiemannMRE.lean)).
- **What this does *not* establish (per #89).** A reciprocal zero-gap *density* is not automatically a
  consecutive-level *spacing* distribution, much less the **GUE** (Montgomery–Odlyzko) law — that is a
  separate, unproven step. "The same coefficient appears" is a shared object, **not** a proof that "`π`
  and RH run on one machine." QLF's RH route still routes the decisive Mellin↔ζ / spacing↔GUE
  correspondence through its named boundary axioms (`spectral_hilbert_polya`, `MRE_bridge`;
  `rh_mre_proof_in_progress`). No complexity ("faster than any known process") claim is made.

## §5 Honest scope — two ledgers (Allen #89)

It matters *which kind* of item each open point is.

**Ledger A — genuine QLF work-items (discrete, internal to the substrate):**

1. **Wire in the convergence.** Import the Mathlib central-binomial/Wallis asymptotic and discharge
   `n·returnDensity → 1/π`, replacing the `physical_pi_in_progress` marker. (Settled math; not in doubt.)
2. **Construct the walk probability space.** Derive the 2-D squaring from ZFA dynamics — i.e. prove the
   substrate realizes two independent equally-weighted axis-walks — rather than imposing the Pólya model.
   This is a *discrete* equivalence theorem, fully inside QLF's frame.

**Ledger B — *not* QLF defects: requests that presuppose the continuum QLF rejects.**

3. **"Derive the geometric continuum `π` (C/2r, A/r²) from isotropy, with no circle premise."** This asks
   QLF to *recover the continuum circle*. But QLF's whole position is that the continuum circle is itself
   a **rendering** — there is no continuum `π` underneath the census to derive. QLF can (and does) tell
   the *discrete* isotropy story — directionally-unbiased closure statistics on the substrate — but it
   will not, and need not, reconstruct a continuum object it holds to be non-physical. Demanding that is
   demanding the ultraviolet catastrophe back. The discrete census's limit **is** what `π` means; "the
   continuum value it should match" is the fallacy, not the standard ([`Continuum_Choice_Fallacy.md`](Continuum_Choice_Fallacy.md)).
4. **"No physical universe-machine has been identified; it's just an estimator."** Under QLF the substrate
   **is** the discrete closure process; the census is not an *estimator of* some external continuum `π`,
   it is the thing itself. "Show nature executes the estimator" again presumes a continuum target the
   discrete process is approximating. The open *physics* questions (locality, timing, energy cost,
   dimensional emergence) are real and live elsewhere in the corpus — but they are not "π is unverified."

**Bottom line.** Adopt Ledger A (real, discrete, doable). Decline Ledger B's *framing*: QLF identifies a
`Real.pi`-free, π-convergent closure census (count proven, convergence a cited classical theorem), and
holds — as its foundational thesis, not as an evasion — that there is no continuum `π` to "recover."
`Real.pi` is not removed from Mathlib; it is *reframed* as the limit of these discrete machines. Allen's
technical points sharpen the claim; his continuum premise is the very thing QLF was built to retire.
