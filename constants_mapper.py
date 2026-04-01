"""
CONSTANTS MAPPER: Bridging QuCalc Logic to SI Units

This module translates the dimensionless topological outputs of the 
Quantum Logical Framework (QLF) into standard SI units (meters, seconds, 
kilograms, Joules) for direct comparison with experimental physics.
"""

import math

class ConstantsMapper:
    # ---------------------------------------------------------
    # 1. Fundamental SI Constants (CODATA recommended values)
    # ---------------------------------------------------------
    C = 299792458.0                  # Speed of light in vacuum (m/s)
    H_SI = 6.62607015e-34            # Planck constant (J*s)
    H_BAR = H_SI / (2 * math.pi)     # Reduced Planck constant (J*s)
    G = 6.67430e-11                  # Gravitational constant (m^3/(kg*s^2))
    K_B = 1.380649e-23               # Boltzmann constant (J/K)

    # ---------------------------------------------------------
    # 2. Derived Planck Units (The QuCalc Baseline)
    # ---------------------------------------------------------
    # 1 QuCalc Spatial Twist = 1 Planck Length
    L_P = math.sqrt((H_BAR * G) / (C**3))  # ~1.616e-35 meters

    # 1 QuCalc Temporal Step = 1 Planck Time
    T_P = math.sqrt((H_BAR * G) / (C**5))  # ~5.391e-44 seconds

    # Planck Mass (Maximal bounding mass of a fundamental twist)
    M_P = math.sqrt((H_BAR * C) / G)       # ~2.176e-8 kilograms

    # ---------------------------------------------------------
    # 3. QuCalc Constants
    # ---------------------------------------------------------
    H_TOPOLOGICAL = 4.0  # Minimum twists for a 2D ZFA boundary loop

    def __init__(self, history_string):
        self.history = history_string
        self.total_twists = len(history_string)

    def extract_topological_action(self):
        """Calculates Free Action (Space) and Bound Action (Time/Mass)."""
        net_v = abs(self.history.count('^') - self.history.count('v'))
        net_h = abs(self.history.count('<') - self.history.count('>'))
        net_d = abs(self.history.count('/') - self.history.count('\\'))
        net_l = abs(self.history.count('+') - self.history.count('-'))
        
        e_free = float(net_v + net_h + net_d + net_l)
        e_bound = float(self.total_twists - e_free)
        
        return e_free, e_bound

    def to_macroscopic_space(self, e_free):
        """
        Converts Free Action into SI Meters.
        x_logical = E_free / H_topological
        x_meters = x_logical * Planck Length
        """
        if e_free == 0:
            return 0.0
        logical_space = e_free / self.H_TOPOLOGICAL
        return logical_space * self.L_P

    def to_macroscopic_time(self, steps):
        """
        Converts Logical Execution Steps into SI Seconds.
        t_seconds = steps * Planck Time
        """
        return float(steps) * self.T_P

    def to_macroscopic_mass(self, e_bound):
        """
        Converts Bound Action (ZFA Loops) into SI Kilograms.
        Using E = hf and E = mc^2.
        1. Calculate logical frequency (loops per step).
        2. Convert to SI frequency (Hz).
        3. Convert to Joules, then to Kilograms.
        """
        if e_bound <= 0:
            return 0.0, 0.0
            
        # Number of ZFA loops in this string
        logical_loops = e_bound / self.H_TOPOLOGICAL
        
        # Frequency = loops / total execution steps
        logical_frequency = logical_loops / self.total_twists
        
        # Convert logical frequency to Hz (cycles per second)
        frequency_hz = logical_frequency / self.T_P
        
        # E = hf (Joules)
        energy_joules = self.H_SI * frequency_hz
        
        # m = E / c^2 (Kilograms)
        mass_kg = energy_joules / (self.C**2)
        
        # Convert to a more readable particle scale (Electron Volts: eV/c^2)
        # 1 eV = 1.602176634e-19 Joules
        mass_ev = energy_joules / 1.602176634e-19
        
        return mass_kg, mass_ev

    def to_macroscopic_entropy(self, e_bound):
        """
        Converts Bound Action into physical thermodynamic entropy (Joules/Kelvin).
        1 ZFA Loop = 1 bit of Bekenstein-Hawking Entropy.
        S = k_B * ln(2) * bits
        """
        bits = e_bound / self.H_TOPOLOGICAL
        entropy_jk = self.K_B * math.log(2) * bits
        return bits, entropy_jk

    def generate_laboratory_report(self):
        """Compiles the logical string into a measurable SI data readout."""
        e_free, e_bound = self.extract_topological_action()
        
        length_m = self.to_macroscopic_space(e_free)
        time_s = self.to_macroscopic_time(self.total_twists)
        mass_kg, mass_ev = self.to_macroscopic_mass(e_bound)
        bits, entropy = self.to_macroscopic_entropy(e_bound)

        report = (
            f"--- QLF Laboratory Translation Report ---\n"
            f"History String : {self.history}\n"
            f"Logical Steps  : {self.total_twists}\n\n"
            f"[Spatial Dimensions]\n"
            f"  Free Action  : {e_free} twists\n"
            f"  Length (SI)  : {length_m:.6e} meters\n\n"
            f"[Temporal Dimensions]\n"
            f"  Execution    : {time_s:.6e} seconds\n\n"
            f"[Mass & Energy (E=mc^2)]\n"
            f"  Bound Action : {e_bound} twists\n"
            f"  Mass (SI)    : {mass_kg:.6e} kg\n"
            f"  Mass (eV)    : {mass_ev:.6e} eV/c^2\n\n"
            f"[Thermodynamics]\n"
            f"  Information  : {bits} bits\n"
            f"  Entropy (SI) : {entropy:.6e} J/K\n"
            f"-----------------------------------------"
        )
        return report

# --- Self-Evident Example Execution ---
if __name__ == "__main__":
    # Test 1: A purely radiative string (Photon-like)
    photon = "^^^^<<<<////" 
    mapper_photon = ConstantsMapper(photon)
    
    # Test 2: A highly bound string (Massive Particle-like)
    fermion = "^>v<^>v<^^>><<vv" 
    mapper_fermion = ConstantsMapper(fermion)

    print(mapper_photon.generate_laboratory_report())
    print("\n")
    print(mapper_fermion.generate_laboratory_report())
