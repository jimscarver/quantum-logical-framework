#!/usr/bin/env python3
"""Check local Markdown links in the repository."""

from __future__ import annotations

import argparse
import re
import sys
import urllib.parse
from pathlib import Path

LINK_RE = re.compile(r"!?\[[^\]]*\]\(([^)]+)\)")


def iter_markdown_files(root: Path):
    for path in sorted(root.rglob("*.md")):
        if any(part in {".git", ".lake", ".venv", "venv", "env"} for part in path.parts):
            continue
        if any(part.endswith(".egg-info") for part in path.parts):
            continue
        yield path


def is_external(target: str) -> bool:
    return target.startswith(("http://", "https://", "mailto:", "app://"))


def normalize_target(raw_target: str) -> tuple[str, str] | None:
    target = raw_target.strip()
    if not target or target.startswith("#") or is_external(target):
        return None
    if target.startswith("<") and target.endswith(">"):
        target = target[1:-1]
    path_part, sep, anchor = target.partition("#")
    if not path_part:
        return None
    return urllib.parse.unquote(path_part), sep + anchor if sep else ""


def check_links(root: Path) -> list[str]:
    failures: list[str] = []
    for md_path in iter_markdown_files(root):
        text = md_path.read_text(encoding="utf-8", errors="ignore")
        for line_number, line in enumerate(text.splitlines(), 1):
            for match in LINK_RE.finditer(line):
                parsed = normalize_target(match.group(1))
                if parsed is None:
                    continue
                target, _anchor = parsed
                resolved = (md_path.parent / target).resolve()
                try:
                    resolved.relative_to(root.resolve())
                except ValueError:
                    failures.append(f"{md_path}:{line_number}: outside repo: {target}")
                    continue
                if not resolved.exists():
                    failures.append(f"{md_path}:{line_number}: missing: {target}")
    return failures


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("root", nargs="?", default=".", help="Repository root")
    args = parser.parse_args(argv)

    failures = check_links(Path(args.root).resolve())
    if failures:
        print("\\n".join(failures))
        return 1
    print("All local Markdown links resolve.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
