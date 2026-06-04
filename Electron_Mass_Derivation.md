# First-Principles Derivation of the Electron Mass — Scope and Gaps

Per [`Bound_States_QLF.md`](Bound_States_QLF.md), the electron mass `m_e ≈ 0.511 MeV` is the electron half-loop's gauge-fold-depth contribution to the joint positronium closure (`m(Ps) = 2 m_e`), to hydrogen (`m_e + m_p`), and to muonium (`m_e + m_μ`). [`Atomic_System_QLF_Closures.md`](Atomic_System_QLF_Closures.md) §1 writes `m = α R` with `α` a unit-conversion factor and `R` a gauge-fold-depth count. The "first-principles derivation of `α R_e = m_e` from QLF closure-multiplicity" is the **open** problem of computing this product without using `m_e` as input.

This document scopes the problem honestly. It does **not** deliver the derivation — that is a research-scale open problem flagged in [`Standard_Model.md`](Standard_Model.md) §6 and [`Active_Inference_Mathematics.md`](Active_Inference_Mathematics.md) §5. It does:

1. State the problem precisely under the bound-state framing.
2. Review the existing QLF infrastructure relevant to a derivation.
3. Run the existing `constants_mapper.emerge_alpha()` and report the numerical result honestly.
4. Identify the specific gaps that block the first-principles derivation today.
5. Propose three specific pathways forward, with their tractability assessed.

The empirical finding (§3) is that the existing `emerge_alpha()` returns `α_QLF ≈ 0.2`, far from the measured `α_FS ≈ 1/137`. So the existing chain does not yet derive `m_e` from QLF closure-multiplicity — the gap is substantive, not bookkeeping.

---

## §1 The problem statement under the bound-state framing

Per [`Bound_States_QLF.md`](Bound_States_QLF.md), `m_e` is not a direct QLF observable; it is the electron's gauge-fold-depth contribution to a joint closure. The first-principles derivation question is therefore best stated as:

> **Derive the electron half-loop's gauge-fold-depth contribution to the joint positronium closure from QLF closure-multiplicity counts, without using `m_e` or `m(Ps)` as input.**

A successful derivation would produce `m_e ≈ 0.511 MeV` (or equivalently `m(Ps) ≈ 1.022 MeV`) from purely combinatorial / topological QLF inputs — the 8-twist alphabet, the count-balance + Pauli-closure ZFA condition, the Hermitian-pair structure, and the half-spin atom of [`HALF-SPIN-ZFA-EMBEDDING.md`](HALF-SPIN-ZFA-EMBEDDING.md) — combined with a Planck-scale unit conversion that itself emerges from the ZFA event rate (not is supplied as a fitted parameter).

The bound-state framing makes the problem cleaner: the **target observable** is `m(Ps)`, not the free `m_e`. The free `m_e` is then `m(Ps) / 2` by the §2 symmetric-positronium derivation of [`Atomic_System_QLF_Closures.md`](Atomic_System_QLF_Closures.md).

---

## §2 Existing infrastructure

### 2.1 Mass-from-depth ansatz

[`Higgs.md`](Higgs.md) §2 states `m = α R` with `α` a unit-conversion factor (`α = 1` in QLF natural units) and `R` a gauge-fold-depth count. The constructing delay is `Δt = R / f_vacuum` per [`Frequency_Synchronization.md`](Frequency_Synchronization.md).

### 2.2 Hadronic depth scaling

[`HadronicDepth.md`](HadronicDepth.md) proposes `n_p ~ (m_P / m_p)^3` for the proton's gauge-fold depth, where `m_P` is the Planck mass. If the same exponent applies to the electron half-loop, `n_e ~ (m_P / m_e)^3` and the ratio is `n_e / n_p = (m_p / m_e)^3 ≈ 6.2 × 10⁹`. But this is **circular** as a derivation of `m_e`: it presupposes `m_e` as input.

### 2.3 Fine-structure constant

[`Hydrogen.md`](Hydrogen.md) §2 identifies the fine-structure constant `α_FS ≈ 1/137` with the ratio of gauge (electric) to spatial (magnetic) twist exchange rates over the stable-history ensemble. [`constants_mapper.py`](constants_mapper.py) `emerge_alpha()` is the implementation:

```python
def emerge_alpha(self) -> Optional[float]:
    """QLF local/spatial ratio over stable closures."""
    total_local = 0
    total_spatial = 0
    for hist in self._stable_histories():
        local = hist.count("+") + hist.count("-")
        spatial = len(hist) - local
        total_local += local
        total_spatial += spatial
    return total_local / total_spatial if total_spatial else None
```

### 2.4 Bohr formula in QLF language

[`Hydrogen.md`](Hydrogen.md) §4 derives `E_n = −(1/2) α² m_e c² / n²`. If `α_FS` is QLF-derived and `E_bind(H) = 13.6 eV` is taken as a measured input, then `m_e c² = 2 E_bind / α²`. This is a **partial** first-principles derivation: it uses one QLF-derived input (`α`) and one measured input (`E_bind`).

### 2.5 Atomic-system mappings

[`Atomic_System_QLF_Closures.md`](Atomic_System_QLF_Closures.md) §§2–4 maps positronium, hydrogen, and muonium to specific joint-closure topologies. These mappings provide the structural constraints `m(Ps) = 2 m_e`, `m(H) = m_e + m_p`, `m(Mu) = m_e + m_μ` — useful for self-consistency but not by themselves a first-principles derivation of `m_e`.

---

## §3 Numerical test of the existing `emerge_alpha()`

Running `ConstantsMapper.emerge_alpha()` against the default stable-history ensemble:

```
α_QLF (emerge_alpha)   = 0.200
α_measured (CODATA)    = 0.0073
1/α_QLF                = 5.0
1/α_measured           = 137.036
rel error              = +2641%
```

The `emerge_alpha()` computation returns the **gauge-to-spatial twist ratio of the small stable-history ensemble** (4 gauge twists `+`,`-` out of every 8 = 1:4 = 0.2). It does **not** return the fine-structure constant `α_FS ≈ 1/137`.

Plugged into the Bohr formula:

```
m_e c² = 2 E_bind(H) / α_QLF²
       = 2 × 13.598 eV / 0.04
       = 679.9 eV  (= 0.00068 MeV)
```

Measured `m_e c² ≈ 511 keV`. **Off by ~750×**. The chain "QLF closure-multiplicity → α → m_e via Bohr" does not work today.

The 0.2 vs. 1/137 discrepancy is large and structural: the small-ensemble gauge-spatial twist ratio is not the fine-structure constant. They are different quantities. A genuine derivation of `α_FS = 1/137` from QLF would require a different combinatorial argument — likely something about the asymmetric multiplicity of gauge-fold paths in larger ensembles, or the Mellin-image multiplicity-saturation argument analogous to [`ReverseMathematics.md`](ReverseMathematics.md) §4's MRE bridge.

---

## §4 Three pathways forward

### Path A — Fix `emerge_alpha()` to derive `α_FS = 1/137`

Identify the specific QLF closure-multiplicity argument that yields `1/137`. Candidate sources:

- The asymmetric gauge-fold-path multiplicity at larger depths (the small-ensemble ratio 0.2 may converge as `depth → ∞` — but to what limit?).
- A Mellin-transform of the gauge-fold generating function (analogous to [`ReverseMathematics.md`](ReverseMathematics.md) §4's MRE-bridge motivation for `spectral_hilbert_polya`).
- A multiplicity-weighted gauge-fold path-counting where the weights come from MRE saturation.

Then the Bohr-formula chain gives `m_e` from QLF-derived `α` and measured `E_bind(H)`. This is the **partial first-principles** path — it still uses one measured input.

**Tractability:** medium — likely solvable with a focused multi-session effort on the gauge-fold-path multiplicity at large depths.

### Path B — Derive `m_e` directly from electron half-loop multiplicity

Bypass the fine-structure constant entirely. Count the QLF closure-multiplicity at the electron-half-loop topology and convert directly to mass via the Planck-scale ZFA event rate:

$$m_e c^2 \;=\; (\text{electron half-loop closure-multiplicity}) \times \hbar \, f_{\text{vacuum}}$$

where `f_vacuum ≈ 1 / t_Planck ≈ 1.85 × 10⁴³ Hz` gives `ℏ f_vacuum ≈ E_Planck ≈ 1.22 × 10²⁸ eV`. Then `m_e c² = 511 keV` requires closure-multiplicity ≈ `4.2 × 10⁻²³`. This is a fractional number, not a count — the simplest reading is that we are counting something inversely (number of Planck events PER electron, rather than electron mass per Planck event).

**Tractability:** depends on identifying the right counting. The Planck-scale event-rate interpretation is structurally clean but operationally requires deciding what the "electron half-loop multiplicity" denominator is.

### Path C — Derive the ratio `m_e / m_p` from joint-closure topology

Bypass absolute mass entirely. Derive the **ratio** `m_e / m_p ≈ 1/1836` from QLF closure-multiplicity counts at the electron half-loop vs. the three-quark proton closure. Then use measured `m_p ≈ 938.27 MeV` (or the hydrogen mass `m(H) ≈ 938.78 MeV`) as the input scale.

The two ratios:

$$\frac{m_e}{m_p} \;=\; \frac{R_e}{R_p} \;\stackrel{?}{=}\; \frac{(\text{electron half-loop multiplicity})}{(\text{three-quark closure multiplicity})}$$

This is the **closest to tractable** of the three paths because:
- The electron half-loop is a single half-spin atom with one gauge fold (per [`Electron.md`](Electron.md) §1).
- The three-quark proton closure has a specific multi-loop structure (per [`HadronicDepth.md`](HadronicDepth.md)).
- Both can be enumerated combinatorially up to a chosen length.

The challenge: the combinatorial multiplicity ratio for the half-loop topologies may not directly give `1/1836`. As [`HadronicDepth.md`](HadronicDepth.md) notes, the ratio `m_p / m_e ≈ 1836` involves a non-trivial topological factor (the `(m_P / m_p)³` scaling argument). Path C would test whether this factor emerges from a clean closure-multiplicity argument at the specific electron and proton topologies.

**Tractability:** medium — testable in a single session with a careful enumeration script, but only if the right topology counts are identified.

---

## §5 Why this is a hard problem

The electron mass is **the** open problem of QED (and of any theory beyond the Standard Model). No first-principles derivation exists in conventional physics: the Higgs Yukawa coupling `y_e` is an input parameter with no further explanation. Any QLF derivation that succeeded would constitute a substantive answer to a 60-year open question.

QLF has the structural ingredients for an attempt:

- The 8-twist alphabet provides a finite generative set.
- ZFA closure provides the selection principle.
- The half-spin ZFA atom and the gauge-fold-depth ansatz provide the mass-generation mechanism.
- The Planck-scale ZFA event rate provides a natural unit conversion.

What QLF currently lacks for a complete derivation:

- A first-principles derivation of `α_FS = 1/137` (the `emerge_alpha()` empirical test of §3 shows the current implementation gives 0.2, not 1/137 — substantive gap, not a bug).
- A direct counting interpretation of the electron half-loop gauge-fold depth `R_e` in terms of Planck-event multiplicity.
- A combinatorial argument for the `(m_P / m_X)³` HadronicDepth scaling exponent that doesn't presuppose the mass it derives.

---

## §6 What this is NOT

- **Not a derivation.** The doc explicitly delivers no first-principles derivation of `m_e`. It scopes the problem and reports the existing-infrastructure gap.
- **Not a critique of the existing infrastructure.** `emerge_alpha()`, `HadronicDepth.md`, `Higgs.md` §2, and `Hydrogen.md` §4 are all useful structural derivations of their stated claims. They just do not, in combination, yet produce a first-principles `m_e`.
- **Not a retreat from the bound-state framing.** Per [`Bound_States_QLF.md`](Bound_States_QLF.md), `m_e` is the electron's gauge-fold-depth contribution to a joint closure; the derivation target is the bound-state quantity `m(Ps) = 2 m_e`, not the free `m_e`. The derivation question is the same under either framing; the bound-state framing makes the *interpretation* of `m_e` cleaner.

---

## §7 Open work

- **Path A** — extend [`constants_mapper.emerge_alpha`](constants_mapper.py) with a multiplicity-weighted gauge-fold-path counting that converges to `1/137` at large depth. Reverse-math-style argument modelled on [`ReverseMathematics.md`](ReverseMathematics.md) §4.
- **Path B** — develop a clean Planck-scale event-rate interpretation of the electron half-loop closure-multiplicity. Identify the "denominator" that makes the multiplicity dimensionless and connects to the Planck event rate.
- **Path C** — write a focused enumeration script that counts the multiplicity of the electron half-loop topology and the three-quark proton closure at matched length, and test whether the ratio approaches `1/1836`. This is the most concretely testable of the three paths.
- **Lean theorem** — once a derivation pathway is established, formalise it as `electron_mass_from_zfa_multiplicity` in Lean 4. Connects to existing `pauli_closed_of_admissible_zfa` and `zfa_closure_minimizes_free_energy`.

---

## References

### Internal

- [`Bound_States_QLF.md`](Bound_States_QLF.md) — the bound-state framing of the mass-spectrum problem.
- [`Atomic_System_QLF_Closures.md`](Atomic_System_QLF_Closures.md) — atomic-system joint-closure topologies; `m(Ps) = 2 m_e`, etc.
- [`Electron.md`](Electron.md) v2.0 — electron half-loop topology `^<v>^+`.
- [`Higgs.md`](Higgs.md) §2 — `m = α R` ansatz; gauge-fold depth as mass-generation mechanism.
- [`Hydrogen.md`](Hydrogen.md) — fine-structure-constant identification; Bohr derivation `E_n = −(1/2) α² m_e c² / n²`.
- [`HadronicDepth.md`](HadronicDepth.md) — `n ~ (m_P / m_p)³` scaling for the proton.
- [`HALF-SPIN-ZFA-EMBEDDING.md`](HALF-SPIN-ZFA-EMBEDDING.md) — half-spin ZFA atom as the minimal Hermitian pair.
- [`MRE.md`](MRE.md) — per-event log 2 quantum; multiplicity-saturation argument.
- [`ReverseMathematics.md`](ReverseMathematics.md) §4 — Mellin-bridge motivation; possible template for Path A.
- [`Frequency_Synchronization.md`](Frequency_Synchronization.md) — `Δt = R/f_vacuum`.
- [`Standard_Model.md`](Standard_Model.md) §6 — "Mass ratios from multiplicity" open work.
- [`Active_Inference_Mathematics.md`](Active_Inference_Mathematics.md) §5 — meta-scoreboard "Quantitative mass spectrum" row.
- [`constants_mapper.py`](constants_mapper.py) — the existing `emerge_alpha()`, `emerge_pi()`, etc. implementations.

### External

- Particle Data Group — measured electron mass `m_e c² = 510.99895 keV ± 1.5 × 10⁻⁸`.
