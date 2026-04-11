"""
CONSTANTS MAPPER: Bridging QuCalc Logic to SI Units + Emergent Constants

Now fully aligned with the clarified spacetime emergence:
- Space emerges from the 3D spatial perspective (^ v < > / \)
- Time emerges as algorithmic lag in the local/gauge dimension (+ -)
"""

import math
from qucalc_engine import QuCalcEngine
from particles import IntuitionisticEngine
from gravitational_tensor import GravitationalTensor
from path_integral import DiscretePathIntegral   # for emerge_e

class ConstantsMapper:
    # ---------------------------------------------------------
    # 1. Fundamental SI Constants (CODATA recommended values)
    # ---------------------------------------------------------
    C = 299792458.0
    H_SI = 6.62607015e-34
    H_BAR = H_SI / (2 * math.pi)
    G = 6.67430e-11
    K_B = 1.380649e-23

    # ---------------------------------------------------------
    # 2. Derived Planck Units
    # ---------------------------------------------------------
    L_P = math.sqrt((H_BAR * G) / (C**3))
    T_P = math.sqrt((H_BAR * G) / (C**5))
    M_P = math.sqrt((H_BAR * C) / G)

    # ---------------------------------------------------------
    # 3. QuCalc Constants
    # ---------------------------------------------------------
    H_TOPOLOGICAL = 4.0

    def __init__(self, history_string):
        self.history = history_string
        self.total_twists = len(history_string)

    def extract_topological_action(self):
        """Now uses the exact 3D spatial vs. algorithmic lag distinction."""
        # 3D Spatial Free Action (^ v < > / \)
        spatial_v = abs(self.history.count('^') - self.history.count('v'))
        spatial_h = abs(self.history.count('<') - self.history.count('>'))
        spatial_d = abs(self.history.count('/') - self.history.count('\\'))
        
        # Local/Gauge Bound Action (+ -) → algorithmic lag
        local_l = abs(self.history.count('+') - self.history.count('-'))
        
        e_spatial_free = float(spatial_v + spatial_h + spatial_d)
        e_local_bound  = float(local_l)
        e_bound_total  = float(self.total_twists - e_spatial_free - e_local_bound) + e_local_bound
        
        return e
