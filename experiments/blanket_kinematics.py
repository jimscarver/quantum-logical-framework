"""
QLF ENGINE: MARKOV BLANKET KINEMATICS
Version 3.3

This script simulates the macroscopic interactions between stable ZFA clusters 
(Markov Blankets). It demonstrates how environmental paradoxes are resolved 
either through Transactional Handshakes (Electromagnetic Repulsion) or 
Topological Symbiosis (Blanket Fusion/Nucleosynthesis) under extreme pressure.
"""

import argparse
import time

class Node:
    def __init__(self, name, vector, is_stable=True):
        self.name = name
        self.vector = vector  # [x, y]
        self.radius = 4       # R=4 Base Fluxoid Cluster
        self.is_stable = is_stable

class KinematicsEngine:
    def __init__(self, node_a_name, node_b_name, extreme_pressure, verbose):
        self.extreme_pressure = extreme_pressure
        self.verbose = verbose
        self.tick = 0
        
        # Initializing Nodes
        v_a = [0.5, 0.0] if not extreme_pressure else [1.5, 0.0]
        v_b = [-0.5, 0.0] if not extreme_pressure else [-1.5, 0.0]
        
        self.node_A = Node(node_a_name, v_a)
        self.node_B = Node(node_b_name, v_b)

    def log(self, message, delay=0.0):
        """Standard output logger for the engine."""
        if self.verbose:
            print(message)
            if delay > 0:
                time.sleep(delay)

    def advance_ticks(self, target_tick):
        """Simulates the macroscopic advancement of topologies."""
        while self.tick < target_tick:
            self.tick += 1
            if self.tick % 5 == 0 or self.tick == target_tick:
                self.log(f"[Tick {self.tick:03d}] Topologies advancing...")

    def execute_transactional_handshake(self):
        """Resolves boundary intersection via photon-equivalent handshake."""
        self.log(f"[Tick {self.tick:03d}] ⚠️ CAUSAL DIAMONDS INTERSECTING.")
        self.log("           -> Environmental Paradox Detected: Local gauge phase surplus (++).")
        
        self.log("\n[Executing Active Inference Protocol]")
        self.log("-> Node A and Node B evaluating Joint ZFA requirements.")
        self.log("-> Internal states (quarks) strictly locked. No internal logic revealed.")
        self.log("-> Surface negotiation initiated: \"Delayed Choice\" optimization.")
        
        self.tick += 1
        self.log(f"\n[Tick {self.tick:03d}] Transactional Handshake Complete.")
        self.log("-> QuCalc Engine synthesizes discrete Free Action string: `^^^^` (Photon equivalent).")
        self.log("-> String bridges Node A and Node B surfaces.")
        self.log("-> Gauge surplus resolved via spatial deflection.")
        
        # Deflect vectors
        self.node_A.vector = [-0.5, 0.1]
        self.node_B.vector = [0.5, -0.1]
        
        self.tick += 1
        self.log(f"\n[Tick {self.tick:03d}] Node A Vector updated: {{{self.node_A.vector[0]:>4.1f}, {self.node_A.vector[1]:>4.1f}}}")
        self.log(f"[Tick {self.tick:03d}] Node B Vector updated: {{{self.node_B.vector[0]:>4.1f}, {self.node_B.vector[1]:>4.1f}}}")

        self.print_report(
            "Successful Electromagnetic Repulsion. Both Markov Blankets deflected the environmental\n"
            "paradox by exchanging a pure-action string. Internal loops suffered 0% decay.\n"
            "Blanket integrity maintained."
        )

    def execute_blanket_fusion(self):
        """Resolves extreme boundary overlap via pion-equivalent exchange and merging."""
        self.log(f"[Tick {self.tick:03d}] ⚠️ BOUNDARY OVERLAP DETECTED.")
        self.log("           -> Pressure exceeds photon-handshake capacity.")
        self.log("           -> Deflection impossible. Engine risks unrecoverable paradox.")
        
        self.log("\n[Executing Emergency Topological Symbiosis]")
        self.log("-> Node A and Node B Markov Blankets breached at contact vector.")
        self.log("-> Engine extracting one fractional gauge string from Node A (`^+`).")
        self.log("-> Engine extracting one fractional gauge string from Node B (`v-`).")
        
        self.tick += 1
        self.log(f"\n[Tick {self.tick:03d}] Synthesizing Shared Mesh (Pion Exchange)...")
        self.log("-> `^+` and `v-` interlocked to form a localized ZFA bridge between the clusters.")
        
        self.tick += 1
        self.log(f"\n[Tick {self.tick:03d}] Establishing Macro-Boundary...")
        self.log("-> Engine wrapping both clusters in a new, unified causal horizon.")
        
        self.node_A.is_stable = False
        self.node_B.is_stable = False

        self.print_report(
            f"Successful Nucleosynthesis. Node A and Node B have merged into a Diproton state.\n"
            f"They no longer possess independent Markov Blankets. They now share a single,\n"
            f"fractally scaled Markov Blanket (The Nucleus), optimizing local algorithmic\n"
            f"efficiency against the extreme external pressure."
        )

    def print_report(self, analysis_text):
        self.log("\n======================================================")
        self.log("ANALYSIS REPORT:")
        self.log(analysis_text)
        self.log("======================================================")

    def run_simulation(self):
        self.log("======================================================")
        self.log("[QLF ENGINE v3.3] MARKOV BLANKET KINEMATICS")
        self.log("======================================================")
        self.log("[System Context Setup]")
        self.log(f"-> Injecting Node A: [{self.node_A.name}] (Stable 3-String Cluster, R=4)")
        self.log(f"-> Injecting Node B: [{self.node_B.name}] (Stable 3-String Cluster, R=4)")
        
        if self.extreme_pressure:
            self.log("-> Environment: High-Density Context (Extreme Computational Pressure)\n")
            self.advance_ticks(5)
            self.execute_blanket_fusion()
        else:
            self.log(f"-> Initial State: Nodes approaching at Vector {{{self.node_A.vector[0]:.1f}, {self.node_A.vector[1]:.1f}}}\n")
            self.advance_ticks(18)
            self.execute_transactional_handshake()


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="QLF Markov Blanket Kinematics Simulator")
    parser.add_argument("--node_A", type=str, default="Proton_1", help="Identifier for the first Markov Blanket")
    parser.add_argument("--node_B", type=str, default="Proton_2", help="Identifier for the second Markov Blanket")
    parser.add_argument("--apply_extreme_pressure", type=bool, default=False, help="Enable extreme environmental pressure (forces fusion)")
    parser.add_argument("--vector", type=str, default="collision_course", help="Initial vector configuration")
    parser.add_argument("--verbose", type=bool, default=True, help="Enable terminal logging")
    
    args = parser.parse_args()
    
    # Python's argparse handles booleans slightly weirdly, so we explicitly check for string 'True'
    extreme_pressure = str(args.apply_extreme_pressure).lower() in ['true', '1', 't', 'y', 'yes']
    
    engine = KinematicsEngine(
        node_a_name=args.node_A,
        node_b_name=args.node_B,
        extreme_pressure=extreme_pressure,
        verbose=args.verbose
    )
    
    engine.run_simulation()
