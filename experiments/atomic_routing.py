"""
QLF ENGINE: ATOMIC ROUTING & FRACTAL MARKOV BLANKETS
Version 4.1

This script simulates the atomic structure as an Information Ecology. 
Electrons are not physical objects orbiting a nucleus; they are injected 
gauge phases required to satisfy the unresolved ZFA of the Proton Core.

The script demonstrates how the engine naturally builds the s-shell and p-shell 
by routing logic through available dimensional vectors, blocking paths (Pauli Exclusion), 
and expanding into new spatial axes to prevent topological paradoxes.
"""

import argparse
import time

class TopologicalPath:
    def __init__(self, name):
        self.name = name
        self.capacity = 2  # Each spatial path can hold 2 gauge states (+ and -)
        self.occupants = [] # Will store '+' and '-'
        
    def is_blocked(self):
        return len(self.occupants) >= self.capacity
        
    def lock_gauge(self):
        """Alternates between binding the Positive and Negative gauge phases."""
        if '+' not in self.occupants:
            self.occupants.append('+')
            return '+'
        elif '-' not in self.occupants:
            self.occupants.append('-')
            return '-'
        return None

class QuCalcAtomicEngine:
    def __init__(self, core_state, total_injections, verbose):
        self.core_state = core_state
        self.total_injections = total_injections
        self.verbose = verbose
        self.tick = 0
        
        # The Atomic Routing Hierarchy
        self.s_shell = TopologicalPath("Direct")
        self.p_shell = [
            TopologicalPath("Axis_X (< >)"),
            TopologicalPath("Axis_Y (^ v)"),
            TopologicalPath("Axis_Z (In Out)")
        ]
        
        self.p_shell_active = False

    def log(self, message, delay=0.1):
        """Standard output logger for the engine."""
        if self.verbose:
            print(message)
            if delay > 0:
                time.sleep(delay)

    def route_electron(self, electron_index):
        """
        Attempts to route the injected negative gauge to the core to 
        execute a ZFA handshake. Evaluates path-blocking strictly.
        """
        self.tick += 1
        self.log(f"\n======================================================")
        self.log(f"[*] INJECTING FLUXOID #{electron_index} (Negative Gauge)")
        self.log(f"======================================================")
        
        # 1. Evaluate the baseline route (s-shell)
        if not self.s_shell.is_blocked():
            self.tick += 1
            gauge_locked = self.s_shell.lock_gauge()
            self.log(f"[Tick {self.tick:03d}] Path [{self.s_shell.name}] evaluating... Gauge ({gauge_locked}) matched. Slot locked.")
            
            if self.s_shell.is_blocked():
                self.log(f"[Alert] Direct vector blocked. s-Shell Markov Blanket established.")
            return

        # 2. Paradox Detected (Traffic Jam at the s-shell)
        self.tick += 1
        self.log(f"[Tick {self.tick:03d}] Path [{self.s_shell.name}] evaluated... PARADOX (Traffic Jam).")
        
        if not self.p_shell_active:
            self.tick += 1
            self.log(f"[Tick {self.tick:03d}] QuCalc expanding search. Synthesizing Orthogonal Routing...")
            self.p_shell_active = True
            self.log(f"[Alert] Spatial routing initiated. p-Shell expansion underway.")
            
        # 3. Route through expanded spatial axes (p-shell)
        for path in self.p_shell:
            if not path.is_blocked():
                self.tick += 1
                gauge_locked = path.lock_gauge()
                self.log(f"[Tick {self.tick:03d}] Path [{path.name}] established. Gauge ({gauge_locked}) matched. Slot locked.")
                
                # Check if entire p-shell is now full
                if all(p.is_blocked() for p in self.p_shell):
                    self.log(f"[Alert] All orthogonal vectors blocked. p-Shell Markov Blanket established (Noble Gas state).")
                return

        # 4. Total Saturation (Beyond Neon/10 electrons for this basic demo)
        self.log(f"[Tick {self.tick:03d}] CRITICAL: All local atomic vectors blocked. Engine requires d-shell synthesis.")

    def run_simulation(self):
        self.log("======================================================")
        self.log("[QLF ENGINE v4.1] FRACTAL MARKOV BLANKET SYNTHESIS")
        self.log("======================================================")
        self.log(f"[*] Core State Evaluated : {self.core_state}")
        self.log(f"[*] Core Topology        : Dense Left-Handed Knot (Unresolved ZFA)")
        self.log(f"[*] Environmental Demand : Resolving {self.total_injections} gauge conjugations.\n")
        
        for i in range(1, self.total_injections + 1):
            self.route_electron(i)
            
        self.log("\n======================================================")
        self.log("STRUCTURAL ANALYSIS REPORT")
        self.log("======================================================")
        self.log(f"Total Free Action Resolved : {self.total_injections}")
        self.log(f"s-Shell Occupancy          : {len(self.s_shell.occupants)} / 2")
        
        p_occupants = sum(len(p.occupants) for p in self.p_shell)
        self.log(f"p-Shell Occupancy          : {p_occupants} / 6")
        
        if self.total_injections == 10:
            self.log("Status: PERFECT ZFA GEOMETRY (Neon Equivalent).")
            self.log("The atom is completely topologically sealed. It will not interact chemically.")
        else:
            self.log("Status: Reactive. The outer Markov Blanket has open topological slots.")
        self.log("======================================================")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="QLF Atomic Routing Simulator")
    parser.add_argument("--core_state", type=str, default="Proton_Cluster", help="State of the dense logical core")
    parser.add_argument("--inject_electrons", type=int, default=3, help="Number of negative gauge fluxoids to inject")
    parser.add_argument("--verbose", type=bool, default=True, help="Enable terminal logging")
    
    args = parser.parse_args()
    
    # Argparse boolean handling
    verbose_flag = str(args.verbose).lower() in ['true', '1', 't', 'y', 'yes']
    
    engine = QuCalcAtomicEngine(
        core_state=args.core_state,
        total_injections=args.inject_electrons,
        verbose=verbose_flag
    )
    
    engine.run_simulation()
