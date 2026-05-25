"""Import smoke tests for the packaged QLF modules."""

from __future__ import annotations

import importlib


CORE_MODULES = [
    "qlf.braket_rho",
    "qlf.constants_mapper",
    "qlf.doubler",
    "qlf.gravitational_tensor",
    "qlf.holographic",
    "qlf.magnetism",
    "qlf.particles",
    "qlf.path_integral",
    "qlf.qucalc_engine",
    "qlf.rho_transpiler",
    "qlf.spacetime_dynamics",
    "qlf.topology_resolver",
    "qlf.twist_core",
]


def test_core_modules_import() -> None:
    for module in CORE_MODULES:
        importlib.import_module(module)
