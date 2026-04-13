"""
particles.py

Constructive / intuitionistic particle closure on the full 8-twist alphabet.
"""

from __future__ import annotations

from typing import Dict, Optional

from twist_core import action_dict, calculate_action, is_zfa, validate_history


POSITIVE_TO_NEGATIVE = {
    "VERTICAL": "v",
    "HORIZONTAL": ">",
    "DEPTH": "\\",
    "LOCAL": "-",
}

NEGATIVE_TO_POSITIVE = {
    "VERTICAL": "^",
    "HORIZONTAL": "<",
    "DEPTH": "/",
    "LOCAL": "+",
}


class IntuitionisticEngine:
    def __init__(self):
        self.axis_order = ("VERTICAL", "HORIZONTAL", "DEPTH", "LOCAL")

    def evaluate_deficit(self, history: str) -> Dict[str, int]:
        validate_history(history)
        return action_dict(history)

    def _closing_twist_for_axis(self, axis_name: str, deficit: int) -> str:
        if deficit > 0:
            return POSITIVE_TO_NEGATIVE[axis_name]
        if deficit < 0:
            return NEGATIVE_TO_POSITIVE[axis_name]
        raise ValueError("cannot request a closing twist for zero deficit")

    def synthesize_proof(
        self,
        seed: str,
        max_depth: int,
        environment_block: bool = False,
    ) -> Optional[str]:
        """
        Constructively build a ZFA loop.

        Unlike the older file, this version works in the full 8-twist space.
        """
        validate_history(seed)
        current_path = seed

        for _ in range(max_depth):
            deficit = self.evaluate_deficit(current_path)
            if is_zfa(current_path):
                return current_path

            appended = False

            if not environment_block:
                for axis_name in ("VERTICAL", "HORIZONTAL", "DEPTH"):
                    axis_deficit = deficit[axis_name]
                    if axis_deficit != 0:
                        current_path += self._closing_twist_for_axis(axis_name, axis_deficit)
                        appended = True
                        break

            if not appended:
                local_deficit = deficit["LOCAL"]
                if local_deficit != 0:
                    current_path += self._closing_twist_for_axis("LOCAL", local_deficit)
                else:
                    # If space was blocked and no local deficit existed yet,
                    # open a temporary local storage channel.
                    current_path += "-"
                environment_block = False

        return current_path if is_zfa(current_path) else None


if __name__ == "__main__":
    engine = IntuitionisticEngine()

    examples = [
        ("^>", 6, False),
        ("^>/", 8, False),
        ("^>/", 10, True),
    ]
    for seed, depth, blocked in examples:
        result = engine.synthesize_proof(seed=seed, max_depth=depth, environment_block=blocked)
        print(f"seed={seed!r}, blocked={blocked} -> {result}")
        if result:
            print(f"  action={calculate_action(result)}")
