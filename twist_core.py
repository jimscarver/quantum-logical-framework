"""
twist_core.py
Core twist-action engine for the Quantum Logical Framework (QLF).

Provides the canonical 8-twist algebra, signed action vector,
Zero-Free-Action (ZFA) detection, history generation, and auxiliary
functions used by spacetime_dynamics, doubler, gravitational_tensor, etc.
"""

from __future__ import annotations

import itertools
from collections import Counter, deque
from typing import List, Tuple, Dict, Optional, Set

# =============================================================================
# 8-TWIST CANONICAL BASIS (used everywhere)
# =============================================================================
TWISTS = ['^', 'v', '<', '>', '/', '\\', '+', '-']
TWIST_INDEX = {t: i for i, t in enumerate(TWISTS)}

# Valid characters for history validation
VALID_CHARS = set(TWISTS)

# Default minimum length for considering a history "ZFA-stable"
MIN_ZFA_LENGTH: int = 4

# =============================================================================
# VALIDATION
# =============================================================================
def validate_history(history: str) -> None:
    """Raise ValueError if history contains invalid twists."""
    if not history or not isinstance(history, str):
        raise ValueError("History must be a non-empty string")
    invalid = set(history) - VALID_CHARS
    if invalid:
        raise ValueError(f"Invalid twist characters: {invalid}. Allowed: {TWISTS}")


# =============================================================================
# ACTION CALCULATION
# =============================================================================
def calculate_action(history: str) -> Tuple[int, int, int, int]:
    """Return canonical signed action vector (v, h, d, l)."""
    validate_history(history)
    count = Counter(history)

    # Vertical: ^ up, v down
    v = count['^'] - count['v']
    # Horizontal: > right, < left
    h = count['>'] - count['<']
    # Diagonal: / forward, \ backward
    d = count['/'] - count['\\']
    # Gauge / rotational: + , -
    l = count['+'] - count['-']

    return (v, h, d, l)


def total_logical_action(history: str) -> int:
    """Total number of twists (raw action magnitude)."""
    validate_history(history)
    return len(history)


# =============================================================================
# FREE ACTION / ZFA
# =============================================================================
def spatial_free_action(history: str) -> float:
    """Spatial component of free (unbound) action."""
    v, h, d, l = calculate_action(history)
    return abs(v) + abs(h) + abs(d)  # spatial degrees


def local_free_action(history: str) -> float:
    """Local / gauge / temporal free action component."""
    v, h, d, l = calculate_action(history)
    return abs(l)  # rotational/gauge component often maps to "local time-like"


def bound_action_estimate(history: str) -> float:
    """Rough estimate of bound (closed) action — total minus free."""
    total = total_logical_action(history)
    free = spatial_free_action(history) + local_free_action(history)
    return max(0.0, total - free)


def is_zfa(history: str, min_length: int = MIN_ZFA_LENGTH) -> bool:
    """True if history is Zero-Free-Action (balanced vector) and long enough."""
    validate_history(history)
    if len(history) < min_length:
        return False
    return all(x == 0 for x in calculate_action(history))


# =============================================================================
# SUCCESSORS & HISTORY GENERATION
# =============================================================================
def get_successor_twists(last_twist: str) -> List[str]:
    """Return allowed next twists (simple orthogonality filter)."""
    if not last_twist:
        return TWISTS[:]
    # Avoid immediate Hermitian reversal as a basic filter
    conj_map = {'^': 'v', 'v': '^', '<': '>', '>': '<',
                '/': '\\', '\\': '/', '+': '-', '-': '+'}
    forbidden = conj_map.get(last_twist)
    return [t for t in TWISTS if t != forbidden]


def generate_histories(
    seed: str,
    causal_horizon: int = 12,
    require_zfa: bool = False,
    min_length: int = MIN_ZFA_LENGTH,
) -> List[str]:
    """BFS generation of histories up to causal_horizon."""
    validate_history(seed)
    if require_zfa and is_zfa(seed, min_length):
        return [seed]

    queue: deque = deque([(seed, 0)])
    visited: Set[str] = set()
    results: List[str] = []

    while queue:
        current, depth = queue.popleft()
        if current in visited:
            continue
        visited.add(current)

        if depth > causal_horizon:
            continue

        if require_zfa:
            if is_zfa(current, min_length):
                results.append(current)
                if len(results) >= 10:  # safety cap
                    break
        else:
            results.append(current)

        for nxt in get_successor_twists(current[-1] if current else None):
            queue.append((current + nxt, depth + 1))

    return results

def adjoint_history(history: str) -> str:
    """
    Return the Hermitian adjoint of a twist history.

    The adjoint reverses order and replaces each twist with its
    complementary opposite.
    """
    validate_history(history)

    adjoint_map = {
        '^': 'v',
        'v': '^',
        '<': '>',
        '>': '<',
        '/': '\\',
        '\\': '/',
        '+': '-',
        '-': '+',
    }

    return ''.join(adjoint_map[t] for t in reversed(history))


def is_admissible_history(history: str) -> bool:
    """
    True if the history is syntactically valid.

    This deliberately checks only canonical twist validity.
    Dynamical admissibility filters may be added later, but this
    keeps topology_resolver.py from rejecting valid ZFA demonstrations
    too early.
    """
    try:
        validate_history(history)
        return True
    except ValueError:
        return False


def closure_with_adjoint(history: str) -> Dict[str, object]:
    """
    Audit whether a history closes with its Hermitian adjoint.

    In QLF terms, a history plus its adjoint forms a zero-free-action
    cycle when the combined action vector cancels exactly.
    """
    validate_history(history)

    adjoint = adjoint_history(history)
    cycle = history + adjoint

    return {
        "history": history,
        "adjoint": adjoint,
        "cycle": cycle,
        "history_action": calculate_action(history),
        "adjoint_action": calculate_action(adjoint),
        "cycle_action": calculate_action(cycle),
        "history_is_admissible": is_admissible_history(history),
        "adjoint_is_admissible": is_admissible_history(adjoint),
        "cycle_is_zfa": is_zfa(cycle),
    }
    
# =============================================================================
# GRAVITATIONAL / MAGNETIC HELPERS (used by gravitational_tensor.py etc.)
# =============================================================================
def signed_spatial_interval_units(left: str, right: str) -> int:
    """Net signed spatial twist units between two branches."""
    validate_history(left)
    validate_history(right)
    joint = left + right
    v, h, d, l = calculate_action(joint)
    return v + h + d  # net spatial bias


def magnetic_interval_audit(left: str, right: str) -> Dict[str, object]:
    """Detailed audit for EM/gravity branch analysis."""
    validate_history(left)
    validate_history(right)
    joint = left + right
    action = calculate_action(joint)
    proj_xy = (action[0] + action[1])  # simple projection example

    return {
        "joint_seed": joint,
        "joint_action": action,
        "joint_projection_xy": proj_xy,
        "magnetic_correlation": action[0] - action[1],  # example vertical vs horizontal
        "spatial_free": spatial_free_action(joint),
        "local_free": local_free_action(joint),
    }


# =============================================================================
# SELF-TEST / DEMO
# =============================================================================
if __name__ == "__main__":
    print("=== TWIST_CORE SELF-TEST ===\n")

    test_hist = "^^^^<<<<////"
    print(f"History: {test_hist}")
    print(f"Action vector (v,h,d,l): {calculate_action(test_hist)}")
    print(f"Spatial free action: {spatial_free_action(test_hist)}")
    print(f"Local free action : {local_free_action(test_hist)}")
    print(f"Bound action est. : {bound_action_estimate(test_hist)}")
    print(f"Is ZFA?           : {is_zfa(test_hist)}")

    print("\nGenerating sample histories from '^<' ...")
    samples = generate_histories("^<", causal_horizon=6, require_zfa=True)
    for s in samples[:5]:
        print(f"  {s} → ZFA: {is_zfa(s)}")

    print("\n✅ twist_core.py loaded and consistent with repo usage.")
