"""
doubler.py

Logical doubler driven by the canonical twist core.

A doubler is defined here as a seed that admits at least two distinct
zero-free-action closures.  The core ZFA criterion remains primitive;
the doubled-mode interpretation is derived.
"""

from __future__ import annotations

from dataclasses import dataclass
from typing import List

from twist_core import generate_histories, is_zfa, validate_history


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
        return min(len(self.closures), 2)


def simulate_qucalc_closures(
    seed_expression: str,
    *,
    light_cone_limit: int = 12,
    max_results: int = 2,
    min_closure_length: int = 8,
) -> QuCalcResult:
    validate_history(seed_expression)

    histories = generate_histories(
        seed_expression,
        causal_horizon=light_cone_limit,
        require_zfa=False,
    )
    closures = [
        history
        for history in histories
        if is_zfa(history, min_length=min_closure_length)
    ][:max_results]

    return QuCalcResult(
        seed=seed_expression,
        closures=closures,
        explored_histories=len(histories),
        light_cone_limit=light_cone_limit,
    )


def construct_logical_doubler(seed_expression: str = "^") -> QuCalcResult:
    return simulate_qucalc_closures(
        seed_expression=seed_expression,
        light_cone_limit=12,
        max_results=2,
        min_closure_length=8,
    )


def format_result(result: QuCalcResult) -> str:
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
            "Two distinct admissible zero-free-action closures were found."
        )
        lines.append(f"QuCalc frequency ratio: {result.logical_frequency_ratio}:1")
    else:
        lines.append("Interpretation: SINGLE MODE / NO DOUBLER")

    return "\n".join(lines)


def main() -> None:
    result = construct_logical_doubler("^")
    print(format_result(result))


if __name__ == "__main__":
    main()
