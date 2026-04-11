"""
SPACETIME GENERATOR: Emergence from 3D Perspective vs. Algorithmic Lag

Space emerges purely from the 3D spatial perspective (^ v < > / \).
When these twists remain uncanceled, they project outward as macroscopic 3D distance.

Time emerges from the other (local/gauge) dimension (+ -) as algorithmic lag —
the internal "processing delay" required by the constructive logic to resolve
topological paradoxes that cannot be closed within the 3D spatial folds alone.
"""

class SpacetimeGenerator:
    # Topological Planck constant: minimum 4 twists for a closed 2D boundary loop
    H_CONSTANT = 4.0

    def __init__(self, history_string):
        """
        Initializes with a QuCalc history string.
        """
        self.history = history_string
        self.total_twists = len(history_string)

    def calculate_action_distribution(self):
        """
        Separates action into:
          - Spatial Free Action (3D perspective: ^ v < > / \)
          - Local Bound Action (algorithmic lag in the + - dimension)
        """
        # 3D Spatial twists (free action projects as space)
        spatial_v = abs(self.history.count('^') - self.history.count('v'))
        spatial_h = abs(self.history.count('<') - self.history.count('>'))
        spatial_d = abs(self.history.count('/') - self.history.count('\\'))
        
        # Local/Gauge twists (algorithmic lag becomes time)
        local_l = abs(self.history.count('+') - self.history.count('-'))
        
        e_spatial_free = float(spatial_v + spatial_h + spatial_d)
        e_local_bound  = float(local_l)
        
        # Bound action also includes any spatial cancellations that create loops
        e_bound_total = float(self.total_twists - e_spatial_free - e_local_bound) + e_local_bound
        
        return e_spatial_free, e_local_bound, e_bound_total

    def generate_space(self, e_spatial_free):
        """
        Space (x = E_spatial_free / h) emerges directly from the 3D perspective.
        Uncanceled spatial twists create the outward projection of the manifold.
        """
        if e_spatial_free == 0:
            return 0.0
        x = e_spatial_free / self.H_CONSTANT
        return x

    def generate_time(self, e_local_bound):
        """
        Time (t = h / E_local_bound) emerges as algorithmic lag in the local/gauge dimension.
        The + - twists represent the extra computational step needed to close paradoxes
        that the 3D spatial perspective alone cannot resolve.
        """
        if e_local_bound <= 0:
            return float('inf')  # Photon limit: no algorithmic lag → no experienced time
        t = self.H_CONSTANT / e_local_bound
        return t

    def get_clock_frequency(self, t_interval):
        """Frequency of the local "tick" caused by algorithmic lag."""
        if t_interval == float('inf'):
            return 0.0
        return 1.0 / t_interval

    def model_spacetime(self):
        """
        Full emergence report with explicit 3D-vs-algorithmic-lag distinction.
        """
        e_spatial_free, e_local_bound, e_bound_total = self.calculate_action_distribution()
        
        x_space = self.generate_space(e_spatial_free)
        t_time = self.generate_time(e_local_bound)
        f_clock = self.get_clock_frequency(t_time)

        report = {
            "History String": self.history,
            "Total Logical Action": self.total_twists,
            "=== SPATIAL EMERGENCE (3D Perspective) ===": "",
            "Spatial Free Action (^ v < > / \\)": e_spatial_free,
            "Generated Space (x = E_spatial_free / h)": f"{x_space:.6f} (topological units)",
            "=== TEMPORAL EMERGENCE (Algorithmic Lag) ===": "",
            "Local/Gauge Bound Action (+ - dimension)": e_local_bound,
            "Algorithmic Lag → Local Time Interval (t = h / E_local_bound)": f"{t_time:.6f} (topological units)",
            "Oscillation Frequency (Clock Speed from Lag)": f"{f_clock:.6f} Hz (topological)",
            "Total Bound Action (for mass/energy reference)": e_bound_total
        }
        return report


# --- Clean Demonstration ---
if __name__ == "__main__":
    print("=== SPACETIME EMERGENCE: 3D Perspective vs. Algorithmic Lag ===\n")
    
    # Example 1: Photon — pure 3D spatial free action
    photon_string = "^^^^<<<<////"
    photon = SpacetimeGenerator(photon_string)
    print("Photon (pure 3D spatial projection — no algorithmic lag):")
    for k, v in photon.model_spacetime().items():
        print(f"  {k}: {v}")
    
    print("\n" + "="*60 + "\n")
    
    # Example 2: Fermion — spatial closure forces algorithmic lag in + - dimension
    fermion_string = "^>v<^>v<^^>><<vv+-"
    fermion = SpacetimeGenerator(fermion_string)
    print("Fermion (3D spatial folds close → algorithmic lag in local dimension creates time):")
    for k, v in fermion.model_spacetime().items():
        print(f"  {k}: {v}")
