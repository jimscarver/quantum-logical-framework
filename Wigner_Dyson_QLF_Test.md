# Wigner-Dyson Test on QLF-Admissible Markov-Blanket Depths

## Summary

This doc records an empirical test of the prediction made in [`ReverseMathematics.md`](ReverseMathematics.md) §4.8 / §4.9: **the discrete spectrum of admissible Markov-blanket depths `{R_X = E_Planck / (M_X c²) : X is QLF-admissible}` should exhibit Wigner-Dyson GUE nearest-neighbor spacing statistics in the large-depth limit**, the same signature Montgomery-Odlyzko observe for non-trivial Riemann ζ-zero ordinates.

**Result: current data do NOT support the GUE prediction.** In the cleanest single-sector cut (pseudoscalar mesons, J^P^C = 0⁻⁺), spacing variance is 0.74 — between GUE's 0.15 and Poisson's 1.0, leaning Poisson. In the symmetry-deduplicated hadron block, variance is 2.86 and KS rejects GUE at α=0.05. The pooled block is uninformative (variance 19.4, dominated by symmetry degeneracies).

**Status:** the strong reading of the §4.8 / §4.9 prediction is empirically weakened. The structural correspondence at the heart of §4.9 — `H ↔ H†` as counterpart of `s ↔ 1−s`, with `Σ_sa` as the operator-side critical line — does **not** depend on GUE spacing and stands independently. What the test undermines is the additional claim that R̂ behaves like a generic GUE matrix in the regime of observable bound-state depths.

Code: [`wigner_dyson_qlf_test.py`](wigner_dyson_qlf_test.py). Run with `python3 wigner_dyson_qlf_test.py` (requires only `numpy`).

---

## 1. The prediction

§4.9 defines the depth operator `R̂` on `ℓ²(Σ_sa)` and claims it is self-adjoint by construction. Its spectrum consists of the **admissible Markov-blanket depths**: `R_X = E_Planck / (M_X c²)` for each QLF-observable bound state X.

The Hilbert-Pólya conjecture posits a self-adjoint operator whose spectrum is the imaginary parts of the non-trivial ζ-zeros. Montgomery-Odlyzko established empirically that those ζ-zero ordinates exhibit Wigner-Dyson GUE spacing statistics. The §4.9 analogy invites the parallel empirical claim for `R̂`.

**Concrete prediction.** Let `{R_i}` be the admissible depths in ascending order. After unfolding (normalizing local mean spacing to 1), the nearest-neighbor spacings `s_i = (R_{i+1} − R_i) / ⟨ΔR⟩_local` should follow the Wigner surmise

$$P_{\text{GUE}}(s) \;=\; \frac{32}{\pi^2}\, s^2\, e^{-4 s^2 / \pi}, \qquad \mathrm{Var}(s) \;=\; 1 - \tfrac{8}{3\pi} \;\approx\; 0.180.$$

The competing null hypothesis is Poisson `P(s) = e^{−s}`, `Var(s) = 1`.

---

## 2. The data

The QLF-admissible observables are the bound states. Free leptons are not admissible (per [`Bound_States_QLF.md`](Bound_States_QLF.md)); hadrons are (per [`Hadrons_Markov_Blankets.md`](Hadrons_Markov_Blankets.md)); atomic systems are (per [`Atomic_System_QLF_Closures.md`](Atomic_System_QLF_Closures.md)).

The script uses:

- **68 hadronic ground-state masses** from PDG 2024 (light unflavored mesons, strange/charm/bottom mesons, baryon octet/decuplet, charm and bottom baryons).
- **6 light atomic systems** (positronium, muonium, hydrogen, deuterium, tritium, helium-4).

Total **N = 74**, spanning M ∈ {1.02 MeV, ..., 10.4 GeV} — corresponding to R ∈ {1.18 × 10¹⁸, ..., 1.20 × 10²²}, a range of about four decades.

Unfolding: density is approximately log-uniform across hadronic mass scales, so we unfold via `log(R)` and normalize spacings by the empirical mean. This is a standard procedure for sparse spectra with smooth-but-unknown density.

---

## 3. Method

Four blocks, each running the same pipeline (sort → log-unfold → spacings → normalize → Wigner-surmise comparison via KS distance):

| Block | Cut | Rationale |
|---|---|---|
| A | All 74 states pooled | Naive baseline; intentionally mixes symmetry sectors |
| B | One representative per symmetry multiplet (30 states) | Removes near-degenerate iso/SU(3) partners |
| C | Pseudoscalar mesons only (11 states, J^P^C = 0⁻⁺) | Single-channel cut, cleanest GUE comparison |
| D | 1/2⁺ baryons only (11 states) | Independent single-channel cross-check |

The test statistic is `D_KS = sup_s |F_emp(s) − F_ref(s)|` against both the GUE and Poisson CDFs. The α=0.05 critical value is `1.36 / √N` (asymptotic Kolmogorov bound).

Additional diagnostics: variance, skewness, kurtosis, and count of low-spacings (`s < 0.5`, which is the regime where GUE level-repulsion bites — GUE expects ≈ 11% of spacings there, Poisson ≈ 39%).

---

## 4. Results

| Block | N (s) | Var(s) | D vs GUE | D vs Poi | KS_crit (α=0.05) | Verdict |
|---|---:|---:|---:|---:|---:|---|
| A — pooled | 73 | 19.37 | 0.70 | 0.43 | 0.16 | rejects both, dominated by symmetry degeneracies |
| B — symm-distinct | 29 | 2.86 | 0.46 | 0.23 | 0.25 | **rejects GUE; consistent with Poisson** |
| C — pseudoscalar | 10 | 0.74 | 0.35 | 0.21 | 0.43 | inconclusive; closer to Poisson |
| D — 1/2⁺ baryons | 10 | 1.60 | 0.57 | 0.29 | 0.43 | **rejects GUE; consistent with Poisson** |

Low-spacing counts (`s < 0.5`):

| Block | Observed | GUE expected | Poisson expected |
|---|---:|---:|---:|
| A | 57 | 8.18 | 28.72 |
| B | 16 | 3.25 | 11.41 |
| C |  4 | 1.12 | 3.93 |
| D |  6 | 1.12 | 3.93 |

In every block, observed low-spacing counts exceed the Poisson expectation — i.e., the data are *more* clustered at small `s` than Poisson, let alone GUE. This is the opposite of level repulsion. In the cleanest single-sector blocks (C, D), the count is close to Poisson but trending higher.

---

## 5. Interpretation

**The pooled block (A) is uninformative.** Isospin and SU(3)-flavor partners sit at nearly equal masses (p/n, K⁰/K⁺, Σ⁺/Σ⁰/Σ⁻, etc.), producing many spurious near-zero spacings. These are symmetry-protected degeneracies, not random-matrix-theory level statistics. Strong rejection of GUE in block A is therefore expected and tells us nothing about §4.9's prediction.

**The symmetry-deduplicated block (B) is informative and rejects GUE.** With one representative per symmetry multiplet, N=29 spacings, variance 2.86, and KS distance to GUE 0.46 (well above the α=0.05 critical 0.25). The data are also closer to Poisson (0.23, just below critical), so block B is **consistent with Poisson** but **rejects GUE**.

**The single-sector blocks (C, D) are limited by sample size.** With N≈10 spacings the KS critical value (0.43) is wide and neither hypothesis can be cleanly rejected. The variance in C (0.74) is between GUE (0.15) and Poisson (1.0), leaning Poisson. The variance in D (1.60) is above Poisson, suggesting either residual symmetry effects (heavy-quark baryons span flavor) or just small-N noise.

**Three possible takeaways**, ordered by how much they require giving up:

1. **The prediction is too strong.** §4.9's structural analogy (`H ↔ H†` ↔ `s ↔ 1−s`, `Σ_sa` ↔ critical line) is a clean formal correspondence but does not entail GUE spacing statistics for R̂'s spectrum. The Hilbert-Pólya programme requires GUE; the QLF-side analogy may not. The structural piece stands; the spacing-statistics extension does not.

2. **The asymptotic regime has not been reached.** GUE is a large-N statement. At N ≲ 30 in any single sector the asymptotic distribution may not yet have emerged. ζ-zero ordinates show clear GUE statistics already at N ~ hundreds; physical mass-spectrum studies see GUE in some systems at similar N. So small-N is a plausible excuse but not a satisfying one — the variance is far from GUE, not just within sampling fluctuation.

3. **The R̂ ↔ physical-mass identification is naive.** R̂ acts on `Σ_sa`, the set of self-adjoint twist histories. Distinct elements of `Σ_sa` can have the same depth (multiplicity), and a single observed particle may correspond to multiple `Σ_sa` elements with different topologies. The mapping from "particles we observe" to "elements of `Σ_sa`" is many-to-one and not yet explicitly constructed. The right empirical test might involve enumerated `Σ_sa` elements from the QLF kernel directly, not observed bound-state masses.

The cleanest available reading is **(1) plus (3)**: the structural §4.9 correspondence holds, but the GUE-spacing extension was an overreach in the absence of a direct enumeration of `Σ_sa`.

---

## 6. What this test does and does not show

| Claim | Status |
|---|---|
| `R̂` is self-adjoint on `ℓ²(Σ_sa)` | independent of this test; still a tractable Lean target (§4.9) |
| `Σ_sa` ↔ critical line as fixed loci of the involution | independent of this test; structural correspondence stands |
| `Z_QLF` Mellin singularities are on Re(s) = 1/2 | independent; §4.2 / §4.3 / §4.8 arguments unchanged |
| R̂'s spectrum exhibits GUE Wigner-Dyson spacings | **not supported** by current data |
| The Hilbert-Pólya analogy carries the GUE spectral signature | **weakened** by this test; the QLF-side analogy does not generate GUE statistics in observable bound-state masses |

---

## 7. What a stronger test would need

- **A much larger curated set of admissible depths in a single sector.** ~10² states with proper PDG-level uncertainties. This is borderline feasible with charmed/bottom hadronic resonances from current PDG listings if one is willing to extend to many-star and unstable states.
- **Direct enumeration of `Σ_sa` from the QLF kernel.** Numerically generate self-adjoint twist histories up to some length, compute their depths, run the spacing test on the kernel-generated spectrum directly. This is the cleanest test because it tests the §4.9 claim about R̂ on `ℓ²(Σ_sa)` rather than the mapped claim about physical bound states. Implementable as a standalone Python script using the existing twist-algebra utilities.
- **A proper density-aware unfolding.** Log-uniform was a crude assumption. A smooth fit (Weyl-law-style) to the cumulative spectrum and unfolding via the fit would give cleaner local spacings.

---

## 8. Implications for the zeta-bridge programme

§4.9 made two distinct claims:

(a) **Structural correspondence.** `H ↔ H†` is the QLF-side counterpart of `s ↔ 1−s`; `Σ_sa` is the QLF-side critical line; R̂ on `ℓ²(Σ_sa)` is the natural self-adjoint operator.

(b) **Spectral statistics.** The spectrum of R̂ should exhibit GUE Wigner-Dyson spacing — the QLF-side analog of the Montgomery-Odlyzko law.

Claim (a) is a structural statement and is unaffected by this empirical result. Claim (b) is a quantitative extension and is **not supported** by the data we can currently bring to bear. §4.9 should be revised to weaken (b) accordingly — flag it as an open empirical question pending either a much larger dataset or direct `Σ_sa` enumeration.

The bridge axiom `spectral_hilbert_polya` was never going to be discharged by an empirical spacing test alone; that work continues along the Mellin-identity path independently of this result.
