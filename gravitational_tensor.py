"""
gravitational_tensor.py

Native QLF gravity prototype with light-cone entropy.

This rewrite ties gravity to the entropy of the light cone in a native way.

Core ideas:
- stable admissible ZFA histories are the basic nodes
- primitive periods define the frequency content of closures
- prime factors of reduced periods are irreducible logical frequencies
- bound prime-frequency content acts as native mass
- local curvature is the angular deficit of the closure neighborhood
- light-cone entropy is the prime-weighted multiplicity of hidden admissible
  continuations at the frontier of a local cone
- native gravitational coupling is the stable ratio

      G_Q ~ |kappa_Q| / sigma_Q

  where:
      kappa_Q = local closure-network curvature
      sigma_Q = light-cone boundary entropy density

This is a QuCalc-native prototype. It is not yet a continuum metric theory.
"""

from __future__ import annotations

from collections import Counter, defaultdict
from dataclasses import dataclass
import math
from typing import DefaultDict, Dict, Iterable, List, Optional, Sequence, Set, Tuple

from twist_core import (
    conjugate_history,
    extend_history,
    generate_histories,
    is_admissible_history,
    is_zfa,
    validate_history,
)


@dataclass(frozen=True)
class ClosureNode:
    history: str
    period: int
    reduced_period: int
    prime_factors: Tuple[Tuple[int, int], ...]
    prime_mass: float


class GravitationalTensor:
    """
    Native QLF gravity estimator with light-cone entropy.

    Public native quantities:
    - prime mass m_Q
    - curvature kappa_Q
    - light-cone entropy S_Q
    - boundary entropy density sigma_Q
    - mass density rho_Q
    - native entropy coupling G_Q
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
        entropy_horizon: int = 2,
    ) -> None:
        self.seeds = tuple(seeds)
        self.causal_horizon = causal_horizon
        self.min_zfa_length = min_zfa_length
        self.max_histories = max_histories
        self.neighbor_hamming = neighbor_hamming
        self.min_shared_prefix = min_shared_prefix
        self.entropy_horizon = entropy_horizon

        self.nodes: Dict[str, ClosureNode] = {}
        self.graph: DefaultDict[str, Set[str]] = defaultdict(set)

        self.curvature: Dict[str, float] = {}
        self.mass_density: Dict[str, float] = {}

        self.light_cone_entropy: Dict[str, float] = {}
        self.frontier_area: Dict[str, int] = {}
        self.entropy_density: Dict[str, float] = {}

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
    def reduce_period(period: int) -> int:
        """
        Factor out the universal spinorial factor 2 when present.

        The remaining reduced period carries the irreducible prime-frequency
        content used for native mass and entropy weighting.
        """
        if period <= 0:
            return period
        if period % 2 == 0:
            return max(1, period // 2)
        return period

    @classmethod
    def prime_mass_from_period(cls, period: int) -> float:
        """
        Native bound prime mass:

            m_Q = sum multiplicity(p) * log(p)

        using the reduced period.
        """
        reduced = cls.reduce_period(period)
        factors = cls.prime_factor_counter(reduced)
        if not factors:
            return 0.0
        return sum(mult * math.log(p) for p, mult in factors.items())

    @classmethod
    def prime_weight_of_history(cls, history: str) -> float:
        """
        Prime-frequency weight of an arbitrary admissible continuation.
        """
        validate_history(history)
        period = cls.primitive_period(history)
        return cls.prime_mass_from_period(period)

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
            reduced = self.reduce_period(period)
            factors = self.prime_factor_counter(reduced)
            prime_mass = self.prime_mass_from_period(period)

            self.nodes[hist] = ClosureNode(
                history=hist,
                period=period,
                reduced_period=reduced,
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

        # Exact adjoints are natural neighbors.
        if right == conjugate_history(left):
            return True

        # Small deformation at fixed length.
        hdist = self.hamming_distance(left, right)
        if hdist is not None and hdist <= self.neighbor_hamming:
            return True

        # Same reduced period + strong shared prefix suggests nearby geometry.
        if (
            node_left.reduced_period == node_right.reduced_period
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
    # Native curvature and mass density
    # ------------------------------------------------------------------

    def local_curvature(self, history: str) -> float:
        """
        Native combinatorial curvature via angular deficit:

            kappa_Q(H) = 2*pi - sum_{K in N(H)} 2*pi / P_red(K)

        where P_red(K) is the reduced primitive period of neighbor K.
        """
        if history not in self.nodes:
            raise ValueError(f"unknown history: {history!r}")

        neighbors = self.graph.get(history, set())
        if not neighbors:
            return 2.0 * math.pi

        angle_load = 0.0
        for nb in neighbors:
            reduced = max(1, self.nodes[nb].reduced_period)
            angle_load += (2.0 * math.pi) / reduced

        return (2.0 * math.pi) - angle_load

    def local_mass_density(self, history: str) -> float:
        """
        Neighborhood average of bound prime mass.
        """
        if history not in self.nodes:
            raise ValueError(f"unknown history: {history!r}")

        neighbors = self.graph.get(history, set())
        masses = [self.nodes[history].prime_mass]
        masses.extend(self.nodes[nb].prime_mass for nb in neighbors)

        volume = max(1, len(neighbors) + 1)
        return sum(masses) / volume

    # ------------------------------------------------------------------
    # Light-cone entropy
    # ------------------------------------------------------------------

    def frontier_continuations(self, history: str, depth: Optional[int] = None) -> List[str]:
        """
        Exact frontier of admissible continuations at a fixed depth outside the
        currently resolved local closure.
        """
        validate_history(history)
        depth = self.entropy_horizon if depth is None else depth

        frontier: Set[str] = {history}
        for _ in range(depth):
            nxt: Set[str] = set()
            for current in frontier:
                for ext in extend_history(current):
                    nxt.add(ext)
            frontier = nxt

        return sorted(frontier)

    def light_cone_entropy_of_history(
        self, history: str, depth: Optional[int] = None
    ) -> Tuple[float, int, float]:
        """
        Prime-weighted light-cone entropy:

            S_Q = log( sum_{C in frontier} exp(w(C)) )

        where w(C) is the prime-frequency weight of continuation C.

        The boundary entropy density is:

            sigma_Q = S_Q / A_Q

        where A_Q is the combinatorial frontier size.
        """
        if history not in self.nodes:
            raise ValueError(f"unknown history: {history!r}")

        frontier = self.frontier_continuations(history, depth=depth)
        area = len(frontier)

        if area == 0:
            return 0.0, 0, 0.0

        total_weighted = 0.0
        for cont in frontier:
            weight = self.prime_weight_of_history(cont)
            total_weighted += math.exp(weight)

        entropy = math.log(total_weighted) if total_weighted > 0 else 0.0
        density = entropy / area if area > 0 else 0.0
        return entropy, area, density

    # ------------------------------------------------------------------
    # Native field assembly
    # ------------------------------------------------------------------

    def compute_native_fields(self, histories: Optional[Iterable[str]] = None) -> None:
        self.build_graph(histories)

        self.curvature.clear()
        self.mass_density.clear()

        self.light_cone_entropy.clear()
        self.frontier_area.clear()
        self.entropy_density.clear()

        for history in self.nodes:
            self.curvature[history] = self.local_curvature(history)
            self.mass_density[history] = self.local_mass_density(history)

            entropy, area, sigma = self.light_cone_entropy_of_history(history)
            self.light_cone_entropy[history] = entropy
            self.frontier_area[history] = area
            self.entropy_density[history] = sigma

    # ------------------------------------------------------------------
    # Native couplings
    # ------------------------------------------------------------------

    def local_entropy_coupling(self, history: str) -> float:
        """
        Local entropy-based gravitational coupling:

            g_Q(H) = |kappa_Q(H)| / sigma_Q(H)
        """
        sigma = self.entropy_density.get(history, 0.0)
        if sigma <= 1e-12:
            return 0.0
        return abs(self.curvature[history]) / sigma

    def local_mass_coupling(self, history: str) -> float:
        """
        Comparison quantity using mass density instead of entropy density.
        """
        rho = self.mass_density.get(history, 0.0)
        if rho <= 1e-12:
            return 0.0
        return abs(self.curvature[history]) / rho

    def native_entropy_coupling(self) -> float:
        """
        Ensemble entropy-based native coupling:

            G_Q = average_H |kappa_Q(H)| / sigma_Q(H)
        """
        if not self.nodes:
            self.compute_native_fields()

        ratios: List[float] = []
        for history in self.nodes:
            ratio = self.local_entropy_coupling(history)
            if ratio > 0:
                ratios.append(ratio)

        if not ratios:
            return 0.0
        return sum(ratios) / len(ratios)

    def native_mass_coupling(self) -> float:
        """
        Comparison ensemble coupling from mass density.
        """
        if not self.nodes:
            self.compute_native_fields()

        ratios: List[float] = []
        for history in self.nodes:
            ratio = self.local_mass_coupling(history)
            if ratio > 0:
                ratios.append(ratio)

        if not ratios:
            return 0.0
        return sum(ratios) / len(ratios)

    def native_coupling(self) -> float:
        """
        Backward-compatible name used by constants_mapper.py.

        By design, this now means the entropy-based native coupling.
        """
        return self.native_entropy_coupling()

    # ------------------------------------------------------------------
    # Compatibility helpers
    # ------------------------------------------------------------------

    def compute_stress_energy(
        self, history_strings: Optional[Iterable[str]] = None
    ) -> Dict[str, Dict[str, object]]:
        """
        Compatibility wrapper.

        Returns a node-wise dictionary rather than the old transition matrix.
        """
        self.compute_native_fields(history_strings)

        result: Dict[str, Dict[str, object]] = {}
        for history, node in self.nodes.items():
            result[history] = {
                "period": node.period,
                "reduced_period": node.reduced_period,
                "prime_factors": dict(node.prime_factors),
                "prime_mass": node.prime_mass,
                "neighbors": sorted(self.graph.get(history, set())),
                "curvature": self.curvature[history],
                "mass_density": self.mass_density[history],
                "light_cone_entropy": self.light_cone_entropy[history],
                "frontier_area": self.frontier_area[history],
                "entropy_density": self.entropy_density[history],
                "local_entropy_coupling": self.local_entropy_coupling(history),
                "local_mass_coupling": self.local_mass_coupling(history),
            }
        return result

    def symmetrize_tensor(self) -> List[List[float]]:
        """
        Build a symmetric inspection matrix.

        Diagonal:
            local entropy density sigma_Q(H)

        Off-diagonal:
            average of sigma_Q for neighboring closures, else 0.
        """
        if not self.nodes:
            self.compute_native_fields()

        self.tensor_order = list(self.nodes.keys())
        n = len(self.tensor_order)
        self.tensor = [[0.0 for _ in range(n)] for _ in range(n)]

        for i, left in enumerate(self.tensor_order):
            for j, right in enumerate(self.tensor_order):
                if i == j:
                    self.tensor[i][j] = self.entropy_density[left]
                elif right in self.graph.get(left, set()):
                    self.tensor[i][j] = (
                        self.entropy_density[left] + self.entropy_density[right]
                    ) / 2.0

        return self.tensor

    def calculate_ricci_scalar(self) -> float:
        """
        Compatibility wrapper.

        Returns the mean native curvature over the closure graph.
        It is NOT a continuum Ricci scalar.
        """
        if not self.nodes:
            self.compute_native_fields()

        if not self.curvature:
            return 0.0

        return sum(self.curvature.values()) / len(self.curvature)

    # ------------------------------------------------------------------
    # Reporting
    # ------------------------------------------------------------------

    def print_tensor(self, title: str = "Native QLF Gravity Report") -> None:
        if not self.nodes:
            self.compute_native_fields()

        print(f"\n--- {title} ---")
        print(f"Stable closures          : {len(self.nodes)}")
        print(f"Native entropy coupling  : {self.native_entropy_coupling():.10f}")
        print(f"Native mass coupling     : {self.native_mass_coupling():.10f}")
        print(f"Mean curvature           : {self.calculate_ricci_scalar():.10f}\n")

        ordered = sorted(
            self.nodes.values(),
            key=lambda node: (-node.prime_mass, node.reduced_period, node.history),
        )

        for node in ordered[:12]:
            history = node.history
            neighbors = len(self.graph.get(history, set()))
            print(
                f"history={history!r:<12} "
                f"P={node.period:<3} "
                f"Pred={node.reduced_period:<3} "
                f"factors={dict(node.prime_factors)!s:<16} "
                f"m_Q={node.prime_mass:>7.4f} "
                f"deg={neighbors:<3} "
                f"kappa={self.curvature[history]:>9.4f} "
                f"S_Q={self.light_cone_entropy[history]:>9.4f} "
                f"A_Q={self.frontier_area[history]:<4} "
                f"sigma_Q={self.entropy_density[history]:>9.4f}"
            )

    def summary_report(self) -> str:
        if not self.nodes:
            self.compute_native_fields()

        lines = [
            "=== NATIVE QLF GRAVITY REPORT ===",
            f"Seeds                         : {self.seeds}",
            f"Causal horizon                : {self.causal_horizon}",
            f"Minimum ZFA length            : {self.min_zfa_length}",
            f"Stable closures               : {len(self.nodes)}",
            f"Entropy horizon               : {self.entropy_horizon}",
            f"G_Q (entropy)                 : {self.native_entropy_coupling():.10f}",
            f"G_Q (mass comparison)         : {self.native_mass_coupling():.10f}",
            f"Mean curvature                : {self.calculate_ricci_scalar():.10f}",
            "",
            "Top closures by bound prime mass:",
        ]

        ordered = sorted(
            self.nodes.values(),
            key=lambda node: (-node.prime_mass, node.reduced_period, node.history),
        )

        for node in ordered[:10]:
            history = node.history
            lines.append(
                f"  {history!r:<12} "
                f"P={node.period:<3} "
                f"Pred={node.reduced_period:<3} "
                f"factors={dict(node.prime_factors)!s:<16} "
                f"m_Q={node.prime_mass:.6f} "
                f"kappa={self.curvature[history]:.6f} "
                f"S_Q={self.light_cone_entropy[history]:.6f} "
                f"sigma_Q={self.entropy_density[history]:.6f}"
            )

        lines.extend(
            [
                "",
                "Interpretation:",
                "  - m_Q is bound irreducible prime-frequency content.",
                "  - S_Q is prime-weighted light-cone entropy.",
                "  - sigma_Q is the light-cone boundary entropy density.",
                "  - G_Q is the stable curvature-to-entropy-density ratio.",
            ]
        )

        return "\n".join(lines)


if __name__ == "__main__":
    gravity_engine = GravitationalTensor(
        seeds=("^", "<", "/", "+"),
        causal_horizon=8,
        min_zfa_length=4,
        max_histories=64,
        entropy_horizon=2,
    )

    gravity_engine.compute_native_fields()
    gravity_engine.print_tensor("Native QLF Gravity with Light-Cone Entropy")
    print()
    print(gravity_engine.summary_report())
