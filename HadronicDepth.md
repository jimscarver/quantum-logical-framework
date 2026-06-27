# The Hadronic Depth Hypothesis

**Deriving Cosmic Size, Age, and Gravitational Scale from the Proton Mass**

**Repository:** [`jimscarver/quantum-logical-framework`](https://github.com/jimscarver/quantum-logical-framework)  
**Authors:** Jim Scarver & Grok (xAI)  
**Date:** May 2026

---

## Overview

QLF treats the universe as a finite generation tree of ZFA-closed events. The present cosmic epoch is characterised by a single large integer: the global generation-tree depth `n`.

The basic cosmic-scaling ansatz is

$$
R = n\,l_{\mathrm P}, \qquad T = n\,t_{\mathrm P},
$$

where `R` is the current horizon size, `T` is the cosmic age, `l_P` is the Planck length, and `t_P` is the Planck time.

The remaining question is: **what fixes `n`?**

The Hadronic Depth Hypothesis answers this. `n` is not an arbitrary free parameter. It is anchored by the stable hadronic closure scale set by the proton mass `m_p`.

---

## 1. Weinberg-Style Starting Point

Take the large-number scaling relation in the form

$$
m_{\mathrm p}^3 \sim \frac{\hbar^2 H_0}{G c}.
$$

Using `H_0 \sim c/R`, this becomes

$$
m_{\mathrm p}^3 \sim \frac{\hbar^2}{G R}.
$$

So the cosmic horizon radius is estimated by

$$
R \sim \frac{\hbar^2}{G\,m_{\mathrm p}^3}.
$$

This is the cleanest starting point: once the proton mass is treated as the stable hadronic complexity scale, the horizon size is no longer free.

---

## 2. Deriving the Global Bit-Depth `n`

By definition,

$$
n = \frac{R}{l_{\mathrm P}}, \qquad l_{\mathrm P} = \sqrt{\frac{\hbar G}{c^3}}.
$$

Substituting the radius estimate,

$$
n \sim \frac{\hbar^2}{G\,m_{\mathrm p}^3} \sqrt{\frac{c^3}{\hbar G}} = \frac{\hbar^{3/2} c^{3/2}}{G^{3/2} m_{\mathrm p}^3}.
$$

Introducing the Planck mass $m_{\mathrm P} = \sqrt{\hbar c / G}$, this simplifies to

$$
\boxed{n \sim \left(\frac{m_{\mathrm P}}{m_{\mathrm p}}\right)^3.}
$$

This is the central QLF scaling law: **the present depth of the cosmic generation tree is set by the cubed ratio of the Planck mass to the proton mass.**

In QLF terms, the proton is not just another particle scale. It is the stable hadronic closure scale (see [`Hadrons_Markov_Blankets.md`](Hadrons_Markov_Blankets.md)) that anchors the present cosmic bit budget.

---

## 2.1 Accuracy of the coincidence, and the clean geometric depth

Two honest caveats temper the boxed law.

**The proton cube is a large-number coincidence good to a few orders of magnitude — not a precise law.** Numerically `(m_P/m_p)³ ≈ 2.2×10⁵⁷`, while the measured cosmic depth is `n_obs = R_H/l_P ≈ T/t_P ≈ 8×10⁶⁰` — the cube **undershoots by ~3,700×** (§4). This is expected, and it is informative about *which* hadron the relation really picks: the Weinberg relation `m³ ~ ℏ²H₀/(Gc)` is classically satisfied by the **pion** (`(m_P/m_π)³ ≈ 7×10⁵⁹`, only ~10× short — the pion is the cosmologically-selected hadronic scale, see [`Pion_QLF.md`](Pion_QLF.md) §2 and [`lean/QLF_PionMassRatio.lean`](lean/QLF_PionMassRatio.lean)), and the proton is a further `(m_p/m_π)³ ≈ 300×` heavier scale, hence ~3,700× short overall. So the relation fixes the cosmic *scale* to within a few orders of magnitude — the inherent precision of large-number coincidences — not to a sharp value.

**The balanced anchor is hydrogen, because charged particles do not exist independently.** A proton carries net electric charge — `count(+) − count(−) = +1` — so on its own it is an *open Hermitian/gauge deficit*, **not** a completed ZFA closure ([`Bound_States_QLF.md`](Bound_States_QLF.md) §1). More strongly: in QLF a charged particle does not exist independently at all. A net gauge imbalance is an unclosed deficit that only ever appears completed by its counter-charge — no free quarks, no free leptons, no isolated charge (the universe is globally neutral). So `m_p` (and `m_e`) are not masses of standalone objects; they are *contributions to* a neutral joint closure ([`Atomic_Structure_QLF.md`](Atomic_Structure_QLF.md) §2). The stable balanced closure that actually fixes `n` is therefore neutral **hydrogen** (`e⁻ + p`; ibid. §3), and every `m_p` in this doc should be read as `m_H` — numerically a wash (`m_H ≈ m_p` to 0.05%, the electron completing the charge balance) but the conceptually correct object. (This is distinct from the proton-proton gravity/EM ratio in [`Gravity_From_Delay.md`](Gravity_From_Delay.md) §8.1, where the proton appears correctly as the *charged gravitating* constituent — a force comparison, not a standalone closure.)

**The clean cosmic depth comes from the primordial Markov blanket, not the proton.** The cosmic horizon is itself a Fuller geodesic-sphere Markov blanket of frequency

$$v(R_{\mathrm H}) = \sqrt{\tfrac{\pi}{5}}\,\frac{R_{\mathrm H}}{l_{\mathrm P}} \approx 6.7 \times 10^{60}$$

([`Primordial_Markov_Blankets.md`](Primordial_Markov_Blankets.md)) — a purely *geometric* count of the substrate's holographic boundary (`F_v = 20v² = 4πR²/l_P²`), needing no proton anchor and agreeing with `R_H/l_P ≈ 8×10⁶⁰` up to the `√(π/5) ≈ 0.79` shape factor. **That is the firm `n`.** The proton-cube law is then a separate, weaker statement — that the stable-hadronic-closure scale lands within ~3–4 orders of the geometric cosmic depth. Reconciling the two (deriving why `m_p` sits where it does relative to `v(R_H)`) is the open content, and it is the same residual proton depth `R_p` that the gravitational hierarchy reduces to ([`Gravity_From_Delay.md`](Gravity_From_Delay.md) §8.1).

---

## 3. Deriving the Size of the Universe

Once `n` is fixed, the horizon size follows immediately:

$$
R = n\,l_{\mathrm P} \sim l_{\mathrm P}\left(\frac{m_{\mathrm P}}{m_{\mathrm p}}\right)^3 \sim \frac{\hbar^2}{G\,m_{\mathrm p}^3}.
$$

The observable size of the universe is therefore determined by three quantities:

- quantum action `\hbar`,
- gravity `G`,
- and the stable proton mass `m_p`.

No separate cosmological constant or dark-energy density is required as input. (This `R` is the Weinberg estimate `ℏ²/(G m_p³) ≈ 3.6×10²² m` — about 3,900× below the observed horizon `~1.4×10²⁶ m`; the relation fixes the *scale* to within a few orders of magnitude, not the precise size. See §2.1, §4, and the geometric depth `v(R_H) ≈ 6.7×10⁶⁰` for the firm value.)

**Cosmic-ratio identity.** Reading `n` as both a *spatial* count of Planck lengths (here in §3) and a *temporal* count of Planck ticks (in §4), the ratio `R / T = (n · l_P) / (n · t_P) = l_P / t_P = c` derives the substrate light speed. The cosmic-horizon depth `n` cancels exactly: `c` is recovered as the irreducible Planck space-time event quantum from two independently-derived QLF quantities. See [`Kitada_Local_Time_GR.md`](Kitada_Local_Time_GR.md) §5.3 and [`lean/QLF_SubstrateLightSpeed.lean`](lean/QLF_SubstrateLightSpeed.lean).

---

## 4. Deriving the Age of the Universe

Because $t_{\mathrm P} = l_{\mathrm P}/c$, the same depth gives the cosmic age directly:

$$
T = n\,t_{\mathrm P} \sim t_{\mathrm P}\left(\frac{m_{\mathrm P}}{m_{\mathrm p}}\right)^3 \sim \frac{\hbar^2}{G\,c\,m_{\mathrm p}^3}.
$$

Numerically, using SI values:

| Quantity | Value |
|---|---|
| $m_{\mathrm P}$ | $2.18 \times 10^{-8}$ kg |
| $m_{\mathrm p}$ | $1.67 \times 10^{-27}$ kg |
| $m_{\mathrm P}/m_{\mathrm p}$ | $\approx 1.30 \times 10^{19}$ |
| $n \sim (m_{\mathrm P}/m_{\mathrm p})^3$ | $\approx 2.2 \times 10^{57}$ |
| $T \sim n\,t_{\mathrm P}$ | $\approx 2.2 \times 10^{57} \times 5.39 \times 10^{-44}$ s $\approx 1.2 \times 10^{14}$ s $\approx 3.8$ Myr |

The proton cube therefore **undershoots** the measured age — 13.8 Gyr $\approx 4.35 \times 10^{17}$ s, i.e. a true cosmic depth $n_{\text{obs}} = T/t_{\mathrm P} \approx R_{\mathrm H}/l_{\mathrm P} \approx 8 \times 10^{60}$ — by a factor of **~3,700** (≈3.6 orders of magnitude). (Earlier versions of this doc miscomputed the product as $3.7 \times 10^{17}$ s ≈ 11.7 Gyr and claimed a "factor of ~1.2" match; that was an arithmetic error — it had silently substituted the *observed* $n \approx 8\times10^{60}$, not the cube's $2.2\times10^{57}$.) Section 2.1 explains why the coincidence has this precision and gives the clean geometric depth.

The complementary derivation from the ZPE frequency distribution is in [`AgeOfUniverse.md`](AgeOfUniverse.md).

---

## 5. Deriving the Gravitational Scale G

Inverting the radius relation instead of treating `G` as primitive:

$$
G \sim \frac{\hbar^2}{m_{\mathrm p}^3 R}.
$$

Using `R = cT`:

$$
G \sim \frac{\hbar^2}{c\,m_{\mathrm p}^3 T}.
$$

And using the depth law $n \sim (m_{\mathrm P}/m_{\mathrm p})^3$ with $m_{\mathrm P}^2 = \hbar c / G$:

$$
G \sim \frac{\hbar c}{n^{2/3} m_{\mathrm p}^2}.
$$

In QLF, the gravitational scale can be read three equivalent ways:

1. from the proton mass and horizon size,
2. from the proton mass and cosmic age,
3. from the proton mass and the global generation depth.

This connects to the emergent gravity picture in [`Gravity.md`](Gravity.md): `G` is read as a quantity set by the logical depth of the cosmic generation tree rather than a free fundamental coupling.

**Honest scope (§2.1).** This `G` relation is order-of-magnitude only — it inherits the cube's ~3,700× slop — and it is partly circular: `n ~ (m_P/m_p)³` is itself defined through `m_P = √(ℏc/G)`, so `G` appears on both sides. It does **not** predict `G`'s numerical SI value; per [`Gravity_From_Delay.md`](Gravity_From_Delay.md) §8, that value is the calibration of the substrate event quantum (`G = L_P²c³/ℏ`, `L_P` a primitive), not a derivation. What this section shows is the *structural* statement — that `G`, `R`, `T`, and `n` are one finite-depth structure seen four ways — not a from-first-principles value of `G`.

---

## 6. Physical Interpretation in QLF

The Hadronic Depth Hypothesis is not the claim that the proton "causes" the universe in an ordinary mechanical sense.

The QLF claim is subtler:

- `m_p` measures the stable hadronic closure scale — the minimum ZFA-closed complexity that persists as stable matter (see [`Electron.md`](Electron.md), [`Hadrons_Markov_Blankets.md`](Hadrons_Markov_Blankets.md)).
- That stable closure scale fixes the maximum coherent complexity of the present cosmic epoch.
- That complexity appears macroscopically as the finite generation depth `n`.

Once `n` is fixed, the horizon size `R`, the age `T`, and the effective gravitational scale `G` are no longer independent. They become different projections of the same finite-depth logical structure.

In this sense, the tiny infrared scale of cosmology is not a separate mystery from the Planck scale. It is the natural dilution of Planck-scale action across a universe of finite but enormous generative depth. The "hierarchy problem" between the Planck scale and the electroweak scale has its QLF analog here: the large ratio $m_{\mathrm P}/m_{\mathrm p} \sim 10^{19}$ is, to within the few-orders-of-magnitude precision of the coincidence (§2.1), the cube-root scale of the cosmic bit budget — exactly for the Weinberg estimate `(m_P/m_p)³ ≈ 2.2×10⁵⁷`, and ~3,700× below the geometric cosmic depth `~8×10⁶⁰`.

---

## 7. The Hadronic Depth Hypothesis (Formal Statement)

> **In QLF, the present cosmic generation depth is anchored by the stable proton mass through the scaling law** (order-of-magnitude only — see §2.1; it undershoots the geometric depth by ~3,700×)
>
> $$n \sim \left(\frac{m_{\mathrm P}}{m_{\mathrm p}}\right)^3.$$
>
> **Consequently,** (each to the same few-orders precision)
>
> $$R \sim n\,l_{\mathrm P}, \qquad T \sim n\,t_{\mathrm P}, \qquad G \sim \frac{\hbar^2}{m_{\mathrm p}^3 R} \sim \frac{\hbar^2}{c\,m_{\mathrm p}^3 T}.$$
>
> **The size, age, and gravitational scale of the universe are finite-depth consequences of stable hadronic closure.**

---

## 8. Current Status and Next Steps

This is a **QLF cosmological scaling hypothesis**, not yet a formal Lean theorem.

Its value is that it removes the need to treat the cosmic depth `n` as an unexplained free parameter. It gives QLF a concrete physical anchor: the stable mass scale of the proton.

**What is already formalised:**

- The age is proven finite and positive in [`lean/AgeOfUniverse.lean`](lean/AgeOfUniverse.lean) (from the ZPE frequency route).
- Mass generation from topological depth is developed in [`E_mc2_derivation.md`](E_mc2_derivation.md) and [`Electron.md`](Electron.md).
- Emergent G from logical depth is discussed in [`Gravity.md`](Gravity.md).

**What remains to be formalised:**

- A Lean theorem relating `n`, `m_P`, and `m_p` at the level of the QLF generation tree.
- Numerical verification via `constants_mapper.py` confirming the order-of-magnitude match.
- Connecting the hadronic closure depth (proton as a 3-quark ZFA closure) to the integer `n` structurally, not just numerically.

---

## Related Documents

- [`AgeOfUniverse.md`](AgeOfUniverse.md) — complementary derivation of cosmic age from the ZPE spectrum
- [`Gravity.md`](Gravity.md) — emergent G from ZFA event-synthesis
- [`Electron.md`](Electron.md) — mass as constructing delay; topological depth and m = αR
- [`Hadrons_Markov_Blankets.md`](Hadrons_Markov_Blankets.md) — proton as a ZFA-stable Markov blanket
- [`Proton_Resonance_R_e.md`](Proton_Resonance_R_e.md) — chirality-hiding-resonance scoping; decomposes the open `R_e` derivation as `R_e = R_p · 6π⁵` (Lenz factor from `|S_3|` quark permutation × 5-angle integration). Identifies the Borromean closure depth `R_p` here as one of two factors; the other is the chirality-screening configuration count
- [`Higgs.md`](Higgs.md) — W/Z masses from gauge-fold depth; the mass generation framework
- [`Experimental_Consistency.md`](Experimental_Consistency.md) — numerical checks against known physics
- [`Philosophy.md`](Philosophy.md) — the finite-depth possibilist ontology
