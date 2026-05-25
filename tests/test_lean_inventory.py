"""Lean inventory guardrails."""

from __future__ import annotations

import re
from pathlib import Path


EXPECTED_ROOTS = {
    "QLF_Axioms",
    "QLF_Combinatorics",
    "QLF_QuCalc",
    "QLF_Universality",
    "QLF_Critical_Line",
    "QLF_Spectral",
    "QLF_Riemann",
    "SpacetimeDynamics",
    "RhoQuCalc",
    "ZFAEventDynamics",
    "AgeOfUniverse",
    "ER_EPR_QLF",
    "PauliExclusion",
    "StringTheoryQLF",
    "MTheoryQLF",
    "BraKetRhoQuCalc",
}


def test_lakefile_roots_match_active_modules() -> None:
    text = Path("lakefile.lean").read_text()
    roots = set(re.findall(r"`([A-Za-z0-9_]+)", text))
    lean_files = {path.stem for path in Path("lean").glob("*.lean")}
    assert roots == EXPECTED_ROOTS
    assert lean_files == EXPECTED_ROOTS


def test_lean_files_have_no_sorry_blocks() -> None:
    for path in Path("lean").glob("*.lean"):
        text = path.read_text()
        assert not re.search(r"\\bsorry\\b", text), f"{path} contains sorry"
