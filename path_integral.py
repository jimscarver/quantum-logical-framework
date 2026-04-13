"""
path_integral.py

Discrete path amplitudes generated from the canonical QuCalc branching law.
"""

from __future__ import annotations

import cmath
import math
from typing import Dict, Iterable, List

from twist_core import generate_histories, is_zfa, l1_action


class DiscretePathIntegral:
    def __init__(self, action_quantum: float = math.pi / 2):
        self.action_quantum = action_quantum

    def calculate_topological_action(self, history: str) -> int:
        return l1_action(history)

    def compute_amplitude(self, history: str):
        action = self.calculate_topological_action(history)
        phase = action * self.action_quantum
        amplitude = cmath.rect(1.0, phase)
        return amplitude, action

    def generate_candidate_histories(self, seed: str, causal_horizon: int) -> List[str]:
        """
        Use the canonical twist generator instead of hand-supplying paths.
        """
        return generate_histories(seed, causal_horizon=causal_horizon, require_zfa=False)

    def calculate_propagator(self, candidate_histories: Iterable[str]) -> Dict[str, object]:
        total_amplitude = 0j
        classical_paths: List[str] = []
        min_action = float("inf")
        history_count = 0

        for history in candidate_histories:
            amp, action = self.compute_amplitude(history)
            total_amplitude += amp
            history_count += 1

            if action < min_action:
                min_action = action
                classical_paths = [history]
            elif action == min_action:
                classical_paths.append(history)

        if history_count > 0:
            total_amplitude /= history_count

        return {
            "propagator_amplitude": total_amplitude,
            "probability": abs(total_amplitude) ** 2,
            "classical_paths": classical_paths,
            "minimum_action": min_action,
            "history_count": history_count,
            "zfa_classical_paths": [path for path in classical_paths if is_zfa(path)],
        }


if __name__ == "__main__":
    path_integral = DiscretePathIntegral()

    candidate_paths = path_integral.generate_candidate_histories("^", causal_horizon=4)

    print("--- Computing discrete propagator from canonical histories ---")
    results = path_integral.calculate_propagator(candidate_paths)

    amp = results["propagator_amplitude"]
    formatted_amp = f"{amp.real:.4f} + {amp.imag:.4f}j"

    print(f"Total Propagator Amplitude (K): {formatted_amp}")
    print(f"Emergent Probability (|K|^2): {results['probability']:.4f}")
    print(f"Histories Evaluated: {results['history_count']}")
    print(
        f"Classical Paths Identified (minimum action = {results['minimum_action']}):"
    )
    for path in results["classical_paths"][:10]:
        print(f"  {path}")
