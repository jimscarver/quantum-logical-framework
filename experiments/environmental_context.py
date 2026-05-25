"""
ENVIRONMENTAL CONTEXT: Unforgeable Names & Hierarchical Assembly

This module demonstrates how isolated ZFA events are "quoted" into 
Unforgeable Names, and how a parent Context uses Environments to 
bind and evaluate them into macroscopic systems.
"""

import hashlib

class QCEvent:
    def __init__(self, history_string, internal_namespace="LOCAL"):
        """
        A resolved ZFA string. Upon creation, it is sealed and 
        assigned an Unforgeable Name via cryptographic hashing.
        """
        self.history = history_string
        self.internal_namespace = internal_namespace
        self.unforgeable_name = self._generate_name()

    def _generate_name(self):
        """Generates a context-independent, unforgeable identifier (@Name)."""
        raw_identity = f"{self.internal_namespace}::{self.history}".encode('utf-8')
        hash_digest = hashlib.sha256(raw_identity).hexdigest()
        return f"@{hash_digest[:8]}"

class Environment:
    def __init__(self, binding_map=None):
        """
        The Environment dictates how a component's arbitrary local 
        axes map into the parent Context's reference frame.
        """
        self.binding_map = binding_map or {
            '^': '^', 'v': 'v', '<': '<', '>': '>', 
            '/': '/', '\\': '\\', '+': '+', '-': '-'
        }

    def evaluate(self, component_history):
        """Translates the component's internal logic into the Context's frame."""
        evaluated_path = ""
        for twist in component_history:
            evaluated_path += self.binding_map.get(twist, twist)
        return evaluated_path

class QCContext:
    def __init__(self, context_name):
        """
        A macroscopic assembly (e.g., a Proton) that holds components 
        by their Unforgeable Names and assigns them Environments.
        """
        self.context_name = context_name
        self.bound_components = {} 

    def bind_component(self, qc_event, environment):
        """
        Binds a context-independent event into the Context.
        The Context only cares about the Name and the Environment.
        """
        name = qc_event.unforgeable_name
        self.bound_components[name] = {
            "event": qc_event,
            "environment": environment
        }
        print(f"Bound component {name} to Context '{self.context_name}'.")

    def evaluate_system(self):
        """
        Evaluates the macroscopic state by asking each Unforgeable Name 
        to express itself through its assigned Environment.
        """
        print(f"\n--- Evaluating Assembly: {self.context_name} ---")
        joint_topology = ""
        
        for name, data in self.bound_components.items():
            event = data["event"]
            env = data["environment"]
            
            # The component is evaluated relationally
            expressed_logic = env.evaluate(event.history)
            joint_topology += expressed_logic
            
            print(f" Component {name} evaluated as: {expressed_logic}")

        return joint_topology

# --- Self-Evident Example Execution ---
if __name__ == "__main__":
    # 1. Three identical, isolated ZFA loops are generated.
    # In their isolated namespaces, they execute the exact same arbitrary logic.
    quark_1 = QCEvent("^<v>")
    quark_2 = QCEvent("^<v>")
    quark_3 = QCEvent("^<v>")

    print("Generated Unforgeable Names:")
    print(f" Q1: {quark_1.unforgeable_name}")
    print(f" Q2: {quark_2.unforgeable_name}")
    print(f" Q3: {quark_3.unforgeable_name}\n")

    # 2. Create the Macroscopic Context (A Proton)
    proton_context = QCContext("Proton_Nucleon")

    # 3. Define the Environments (The Hierarchical Gauge)
    # Q1 is bound in the standard orientation
    env_standard = Environment() 
    
    # Q2 is bound with a 90-degree orthogonal shift
    env_orthogonal = Environment({
        '^': '<', 'v': '>', '<': 'v', '>': '^', 
        '/': '/', '\\': '\\', '+': '+', '-': '-'
    })
    
    # Q3 is bound with a 180-degree inversion
    env_inverted = Environment({
        '^': 'v', 'v': '^', '<': '>', '>': '<', 
        '/': '/', '\\': '\\', '+': '+', '-': '-'
    })

    # 4. Assemble the System
    proton_context.bind_component(quark_1, env_standard)
    proton_context.bind_component(quark_2, env_orthogonal)
    proton_context.bind_component(quark_3, env_inverted)

    # 5. Evaluate the Macroscopic Context
    macroscopic_state = proton_context.evaluate_system()
    
    print(f"\nMacroscopic Topological State: {macroscopic_state}")
