"""
QLF INTUITIONISTIC PARTICLE GENERATOR

This engine uses Constructive Intuitionistic Logic. It does not blindly 
generate all paths and filter the bad ones. Instead, it calculates the 
topological deficit (the paradox) and actively attempts to synthesize 
the exact geometric proof (Zero Free Action) required to close the loop.
"""

class IntuitionisticEngine:
    def __init__(self):
        # Primary spatial basis
        self.spatial_basis = {'^': 'v', 'v': '^', '<': '>', '>': '<'}
        
        # Secondary gauge/spin basis (Synthesized when spatial closure fails)
        self.gauge_basis = {'+': '-', '-': '+'}

    def evaluate_deficit(self, history):
        """Calculates the exact topological remainder needing to be closed."""
        net_v = history.count('^') - history.count('v')
        net_h = history.count('<') - history.count('>')   # FIXED: standardized sign
        net_g = history.count('+') - history.count('-')
        return {'v': net_v, 'h': net_h, 'g': net_g}

    def synthesize_proof(self, seed, max_depth, environment_block=False):
        """
        Attempts to constructively build a ZFA loop.
        If 'environment_block' is True, it simulates a dense vacuum that 
        forbids simple spatial closure, forcing the engine to synthesize 
        a higher-dimensional (gauge) proof.
        """
        current_path = seed
        print(f"--- Constructing ZFA Proof for Seed: '{seed}' ---")
        
        for step in range(max_depth):
            deficit = self.evaluate_deficit(current_path)
            
            # If all deficits are 0, we have successfully constructed a particle
            if deficit['v'] == 0 and deficit['h'] == 0 and deficit['g'] == 0:
                print(f"[SUCCESS] ZFA Proof Constructed: {current_path}")
                print(f"Emergent Radius (Mass): {len(current_path)}\n")
                return current_path
                
            # Actively construct the next required step based on the deficit
            appended = False
            
            # 1. Attempt standard spatial closure first
            if not environment_block:
                if deficit['v'] > 0: current_path += 'v'; appended = True
                elif deficit['v'] < 0: current_path += '^'; appended = True
                elif deficit['h'] > 0: current_path += '<'; appended = True
                elif deficit['h'] < 0: current_path += '>'; appended = True
            
            # 2. Intuitionistic Synthesis (Dialectic Resolution)
            # If the environment blocks simple space, we MUST construct a gauge solution
            if not appended:
                print(f"  [Paradox at t={step}] Spatial closure blocked. Synthesizing gauge fold...")
                # Synthesize a gauge twist to temporarily store the action
                if deficit['g'] >= 0: 
                    current_path += '-'
                else:
                    current_path += '+'
                # Release the block after stepping into the higher dimension
                environment_block = False 

        print(f"[FAILED] Unable to construct proof within depth {max_depth}.")
        print(f"Terminal Paradox State: {current_path}\n")
        return None

# --- Demonstration of Constructive Logic ---
if __name__ == "__main__":
    engine = IntuitionisticEngine()
    
    # Example 1: The Vacuum (No environmental block)
    engine.synthesize_proof(seed="^>", max_depth=6, environment_block=False)
    
    # Example 2: The Dense Context (Environmental Block)
    engine.synthesize_proof(seed="^>", max_depth=8, environment_block=True)
