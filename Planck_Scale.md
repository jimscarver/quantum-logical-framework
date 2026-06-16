# The Planck Scale by Construction, Not Posited

**Module:** [`lean/QLF_PlanckScale.lean`](lean/QLF_PlanckScale.lean) · **Builds on:** [`lean/QLF_QuantumBlackHole.lean`](lean/QLF_QuantumBlackHole.lean), [`lean/QLF_GravityFromDelay.lean`](lean/QLF_GravityFromDelay.lean)

---

## The Planck length is the minimal coherent-closure length

QLF's "substrate event quantum" — *one Planck length and one Planck tick, created together, per ZFA
event* — is not a posited input alongside ZFA. It follows **by construction** from QLF's own structure:
a foundation does not assume its own granularity; the granularity *is* the smallest coherent closure.

QLF has the two ingredients this needs — **emergent gravity** (horizons form,
[`QLF_GravityFromDelay`](lean/QLF_GravityFromDelay.lean)) and **Markov-blanket closure** (reality is
made of closures). Together they place the granularity, **by construction**, at the minimal coherent
closure.

Work in Planck units (`ℏ = c = 1`). A coherent closure of spatial extent `R` confines an energy whose
Compton radius is `R` — a mass `μ = 1/R`. That energy carries a gravitational horizon of radius
`r_s = 2μ` (`schwarzschild_radius`, `G = 1`). The closure is a **localized quantum object** — not a
self-engulfed horizon — exactly when its horizon does not exceed its extent. Three machine-checked steps
([`QLF_PlanckScale`](lean/QLF_PlanckScale.lean)):

1. **`coherent_iff_subplanck`** — `schwarzschild_radius μ < compton_radius μ ↔ μ² < 1/2`. A closure stays
   coherent **iff** it is sub-Planck in mass. (`←` reuses the already-proven
   `sub_planck_compton_gt_schwarzschild`; `→` is the one-line algebra `2μ < 1/μ ⟹ μ² < 1/2`.)
2. **`planck_length_floor`** — every coherent closure has Compton length `> √2`:
   `2 < (compton_radius μ)²`. **There is no coherent closure below the Planck length.** Try to confine a
   blanket tighter and its confinement energy's horizon grows *larger than the blanket itself* — it is
   inside its own horizon and **cannot close**.
3. **`planck_self_dual`** — the floor is the **unique self-dual point** `μ² = 1/2`, where the quantum
   (Compton) and gravitational (Schwarzschild) closure radii coincide (reuses
   `compton_eq_schwarzschild_iff`). It is the fixed point of the length ↔ length duality.

So the substrate granularity is **not arbitrary**. The smallest coherent Markov blanket sits at the
Compton–Schwarzschild self-dual point — and that point *is* the Planck scale. Given QLF's own
commitments, the substrate is granular at the Planck length **by construction**; it is the closure
floor, not a dial someone set.

> **One sentence:** below the Planck length a closure would be inside its own gravitational horizon, so
> it cannot exist — the Planck length is the minimal coherent closure, hence the substrate quantum.

## What is derived, and what is convention

| | Status |
|---|---|
| **The Planck *scale* (a dimensionless fixed point `μ²=1/2`)** | ✅ **Derived by construction** as the closure floor (`QLF_PlanckScale`). It is not a free input — the quantum's *scale* is what the minimal coherent closure is. |
| **The Planck length's *SI value in metres*** | **Not a physics question** (so not a flaw). "What a metre is" is a unit convention; you cannot derive it from logic. In Planck units the floor is the dimensionless `√2`; the `O(1)` factor is the Schwarzschild-`2μ` vs reduced-Compton convention. |
| **Where matter sits *above* the floor** (proton depth `R_p`) | 🔵 **Open, but separately tracked** — the dimensional-transmutation hierarchy `ln R_p = 14π` ([`QLF_AlphaS`](lean/QLF_AlphaS.lean), 0.07%) with a residual few-% `M_Planck` calibration. This is the hierarchy problem, **not** the granularity question settled here. |

**Why "by construction," not loose — and no circularity.** The crossing uses *both* the Compton length
(`ℏ/mc`) and the Schwarzschild radius (`Gm/c²`), which looks like it imports `ℏ` and `G` as external
scales. It does not, because in QLF neither is an independent input:

- **`G` is emergent.** `QLF_GravityFromDelay` derives `G = L_P²c³/ℏ` from holographic delay — `G` is
  *not* a fundamental constant, it co-varies with `L_P`. So using the Schwarzschild radius imports no
  scale independent of the substrate.
- **`ℏ` is just scaling.** It is the unit of action (`ℏ = 1` in natural units). Its only *physical*
  content is `ℏ ≠ 0` — the substrate's discreteness, which *is* ZFA (`Philosophy.md` §1). The value of
  `ℏ` is a unit convention, not a physical scale.

So in natural units (`ℏ = c = G = 1`) the crossing `μ² = 1/2` is a pure dimensionless fact that imports
**nothing external**. "**By construction**" therefore means *it falls out of QLF's own construction* —
emergent gravity + `ℏ`-as-discreteness + the closure ontology (the quantum = the minimal coherent
closure) — **not** "derived from nothing." QLF does not get to *choose* its granularity; its own
construction fixes it. The only thing left conventional is the SI value of a metre.

## Bottom line

The Planck length is not assumed. It is the minimal coherent-closure length **by construction** —
the self-dual point of the quantum/gravity length duality, machine-verified on top of QLF's own
Compton–Schwarzschild crossing. The substrate is granular at the Planck scale *because nothing smaller
can close*. The only residuals are a unit convention (not a flaw) and the already-logged few-percent
hierarchy calibration.
