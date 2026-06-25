# The geometry of Navier–Stokes — angular momentum, vorticity, and where QLF avoids the infinity

The dynamics of the substrate geometry ([`Geometry_Of_Space.md`](Geometry_Of_Space.md)) are rotational,
and the [Quantum Logical Framework](README.md) (QLF) already carries the right objects. This doc
formalizes **angular momentum conservation**, then reads the **Navier–Stokes** geometry off it — and
shows precisely **where QLF avoids the blow-up** and **what correction it makes**. The structural
spine is machine-verified in [`lean/QLF_AngularMomentum.lean`](lean/QLF_AngularMomentum.lean).

---

## 1. Angular momentum = circulation

`baryonNumber` ([`QLF_BaryonWinding`](lean/QLF_BaryonWinding.lean)) is a **sliding-window sum of
`signTriple`** — the oriented all-three-axes sign (`+1` cyclic `(x,y,z)`, `−1` anticyclic, `0`
otherwise), the discrete **Levi-Civita curl** of three consecutive twist-axes. Summed over the path it
is the **signed 3-axis winding** — orbital angular momentum, the **Kelvin circulation** of the twist
flow, the Noether charge of the substrate's rotational `su(2)` symmetry (`su2_comm_xy`, `QLF_Spin`).

- **`circulation := baryonNumber`** — angular momentum. Calibrated: the Borromean proton `>^/` carries
  `+1`, its antiparticle `−1` (`baryon_antiproton`), a meson `q q̄` cancels to `0` (`baryon_meson`).
- **`circulation_reverses_under_time_reversal`** — angular momentum is a **pseudovector**: time-reversal
  / parity (`antiparticle` = conjugate-and-reverse) flips it, `L → −L`. This is the defining
  transformation of angular momentum, and it is exactly `baryon_dagger_odd` re-read.

So the conserved rotational charge of the geometry is the circulation, T-odd as angular momentum must be.

## 2. Vorticity is the discrete curl — and it is quantized

In fluid dynamics the **vorticity** `ω = ∇×v` is the local rotation rate — the angular momentum density.
On the substrate it is exactly the local curl cell:

- **`vorticity a b c := signTriple (axOf a) (axOf b) (axOf c)`** — the oriented all-three-axes sign of
  three consecutive twist-axes, the per-cell circulation.
- **`vorticity_antisymmetric`** — reversing the cell flips the sign (`ω(c,b,a) = −ω(a,b,c)`): a curl is
  orientation-odd, as it must be (`signTriple_rev`).
- **`vorticity_quantized` — `|ω| ≤ 1`.** Every cell carries **at most one circulation quantum**
  (`signTriple ∈ {−1, 0, +1}`). The vorticity is *quantized*.

## 3. Where QLF avoids the Navier–Stokes infinity

The Clay Navier–Stokes problem is whether a smooth incompressible flow can develop a **finite-time
singularity** — and the sharp criterion (Beale–Kato–Majda) is exactly **vorticity blow-up**: a
singularity forms iff `∫ ‖ω‖_∞ dt → ∞`, i.e. iff the vorticity becomes **unbounded**.

On the substrate that cannot happen:

- **Local: `ω` is capped at one quantum per cell** (`vorticity_quantized`, `|ω| ≤ 1`). There is no
  `ω → ∞` because there is a smallest, largest circulation a cell can hold. The blow-up criterion is
  *unsatisfiable* on the discrete geometry.
- **Global: angular momentum in a finite region is finite** (`circulation_bounded`, `|L| ≤ n`). A
  length-`n` history holds at most `n` circulation quanta — no runaway angular momentum.
- **The continuum's singular vorticity is unrealizable** (`continuum_vorticity_unrealizable`): a
  continuum vorticity value is a real number (`Infinite ℝ`), but a substrate cell holds finite
  information (`Finite R`), so there is **no faithful realization** of an `ℝ`-valued vorticity in a
  finite cell ([`no_continuum_in_finite_region`](lean/QLF_Realizability.lean)).

This gives the existing result `realized_flow_is_stable` ([`QLF_NavierStokes`](lean/QLF_NavierStokes.lean) —
"no realized flow blows up") its **geometric mechanism**: a blow-up would require unbounded vorticity,
and vorticity is capped at one quantum per cell.

## 4. The nature of the correction

The continuum permits `ω → ∞` because it models vorticity as a **real field with no smallest quantum** —
arbitrarily fine, arbitrarily intense rotation concentrated at a point. The substrate **quantizes
circulation to `±1` per cell** and bounds the count per region. That **discreteness is the correction** —
not a regularization bolted on, but the substrate's native floor. It is the *same* cutoff that removes
the ultraviolet catastrophe and the `10¹²²` vacuum catastrophe ([`TheContinuum.md`](TheContinuum.md)):
wherever the continuum produces an infinity by allowing unbounded fineness, the discrete substrate caps
it. The Navier–Stokes would-be singularity is one more instance — and the cap is *angular-momentum
quantization*.

## 5. Honest scope

- **Proven on the substrate:** angular momentum = circulation, its pseudovector law, vorticity =
  quantized discrete curl, `|ω| ≤ 1`, `|L| ≤ n`, and the unrealizability of continuum vorticity in a
  finite cell — all machine-verified, no new axioms.
- **The one boundary:** carrying this no-blow-up to the **continuum incompressible PDE** under the
  continuum limit is the named axiom `navier_stokes_continuum_limit` ([`QLF_NavierStokes`](lean/QLF_NavierStokes.lean)) —
  the analytic continuum-sector crossing, the same `RCA₀ → analytic` boundary as the other Millennium
  problems. QLF supplies the *discrete mechanism* (vorticity quantization); the continuum inheritance is
  the boundary, not a QLF theorem.
- **Beale–Kato–Majda** is cited as the standard continuum criterion that *names* what the substrate
  rules out; QLF does not re-derive BKM.

See also: [`NavierStokes_QLF.md`](NavierStokes_QLF.md) (the existence/smoothness reformulation),
[`Geometry_Of_Space.md`](Geometry_Of_Space.md) (the geometry these dynamics live on),
[`Conservation.md`](Conservation.md) (Noether currents), [`Curvature.md`](Curvature.md) (blanket
deformation), [`TheContinuum.md`](TheContinuum.md) (why discreteness removes the infinities).
