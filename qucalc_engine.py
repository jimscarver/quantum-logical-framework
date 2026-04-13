"""
QUCALC ENGINE: canonical possibility generation built on twist_core.py
"""

from __future__ import annotations

from typing import List, Tuple

from twist_core import (
    ALL_TWISTS,
    AXES,
    MIN_ZFA_LENGTH,
    calculate_action,
    generate_histories,
    get_successor_twists,
    is_zfa,
    validate_history,
)


class QuCalcEngine:
    """
    Canonical engine for admissible twist-history generation.

    All branching and action logic comes from twist_core.py.
    """

    AXES = AXES
    ALL_TWISTS = ALL_TWISTS

    def __init__(self, causal_horizon: int = 10, min_zfa_length: int = MIN_ZFA_LENGTH):
        self.causal_horizon = causal_horizon
        self.min_zfa_length = min_zfa_length

    def get_orthogonal_axes(self, last_twist: str) -> List[str]:
        return get_successor_twists(last_twist)

    def calculate_action(self, history: str) -> Tuple[int, int, int, int]:
        return calculate_action(history)

    def is_zfa(self, history: str) -> bool:
        return is_zfa(history, min_length=self.min_zfa_length)

    def generate_possibilities(self, seed_twist: str) -> List[str]:
        validate_history(seed_twist)
        return generate_histories(
            seed_twist,
            causal_horizon=self.causal_horizon,
            require_zfa=True,
            min_length=self.min_zfa_length,
        )


if __name__ == "__main__":
    engine = QuCalcEngine(causal_horizon=6)

    results = engine.generate_possibilities("^")

    print(f"Discovered {len(results)} stable history strings:")
    for event in results:
        print(f"  {event} -> action {engine.calculate_action(event)}")
