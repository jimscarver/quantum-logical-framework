"""
QUANTUM ZENO SIMULATOR: Multiplicity and Emergent Energy

A Particle is a collection of event histories of a particular length ~energy.
- Emergent Spatial Radius (R) = Length of the history string.
- Emergent Energy (E) = The number of valid ways (paths) in the collection.

Observation forces Joint ZFA, collapsing the multiplicity and dumping 
the topological energy. Continuous observation (Zeno Effect) prevents 
the particle from ever accumulating energy.
"""

class ZenoParticle:
    def __init__(self):
        # A particle begins with a single Identity history (R=0, E=1)
        self.active_histories = [""]
        self.axes = ['^', 'v', '<', '>']

    def get_spatial_radius(self):
        """Radius is the length of the unresolved logical history."""
        if not self.active_histories:
            return 0
        return max(len(history) for history in self.active_histories)

    def get_emergent_energy(self):
        """
        Energy is the combinatoric volume of the possibility space 
        (the number of valid parallel histories).
        """
        return len(self.active_histories)

    def evolve(self):
        """
        Unobserved evolution. The history length increases (Radius expands),
        and the combinatoric volume multiplies (Energy grows).
        """
        next_histories = []
        for path in self.active_histories:
            for twist in self.axes:
                next_histories.append(path + twist)
        self.active_histories = next_histories

    def observe(self, environment_twist):
        """
        Causal Intersection. The particle must satisfy Joint ZFA.
        Surviving histories are bound (Radius resets to 0), and 
        the multiplicity is pruned (Energy drops).
        """
        conjugate = self._get_conjugate(environment_twist)
        surviving_histories = []
        
        for path in self.active_histories:
            if path.endswith(conjugate):
                # ZFA achieved. History is consumed.
                surviving_histories.append("") 
                
        self.active_histories = surviving_histories

    def _get_conjugate(self, twist):
        conjugates = {'^': 'v', 'v': '^', '<': '>', '>': '<'}
        return conjugates.get(twist)

class ZenoSimulator:
    def simulate(self, total_time, observation_interval, env_pulse='^'):
        particle = ZenoParticle()
        
        print(f"\n--- Zeno Simulation: Observation every {observation_interval} step(s) ---")
        print(f"{'Time (t)':<10} | {'Spatial Radius (R)':<20} | {'Emergent Energy (E)':<25}")
        print("-" * 65)

        for t in range(1, total_time + 1):
            particle.evolve()
            
            obs_marker = ""
            if t % observation_interval == 0:
                particle.observe(env_pulse)
                obs_marker = " [OBSERVED -> Energy Dump]"
                
            if not particle.active_histories:
                print(f"{t:<10} | SYSTEM COLLAPSED")
                break

            radius = particle.get_spatial_radius()
            energy = particle.get_emergent_energy()
            
            print(f"{t:<10} | R = {radius:<16} | E = {energy:,}{obs_marker}")

# --- Self-Evident Example Execution ---
if __name__ == "__main__":
    sim = ZenoSimulator()
    total_t = 6
    
    # 1. Unobserved (Energy Accumulation)
    # The particle is free to multiply its possibilities.
    sim.simulate(total_time=total_t, observation_interval=10)
    
    # 2. Measured Particle (Interval = 2)
    # The particle accumulates energy for one step, then is forced to dump it.
    sim.simulate(total_time=total_t, observation_interval=2)
    
    # 3. The Zeno Limit (Continuous Observation)
    # The particle is mathematically blocked from accumulating ANY energy.
    sim.simulate(total_time=total_t, observation_interval=1)
