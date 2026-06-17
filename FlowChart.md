# QLF Flow Chart — a visual map of the framework

> **This is a navigation map of the [Quantum Logical Framework (QLF)](README.md).** Each chart shows a
> domain as a Mermaid diagram (rendered on GitHub) with every **connector labelled** by the relationship
> it encodes; the **↳ open:** line under each chart links to the docs that derive those boxes, so the ten
> charts form one navigable web.

The taxonomy: **one substrate → ten domains → the individual results.**

---

## Master map — the substrate and its ten domains

```mermaid
flowchart TD
  S["⬡ The QLF Substrate<br/>8-twist alphabet · ZFA closure · synthesized spacetime"]
  S -->|"renders"| SP["① Space, time and the continuum"]
  S -->|"fixes"| C["② The fundamental constants"]
  S -->|"projects"| F["③ Forces"]
  S -->|"binds"| A["④ Atoms and QED"]
  S -->|"weighs"| G["⑤ Gravity and GR"]
  S -->|"expands"| CO["⑥ Cosmology and the dark sector"]
  S -->|"structures"| P["⑦ Particles and the Standard Model"]
  S -->|"meets"| T["⑧ Quantum-gravity / TOE pillars"]
  S -->|"resolves"| M["⑨ The Millennium Prize program"]
  S -->|"predicts"| B["⑩ Beyond the SM"]
```

**↳ open:** [`README.md`](README.md)

Root reading: **everything derives from the 8-twist substrate under Zero Free Action** —
[`Philosophy.md`](Philosophy.md) (possibilist ontology), [`WHITE_PAPER.md`](WHITE_PAPER.md).

---

## 1. Space, time, and the continuum

```mermaid
flowchart TD
  H1["⬆ master map"] -.->|"domain ①"| S["8-twist substrate · ZFA"]
  S -->|"causal order"| R["Closure-reachability<br/>(pre-geometric causal set)"]
  R -->|"faithful 3-D render"| D["3 spatial dimensions"]
  S -->|"logical latency"| T["Time = per-event Planck tick"]
  D -->|"synthesize"| SP["Synthesized spacetime"]
  T -->|"synthesize"| SP
  S -->|"RCA₀ floor"| CN["No continuum / no Choice"]
```

**↳ open:** [`README.md`](README.md) · [`SpaceTime.md`](SpaceTime.md) · [`TheContinuum.md`](TheContinuum.md)

`3` is the minimal dimension that renders any relational structure faithfully — and it reappears
everywhere below ([`SpaceTime.md`](SpaceTime.md) §3a).

---

## 2. The fundamental constants

The `6 spatial + 2 gauge` split (the `3` axes) fixes a family of constants. **α is the flagship.**

```mermaid
flowchart TD
  H2["⬆ master map"] -.->|"domain ②"| SP["6+2 split → 3 spatial axes"]
  SP -->|"N = 3²"| AL["α = 1/137"]
  SP -->|"spatial 3/8"| WK["sin²θ_W = 3/8"]
  SP -->|"gauge 2/8"| OL["Ω_Λ = log 2"]
  SP -->|"surface ∝ r²"| NW["Newton 1/r²"]
  SP -->|"ℓ = 3"| MG["nuclear magic numbers"]
  S2["3-quark Borromean closure"] -->|"6π⁵"| MP["m_p/m_e = 6π⁵"]
  AL -->|"2/α"| MPI["m_π/m_e = 274"]
```

**↳ open:** [`SpaceTime.md`](SpaceTime.md) · [`Alpha.md`](Alpha.md) · [`Weak_Force.md`](Weak_Force.md) · [`Cosmological_Constant.md`](Cosmological_Constant.md) · [`Gravity_From_Delay.md`](Gravity_From_Delay.md) · [`Magic_numbers.md`](Magic_numbers.md) · [`Proton_Resonance_R_e.md`](Proton_Resonance_R_e.md) · [`Pion_QLF.md`](Pion_QLF.md)

**α's full story** (derivation, IR/3-D scale, the running, the no-drift theorem, 4D/5D
over-determination): [`Alpha.md`](Alpha.md).

---

## 3. Forces

One gauge-twist mechanism, seen from three projections of the 3-axis structure.

```mermaid
flowchart TD
  H3["⬆ master map"] -.->|"domain ③"| AX["3 spatial axes + 2 gauge"]
  AX -->|"abelian"| EM["U(1) — electromagnetism"]
  AX -->|"non-abelian, chiral"| WK["SU(2) — weak"]
  AX -->|"colour, confined"| ST["SU(3) — strong"]
  AL["α (derived)"] -->|"+ one mass = scale"| CPL["dimensionless couplings"]
  EM -->|"projection"| UNI["one force, three projections"]
  WK -->|"projection"| UNI
  ST -->|"projection"| UNI
```

**↳ open:** [`Forces_From_Three_Axes.md`](Forces_From_Three_Axes.md) · [`Electricity.md`](Electricity.md) · [`Weak_Force.md`](Weak_Force.md) · [`Alpha.md`](Alpha.md) · [`Forces_From_Alpha.md`](Forces_From_Alpha.md)

---

## 4. Atoms and QED

Everything here is **downstream of the derived α** ([`Alpha.md`](Alpha.md) §10).

```mermaid
flowchart TD
  H4["⬆ master map"] -.->|"domain ④"| AL["α = 1/137"]
  AL -->|"½α²m_e c²"| RY["Rydberg / Bohr"]
  AL -->|"∝ α²"| DI["Dirac fine structure"]
  AL -->|"loop α"| LA["Lamb shift"]
  AL -->|"α/2π"| GM["g−2"]
  AL -->|"Z₀/2α"| VK["von Klitzing R_K"]
  AL -->|"∝ α⁴"| HF["hyperfine / 21 cm"]
```

**↳ open:** [`Alpha.md`](Alpha.md) · [`Hydrogen.md`](Hydrogen.md) · [`Dirac_Correction.md`](Dirac_Correction.md) · [`Lamb_Shift.md`](Lamb_Shift.md) · [`g_minus_2.md`](g_minus_2.md) · [`Electricity.md`](Electricity.md) · [`Magnetism_Spatial_Dynamics.md`](Magnetism_Spatial_Dynamics.md)

---

## 5. Gravity and GR

```mermaid
flowchart TD
  H5["⬆ master map"] -.->|"domain ⑤"| HO["Holographic event-counting + log 2"]
  HO -->|"G = L_P²c³/ℏ"| NG["Newton's law + G"]
  NG -->|"43″/century"| ME["Mercury perihelion"]
  HO -->|"δQ = T δS"| EE["Einstein equations<br/>(equation of state)"]
  EE -->|"causal order → metric"| CV["Curvature"]
  EE -->|"spin-2, v = c"| GW["Gravitational waves"]
```

**↳ open:** [`Gravity_From_Delay.md`](Gravity_From_Delay.md) · [`Mercury_Perihelion.md`](Mercury_Perihelion.md) · [`Einstein_Equations.md`](Einstein_Equations.md) · [`Curvature.md`](Curvature.md)

---

## 6. Cosmology and the dark sector

```mermaid
flowchart TD
  H6["⬆ master map"] -.->|"domain ⑥"| EV["ZFA event synthesis (w = −1)"]
  EV -->|"gauge 2/8"| OL["Ω_Λ = log 2<br/>closes the 10¹²² catastrophe"]
  EV -->|"high-V epoch"| IN["Inflation (same field)"]
  EV -->|"denser logic"| DM["Dark matter (no particle)"]
  OL -->|"residual w = −1"| DE["Dark energy"]
  EV -->|"event rate"| AGE["Age ≈ 13.8 Gyr"]
  EV -->|"freeze-out n/p"| NS["⁴He fraction Y_p ≈ ¼"]
```

**↳ open:** [`Cosmological_Constant.md`](Cosmological_Constant.md) · [`Curvature.md`](Curvature.md) · [`DarkMatter.md`](DarkMatter.md) · [`AgeOfUniverse.md`](AgeOfUniverse.md) · [`Fusion.md`](Fusion.md)

---

## 7. Particles and the Standard Model

```mermaid
flowchart TD
  H7["⬆ master map"] -.->|"domain ⑦"| TH["3 spatial axes (the same 3)"]
  TH -->|"axis count"| GEN["3 fermion generations"]
  GEN -->|"Q = 2/3"| KO["Koide → m_τ"]
  GEN -->|"3 angles + CP"| MX["CKM / PMNS mixing"]
  TH -->|"self-conjugate"| NU["neutrino is Majorana"]
  NU -->|"ΔL = 2"| BD["β-decay / 0νββ"]
  TH -->|"one scale × ratios"| MS["mass spectrum"]
  SP["spin = the twists"] -->|"m = 1/R fold delay"| HG["mass (Higgs mechanism)"]
```

**↳ open:** [`Standard_Model.md`](Standard_Model.md) · [`Beta_Decay_Neutrino_Nature.md`](Beta_Decay_Neutrino_Nature.md) · [`Per_Qubit_Mass_Quantum.md`](Per_Qubit_Mass_Quantum.md) · [`Spin_QLF.md`](Spin_QLF.md) · [`Higgs.md`](Higgs.md)

---

## 8. Quantum-gravity / TOE pillars

QLF meets the three TOE-candidate programs — and reproduces their wins from the substrate.

```mermaid
flowchart TD
  H8["⬆ master map"] -.->|"domain ⑧"| S["substrate"]
  S -->|"j = ½ spin network"| LQ["Loop Quantum Gravity"]
  S -->|"C(2n,n) modes"| ST["String theory"]
  S -->|"Q = half-spin shift"| SU["Supersymmetry"]
  S -->|"closure floor μ²=½"| PL["Planck scale"]
```

**↳ open:** [`README.md`](README.md) · [`LQG_QLF.md`](LQG_QLF.md) · [`StringTheory.md`](StringTheory.md) · [`SUSY_QLF.md`](SUSY_QLF.md) · [`Planck_Scale.md`](Planck_Scale.md)

---

## 9. The Millennium Prize program

The thesis: *the continuum and Choice are mathematics' UV catastrophe* — each problem = a constructive
RCA₀ core + one explicit continuum/Choice boundary axiom.

```mermaid
flowchart TD
  H9["⬆ master map"] -.->|"domain ⑨"| CC["Continuum = UV catastrophe<br/>(RCA₀ core + boundary axiom)"]
  CC -->|"critical line"| RH["Riemann hypothesis"]
  CC -->|"log 2 gap quantum"| YM["Yang–Mills mass gap"]
  CC -->|"rank = ord"| BS["Birch–Swinnerton-Dyer"]
  CC -->|"balanced ⟹ algebraic"| HOD["Hodge conjecture"]
  CC -->|"generate ≠ verify"| PN["P vs NP"]
  CC -->|"no blow-up"| NV["Navier–Stokes"]
```

**↳ open:** [`Continuum_Choice_Fallacy.md`](Continuum_Choice_Fallacy.md) · [`Riemann-Conjecture-Proof.md`](Riemann-Conjecture-Proof.md) · [`YangMills_MassGap_QLF.md`](YangMills_MassGap_QLF.md) · [`BSD_QLF.md`](BSD_QLF.md) · [`Hodge_QLF.md`](Hodge_QLF.md) · [`P_vs_NP_QLF.md`](P_vs_NP_QLF.md) · [`NavierStokes_QLF.md`](NavierStokes_QLF.md)

Overview: [`Millennium.md`](Millennium.md).

---

## 10. Beyond the SM

What QLF derives that the SM treats as free input, and the falsifiable predictions it makes.

```mermaid
flowchart TD
  H10["⬆ master map"] -.->|"domain ⑩"| B["Beyond the Standard Model"]
  B -->|"not free"| D1["derived: α, Koide, θ̄=0, Ω_Λ"]
  B -->|"⚡ test now"| P1["Majorana neutrino → 0νββ"]
  B -->|"⚡ scale-free by construction"| P2["no cosmological drift of α(0)"]
  B -->|"soft"| P3["dark matter is not a particle"]
```

**↳ open:** [`Beyond_Standard_Model.md`](Beyond_Standard_Model.md) · [`Beta_Decay_Neutrino_Nature.md`](Beta_Decay_Neutrino_Nature.md) · [`Alpha.md`](Alpha.md) · [`DarkMatter.md`](DarkMatter.md)

---

## See also

- [`README.md`](README.md) · [`lean/README.md`](lean/README.md) — project overview + the 89-module Lean
  table.
- [`Open_Problems.md`](Open_Problems.md) — the honest gap registry (closed / principled-boundary / open).
- [`Beyond_Standard_Model.md`](Beyond_Standard_Model.md) — the derived / predicted / open scorecard.
- [`Alpha.md`](Alpha.md) — one result mapped end to end, as a worked example.
