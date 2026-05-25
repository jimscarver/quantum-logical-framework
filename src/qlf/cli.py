"""Command-line entry points for small QLF checks."""

from __future__ import annotations

import argparse
from typing import Sequence

from qlf.qucalc_engine import PossibilistEngine, is_zfa_closed
from qlf.twist_core import calculate_action, closure_with_adjoint, is_zfa


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        prog="qlf",
        description="Run small Quantum Logical Framework checks.",
    )
    subparsers = parser.add_subparsers(dest="command")

    action_parser = subparsers.add_parser(
        "action",
        help="Print the signed twist-action vector for a history.",
    )
    action_parser.add_argument("history")

    zfa_parser = subparsers.add_parser(
        "zfa",
        help="Check whether a history is zero-free-action closed.",
    )
    zfa_parser.add_argument("history")
    zfa_parser.add_argument(
        "--min-length",
        type=int,
        default=4,
        help="Minimum stable event length for twist-core ZFA checks.",
    )

    close_parser = subparsers.add_parser(
        "close",
        help="Find a short QuCalc ZFA closure for a prefix.",
    )
    close_parser.add_argument("prefix")

    audit_parser = subparsers.add_parser(
        "audit",
        help="Print the Hermitian adjoint closure audit for a history.",
    )
    audit_parser.add_argument("history")

    return parser


def main(argv: Sequence[str] | None = None) -> int:
    parser = build_parser()
    args = parser.parse_args(argv)

    if args.command is None:
        parser.print_help()
        return 0

    if args.command == "action":
        print(calculate_action(args.history))
        return 0

    if args.command == "zfa":
        twist_core_closed = is_zfa(args.history, min_length=args.min_length)
        pairwise_closed = is_zfa_closed(args.history)
        print(f"twist_core_zfa={twist_core_closed}")
        print(f"pairwise_zfa_closed={pairwise_closed}")
        return 0

    if args.command == "close":
        engine = PossibilistEngine()
        closure = engine.core_engine.find_zfa(args.prefix)
        print(closure if closure is not None else "NO_CLOSURE")
        return 0

    if args.command == "audit":
        for key, value in closure_with_adjoint(args.history).items():
            print(f"{key}: {value}")
        return 0

    parser.error(f"unknown command: {args.command}")
    return 2
