"""
topology_resolver.py

Physics-style filtering over the canonical twist core.
"""

from __future__ import annotations

from typing import Dict, Iterable, List

from twist_core import (
    calculate_action,
    closure_with_adjoint,
    is_admissible_history,
    is_zfa,
)


class TopologyResolver:
    def __init__(self, light_cone_limit: int = 12, min_zfa_length: int = 4):
        self.light_cone_limit = light_cone_limit
        self.min_zfa_length = min_zfa_length

    def measure_net_action(self, history_string: str):
        return calculate_action(history_string)

    def is_zero_free_action(self, history_string: str) -> bool:
        return is_zfa(history_string, min_length=self.min_zfa_length)

    def verify_unitarity(self, history_string: str) -> bool:
        audit = closure_with_adjoint(history_string)
        return (
            audit["history_is_admissible"]
            and audit["adjoint_is_admissible"]
            and audit["cycle_is_zfa"]
        )

    def resolve_bulk(self, candidate_histories: Iterable[str]) -> Dict[str, object]:
        stable_observables: List[str] = []
        dissipated = 0
        contradictions = 0
        inadmissible = 0

        for history in candidate_histories:
            if len(history) > self.light_cone_limit:
                dissipated += 1
                continue

            if not is_admissible_history(history):
                inadmissible += 1
                continue

            if self.is_zero_free_action(history):
                if self.verify_unitarity(history):
                    stable_observables.append(history)
                else:
                    contradictions += 1
            else:
                contradictions += 1

        return {
            "stable_events": stable_observables,
            "dissipated_paths": dissipated,
            "topological_contradictions": contradictions,
            "inadmissible_histories": inadmissible,
        }


if __name__ == "__main__":
    resolver = TopologyResolver(light_cone_limit=10)

    raw_paths = [
        "^<v>",
        "^</+-",
        "^^vv<<>>",
        "^>v<+-\\/-",
        "^<v>^<v>^<v>",
    ]

    results = resolver.resolve_bulk(raw_paths)

    print("Stable events:")
    for event in results["stable_events"]:
        print(f"  {event}")

    print("\nAudit summary:")
    for key, value in results.items():
        if key != "stable_events":
            print(f"  {key}: {value}")
