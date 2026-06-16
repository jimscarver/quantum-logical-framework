# Loop Quantum Gravity in the Quantum Logical Framework

**Module:** [`lean/QLF_LoopQuantumGravity.lean`](lean/QLF_LoopQuantumGravity.lean) · **Builds on:** [`lean/QLF_GravityFromDelay.lean`](lean/QLF_GravityFromDelay.lean) (holographic entropy), [`lean/QLF_Spin.lean`](lean/QLF_Spin.lean) (`su(2)` closure), [`lean/QLF_ReachableEvent.lean`](lean/QLF_ReachableEvent.lean) (causal set)

---

## Thesis

Loop Quantum Gravity (Ashtekar, Rovelli, Smolin) and QLF arrive at the same picture from opposite ends.
LQG **quantizes** general relativity and finds that space is discrete — a **spin network** of SU(2)-labelled
edges with quantized area and volume, on **no background**. QLF **starts** from discrete logical closures
and *synthesizes* spacetime. The overlap is not a loose analogy: **QLF's substrate is a spin network of
half-spin (j = ½) ZFA closures**, and the two frameworks' black-hole entropy counts are the *same* object.

## The dictionary

| Loop Quantum Gravity | Quantum Logical Framework | QLF anchor |
|---|---|---|
| **Spin network** (graph, SU(2) labels on edges) | graph of **half-spin ZFA closures**; the three twist axes close `su(2)` | `su2_comm_xy/yz/zx`, `spin_double_cover_nontrivial` ([`QLF_Spin`](lean/QLF_Spin.lean)) |
| **Background independence** (no fixed metric) | spacetime **synthesized** from ZFA events; causal order = reachability partial order | [`ZFAEventDynamics`](lean/ZFAEventDynamics.lean), [`QLF_ReachableEvent`](lean/QLF_ReachableEvent.lean) |
| **Discrete area** (Planck-scale quanta) | holographic patch count `N(R) = 4πR²`, area in Planck patches | `holographic_event_count` ([`QLF_GravityFromDelay`](lean/QLF_GravityFromDelay.lean)) |
| **Horizon punctures**, dominant `j = ½` | each puncture = one half-spin closure carrying `log 2` | `puncture_is_log_two` ([`QLF_LoopQuantumGravity`](lean/QLF_LoopQuantumGravity.lean)) |
| **Black-hole entropy** `S = A/4` from puncture count | `S(R) = N(R)·log 2 = 4πR² log 2` (the same count) | `lqg_horizon_is_holographic`, `holographic_entropy_eq` |
| **Barbero–Immirzi parameter** `γ` (fixes `S = A/4`) | fixed **by construction** by the `log 2`-per-half-spin-puncture quantum | `per_event_entropy = log 2` |
| **Minimal spin `j = ½`** dominates the count | half-spin is the **minimal** ZFA closure (one bit, one `log 2`) | [`HALF-SPIN-ZFA-EMBEDDING.md`](HALF-SPIN-ZFA-EMBEDDING.md) |

## The sharp point: the Immirzi `log 2` is QLF's per-event quantum

In LQG, black-hole entropy is computed by counting horizon states. A puncture of spin `j` carries
`2j + 1` states; the dominant punctures are `j = ½` (two states), each contributing **`log 2`** to the
entropy. The Barbero–Immirzi parameter `γ` is then *chosen* so the total reproduces `S = A/(4ℓ_P²)` — its
value is set by that `log 2`-per-`j=½`-puncture.

QLF needs no such choice. Its per-Planck-patch entropy **is** `log 2` (`per_event_entropy`, the MRE
quantum, the same `log 2` as the Yang–Mills mass gap `gaugeMassGap` and the free-energy decrement
`zfa_closure_minimizes_free_energy`). So:

$$
S(R) \;=\; \underbrace{4\pi R^2}_{N(R)\ \text{punctures}} \times \underbrace{\log 2}_{\text{per } j=\tfrac12 \text{ puncture}}
\qquad(\texttt{lqg\_horizon\_is\_holographic},\ \texttt{holographic\_entropy\_eq})
$$

The LQG horizon-as-a-bag-of-`j=½`-punctures **is** QLF's holographic horizon-as-`4πR²`-half-spin-closures.
The Immirzi parameter is not a free dial in QLF — it is the `log 2` every half-spin closure carries by
construction.

## What QLF adds to LQG

- **A selection rule.** LQG quantizes *all* of GR's kinematics; which spin-network states are physical is
  governed by constraints that are hard to solve. QLF's physical states are exactly the **ZFA closures**
  (`full_zeno_prune`) — the selection principle LQG's kinematical Hilbert space lacks.
- **Causal dynamics.** The succession of states is QLF's **reachability partial order / causal set**
  ([`QLF_ReachableEvent`](lean/QLF_ReachableEvent.lean)) — closer to the covariant spin-foam picture, with
  time as the rendered total order.
- **The Planck scale by construction.** The puncture scale is the minimal coherent closure (the
  Compton–Schwarzschild self-dual floor, [`Planck_Scale.md`](Planck_Scale.md)) — not an input.
- **Why `j = ½` dominates.** Half-spin is the *minimal* ZFA closure (one Hermitian pair, one `log 2`);
  the LQG empirical fact that `j = ½` punctures dominate the entropy is, in QLF, that the smallest closure
  is the half-spin one.

## Honest scope

What is **machine-verified**: the entropy-count correspondence — j = ½ punctures ↔ half-spin closures,
each `log 2`; the horizon entropy `N·log 2`; and its identity with QLF's holographic entropy
`4πR² log 2` (`QLF_LoopQuantumGravity`, reusing `QLF_GravityFromDelay` + `QLF_Spin`). What is **open**
(`lqg_correspondence_in_progress`): the full LQG **area-operator spectrum** `∝ √(j(j+1))` for general `j`
(QLF anchors the `j = ½` count and the Planck-patch area, not the general-`j` operator), and the LQG
**Hamiltonian constraint / spin-foam amplitudes** (QLF's dynamics is the causal-set order, the same open
order→metric step as the Einstein-equation curvature side, [`Einstein_Equations.md`](Einstein_Equations.md) §6a).

## Convergence, not competition

QLF doesn't refute LQG; it *grounds* it. LQG's spin networks, discrete area, background independence, and
`log 2`-per-puncture entropy are all features QLF derives from the half-spin ZFA closure — with the
selection rule and causal dynamics LQG still seeks supplied by ZFA. Loop Quantum Gravity is what the
QLF substrate looks like when you quantize the geometry first and discover the loops afterward.
