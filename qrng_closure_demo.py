"""
qrng_closure_demo.py
====================

Companion to QRNG_Closure_Observatory.md.

Demonstrates the ONE thing QLF concretely contributes to a QRNG-anomaly
experiment: a *predeclared* closure sieve (ZFA closure) with an *analytically
known null distribution*. That is what separates a disciplined, falsifiable
test from "the LLM saw a face in the static."

Pipeline:   bits --(3 bits -> 1 of 8 twists)--> twist history --> ZFA closure?

ZFA closure here is the machine-verified predicate from the Lean development:
count balance (signed action vector = 0) AND Pauli closure. As of
`count_balanced_pauli_closed` (QLF_TwistAlphabet.lean) the second is ENTAILED
by the first, so the sieve is a clean, auditable yes/no.

What this script shows:
  1. The EXACT null closure rate p(L) under true randomness (by enumeration) —
     the predeclared baseline a real run is tested against.
  2. A stream scorer + a z-test against that analytic null.
  3. A three-channel scaffold (A=live, B=PRNG, C=shuffled). With no anomaly
     present, all three sit on the null — exactly the expected Tier-0 result.
     A real experiment swaps channel A for hardware QRNG and preregisters.

HONEST SCOPE: this demonstrates the *instrument and its null*, not a claim that
QRNG streams carry any anomalous structure. There is no established mechanism
by which intent biases a QRNG; the expected outcome of a real run is a clean
null. QLF supplies the sieve and the baseline — not a mechanism, not evidence.

Pure Python (uses twist_core.py from this repo). os.urandom stands in for both
"live" and "PRNG" since no hardware QRNG is attached.
"""

import itertools
import os
import math
from twist_core import TWISTS, calculate_action, is_pauli_closed

assert len(TWISTS) == 8, "8-twist alphabet expected"


def bits_to_twists(bits):
    """Map a bit list to twists: every 3 bits -> one of 8 twists (0..7)."""
    out = []
    for i in range(0, len(bits) - 2, 3):
        idx = (bits[i] << 2) | (bits[i + 1] << 1) | bits[i + 2]
        out.append(TWISTS[idx])
    return "".join(out)


def is_zfa_closed(history):
    """ZFA closure: signed action vector zero (count balance) AND Pauli closed.

    Per `count_balanced_pauli_closed`, count balance implies Pauli closure, so
    in practice the first conjunct decides it — we check both for fidelity to
    the runtime definition.
    """
    return all(x == 0 for x in calculate_action(history)) and is_pauli_closed(history)


def null_closure_rate(L):
    """EXACT closure rate over all 8^L equiprobable twist histories of length L.

    This is the predeclared null: the probability a length-L window of a truly
    random stream lands in the ZFA-closure basin. No data, no fitting — it is a
    property of the formal system, computed once.
    """
    closed = 0
    total = 0
    for tup in itertools.product(TWISTS, repeat=L):
        total += 1
        if is_zfa_closed("".join(tup)):
            closed += 1
    return closed, total, closed / total


def random_bits(n):
    """n cryptographic-random bits (os.urandom). Stands in for QRNG/PRNG here."""
    nbytes = (n + 7) // 8
    raw = os.urandom(nbytes)
    bits = []
    for byte in raw:
        for k in range(7, -1, -1):
            bits.append((byte >> k) & 1)
    return bits[:n]


def score_stream(twists, L):
    """Observed closure rate over non-overlapping length-L windows."""
    windows = len(twists) // L
    closed = sum(1 for w in range(windows)
                 if is_zfa_closed(twists[w * L:(w + 1) * L]))
    return closed, windows, (closed / windows if windows else 0.0)


def z_vs_null(closed, windows, p_null):
    """z-score of an observed closure count against the analytic null Binomial."""
    if windows == 0:
        return 0.0
    mu = windows * p_null
    sd = math.sqrt(windows * p_null * (1 - p_null))
    return (closed - mu) / sd if sd > 0 else 0.0


def header(t):
    print("=" * 78)
    print("  " + t)
    print("=" * 78)


def main():
    header("QRNG Closure Observatory — the predeclared sieve and its null")
    print()
    print("  Pipeline:  bits --(3->1 twist)--> history --> ZFA closure?")
    print("  ZFA closure = count balance AND Pauli closure (count_balanced_pauli_closed).")
    print()

    header("1. EXACT null closure rate p(L)  (predeclared baseline, by enumeration)")
    print()
    print(f"  {'L':>3}  {'closed':>8}  {'total 8^L':>11}  {'p(L) null':>12}")
    print(f"  {'-'*3}  {'-'*8}  {'-'*11}  {'-'*12}")
    null = {}
    for L in (2, 3, 4, 5, 6):
        c, n, p = null_closure_rate(L)
        null[L] = p
        print(f"  {L:>3}  {c:>8}  {n:>11}  {p:>11.5%}")
    print()
    print("  (Odd L cannot be count-balanced -> p = 0, as required: each axis")
    print("   pair needs equal counts, so closure only occurs at even length.)")
    print("  This baseline is a property of the formal system, fixed in advance —")
    print("  NOT fitted to any data. That is what makes a deviation meaningful.")
    print()

    L = 6
    p_null = null[L]
    N_WINDOWS = 20000
    n_bits = N_WINDOWS * L * 3 + 8

    header(f"2. Three-channel control scaffold  (window L={L}, {N_WINDOWS} windows)")
    print()
    print(f"  Predeclared null p({L}) = {p_null:.5%}.  Expected closures/run ~ {N_WINDOWS*p_null:.0f}.")
    print()
    print(f"  {'channel':<26}{'closed':>8}{'rate':>10}{'z vs null':>12}")
    print(f"  {'-'*26}{'-'*8}{'-'*10}{'-'*12}")

    # Channel A "live": os.urandom (no hardware QRNG attached — placeholder).
    twA = bits_to_twists(random_bits(n_bits))
    cA, wA, rA = score_stream(twA, L)
    print(f"  {'A: live (urandom*)':<26}{cA:>8}{rA:>9.4%}{z_vs_null(cA, wA, p_null):>12.2f}")

    # Channel B "PRNG control": independent os.urandom draw.
    twB = bits_to_twists(random_bits(n_bits))
    cB, wB, rB = score_stream(twB, L)
    print(f"  {'B: PRNG control':<26}{cB:>8}{rB:>9.4%}{z_vs_null(cB, wB, p_null):>12.2f}")

    # Channel C "shuffled replay": same bits as A, order destroyed.
    bitsA = random_bits(n_bits)
    import random as _r  # stdlib shuffle is fine for a *control* channel
    _r.Random(12345).shuffle(bitsA)
    twC = bits_to_twists(bitsA)
    cC, wC, rC = score_stream(twC, L)
    print(f"  {'C: shuffled replay':<26}{cC:>8}{rC:>9.4%}{z_vs_null(cC, wC, p_null):>12.2f}")
    print()
    print("  * No hardware QRNG is attached, so channel A uses os.urandom — it is")
    print("    NOT a live quantum source here. All three channels therefore sit on")
    print("    the null (|z| a few sigma at most): the expected Tier-0 outcome.")
    print()

    header("3. What a REAL run changes (and what it does not)")
    print()
    print("  Swap channel A for ID-Quantique-class hardware QRNG; preregister L,")
    print("  the closure definition, the intent/event windows, and the decision")
    print("  rule; blind the channel labels; lock timestamps; correct for multiple")
    print("  comparisons.  Then ask ONE preregistered question:")
    print()
    print("    Does the live-QRNG closure rate deviate from p(L) MORE than the")
    print("    PRNG and shuffled controls do, during marked windows vs baseline?")
    print()
    print("  Tier 0 (clean null) is the expected — and still useful — result: a")
    print("  machine-verified instrument that bounds anomalous-RNG claims and")
    print("  doubles as a structure/entropy assay.  Tiers 3-4 (survives blinding +")
    print("  independent replication) would be the 'run that again' line.")
    print()
    print("  QLF supplies the predeclared sieve and the analytic null.")
    print("  It does NOT supply a mechanism, and a passing result here is not")
    print("  asserted or expected.  See QRNG_Closure_Observatory.md sec 'What this is NOT'.")


if __name__ == "__main__":
    main()
