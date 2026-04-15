from __future__ import annotations

"""
magnetism.py

Pure QuCalc demonstration of a minimal magnetic contrast.

This module stays inside the canonical 8-twist QuCalc / QLF rules.
It introduces no SI bridge constants and no probabilistic assumptions.
It reports only native quantities already present in the framework:

- action vectors
- spatial free action
- admissible ZFA closure counts
- closure length statistics
- dimensionless ratios between native quantities

Interpretive idea
-----------------
A two-twist seed such as '^>' is treated as a directed spatial primitive.
A like-oriented pair '^>' with '^>' reinforces the vertical contribution,
while a mixed pair 'v>' with '^>' cancels it. If uncancelled spatial
action is the native proxy for projected distance, then the like pair
projects more distance budget than the mixed pair.
"""

from dataclasses import dataclass
from statistics import mean
from typing import Dict, Iterable, List, Sequence, Tuple


# ---------------------------------------------------------------------------
# Prefer the repo's canonical primitives. Fall back to a local copy so this
# file still runs standalone when tested outside the repository.
# ---------------------------------------------------------------------------
try:  # pragma: no cover - exercised when run inside the repo
    from twist_core import (  # type: ignore
        MIN_ZFA_LENGTH,
        calculate_action,
        generate_histories,
        is_admissible_history,
        is_zfa,
        spatial_free_action,
        validate_history,
    )
except Exception:  # pragma: no cover - standalone fallback
    from collections import deque

    AXES: Dict[str, Tuple[str, str]] = {
        "VERTICAL": ("^", "v"),
        "HORIZONTAL": ("<", ">"),
        "DEPTH": ("/", "\\"),
        "LOCAL": ("+", "-"),
    }
    ALL_TWISTS: Tuple[str, ...] = tuple(
        twist for pair in AXES.values() for twist in pair
    )
    AXIS_FOR_TWIST: Dict[str, str] = {
        twist: axis_name for axis_name, pair in AXES.items() for twist in pair
    }
    MIN_ZFA_LENGTH = 4

    def validate_history(history: str) -> None:
        if not history:
            raise ValueError("history must not be empty")
        invalid = sorted(set(ch for ch in history if ch not in ALL_TWISTS))
        if invalid:
            raise ValueError(
                f"history contains invalid twists {invalid}; "
                f"allowed twists are {list(ALL_TWISTS)}"
            )

    def get_successor_twists(last_twist: str) -> List[str]:
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
        validate_history(history)
        if len(history) < 2:
            return True
        for left, right in zip(history, history[1:]):
            if right not in get_successor_twists(left):
                return False
        return True

    def calculate_action(history: str) -> Tuple[int, int, int, int]:
        validate_history(history)
        return (
            history.count("^") - history.count("v"),
            history.count("<") - history.count(">"),
            history.count("/") - history.count("\\"),
            history.count("+") - history.count("-"),
        )

    def is_zfa(history: str, *, min_length: int = MIN_ZFA_LENGTH) -> bool:
        validate_history(history)
        return len(history) >= min_length and all(v == 0 for v in calculate_action(history))

    def spatial_free_action(history: str) -> int:
        vertical, horizontal, depth, _ = calculate_action(history)
        return abs(vertical) + abs(horizontal) + abs(depth)

    def generate_histories(
        seed: str,
        *,
        causal_horizon: int,
        require_zfa: bool = False,
        min_length: int = MIN_ZFA_LENGTH,
    ) -> List[str]:
        validate_history(seed)
        queue = deque([seed])
        seen = {seed}
        results: List[str] = []
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

            last = current[-1]
            for nxt in get_successor_twists(last):
                extended = current + nxt
                if extended not in seen:
                    seen.add(extended)
                    queue.append(extended)
        return results


# ---------------------------------------------------------------------------
# Native 2D spatial projection used only for readable reporting.
# This follows the repo's MultiParticle.py convention for ^ v < > while
# leaving depth/local twists non-projective in the simple view.
# ---------------------------------------------------------------------------
SPATIAL_MAP: Dict[str, Tuple[int, int]] = {
    "^": (0, 1),
    "v": (0, -1),
    ">": (1, 0),
    "<": (-1, 0),
    "/": (0, 0),
    "\\": (0, 0),
    "+": (0, 0),
    "-": (0, 0),
}


@dataclass(frozen=True)
class MagneticCase:
    name: str
    left_seed: str
    right_seed: str

    @property
    def joint_seed(self) -> str:
        return self.left_seed + self.right_seed


@dataclass
class MagneticReport:
    case: MagneticCase
    joint_seed: str
    action: Tuple[int, int, int, int]
    projected_xy: Tuple[int, int]
    spatial_budget: int
    stable_closure_count: int
    shortest_closure_length: int | None
    mean_closure_length: float | None
    sample_closures: List[str]


def projected_xy(history: str) -> Tuple[int, int]:
    """Simple readable 2D projection for reporting only."""
    validate_history(history)
    x = 0
    y = 0
    for twist in history:
        dx, dy = SPATIAL_MAP[twist]
        x += dx
        y += dy
    return (x, y)


def stable_closures(
    seed: str,
    *,
    causal_horizon: int,
    min_zfa_length: int = MIN_ZFA_LENGTH,
    max_histories: int | None = 256,
) -> List[str]:
    """All admissible ZFA closures extending the seed within the horizon."""
    validate_history(seed)
    closures = generate_histories(
        seed,
        causal_horizon=causal_horizon,
        require_zfa=True,
        min_length=min_zfa_length,
    )
    filtered = [
        hist
        for hist in closures
        if hist.startswith(seed)
        and is_admissible_history(hist)
        and is_zfa(hist, min_length=min_zfa_length)
    ]
    filtered = sorted(set(filtered), key=lambda h: (len(h), h))
    if max_histories is not None:
        return filtered[:max_histories]
    return filtered


def analyze_case(
    case: MagneticCase,
    *,
    causal_horizon: int = 8,
    min_zfa_length: int = MIN_ZFA_LENGTH,
    sample_size: int = 6,
) -> MagneticReport:
    joint = case.joint_seed
    validate_history(joint)
    action = calculate_action(joint)
    closures = stable_closures(
        joint,
        causal_horizon=causal_horizon,
        min_zfa_length=min_zfa_length,
    )
    lengths = [len(hist) for hist in closures]
    return MagneticReport(
        case=case,
        joint_seed=joint,
        action=action,
        projected_xy=projected_xy(joint),
        spatial_budget=spatial_free_action(joint),
        stable_closure_count=len(closures),
        shortest_closure_length=min(lengths) if lengths else None,
        mean_closure_length=mean(lengths) if lengths else None,
        sample_closures=closures[:sample_size],
    )


def ratio(numerator: int | float, denominator: int | float) -> float | None:
    if denominator == 0:
        return None
    return numerator / denominator


def compare_reports(left: MagneticReport, right: MagneticReport) -> Dict[str, float | None]:
    """Dimensionless native ratios only."""
    return {
        "spatial_budget_ratio": ratio(left.spatial_budget, right.spatial_budget),
        "closure_count_ratio": ratio(
            left.stable_closure_count, right.stable_closure_count
        ),
        "shortest_length_ratio": ratio(
            left.shortest_closure_length or 0,
            right.shortest_closure_length or 0,
        ),
    }


def format_report(report: MagneticReport) -> str:
    vertical, horizontal, depth, local = report.action
    lines = [
        f"[{report.case.name}]",
        f"left_seed            : {report.case.left_seed}",
        f"right_seed           : {report.case.right_seed}",
        f"joint_seed           : {report.joint_seed}",
        f"action (V,H,D,L)     : {report.action}",
        f"projected_xy         : {report.projected_xy}",
        f"spatial_budget       : {report.spatial_budget}",
        f"stable_closure_count : {report.stable_closure_count}",
        f"shortest_closure_len : {report.shortest_closure_length}",
        f"mean_closure_len     : {report.mean_closure_length}",
    ]
    if report.sample_closures:
        lines.append("sample_closures      :")
        lines.extend(f"  - {hist}" for hist in report.sample_closures)
    else:
        lines.append("sample_closures      : none within horizon")

    lines.extend(
        [
            "interpretation       :",
            f"  - vertical load = {vertical}",
            f"  - horizontal load = {horizontal}",
            f"  - depth load = {depth}",
            f"  - local load = {local}",
            "  - spatial_budget is the native QuCalc proxy for uncancelled",
            "    spatial action remaining before closure.",
        ]
    )
    return "\n".join(lines)


def demonstrate(causal_horizon: int = 8) -> str:
    same = analyze_case(
        MagneticCase("like pair (^> with ^>)", "^>", "^>"),
        causal_horizon=causal_horizon,
    )
    mixed = analyze_case(
        MagneticCase("mixed pair (v> with ^>)", "v>", "^>"),
        causal_horizon=causal_horizon,
    )
    ratios = compare_reports(same, mixed)

    lines = [
        "Pure QuCalc magnetism demonstration",
        "===================================",
        "",
        "Claim under test:",
        "Magnetism can be represented inside QuCalc as a composite of the",
        "independent vertical twists ^ and v coupled to the horizontal twist >.",
        "",
        format_report(same),
        "",
        format_report(mixed),
        "",
        "Native comparison",
        "-----------------",
        f"spatial_budget_ratio (same/mixed) : {ratios['spatial_budget_ratio']}",
        f"closure_count_ratio (same/mixed)  : {ratios['closure_count_ratio']}",
        f"shortest_len_ratio (same/mixed)   : {ratios['shortest_length_ratio']}",
        "",
        "Minimal conclusion",
        "------------------",
        "1. '^>' + '^>' carries vertical reinforcement: the joint seed '^>^>'",
        "   has action (2, -2, 0, 0), so both vertical and horizontal spatial",
        "   loads remain uncancelled.",
        "2. 'v>' + '^>' cancels the vertical axis at the seed level: the joint",
        "   seed 'v>^>' has action (0, -2, 0, 0).",
        "3. In pure QuCalc terms, the mixed pair preserves the horizontal load",
        "   but removes the vertical contribution.",
        "4. If uncancelled spatial action is the native proxy for projected",
        "   distance, the like pair has twice the spatial budget of the mixed",
        "   pair before closure.",
        "5. This file therefore demonstrates a minimal magnetic contrast without",
        "   introducing any extra force law, probability model, or SI bridge.",
        "",
        "About constants of nature",
        "-------------------------",
        "This module does not derive SI constants. It stays with proven native",
        "QuCalc quantities only. If a future bridge to measured constants is",
        "attempted, it should begin from dimensionless native invariants such as",
        "the ratios reported above, not from newly introduced dimensional",
        "parameters.",
    ]
    return "\n".join(lines)


def main() -> None:
    print(demonstrate())


if __name__ == "__main__":
    main()
