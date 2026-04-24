"""
particles.py
Quantum Logical Framework (QLF) – Particles as Primordial Quantum Black Holes

Updated to match the current QuCalc / RhoQuCalc architecture while preserving
the primordial-black-hole interpretation.
"""

from __future__ import annotations

import argparse
from dataclasses import dataclass, field
from typing import Dict, List, Optional, Any

from qucalc_engine import (
    PossibilistEngine,
    compute_imbalance,
    hermitian_conjugate,
    is_zfa_closed,
)

try:
    from rho_transpiler import execute_rho
except Exception:
    execute_rho = None


@dataclass
class VacuumEcology:
    baseline_density: float = 0.0
    resolved_histories: List[str] = field(default_factory=list)

    def absorb(self, closed_history: str) -> None:
        self.baseline_density += 1.0
        self.resolved_histories.append(closed_history)


@dataclass
class ParticleRecord:
    label: str
    prefix: str
    closure_name: Optional[str]
    combined_history: Optional[str]
    shortest_closure: Optional[str]
    final_history: Optional[str]
    is_zfa: bool
    imbalance: Optional[tuple]
    hermitian: Optional[str]
    interpretation: str


class PrimordialBlackHoleParticle:
    """Interpret a particle as a dense knot of unresolved free action."""

    def __init__(
        self,
        prefix: str,
        label: str = "particle",
        closure_name: Optional[str] = None,
        engine: Optional[PossibilistEngine] = None,
    ) -> None:
        self.prefix = prefix
        self.label = label
        self.closure_name = closure_name
        self.engine = engine or PossibilistEngine()

    def resolve(self) -> ParticleRecord:
        combined_history: Optional[str] = None
        shortest_closure: Optional[str] = None
        final_history: Optional[str] = None

        if self.closure_name:
            combined_history = self.engine.ApplyZfa(self.prefix, self.closure_name)

        if combined_history and is_zfa_closed(combined_history):
            final_history = combined_history
        elif combined_history:
            shortest_closure = self.engine.core_engine.find_zfa(combined_history)
            final_history = shortest_closure
        else:
            shortest_closure = self.engine.core_engine.find_zfa(self.prefix)
            final_history = shortest_closure

        is_closed = bool(final_history and is_zfa_closed(final_history))
        imbalance = compute_imbalance(final_history) if final_history else None
        hermitian = hermitian_conjugate(final_history) if final_history else None

        if is_closed:
            interpretation = (
                "Primordial quantum black hole successfully gauge-folded into "
                "a stable ZFA particle closure."
            )
        else:
            interpretation = (
                "Candidate remains unresolved free action; no admissible closure "
                "was found within the current engine constraints."
            )

        return ParticleRecord(
            label=self.label,
            prefix=self.prefix,
            closure_name=self.closure_name,
            combined_history=combined_history,
            shortest_closure=shortest_closure,
            final_history=final_history,
            is_zfa=is_closed,
            imbalance=imbalance,
            hermitian=hermitian,
            interpretation=interpretation,
        )


PARTICLE_LIBRARY: Dict[str, Dict[str, str]] = {
    "electron": {
        "prefix": "^<",
        "closure_name": "ZFA_MIN_SQUARE_CCW",
        "note": "Minimal spatial closure; electron-like pedagogical example.",
    },
    "positron": {
        "prefix": "v>",
        "closure_name": "ZFA_MIN_SQUARE",
        "note": "Conjugate-oriented minimal spatial closure.",
    },
    "neutrino": {
        "prefix": "^-",
        "closure_name": "ZFA_GAUGE_LOOP",
        "note": "Gauge-dominant pedagogical example.",
    },
    "fluxoid": {
        "prefix": "^>/+",
        "closure_name": "ZFA_FLUXOID",
        "note": "Composite particle-like closure from the catalog.",
    },
}


def resolve_rho_process(rho_code: str) -> Dict[str, Any]:
    if execute_rho is None:
        return {
            "status": "unavailable",
            "reason": "rho_transpiler.execute_rho could not be imported",
        }
    return execute_rho(rho_code)


def print_particle_record(record: ParticleRecord, verbose: bool = False) -> None:
    print(f"\n=== {record.label.upper()} ===")
    print(f"open prefix         : {record.prefix}")
    print(f"catalog closure     : {record.closure_name}")
    if record.combined_history is not None:
        print(f"ApplyZfa result     : {record.combined_history}")
    if record.shortest_closure is not None:
        print(f"engine closure      : {record.shortest_closure}")
    print(f"final history       : {record.final_history}")
    print(f"ZFA closed          : {record.is_zfa}")
    print(f"hermitian conjugate : {record.hermitian}")
    print(f"interpretation      : {record.interpretation}")

    if verbose:
        print(f"imbalance tuple     : {record.imbalance}")


def print_catalog(engine: PossibilistEngine) -> None:
    print("Registered ZFA closures:")
    for name in sorted(engine.catalog._catalog.keys()):
        print(f"  - {name}: {engine.catalog.get_by_name(name)}")


def run_demo(args: argparse.Namespace) -> None:
    engine = PossibilistEngine()
    vacuum = VacuumEcology()

    print("============================================================")
    print("QLF PARTICLE ENGINE: PRIMORDIAL QUANTUM BLACK HOLE DEMO")
    print("============================================================")
    print("A particle is treated here as a dense knot of unresolved free")
    print("action that stabilizes only by QuCalc / RhoQuCalc ZFA closure.")
    print("============================================================")

    if args.show_catalog:
        print_catalog(engine)
        print("============================================================")

    if args.rho:
        print(resolve_rho_process(args.rho))
        return

    targets = list(PARTICLE_LIBRARY.keys()) if args.particle == "all" else [args.particle]
    records: List[ParticleRecord] = []

    for name in targets:
        spec = PARTICLE_LIBRARY[name]
        particle = PrimordialBlackHoleParticle(
            prefix=spec["prefix"],
            label=name,
            closure_name=spec["closure_name"],
            engine=engine,
        )
        record = particle.resolve()
        records.append(record)
        if record.final_history and record.is_zfa:
            vacuum.absorb(record.final_history)

    if args.parallel and len(records) > 1:
        parallel_inputs = [r.final_history or r.prefix for r in records]
        print("\nParallel composition:")
        print(engine.parallel(*parallel_inputs))

    if args.replicate and records:
        replicated = engine.replicate(records[0].final_history or records[0].prefix, args.replicate)
        print("\nReplication:")
        print(replicated)

    for record in records:
        print_particle_record(record, verbose=args.verbose)

    print("\nVacuum ecology summary:")
    print(f"  resolved histories : {len(vacuum.resolved_histories)}")
    print(f"  baseline density   : {vacuum.baseline_density}")
    if args.verbose and vacuum.resolved_histories:
        print(f"  absorbed closures  : {vacuum.resolved_histories}")


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        description="QLF particles updated for current QuCalc / RhoQuCalc support"
    )
    parser.add_argument(
        "--particle",
        choices=["electron", "positron", "neutrino", "fluxoid", "all"],
        default="all",
    )
    parser.add_argument("--parallel", action="store_true")
    parser.add_argument("--replicate", type=int, default=0)
    parser.add_argument("--show-catalog", action="store_true")
    parser.add_argument("--rho", type=str, default="")
    parser.add_argument("--verbose", action="store_true")
    return parser


if __name__ == "__main__":
    parser = build_parser()
    run_demo(parser.parse_args())
