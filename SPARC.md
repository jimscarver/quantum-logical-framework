# Blind SPARC rotation-curve benchmark — [QLF](README.md) vs Newton / MOND

A **blind, parameter-free** test of QLF's dark-matter sector (the radial-acceleration law of
[`DarkMatter.md`](DarkMatter.md) §7.5) against the real SPARC rotation-curve database
(Lelli, McGaugh & Schombert 2016, 175 disk galaxies). Issue [#77](https://github.com/jimscarver/quantum-logical-framework/issues/77);
pipeline in [`sparc/sparc_blind_pipeline.py`](sparc/sparc_blind_pipeline.py).

## The protocol (blind)

The predictor reads **baryonic inputs only** — `Vgas`, `Vdisk`, `Vbul`, radius `R` — and never the
observed velocity `Vobs`. Predictions `V_pred(r)` are written and **SHA-256 sealed** *before* `Vobs` is
revealed and scored. No per-galaxy tuning of any kind (per-galaxy tuning is disqualifying, #77).

## The QLF model — zero parameters fit to the rotation curves

- **Acceleration scale** `a₀ = c H₀ / 2π` — **derived** (the de Sitter horizon / loop phase,
  [`QLF_DarkMatter`](lean/QLF_DarkMatter.lean) `mond_acceleration`); `H₀` is declared, not fitted.
- **Mass-to-light** `Υ_disk = 0.5`, `Υ_bul = 0.7` — the canonical global 3.6 µm stellar-population
  values (the same ones MOND/RAR use); **not** fit to the curves.
- **Radial-acceleration relation** (the closure-balance, Lean `radialAccel_self_consistent`):
  `g_obs = ½(g_bar + √(g_bar² + 4 g_bar a₀))`, the positive root of `g² = g_bar·(g + a₀)`.

So the prediction has **no free parameter fit to the rotation curves** — `a₀` is derived, `Υ` is from
stellar populations.

## Result (164 galaxies, 2803 points after quality cuts `e_Vobs < 0.1·Vobs`)

Residual = `log₁₀ g_obs − log₁₀ g_pred` (dex). `scatter` is RMS about the model's own mean; `mean` is the
systematic offset.

| model | mean (dex) | scatter (dex) |
|---|---|---|
| **Newton** (`g_bar`, no dark matter) | **+0.432** | 0.285 |
| QLF form, `a₀` **fitted** to SPARC (`g† = 1.2×10⁻¹⁰`) | −0.014 | 0.144 |
| **QLF, `a₀ = cH₀/2π` DERIVED** (`H₀ = 73`) | **−0.004** | **0.144** |

- **Newton fails**: a `+0.432 dex` offset is a factor **2.7×** of "missing gravity" — the dark-matter
  signal itself.
- **QLF, parameter-free, is statistically identical to the best fit**: derived-`a₀` gives the *same*
  `0.144 dex` scatter as fitting `a₀`, with a negligible `−0.004 dex` offset. The scatter is near the
  observational floor (McGaugh+2016 report ~0.13 dex total, ~0.11 intrinsic; our slightly higher value
  is the cruder quality cut — no inclination/quality flags vs the curated common122).
- **Insensitive to `H₀`**: scatter stays `0.144 dex` for `H₀ = 67–73`; the mean offset runs `+0.007 →
  −0.004 dex` (per-galaxy: `0.163 dex` scatter). QLF's derived `a₀` lands right on the data across the
  whole `H₀` range — the local `H₀ = 73` is essentially exact.

**So QLF predicts the SPARC rotation curves blind, parameter-free, as well as best-fit MOND and far
better than Newton** — the galactic Radial Acceleration Relation reproduced with `a₀` *derived*, not fit.

## Honest scope

- The interpolation *form* is substrate-**motivated** (the closure-balance conjunction; `DarkMatter.md`
  §7.5) and the two limits are forced (Newton; geometric-mean/Tully–Fisher), but the exact `ν`-function
  is not yet proven the *unique* one — other interpolations fit at this level. The scatter cannot
  distinguish them; the *parameter-free a₀* is the real win.
- Quality cuts are cruder than the curated SPARC common122 (slightly inflates the scatter); an explicit
  NFW per-galaxy comparison and a PFEM-style verification receipt are the remaining refinements (#77).
- The `~13 %` `a₀` residual (the `1/2π` prefactor, the open `dark_matter_acceleration_scale_in_progress`)
  is absorbed at the local `H₀`; it is the one principled, named uncertainty.

## Reproduce

```bash
cd sparc
# data (public; Lelli, McGaugh & Schombert 2016), GitHub mirror:
curl -sSL https://raw.githubusercontent.com/jobovy/sparc-rotation-curves/main/data/MassModels_Lelli2016c.mrt -o MassModels_Lelli2016c.mrt
python3 sparc_blind_pipeline.py
```

## References

- F. Lelli, S. McGaugh & J. Schombert, *SPARC: Mass Models for 175 Disk Galaxies*, AJ **152** (2016) 157.
- S. McGaugh, F. Lelli & J. Schombert, *Radial Acceleration Relation*, PRL **117** (2016) 201101.
- [`DarkMatter.md`](DarkMatter.md) §7.5 (the closure-balance RAR), [`lean/QLF_DarkMatter.lean`](lean/QLF_DarkMatter.lean).
