"""Regression tests for documented twist-core invariants."""

from __future__ import annotations

from qlf.qucalc_engine import PossibilistEngine, is_zfa_closed
from qlf.twist_core import (
    adjoint_history,
    calculate_action,
    closure_with_adjoint,
    generate_histories,
    is_zfa,
)


def test_documented_minimal_zfa_history() -> None:
    assert calculate_action("^<v>") == (0, 0, 0, 0)
    assert is_zfa("^<v>")
    assert adjoint_history("^<v>") == "<^>v"


def test_adjoint_cycle_is_zfa() -> None:
    audit = closure_with_adjoint("^<v>")
    assert audit["cycle"] == "^<v><^>v"
    assert audit["cycle_action"] == (0, 0, 0, 0)
    assert audit["cycle_is_zfa"] is True


def test_generator_finds_zfa_histories_from_seed() -> None:
    samples = generate_histories("^<", causal_horizon=6, require_zfa=True)
    assert "^<v>" in samples
    assert all(is_zfa(sample) for sample in samples)


def test_qucalc_engine_finds_pairwise_closed_prefix() -> None:
    engine = PossibilistEngine()
    closure = engine.core_engine.find_zfa("^>")
    assert closure is not None
    assert is_zfa_closed(closure)
