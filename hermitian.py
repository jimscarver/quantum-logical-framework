"""
Hermitian / adjoint closure checks driven by twist_core.py
"""

from __future__ import annotations

from typing import Dict

from twist_core import (
    calculate_action,
    closure_with_adjoint,
    conjugate_history,
    is_admissible_history,
    is_zfa,
)


def get_hermitian_conjugate(history_string: str) -> str:
    return conjugate_history(history_string)


def is_zero_free_action(history_string: str) -> bool:
    return is_zfa(history_string, min_length=0)


def test_hermitian_closure(candidate_event: str) -> Dict[str, object]:
    """
    Return a structured closure audit.

    This is stronger than the old count-only check because it also verifies
    that the history and its adjoint are admissible under the canonical
    successor rule.
    """
    audit = closure_with_adjoint(candidate_event)
    audit["candidate_action"] = calculate_action(candidate_event)
    audit["candidate_is_zfa"] = is_zfa(candidate_event)
    audit["candidate_is_admissible"] = is_admissible_history(candidate_event)
    return audit


if __name__ == "__main__":
    examples = ["^<", "^v", "^<v>", "^/>\\<v+"]
    print("=== Hermitian closure audits ===")
    for example in examples:
        audit = test_hermitian_closure(example)
        print(f"\nCandidate: {audit['history']}")
        print(f"Adjoint:   {audit['adjoint']}")
        print(f"Cycle:     {audit['cycle']}")
        print(f"Action(E): {audit['candidate_action']}")
        print(f"Action(cycle): {audit['cycle_action']}")
        print(f"Admissible(E): {audit['candidate_is_admissible']}")
        print(f"Admissible(E†): {audit['adjoint_is_admissible']}")
        print(f"Cycle ZFA: {audit['cycle_is_zfa']}")
