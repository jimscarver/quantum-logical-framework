# genesis.py — the ZFA landscape spectrum explorer

`genesis.py` is an exploratory instrument for the [Quantum Logical Framework](README.md): it starts from
the *first distinction* (one signed generator pair `+g/−g`), builds the exact closure census, treats
cycle-order as a **frequency-octave hierarchy**, and measures the fractal structure of closures at each
frequency. It computes **real combinatorics** and reports **measured** exponents — it does not prove
physics. Every printed result carries an epistemic tag (`[EXACT]`, `[MEASURED]`, `[STRUCTURAL]`,
`[OPEN]`), and the sectors that show no signal say so.

Pure standard library, no network. Run: `python3 genesis.py`.

## What to read it for

- **The one genuine derivation — the spectral exponent (§2).** The census fractal exponent is `−p/2`,
  *exactly*, and this is not a fit: `C(2m,m)·c_pair(p,m)` is the closed-walk count on `ℤ^p`, so the slope
  is the `p`-dimensional return-probability exponent. Three spatial pairs → `−3/2`; the 8-twist / 4-pair
  → `−2`. This is the strongest thing in the file and it is derived. See [`Alpha.md`](Alpha.md).
- **census → π (§1, §5).** `C(2n,n)/4ⁿ → 1/√(πn)`, so `π ≈ 1/(n·ratio²)` with error falling as `~1/n`
  (`7.85×10⁻⁶` at `n=10⁵`). The census carries π. See [`Physical_Pi.md`](Physical_Pi.md).
- **The honest negatives — as valuable as the hits.** The swap-graph ball-growth `D` (§4) does **not**
  converge to 3: the finite-size ladder (§4b) shows it climbs *past* 3 and keeps rising (`D ~ k·log2/log k
  → ∞`), so "≈3 at moderate size" is a **crossing, not a limit** — the naive raw-graph is the *wrong*
  #62 instrument (the stable one is the receipt-quotient `~2.94`, [`Pointer_Swap_Fuzz.md`](Pointer_Swap_Fuzz.md)).
  No log-periodic discrete-scale-invariance signal is found in the binary sector. The α residual `0.036`
  is *not* here — census-derivation of it stays open ([`Alpha_Residual.md`](Alpha_Residual.md)).
- **The `128 + d²` census joint (§5).** `d=3 → 137`, the only prime in the small family — the α
  cross-sector reading, tagged `[STRUCTURAL]` for the identification, `[OPEN]` for the residual.

## Full sample run

```
genesis.py  —  ZFA landscape spectrum explorer

======================================================================
1. THE FIRST DISTINCTION  (binary closure census)
======================================================================
  n    generated 4^n   realized C(2n,n)        ratio
  1                4                  2     0.500000
  2               16                  6     0.375000
  3               64                 20     0.312500
  4              256                 70     0.273438
  6             4096                924     0.225586
  8            65536              12870     0.196381
 12         16777216            2704156     0.161180
 16       4294967296          601080390     0.139950

[EXACT] ratio = C(2n,n)/4^n -> 1/sqrt(pi n).  The first distinction's
        closure fraction already carries pi; this is the alpha anchor.

======================================================================
2. MULTI-PAIR CENSUS  (spectral exponent counts conjugate pairs)
======================================================================
 p (pairs)   fitted slope    expected -p/2
         1        -0.4919          -0.5000
         2        -0.9839          -1.0000
         3        -1.4762          -1.5000
         4        -1.9694          -2.0000

[EXACT] slope -> -p/2: the census fractal exponent IS the pair count.
[STRUCTURAL] 3 spatial pairs -> slope -3/2 ; the 8-twist/4-pair -> -2.

======================================================================
3. FREQUENCY-OCTAVE HIERARCHY  (closure spectrum, p=1)
======================================================================
 octave j   n=2^j   closure-bits        ratio
        0       1         1.0000    5.000e-01
        1       2         2.5850    3.750e-01
        2       4         6.1293    2.734e-01
        3       8        13.6517    1.964e-01
        4      16        29.1630    1.399e-01
        5      32        60.6686    9.935e-02
        6      64       124.1714    7.039e-02

bits increment per octave : [1.585, 3.544, 7.522, 15.511, 31.506, 63.503]
successive increment ratio: [2.2362, 2.1224, 2.062, 2.0311, 2.0156]
[MEASURED] increment ratio -> 2 (each octave doubles n, ~doubles the
        extensive 2n term): self-similar cascade across frequency.

log-periodic residual: peak power=6.712e-03, rms=1.683e-02
[MEASURED] no significant discrete-scale-invariance signal in the binary
        sector.  If DSI exists it lives in multi-pair / swap sectors.

======================================================================
4. SWAP-GRAPH GROWTH  (#62 dimension probe: measured, not assumed)
======================================================================
        multiset    #nodes   diam  growth exponent D
          (6, 6)       924     36              2.230
          (8, 8)     12870     64              2.774
        (10, 10) (too big)
       (3, 3, 3)      1680     27              2.326
       (4, 4, 4)     34650     48              2.930
    (2, 2, 2, 2)      2520     24              2.386
    (3, 3, 3, 3) (too big)
          (6, 2)        28     12              1.248
       (4, 2, 2)       420     20              1.926

[MEASURED] growth exponent D of the pointer-swap configuration space.
[OPEN] whether the substrate-forced 6+2 -> 3-axis structure yields D~3
        is issue #62; this is the apparatus, deliberately not rigged.

======================================================================
4b. SWAP-GRAPH EXTRAPOLATION  (does D converge? finite-size ladder)
======================================================================
k (=(k,k))    #nodes   diam     D(k)
         4        70     16   1.6094
         5       252     25   1.8808
         6       924     36   2.2302
         7      3432     49   2.5124
         8     12870     64   2.7744
         9     48620     81   3.0146  > 3
        10    184756    100   3.2184  > 3

D increments D(k+1)-D(k): [0.271, 0.349, 0.282, 0.262, 0.24, 0.204]
linear slope of D vs k  : 0.2728  (steady & positive)
[MEASURED] D does NOT converge -- it climbs past 3 and keeps rising
        (~ k*log2/log k -> infinity).  The '~3 at moderate size' seen
        in section 4 is a CROSSING, not a limit.
[STRUCTURAL] so the naive binary ball-growth is not a fixed-D spatial
        probe; the #62 mechanism evidence is the NORMALIZED doubling /
        receipt-quotient exponent (~2.94, pointer_swap_fuzz.py), a
        different instrument.  Honest negative result for this one.

======================================================================
5. CONSTANTS SECTOR  (census meets physics; tagged)
======================================================================
census -> pi   (pi ~ 1/(n*ratio^2)):
    n=     10   pi ~ 3.221089   (err 7.95e-02)
    n=    100   pi ~ 3.149456   (err 7.86e-03)
    n=   1000   pi ~ 3.142378   (err 7.85e-04)
    n=  10000   pi ~ 3.141671   (err 7.85e-05)
    n= 100000   pi ~ 3.141601   (err 7.85e-06)
[EXACT] converges to pi in the limit (Wallis / Stirling).

alpha^-1 = 128 + d^2:
    d=1  ->   129   composite
    d=2  ->   132   composite
    d=3  ->   137   prime  <- 137, prime, elementary
    d=4  ->   144   composite
    d=5  ->   153   composite
[STRUCTURAL] d=3 substrate-derived (6+2 split); 128=2^7 selectivity.
[EXACT] the joint holds at exactly d=3 (cross-sector; see rigidity module).
[OPEN] the 0.036 residual (QED running) is NOT here; census-derivation open.

======================================================================
WHAT THIS COMPUTES vs CLAIMS  (misses at full weight)
======================================================================
  COMPUTES [EXACT]  : the closure census, the -p/2 spectral exponent,
                      census->pi convergence, the 128+d^2 joint at d=3.
  MEASURES          : octave self-similarity; swap-graph growth D.
  DOES NOT SHOW     : that D=3 -- the naive ball-growth DIVERGES (4b),
                      refuting the crossing seen at moderate size; #62 open;
                      any log-periodic DSI in the binary sector (none found);
                      the alpha residual (QED running from census: OPEN);
                      that these closures ARE physics (STRUCTURAL reading).
  NOT A PROOF       : an exploratory instrument.  The Lean layer, not this,
                      is where verified claims live.
```

## Extending it (from the script's own notes)

- The swap-graph cap is 60k nodes; raise it to resolve the finite-size drift further (the single most
  informative extension). `swap_dimension_ladder` (§4b) is the harness that fits `D(k)` up the ladder —
  the extrapolation, not any single finite `D`, is what bears on #62.
- The multi-pair census memoizes `c_pair`, so very large `p×m` grows memory; everything else is O(seconds).

## See also

- [`Pointer_Swap_Fuzz.md`](Pointer_Swap_Fuzz.md) — the #62 swap-graph mechanism and the receipt-quotient (stable `d`).
- [`Alpha.md`](Alpha.md) — the census sector: the `−p/2` spectral exponent and the `128 + d²` joint.
- [`Physical_Pi.md`](Physical_Pi.md) — census → π (Wallis / Stirling).
- [`Open_Problems.md`](Open_Problems.md) — #62 status (the raw-graph divergence finding).
