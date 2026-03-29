"""
doubler.py

Quantum-logical doubler built on a QuCalc-style simulator.

Idea
----
A doubler is not defined here as a classical nonlinear-optics device.
It is defined as a seed expression that admits *two distinct zero-free-action*
closures in the QuCalc search space.

The script explores fold histories breadth-first, using the same directional
alphabet and cancellation logic as the repository's QuCalc notes.  The first
single zero-free-action closure is treated as the base mode.  The first two
independent zero-free-action closures are treated as the doubled mode.

This makes the intended claim explicit:
    one admissible zero-free-action closure  -> base logical mode
    two admissible zero-free-action closures -> doubled logical mode

Usage
-----
    python doubler.py

    === QUCALC LOGICAL DOUBLER RESULT ===
Seed expression: '^'
Histories explored: 31385
Light-cone limit: 12
Zero-free-action closures found: 2
Closure 1: ^<^<v>v>
Closure 2: ^<^>v<v>
Interpretation: DOUBLER
Two distinct zero-free-action closures were found, so the seed supports a doubled logical mode.
QuCalc frequency ratio: 2:1
"""

from __future__ import annotations

from collections import deque
from dataclasses import dataclass
from typing import List, Sequence


# ---------------------------------------------------------------------------
# QuCalc-style primitives
# ---------------------------------------------------------------------------

TWISTS: Sequence[str] = ("^", "v", "<", ">", "/", "\\", "+", "-")


def generate_next_folds(current_sequence: str) -> List[str]:
    """
    Generate successor folds using the repository's QuCalc-style branching rule.

    The final twist determines which orthogonal or local twists can follow.
    This mirrors the conceptual QuCalc.py logic already present in the repo.
    """
    last_twist = current_sequence[-1]

    if last_twist in ("^", "v"):
        return ["<", ">", "/", "\\", "+"]
    if last_twist in ("<", ">"):
        return ["^", "v", "/", "\\", "-"]
    if last_twist in ("/", "\\"):
        return ["^", "v", "<", ">", "+", "-"]

    # last twist is local/temporal: '+' or '-'
    return ["^", "v", "<", ">", "/", "\\"]


def evaluate_free_action(history_string: str, min_half_spin_length: int = 8) -> bool:
    """
    Return True when the history closes to zero free action.

    Zero free action means every directional distinction is balanced by its
    opposite.  The half-spin condition is represented here by requiring at
    least 8 twists, i.e. a full enough loop to represent a doubled closure.
    """
    vertical = history_string.count("^") - history_string.count("v")
    horizontal = history_string.count("<") - history_string.count(">")
    depth = history_string.count("/") - history_string.count("\\")
    local = history_string.count("+") - history_string.count("-")

    is_balanced = vertical == 0 and horizontal == 0 and depth == 0 and local == 0
    is_half_spin = len(history_string) >= min_half_spin_length
    return is_balanced and is_half_spin


@dataclass(frozen=True)
class QuCalcResult:
    seed: str
    closures: List[str]
    explored_histories: int
    light_cone_limit: int

    @property
    def doubled(self) -> bool:
        return len(self.closures) >= 2

    @property
    def logical_frequency_ratio(self) -> int:
        """
        Interpret the number of zero-free-action closures as the logical mode.
        A doubler has ratio 2 because it exhibits two admissible closures.
        """
        return min(len(self.closures), 2)


def simulate_qucalc_closures(
    seed_expression: str,
    *,
    light_cone_limit: int = 12,
    max_results: int = 2,
) -> QuCalcResult:
    """
    Explore the QuCalc search tree breadth-first until zero-free-action
    closures are found.

    Parameters
    ----------
    seed_expression:
        Initial fold string.
    light_cone_limit:
        Maximum history length to explore.
    max_results:
        Maximum number of zero-free-action closures to return.
    """
    if not seed_expression:
        raise ValueError("seed_expression must not be empty")
    if any(ch not in TWISTS for ch in seed_expression):
        raise ValueError(f"seed_expression must use only twists from {TWISTS}")
    if max_results < 1:
        raise ValueError("max_results must be at least 1")

    queue: deque[str] = deque([seed_expression])
    seen = {seed_expression}
    closures: List[str] = []
    explored = 0

    while queue and len(closures) < max_results:
        current = queue.popleft()
        explored += 1

        if len(current) > light_cone_limit:
            continue

        if evaluate_free_action(current):
            closures.append(current)
            continue

        for twist in generate_next_folds(current):
            candidate = current + twist
            if candidate not in seen:
                seen.add(candidate)
                queue.append(candidate)

    return QuCalcResult(
        seed=seed_expression,
        closures=closures,
        explored_histories=explored,
        light_cone_limit=light_cone_limit,
    )


# ---------------------------------------------------------------------------
# Doubler construction
# ---------------------------------------------------------------------------


def construct_logical_doubler(seed_expression: str = "^") -> QuCalcResult:
    """
    Build the logical doubler by asking for the first two zero-free-action
    closures reachable from a seed.

    In this framework, the doubler condition is:
        there exist two distinct admissible zero-free-action closures.
    """
    return simulate_qucalc_closures(
        seed_expression=seed_expression,
        light_cone_limit=12,
        max_results=2,
    )


def format_result(result: QuCalcResult) -> str:
    """Render a compact QuCalc report."""
    lines = [
        "=== QUCALC LOGICAL DOUBLER RESULT ===",
        f"Seed expression: {result.seed!r}",
        f"Histories explored: {result.explored_histories}",
        f"Light-cone limit: {result.light_cone_limit}",
        f"Zero-free-action closures found: {len(result.closures)}",
    ]

    for idx, closure in enumerate(result.closures, start=1):
        lines.append(f"Closure {idx}: {closure}")

    if result.doubled:
        lines.append("Interpretation: DOUBLER")
        lines.append(
            "Two distinct zero-free-action closures were found, so the seed "
            "supports a doubled logical mode."
        )
        lines.append(
            f"QuCalc frequency ratio: {result.logical_frequency_ratio}:1"
        )
    else:
        lines.append("Interpretation: SINGLE MODE / NO DOUBLER")
        lines.append(
            "Fewer than two zero-free-action closures were found inside the "
            "light cone."
        )

    return "\n".join(lines)


def main() -> None:
    result = construct_logical_doubler("^")
    print(format_result(result))


if __name__ == "__main__":
    main()
