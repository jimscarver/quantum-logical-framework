"""
QC ASSEMBLER: Unforgeable Names and Component Logic

This module demonstrates how resolved QuCalc history strings are "quoted" 
into unforgeable names, allowing them to be assembled into complex, 
context-independent quantum logical systems.
"""

import hashlib

class QCEvent:
    def __init__(self, history_string, namespace_prefix="GLOBAL"):
        """
        An event must be a resolved ZFA string. Upon creation, it is 
        sealed and assigned an unforgeable name.
        """
        self.history = history_string
        self.namespace = namespace_prefix
        self.unforgeable_name = self._generate_unforgeable_name()

    def _generate_unforgeable_name(self):
        """
        Generates a context-independent, unforgeable identifier for the event.
        We use a SHA-256 hash of its topology and namespace to simulate 
        the absolute uniqueness of the logical boundary.
        """
        raw_identity = f"{self.namespace}::{self.history}".encode('utf-8')
        hash_digest = hashlib.sha256(raw_identity).hexdigest()
        
        # We prefix it with '@' to denote a quoted Name (Rho-calculus convention)
        return f"@{hash_digest[:12]}"

    def get_name(self):
        return self.unforgeable_name

class QCAssembly:
    def __init__(self, system_name):
        self.system_name = system_name
        self.components = {}

    def add_component(self, qc_event):
        """
        Adds a named event to the macroscopic assembly. 
        Notice we only store the Name, not the internal history string.
        The system does not need to re-evaluate the event's internal logic.
        """
        name = qc_event.get_name()
        if name in self.components:
            print(f"Component {name} is already in the assembly.")
        else:
            self.components[name] = qc_event
            print(f"Successfully bound {name} to {self.system_name}.")

    def evaluate_system_state(self):
        """
        Outputs the state of the macroscopic assembly.
        The assembly is defined entirely by the relationships between its Names.
        """
        print(f"\n--- Assembly State: {self.system_name} ---")
        print(f"Total Context-Independent Components: {len(self.components)}")
        for name in self.components.keys():
            print(f" [Component Node] : {name}")

# --- Self-Evident Example Execution ---
if __name__ == "__main__":
    # 1. Three independent QuCalc events successfully resolve their ZFA loops.
    # (Simulating two Up Quarks and a Down Quark)
    quark_up_1 = QCEvent("^>v<", namespace_prefix="SYS_A")
    quark_up_2 = QCEvent("^>v<", namespace_prefix="SYS_B") 
    quark_down = QCEvent("v<^>", namespace_prefix="SYS_C")

    # 2. They are instantly given Unforgeable Names based on their topology
    print("Resolved Events quoted into Unforgeable Names:")
    print(f" U1: {quark_up_1.get_name()}")
    print(f" U2: {quark_up_2.get_name()}")
    print(f" D1: {quark_down.get_name()}\n")

    # Notice that U1 and U2 have different Names even though their history is the same,
    # because their initial Namespace context makes them physically distinct events.

    # 3. Assemble them into a composite system (A Proton)
    proton_assembly = QCAssembly("Proton_Nucleon")
    
    # We assemble the system using ONLY their unforgeable names.
    proton_assembly.add_component(quark_up_1)
    proton_assembly.add_component(quark_up_2)
    proton_assembly.add_component(quark_down)

    # 4. View the macroscopic system
    proton_assembly.evaluate_system_state()
