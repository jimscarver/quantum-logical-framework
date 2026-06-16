# The Planck Scale is Forced, Not Posited

**Module:** [`lean/QLF_PlanckScale.lean`](lean/QLF_PlanckScale.lean) · **Builds on:** [`lean/QLF_QuantumBlackHole.lean`](lean/QLF_QuantumBlackHole.lean), [`lean/QLF_GravityFromDelay.lean`](lean/QLF_GravityFromDelay.lean)

---

## The flaw

QLF's "substrate event quantum" — *one Planck length and one Planck tick, created together, per ZFA
event* — was carried as a **primitive**: a posited input alongside ZFA (so
[`Experimental_Consistency.md`](Experimental_Consistency.md) listed **two** foundational inputs). A
foundation that has to *assume its own granularity* has a real gap. The docs were honest about it
([`Gravity_From_Delay.md`](Gravity_From_Delay.md) §8: *"there is no independent QLF derivation of the
Planck length"*), but honesty about a gap is not the same as closing it. This note closes it.

## The close: the Planck length is the minimal coherent-closure length

QLF already has the two ingredients it needs — **emergent gravity** (horizons form,
[`QLF_GravityFromDelay`](lean/QLF_GravityFromDelay.lean)) and **Markov-blanket closure** (reality is
made of closures). Put them together and the granularity is *forced*.

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
commitments, the substrate is **forced** to be granular at the Planck length; it is the closure floor,
not a dial someone set.

> **One sentence:** below the Planck length a closure would be inside its own gravitational horizon, so
> it cannot exist — the Planck length is the minimal coherent closure, hence the substrate quantum.

## What this closes — and what it honestly does not

| | Status |
|---|---|
| **The Planck *scale* (a dimensionless fixed point `μ²=1/2`)** | ✅ **Derived** as the closure floor (`QLF_PlanckScale`). No longer a free input — the two foundational inputs (ZFA + substrate quantum) collapse toward one: the quantum's *scale* is entailed. |
| **The Planck length's *SI value in metres*** | **Not a physics question** (so not a flaw). "What a metre is" is a unit convention; you cannot derive it from logic. In Planck units the floor is the dimensionless `√2`; the `O(1)` factor is the Schwarzschild-`2μ` vs reduced-Compton convention. |
| **Where matter sits *above* the floor** (proton depth `R_p`) | 🔵 **Open, but separately tracked** — the dimensional-transmutation hierarchy `ln R_p = 14π` ([`QLF_AlphaS`](lean/QLF_AlphaS.lean), 0.07%) with a residual few-% `M_Planck` calibration. This is the hierarchy problem, **not** the granularity question settled here. |

**Honest dependency note (no circularity).** The Compton–Schwarzschild crossing uses *both* quantum
mechanics (Compton `ℏ/mc`) and gravity (Schwarzschild `Gm/c²`). QLF does **not** derive `ℏ` or `G` here;
it shows their *crossing* is where coherent closure bottoms out. The dimensionless statement `μ² = 1/2`
needs no value of `G` — it presupposes only that QLF *has* emergent gravity and quantum closure, both of
which it does. What was a posited scale becomes an *entailed* one.

## Bottom line

The Planck length is no longer assumed. It is the structurally-forced minimal coherent-closure length —
the self-dual point of the quantum/gravity length duality, machine-verified on top of QLF's own
Compton–Schwarzschild crossing. The substrate is granular at the Planck scale *because nothing smaller
can close*. The only residuals are a unit convention (not a flaw) and the already-logged few-percent
hierarchy calibration.
