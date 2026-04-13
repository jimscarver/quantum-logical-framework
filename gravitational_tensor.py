"""
gravitational_tensor.py

Native QLF gravity prototype.

This rewrite replaces the old transition-count "tensor" with a native
closure-network model built from the canonical QuCalc core.

Core ideas:
- stable admissible histories are the basic nodes
- primitive periods define the frequency content of each closure
- prime factors of those periods are irreducible logical frequencies
- bound prime-frequency content acts as native mass
- local curvature is the angular deficit of the closure neighborhood
- native gravitational coupling is the curvature-to-density ratio

This is a QuCalc-native prototype. It is not yet a continuum metric model.
"""

from __future__ import annotations

from collections import Counter, defaultdict
from dataclasses import dataclass
import math
from typing import DefaultDict, Dict, Iterable, List, Optional, Sequence, Set, Tuple

from twist_core import (
    conjugate_history,
    generate_histories,
    is_admissible_history,
    is_zfa,
    validate_history,
)


@dataclass(frozen=True)
class ClosureNode:
    history: str
    period: int
    prime_factors: Tuple[Tuple[int, int], ...]
    prime_mass: float


class GravitationalTensor:
    """
    Native QLF gravity estimator.

    Public outputs:
    - stable closures
    - primitive periods
    - prime-factor masses
    - closure-neighborhood graph
    - local curvature kappa_Q
    - local density rho_Q
    - native coupling G_Q
    """

    def __init__(
        self,
        *,
        seeds: Sequence[str] = ("^", "<", "/", "+"),
        causal_horizon: int = 8,
        min_zfa_length: int = 4,
        max_histories: int = 128,
        neighbor_hamming: int = 2,
        min_shared_prefix: int = 2,
    ) -> None:
        self.seeds = tuple(seeds)
        self.causal_horizon = causal_horizon
        self.min_zfa_length = min_zfa_length
        self.max_histories = max_histories
        self.neighbor_hamming = neighbor_hamming
        self.min_shared_prefix = min_shared_prefix

        self.nodes: Dict[str, ClosureNode] = {}
        self.graph: DefaultDict[str, Set[str]] = defaultdict(set)
        self.curvature: Dict[str, float] = {}
        self.density: Dict[str, float] = {}
        self.tensor: List[List[float]] = []
        self.tensor_order: List[str] = []

    # ------------------------------------------------------------------
    # Primitive number theory
    # ------------------------------------------------------------------

    @staticmethod
    def divisors(n: int) -> List[int]:
        if n <= 0:
            return []
        small: List[int] = []
        large: List[int] = []
        k = 1
        while k * k <= n:
            if n % k == 0:
                small.append(k)
                if k * k != n:
                    large.append(n // k)
            k += 1
        return small + list(reversed(large))

    @staticmethod
    def prime_factor_counter(n: int) -> Counter[int]:
        factors: Counter[int] = Counter()
        if n < 2:
            return factors

        d = 2
        while d * d <= n:
            while n % d == 0:
                factors[d] += 1
                n //= d
            d += 1

        if n > 1:
            factors[n] += 1

        return factors

    @classmethod
    def primitive_period(cls, history: str) -> int:
        """
        Smallest repeat length of the history if it is composed of repeated
        blocks; otherwise the full length.

        This is the current native closure-period proxy.
        """
        validate_history(history)
        n = len(history)

        for p in cls.divisors(n):
            if p == 0:
                continue
            if history == history[:p] * (n // p):
                return p

        return n

    @staticmethod
    def prime_mass_from_counter(counter: Counter[int]) -> float:
        """
        Native bound mass:
            m_Q = sum multiplicity(p) * log(p)
        """
        if not counter:
            return 0.0
        return sum(mult * math.log(p) for p, mult in counter.items())

    # ------------------------------------------------------------------
    # Stable closures
    # ------------------------------------------------------------------

    def generate_stable_histories(self) -> List[str]:
        seen: Set[str] = set()
        stable: List[str] = []

        for seed in self.seeds:
            validate_history(seed)
            results = generate_histories(
                seed,
                causal_horizon=self.causal_horizon,
                require_zfa=True,
                min_length=self.min_zfa_length,
            )
            for hist in results:
                if hist in seen:
                    continue
                if not is_admissible_history(hist):
                    continue
                if not is_zfa(hist, min_length=self.min_zfa_length):
                    continue

                seen.add(hist)
                stable.append(hist)

                if len(stable) >= self.max_histories:
                    return stable

        return stable

    def build_nodes(self, histories: Optional[Iterable[str]] = None) -> Dict[str, ClosureNode]:
        self.nodes.clear()

        source = list(histories) if histories is not None else self.generate_stable_histories()

        for hist in source:
            validate_history(hist)
            if not is_admissible_history(hist):
                continue
            if not is_zfa(hist, min_length=self.min_zfa_length):
                continue

            period = self.primitive_period(hist)
            factors = self.prime_factor_counter(period)
            prime_mass = self.prime_mass_from_counter(factors)

            self.nodes[hist] = ClosureNode(
                history=hist,
                period=period,
                prime_factors=tuple(sorted(factors.items())),
                prime_mass=prime_mass,
            )

        return self.nodes

    # ------------------------------------------------------------------
    # Closure-neighborhood graph
    # ------------------------------------------------------------------

    @staticmethod
    def hamming_distance(left: str, right: str) -> Optional[int]:
        if len(left) != len(right):
            return None
        return sum(a != b for a, b in zip(left, right))

    @staticmethod
    def shared_prefix_length(left: str, right: str) -> int:
        count = 0
        for a, b in zip(left, right):
            if a != b:
                break
            count += 1
        return count

    def are_neighbors(self, left: str, right: str) -> bool:
        if left == right:
            return False

        node_left = self.nodes[left]
        node_right = self.nodes[right]

        # Exact conjugates are treated as natural neighbors.
        if right == conjugate_history(left):
            return True

        # Small deformation at fixed length.
        hdist = self.hamming_distance(left, right)
        if hdist is not None and hdist <= self.neighbor_hamming:
            return True

        # Same period + strong shared prefix suggests nearby closure geometry.
        if (
            node_left.period == node_right.period
            and self.shared_prefix_length(left, right) >= self.min_shared_prefix
        ):
            return True

        return False

    def build_graph(self, histories: Optional[Iterable[str]] = None) -> DefaultDict[str, Set[str]]:
        self.build_nodes(histories)
        self.graph = defaultdict(set)

        keys = list(self.nodes.keys())
        for i, left in enumerate(keys):
            for right in keys[i + 1 :]:
                if self.are_neighbors(left, right):
                    self.graph[left].add(right)
                    self.graph[right].add(left)

        return self.graph

    # ------------------------------------------------------------------
    # Native curvature and density
    # ------------------------------------------------------------------

    def local_curvature(self, history: str) -> float:
        """
        Native combinatorial curvature via angular deficit:

            kappa_Q(H) = 2*pi - sum_{K in N(H)} 2*pi / P(K)

        where P(K) is the primitive period of neighbor K.
        """
        if history not in self.nodes:
            raise ValueError(f"unknown history: {history!r}")

        neighbors = self.graph.get(history, set())
        if not neighbors:
            return 2.0 * math.pi

        angle_load = 0.0
        for nb in neighbors:
            period = max(2, self.nodes[nb].period)
            angle_load += (2.0 * math.pi) / period

        return (2.0 * math.pi) - angle_load

    def local_density(self, history: str) -> float:
        """
        Local source density as neighborhood average of bound prime mass.
        """
        if history not in self.nodes:
            raise ValueError(f"unknown history: {history!r}")

        neighbors = self.graph.get(history, set())
        masses = [self.nodes[history].prime_mass]
        masses.extend(self.nodes[nb].prime_mass for nb in neighbors)

        volume = max(1, len(neighbors) + 1)
        return sum(masses) / volume

    def compute_native_fields(self, histories: Optional[Iterable[str]] = None) -> None:
        self.build_graph(histories)
        self.curvature.clear()
        self.density.clear()

        for history in self.nodes:
            self.curvature[history] = self.local_curvature(history)
            self.density[history] = self.local_density(history)

    def native_coupling(self) -> float:
        """
        Ensemble native coupling:

            G_Q = average_H |kappa_Q(H)| / rho_Q(H)

        skipping zero-density nodes.
        """
        if not self.nodes:
            self.compute_native_fields()

        ratios: List[float] = []
        for history in self.nodes:
            rho = self.density[history]
            if rho <= 1e-12:
                continue
            ratios.append(abs(self.curvature[history]) / rho)

        if not ratios:
            return 0.0

        return sum(ratios) / len(ratios)

    # ------------------------------------------------------------------
    # Compatibility helpers
    # ------------------------------------------------------------------

    def compute_stress_energy(
        self, history_strings: Optional[Iterable[str]] = None
    ) -> Dict[str, Dict[str, object]]:
        """
        Compatibility wrapper for older callers.

        Returns a node-wise dictionary rather than the old transition matrix.
        """
        self.compute_native_fields(history_strings)

        result: Dict[str, Dict[str, object]] = {}
        for history, node in self.nodes.items():
            result[history] = {
                "period": node.period,
                "prime_factors": dict(node.prime_factors),
                "prime_mass": node.prime_mass,
                "neighbors": sorted(self.graph.get(history, set())),
                "curvature": self.curvature[history],
                "density": self.density[history],
            }
        return result

    def symmetrize_tensor(self) -> List[List[float]]:
        """
        Build a symmetric adjacency-weight matrix for inspection.

        Entry (i,j) = average prime mass of two neighboring closures, else 0.
        """
        if not self.nodes:
            self.compute_native_fields()

        self.tensor_order = list(self.nodes.keys())
        n = len(self.tensor_order)
        self.tensor = [[0.0 for _ in range(n)] for _ in range(n)]

        for i, left in enumerate(self.tensor_order):
            for j, right in enumerate(self.tensor_order):
                if i == j:
                    self.tensor[i][j] = self.nodes[left].prime_mass
                elif right in self.graph.get(left, set()):
                    self.tensor[i][j] = (
                        self.nodes[left].prime_mass + self.nodes[right].prime_mass
                    ) / 2.0

        return self.tensor

    def calculate_ricci_scalar(self) -> float:
        """
        Compatibility wrapper.

        This returns the mean native curvature over the closure graph.
        It is NOT a continuum Ricci scalar.
        """
        if not self.nodes:
            self.compute_native_fields()

        if not self.curvature:
            return 0.0

        return sum(self.curvature.values()) / len(self.curvature)

    def print_tensor(self, title: str = "Native QLF Gravity Report") -> None:
        if not self.nodes:
            self.compute_native_fields()

        print(f"\n--- {title} ---")
        print(f"Stable closures: {len(self.nodes)}")
        print(f"Native coupling G_Q: {self.native_coupling():.6f}")
        print(f"Mean curvature: {self.calculate_ricci_scalar():.6f}\n")

        ordered = sorted(
            self.nodes.values(),
            key=lambda node: (-node.prime_mass, node.period, node.history),
        )

        for node in ordered[:12]:
            curvature = self.curvature[node.history]
            density = self.density[node.history]
            neighbors = len(self.graph.get(node.history, set()))
            print(
                f"history={node.history!r:<12} "
                f"period={node.period:<3} "
                f"factors={dict(node.prime_factors)!s:<18} "
                f"mass={node.prime_mass:>7.4f} "
                f"deg={neighbors:<3} "
                f"kappa={curvature:>8.4f} "
                f"rho={density:>8.4f}"
            )

    def summary_report(self) -> str:
        if not self.nodes:
            self.compute_native_fields()

        lines = [
            "=== NATIVE QLF GRAVITY REPORT ===",
            f"Seeds                    : {self.seeds}",
            f"Causal horizon           : {self.causal_horizon}",
            f"Minimum ZFA length       : {self.min_zfa_length}",
            f"Stable closures          : {len(self.nodes)}",
            f"Native coupling G_Q      : {self.native_coupling():.10f}",
            f"Mean curvature           : {self.calculate_ricci_scalar():.10f}",
            "",
            "Top closures by bound prime mass:",
        ]

        ordered = sorted(
            self.nodes.values(),
            key=lambda node: (-node.prime_mass, node.period, node.history),
        )

        for node in ordered[:10]:
            lines.append(
                f"  {node.history!r:<12} "
                f"P={node.period:<3} "
                f"factors={dict(node.prime_factors)!s:<16} "
                f"m_Q={node.prime_mass:.6f} "
                f"kappa={self.curvature[node.history]:.6f} "
                f"rho={self.density[node.history]:.6f}"
            )

        return "\n".join(lines)


if __name__ == "__main__":
    gravity_engine = GravitationalTensor(
        seeds=("^", "<", "/", "+"),
        causal_horizon=8,
        min_zfa_length=4,
        max_histories=64,
    )

    gravity_engine.compute_native_fields()
    gravity_engine.print_tensor("Native QLF Gravity Prototype")
    print()
    print(gravity_engine.summary_report())
