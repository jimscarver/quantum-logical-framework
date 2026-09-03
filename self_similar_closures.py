#!/usr/bin/env python3
"""
self_similar_closures.py — self-similar ZFA closures, and how many there are.

[`Philosophy.md`](Philosophy.md) §3a: *self-similar things dominate existence* — a
structure that reproduces itself at every scale is reachable every way at every scale,
so its multiplicity is compounded across the whole hierarchy. This script exhibits
concrete self-similar closures and counts the families.

**Self-similar closure** (operational): a twist history `h` that is a prefix of the
fixed point of a **balanced length-doubling substitution** `σ` — `h = σ^k(a)` with
`σ(a)` starting with `a`, every image count-balanced — and is a ZFA closure at every
`k` (count-balanced ∧ Pauli-closed, i.e. `twist_core.is_zfa` modulo the length floor).
Then `h`'s left half is `σ^{k-1}(a)`, again a closure of the identical structure:
exact self-similarity under bisection.

The canonical instance is the **Thue-Morse closure** — `σ(a)=aā`, `σ(ā)=āa` on a
conjugate pair. Its prime factorization (over `{aā, āa}`) is *itself* the Thue-Morse
sequence, so the self-similarity is exact at the free-monoid / bifibration level
(`census_irreducible_resummation`, `G = 1/(1−I)`), not just the string level.

Run:  python3 self_similar_closures.py
"""
from __future__ import annotations

import itertools
from math import comb

from census_inventory import CONJ_PAIRS, fold_phase, is_count_balanced
from qucalc_search import max_excursion


def is_closure(h: str) -> bool:
    return len(h) >= 2 and is_count_balanced(h) and fold_phase(h) is not None


def balanced_blocks(pair: tuple[str, str], m: int) -> list[str]:
    """every length-2m word over the pair with m of each letter."""
    a, b = pair
    out = []
    for pos in itertools.combinations(range(2 * m), m):
        w = [b] * (2 * m)
        for p in pos:
            w[p] = a
        out.append("".join(w))
    return out


def apply_sub(sigma: dict[str, str], seed: str, k: int) -> str:
    h = seed
    for _ in range(k):
        h = "".join(sigma[c] for c in h)
    return h


def primitive(sigma: dict[str, str], letters: list[str]) -> bool:
    n = len(letters)
    M = [[sigma[x].count(y) for x in letters] for y in letters]
    P = [[1 if i == j else 0 for j in range(n)] for i in range(n)]

    def mm(A, B):
        return [[sum(A[i][k] * B[k][j] for k in range(n)) for j in range(n)] for i in range(n)]

    for _ in range(12):
        P = mm(P, M)
        if all(all(x > 0 for x in row) for row in P):
            return True
    return False


def prime_factor_word(h: str) -> list[str]:
    """greedy shortest-closing-prefix factorization (unique for these histories)."""
    factors, rest = [], h
    while rest:
        for j in range(2, len(rest) + 1, 2):
            if is_count_balanced(rest[:j]):
                factors.append(rest[:j])
                rest = rest[j:]
                break
        else:
            factors.append(rest)
            rest = ""
    return factors


def thue_morse_letters(n: int) -> str:
    return "".join("A" if bin(i).count("1") % 2 == 0 else "B" for i in range(n))


def enumerate_families(block_lengths=(1, 2), depth=4):
    """single-pair balanced substitutions whose fixed-point prefixes are all closures."""
    fams = []
    for pair in CONJ_PAIRS:
        a, b = pair
        for m in block_lengths:
            for wa in balanced_blocks(pair, m):
                if wa[0] != a:                     # need σ(a) to start with a (fixed point)
                    continue
                for wb in balanced_blocks(pair, m):
                    sigma = {a: wa, b: wb}
                    seq = [apply_sub(sigma, a, k) for k in range(1, depth + 1)]
                    if not all(is_closure(s) for s in seq):
                        continue
                    kind = "aperiodic" if (primitive(sigma, [a, b]) and wa != wb) else "periodic"
                    fams.append({"pair": pair, "block": 2 * m, "sigma": (wa, wb),
                                 "kind": kind, "seq": seq})
    return fams


def main() -> None:
    fams = enumerate_families()
    ap = [f for f in fams if f["kind"] == "aperiodic"]

    print("=== one self-similar closure ===\n")
    tm = {"+": "+-", "-": "-+"}
    for k in range(1, 6):
        h = apply_sub(tm, "+", k)
        fw = "".join("A" if f == "+-" else "B" for f in prime_factor_word(h))
        print(f"  σ^{k}(+) = {h:<34}  closure={is_closure(h)}  fold={fold_phase(h)}  "
              f"max_excursion={max_excursion(h)}")
        print(f"           prime word = {fw:<20}  Thue-Morse = {thue_morse_letters(len(fw))}  "
              f"({'match' if fw == thue_morse_letters(len(fw)) else 'DIFFER'})")
    print("\n  → the left half of σ^k(+) is σ^{k-1}(+), again a closure of the identical")
    print("    structure — self-similar under bisection, at the string level AND at the")
    print("    prime-factorization (free-monoid / bifibration) level.\n")

    print("=== the same closure on every axis (Thue-Morse block, σ^3) ===\n")
    for pair in CONJ_PAIRS:
        a, b = pair
        s = {a: a + b, b: b + a}
        h = apply_sub(s, a, 3)
        print(f"  pair ({a},{b}):  {h:<12}  closure={is_closure(h)}  fold={fold_phase(h)}  "
              f"exc={max_excursion(h)}")

    print("\n=== how many self-similar closures ===\n")
    print(f"  single-pair balanced substitutions with all-closure fixed points: {len(fams)}")
    print(f"    aperiodic (genuinely fractal): {len(ap)}     periodic: {len(fams) - len(ap)}")
    by_len: dict[int, set] = {}
    for f in ap:
        for s in f["seq"]:
            by_len.setdefault(len(s), set()).add(s)
    print(f"  distinct aperiodic self-similar closures by length: "
          f"{ {L: len(v) for L, v in sorted(by_len.items())} }")

    print("\n  lower bounds on the number of *infinite* self-similar-closure families:")
    tot = 0
    for r in (1, 2, 3, 4):
        c = comb(4, r) * (2 ** r)          # r pairs, TM or mirror-TM on each
        tot += c
        print(f"    Thue-Morse on r={r} of the 4 conjugate pairs: {c}")
    print(f"    total ≥ {tot}, from length-2 substitution blocks alone.")
    print(f"  with block length 2m there are C(2m,m)² balanced substitutions per pair")
    print(f"    (m=1: {comb(2,1)**2}, m=2: {comb(4,2)**2}, m=3: {comb(6,3)**2}, m=4: {comb(8,4)**2}, …) — unbounded.")
    print(f"  and any product of self-similar closures whose *prime word* is self-similar")
    print(f"    (e.g. a Thue-Morse word over any alphabet of primes) is again self-similar.")

    print("\n=== verdict ===")
    print("  Self-similar closures are not rare specimens — every conjugate pair carries an")
    print("  infinite Thue-Morse family (4 axes × {TM, mirror} = 8), multi-axis products add")
    print("  dozens more, and longer substitution blocks make the count unbounded. Each such")
    print("  closure is admitted at the *lowest* capacity its block needs (the Thue-Morse ones")
    print("  at max_excursion = 1), so they are heard at every horizon — the concrete form of")
    print("  'self-similar things dominate existence' (Philosophy.md §3a).")


if __name__ == "__main__":
    main()
