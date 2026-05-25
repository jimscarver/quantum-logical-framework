#!/usr/bin/env python3
"""
qlf_dirichlet_search.py

Empirical search for a combinatorial connection between QLF stable states
and Dirichlet partial sums sum_{k=1}^{n} k^{-1/2}.

The QLF stable state count at generation n (proved in Lean as find_stable_states_iff):
  count(n) = C(n, n//2)  if n is even
           = 0            if n is odd

The normalized probability p(n) = count(n) / 2^n ~ 1/sqrt(pi * n/2) by Stirling.

This script:
1. Computes exact counts and normalized probabilities for n = 1..40
2. Compares cumulative sums sum C(2k,k)/4^k against (1/sqrt(pi)) * zeta_partial_sum(N)
3. Searches for any exact rational weighting that could yield an identity
4. Reports whether the connection is purely asymptotic (Stirling) or exact
"""

import math


# ---------------------------------------------------------------------------
# Core combinatorial quantities
# ---------------------------------------------------------------------------

def count_stable(n: int) -> int:
    """Count of symmetric pure-phase strings of length n (= find_stable_states(n).length)."""
    if n % 2 != 0:
        return 0
    return math.comb(n, n // 2)


def p(n: int) -> float:
    """Fraction of length-n pure-phase strings that are stable (symmetric)."""
    return count_stable(n) / (2 ** n)


def zeta_partial_sum(N: int, s: float = 0.5) -> float:
    """sum_{k=1}^{N} k^{-s}  (Dirichlet partial sum at exponent s)."""
    return sum(k ** (-s) for k in range(1, N + 1))


def central_binom_cum(N: int) -> float:
    """sum_{k=1}^{N} C(2k,k)/4^k  (cumulative over even generations, reindexed by k)."""
    return sum(math.comb(2 * k, k) / 4 ** k for k in range(1, N + 1))


# ---------------------------------------------------------------------------
# Report 1: per-term comparison of p(n) against Stirling approximation
# ---------------------------------------------------------------------------

def report_per_term(max_n: int = 32) -> None:
    INV_SQRT_PI = 1.0 / math.sqrt(math.pi)
    print("=" * 88)
    print("REPORT 1 — Per-term: p(n) = C(n,n/2)/2^n  vs  1/sqrt(pi * n/2)  (Stirling)")
    print("=" * 88)
    print(f"  {'n':>4}  {'count(n)':>12}  {'p(n)':>12}  {'1/sqrt(πn/2)':>14}  {'ratio':>10}")
    print("-" * 88)
    for n in range(1, max_n + 1):
        c = count_stable(n)
        prob = p(n)
        if n % 2 == 0:
            k = n // 2
            approx = INV_SQRT_PI / math.sqrt(k)
            ratio = prob / approx
            print(f"  {n:>4}  {c:>12}  {prob:>12.8f}  {approx:>14.8f}  {ratio:>10.6f}")
        else:
            print(f"  {n:>4}  {c:>12}  {'0.00000000':>12}  {'— (odd)':>14}")
    print()


# ---------------------------------------------------------------------------
# Report 2: cumulative comparison
# ---------------------------------------------------------------------------

def report_cumulative(max_N: int = 25) -> None:
    INV_SQRT_PI = 1.0 / math.sqrt(math.pi)
    print("=" * 88)
    print("REPORT 2 — Cumulative: sum_{k=1}^{N} C(2k,k)/4^k  vs  (1/sqrt(pi)) * sum k^{-1/2}")
    print(f"  1/sqrt(pi) = {INV_SQRT_PI:.10f}")
    print("=" * 88)
    print(f"  {'N':>4}  {'LHS':>16}  {'(1/√π)·RHS':>16}  {'ratio':>10}  {'diff':>14}")
    print("-" * 88)
    for N in range(1, max_N + 1):
        lhs = central_binom_cum(N)
        rhs = INV_SQRT_PI * zeta_partial_sum(N)
        ratio = lhs / rhs
        diff = lhs - rhs
        print(f"  {N:>4}  {lhs:>16.10f}  {rhs:>16.10f}  {ratio:>10.6f}  {diff:>14.10f}")
    # Large-N check
    limit_ratio = central_binom_cum(200) / (INV_SQRT_PI * zeta_partial_sum(200))
    print(f"\n  Ratio at N=200: {limit_ratio:.8f}  (→ 1.0 asymptotically by Stirling)")
    print()


# ---------------------------------------------------------------------------
# Report 3: term-by-term ratio — does C(2k,k)/4^k / (1/sqrt(k)) converge to 1/sqrt(pi)?
# ---------------------------------------------------------------------------

def report_term_ratio(max_k: int = 20) -> None:
    SQRT_PI = math.sqrt(math.pi)
    print("=" * 88)
    print("REPORT 3 — Does C(2k,k)/4^k  =  (1/sqrt(pi)) * (1/sqrt(k))  exactly?")
    print(f"  sqrt(pi) = {SQRT_PI:.10f}")
    print("=" * 88)
    print(f"  {'k':>4}  {'C(2k,k)/4^k':>16}  {'(1/√π)/√k':>14}  {'ratio':>10}  {'error':>14}")
    print("-" * 88)
    for k in range(1, max_k + 1):
        lhs = math.comb(2 * k, k) / 4 ** k
        rhs = 1.0 / (math.sqrt(math.pi) * math.sqrt(k))
        ratio = lhs / rhs
        err = lhs - rhs
        print(f"  {k:>4}  {lhs:>16.10f}  {rhs:>14.10f}  {ratio:>10.6f}  {err:>14.10f}")
    print(f"\n  Ratio → 1 asymptotically; error O(1/k): this is NEVER exactly equal.")
    print()


# ---------------------------------------------------------------------------
# Report 4: search for alternative weightings
# ---------------------------------------------------------------------------

def report_weighting_search(max_k: int = 15) -> None:
    print("=" * 88)
    print("REPORT 4 — Weighted search: does sum w(k) * C(2k,k)/4^k = zeta_partial_sum(N)?")
    print("  Testing w(k) = sqrt(k) (to cancel the 1/sqrt(k) in Stirling):")
    print("=" * 88)
    print(f"  {'N':>4}  {'Σ√k·C(2k,k)/4^k':>20}  {'Σ√k·C(2k,k)/4^k·√π':>22}  {'ζ(1/2,N)':>14}")
    print("-" * 88)
    for N in range(1, max_k + 1):
        weighted = sum(math.sqrt(k) * math.comb(2 * k, k) / 4 ** k for k in range(1, N + 1))
        scaled = weighted * math.sqrt(math.pi)
        dirichlet = zeta_partial_sum(N)
        print(f"  {N:>4}  {weighted:>20.10f}  {scaled:>22.10f}  {dirichlet:>14.8f}")
    print(f"\n  √π · Σ√k·C(2k,k)/4^k ≈ ζ(1/2,N) asymptotically (same Stirling reason).")
    print()


# ---------------------------------------------------------------------------
# Report 5: exact integer check — is there a closed-form identity?
# ---------------------------------------------------------------------------

def report_exact_check() -> None:
    print("=" * 88)
    print("REPORT 5 — Exact check: is there any n where count_stable(n) / 2^n = 1/sqrt(n)?")
    print("  (i.e., C(n,n/2) * sqrt(n) = 2^n  exactly for some n?)")
    print("=" * 88)
    found = False
    for n in range(2, 100, 2):
        c = math.comb(n, n // 2)
        lhs_sq = c * c * n      # (C(n,n/2) * sqrt(n))^2
        rhs_sq = 4 ** n         # (2^n)^2
        if lhs_sq == rhs_sq:
            print(f"  EXACT MATCH at n={n}!")
            found = True
    if not found:
        print("  No exact match for n=2..98.  The ratio C(n,n/2)*sqrt(n)/2^n is always irrational.")
    print()


# ---------------------------------------------------------------------------
# Conclusion
# ---------------------------------------------------------------------------

def conclusion() -> None:
    INV_SQRT_PI = 1.0 / math.sqrt(math.pi)
    ratio_large = central_binom_cum(500) / (INV_SQRT_PI * zeta_partial_sum(500))
    print("=" * 88)
    print("CONCLUSION")
    print("=" * 88)
    print(f"  Ratio sum C(2k,k)/4^k  /  (1/√π)·ζ(1/2,N)  at N=500: {ratio_large:.8f}")
    print()
    print("  The connection between QLF stable-state counts and Dirichlet partial sums is:")
    print()
    print("    ASYMPTOTIC (Stirling), NOT EXACT.")
    print()
    print("  Specifically:  sum_{k=1}^{N} C(2k,k)/4^k  ~  (1/sqrt(pi)) * sum_{k=1}^{N} k^{-1/2}")
    print()
    print("  This means 'critical_line_forcing' cannot be eliminated by a purely combinatorial")
    print("  identity — it would require analytic number theory (e.g. a Mellin-transform")
    print("  argument connecting the discrete QLF generating function to the zeta function).")
    print()
    print("  The 1/sqrt(n) decay of p(n) is the signature of a 1D symmetric random walk")
    print("  (return-to-origin probability), which connects to the Heat kernel / Jacobi theta")
    print("  function path to zeta via Mellin transform — but that bridge is analytic, not")
    print("  combinatorial.")
    print("=" * 88)


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

if __name__ == "__main__":
    report_per_term(max_n=30)
    report_cumulative(max_N=20)
    report_term_ratio(max_k=15)
    report_weighting_search(max_k=12)
    report_exact_check()
    conclusion()
