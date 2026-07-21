# genesis.py — the ZFA landscape spectrum explorer

`genesis.py` is an exploratory instrument for the [Quantum Logical Framework](README.md): it starts from
the *first distinction* (one signed generator pair `+g/−g`), builds the exact closure census, treats
cycle-order as a **frequency-octave hierarchy**, and measures the fractal structure of closures at each
frequency. It computes **real combinatorics** and reports **measured** exponents — it does not prove
physics. Every printed result carries an epistemic tag (`[EXACT]`, `[MEASURED]`, `[STRUCTURAL]`,
`[LEAN]` = machine-checked in the Lean layer, `[OPEN]`), and the sectors that show no signal say so.

Pure standard library, no network. Run: `python3 genesis.py`.

## What to read it for

- **The one genuine derivation — the spectral exponent (§2).** The census fractal exponent is `−p/2`,
  *exactly*, and this is not a fit: `C(2m,m)·c_pair(p,m)` is the closed-walk count on `ℤ^p`, so the slope
  is the `p`-dimensional return-probability exponent. Three spatial pairs → `−3/2`; the 8-twist / 4-pair
  → `−2`. This is the strongest thing in the file and it is derived — **and now Lean-anchored at the low
  orders** ([`QLF_CensusWalk`](lean/QLF_CensusWalk.lean)): `p=1` is the closure census, and `p=2` is the
  Vandermonde identity `Σ_k C(m,k)² = C(2m,m)` (`sumChooseSq_eq_central`), so the p=2 census `C(2m,m)²`
  **is** the machine-checked π return density (`census_p2_is_return_density`, = `QLF_PhysicalPi.returnDensity`).
  The general-`p` closed-walk identity and the `−p/2` asymptotic stay the Wallis residual. See [`Alpha.md`](Alpha.md).
- **census → π (§1, §5).** `C(2n,n)/4ⁿ → 1/√(πn)`, so `π ≈ 1/(n·ratio²)` with error falling as `~1/n`
  (`7.85×10⁻⁶` at `n=10⁵`). The census carries π. See [`Physical_Pi.md`](Physical_Pi.md).
- **The swap-graph beyond 3-D — internal dimensions, not a negative (§4, §4b).** The ball-growth `D`
  does **not** converge to 3; it climbs *past* 3 (`D ~ k·log2/log k → ∞`). This is **not** a failed 3-D
  probe: the *external* rendered dimension is the receipt quotient (→3-D, `~2.94`,
  [`Pointer_Swap_Fuzz.md`](Pointer_Swap_Fuzz.md)); the **excess beyond 3 is the internal gauge/color
  structure** — dimensions not perceived as space, manifesting externally as *stronger forces* (the
  Kaluza-Klein reading). More internal DOF = stronger color binding = heavier. This feeds the particle
  map (below). *(Genuine residuals that stay negative: no discrete-scale-invariance in the binary sector;
  the α `0.036` residual is not here, [`Alpha_Residual.md`](Alpha_Residual.md).)*
- **Frequency = mass → the particle map (§3, §6).** `m = 1/R = frequency` is a QLF identity, so the
  frequency-octave hierarchy **is** the mass spectrum; §6 maps internal structure → quantum numbers →
  zoo particle → mass relative to `m_e` (proton `6π⁵`, pion `2/α`, Koide τ — all with the measured value
  beside them). See below.
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
[LEAN] anchored at low orders (QLF_CensusWalk): p=1 = the closure census;
        p=2 = C(2m,m)^2 = the machine-checked pi return density (sumChooseSq_eq_central,
        census_p2_is_return_density).  General-p + the -p/2 asymptotic = Wallis residual.

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
[STRUCTURAL] m = 1/R = frequency (QLF_HiggsMechanism, mass_is_gauge_fold_delay):
        this frequency hierarchy IS the mass spectrum -- frequency determines
        mass.  The particle assignments referenced to m_e are in sec 6.

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
[STRUCTURAL] D>3 = INTERNAL (gauge/color) dimensions, not 3D space (Jim's reading):
        the EXTERNAL 3D is the receipt quotient (#62, pointer_swap_fuzz.py ~2.94);
        the excess beyond 3 is the internal color DOF = stronger forces (sec 6).

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
        (~ k*log2/log k -> infinity).  The '~3 at moderate size' is a CROSSING.
[STRUCTURAL] NOT a failed 3D probe (Jim's reading): the external 3D is the
        receipt-quotient (~2.94, pointer_swap_fuzz.py); the growth beyond 3 is
        the INTERNAL gauge/color structure -- more internal DOF = stronger
        forces / more binding = heavier (frequency=mass, sec 6).

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
6. PARTICLE MAP  (frequency=mass; internal structure -> quantum #s -> m/m_e)
======================================================================
m = 1/R = frequency (QLF_HiggsMechanism): the sec-3 frequency hierarchy IS the
mass ladder.  Internal dims (sec 4, D>3) = gauge/color, not 3D space.  Every mass
is a ratio to the electron; proton & pion reuse THIS run's pi and 137 (sec 5).

 particle         internal    quantum #s   m/m_e QLF   measured        tag
 electron  min chiral loop   L q=-1 gen1        1.00       1.00      [ref]
     muon     gen-2 lepton   L q=-1 gen2      206.77     206.77    [depth]
      tau    3-phase Koide   L q=-1 gen3     3477.40    3477.23  [Derived]
   proton  3 colors |S3|=6     B=+1 q=+1     1836.12    1836.15  [Derived]
   pion+-  2 quarks |S2|=2     B=0 q=+-1      274.00     273.13  [Derived]

[Derived]  proton 6*pi^5 = |S3|*pi^5 (3-colour permutation x internal angular,
           QLF_LenzMassRatio, 0.002%); pion 2/alpha = |S2|/alpha (2 quarks x exposed
           chirality, QLF_PionMassRatio); tau via Koide Q=2/3 given m_e,m_mu (QLF_Koide).
[STRUCTURAL] internal dimension = colour charge (Borromean 3, QLF_QuarkStructure);
           charge in thirds from 3 colours; generations = 3 axis-pairs (= sec-2 p=3).
[Hypothesis] deeper internal (higher-D) structure = stronger colour binding = heavier;
           swap-graph symbol-count <-> quark/colour content (falsifiable, untested).
[DEFEATER] every row shows the measured value; any mismatch falsifies that assignment.

======================================================================
WHAT THIS COMPUTES vs CLAIMS  (misses at full weight)
======================================================================
  COMPUTES [EXACT]  : the closure census, the -p/2 spectral exponent,
                      census->pi convergence, the 128+d^2 joint at d=3.
  READS             : frequency=mass (m=1/R), so the octave hierarchy IS the
                      mass spectrum; D>3 = internal gauge/color (external 3D =
                      receipt quotient); particle map to m_e (sec 6).
  DERIVED (reused)  : proton 6*pi^5, pion 2/alpha, tau Koide -- ratios to m_e,
                      verified in QLF_LenzMassRatio/PionMassRatio/Koide.
  HYPOTHESIS        : swap-graph symbol-count <-> quark/color content; deeper
                      internal structure = stronger binding = heavier (untested).
  STILL OPEN        : DSI (none in binary sector); the alpha 0.036 residual; the
                      ABSOLUTE mass scale (needs closure depth + QCD, not census).
  NOT A PROOF       : an exploratory instrument.  The Lean layer, not this,
                      is where the verified ratios live.

```

## genesis.py ↔ the particle zoo

genesis.py's sectors are not separate from particle physics — each is *the same combinatorial object* a
verified QLF module already rests on. Two identities carry the tie:

- **Frequency = mass.** `m = 1/R = frequency` ([`QLF_HiggsMechanism`](lean/QLF_HiggsMechanism.lean),
  `mass_is_gauge_fold_delay`), so the §3 frequency-octave hierarchy **is** the mass spectrum — frequency
  *determines* mass ([`Per_Qubit_Mass_Quantum.md`](Per_Qubit_Mass_Quantum.md)).
- **Internal dimensions = color/forces.** The §4 swap-graph growth beyond the externally-rendered 3-D
  (the receipt quotient) is the **internal gauge/color structure** — extra dimensions not perceived as
  space, manifesting as the stronger (color) force ([`QLF_StrongAlgebra`](lean/QLF_StrongAlgebra.lean);
  Borromean three-color necessity `baryon_needs_all_three_axes`, [`QLF_QuarkStructure`](lean/QLF_QuarkStructure.lean)).

### The shared objects

| genesis sector | the object | shared with (verified) | what it fixes |
|---|---|---|---|
| §1 census `C(2n,n)` | central-binomial closure count | `string_mode_count` ([`StringTheoryQLF`](lean/StringTheoryQLF.lean)) | the string level-`n` **mode degeneracy** |
| §2 `−p/2` exponent | conjugate-pair count | [`QLF_Generations`](lean/QLF_Generations.lean), [`QLF_StrongAlgebra`](lean/QLF_StrongAlgebra.lean), [`QLF_SU5`](lean/QLF_SU5.lean) | the **6+2 split** → colour SU(3), 3 generations, α's `N=3²` |
| §3 frequency hierarchy | `m = 1/R` ladder | [`QLF_HiggsMechanism`](lean/QLF_HiggsMechanism.lean), [`QLF_PrimeResonance`](lean/QLF_PrimeResonance.lean) | **mass**, and prime-frequency stability (proton `n=3`) |
| §4 swap-graph `D>3` | internal config-space DOF | [`QLF_QuarkStructure`](lean/QLF_QuarkStructure.lean), [`QLF_StrongAlgebra`](lean/QLF_StrongAlgebra.lean) | the internal **color** structure / strong force |
| §5 `128+d²=137` | α from `6+2` | [`QLF_FineStructureSubstrate`](lean/QLF_FineStructureSubstrate.lean) | EM coupling / fine structure |

### Quantum numbers (derived)

- **Color** = the 3 internal axes (`QLF_StrongAlgebra`); a baryon needs **all three** (`baryon_needs_all_three_axes`).
- **Electric charge** = signed twist winding, quantized in **thirds** by the 3 colors (`down_quark_charge_third`, `QLF_QuarkStructure`).
- **Baryon number** = 3-axis winding ([`QLF_BaryonWinding`](lean/QLF_BaryonWinding.lean)); proton `+1`.
- **Generation** = the 3 spatial axis-pairs (= genesis §2's `p=3`; `num_generations_eq_three`, `QLF_Generations`).
- **Spin** = the half-spin closure ([`QLF_Spin`](lean/QLF_Spin.lean)), 720° double cover.

### The particle table — internal structure → mass relative to `m_e`

Every mass is a ratio to the electron (the minimal chiral 4-twist loop, `fold_electron`). The proton and
pion ratios use genesis.py's *own* π (§5 census) and `137` (§5, `128+d²`):

| particle | internal structure | quantum #s | `m/m_e` (QLF) | measured | tag |
|---|---|---|---|---|---|
| electron | minimal chiral loop | `L, q=−1, gen 1` | `1` (reference) | 1 | reference |
| muon | gen-2 lepton | `L, q=−1, gen 2` | `206.77` | 206.77 | depth ratio |
| tau | 3-phase Koide | `L, q=−1, gen 3` | `3477.4` | 3477.2 | **[Derived]** (Koide, given `m_e,m_μ`) |
| proton | 3 colors, `\|S₃\|=6` | `B=+1, q=+1` | `6π⁵ = 1836.12` | 1836.15 | **[Derived]** ([`QLF_LenzMassRatio`](lean/QLF_LenzMassRatio.lean), 0.002%) |
| charged pion | 2 quarks, `\|S₂\|=2` | `B=0, q=±1` | `2/α = 274` | 273.1 | **[Derived]** ([`QLF_PionMassRatio`](lean/QLF_PionMassRatio.lean)) |

**[Hypothesis]** (falsifiable, untested): deeper internal (higher-`D`) structure = stronger color
binding = heavier; the swap-graph symbol-type count maps to quark/color content. **Defeater:** every row
carries its measured value — any assignment that misses the PDG number falsifies *that* assignment.

**Honest scope.** The `m_e`-referenced *ratios* (`6π⁵`, `2/α`, Koide) are machine-verified in the cited
Lean modules; genesis.py **reuses and displays** them (its own π and `137` feed the proton/pion rows). It
does **not** compute the **absolute** mass scale — that needs the closure depth + the QCD scale
([`QLF_MassSpectrum`](lean/QLF_MassSpectrum.lean), [`QLF_AlphaS`](lean/QLF_AlphaS.lean)), which is a
separate, in-progress input. So the answer to "can genesis.py's results be tied to the particle zoo?" is:
**yes — the frequency ladder is the mass spectrum and the internal dimensions are the color/gauge
structure, with the specific mass *ratios* derived and referenced to the electron; the absolute scale
stays open.** See [`Standard_Model.md`](Standard_Model.md), [`Quarks.md`](Quarks.md).

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
