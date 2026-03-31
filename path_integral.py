"""
DISCRETE PATH INTEGRAL: Sum Over Histories in the Possibilist Universe.

This module replaces the continuous Lagrangian with a discrete topological action.
It calculates the complex probability amplitude (Propagator) by summing
over all Pauli-permitted history strings. The 'classical trajectory' mechanically 
emerges as the strings with the stationary phase (Zero Free Action).
"""

import cmath
import math

class DiscretePathIntegral:
    def __init__(self, action_quantum=math.pi / 2):
        """
        Initializes the Path Integral calculator.
        `action_quantum` represents the fundamental phase shift induced by a 
        single unbalanced topological twist.
        """
        self.action_quantum = action_quantum

    def calculate_topological_action(self, history):
        """
        The discrete Action (S) of a history string is its net topological 
        deviation from the Void (Identity/ZFA).
        Calculated as the L1 norm (Manhattan distance) across the 4 logical axes.
        """
        v = history.count('^') - history.count('v')
        h = history.count('<') - history.count('>')
        d = history.count('/') - history.count('\\')
        l = history.count('+') - history.count('-')
        
        # Action is the sum of the absolute un-canceled twists
        action = abs(v) + abs(h) + abs(d) + abs(l)
        return action

    def compute_amplitude(self, history):
        """
        Calculates the complex amplitude for a single history string: e^(i * S * quantum)
        If the path is perfectly ZFA, Action = 0, meaning Amplitude = e^0 = 1 (Constructive).
        Unbalanced paths receive a rotating complex phase causing destructive interference.
        """
        S = self.calculate_topological_action(history)
        phase = S * self.action_quantum
        
        # cmath.rect(r, phi) returns the complex number r * e^(i * phi)
        amplitude = cmath.rect(1.0, phase)
        return amplitude, S

    def calculate_propagator(self, candidate_histories):
        """
        The Sum Over Histories. Calculates the total propagator (K) by summing 
        the complex amplitudes of all possible topological paths.
        Identifies the 'Classical Paths' representing the stationary phase.
        """
        total_amplitude = 0j
        classical_paths = []
        min_action = float('inf')

        for history in candidate_histories:
            amp, S = self.compute_amplitude(history)
            total_amplitude += amp
            
            # The Classical Path is mechanically the path of Least Action
            if S < min_action:
                min_action = S
                classical_paths = [history]
            elif S == min_action:
                classical_paths.append(history)

        # Normalize the total propagator by the number of histories explored
        N = len(candidate_histories)
        if N > 0:
            total_amplitude /= N

        return {
            "propagator_amplitude": total_amplitude,
            "probability": abs(total_amplitude)**2,
            "classical_paths": classical_paths,
            "minimum_action": min_action
        }

# --- Self-Evident Example Execution ---
if __name__ == "__main__":
    path_integral = DiscretePathIntegral()
    
    # A raw sample of generated histories from a seed twist.
    # In a full simulation, these are provided by `qucalc_engine.py`
    candidate_paths = [
        "^<v>",         # Closed 2D Loop (Action = 0)
        "^^<<vv>>",     # Complex Closed Loop (Action = 0)
        "^</+",         # Open Path (Action = 4)
        "^>v-",         # Open Path (Action = 2)
        "^<v>^+-"       # Almost Closed (Action = 1)
    ]
    
    print("--- Computing Discrete Path Integral ---")
    results = path_integral.calculate_propagator(candidate_paths)
    
    # Format the complex number for clean output
    amp = results['propagator_amplitude']
    formatted_amp = f"{amp.real:.4f} + {amp.imag:.4f}j"
    
    print(f"\nTotal Propagator Amplitude (K): {formatted_amp}")
    print(f"Emergent Probability (|K|^2): {results['probability']:.4f}")
    
    print(f"\nClassical Paths Identified (Stationary Phase, Action = {results['minimum_action']}):")
    for path in results['classical_paths']:
        print(f" [+] {path} -> Contributes coherently")
