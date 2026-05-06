"""
SpaceTime.py

Derived spacetime bookkeeping driven by the canonical twist action vector.

This file no longer redefines action independently.  It interprets the same
signed action vector used everywhere else in the refactor.
"""

from __future__ import annotations

from typing import Dict

from twist_core import (
    bound_action_estimate,
    calculate_action,
    local_free_action,
    spatial_free_action,
    validate_history,
)


class SpacetimeGenerator:
    H_CONSTANT = 4.0

    def __init__(self, history_string: str):
        validate_history(history_string)
        self.history = history_string
        self.total_twists = len(history_string)

    def calculate_action_distribution(self):
        action = calculate_action(self.history)
        e_spatial_free = float(spatial_free_action(self.history))
        e_local_free = float(local_free_action(self.history))
        e_bound_total = float(bound_action_estimate(self.history))
        return action, e_spatial_free, e_local_free, e_bound_total

    def generate_space(self, e_spatial_free: float) -> float:
        if e_spatial_free == 0:
            return 0.0
        return e_spatial_free / self.H_CONSTANT

    def generate_time(self, e_local_free: float) -> float:
        if e_local_free <= 0:
            return float("inf")
        return self.H_CONSTANT / e_local_free

    def get_clock_frequency(self, t_interval: float) -> float:
        if t_interval == float("inf"):
            return 0.0
        return 1.0 / t_interval

    def model_spacetime(self) -> Dict[str, object]:
        action, e_spatial_free, e_local_free, e_bound_total = self.calculate_action_distribution()

        x_space = self.generate_space(e_spatial_free)
        t_time = self.generate_time(e_local_free)
        f_clock = self.get_clock_frequency(t_time)

        return {
            "History String": self.history,
            "Total Logical Action": self.total_twists,
            "Canonical Action Vector (v, h, d, l)": action,
            "Spatial Free Action": e_spatial_free,
            "Generated Space (x = E_spatial_free / h)": f"{x_space:.6f}",
            "Local Free Action": e_local_free,
            "Generated Time (t = h / E_local_free)": f"{t_time:.6f}",
            "Clock Frequency": f"{f_clock:.6f}",
            "Estimated Bound Action": e_bound_total,
        }


if __name__ == "__main__":
    print("=== SPACETIME EMERGENCE ===\n")

    photon_string = "^^^^<<<<////"
    photon = SpacetimeGenerator(photon_string)
    print("Photon-like example:")
    for k, v in photon.model_spacetime().items():
        print(f"  {k}: {v}")

    print("\n" + "=" * 60 + "\n")

    fermion_string = "^>v<^>v<//\\\\+-"
    fermion = SpacetimeGenerator(fermion_string)
    print("Closed-loop example:")
    for k, v in fermion.model_spacetime().items():
        print(f"  {k}: {v}")
