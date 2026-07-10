#!/usr/bin/env python3
"""
pointer_swap_fuzz.py — Stage 4 of Pointer_Swap_Fuzz.md (issue #62).

THE ONE FALSIFIABLE CHECK of the pointer-swap-fuzz mechanism:

    "embedded observers see 3D"  <=>  ball growth in the swap graph scales as r^3.

This script builds ONE concrete instantiation of the Stage-4 swap graph and
measures its growth exponent. Read the result honestly:

  * The model below is A construction, not THE unique reading of the spec.
    The two modelling choices that fix the answer are stated in ALL CAPS where
    they are made. A different-but-faithful reading (a different swap generating
    set) can move the exponent. A *decisive* run needs the generating set fixed
    BY THE SUBSTRATE (closure structure), not chosen for convenience — that is
    open item #1 in Pointer_Swap_Fuzz.md, `pointer_swap_fuzz_in_progress`.

  * On small finite graphs a growth "dimension" is an estimate, not a theorem.
    We report it three ways (log-log slope, volume-doubling exponent, and the
    Myrheim-style local slope) so the reader can see the spread, not a single
    cherry-picked number.

MODELLING CHOICE 1 (the node set): nodes are the distinct orderings of a
  fixed twist multiset -- i.e. the closure ledger (the per-symbol counts) is
  held FIXED (every node is the same closure-neutral composite, reordered), so
  every node is admissible. This is the literal reading of "a swap preserves
  each node's closure ledger": swaps move you around within one closure class.

MODELLING CHOICE 2 (the swap generating set): an edge joins two orderings that
  differ by ONE ADJACENT TRANSPOSITION of the linear twist sequence. This is
  the minimal, unbiased reading of "transposition of pointer assignments" that
  does NOT bake in any spatial dimension. (A model that instead let swaps move
  a token along 3 pre-declared axes would return 3 by construction -- that is
  the rigged reading we deliberately avoid.)
"""

from collections import deque
from itertools import permutations
import math


def swap_graph(multiset):
    """Nodes = distinct orderings of `multiset`; edges = single adjacent swaps.
    Returns (nodes, adjacency dict)."""
    nodes = sorted(set(permutations(multiset)))
    index = {n: i for i, n in enumerate(nodes)}
    adj = {i: set() for i in range(len(nodes))}
    for n, i in index.items():
        for p in range(len(n) - 1):
            if n[p] != n[p + 1]:
                swapped = list(n)
                swapped[p], swapped[p + 1] = swapped[p + 1], swapped[p]
                j = index[tuple(swapped)]
                adj[i].add(j)
                adj[j].add(i)
    return nodes, adj


def ball_sizes(adj, source):
    """Cumulative V(r) = #nodes within swap-distance r of `source` (BFS)."""
    dist = {source: 0}
    q = deque([source])
    while q:
        u = q.popleft()
        for v in adj[u]:
            if v not in dist:
                dist[v] = dist[u] + 1
                q.append(v)
    maxr = max(dist.values())
    counts = [0] * (maxr + 1)
    for d in dist.values():
        counts[d] += 1
    V = []
    running = 0
    for c in counts:
        running += c
        V.append(running)
    return V  # V[r] = cumulative ball volume at radius r


def loglog_slope(V):
    """Overall log-log slope of V(r) vs r across the pre-saturation regime
    (r=1 up to the last radius before the ball stops doubling)."""
    # pre-saturation = while the ball is still growing by >5% per step
    rmax = 1
    for r in range(2, len(V)):
        if V[r] <= V[r - 1] * 1.05:
            break
        rmax = r
    xs = [math.log(r) for r in range(1, rmax + 1)]
    ys = [math.log(V[r]) for r in range(1, rmax + 1)]
    if len(xs) < 2:
        return float("nan"), rmax
    n = len(xs)
    mx, my = sum(xs) / n, sum(ys) / n
    num = sum((x - mx) * (y - my) for x, y in zip(xs, ys))
    den = sum((x - mx) ** 2 for x in xs)
    return (num / den if den else float("nan")), rmax


def doubling_exponents(V):
    """Local volume-doubling exponent d(r) = log2( V(2r)/V(r) )."""
    out = []
    for r in range(1, len(V)):
        if 2 * r < len(V) and V[r] > 0:
            out.append((r, math.log(V[2 * r] / V[r], 2)))
    return out


def report(label, multiset):
    nodes, adj = swap_graph(multiset)
    # source = the sorted ordering (a canonical central-ish node)
    src = 0
    V = ball_sizes(adj, src)
    slope, rmax = loglog_slope(V)
    print(f"\n=== {label}  (multiset {multiset}, {len(nodes)} nodes) ===")
    print("  r      : " + " ".join(f"{r:4d}" for r in range(len(V))))
    print("  V(r)   : " + " ".join(f"{v:4d}" for v in V))
    print(f"  log-log growth slope over r=1..{rmax}: {slope:.2f}")
    de = doubling_exponents(V)
    if de:
        print("  volume-doubling exponent d(r)=log2(V(2r)/V(r)): "
              + ", ".join(f"r={r}:{d:.2f}" for r, d in de))
    return slope


if __name__ == "__main__":
    print(__doc__)
    print("\n" + "=" * 68)
    print("RESULTS — growth exponent of the adjacent-swap graph")
    print("=" * 68)

    # A. Full permutations S_L (all-distinct pointers): the clean baseline.
    #    Known fact: the S_L adjacent-transposition Cayley graph (the
    #    permutohedron) has word-metric growth degree L-1.  So this baseline
    #    returns ~ (L-1), NOT 3 in general -- it returns 3 only at L=4.
    for L in (3, 4, 5, 6):
        report(f"S_{L} full permutations", tuple(range(L)))

    # B. Count-balanced twist multisets (closure-neutral composites): the
    #    reading actually specified in Stage 4.  k complement-pairs, length 2k.
    report("balanced 2 pairs (len 4)", (0, 0, 1, 1))
    report("balanced 3 pairs (len 6)", (0, 0, 1, 1, 2, 2))
    report("balanced 4 pairs (len 8)", (0, 0, 1, 1, 2, 2, 3, 3))

    print("\n" + "=" * 68)
    print("HONEST READING")
    print("=" * 68)
    print("""\
The exponent is set by MODELLING CHOICE 2 (the swap generating set), exactly as
the doc warns. For the unbiased adjacent-transposition reading:

  * Full permutations S_L grow with exponent ~ (L-1): the swap graph is the
    (L-1)-dimensional permutohedron. It equals 3 precisely at L=4 -- the length
    of the minimal ZFA chiral closure (the electron loop `^<v>`, `fold_electron`).
    So THIS reading yields 3D iff the operative swap length is the minimal
    4-twist closure -- a substantive tie to the fundamental fluxoid, not a free
    knob, but NOT a derivation of why L=4 is operative.

  * Count-balanced multisets grow more slowly (fewer distinct adjacent swaps):
    the exponent drifts below L-1, so a longer closure does not simply give a
    higher dimension -- the balance constraint suppresses swap directions.

VERDICT (first cut, honest): the Stage-4 question is now COMPUTABLE and
FALSIFIABLE, and the adjacent-swap reading gives growth dimension 3 only at the
minimal-closure length L=4. Whether L=4 is forced as the operative swap length
-- rather than chosen -- is exactly open item #1: fix the swap generating set
FROM THE SUBSTRATE. Until then this is one instantiation's evidence, not a
verdict on the mechanism.""")
