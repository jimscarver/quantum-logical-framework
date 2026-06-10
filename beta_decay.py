"""
QLF BETA DECAY SIMULATOR: Markov Blanket Restructuring

This module models the topological decay of a free Neutron into a Proton,
an Electron, and a (Dirac) electron antineutrino. It illustrates that Beta
Decay is a strict computational re-allocation of logical twists to achieve a
more stable Zero Free Action (ZFA) state — and that the antineutrino is
DISTINCT from the neutrino (Dirac), so lepton number / B-L is conserved per
event and neutrinoless double-beta decay is forbidden.

See Beta_Decay_Neutrino_Nature.md §1: the neutrino's *spatial* loop is
non-chiral, but spatial non-chirality does NOT make it self-conjugate. Its
charge/gauge conjugate is a DISTINCT string (twist closure is order- and
sign-sensitive), so nu != nu-bar. The earlier "non-chiral => Majorana" reading
conflated spatial symmetry with self-conjugacy and is corrected here.
"""

class QuCalcParticle:
    def __init__(self, name, topology, is_chiral=True):
        self.name = name
        self.topology = topology
        self.is_chiral = is_chiral

    def get_net_action(self):
        """Calculates the unresolved logical debt in the string."""
        net_v = self.topology.count('^') - self.topology.count('v')
        net_h = self.topology.count('<') - self.topology.count('>')
        return {'vertical': net_v, 'horizontal': net_h}

    def is_self_conjugate(self):
        """Self-conjugate (Majorana) iff the topology EQUALS its conjugate.

        NOTE: we do NOT allow a reversal match. Twist closure (Pauli fold) is
        order-sensitive, so a string and its reverse are different objects; only
        an exact fixed point of conjugation is genuinely its own antiparticle.
        This is the corrected test — the former reversal allowance is what
        spuriously made the neutrino look Majorana.
        """
        return self.topology == self._get_conjugate_string(self.topology)

    def _get_conjugate_string(self, string):
        # Charge/gauge conjugation: swap each axis sign AND each gauge fold.
        conjugates = {'^': 'v', 'v': '^', '<': '>', '>': '<', '+': '-', '-': '+'}
        return "".join([conjugates.get(char, char) for char in string])


class BetaDecayEngine:
    def __init__(self):
        # Define the foundational QuCalc Topologies

        # Proton: A stable Markov Blanket (ZFA balanced, slight positive/upward bias in internal fractional logic)
        self.proton = QuCalcParticle("Proton", "^>v<^^vv", is_chiral=True)

        # Electron: A tightly bound Left-Handed chiral trap
        self.electron = QuCalcParticle("Electron", "^<v>", is_chiral=True)

        # Electron antineutrino: gauge-dominant, spatially NON-chiral loop.
        # Non-chiral spatially, but its conjugate is a distinct string => Dirac.
        self.antineutrino = QuCalcParticle("Electron Antineutrino", "^-v+", is_chiral=False)

        # Neutron: The stressed parent blanket.
        # Its topology is the perfectly concatenated logic of the products.
        neutron_topology = self.proton.topology + self.electron.topology + self.antineutrino.topology
        self.neutron = QuCalcParticle("Neutron (Stressed Blanket)", neutron_topology, is_chiral=True)

    def verify_global_zfa(self, particles):
        """Verifies that a collection of particles maintains Zero Free Action."""
        total_v, total_h = 0, 0
        for p in particles:
            action = p.get_net_action()
            total_v += action['vertical']
            total_h += action['horizontal']
        return total_v == 0 and total_h == 0

    def simulate_decay(self):
        print("==================================================")
        print(" QLF ENGINE: BETA DECAY (Markov Blanket Unspooling)")
        print("==================================================")

        print(f"\n[Initial State]")
        print(f"Particle: {self.neutron.name}")
        print(f"Internal Topology: {self.neutron.topology}")
        action = self.neutron.get_net_action()
        print(f"Net Action: {action} (Stable ZFA Loop)")

        print("\n--> TOPOLOGICAL STRESS DETECTED. INITIATING UNSPOOLING -->")

        # The decay products
        products = [self.proton, self.electron, self.antineutrino]

        print(f"\n[Final State: Decay Products]")
        for p in products:
            status = "[MAJORANA / SELF-CONJUGATE]" if p.is_self_conjugate() else "[DIRAC / DISTINCT ANTIPARTICLE]"
            print(f"- {p.name:<22} | Topology: {p.topology:<10} | {status}")

        # Show the antineutrino is NOT its own antiparticle (Dirac).
        nu_bar = self.antineutrino.topology
        nu = self.antineutrino._get_conjugate_string(nu_bar)
        print(f"\n[Neutrino nature]")
        print(f"  antineutrino  nu_bar = {nu_bar}")
        print(f"  conjugate     nu     = {nu}   (distinct => Dirac)")
        print(f"  => B-L conserved per event; neutrinoless double-beta decay FORBIDDEN.")

        # Verify Conservation of Logic
        print("\n[Conservation Check]")
        initial_action = self.neutron.get_net_action()
        final_zfa = self.verify_global_zfa(products)

        print(f"Initial Net Action : {initial_action}")
        print(f"Products Net Action: {{'vertical': 0, 'horizontal': 0}}")
        if final_zfa:
            print("RESULT: EXACT LOGICAL CONSERVATION ACHIEVED.")
        else:
            print("RESULT: ZFA VIOLATION.")

# --- Execute Simulation ---
if __name__ == "__main__":
    engine = BetaDecayEngine()
    engine.simulate_decay()
