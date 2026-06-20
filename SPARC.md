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

## Result — curated sample (147 galaxies, 2696 points; `Q ≤ 2`, `Inc ≥ 30°`, `e_Vobs < 0.1·Vobs`)

Residual = `log₁₀ g_obs − log₁₀ g_pred` (dex). `scatter` is RMS about the model's own mean; `mean` is the
systematic offset. Machine-readable [`sparc/receipt.json`](sparc/receipt.json).

| model | free params | mean (dex) | scatter (dex) |
|---|---|---|---|
| **Newton** (`g_bar`, no dark matter) | 0 | **+0.431** | 0.281 |
| **NFW** halo, fit **per galaxy** | **294** | −0.005 | 0.059 |
| QLF form, `a₀` **fitted** to SPARC | 1 | −0.009 | 0.133 |
| **QLF, `a₀ = cH₀/2π` DERIVED** (`H₀ = 73`) | **0** | **−0.000** | **0.133** |

- **Newton fails**: a `+0.431 dex` offset is a factor **2.7×** of "missing gravity" — the dark-matter
  signal itself.
- **QLF, parameter-free, hits the observational floor**: `0.133 dex` scatter (= McGaugh+2016's measured
  RAR scatter ~0.13 dex), with a **zero** mean offset, and *identical* to the same form with `a₀` fitted —
  the derived `a₀ = cH₀/2π` is essentially exact. Insensitive to `H₀` (0.13–0.14 dex for `H₀ = 67–73`).
- **vs NFW — the parameter economy.** NFW fits *tighter* (`0.059 dex`), but only by giving **2 free halo
  parameters to every galaxy** (294 total): it absorbs the per-galaxy scatter. The RAR's *observed*
  tightness (`0.13 dex`, mostly observational error) shows there is **no room** for that halo-to-halo
  diversity — so NFW's lower scatter is over-fitting noise, not better prediction. **QLF matches the data
  with `0` free parameters; NFW needs `294`.**

**So QLF predicts the SPARC rotation curves blind, parameter-free, at the observational floor — as well as
best-fit MOND, far better than Newton, and with `294×` fewer parameters than NFW for the same data** — the
galactic Radial Acceleration Relation reproduced with `a₀` *derived*, not fit.

## Honest scope

- The interpolation *form* is substrate-**motivated** (the closure-balance conjunction; `DarkMatter.md`
  §7.5) and the two limits are forced (Newton; geometric-mean/Tully–Fisher), but the exact `ν`-function
  is not yet proven the *unique* one — other interpolations fit at this level. The scatter cannot
  distinguish them; the *parameter-free a₀* is the real win.
- The `1/2π` prefactor is **confirmed**: fit `a₀` in QLF's *own* closure-balance form (not McGaugh's
  exponential, which gives `g† = 1.20×10⁻¹⁰`) and the data prefers `a₀ = 1.127×10⁻¹⁰` = `cH₀/2π` at
  **`H₀ = 72.9`** — the local Hubble constant. So the old "~13%" was a wrong-form comparison; the prefactor
  is right to `< 1%` at the local `H₀`, and the only residual is the **Hubble tension** itself (the galaxy
  data picks the local `H₀ = 73`, not the CMB `67`). (`DarkMatter.md` §5.)
- Curation, NFW, and the receipt are now done: the **standard SPARC RAR cuts** (`Q ≤ 2`, `Inc ≥ 30°`) from
  Table 1, an explicit per-galaxy **NFW** fit, and a SHA-256 **verification receipt** (`sparc/receipt.json`).

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
