"""
TUTORIAL 01: THE BELL STATE (ENTANGLEMENT)
---------------------------------------------------------
In standard quantum mechanics, a Bell State represents two particles 
that are maximally entangled. Measuring one instantly determines the 
state of the other. 

In the Quantum Logical Framework (QLF), there is no "spooky action." 
Entanglement is simply the geometric requirement of Joint Zero Free Action.
If two unforgeable names share a Context, their combined relational 
twists MUST mathematically cancel out to survive in the universe.

This tutorial demonstrates how to assemble a Bell State in QuCalc.
"""

class QuCalcComponent:
    def __init__(self, history, name):
        self.history = history
        self.name = name

class BellStateContext:
    def __init__(self):
        self.context_name = "Interaction_Manifold_Phi_Plus"
        
    def evaluate_joint_zfa(self, component_a, component_b, env_a, env_b):
        """
        Evaluates if the two components can coexist as an entangled system.
        They must balance out to Zero Free Action in the shared context.
        """
        # Apply the environmental gauges
        expressed_a = env_a(component_a.history)
        expressed_b = env_b(component_b.history)
        
        joint_history = expressed_a + expressed_b
        
        # Check ZFA (Topological cancellation)
        v = joint_history.count('^') - joint_history.count('v')
        h = joint_history.count('>') - joint_history.count('<')
        
        is_entangled = (v == 0 and h == 0)
        
        print(f"Evaluating System: {self.context_name}")
        print(f"  {component_a.name} expressed as: {expressed_a}")
        print(f"  {component_b.name} expressed as: {expressed_b}")
        print(f"  Joint Topology: {joint_history}")
        
        if is_entangled:
            print("  Result: SUCCESS. Joint ZFA achieved. The system is ENTANGLED.")
        else:
            print("  Result: FAILURE. Topological contradiction. Strings scatter.")

# ---------------------------------------------------------
# EXECUTION: Replicating the |Phi+> State
# ---------------------------------------------------------
if __name__ == "__main__":
    print("--- QLF Tutorial 01: Bell State Entanglement ---\n")

    # 1. Create two isolated, context-independent particles.
    # In their own namespaces, they both execute an arbitrary 'Up-Left' logic.
    particle_1 = QuCalcComponent("^<", "@Particle_1")
    particle_2 = QuCalcComponent("^<", "@Particle_2")

    # 2. Establish the Interaction Context
    context = BellStateContext()

    # 3. Define the Environments (The Hierarchical Gauges)
    # To simulate the entangled creation of a particle pair (like an electron 
    # and positron splitting from a photon), they are emitted with opposite gauges.
    
    # Particle 1 is bound in the identity environment
    env_identity = lambda x: x 
    
    # Particle 2 is bound in a fully inverted environment
    env_inverted = lambda x: x.translate(str.maketrans('^<v>', 'v>^<'))

    # 4. Evaluate the System
    # If Particle 1 twists ^<, Particle 2 is logically FORCED to twist v> 
    # relative to the shared context to maintain Unitarity.
    context.evaluate_joint_zfa(particle_1, particle_2, env_identity, env_inverted)
