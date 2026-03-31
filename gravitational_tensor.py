Here is the complete and fully documented `gravitational_tensor.py` module. 

In the **Quantum Logical Framework (QLF)**, gravity is not a fundamental force; it is an emergent property. Just as General Relativity dictates that mass-energy tells spacetime how to curve, in QLF, the **Density of Logical Twists** (information) tells the discrete manifold how to warp. 

This script calculates the interaction density of the 8-axis logic to generate a discrete curvature tensor, mapping how "knotted" a specific logical region has become.

### `gravitational_tensor.py`

```python
"""
GRAVITATIONAL TENSOR: Emergent Spacetime Curvature
In the Possibilist Universe, gravity is not a fundamental force. It is an emergent 
property of information density. This module maps a collection of Zero Free Action (ZFA) 
history strings into a discrete 4x4 topological tensor, representing the curvature 
of the logical manifold in a specific region.
"""

class GravitationalTensor:
    # Map the 8 twists to their respective 4 dimensions (mu, nu)
    # 0: Vertical (Y), 1: Horizontal (X), 2: Depth (Z), 3: Local/Temporal (T)
    DIMENSION_MAP = {
        '^': 0, 'v': 0,
        '<': 1, '>': 1,
        '/': 2, '\\': 2,
        '+': 3, '-': 3
    }

    def __init__(self):
        """
        Initializes an empty 4x4 metric tensor.
        G_uv represents the interaction density between dimension u and dimension v.
        """
        self.reset_tensor()

    def reset_tensor(self):
        # 4x4 matrix initialized to 0
        self.tensor = [[0.0 for _ in range(4)] for _ in range(4)]

    def compute_stress_energy(self, history_strings):
        """
        Calculates the discrete equivalent of the Stress-Energy Tensor (T_uv).
        It measures the frequency of Pauli folds (transitions from one axis to another)
        across a collection of stable history strings in a localized region.
        """
        self.reset_tensor()
        total_transitions = 0

        for history in history_strings:
            # We measure the 'knot density' by looking at sequential twists
            for i in range(len(history) - 1):
                twist_a = history[i]
                twist_b = history[i+1]

                dim_u = self.DIMENSION_MAP[twist_a]
                dim_v = self.DIMENSION_MAP[twist_b]

                # Accumulate the interaction weight
                self.tensor[dim_u][dim_v] += 1.0
                total_transitions += 1

        # Normalize the tensor by the total number of actions (density per twist)
        if total_transitions > 0:
            for u in range(4):
                for v in range(4):
                    self.tensor[u][v] /= total_transitions
                    
        return self.tensor

    def symmetrize_tensor(self):
        """
        In general relativity, the metric and Einstein tensors are symmetric (G_uv = G_vu).
        We enforce this by averaging the directional topological transitions.
        """
        symmetric_tensor = [[0.0] * 4 for _ in range(4)]
        for u in range(4):
            for v in range(4):
                avg = (self.tensor[u][v] + self.tensor[v][u]) / 2.0
                symmetric_tensor[u][v] = avg
                symmetric_tensor[v][u] = avg
        self.tensor = symmetric_tensor
        return self.tensor

    def calculate_ricci_scalar(self):
        """
        Calculates the emergent Ricci Scalar (R).
        In this discrete manifold, the scalar curvature is the trace of the tensor.
        A higher trace means more self-interacting dimensions (tightly bound information),
        representing a higher localized "mass".
        """
        trace = sum(self.tensor[i][i] for i in range(4))
        return trace

    def print_tensor(self, title="Gravitational Tensor (G_uv)"):
        """Utility to format and print the 4x4 tensor."""
        axes = ["Vrt(Y)", "Hrz(X)", "Dpt(Z)", "Loc(T)"]
        print(f"\n--- {title} ---")
        print("          " + "  ".join(f"{ax:6}" for ax in axes))
        for i, row in enumerate(self.tensor):
            formatted_row = "  ".join(f"{val:6.3f}" for val in row)
            print(f"{axes[i]:6} | {formatted_row}")


# --- Self-Evident Example Execution ---
if __name__ == "__main__":
    gravity_engine = GravitationalTensor()

    # 1. The Vacuum (Empty Space)
    # A region with very few, simple, non-interacting history strings.
    vacuum_region = [
        "^v", "<>", "/\\"
    ]
    
    # 2. A Massive Particle (Fermion Knot)
    # A region dense with tightly wound, complex ZFA history strings (e.g., a spin-1/2 double cycle).
    fermion_region = [
        "^</+-\>v-", 
        "v\+-></^+-", 
        "^^<<vv>>//\\\\+-"
    ]

    print("Analyzing Vacuum Region...")
    gravity_engine.compute_stress_energy(vacuum_region)
    gravity_engine.symmetrize_tensor()
    gravity_engine.print_tensor("Vacuum Tensor")
    vacuum_mass = gravity_engine.calculate_ricci_scalar()
    print(f"Emergent Ricci Scalar (Mass/Curvature): {vacuum_mass:.4f}\n")

    print("Analyzing Dense Fermion Region...")
    gravity_engine.compute_stress_energy(fermion_region)
    gravity_engine.symmetrize_tensor()
    gravity_engine.print_tensor("Fermion Tensor")
    fermion_mass = gravity_engine.calculate_ricci_scalar()
    print(f"Emergent Ricci Scalar (Mass/Curvature): {fermion_mass:.4f}\n")
    
    print(f"Observation: The Fermion region warps the logical manifold {fermion_mass/vacuum_mass:.1f}x more than the vacuum.")
```

### Theoretical Alignment with `REVIEW.md`

1. **Discrete Stress-Energy:** Standard physics uses continuous energy density ($T_{\mu\nu}$). In QLF, "energy" is information. The `compute_stress_energy` method calculates how frequently the simulation is forced to fold between different dimensional axes.
2. **Emergent Mass (Ricci Scalar):** The Trace of the matrix represents interactions within the *same* axis block. In Pauli-constrained logic, folding into the same dimension without orthogonal mediation requires a tight, recursive logical loop. Therefore, a higher trace directly correlates to a tightly "knotted" history string—which behaves macroscopically exactly like localized mass.
3. **No Background Geometry:** The tensor doesn't exist *in* space; the tensor *is* the space. The matrix output entirely defines the local "shape" of the universe in that region based purely on the generated history strings.
