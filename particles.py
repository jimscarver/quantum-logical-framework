# particles.py
# Quantum version (pure logical, no QuTiP): Particle emergence in the Quantum Logical Framework
# Demonstrates: "If a state repeats in more than one way, it has more than 1 bit"
# One-bit event (single distinction) → multi-bit event via logical folding / degeneracy
# Ties directly to doubler.py, quantum_simulator.py, path_integral.py, fermi_accelerator.py
# Uses only numpy + matplotlib (framework-native)

import numpy as np
from collections import defaultdict
import matplotlib.pyplot as plt
from itertools import product

def one_bit_event():
    """Pure 1-bit event: single logical distinction, no repeats possible."""
    print("=== Quantum Logical Framework: One-Bit Event ===")
    print("Single distinction (spin-1/2 primitive).")
    print("States: |0⟩ or |1⟩")
    print("Each state reachable in exactly 1 way.")
    print("Hilbert dimension d = 2¹ = 2")
    print("Energy proxy: E = d × h × f = 2 × h × f\n")
    return {0: 1, 1: 1}  # state → ways

def multi_bit_event(n_folds=2, n_fold_types=2):
    """Logical folding: apply successive folds (Pauli-like or distinction toggles).
    If a final state can be reached by >1 sequence of folds → >1 bit."""
    print(f"=== Logical Folding: {n_folds} folds, {n_fold_types} fold types ===")
    ways = defaultdict(int)
    
    # Exhaustive enumeration of all possible fold sequences (zero-action histories)
    all_sequences = list(product(range(n_fold_types), repeat=n_folds))
    for seq in all_sequences:
        # Map sequence to observed state via a simple logical reduction
        # (in full framework this would be Pauli product or quaternion multiplication)
        # Here: sum mod (n_fold_types + 1) creates natural degeneracy
        state_id = sum(seq) % (n_fold_types + 1)
        ways[state_id] += 1
    
    print("Final states and their multiplicity (number of ways):")
    for state, count in sorted(ways.items()):
        bit_level = 1 if count == 1 else 2
        print(f"  State {state}: {count} ways → {bit_level}-bit event")
    
    max_multi = max(ways.values())
    print(f"\nMax multiplicity = {max_multi}")
    print("Any state with multiplicity > 1 encodes >1 bit (degeneracy in Hilbert space).")
    print("This is the quantum-logical birth of particles and energy scaling.\n")
    return dict(ways)

def fermi_like_multiplicity_growth(n_particles=5, n_collisions=4):
    """Fermi-style: repeated folds increase total paths exponentially.
    Higher-multiplicity states emerge naturally (statistical bias)."""
    print("=== Fermi-like Acceleration via Multiplicity Growth ===")
    print("Each collision = additional logical fold.")
    print("Higher-energy states = states reachable in more ways.\n")
    
    ways_per_step = []
    for step in range(1, n_collisions + 1):
        ways = multi_bit_event(n_folds=step, n_fold_types=2)
        ways_per_step.append(max(ways.values()))
        print(f"After {step} folds → max ways = {max(ways.values())}\n")
    
    return ways_per_step

def plot_multiplicity_demo():
    """Holographic-style plot: multiplicity defines bit count and energy."""
    fig, axs = plt.subplots(1, 2, figsize=(12, 5))
    
    # 1-bit vs multi-bit bar chart
    states_1 = ['|0⟩', '|1⟩']
    ways_1 = [1, 1]
    axs[0].bar(states_1, ways_1, color='blue', alpha=0.7)
    axs[0].set_xlabel('1-Bit States')
    axs[0].set_ylabel('Number of Ways')
    axs[0].set_title('One-Bit Event\n(Exactly 1 way per state)')
    axs[0].grid(True)
    
    # 2-fold example with degeneracy
    states_2 = ['S0', 'S1', 'S2']
    ways_2 = [1, 2, 1]
    bars = axs[1].bar(states_2, ways_2, color=['blue', 'cyan', 'blue'], alpha=0.7)
    axs[1].set_xlabel('Observed States after 2 Folds')
    axs[1].set_ylabel('Number of Ways')
    axs[1].set_title('Two-Bit Event Emergence\n(S1 reachable in 2 ways → >1 bit)')
    axs[1].grid(True)
    
    # Annotate degeneracy
    for bar, w in zip(bars, ways_2):
        if w > 1:
            axs[1].text(bar.get_x() + bar.get_width()/2, bar.get_height() + 0.1,
                        'MULTI-BIT!', ha='center', color='magenta', weight='bold')
    
    plt.suptitle('Quantum Logical Particles\n"If a state repeats in more than one way, it has more than 1 bit"')
    plt.tight_layout()
    plt.show()

if __name__ == "__main__":
    one_bit_event()
    multi_bit_event(n_folds=2, n_fold_types=2)
    fermi_like_multiplicity_growth()
    plot_multiplicity_demo()
    
    print("✅ Demonstration complete (pure logical, framework-native).")
    print("One-bit events fold into multi-bit particles via state degeneracy.")
    print("Higher multiplicity = higher d → higher E = d × h × f → gamma rays.")
    print("Run: python particles.py")
