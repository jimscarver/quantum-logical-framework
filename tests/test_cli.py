"""CLI smoke tests."""

from __future__ import annotations

import subprocess
import sys
import os
from pathlib import Path


def run_cli(*args: str) -> subprocess.CompletedProcess[str]:
    root = Path(__file__).resolve().parents[1]
    env = os.environ.copy()
    env["PYTHONPATH"] = os.pathsep.join(
        [str(root / "src"), str(root), env.get("PYTHONPATH", "")]
    )
    return subprocess.run(
        [sys.executable, "-m", "qlf", *args],
        check=False,
        text=True,
        capture_output=True,
        env=env,
    )


def test_cli_help() -> None:
    result = run_cli("--help")
    assert result.returncode == 0
    assert "Run small Quantum Logical Framework checks." in result.stdout


def test_cli_action() -> None:
    result = run_cli("action", "^<v>")
    assert result.returncode == 0
    assert "(0, 0, 0, 0)" in result.stdout


def test_cli_zfa() -> None:
    result = run_cli("zfa", "^<v>")
    assert result.returncode == 0
    assert "twist_core_zfa=True" in result.stdout
    assert "pairwise_zfa_closed=True" in result.stdout
