"""
quantum_simulator.py

Thin simulator wrapper over the canonical QuCalcEngine.
"""

from __future__ import annotations

from typing import List

from qucalc_engine import QuCalcEngine
from twist_core import calculate_action


class QuCalcSimulator:
    def __init__(self, light_cone_limit: int = 12, min_zfa_length: int = 4):
        self.engine = QuCalcEngine(
            causal_horizon=light_cone_limit,
            min_zfa_length=min_zfa_length,
        )

    def generate_next_folds(self, current_path: str) -> List[str]:
        return self.engine.get_orthogonal_axes(current_path[-1])

    def evaluate_zfa(self, history: str) -> bool:
        return self.engine.is_zfa(history)

    def simulate(self, seed: str) -> List[str]:
        return self.engine.generate_possibilities(seed)

    def action(self, history: str):
        return calculate_action(history)


if __name__ == "__main__":
    sim = QuCalcSimulator(light_cone_limit=8)

    results = sim.simulate(">")

    print(f"Found {len(results)} stable ZFA history strings:")
    for history in results[:10]:
        print(f"  {history} -> action {sim.action(history)}")
