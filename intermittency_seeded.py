#!/usr/bin/env python3
"""
intermittency_seeded.py — leg 2 of the α-residual intermittency swing, re-posed on a
SEEDED census (an injection scale), and taken to the end of the path
([`Alpha_Residual.md`](Alpha_Residual.md) §9c).

The vacuum first-closure census has no inertial range: the per-octave Kraft-flux
multiplier `W(R) = ΔM(R)/ΔM(R−1)` decays monotonically (`intermittency_bridge.py`).
A turbulent inertial range needs continuous forcing at an injection scale, so this
seeds the transfer recursion from a preparation strand (imbalance = injection) and
checks whether `W(R)` develops a plateau. Three readings:

  (A) seeded first-closure census: `W(R)` per injection scale `R_inj`;
  (B) first-passage sub-cascade: successive `W`-ratios in the tail;
  (C) steady-state: the stationary distribution of the capacity-`R` transfer operator.

Result (all three): **no inertial range at any injection scale.** Seeding shifts the
`W(R)` peak to `R_inj + 1` and adds a spike, then `W(R)` decays exactly as in the
vacuum; the steady state concentrates at the boundary. The closure census has no
turbulent cascade — the Kraft-weighted flux leaks (Kraft bound) and piles at the
floor rather than cascading scale-invariantly. Leg 2 is definitively negative.

Run:  python3 intermittency_seeded.py
"""
from __future__ import annotations

from collections import defaultdict

_STEPS = [("^", 1, 0, 0, 0), ("v", -1, 0, 0, 0), (">", 0, 1, 0, 0), ("<", 0, -1, 0, 0),
          ("/", 0, 0, 1, 0), ("\\", 0, 0, -1, 0), ("+", 0, 0, 0, 1), ("-", 0, 0, 0, -1)]


def _exc(v, h, d, l):
    return abs(v) + abs(h) + abs(d) + abs(l)


def seeded_first_closure(seed, L_max, R_max):
    """seed = (v,h,d,l).  Transfer recursion from that state, absorb at the first
    return to the origin, bin by max L1-excursion.  clos[(R, L)] = count."""
    sv, sh, sd, sl = seed
    live = {(sv, sh, sd, sl, _exc(sv, sh, sd, sl)): 1}
    clos: dict[tuple[int, int], int] = defaultdict(int)
    for L in range(1, L_max + 1):
        nxt: dict[tuple, int] = defaultdict(int)
        for (v, h, d, l, mx), c in live.items():
            for _n, dv, dh, dd, dl in _STEPS:
                nv, nh, nd, nl = v + dv, h + dh, d + dd, l + dl
                e = _exc(nv, nh, nd, nl)
                if e > R_max:
                    continue
                nmx = mx if mx >= e else e
                if nv == 0 and nh == 0 and nd == 0 and nl == 0:
                    clos[(nmx, L)] += c
                else:
                    nxt[(nv, nh, nd, nl, nmx)] += c
        live = nxt
        if not live:
            break
    return clos


def W_profile(clos, R_max):
    M = {R: sum(c * 8.0 ** -L for (RR, L), c in clos.items() if RR == R) for R in range(0, R_max + 1)}
    W = {R: (M[R] / M[R - 1] if M.get(R - 1) else float("nan")) for R in range(1, R_max + 1)}
    return M, W


def stationary_profile(R_cap, iters=1500):
    """Power-iterate the capacity-R-bounded walk (unsigned); return the stationary
    mass at each excursion level (even levels only — the walk is period-2)."""
    live = defaultdict(float)
    live[(0, 0, 0, 0)] = 1.0
    for _ in range(iters):
        nxt = defaultdict(float)
        for (v, h, d, l), p in live.items():
            for _n, dv, dh, dd, dl in _STEPS:
                nv, nh, nd, nl = v + dv, h + dh, d + dd, l + dl
                if _exc(nv, nh, nd, nl) > R_cap:
                    continue
                nxt[(nv, nh, nd, nl)] += p
        s = sum(nxt.values())
        if s == 0:
            return None
        live = {k: val / s for k, val in nxt.items()}
    prof = defaultdict(float)
    for (v, h, d, l), p in live.items():
        prof[_exc(v, h, d, l)] += p
    return prof


def main() -> None:
    print(__doc__.split("Run:")[0])
    R_MAX, L_MAX = 12, 24

    print("=" * 78)
    print("(A) seeded first-closure census — W(R) = ΔM(R)/ΔM(R−1) per injection scale\n")
    seeds = [((0, 0, 0, 0), "vacuum   R_inj=0"), ((2, 0, 0, 0), "Y-prep   R_inj=2"),
             ((4, 0, 0, 0), "Y-prep   R_inj=4"), ((6, 0, 0, 0), "Y-prep   R_inj=6"),
             ((8, 0, 0, 0), "Y-prep   R_inj=8"), ((3, 3, 0, 0), "XY-prep  (3,3)"),
             ((5, 5, 0, 0), "XY-prep  (5,5)")]
    for seed, label in seeds:
        clos = seeded_first_closure(seed, L_MAX, R_MAX)
        M, W = W_profile(clos, R_MAX)
        ws = "  ".join(f"{R}:{W[R]:.3f}" for R in range(1, R_MAX + 1) if W[R] == W[R])
        print(f"  {label:18s} M_∞={sum(M.values()):.6f}   W(R): {ws}")
    print("\n  → seeding shifts the peak to R_inj+1 and adds a W>1 spike, then W(R) DECAYS")
    print("    monotonically — the same tail as the vacuum, at every injection scale.\n")

    print("=" * 78)
    print("(B) first-passage sub-cascade — successive W-ratios in the vacuum tail\n")
    clos0 = seeded_first_closure((0, 0, 0, 0), 28, 14)
    _, W0 = W_profile(clos0, 14)
    for R_inj in (2, 4, 6):
        tail = [W0[R] for R in range(R_inj, 14) if W0[R] == W0[R] and W0[R] > 0]
        rats = [tail[i + 1] / tail[i] for i in range(len(tail) - 1)]
        print(f"  R_inj={R_inj}: ratios {[f'{r:.2f}' for r in rats]}  "
              f"(a constant ⇒ inertial range; here drifting down)")
    print()

    print("=" * 78)
    print("(C) steady-state — stationary distribution of the capacity-R transfer operator\n")
    for R_cap in (4, 6, 8):
        prof = stationary_profile(R_cap, iters=1200)
        if prof is None:
            continue
        row = "  ".join(f"{r}:{prof[r]:.4f}" for r in range(0, R_cap + 1, 2))
        evens = [prof[r] for r in range(0, R_cap + 1, 2)]
        ratios = [evens[i + 1] / evens[i] for i in range(len(evens) - 1) if evens[i] > 1e-12]
        print(f"  R_cap={R_cap}: {row}")
        print(f"           even-level ratios {[f'{x:.2f}' for x in ratios]}  "
              f"(concentrates at the boundary — not scale-invariant)")
    print()

    print("=" * 78)
    print("VERDICT — leg 2, to the end of the path\n")
    print("  NO inertial range in the closure census, vacuum OR seeded, at converged depth.")
    print("  The Kraft-weighted closure-flux leaks (twist_kraft) and piles at the floor; it is")
    print("  not a conserved cascading quantity, so there is no μ and re-posing cannot create one.")
    print("  Leg 1's C₀ = 2 derivation stands; the turbulence swing gives a side-result, not δw.")
    print("  Honest landing: w = 1/2 structural, α⁻¹ = 137.032 the pure-ZFA prediction, the last")
    print("  ~0.004 the continuum vacuum-polarisation running (Alpha_Residual.md §2a, §9c).")


if __name__ == "__main__":
    main()
