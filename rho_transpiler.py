"""
rho_transpiler.py
RhoQuCalc → Python Transpiler for the Quantum Logical Framework (QLF)

Converts simple RhoLang-style notation into executable Python code that
uses the PossibilistEngine (with ZfaCatalog and ApplyZfa) from qucalc_engine.py.

Supported Rho subset:
- new x1, x2 in P
- P | Q                  (parallel composition)
- *P                     (replication)
- ApplyZfa(prefix, name)
- for( _ <- chan ) . P   (simple input guard – stubbed for now)
- chan ! (@proc)         (output – stubbed)
- ZFA_... closures

Author: Jim Whitescarver + Grok (xAI) – April 23, 2026
Repo: https://github.com/jimscarver/quantum-logical-framework
"""

from qucalc_engine import PossibilistEngine
import re
from typing import Dict, Any

# Global engine instance (shared across transpiled code)
engine = PossibilistEngine()


def transpile_rho_to_python(rho_code: str) -> str:
    """
    Transpile RhoQuCalc code to Python using PossibilistEngine.
    Returns a string containing executable Python code.
    """
    # Strip comments and normalize whitespace
    lines = [line.strip() for line in rho_code.splitlines() if line.strip() and not line.strip().startswith('//')]

    python_lines = [
        "# RhoQuCalc transpiled code",
        "from qucalc_engine import PossibilistEngine",
        "engine = PossibilistEngine()",
        "",
    ]

    for line in lines:
        line = line.strip()

        # ApplyZfa
        if line.startswith("ApplyZfa("):
            python_lines.append(f"    result = {line}")

        # Parallel composition:  P | Q
        elif " | " in line:
            parts = [p.strip() for p in line.split("|")]
            python_lines.append(f"    parallel_processes = engine.parallel({', '.join(parts)})")

        # Replication: *P
        elif line.startswith("*"):
            proc = line[1:].strip()
            python_lines.append(f"    replicated = engine.replicate({proc})")

        # new ... in ...
        elif line.startswith("new "):
            # Simple ignore for now (name restriction not yet needed in engine)
            python_lines.append(f"    # new {line[4:]}")

        # Cataloged closure definition (register)
        elif "=" in line and "ZFA_" in line:
            name = line.split("=")[0].strip()
            closure = line.split("=")[1].strip().replace(";", "")
            python_lines.append(f"    engine.catalog.register('{name}', '{closure}')")

        # Simulate / run
        elif line.startswith("simulate") or line.startswith("run"):
            python_lines.append(f"    sim_result = engine.simulate(parallel_processes)")

        else:
            # Pass-through for other valid Python
            python_lines.append(f"    {line}")

    python_lines.append("\n# End of transpiled RhoQuCalc code")
    return "\n".join(python_lines)


def execute_rho(rho_code: str) -> Dict[str, Any]:
    """
    Transpile and immediately execute RhoQuCalc code.
    Returns the simulation result dictionary.
    """
    py_code = transpile_rho_to_python(rho_code)
    # Execute in a controlled namespace
    namespace: Dict[str, Any] = {}
    exec(py_code, globals(), namespace)
    return namespace.get("sim_result", {"status": "executed", "raw_code": py_code})


# =============================================================================
# EXAMPLE USAGE & TEST CASES
# =============================================================================
if __name__ == "__main__":
    print("=== RhoQuCalc Transpiler Demo ===\n")

    # Example 1: Bell state (already in tutorial)
    bell_rho = """
new a, b in
  (a ! (@^) | b ! (@^)) |
  ApplyZfa(a, "ZFA_FLUXOID") |
  ApplyZfa(b, "ZFA_FLUXOID")
"""
    print("Transpiling Bell-state Rho code...")
    py = transpile_rho_to_python(bell_rho)
    print(py)
    print("\nExecuting...")
    result = execute_rho(bell_rho)
    print(result)

    # Example 2: Double-slit
    double_slit_rho = """
new slit1, slit2 in
  (^ ! (> ! (@slit1)) | ^ ! (< ! (@slit2))) |
  *ApplyZfa(slit1, "ZFA_MIN_SQUARE") |
  *ApplyZfa(slit2, "ZFA_MIN_SQUARE")
"""
    print("\n\nTranspiling Double-Slit Rho code...")
    print(transpile_rho_to_python(double_slit_rho))

    print("\n✅ Rho transpiler ready!")
    print("   Use: execute_rho('your Rho code here')")
    print("   or  transpile_rho_to_python('your Rho code here')")
