"""
Muon Lifetime in the Quantum Logical Framework (QLF)
Shows how moving muons synthesize fewer logical bits per second
"""

import numpy as np

tau_proper = 2.197  # μs - proper lifetime in rest frame

def qlf_muon_survival(v, t_lab=10.0):
    gamma = 1 / np.sqrt(1 - v**2)
    
    # In QLF, the logical bit synthesis rate decreases with velocity
    bit_rate_factor = 1.0 / gamma   # moving system synthesizes bits slower
    
    # Calculate survival based on number of logical bits processed
    effective_proper_time = t_lab * bit_rate_factor
    survival = np.exp(-effective_proper_time / tau_proper) * 100
    
    return survival

print("Muon Survival Probability - QLF Framework")
print("=" * 50)
print("Velocity\tSurvival %\tInterpretation")
print("-" * 50)

for v in [0.0, 0.8, 0.9, 0.95, 0.99]:
    percent = qlf_muon_survival(v)
    print(f"{v:.2f}c\t\t{percent:.1f}%\t\tFewer logical bits synthesized")
