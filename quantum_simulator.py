"""
quantum_simulator.py

Core Pauli folding, double-cover, and energy demo for the
Quantum Logical Framework (QLF).

This module does three concrete things:

1. Represents logical folds by SU(2) spin-1/2 rotation operators built
   from the Pauli matrices.
2. Demonstrates double-cover behavior:
      2π rotation -> -I
      4π rotation -> +I
3. Demonstrates simple two-level energy quantization with a Pauli Hamiltonian.

Interpretive note:
- A "logical fold" is represented here as a spinor rotation in Hilbert space.
- A "zero free action" history is modeled as a closed sequence whose net
  operator is the identity (up to numerical tolerance).
- This is a computable toy core, not a full derivation of all physics.

Dependencies:
    pip install numpy
"""

from __future__ import annotations

from dataclasses import dataclass
from itertools import product
from typing import Dict, Iterable, List, Sequence, Tuple

import numpy as np

# ---------------------------------------------------------------------
# Constants
# ---------------------------------------------------------------------

HBAR = 1.0  # natural units for demo purposes
TOL = 1e-10

# ---------------------------------------------------------------------
# Pauli basis
# ---------------------------------------------------------------------

I2 = np.eye(2, dtype=complex)

SIGMA_X = np.array(
    [
        [0, 1],
        [1, 0],
    ],
    dtype=complex,
)

SIGMA_Y = np.array(
    [
        [0, -1j],
        [1j, 0],
    ],
    dtype=complex,
)

SIGMA_Z = np.array(
    [
        [1, 0],
        [0, -1],
    ],
    dtype=complex,
)

PAULI_BY_AXIS: Dict[str, np.ndarray] = {
    "x": SIGMA_X,
    "y": SIGMA_Y,
    "z": SIGMA_Z,
}


# ---------------------------------------------------------------------
# Fold alphabet
# ---------------------------------------------------------------------
# Minimal physically clear mapping:
#   >  : +x fold
#   <  : -x fold
#   /  : +y fold
#   \  : -y fold
#   ^  : +z fold
#   v  : -z fold
#
# Optional local/temporal markers:
#   +  : +phase fold
#   -  : -phase fold
#
# The phase folds are represented as pure global phases. They are included
# only to preserve your broader alphabet, while the experimentally grounded
# core behavior comes from the Pauli-generated spatial folds.

FOLD_INFO = {
    ">": ("x", +1.0),
    "<": ("x", -1.0),
    "/": ("y", +1.0),
    "\\": ("y", -1.0),
    "^": ("z", +1.0),
    "v": ("z", -1.0),
}

PHASE_FOLDS = {"+": +1.0, "-": -1.0}


# ---------------------------------------------------------------------
# State helpers
# ---------------------------------------------------------------------

def normalize(state: np.ndarray) -> np.ndarray:
    """Return normalized state vector."""
    norm = np.linalg.norm(state)
    if norm < TOL:
        raise ValueError("Cannot normalize near-zero vector.")
    return state / norm


KET_UP = np.array([1.0, 0.0], dtype=complex)
KET_DOWN = np.array([0.0, 1.0], dtype=complex)
KET_PLUS_X = normalize(np.array([1.0, 1.0], dtype=complex))
KET_MINUS_X = normalize(np.array([1.0, -1.0], dtype=complex))
KET_PLUS_Y = normalize(np.array([1.0, 1.0j], dtype=complex))
KET_MINUS_Y = normalize(np.array([1.0, -1.0j], dtype=complex))


# ---------------------------------------------------------------------
# SU(2) rotation machinery
# ---------------------------------------------------------------------

def rotation_operator(axis: str, theta: float, sign: float = +1.0) -> np.ndarray:
    """
    Spin-1/2 rotation:
        U = exp(-i * (sign * theta / 2) * sigma_axis)
          = cos(theta/2) I - i sign sin(theta/2) sigma_axis
    """
    sigma = PAULI_BY_AXIS[axis]
    half = theta / 2.0
    return np.cos(half) * I2 - 1j * sign * np.sin(half) * sigma


def phase_operator(theta: float, sign: float = +1.0) -> np.ndarray:
    """
    Global phase operator.
    Included as a minimal representation of +/- local/temporal fold tags.
    """
    return np.exp(1j * sign * theta) * I2


def fold_operator(symbol: str, theta: float = np.pi) -> np.ndarray:
    """
    Map a fold symbol to its operator.

    Default theta=π means each fold is a half-turn logical action
    in the chosen axis.
    """
    if symbol in FOLD_INFO:
        axis, sign = FOLD_INFO[symbol]
        return rotation_operator(axis, theta, sign)
    if symbol in PHASE_FOLDS:
        return phase_operator(theta / 2.0, PHASE_FOLDS[symbol])

    raise ValueError(f"Unknown fold symbol: {symbol!r}")


def history_operator(history: str, theta: float = np.pi) -> np.ndarray:
    """
    Compose operators left-to-right over the history string.
    """
    U = I2.copy()
    for symbol in history:
        U = fold_operator(symbol, theta) @ U
    return U


def apply_history(state: np.ndarray, history: str, theta: float = np.pi) -> np.ndarray:
    """
    Apply history operator to a state.
    """
    return history_operator(history, theta) @ state


# ---------------------------------------------------------------------
# Zero-free-action / closure
# ---------------------------------------------------------------------

def operator_distance(A: np.ndarray, B: np.ndarray) -> float:
    """Frobenius norm distance."""
    return float(np.linalg.norm(A - B))


def is_identity(U: np.ndarray, tol: float = TOL) -> bool:
    """Check whether U is numerically the identity."""
    return operator_distance(U, I2) < tol


def is_negative_identity(U: np.ndarray, tol: float = TOL) -> bool:
    """Check whether U is numerically -I."""
    return operator_distance(U, -I2) < tol


def zero_free_action_score(history: str, theta: float = np.pi) -> float:
    """
    Distance of the net history operator from identity.
    Lower is better. Zero means exact closure.
    """
    U = history_operator(history, theta)
    return operator_distance(U, I2)


def is_zero_free_action(history: str, theta: float = np.pi, tol: float = TOL) -> bool:
    """
    A toy operational definition:
    the history closes if its net action is identity.
    """
    return zero_free_action_score(history, theta) < tol


# ---------------------------------------------------------------------
# Hermitian-conjugate closure demo
# ---------------------------------------------------------------------

def hermitian_closure_score(history: str, theta: float = np.pi) -> float:
    """
    Check closure under U† U = I for the history operator U.
    For a unitary product this should be near zero.
    """
    U = history_operator(history, theta)
    closed = U.conj().T @ U
    return operator_distance(closed, I2)


# ---------------------------------------------------------------------
# Candidate-history generator
# ---------------------------------------------------------------------

def generate_candidate_histories(
    alphabet: Sequence[str],
    max_length: int,
) -> List[str]:
    """Generate all histories up to max_length."""
    out: List[str] = []
    for length in range(1, max_length + 1):
        out.extend("".join(chars) for chars in product(alphabet, repeat=length))
    return out


def find_zero_free_action_histories(
    alphabet: Sequence[str],
    max_length: int,
    theta: float = np.pi,
    tol: float = TOL,
) -> List[str]:
    """Return all closing histories up to the given length."""
    histories = generate_candidate_histories(alphabet, max_length)
    return [h for h in histories if is_zero_free_action(h, theta=theta, tol=tol)]


# ---------------------------------------------------------------------
# Double-cover demonstration
# ---------------------------------------------------------------------

@dataclass
class DoubleCoverResult:
    axis: str
    theta: float
    operator: np.ndarray
    classification: str


def classify_rotation(U: np.ndarray, tol: float = TOL) -> str:
    if is_identity(U, tol=tol):
        return "+I (identity closure)"
    if is_negative_identity(U, tol=tol):
        return "-I (spinor sign flip)"
    return "nontrivial SU(2) rotation"


def double_cover_demo(axis: str = "z") -> List[DoubleCoverResult]:
    """
    Demonstrate spin-1/2 double cover:
      2π -> -I
      4π -> +I
    """
    results: List[DoubleCoverResult] = []
    for theta in (np.pi, 2 * np.pi, 4 * np.pi):
        U = rotation_operator(axis, theta)
        results.append(
            DoubleCoverResult(
                axis=axis,
                theta=theta,
                operator=U,
                classification=classify_rotation(U),
            )
        )
    return results


# ---------------------------------------------------------------------
# Energy demo
# ---------------------------------------------------------------------

def hamiltonian_z(omega: float) -> np.ndarray:
    """
    Standard two-level Hamiltonian:
        H = (ħ ω / 2) σ_z
    Eigenvalues are ± ħω/2.
    """
    return 0.5 * HBAR * omega * SIGMA_Z


def expectation_value(state: np.ndarray, operator: np.ndarray) -> complex:
    """<psi|A|psi>"""
    psi = normalize(state)
    return np.vdot(psi, operator @ psi)


def energy_demo(omega: float = 1.0) -> List[Tuple[str, complex]]:
    """
    Demonstrate discrete energies for standard spin states under H_z.
    """
    H = hamiltonian_z(omega)
    samples = [
        ("|up>", KET_UP),
        ("|down>", KET_DOWN),
        ("|+x>", KET_PLUS_X),
        ("|-x>", KET_MINUS_X),
        ("|+y>", KET_PLUS_Y),
        ("|-y>", KET_MINUS_Y),
    ]
    return [(name, expectation_value(state, H)) for name, state in samples]


# ---------------------------------------------------------------------
# Pretty-print helpers
# ---------------------------------------------------------------------

def format_complex_matrix(M: np.ndarray, precision: int = 3) -> str:
    rows = []
    for row in M:
        pieces = []
        for value in row:
            pieces.append(f"{value.real:.{precision}f}{value.imag:+.{precision}f}j")
        rows.append("[ " + ", ".join(pieces) + " ]")
    return "\n".join(rows)


def print_section(title: str) -> None:
    print("\n" + "=" * len(title))
    print(title)
    print("=" * len(title))


# ---------------------------------------------------------------------
# Main demo
# ---------------------------------------------------------------------

def run_demo() -> None:
    print_section("Core Pauli Folding Demo")
    seed = KET_UP
    history = "^>v<"
    evolved = apply_history(seed, history)

    print(f"Seed state: |up> = {seed}")
    print(f"History: {history}")
    print("Net operator:")
    print(format_complex_matrix(history_operator(history)))
    print(f"ZFA score: {zero_free_action_score(history):.6e}")
    print(f"Hermitian-closure score: {hermitian_closure_score(history):.6e}")
    print(f"Final state: {evolved}")

    print_section("Double-Cover Demo")
    for result in double_cover_demo("z"):
        print(f"Axis={result.axis}, theta={result.theta:.6f}")
        print(result.classification)
        print(format_complex_matrix(result.operator))
        print()

    print_section("Zero-Free-Action Candidate Histories")
    # Restrict to grounded spatial fold alphabet for the core demo.
    alphabet = [">", "<", "/", "\\", "^", "v"]
    zfa_histories = find_zero_free_action_histories(alphabet, max_length=4)

    if not zfa_histories:
        print("No exact closures found up to length 4.")
    else:
        for h in zfa_histories[:30]:
            print(
                f"{h:>4s}  "
                f"score={zero_free_action_score(h):.3e}  "
                f"adjoint={hermitian_closure_score(h):.3e}"
            )
        if len(zfa_histories) > 30:
            print(f"... {len(zfa_histories) - 30} more")

    print_section("Energy Demo")
    for name, energy in energy_demo(omega=2.0):
        print(f"{name:>6s}  <H> = {energy.real:.6f}{energy.imag:+.6f}j")


if __name__ == "__main__":
    run_demo()
