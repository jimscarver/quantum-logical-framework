"""
GRAVITATIONAL TENSOR: Emergent Spacetime Curvature
Curvature arises from information density in the 3D spatial perspective.
The local/gauge dimension contributes algorithmic lag that modulates perceived mass.
"""

class GravitationalTensor:
    DIMENSION_MAP = {
        '^': 0, 'v': 0,     # 3D spatial Y
        '<': 1, '>': 1,     # 3D spatial X
        '/': 2, '\\': 2,    # 3D spatial Z
        '+': 3, '-': 3      # local/gauge dimension (algorithmic lag)
    }

    def __init__(self):
        self.reset_tensor()

    def reset_tensor(self):
        self.tensor = [[0.0 for _ in range(4)] for _ in range(4)]

    def compute_stress_energy(self, history_strings):
        self.reset_tensor()
        total_transitions = 0
        for history in history_strings:
            for i in range(len(history) - 1):
                twist_a = history[i]
                twist_b = history[i+1]
                dim_u = self.DIMENSION_MAP[twist_a]
                dim_v = self.DIMENSION_MAP[twist_b]
                self.tensor[dim_u][dim_v] += 1.0
                total_transitions += 1
        if total_transitions > 0:
            for u in range(4):
                for v in range(4):
                    self.tensor[u][v] /= total_transitions
        return self.tensor

    def symmetrize_tensor(self):
        symmetric_tensor = [[0.0] * 4 for _ in range(4)]
        for u in range(4):
            for v in range(4):
                avg = (self.tensor[u][v] + self.tensor[v][u]) / 2.0
                symmetric_tensor[u][v] = avg
                symmetric_tensor[v][u] = avg
        self.tensor = symmetric_tensor
        return self.tensor

    def calculate_ricci_scalar(self):
        trace = sum(self.tensor[i][i] for i in range(4))
        return trace

    def print_tensor(self, title="Gravitational Tensor (G_uv)"):
        axes = ["Vrt(Y) 3D", "Hrz(X) 3D", "Dpt(Z) 3D", "Loc(T) Lag"]
        print(f"\n--- {title} ---")
        print("          " + "  ".join(f"{ax:8}" for ax in axes))
        for i, row in enumerate(self.tensor):
            formatted_row = "  ".join(f"{val:8.3f}" for val in row)
            print(f"{axes[i]:8} | {formatted_row}")


if __name__ == "__main__":
    gravity_engine = GravitationalTensor()
    vacuum_region = ["^v", "<>", "/\\", "^v<>"]
    fermion_region = ["^v<>", "v^+->//\\\\+-"]

    print("Analyzing Vacuum Region (3D perspective only)...")
    gravity_engine.compute_stress_energy(vacuum_region)
    gravity_engine.symmetrize_tensor()
    gravity_engine.print_tensor("Vacuum Tensor")
    print(f"Ricci Scalar: {gravity_engine.calculate_ricci_scalar():.4f}\n")

    print("Analyzing Fermion Region (3D + algorithmic lag)...")
    gravity_engine.compute_stress_energy(fermion_region)
    gravity_engine.symmetrize_tensor()
    gravity_engine.print_tensor("Fermion Tensor")
    print(f"Ricci Scalar: {gravity_engine.calculate_ricci_scalar():.4f}\n")
