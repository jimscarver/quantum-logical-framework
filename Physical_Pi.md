# Physical Pi — the machines that generate π

**Module:** [`lean/QLF_PhysicalPi.lean`](lean/QLF_PhysicalPi.lean)
**Companions:** [`lean/QLF_LoopClosure.lean`](lean/QLF_LoopClosure.lean) (the closure machine vs the `2π` rendering), [`TheContinuum.md`](TheContinuum.md), [`Continuum_Choice_Fallacy.md`](Continuum_Choice_Fallacy.md) (`π` is a *computable* real, not the continuum fallacy).
**Origin:** Allen's issue [#86](https://github.com/jimscarver/quantum-logical-framework/issues/86) and his [`fundamentalPi.md`](https://github.com/lightrock/CharacteristicImpedancePython/blob/main/docs/references/fundamentalPi.md) — *"stop worshiping the notation, find the machine**s**."*

---

## §0 The thesis

`π` is **not a stored primitive**; it is the **emergent signature of closure detection** — what you get
when a process "goes around, compares with where it started, and asks whether the state actually
closed" (Allen). Physics does not carry `π` as digits; it repeatedly runs cyclic / counting processes
whose statistics produce `π`. QLF agrees and sharpens it: `π` is a **computable** real (a finite
algorithm yields any precision — it was never the continuum fallacy,
[`Continuum_Choice_Fallacy.md`](Continuum_Choice_Fallacy.md)), and the algorithms are *closure
machines*. `Real.pi` is the **limit / rendering** of those machines, never a substrate primitive.

There is no single "right way" — there are several machines, and they agree. Below: the QLF-native one
(Lean-anchored), three classical ones expressed as closure processes, the symmetry-dependent closure
*periods*, and the Riemann tie.

## §1 The closure-census machine (QLF-native, Lean-anchored)

Allen's strongest generator is the **path-counting return walk**, and in QLF its count is the
substrate's own closure census. The number of ZFA-balanced stable closures of length `2n` is exactly
the central binomial coefficient:

$$
\#\{\text{stable closures of length } 2n\} = \binom{2n}{n}
\qquad(\texttt{closure\_census},\ \texttt{find\_stable\_states\_length\_even})
$$

— the same `C(2n,n)` behind the Born statistics, the P-vs-NP verify-filter
(`realized_count_eq_central_binomial`), and the Riemann gap-zero density. The **2-D closure-walk return
probability** is then a finite, computable **rational** (no `Real.pi`):

$$
P_{2n}(0) = \left(\frac{\binom{2n}{n}}{4^{n}}\right)^{2}
\qquad(\texttt{returnDensity},\ \texttt{returnDensity\_eq\_census})
$$

and because `C(2n,n) ~ 4ⁿ/√(πn)` (Wallis/Stirling), `n·P₂ₙ(0) → 1/π`, so

$$
\boxed{\ \pi \;=\; \lim_{n\to\infty}\frac{1}{n\,P_{2n}(0)}\ }
$$

`π` from **pure counting** of the substrate's own closures — no circle, no coordinates, no `Real.pi`
assumed. The machine's moving parts (`closure_census`, `returnDensity`,
`returnDensity_eq_census`) are Lean-anchored in [`QLF_PhysicalPi`](lean/QLF_PhysicalPi.lean); the
convergence is the Wallis/Stirling asymptotic (cited from Mathlib).

## §2 Three classical machines, as closure processes

The same `π` falls out of several finite, computable processes — each a "go around and test closure":

- **Signed-residue sum (Leibniz–Gregory).** `π/4 = 1 − 1/3 + 1/5 − 1/7 + …` — the **alternating signed
  count over odd residues**, i.e. QLF's signed-count (`count_pos − count_neg`) closure structure read
  on the odd lattice. Computable; the partial sums bracket `π`.
- **Pairing product (Wallis).** `π/2 = (2·2·4·4·6·6…)/(1·3·3·5·5·7…) = ∏ₙ (2n)²/((2n−1)(2n+1))` — the
  **half-spin pairing census**, the product form of the same central-binomial ratio as §1.
- **Inverse-square sum (Basel / ζ).** `π² = 6·∑_{n≥1} 1/n² = 6·ζ(2)` — `π` from a **sum over the
  integers**, with no circle anywhere. This one is the bridge to §4.

Each is RCA₀, each generates `π` to any precision, and each is a closure test, not a circle.

## §3 The closure *periods* — why 2π, 4π, 2π/3 coexist

Allen's families fall straight out of QLF's gauge structure
([`Forces_From_Three_Axes.md`](Forces_From_Three_Axes.md) §3a): **the symmetry determines what counts
as closure**, so the closure period differs by sector —

| period | sector | QLF reading |
|---|---|---|
| `2π` | `U(1)` / ordinary rotation | the **abelian** gauge-fold full cycle (EM, the photon) |
| `4π` | `SU(2)` / spin-½ | the **720° double cover** — two half-spins close (`QLF_Spin`) |
| `2π/3` | `SU(3)` center | the **three-axis** Borromean third (colour) |

So the "different πs" are the **different closure periods of the same three-axis substrate** — the same
projections that give the gauge unification. `2π` itself is the *rendering* of the finite cycle
`phase = · % N` ([`QLF_LoopClosure`](lean/QLF_LoopClosure.lean)).

## §4 The Riemann tie — the same machine parts

Allen's open question: *can the universe finish the Riemann hypothesis with these very same machine
parts, and generate π faster than any known process?* The parts **are** shared:

- **`π` and `ζ` are the same census.** `π² = 6·ζ(2)` (§2) ties `π` directly to the Riemann zeta
  function at an even integer; the `π`-generating central binomial `C(2n,n)` is *also* the QLF Riemann
  object — the **gap-zero density** `C(2n,n)/4ⁿ ~ 1/√(πn)` carries the GUE / Montgomery–Odlyzko spacing
  of the ζ zeros ([`ReverseMathematics.md`](ReverseMathematics.md) §4.7, [`SpectralGap.md`](SpectralGap.md),
  [`QLF_RiemannMRE`](lean/QLF_RiemannMRE.lean)). So the **closure census that generates `π` is the same
  census whose Mellin image is the Riemann boundary** — `π` and RH run on one machine.
- **"Faster than any known process"** is the right intuition but unproven: the substrate *generates*
  the census in parallel (every admissible history at once), so the `π`-count and the zero-spacing are
  produced by the same possibilist enumeration — but turning that into a concrete speedup claim is open
  (it touches the same Mellin↔ζ boundary as the Riemann program, `rh_mre_proof_in_progress`).

## §5 Honest scope

What is **done**: `π`'s generator is the substrate closure census `C(2n,n)` (Lean-anchored), and the
return density that limits to `1/π` is a finite computable rational built from that count; the classical
machines (Leibniz, Wallis, Basel) are computable closure processes; the closure *periods* `2π/4π/2π/3`
are the substrate's gauge sectors; and `π²=6ζ(2)` ties `π` to the Riemann program's own census.

What is **open** (Allen's acceptance test, honestly): the **geometric** bridge — deriving the
circumference/area `π` from discrete **isotropy** with *no circle, no `Real.pi`, no radian premise*
(finite transformations → directionally-unbiased propagation → emergent circular boundary). QLF
currently *generates* `π` by counting (§1–§2) but still *renders* geometry with `Real.pi`; closing the
gap between the two is the named open piece (`physical_pi_in_progress`). And `Real.pi` is **not removed
from Mathlib** — it is *reframed* as the limit of these machines, which is the honest form of "put it
back the right way."
