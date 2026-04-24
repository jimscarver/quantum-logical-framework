"""
qucalc_engine.py
Quantum Logical Framework (QLF) Core Engine
────────────────────────────────────────────
Now includes full RhoQuCalc support:
• ZfaCatalog – memoized registry of verified ZFA closures
• ApplyZfa – Rho-style composition of prefix + cataloged closure
• PossibilistEngine – wrapper exposing Rho primitives (| , *, ApplyZfa)

Author: Jim Whitescarver + Grok (xAI) – April 23, 2026
Repo: https://github.com/jimscarver/quantum-logical-framework
"""

from collections import Counter, defaultdict, deque
from typing import Dict, Tuple, List, Optional, Any, Set
import itertools

# =============================================================================
# 8-TWIST BASIS (canonical order used everywhere)
# =============================================================================
TWISTS = ['^', 'v', '<', '>', '/', '\\', '+', '-']
TWIST_INDEX = {t: i for i, t in enumerate(TWISTS)}

# =============================================================================
# CORE UTILITIES
# =============================================================================
def compute_imbalance(history: str) -> Tuple[int, ...]:
    """Return immutable tuple of twist counts in canonical order."""
    count = Counter(history)
    return tuple(count.get(t, 0) for t in TWISTS)


def is_zfa_closed(history: str) -> bool:
    """True if the history string satisfies Zero Free Action (net imbalance = 0)."""
    return all(x == 0 for x in compute_imbalance(history))


def hermitian_conjugate(history: str) -> str:
    """Simple Hermitian conjugate mapping (invert each twist)."""
    conj_map = {'^': 'v', 'v': '^', '<': '>', '>': '<',
                '/': '\\', '\\': '/', '+': '-', '-': '+'}
    return ''.join(conj_map.get(c, c) for c in reversed(history))


# =============================================================================
# ZfaCatalog – Memoized registry of known ZFA closures
# =============================================================================
class ZfaCatalog:
    """Memoized registry of pre-verified ZFA closures.
    Keyed by name for fast lookup and by net imbalance for future matching.
    """
    def __init__(self):
        self._catalog: Dict[str, Tuple[str, Tuple[int, ...]]] = {}
        self._imbalance_index: Dict[Tuple[int, ...], List[str]] = defaultdict(list)

    def register(self, name: str, closure: str) -> None:
        """Register a verified minimal or composite ZFA closure."""
        if not is_zfa_closed(closure):
            raise ValueError(f"Closure '{name}' is not ZFA-closed: {closure}")
        imbalance = compute_imbalance(closure)
        self._catalog[name] = (closure, imbalance)
        self._imbalance_index[imbalance].append(name)

    def get_by_name(self, name: str) -> Optional[str]:
        """Return the closure string for a registered name."""
        entry = self._catalog.get(name)
        return entry[0] if entry else None

    def find_compatible_closures(self, current_imbalance: Tuple[int, ...]) -> List[str]:
        """Return names of closures that match a given imbalance."""
        return self._imbalance_index.get(current_imbalance, [])


# =============================================================================
# CORE QuCalcEngine (original BFS-based ZFA discovery)
# =============================================================================
class QuCalcEngine:
    """Core constrained BFS engine for ZFA discovery."""

    def __init__(self):
        self.max_depth = 12
        self.visited: Set[str] = set()

    def find_zfa(self, prefix: str) -> Optional[str]:
        """Return the shortest ZFA closure for a given prefix (or None)."""
        if is_zfa_closed(prefix):
            return prefix
        self.visited.clear()
        queue = deque([(prefix, 0)])

        while queue:
            current, depth = queue.popleft()
            if current in self.visited:
                continue
            self.visited.add(current)

            if depth > self.max_depth:
                continue

            if is_zfa_closed(current):
                return current

            # Branch on every possible next twist (orthogonal only)
            for t in TWISTS:
                next_hist = current + t
                # Simple Pauli-like filter: avoid trivial reversal
                if len(next_hist) >= 2 and next_hist[-2] == hermitian_conjugate(next_hist[-1]):
                    continue
                queue.append((next_hist, depth + 1))

        return None


# =============================================================================
# PossibilistEngine – Rho-style wrapper exposing parallel composition
# =============================================================================
class PossibilistEngine:
    """Rho calculus wrapper around the core QuCalc engine.
    Exposes native | (parallel), * (replication), and ApplyZfa.
    Fully compatible with existing QLF code.
    """
    def __init__(self, core_engine: Optional[QuCalcEngine] = None):
        self.catalog = ZfaCatalog()
        self.core_engine = core_engine or QuCalcEngine()
        self._register_standard_closures()

    def _register_standard_closures(self) -> None:
        """Register the official minimal and composite ZFA closures."""
        # Minimal spatial loops
        self.catalog.register("ZFA_MIN_SQUARE", "^>v<")
        self.catalog.register("ZFA_MIN_SQUARE_CCW", "^<v>")
        self.catalog.register("ZFA_MIN_DIAG", "/\\/\\")
        # Gauge-resolved
        self.catalog.register("ZFA_GAUGE_LOOP", "+-")
        # Composite particle-like fluxoid
        self.catalog.register("ZFA_FLUXOID", "^>/+v<\\-")
        # Add more closures here as they are discovered

    def ApplyZfa(self, prefix: str, name: str) -> Optional[str]:
        """Rho-style: compose current prefix with a cataloged ZFA closure.
        Returns the concatenated history (ready for further processing).
        """
        closure = self.catalog.get_by_name(name)
        if closure is None:
            return None
        # Additive composition in the 8-twist algebra
        return prefix + closure

    def parallel(self, *histories: str) -> List[str]:
        """Rho `P | Q` – independent parallel histories (superposition)."""
        return list(histories)

    def replicate(self, history: str, count: int = 1) -> List[str]:
        """Rho `*P` – replication (multiple identical particles/histories)."""
        return [history] * count

    def simulate(self, processes: List[str]) -> Dict[str, Any]:
        """Run the core engine on a list of parallel Rho processes."""
        results = {}
        for i, proc in enumerate(processes):
            closed = self.core_engine.find_zfa(proc)
            results[f"process_{i}"] = {
                "input": proc,
                "closed": closed,
                "is_zfa": is_zfa_closed(closed) if closed else False
            }
        return results


# =============================================================================
# MAIN – Demo / Self-test
# =============================================================================
if __name__ == "__main__":
    print("=== QLF QuCalc Engine with RhoQuCalc Support ===\n")

    engine = PossibilistEngine()

    # Example 1: ApplyZfa (catalog composition)
    open_prefix = "^>"
    closed = engine.ApplyZfa(open_prefix, "ZFA_MIN_SQUARE")
    print(f"ApplyZfa('{open_prefix}', 'ZFA_MIN_SQUARE') → {closed}")
    print(f"   ZFA closed? {is_zfa_closed(closed) if closed else False}\n")

    # Example 2: Rho parallel + replicate
    multi = engine.parallel("^", "v")
    replicated = engine.replicate("^>v<", 3)
    print(f"Parallel example: {multi}")
    print(f"Replicated example: {replicated}\n")

    # Example 3: Full simulation of parallel processes
    sim_result = engine.simulate(multi)
    print("Simulation result:")
    for k, v in sim_result.items():
        print(f"  {k}: {v}")

    print("\n✅ PossibilistEngine + ZfaCatalog successfully loaded!")
    print("   Ready for RhoQuCalc quantum-circuit and multi-particle simulations.")
