"""
QLF ENGINE: PRIMORDIAL QUANTUM BLACK HOLES & GAUGE-FOLDING
Version 5.0

A particle is not a point-mass. It is a dense topological knot of unresolved 
free action—a Primordial Quantum Black Hole. 

Its Markov Blanket acts as an Event Horizon. By executing 'Gauge-Folding', 
it cancels internal paradoxes against the vacuum, simultaneously synthesizing 
Local Time (t=h/E) and emitting the geometric exhaust we perceive as Hawking Radiation. 
The resulting 'Density Swap' between the knot and the vacuum is the emergent 
phenomenon of Gravity.
"""

import argparse
import time

class VacuumEcology:
    def __init__(self):
        self.baseline_density = 0.0
        self.topology_grid = ["~", "~", "~", "~", "~"] # Visual representation of local vacuum

class PrimordialBlackHole:
    def __init__(self, energy_density, enable_gauge):
        self.E = energy_density # Informational mass (Unresolved free action)
        self.enable_gauge = enable_gauge
        self.markov_blanket_intact = True
        self.gauge_state = "^<+" # Left-handed, positive gauge core
        
    def gauge_fold(self, vacuum):
        """
        The core engine of reality. The knot folds its geometry against the vacuum,
        forcing a ZFA phase cancellation (+ and - annihilate).
        """
        # The vacuum provides the conjugate gauge (-)
        conjugate = "->"
        
        if self.enable_gauge:
            print(f"    [Gauge-Fold] Executing topology phase cancellation: `{self.gauge_state}` folds into `{conjugate}`")
            # The Event: Mathematical annihilation
            exhaust = (self.gauge_state + conjugate).replace('+-', '').replace('-+', '')
            return exhaust
        return "^<>v" # Default stable R=4 fluxoid if visualization is off

    def execute_tick(self, tick, vacuum, show_density_swap):
        print(f"\n[Tick {tick:03d}] QBH Core Evaluated. Unresolved Action: {self.E}")
        
        # 1. GAUGE-FOLDING & HAWKING RADIATION
        # The particle cancels a fraction of its paradox, radiating the geometric exhaust.
        exhaust_geometry = self.gauge_fold(vacuum)
        radiated_energy = 1.0 # 1 quantum of logical burden resolved
        self.E -= radiated_energy
        
        print(f"    [Hawking Radiation] ZFA Handshake complete. Emitted geometric exhaust: `{exhaust_geometry}`")

        # 2. LOCAL TIME SYNTHESIS (t = h/E)
        topological_constant_h = 1.0
        # Time dilates as the black hole gets less massive (E decreases)
        local_time = topological_constant_h / self.E if self.E > 0 else 0
        print(f"    [Local Time] Synthesized duration for event: t = {local_time:.4f}")

        # 3. DENSITY SWAP (EMERGENT GRAVITY)
        # As the knot resolves, it transfers informational density to the surrounding vacuum,
        # warping the local topology. This IS gravity.
        if show_density_swap:
            vacuum.baseline_density += radiated_energy
            # Visualizing the spatial warping
            warp_index = (tick - 1) % len(vacuum.topology_grid)
            vacuum.topology_grid[warp_index] = "V" # 'V' represents a gravitational well/dent
            warp_visual = "".join(vacuum.topology_grid)
            
            print(f"    [Density Swap] Core E: {self.E} <---> Vacuum Density: {vacuum.baseline_density}")
            print(f"    [Emergent Gravity] Local space warped by computational burden: [{warp_visual}]")

        if self.E <= 0:
            self.markov_blanket_intact = False
            print("\n[!] CORE RESOLVED. Markov Blanket dissolved. QBH has fully evaporated into the vacuum.")

def run_simulation(args):
    print("======================================================")
    print("QLF ENGINE: SOURCE CODE OF REALITY INITIALIZED")
    print("======================================================")
    print("[*] Instantiating Primordial Quantum Black Hole...")
    print("[*] Ruleset : Gauge-Folding Active")
    print("======================================================")

    vacuum = VacuumEcology()
    qbh = PrimordialBlackHole(energy_density=5.0, enable_gauge=args.enable_gauge)
    
    tick = 1
    while qbh.markov_blanket_intact and tick <= 5:
        qbh.execute_tick(tick, vacuum, args.show_density_swap)
        tick += 1
        if args.verbose:
            time.sleep(0.5)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="QLF Particle/QBH Engine")
    parser.add_argument("--enable-gauge", action="store_true", help="Visualize internal gauge phase cancellation")
    parser.add_argument("--show-density-swap", action="store_true", help="Visualize emergence of gravity/warped topology")
    parser.add_argument("--verbose", action="store_true", default=True, help="Add terminal delay for readability")
    
    args = parser.parse_args()
    run_simulation(args)
