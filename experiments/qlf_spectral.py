#!/usr/bin/env python3
"""
qlf_spectral.py

Empirical verification of the QLF spectral structure:
  1. For all pure-phase strings, toSpectralMode is Hermitian (eigenvalues real).
  2. For symmetric strings (count_pos = count_neg), the spectral mode is a
     scalar multiple of the identity (both eigenvalues equal).

This corresponds to the Lean theorems:
  - toSpectralMode_hermitian      (all strings)
  - spectral_symmetric_eq_scalar_id (pure-phase + symmetric)
"""

import cmath
import itertools


def phase_matrix(phase: str):
    """2×2 projector: pos → |+⟩⟨+|, neg → |−⟩⟨−|."""
    if phase == "pos":
        return [[1 + 0j, 0 + 0j], [0 + 0j, 0 + 0j]]
    else:
        return [[0 + 0j, 0 + 0j], [0 + 0j, 1 + 0j]]


def mat_add(A, B):
    return [[A[i][j] + B[i][j] for j in range(2)] for i in range(2)]


def spectral_mode(string):
    """toSpectralMode: sum of projectors for elements in string."""
    M = [[0 + 0j, 0 + 0j], [0 + 0j, 0 + 0j]]
    for e in string:
        M = mat_add(M, phase_matrix(e))
    return M


def eigenvalues(M):
    """Eigenvalues of 2×2 matrix via characteristic polynomial."""
    a, b, c, d = M[0][0], M[0][1], M[1][0], M[1][1]
    tr = a + d
    det = a * d - b * c
    disc = tr * tr - 4 * det
    sq = cmath.sqrt(disc)
    return (tr + sq) / 2, (tr - sq) / 2


def is_hermitian(M, tol=1e-12):
    for i in range(2):
        for j in range(2):
            if abs(M[i][j] - M[j][i].conjugate()) > tol:
                return False
    return True


def is_scalar_identity(M, tol=1e-12):
    """Check M = c·I: off-diagonals zero, diagonals equal."""
    return (abs(M[0][1]) < tol and abs(M[1][0]) < tol
            and abs(M[1][1] - M[0][0]) < tol)


def label(string):
    return "".join("+" if e == "pos" else "-" for e in string)


# ─── Report ───────────────────────────────────────────────────────────────

COL = 66
print("=" * COL)
print("QLF Spectral Structure — Empirical Verification")
print("=" * COL)
print(f"{'string':>12}  {'cp':>3}  {'cn':>3}  "
      f"{'Herm':>5}  {'λ₁':>8}  {'λ₂':>8}  {'c·I':>5}")
print("-" * COL)

for n in range(1, 7):
    for combo in itertools.product(["pos", "neg"], repeat=n):
        s = list(combo)
        cp = s.count("pos")
        cn = s.count("neg")
        M = spectral_mode(s)
        herm = is_hermitian(M)
        scalar = is_scalar_identity(M)
        l1, l2 = eigenvalues(M)
        sym_marker = " *" if cp == cn else ""
        print(f"  {label(s):>10}  {cp:>3}  {cn:>3}  "
              f"  {'yes' if herm else 'NO':>4}  "
              f"  {l1.real:>5.1f}  {l2.real:>5.1f}  "
              f"  {'yes' if scalar else 'no':>5}{sym_marker}")
    print()

print("=" * COL)
print("Legend: * = symmetric (cp = cn)")
print()
print("Observations:")

# Verify claims across all strings up to length 8
all_herm = True
sym_scalar = True
for n in range(1, 9):
    for combo in itertools.product(["pos", "neg"], repeat=n):
        s = list(combo)
        M = spectral_mode(s)
        if not is_hermitian(M):
            all_herm = False
        if s.count("pos") == s.count("neg") and not is_scalar_identity(M):
            sym_scalar = False

print(f"  All pure-phase strings Hermitian (n=1..8): {'YES' if all_herm else 'FAIL'}")
print(f"  Symmetric strings give scalar·I (n=1..8):  {'YES' if sym_scalar else 'FAIL'}")
print("=" * COL)
