"""
twist_core.py

Canonical primitives for the Quantum Logical Framework.

This module is the single source of truth for:
- the 8-twist alphabet
- conjugation / adjoint construction
- admissible successor generation
- topological action measurement
- zero-free-action (ZFA) testing

Everything else in the refactor imports these definitions instead of
re-declaring slightly different versions of the same theory.
"""

from __future__ import annotations

from collections import deque
from typing import Deque, Dict, Iterable, Iterator, List, Sequence, Tuple

AXES: Dict[str, Tuple[str, str]] = {
    "VERTICAL": ("^", "v"),
    "HORIZONTAL": ("<", ">"),
    "DEPTH": ("/", "\\"),
    "LOCAL": ("+", "-"),
}

ALL_TWISTS: Tuple[str, ...] = tuple(twist for pair in AXES.values() for twist in pair)

CONJUGATE_MAP: Dict[str, str] = {
    "^": "v",
    "v": "^",
    "<": ">",
    ">": "<",
    "/": "\\",
    "\\": "/",
    "+": "-",
    "-": "+",
}

AXIS_FOR_TWIST: Dict[str, str] = {
    twist: axis_name for axis_name, pair in AXES.items() for twist in pair
}

MIN_ZFA_LENGTH = 4


def validate_history(history: str) -> None:
    """Raise ValueError when a history contains a non-canonical twist."""
    if not history:
        raise ValueError("history must not be empty")

    invalid = sorted(set(ch for ch in history if ch not in ALL_TWISTS))
    if invalid:
        raise ValueError(
            f"history contains invalid twists {invalid}; "
            f"allowed twists are {list(ALL_TWISTS)}"
        )


def conjugate_history(history: str) -> str:
    """Return the Hermitian-style adjoint: reverse the string and invert twists."""
    validate_history(history)
    return "".join(CONJUGATE_MAP[twist] for twist in reversed(history))


def get_successor_twists(last_twist: str) -> List[str]:
    """
    Canonical branching rule.

    A spatial twist branches only into orthogonal spatial axes plus the local axis.
    A local twist can branch into the full alphabet.
    """
    if last_twist not in ALL_TWISTS:
        raise ValueError(f"invalid twist: {last_twist!r}")

    last_axis = AXIS_FOR_TWIST[last_twist]
    if last_axis == "LOCAL":
        return list(ALL_TWISTS)

    return [
        twist
        for axis_name, pair in AXES.items()
        if axis_name != last_axis
        for twist in pair
    ]


def is_admissible_history(history: str) -> bool:
    """
    Return True when every step in the history respects the canonical branching law.
    """
    validate_history(history)
    if len(history) < 2:
        return True

    for left, right in zip(history, history[1:]):
        if right not in get_successor_twists(left):
            return False
    return True


def calculate_action(history: str) -> Tuple[int, int, int, int]:
    """
    Net topological action across the canonical axes:
    (vertical, horizontal, depth, local)
    """
    validate_history(history)
    return (
        history.count("^") - history.count("v"),
        history.count("<") - history.count(">"),
        history.count("/") - history.count("\\"),
        history.count("+") - history.count("-"),
    )


def action_dict(history: str) -> Dict[str, int]:
    """Action as a named dictionary, using the canonical axis order."""
    vertical, horizontal, depth, local = calculate_action(history)
    return {
        "VERTICAL": vertical,
        "HORIZONTAL": horizontal,
        "DEPTH": depth,
        "LOCAL": local,
    }


def l1_action(history: str) -> int:
    """Manhattan / L1 magnitude of the net action vector."""
    return sum(abs(component) for component in calculate_action(history))


def is_zfa(history: str, *, min_length: int = MIN_ZFA_LENGTH) -> bool:
    """Return True when every axis cancels and the history is long enough."""
    validate_history(history)
    return len(history) >= min_length and all(v == 0 for v in calculate_action(history))


def spatial_free_action(history: str) -> int:
    """Absolute imbalance in the three spatial axes."""
    vertical, horizontal, depth, _ = calculate_action(history)
    return abs(vertical) + abs(horizontal) + abs(depth)


def local_free_action(history: str) -> int:
    """Absolute imbalance in the local / gauge axis."""
    _, _, _, local = calculate_action(history)
    return abs(local)


def bound_action_estimate(history: str) -> int:
    """
    Simple derived quantity used by higher-level demos.

    Bound action is everything not expressed as residual free imbalance.
    """
    validate_history(history)
    return len(history) - l1_action(history)


def extend_history(history: str) -> Iterator[str]:
    """Yield all admissible one-step extensions of a history."""
    validate_history(history)
    for twist in get_successor_twists(history[-1]):
        yield history + twist


def generate_histories(
    seed: str,
    *,
    causal_horizon: int,
    require_zfa: bool = False,
    min_length: int = MIN_ZFA_LENGTH,
) -> List[str]:
    """
    Breadth-first generation from the canonical branching law.

    When require_zfa=True, only stable closures are returned.
    Otherwise all explored histories up to the horizon are returned.
    """
    validate_history(seed)

    queue: Deque[str] = deque([seed])
    results: List[str] = []
    seen = {seed}

    while queue:
        current = queue.popleft()

        if require_zfa:
            if is_zfa(current, min_length=min_length):
                results.append(current)
                continue
        else:
            results.append(current)

        if len(current) >= causal_horizon:
            continue

        for nxt in extend_history(current):
            if nxt not in seen:
                seen.add(nxt)
                queue.append(nxt)

    return results


def closure_with_adjoint(history: str) -> Dict[str, object]:
    """
    Stronger closure audit than a raw count test.

    We verify:
    - the history is canonical
    - the history itself is admissible
    - its adjoint is canonical
    - the concatenated cycle closes to ZFA
    """
    validate_history(history)
    adjoint = conjugate_history(history)
    cycle = history + adjoint
    return {
        "history": history,
        "adjoint": adjoint,
        "cycle": cycle,
        "history_is_admissible": is_admissible_history(history),
        "adjoint_is_admissible": is_admissible_history(adjoint),
        "cycle_action": calculate_action(cycle),
        "cycle_is_zfa": is_zfa(cycle, min_length=0),
    }
