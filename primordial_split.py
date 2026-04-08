"""
QLF ENGINE: PRIMORDIAL GENESIS & CPT SYMMETRY
Version 3.4

This script simulates the "Logical Bang" of the Possibilist Universe.
It generates the first entangled pair of strings (Seed A and Seed B) 
and combinatorially expands their logical light cones. 

The engine mathematically proves that as emergent complexity (Energy/Volume) 
explodes, the universe maintains perfect CPT Symmetry, and the global sum 
of all topological action remains exactly zero.
"""

import argparse

class GenesisSimulator:
    def __init__(self, max_depth, verify_symmetry, verbose):
        self.max_depth = max_depth
        self.verify_symmetry = verify_symmetry
        self.verbose = verbose
        
        # QuCalc Alphabet
        self.spatial_axes = ['^', 'v', '<', '>']
        self.gauge_axes = ['+', '-']
        self.all_axes = self.spatial_axes + self.gauge_axes
        
        # CPT Conjugation Map (Perfect Anti-Logic)
        self.cpt_map = {
            '^': 'v',  # Time inversion
            'v': '^',
            '>': '<',  # Parity inversion
            '<': '>',
            '+': '-',  # Charge/Phase inversion
            '-': '+'
        }

        # Universe State
        self.tick = 0
        self.universe_A = [] # Matter / Forward-Time
        self.universe_B = [] # Antimatter / Backward-Time

    def log(self, message):
        """Standard output logger."""
        if self.verbose:
            print(message)

    def get_conjugate(self, history_string):
        """Returns the perfect CPT symmetric conjugate of a history string."""
        return "".join(self.cpt_map[char] for char in history_string)

    def calculate_net_action(self):
        """
        Sums the total topological action of the entire multiverse.
        Proves the Void Equation: 0 = (+Logic) + (-Logic)
        """
        action_counts = {axis: 0 for axis in self.all_axes}
        
        # Count all action in Universe A
        for string in self.universe_A:
            for char in string:
                action_counts[char] += 1
                
        # Count all action in Universe B
        for string in self.universe_B:
            for char in string:
                action_counts[char] += 1
                
        # Calculate net global imbalances
        net_time = action_counts['^'] - action_counts['v']
        net_space = action_counts['>'] - action_counts['<']
        net_gauge = action_counts['+'] - action_counts['-']
        
        return net_time + net_space + net_gauge

    def initiate_bang(self):
        """Executes the initial symmetric divergence from the Void."""
        self.tick += 1
        self.log("\n[Tick 001] THE LOGICAL BANG")
        self.log("-> The Void Equation resolves: 0 = (+1) + (-1)")
        
        # Seed A: Forward Time, Right-Handed, Positive Phase
        seed_a = "^>+"
        # Seed B: Backward Time, Left-Handed, Negative Phase
        seed_b = self.get_conjugate(seed_a)
        
        self.universe_A.append(seed_a)
        self.universe_B.append(seed_b)
        
        self.log(f"-> Seed A (Matter Path)     : `{seed_a}` (Forward-Time, Right-Handed, Positive)")
        self.log(f"-> Seed B (Antimatter Path) : `{seed_b}` (Backward-Time, Left-Handed, Negative)")
        
        self.verify_global_state()

    def expand_light_cones(self):
        """
        Simulates the combinatoric expansion of both universes.
        Applies Pauli restriction to prevent trivial self-cancellation.
        """
        new_A = []
        new_B = []
        
        for string_a in self.universe_A:
            last_op = string_a[-1]
            
            # Expand Universe A into all orthogonal axes
            for next_op in self.all_axes:
                # Pauli Restriction: Cannot immediately reverse the previous step
                if next_op != self.cpt_map[last_op]:
                    expanded_a = string_a + next_op
                    new_A.append(expanded_a)
                    
                    # Universe B is strictly entangled; it MUST take the CPT conjugate step
                    expanded_b = self.get_conjugate(expanded_a)
                    new_B.append(expanded_b)
                    
        self.universe_A = new_A
        self.universe_B = new_B
        self.tick += 1
        
        self.log(f"\n[Tick {self.tick:03d}] Combinatoric Expansion")
        self.verify_global_state()

    def verify_global_state(self):
        """Outputs the emergent energy (volume) and checks the ZFA baseline."""
        volume_a = len(self.universe_A)
        volume_b = len(self.universe_B)
        total_volume = volume_a + volume_b
        
        self.log(f"  -> Emergent Combinatoric Volume (Energy) : {total_volume} total branches")
        
        if self.verify_symmetry:
            net_action = self.calculate_net_action()
            if net_action == 0:
                self.log("  -> Global Symmetry Check: PASS | Net Action = 0 (Perfect Void Conserved)")
            else:
                self.log(f"  -> Global Symmetry Check: FAIL | Net Action = {net_action}")

    def run_simulation(self):
        self.log("======================================================")
        self.log("[QLF ENGINE v3.4] PRIMORDIAL GENESIS SIMULATOR")
        self.log("======================================================")
        self.log("[System Context Setup]")
        self.log("-> Initial State : The Void (Zero Free Action)")
        self.log("-> Protocol      : Constructive Intuitionistic Logic")
        self.log("-> Constraints   : Strict CPT Symmetry Enforcement")
        self.log("======================================================")
        
        self.initiate_bang()
        
        while self.tick < self.max_depth:
            self.expand_light_cones()
            
        self.log("\n======================================================")
        self.log("[SIMULATION HALTED]")
        self.log("======================================================")
        self.log("ANALYSIS REPORT:")
        self.log(f"1. The Logical Bang expanded to Depth {self.max_depth}.")
        self.log(f"2. Emergent Multiplicity (Total Logical Branches): {len(self.universe_A) * 2:,}")
        self.log("3. Observation: Despite exponential growth in computational complexity,")
        self.log("   entangled CPT mirroring ensures that the global sum of all logic")
        self.log("   remains exactly zero. The universe is a localized illusion of the Void.")
        self.log("======================================================")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="QLF Primordial Genesis Simulator")
    parser.add_argument("--max_depth", type=int, default=5, help="Number of expansion ticks to simulate")
    parser.add_argument("--verify_symmetry", type=bool, default=True, help="Verify global net action equals zero at each step")
    parser.add_argument("--verbose", type=bool, default=True, help="Enable terminal logging")
    
    args = parser.parse_args()
    
    # Python's argparse boolean handling
    verify = str(args.verify_symmetry).lower() in ['true', '1', 't', 'y', 'yes']
    
    engine = GenesisSimulator(
        max_depth=args.max_depth,
        verify_symmetry=verify,
        verbose=args.verbose
    )
    
    engine.run_simulation()
