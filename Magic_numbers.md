# Magic Numbers from Zero Free Action

## Core Principle
The universe is pure quantum logic. There are no fundamental forces or fields — only **Zero Free Action**. Every valid sequence of half-spin orthogonal folds must be perfectly reversible in non-commutative logic, returning exactly to the original state.

## Fundamental Concepts

- Only **half-spin closures** satisfy Zero Free Action
- Full integer spin folds cannot close without residual action
- Closures emerge from orthogonal folds matching Pauli matrix operations
- The history of any valid sequence must map back to the original state when reversed in time

## Dimensional Growth of Closures

- **2 Dimensions**: 2 possible half-spin closures
- **3 Dimensions**: +6 closures → total 8
- **4 Dimensions**: +12 closures → total 20

## Two-Particle Interaction Model
The nucleus is modeled as a six-dimensional system. Open half-spin structures (proton inside, electron outside) couple together. This external coupling creates additional stable closures that would not exist in isolation. The 8-twist alphabet's split into **6 spatial twists** (3 spatial dimensions) and **2 gauge twists** carries this 6D / 3D distinction into the closure spectrum.

## Resonant Frequencies
- At each resonant frequency, exactly **two** new half-spin closures become available
- Resonant frequency is determined by the number of ways the orthogonal folds can combine — j-coupling between orbital structure (spatial twists) and intrinsic spin (gauge twists) gives `j = ℓ ± 1/2` for each (n_HO, ℓ) at major harmonic-oscillator shell N_HO
- These resonances emerge naturally from the possibilist quantum logical framework
- Each j-shell contributes `2j+1` closures, equivalently `(j + 1/2)` resonances × 2 closures per resonance (the m_j = ± |m_j| spin pair)

## The Vacuum is the Intruder

At each frequency, the vacuum's structured resonance spectrum (see [`VacuumEnergy.md`](VacuumEnergy.md) §6.1) couples in by **selecting one closure**: the `j = ℓ_max + 1/2` orbital at the highest ℓ available at that frequency. The vacuum is therefore the intruder — there is no separate "orbit stepping down from a higher frequency." The vacuum's coupling at each level supplies the high-j orbit that nuclear physics reads as the spin-orbit intruder.

**Threshold at ℓ_max ≥ 3.** The 8-twist alphabet has 6 spatial twists (3 native spatial dimensions) and 2 gauge twists. Two regimes:

- **ℓ_max ≤ 2** (s, p, d shells). The orbital fits within 3D. The vacuum's 6D coupling superposes invisibly with the native 3D-orbital structure, and all of N_HO = k fills together. Cumulative closures match the 3D harmonic-oscillator sequence `2, 8, 20`.

- **ℓ_max ≥ 3** (f, g, h, i shells). The orbital's angular extent exceeds the 3D subspace of the alphabet's spatial twists. The vacuum's 6D coupling becomes distinguishable from the native 3D structure, and the vacuum-selected `j = ℓ_max + 1/2` orbital separates from the rest of N_HO = k as a distinct closure at frequency k. The rest of N_HO = k waits for the next frequency.

Combined with the dimensional growth of §"Dimensional Growth of Closures", this rule reproduces the empirical magic numbers exactly:

| k | orbits at frequency k (vacuum-selected marked ✦) | n_res | +closures | cumulative |
|---:|---|---:|---:|---:|
| 0 | 1s₁/₂ | 1 | +2 | 2 |
| 1 | 1p₃/₂, 1p₁/₂ | 3 | +6 | 8 |
| 2 | 1d₅/₂, 1d₃/₂, 2s₁/₂ | 6 | +12 | 20 |
| 3 | ✦1f₇/₂ | 4 | +8 | 28 |
| 4 | 1f₅/₂, 2p₃/₂, 2p₁/₂, ✦1g₉/₂ | 11 | +22 | 50 |
| 5 | 1g₇/₂, 2d₅/₂, 2d₃/₂, 3s₁/₂, ✦1h₁₁/₂ | 16 | +32 | 82 |
| 6 | 1h₉/₂, 2f₇/₂, 2f₅/₂, 3p₃/₂, 3p₁/₂, ✦1i₁₃/₂ | 22 | +44 | 126 |

The per-frequency resonance counts `1, 3, 6, 4, 11, 16, 22` are produced by direct enumeration of `(n_HO, ℓ, j)` orbits plus the vacuum-selection rule — no empirical input beyond the j-coupling structure of the 8-twist alphabet's 6+2 split.

Concrete numerical demo: [`magic_numbers_demo.py`](magic_numbers_demo.py) (numpy-only, ASCII output).

### Why the threshold is exactly ℓ_max = 3

At major harmonic shell N_HO = k, the 3D harmonic-oscillator degeneracy is `(k+1)(k+2)` — the standard formula for a particle in 3 spatial dimensions, which is exactly the 3 dimensions encoded by the 8-twist alphabet's 6 spatial twists. The vacuum-selected `j = ℓ_max + 1/2 = k + 1/2` multiplet contributes `2(k+1)` states. The "rest of N_HO = k" therefore has `(k+1)(k+2) − 2(k+1) = k(k+1)` states.

The vacuum-selected and rest are **equal** at k = 2 (each is 6 states). For k ≥ 3, the rest exceeds the vacuum-selected:

| k | vacuum-selected `2(k+1)` | rest `k(k+1)` | rest > vacuum? |
|---:|---:|---:|:---:|
| 0 |  2 |  0 | (only vacuum) |
| 1 |  4 |  2 | no |
| 2 |  6 |  6 | equal (boundary) |
| 3 |  8 | 12 | **yes** |
| 4 | 10 | 20 | yes |
| 5 | 12 | 30 | yes |
| 6 | 14 | 42 | yes |

Below the boundary the vacuum's selection is at least as large as the rest and superposes invisibly with it; the whole N_HO = k fills together at frequency k (no intruder visible). Above the boundary the rest forms a coherent majority closure unit, filling at the *next* frequency, while the vacuum-selected separates as the intruder at the *current* frequency.

Algebraically: the inequality `rest > vacuum-selected` reduces to

$$k(k+1) > 2(k+1) \;\Longleftrightarrow\; k > 2.$$

The integer threshold is therefore `k ≥ 3`. The "3" in this threshold comes directly from the 3 in `(k+1)(k+2)` — the `d = 3` in the d-dimensional harmonic-oscillator degeneracy `C(k+d−1, d−1) · 2` — which is exactly the 3 spatial dimensions encoded by the 8-twist alphabet's 6 spatial twists.

**Counterfactual.** If the alphabet's spatial part had a different dimensional structure, the threshold would shift:

- For d = 2: vacuum-selected fraction = `(d−1)! / ((k+2)(k+3)…(k+d−1))` = `1/1 = 1`, so the vacuum is always dominant — no intruder threshold.
- For d = 3: ratio `2/(k+2)`, crosses 1/2 at k = 2; threshold `k ≥ 3`.
- For d = 4: ratio `6/((k+2)(k+3))`, crosses 1/2 at k = 1; threshold `k ≥ 2`.
- For d = 5: ratio `24/((k+2)(k+3)(k+4))`, crosses 1/2 at k = 0; threshold `k ≥ 1`.

The empirical threshold at ℓ = 3 in nuclear physics is therefore a **structural prediction** of the 8-twist alphabet's specific 6+2 split. Observing magic-number deviations from the 3D-SHO sequence beginning exactly at ℓ = 3 is consistent with — and a non-trivial empirical constraint on — the dimensionality of the alphabet's spatial twists.

## Current Status

- ✓ The full sequence `2, 8, 20, 28, 50, 82, 126` is reproduced by `magic_numbers_demo.py` from j-coupling enumeration plus the vacuum-selection rule. The dimensional-growth phase (k ≤ 2) gives 2, 8, 20 directly; the vacuum-as-intruder phase (k ≥ 3) gives 28, 50, 82, 126.
- ✓ The threshold at ℓ_max ≥ 3 is **derived**: the inequality `rest > vacuum-selected` reduces to `k > 2`, and the integer threshold `k = 3` falls out of the 3 in `(k+1)(k+2)` — the d = 3 of the alphabet's 6 spatial twists / 3 spatial dimensions. Counterfactual shifts (d = 4 → threshold at ℓ = 2; d = 2 → no threshold) make this a structural prediction.
- The same `ℓ ≤ 2 / ℓ ≥ 3` boundary has a geometric reading in [`Atomic_Structure_QLF.md`](Atomic_Structure_QLF.md): the `s, p, d` shells (orbital dimensions `1, 3, 5`) are exactly the unsplit irreducible representations of the substrate's icosahedral closure group `A₅`, and `f` (dimension 7) is the **first** orbital with no icosahedral irrep — so the dimensional-growth → vacuum-intruder transition is also where the substrate's icosahedral irreps run out (anchored in [`lean/QLF_AtomicStructure.lean`](lean/QLF_AtomicStructure.lean)).
- ⚠ The vacuum's selection rule (vacuum picks `j = ℓ_max + 1/2` at each frequency) remains the framework's structural commitment. Intuitively the vacuum couples to the spin-aligned configuration (orbital and spin angular momenta parallel), which is the most-extended-in-angle and most-degenerate j-multiplet at each ℓ. A rigorous derivation of this choice from the 8-twist alphabet's gauge-twist ↔ spatial-twist coupling structure remains open.
- ✗ Open: derive why the vacuum specifically selects `j = ℓ_max + 1/2` (rather than `j = ℓ_max − 1/2` or another j-shell) from the alphabet's gauge ↔ spatial coupling.

## Goal
Develop a pure logical derivation where all magic numbers emerge strictly from Zero Free Action and half-spin orthogonal fold closures, without reference to traditional nuclear forces. The dimensional-growth (2, 8, 20), vacuum-as-intruder (28, 50, 82, 126), and ℓ = 3 threshold are derived from the 8-twist alphabet's 6+2 split. The remaining concrete target is to derive the vacuum's `j = ℓ_max + 1/2` selection rule from the gauge-twist ↔ spatial-twist coupling structure of the alphabet.
