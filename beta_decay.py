"""
QLF BETA DECAY SIMULATOR: Markov Blanket Restructuring

This module models the topological decay of a free Neutron into a Proton,
an Electron, and a Majorana neutrino. It illustrates that Beta Decay is a
strict computational re-allocation of logical twists to achieve a more stable
Zero Free Action (ZFA) state.

The neutrino is MAJORANA — its own antiparticle. In QLF the antiparticle is the
Hermitian conjugate: conjugate each twist AND reverse the order, since the adjoint
of a product reverses it, (A·B·C)† = C†·B†·A†. A particle is its own antiparticle
exactly when its twist string is a FIXED POINT of this conjugate-and-reverse map.
The neutrino loop `^v` is such a fixed point; the electron loop `^<v>` is not (its
conjugate is the distinct positron, so the charged lepton is Dirac). This matches
the machine-verified Lean theorems `neutrino_majorana` / `electron_not_majorana`
(lean/QLF_Majorana.lean). Pure Python.
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

    def antiparticle(self):
        """Hermitian conjugate = conjugate each twist AND reverse the order."""
        conj = {'^': 'v', 'v': '^', '<': '>', '>': '<',
                '/': '\\', '\\': '/', '+': '-', '-': '+'}
        return "".join(conj.get(c, c) for c in reversed(self.topology))

    def is_majorana(self):
        """Majorana (its own antiparticle) iff a fixed point of the conjugate."""
        return self.topology == self.antiparticle()


class BetaDecayEngine:
    def __init__(self):
        # Proton: a stable Markov blanket (ZFA balanced)
        self.proton = QuCalcParticle("Proton", "^>v<^^vv", is_chiral=True)

        # Electron: a tightly bound left-handed chiral trap (Dirac — distinct positron)
        self.electron = QuCalcParticle("Electron", "^<v>", is_chiral=True)

        # Majorana neutrino: a non-chiral loop that is its own Hermitian conjugate
        self.neutrino = QuCalcParticle("Majorana Neutrino", "^v", is_chiral=False)

        neutron_topology = (self.proton.topology + self.electron.topology
                            + self.neutrino.topology)
        self.neutron = QuCalcParticle("Neutron (Stressed Blanket)", neutron_topology, is_chiral=True)

    def verify_global_zfa(self, particles):
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
        print(f"Net Action: {self.neutron.get_net_action()} (Stable ZFA Loop)")

        print("\n--> TOPOLOGICAL STRESS DETECTED. INITIATING UNSPOOLING -->")

        products = [self.proton, self.electron, self.neutrino]
        print(f"\n[Final State: Decay Products]")
        for p in products:
            status = "[MAJORANA / SELF-CONJUGATE]" if p.is_majorana() else "[DIRAC / DISTINCT ANTIPARTICLE]"
            print(f"- {p.name:<22} | Topology: {p.topology:<10} | {status}")

        nu = self.neutrino
        print(f"\n[Neutrino nature]")
        print(f"  neutrino          = {nu.topology}")
        print(f"  antiparticle (†)  = {nu.antiparticle()}   (equal => its own antiparticle => Majorana)")
        e = self.electron
        print(f"  electron          = {e.topology}")
        print(f"  antiparticle (†)  = {e.antiparticle()}   (distinct => the positron => Dirac)")
        print(f"  => neutrino Majorana: lepton number violated; 0vbb is the signature.")

        print("\n[Conservation Check]")
        print(f"Initial Net Action : {self.neutron.get_net_action()}")
        print(f"Products Net Action: {{'vertical': 0, 'horizontal': 0}}")
        print("RESULT: EXACT LOGICAL CONSERVATION ACHIEVED."
              if self.verify_global_zfa(products) else "RESULT: ZFA VIOLATION.")


if __name__ == "__main__":
    BetaDecayEngine().simulate_decay()
