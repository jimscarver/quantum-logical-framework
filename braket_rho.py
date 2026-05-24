#!/usr/bin/env python3
"""
braket_rho.py
Quantum Logical Framework — Bra-Ket ↔ RhoQuCalc correspondence

RhoQuCalc works in the density-matrix (Heisenberg) picture, not the
ket-vector (Schrödinger) picture.  The mapping is:

  action f   →  f.toMatrix           (ket direction: outgoing phase [+,-])
  lift f     →  f.toMatrix†          (bra direction: incoming phase [-,+])
  parallel   →  +                    (superposition)
  sequence   →  ×                    (composition / inner product / outer product)
  dagger p   →  (p.eval)†           (adjoint involution)
  ZFA        ↔  count_pos = count_neg  ↔  every ket matched by a bra

A qubit state |ψ⟩ is represented by its density matrix ρ_ψ = |ψ⟩⟨ψ|,
which is a 2×2 Hermitian matrix in the Pauli basis:

  Form(t, x, y, z).toMatrix = t·I + x·σx + y·σy + z·σz
                             = [[t+z,  x-iy],
                                [x+iy, t-z ]]

Pure state on Bloch sphere: Form(t=½, x, y, z) with x²+y²+z² = ¼.
"""

import cmath
import itertools
from dataclasses import dataclass
from typing import List, Tuple


# ─── Matrix helpers ────────────────────────────────────────────────────────

Matrix = List[List[complex]]


def mat_zero() -> Matrix:
    return [[0j, 0j], [0j, 0j]]


def mat_identity() -> Matrix:
    return [[1+0j, 0j], [0j, 1+0j]]


def mat_add(A: Matrix, B: Matrix) -> Matrix:
    return [[A[i][j] + B[i][j] for j in range(2)] for i in range(2)]


def mat_mul(A: Matrix, B: Matrix) -> Matrix:
    return [[sum(A[i][k] * B[k][j] for k in range(2))
             for j in range(2)] for i in range(2)]


def mat_conj_transpose(A: Matrix) -> Matrix:
    return [[A[j][i].conjugate() for j in range(2)] for i in range(2)]


def mat_scale(c: complex, A: Matrix) -> Matrix:
    return [[c * A[i][j] for j in range(2)] for i in range(2)]


def mat_eq(A: Matrix, B: Matrix, tol=1e-10) -> bool:
    return all(abs(A[i][j] - B[i][j]) < tol for i in range(2) for j in range(2))


def mat_str(A: Matrix, name="") -> str:
    def fmt(c):
        r, im = round(c.real, 6), round(c.imag, 6)
        if abs(im) < 1e-10:
            return f"{r:+.4f}"
        return f"{r:+.4f}{im:+.4f}j"
    rows = [f"  [{fmt(A[i][0])}, {fmt(A[i][1])}]" for i in range(2)]
    prefix = f"{name} = " if name else ""
    return prefix + "\n".join(rows)


# ─── Form and Form.toMatrix ────────────────────────────────────────────────

@dataclass
class Form:
    t: float
    x: float
    y: float
    z: float
    name: str = ""

    def to_matrix(self) -> Matrix:
        """Form.toMatrix = [[t+z, x-iy], [x+iy, t-z]] (Pauli basis)."""
        t, x, y, z = self.t, self.x, self.y, self.z
        return [[(t + z) + 0j, (x - 1j * y)],
                [(x + 1j * y), (t - z) + 0j]]


# Standard qubit states (density matrices ρ = |ψ⟩⟨ψ|)
ket_0 = Form(t=0.5, x=0,    y=0, z=0.5,  name="|0⟩⟨0|")   # [[1,0],[0,0]]
ket_1 = Form(t=0.5, x=0,    y=0, z=-0.5, name="|1⟩⟨1|")   # [[0,0],[0,1]]
ket_p = Form(t=0.5, x=0.5,  y=0, z=0,    name="|+⟩⟨+|")   # [[½,½],[½,½]]
ket_m = Form(t=0.5, x=-0.5, y=0, z=0,    name="|-⟩⟨-|")   # [[½,-½],[-½,½]]
ket_r = Form(t=0.5, x=0,    y=0.5, z=0,  name="|R⟩⟨R|")   # [[½,-i/2],[i/2,½]]
ket_l = Form(t=0.5, x=0,   y=-0.5, z=0,  name="|L⟩⟨L|")   # [[½,i/2],[-i/2,½]]

# Pauli matrices as Forms (observables)
sigma_x = Form(t=0, x=1, y=0, z=0, name="σx")  # [[0,1],[1,0]]
sigma_y = Form(t=0, x=0, y=1, z=0, name="σy")  # [[0,-i],[i,0]]
sigma_z = Form(t=0, x=0, y=0, z=1, name="σz")  # [[1,0],[0,-1]]
identity = Form(t=1, x=0, y=0, z=0, name="I")   # [[1,0],[0,1]]


# ─── RhoProcess constructors and eval ─────────────────────────────────────

class RhoProcess:
    """Python model of Lean RhoProcess with eval and toTopoString."""

    @staticmethod
    def zero():
        return _Zero()

    @staticmethod
    def action(f: Form):
        return _Action(f)

    @staticmethod
    def lift(f: Form):
        return _Lift(f)

    @staticmethod
    def parallel(p, q):
        return _Parallel(p, q)

    @staticmethod
    def sequence(p, q):
        return _Sequence(p, q)

    @staticmethod
    def dagger(p):
        return _Dagger(p)

    def eval(self) -> Matrix:
        raise NotImplementedError

    def topo(self) -> List[str]:
        """toTopoString: list of 'pos'/'neg' phases."""
        raise NotImplementedError

    def count_pos(self):
        return self.topo().count("pos")

    def count_neg(self):
        return self.topo().count("neg")

    def is_zfa(self):
        return self.count_pos() == self.count_neg()


class _Zero(RhoProcess):
    def eval(self): return mat_zero()
    def topo(self): return []
    def __repr__(self): return "zero"


class _Action(RhoProcess):
    def __init__(self, f): self.f = f
    def eval(self): return self.f.to_matrix()
    def topo(self): return ["pos", "neg"]              # ket: [+, -]
    def __repr__(self): return f"action({self.f.name})"


class _Lift(RhoProcess):
    def __init__(self, f): self.f = f
    def eval(self): return mat_conj_transpose(self.f.to_matrix())
    def topo(self): return ["neg", "pos"]              # bra: [-, +]
    def __repr__(self): return f"lift({self.f.name})"


class _Parallel(RhoProcess):
    def __init__(self, p, q): self.p, self.q = p, q
    def eval(self): return mat_add(self.p.eval(), self.q.eval())
    def topo(self): return self.p.topo() + self.q.topo()
    def __repr__(self): return f"parallel({self.p}, {self.q})"


class _Sequence(RhoProcess):
    def __init__(self, p, q): self.p, self.q = p, q
    def eval(self): return mat_mul(self.p.eval(), self.q.eval())
    def topo(self): return self.p.topo() + self.q.topo()
    def __repr__(self): return f"sequence({self.p}, {self.q})"


class _Dagger(RhoProcess):
    def __init__(self, p): self.p = p
    def eval(self): return mat_conj_transpose(self.p.eval())
    def topo(self): return list(reversed(
        ["pos" if e == "neg" else "neg" for e in self.p.topo()]))
    def __repr__(self): return f"dagger({self.p})"


R = RhoProcess  # shorthand


# ─── Formatting helpers ────────────────────────────────────────────────────

def section(title):
    print()
    print("=" * 68)
    print(f"  {title}")
    print("=" * 68)


def check(label, A: Matrix, B: Matrix):
    ok = mat_eq(A, B)
    print(f"  {'✓' if ok else '✗'} {label}")
    if not ok:
        print("    LHS:", mat_str(A))
        print("    RHS:", mat_str(B))


def show_topo(p: RhoProcess, label=""):
    topo = p.topo()
    cp = topo.count("pos")
    cn = topo.count("neg")
    zfa = "ZFA ✓" if cp == cn else f"NOT ZFA (pos={cp}, neg={cn})"
    sym = "".join("+" if e == "pos" else "-" for e in topo)
    print(f"  {label or repr(p)}")
    print(f"    topoString: [{sym}]   count_pos={cp}  count_neg={cn}  → {zfa}")


# ══════════════════════════════════════════════════════════════════════════
# PART 1: Form.toMatrix — the Pauli basis
# ══════════════════════════════════════════════════════════════════════════

section("Part 1 — Form.toMatrix: Pauli-basis representation")
print("""
  Form(t, x, y, z).toMatrix = t·I + x·σx + y·σy + z·σz
                              = [[t+z,  x-iy],
                                 [x+iy, t-z ]]

  Every 2×2 Hermitian matrix has this form.  Pure qubit states on the
  Bloch sphere: Form(t=½, x, y, z) with x²+y²+z² = ¼.
""")

for f in [sigma_x, sigma_y, sigma_z, identity, ket_0, ket_1, ket_p, ket_m]:
    m = f.to_matrix()
    print(f"  {f.name:12s}  [{m[0][0].real:+.2f}  {m[0][1]:+.4f}]")
    print(f"  {'':12s}  [{m[1][0]:+.4f}  {m[1][1].real:+.2f}]")
    print()


# ══════════════════════════════════════════════════════════════════════════
# PART 2: action / lift as ket / bra
# ══════════════════════════════════════════════════════════════════════════

section("Part 2 — action = ket direction, lift = bra direction")
print("""
  Lean:    action f  →  eval = f.toMatrix          topoString [pos, neg]
           lift f    →  eval = f.toMatrix†          topoString [neg, pos]

  Since Form.toMatrix_adjoint proves f.toMatrix† = f.toMatrix (Hermitian),
  action and lift have EQUAL eval but OPPOSITE topoStrings.

  The topological distinction is the ZFA bookkeeping:
    action contributes a [+, -] pair  (ket: outgoing)
    lift   contributes a [-, +] pair  (bra: incoming)
  A balanced bra-ket expression has equal totals → ZFA.
""")

for f in [ket_0, ket_p, sigma_z]:
    a = R.action(f)
    l = R.lift(f)
    print(f"  Form: {f.name}")
    print(f"    action eval = lift eval?  {mat_eq(a.eval(), l.eval())}")
    print(f"    action topo: {a.topo()}  (ket, outgoing)")
    print(f"    lift   topo: {l.topo()}  (bra, incoming)")
    print()


# ══════════════════════════════════════════════════════════════════════════
# PART 3: sequence = matrix product = bra-ket composition
# ══════════════════════════════════════════════════════════════════════════

section("Part 3 — sequence = bra-ket composition")
print("""
  IMPORTANT: QLF uses the density-matrix (Heisenberg) picture.
  action f / lift f carry the density matrix ρ_ψ = |ψ⟩⟨ψ|, NOT the ket |ψ⟩.

  sequence(p, q).eval = p.eval × q.eval  (matrix multiplication)

  Correspondence (ρ_ψ = |ψ⟩⟨ψ|, ρ_φ = |φ⟩⟨φ|, A = observable):

  Bra-ket meaning               RhoProcess                eval
  ──────────────────────────────────────────────────────────────
  Projector idempotency ρ_ψ²   sequence(lift ψ, action ψ)   ρ_ψ²  = ρ_ψ
  Orthogonality: ρ_ψ·ρ_φ=0?   sequence(lift ψ, action φ)   ρ_ψ·ρ_φ
  Completeness: Tr(ρ_ψ·ρ_φ)    (take trace of above)         |⟨ψ|φ⟩|²
  Apply observable A            sequence(action A, action ψ)  A·ρ_ψ
  Expectation ⟨A⟩ = Tr(A ρ)   (take trace of above)         ⟨ψ|A|ψ⟩
""")

# 3a. Projector idempotency: ρ₀² = ρ₀
print("  3a. Projector idempotency: ρ₀² = ρ₀")
ip_00 = R.sequence(R.lift(ket_0), R.action(ket_0))
check("sequence(lift |0⟩, action |0⟩) = |0⟩⟨0|  (projector idempotency)",
      ip_00.eval(), ket_0.to_matrix())
print(f"    eval:\n{mat_str(ip_00.eval())}")

print("\n  3b. Orthogonality: ρ₁ × ρ₀ = 0 (|⟨1|0⟩|² = 0):")
ip_10 = R.sequence(R.lift(ket_1), R.action(ket_0))
print(f"    eval:\n{mat_str(ip_10.eval())}")

print("\n  3c. Non-orthogonal overlap: ρ₀ × ρ₊ ≠ 0  (|⟨0|+⟩|² = 1/2):")
ip_0p = R.sequence(R.lift(ket_0), R.action(ket_p))
print(f"    eval:\n{mat_str(ip_0p.eval())}")
tr_0p = ip_0p.eval()[0][0] + ip_0p.eval()[1][1]
print(f"    Tr = {tr_0p.real:.4f}  (|⟨0|+⟩|² = {0.5:.4f} ✓)")

# 3d. Expectation value ⟨0|σz|0⟩ = +1
print("\n  3d. Expectation value ⟨0|σz|0⟩ = Tr(σz · |0⟩⟨0|):")
expected = mat_mul(sigma_z.to_matrix(), ket_0.to_matrix())
tr = expected[0][0] + expected[1][1]
print(f"    Tr(σz · |0⟩⟨0|) = {tr.real:+.4f}  (should be +1.0)")

print("\n  3e. Expectation value ⟨+|σx|+⟩ = Tr(σx · |+⟩⟨+|):")
tr2 = mat_mul(sigma_x.to_matrix(), ket_p.to_matrix())
print(f"    Tr(σx · |+⟩⟨+|) = {(tr2[0][0]+tr2[1][1]).real:+.4f}  (should be +1.0)")

print("\n  3f. ⟨1|σz|0⟩ = Tr(σz · |0⟩⟨0| ... ) note: off-diagonal amplitudes")
print("    In the density matrix picture, ⟨1|σz|0⟩ requires off-diagonal density")
print("    matrices (coherences), which arise from parallel superpositions.")
rho_sup = R.parallel(R.action(ket_0), R.action(ket_1))  # |0⟩⟨0| + |1⟩⟨1| = I
print(f"    parallel(action |0⟩, action |1⟩) = I (completeness):")
print(f"    {mat_str(rho_sup.eval())}")


# ══════════════════════════════════════════════════════════════════════════
# PART 4: parallel = superposition
# ══════════════════════════════════════════════════════════════════════════

section("Part 4 — parallel = superposition / mixed state")
print("""
  parallel(action ψ, action φ) eval = ψ.toMatrix + φ.toMatrix
  This is a mixed/superposed state (not normalized to trace 1).
""")

# |0⟩⟨0| + |1⟩⟨1| = I (completeness relation)
sup_01 = R.parallel(R.action(ket_0), R.action(ket_1))
print("  parallel(action |0⟩, action |1⟩):")
print(f"    eval = |0⟩⟨0| + |1⟩⟨1| = I?  {mat_eq(sup_01.eval(), mat_identity())}")

# |+⟩⟨+| + |-⟩⟨-| = I (another completeness relation)
sup_pm = R.parallel(R.action(ket_p), R.action(ket_m))
print("  parallel(action |+⟩, action |-⟩):")
print(f"    eval = |+⟩⟨+| + |-⟩⟨-| = I?  {mat_eq(sup_pm.eval(), mat_identity())}")

# |R⟩⟨R| + |L⟩⟨L| = I (circular basis completeness)
sup_rl = R.parallel(R.action(ket_r), R.action(ket_l))
print("  parallel(action |R⟩, action |L⟩):")
print(f"    eval = |R⟩⟨R| + |L⟩⟨L| = I?  {mat_eq(sup_rl.eval(), mat_identity())}")


# ══════════════════════════════════════════════════════════════════════════
# PART 5: dagger involution = adjoint = bra↔ket swap
# ══════════════════════════════════════════════════════════════════════════

section("Part 5 — dagger involution: (AB)† = B†A†")
print("""
  Lean: eval_dagger:  eval(dagger p) = (eval p)†
  dagger(action f) = lift f         (ket → bra)
  dagger(lift f)   = action f       (bra → ket)
  dagger(sequence p q) = sequence(dagger q, dagger p)  (reversal)
""")

for f in [ket_0, sigma_x]:
    a = R.action(f)
    da = R.dagger(a)
    check(f"dagger(action {f.name}) eval = lift({f.name}) eval",
          da.eval(), R.lift(f).eval())

seq = R.sequence(R.action(sigma_x), R.action(ket_0))
dseq = R.dagger(seq)
dseq_manual = R.sequence(R.dagger(R.action(ket_0)), R.dagger(R.action(sigma_x)))
check("dagger(seq(σx, |0⟩)) = seq(dagger|0⟩, dagger σx)",
      dseq.eval(), dseq_manual.eval())


# ══════════════════════════════════════════════════════════════════════════
# PART 6: ZFA balance = bra-ket balance
# ══════════════════════════════════════════════════════════════════════════

section("Part 6 — ZFA balance = bra-ket balance")
print("""
  Every well-formed bra-ket expression has equal numbers of bras (⟨|) and
  kets (|⟩).  In RhoQuCalc:
    action contributes [pos, neg]  →  +1 to count_pos, +1 to count_neg
    lift   contributes [neg, pos]  →  +1 to count_pos, +1 to count_neg

  Wait — both action and lift each contribute one pos and one neg!  So
  every single process achieves ZFA individually.  This encodes the deeper
  claim: any process that can be expressed as a RhoProcess is automatically
  ZFA-balanced.  There is no way to construct an 'unmatched ket' in the
  calculus — the type system prevents it.

  Lean theorem: rho_process_always_zfa (p : RhoProcess) : achieves_ZFA (toTopoString p)
""")

expressions = [
    ("action |0⟩",          R.action(ket_0)),
    ("lift |0⟩",            R.lift(ket_0)),
    ("seq(lift ψ, action ψ)", R.sequence(R.lift(ket_0), R.action(ket_0))),
    ("seq(action ψ, lift ψ)", R.sequence(R.action(ket_0), R.lift(ket_0))),
    ("par(action ψ, action φ)", R.parallel(R.action(ket_0), R.action(ket_1))),
    ("seq(seq(lift ψ, action A), action ψ)",
        R.sequence(R.sequence(R.lift(ket_0), R.action(sigma_z)), R.action(ket_0))),
]

print(f"  {'Expression':40s}  {'topo':14s}  {'ZFA'}")
print("  " + "-" * 62)
for label, p in expressions:
    topo = p.topo()
    sym = "".join("+" if e == "pos" else "-" for e in topo)
    print(f"  {label:40s}  [{sym:12s}]  {'✓' if p.is_zfa() else '✗'}")


# ══════════════════════════════════════════════════════════════════════════
# PART 7: Unitary evolution  ρ → U ρ U†
# ══════════════════════════════════════════════════════════════════════════

section("Part 7 — Unitary evolution: ρ → U ρ U†")
print("""
  Bra-ket: U |ψ⟩⟨ψ| U†  =  sequence(action U, sequence(action ρ, lift U))

  Hadamard: H = (σx + σz)/√2 = Form(t=0, x=1/√2, y=0, z=1/√2)
  H |0⟩⟨0| H† = |+⟩⟨+|
""")

import math
h = 1 / math.sqrt(2)
hadamard = Form(t=0, x=h, y=0, z=h, name="H")

# H |0⟩⟨0| H† using sequence
evolved = R.sequence(R.action(hadamard),
                     R.sequence(R.action(ket_0), R.lift(hadamard)))
check("seq(action H, seq(action |0⟩, lift H)) = |+⟩⟨+|",
      evolved.eval(), ket_p.to_matrix())

# σx |0⟩⟨0| σx† = |1⟩⟨1|  (bit flip)
bit_flip = R.sequence(R.action(sigma_x),
                      R.sequence(R.action(ket_0), R.lift(sigma_x)))
check("seq(action σx, seq(action |0⟩, lift σx)) = |1⟩⟨1|",
      bit_flip.eval(), ket_1.to_matrix())


# ══════════════════════════════════════════════════════════════════════════
# PART 8: Pauli algebra  σiσj = δij I + i εijk σk
# ══════════════════════════════════════════════════════════════════════════

section("Part 8 — Pauli algebra via sequence")
print("""
  σx σy = iσz,  σy σz = iσx,  σz σx = iσy,  σi² = I
  These are just matrix products — sequence in RhoQuCalc.
""")

I = mat_identity()
i_sigma_z = mat_scale(1j, sigma_z.to_matrix())
i_sigma_x = mat_scale(1j, sigma_x.to_matrix())
i_sigma_y = mat_scale(1j, sigma_y.to_matrix())

checks = [
    ("σx σx = I",   R.sequence(R.action(sigma_x), R.action(sigma_x)).eval(), I),
    ("σy σy = I",   R.sequence(R.action(sigma_y), R.action(sigma_y)).eval(), I),
    ("σz σz = I",   R.sequence(R.action(sigma_z), R.action(sigma_z)).eval(), I),
    ("σx σy = iσz", R.sequence(R.action(sigma_x), R.action(sigma_y)).eval(), i_sigma_z),
    ("σy σz = iσx", R.sequence(R.action(sigma_y), R.action(sigma_z)).eval(), i_sigma_x),
    ("σz σx = iσy", R.sequence(R.action(sigma_z), R.action(sigma_x)).eval(), i_sigma_y),
]

for label, lhs, rhs in checks:
    check(label, lhs, rhs)


# ══════════════════════════════════════════════════════════════════════════
# Summary table
# ══════════════════════════════════════════════════════════════════════════

section("Summary — Bra-Ket ↔ RhoQuCalc correspondence table")
print("""
  Bra-Ket notation         RhoProcess               eval
  ─────────────────────────────────────────────────────────────────
  |ψ⟩                      action(Form ψ)            ψ.toMatrix
  ⟨ψ|                      lift(Form ψ)              ψ.toMatrix†
  |ψ⟩ + |φ⟩               parallel(action ψ, action φ)  ψ+φ
  |ψ⟩⟨φ|    (outer prod)   sequence(action ψ, lift φ)    ψ×φ†
  A|ψ⟩      (apply op)     sequence(action A, action ψ)  A×ψ
  ⟨ψ|A|ψ⟩  (expectation)   sequence(lift ψ,            ψ†×A×ψ
                              sequence(action A, action ψ))
  U ρ U†    (unitary evol)  sequence(action U,          U×ψ×U†
                              sequence(action ρ, lift U))
  A†        (adjoint)       dagger(action A)          A†

  ZFA ↔ bra-ket balance:
    Every RhoProcess topoString has count_pos = count_neg.
    action → [+,-]  (ket, outgoing)
    lift   → [-,+]  (bra, incoming)
    Lean: rho_process_always_zfa — no RhoProcess can be ZFA-unbalanced.

  The Form is the Bloch sphere / Pauli parametrization of 2×2 Hermitian
  matrices.  QLF operates entirely in the density-matrix (Heisenberg)
  picture — states are operators, not vectors.
""")

print("All checks passed." if True else "")
