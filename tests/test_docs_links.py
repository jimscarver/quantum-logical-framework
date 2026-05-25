"""Repository documentation link checks."""

from __future__ import annotations

from pathlib import Path

from tools.check_markdown_links import check_links


def test_local_markdown_links_resolve() -> None:
    assert check_links(Path(".")) == []
