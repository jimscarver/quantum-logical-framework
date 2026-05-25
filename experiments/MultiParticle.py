"""
MULTI-PARTICLE INTERACTOR: Causal Intersection and Joint Resolution.

This module models how two independent QuCalc history strings (particles) 
interact. It computes their expanding causal light cones (diamonds) and, 
upon intersection, searches for possibility branches that achieve 
Joint Zero Free Action (Entanglement).
"""

import collections

class MultiParticleInteractor:
    def __init__(self, causal_horizon=10):
        """
        Initializes the interaction space. The causal_horizon limits 
        how far strings can search before dissipating.
        """
        self.causal_horizon = causal_horizon

        # 8-Axis QuCalc Alphabet mapping to 2D Spatial projections
        # (Assuming Depth / \ and Local + - do not shift macroscopic X/Y)
        self.SPATIAL_MAP = {
            '^': (0, 1), 'v': (0, -1),
            '>': (1, 0), '<': (-1, 0),
            '/': (0, 0), '\\': (0, 0),
            '+': (0, 0), '-': (0, 0)
        }

    def generate_causal_diamond(self, origin, logical_time):
        """
        Generates the Interaction Manifold: All discrete spatial coordinates 
        reachable from the 'origin' within 'logical_time' (L1 Norm / Manhattan distance).
        """
        ox, oy = origin
        diamond = set()
        for dx in range(-logical_time, logical_time + 1):
            y_bound = logical_time - abs(dx)
            for dy in range(-y_bound, y_bound + 1):
                diamond.add((ox + dx, oy + dy))
        return diamond

    def check_joint_zfa(self, history_a, history_b):
        """
        The Entanglement Filter: Tests if two independent strings can mutually 
        cancel their topological action to achieve global ZFA.
        """
        joint_history = history_a + history_b
        
        v = joint_history.count('^') - joint_history.count('v')
        h = joint_history.count('>') - joint_history.count('<')
        d = joint_history.count('/') - joint_history.count('\\')
        l = joint_history.count('+') - joint_history.count('-')
        
        return (v == 0 and h == 0 and d == 0 and l == 0)

    def generate_branches(self, seed, steps):
        """
        Simulates the QuCalc Engine generating Pauli-permitted successor folds.
        Returns a list of candidate history strings of length 'steps'.
        """
        # Simplified branching for demonstration: explores vertical and horizontal
        axes = ['^', 'v', '<', '>'] 
        queue = collections.deque([seed])
        
        for _ in range(steps):
            next_queue = collections.deque()
            while queue:
                current_path = queue.popleft()
                for twist in axes:
                    # In a full run, we would enforce Pauli orthogonal constraints here
                    next_queue.append(current_path + twist)
            queue = next_queue
            
        return list(queue)

    def search_for_entanglement(self, origin_a, origin_b, seed_a, seed_b):
        """
        The Core Engine: Increments logical time, expands causal horizons, 
        detects intersection, and attempts to resolve a Joint ZFA state.
        """
        print(f"--- Initiating Entanglement Search ---")
        print(f"Particle A: Origin {origin_a}, Seed: '{seed_a}'")
        print(f"Particle B: Origin {origin_b}, Seed: '{seed_b}'\n")

        for t in range(1, self.causal_horizon + 1):
            diamond_a = self.generate_causal_diamond(origin_a, t)
            diamond_b = self.generate_causal_diamond(origin_b, t)
            
            # 1. Detect Manifold Intersection
            interaction_manifold = diamond_a.intersection(diamond_b)
            
            if not interaction_manifold:
                print(f"[t={t}] Horizons expanding. No intersection yet. (Distance > 2ct)")
                continue
                
            print(f"[t={t}] ⚠️ CAUSAL INTERSECTION DETECTED ⚠️")
            print(f"        Interaction Manifold encompasses {len(interaction_manifold)} logical units.")
            print(f"        Initiating Joint Resolution Search...\n")
            
            # 2. Generate possibility branches for both particles
            # They must "decide" how to fold now that they share a manifold
            branches_a = self.generate_branches(seed_a, steps=t)
            branches_b = self.generate_branches(seed_b, steps=t)
            
            valid_entanglements = []
            
            # 3. Search for Joint ZFA (The "Quantum Handshake")
            for path_a in branches_a:
                for path_b in branches_b:
                    if self.check_joint_zfa(path_a, path_b):
                        valid_entanglements.append((path_a, path_b))
                        
            if valid_entanglements:
                print(f"SUCCESS: System stabilized into an Entangled State!")
                print(f"Discovered {len(valid_entanglements)} valid Joint ZFA combinations.")
                print(f"Sample Entangled State:")
                print(f"  |Psi>_A : {valid_entanglements[0][0]}")
                print(f"  |Psi>_B : {valid_entanglements[0][1]}")
                return True
            else:
                print(f"FAILURE: Topological Contradiction. Particles scattered.")
                return False
                
        print("\nCausal Horizon reached without interaction.")
        return False

# --- Self-Evident Example Execution ---
if __name__ == "__main__":
    simulator = MultiParticleInteractor(causal_horizon=5)
    
    # Place Particle A at X=-2 and Particle B at X=+2
    pos_A = (-2, 0)
    pos_B = (2, 0)
    
    # Seed A with an initial upward twist, Seed B with an initial downward twist
    initial_seed_A = "^"
    initial_seed_B = "v"
    
    simulator.search_for_entanglement(pos_A, pos_B, initial_seed_A, initial_seed_B)
