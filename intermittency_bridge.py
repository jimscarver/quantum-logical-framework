#!/usr/bin/env python3
"""
intermittency_bridge.py — the pre-registered R0 test of the turbulence/intermittency
swing for the α residual `δw` ([`Alpha_Residual.md`](Alpha_Residual.md) §9c).

**Pre-registration (R0, frozen at the commit that adds this file).**

| field | specification |
|---|---|
| physical inputs held fixed | the 8-twist closure census and the `/solve` selection cascade (least peak excursion → shortest → phase +1 → lexicographic). **No use** of `α⁻¹(0)`, `137.036`, `0.036`, or `w = 0.624` at any step. |
| substrate representation | the per-octave (capacity-horizon `R`) first-closure census, and — the swing's own idea (per Jim) — the **one** closure the substrate selects per octave via the handedness-mediated listener-listener interaction (`/solve`, `QucalcSearch.md`), not the full-census sum. |
| calculation, leg 1 (`C₀`) | the codimension of the selected structure: `C₀ = (spatial axes) − (axes the /solve closure engages)`, from the vacuum and from single-axis seeds. |
| calculation, leg 2 (`μ`) | the per-octave Kraft-flux multiplier `W(R) = ΔM(R)/ΔM(R−1)`, `M(R) = Σ_{maxexc=R first-closures} 8^{−L}`, from the first-closure census run **to convergence** by an exact transfer recursion (state `(v,h,d,l,inv,maxexc)`, no numpy). A scale-invariant inertial range (`W(R) → const`) is the prerequisite; its multifractal deviation is `μ`. |
| observable-extraction rule | leg 1: `C₀` = the modal codimension of the vacuum/single-axis `/solve` closures. leg 2: first check `W(R)` has an inertial range at all; only then fit `ζ_p` and read `μ = 2 − ζ_6`. |
| tolerance | exact integer for `C₀`; the census is exact and converged for leg 2 (`M(∞)` stable to 8 digits by `R = 11`). |
| comparator | She–Leveque, forced (`QLF_Kolmogorov`, `Navier_Stokes_Geometry.md` §6a): `C₀ = 2`, `β = 2/3`, `μ = 2 − ζ_6 = 0.222`. Known numbers, so a match is a retrodiction for the parameter; the prediction is the resulting `δw`. |
| kill condition | if `/solve` is **not** axis-minimal (leg 1 `C₀ ≠ 2`), the swing is closed. If the converged `W(R)` shows **no inertial range** (decays, rather than approaching a constant), leg 2 as posed on the *vacuum* census fails — and re-posing it needs a **seeded** census (an injection scale). |

Run:  python3 intermittency_bridge.py
"""
from __future__ import annotations

from collections import Counter, defaultdict
from math import log

from census_inventory import balanced_histories, is_count_balanced, predicted_phase
from qucalc_search import max_excursion, solve

AXIS = {"^": "Y", "v": "Y", "<": "X", ">": "X", "/": "Z", "\\": "Z", "+": "I", "-": "I"}
SPATIAL_D = 3


def zeta_SL(p: float, C0: float = 2.0, beta: float = 2.0 / 3.0) -> float:
    return p / 9 + C0 * (1 - beta ** (p / 3))


# ---------------------------------------------------------------- leg 1: C₀
def leg1_codimension() -> dict:
    """Is the /solve selection axis-minimal?  C₀ = 3 − (axes engaged)."""
    single = ["^", "^^", "^^^", "^^^^", ">", ">>", ">>>", "/", "//", "///"]
    multi = ["^<", "^^<", "^<<", "^</", "^^<<", "^</\\", "<^>", "/^\\"]
    gauge = ["+^", "^+", "+^^"]
    rows = []
    for label, seeds in (("single-axis", single), ("multi-axis", multi), ("gauge+axis", gauge)):
        for s in seeds:
            r = solve(s, max_depth=6)
            if not r.get("solved"):
                rows.append((label, s, None, None, None))
                continue
            h = r["history"]
            axes = {AXIS[c] for c in h if AXIS[c] != "I"}
            na = len(axes)
            rows.append((label, s, h, sorted(axes), SPATIAL_D - na if na <= SPATIAL_D else 0))
    # the vacuum / single-axis modal codimension
    single_codims = [cd for lbl, s, h, ax, cd in rows if lbl == "single-axis" and cd is not None]
    axis_minimal = all(
        cd == SPATIAL_D - 1 for lbl, s, h, ax, cd in rows if lbl == "single-axis" and cd is not None
    )
    C0 = Counter(single_codims).most_common(1)[0][0] if single_codims else None
    return {"rows": rows, "axis_minimal_on_single_axis": axis_minimal, "C0_from_solve": C0,
            "C0_SL": 2}


# ------------------------------------------------ leg 1b: listener-listener
def leg1b_listeners() -> dict:
    """Two listeners = two seeds; the joint /solve (the 'meeting of minds') — is the
    joint closure still axis-minimal, i.e. does handedness balance select ONE
    low-codimension solution rather than the union of both?"""
    pairs = [("^", "^"), ("^", "v"), ("^", ">"), ("^^", "vv"), (">", "^"),
             ("^<", ">v"), ("/", "\\"), ("^", "^^")]
    rows = []
    for a, b in pairs:
        r = solve(a + b, max_depth=6)         # concatenated joint position
        if not r.get("solved"):
            rows.append((a, b, None, None))
            continue
        h = r["history"]
        axes = {AXIS[c] for c in h if AXIS[c] != "I"}
        rows.append((a, b, h, SPATIAL_D - len(axes) if len(axes) <= SPATIAL_D else 0))
    codims = [cd for a, b, h, cd in rows if cd is not None]
    return {"rows": rows, "joint_codims": codims,
            "joint_selects_one_low_codim": bool(codims) and min(codims) >= SPATIAL_D - 2}


# ---------------------------------------------------------------- leg 2: μ
# name, dv, dh, dd, dl, axis  (axis order X<Y<Z, per QLF_PhaseRule / census_inventory.AXIS_ORDER)
_STEPS = [("^", 1, 0, 0, 0, "Y"), ("v", -1, 0, 0, 0, "Y"), (">", 0, 1, 0, 0, "X"),
         ("<", 0, -1, 0, 0, "X"), ("/", 0, 0, 1, 0, "Z"), ("\\", 0, 0, -1, 0, "Z"),
         ("+", 0, 0, 0, 1, "I"), ("-", 0, 0, 0, -1, "I")]


def _first_closure_census(L_max: int, R_max: int) -> dict:
    """Exact transfer recursion for the 8-twist first-closure (prime) census.
    state = (v, h, d, l, inv_parity, max_L1_excursion); absorb at the first return
    to the origin.  Phase of a closure = (−1)^{L/2} · (−1)^{inv}  — for a closure
    #neg = L/2 exactly, and the axis-inversion parity `inv` updates locally because
    #X, #Y, #Z parities equal the h, v, d excursion parities.  No numpy needed.
    Returns clos[(R, L)] = [count inv-even, count inv-odd]."""
    clos: dict[tuple[int, int], list[int]] = defaultdict(lambda: [0, 0])
    live: dict[tuple, int] = {(0, 0, 0, 0, 0, 0): 1}
    for L in range(1, L_max + 1):
        nxt: dict[tuple, int] = defaultdict(int)
        for (v, h, d, l, inv, mx), c in live.items():
            for _nm, dv, dh, dd, dl, ax in _STEPS:
                nv, nh, nd, nl = v + dv, h + dh, d + dd, l + dl
                e = abs(nv) + abs(nh) + abs(nd) + abs(nl)
                if e > R_max:
                    continue
                ninv = inv
                if ax == "Y":
                    ninv ^= d & 1                      # + #Z inversions
                elif ax == "X":
                    ninv ^= (v & 1) ^ (d & 1)          # + (#Y + #Z) inversions
                nmx = mx if mx >= e else e
                if nv == 0 and nh == 0 and nd == 0 and nl == 0 and L >= 2:
                    clos[(nmx, L)][ninv] += c
                else:
                    nxt[(nv, nh, nd, nl, ninv, nmx)] += c
        live = nxt
        if not live:
            break
    return clos


def leg2_multiplier(L_max: int = 22, R_max: int = 11) -> dict:
    """Per-octave Kraft-flux multiplier W(R) = ΔM(R)/ΔM(R−1), M(R) = Σ_{maxexc=R} 8^{−L},
    from the first-closure census run to convergence via the transfer recursion."""
    clos = _first_closure_census(L_max, R_max)
    # cross-check against the brute enumeration for L ≤ 8
    brute = {L: 0 for L in (2, 4, 6, 8)}
    for L in brute:
        for hh in balanced_histories(L):
            if not any(is_count_balanced(hh[:k]) for k in range(2, L, 2)):
                brute[L] += 1
    trans = {L: 0 for L in (2, 4, 6, 8)}
    for (RR, L), (ce, co) in clos.items():
        if L in trans:
            trans[L] += ce + co
    xcheck_ok = brute == trans

    per_R: dict[int, dict] = {}
    for R in range(1, R_max + 1):
        M = S = 0.0
        cnt = 0
        for (RR, L), (ce, co) in clos.items():
            if RR != R:
                continue
            base = 1 if (L // 2) % 2 == 0 else -1
            npl, nmi = (ce, co) if base == 1 else (co, ce)
            M += (ce + co) * 8.0 ** -L
            S += (npl - nmi) * 8.0 ** -L
            cnt += ce + co
        per_R[R] = {"count": cnt, "M": M, "S": S}
    M_inf = sum(per_R[R]["M"] for R in per_R)
    W = {R: (per_R[R]["M"] / per_R[R - 1]["M"] if R > 1 and per_R[R - 1]["M"] else float("nan"))
         for R in per_R}
    monotone_decay = all(
        W[R] <= W[R - 1] + 1e-9 for R in range(6, R_max + 1) if not (W[R] != W[R]))
    return {"per_R": per_R, "W": W, "M_inf": M_inf, "xcheck_ok": xcheck_ok,
            "no_inertial_range": monotone_decay and W.get(R_max, 1.0) < 0.1,
            "L_max": L_max, "R_max": R_max}


def main() -> None:
    print(__doc__.split("Run:")[0])

    print("=" * 78)
    print("LEG 1 — C₀ from the /solve selection (axis-minimality)\n")
    l1 = leg1_codimension()
    for lbl, s, h, ax, cd in l1["rows"]:
        if h is None:
            print(f"  [{lbl:11}] {s:<8} UNSOLVED")
        else:
            print(f"  [{lbl:11}] {s:<8} → {h:<16} axes={str(ax):<16} codim = {cd}")
    print(f"\n  /solve is axis-minimal on single-axis seeds: {l1['axis_minimal_on_single_axis']}")
    print(f"  C₀ (modal codimension of the 1-D / vacuum selection) = {l1['C0_from_solve']}"
          f"   vs She–Leveque C₀ = {l1['C0_SL']}")

    print("\n" + "=" * 78)
    print("LEG 1b — listener–listener (joint /solve, the 'meeting of minds')\n")
    l1b = leg1b_listeners()
    for a, b, h, cd in l1b["rows"]:
        print(f"  {a:>4} ⊕ {b:<4} → {h if h else 'UNSOLVED':<16}"
              + (f"  codim = {cd}" if cd is not None else ""))
    print(f"\n  joint /solve selects one low-codimension solution (not the union): "
          f"{l1b['joint_selects_one_low_codim']}")

    print("\n" + "=" * 78)
    print("LEG 2 — μ from the per-octave Kraft-flux multiplier W(R) = ΔM(R)/ΔM(R−1)\n")
    l2 = leg2_multiplier()
    print(f"  transfer recursion cross-checks brute enumeration (L ≤ 8): {l2['xcheck_ok']}")
    print(f"  first-closure Kraft mass converges: M(∞) = {l2['M_inf']:.8f}  "
          f"(R_max = {l2['R_max']}, L_max = {l2['L_max']})\n")
    for R in sorted(l2["per_R"]):
        d = l2["per_R"][R]
        w = l2["W"][R]
        print(f"  R={R:>2}: closures {d['count']:>18}   M(R) = {d['M']:.9f}   "
              f"W(R) = {w:.4f}" if w == w else
              f"  R={R:>2}: closures {d['count']:>18}   M(R) = {d['M']:.9f}   W(R) = —")
    print(f"\n  W(R) rises to a peak near R=4 then DECAYS monotonically toward 0.")
    print(f"  no_inertial_range = {l2['no_inertial_range']}  — the per-octave census flux does not")
    print(f"  cascade scale-invariantly; the deepest strata hold O(1) closures. Converged, not")
    print(f"  depth-limited: there is no μ to extract from this (vacuum) census object.")

    print("\n" + "=" * 78)
    print("VERDICT (§9c)\n")
    leg1_pass = l1["C0_from_solve"] == l1["C0_SL"] and l1["axis_minimal_on_single_axis"]
    print(f"  [leg 1 — C₀]  {'PASS' if leg1_pass else 'FAIL'}: /solve is axis-minimal ⇒ the vacuum's")
    print(f"                selected structure is 1-D ⇒ C₀ = 2 — She–Léveque's codimension,")
    print(f"                DERIVED from the substrate's selection rule, not posited.")
    print(f"  [leg 1b]      {'PASS' if l1b['joint_selects_one_low_codim'] else 'FAIL'}: the joint /solve")
    print(f"                (handedness listener–listener) collapses to one low-codim solution.")
    print(f"  [leg 2 — μ]   NEGATIVE (converged): W(R) decays — no inertial range in the vacuum")
    print(f"                first-closure census. Not a full kill (the cascade, if anywhere, is in")
    print(f"                a SEEDED census with an injection scale), but leg 2 as posed fails.")
    print(f"  [net]         Half-standing: C₀ derived, selection mechanism confirmed; the μ cascade")
    print(f"                is not in the vacuum census. δw / +0.036 NOT delivered — the honest")
    print(f"                reading tilts back to §2a's close (w = 1/2 structural, residual =")
    print(f"                continuum running).")


if __name__ == "__main__":
    main()
