import collections

# QuCalc Alphabet: 8-Axis Directional Logic
# ^v (Vertical), <> (Horizontal), /\ (Depth), +- (Local/Temporal)
TWISTS = ['^', 'v', '<', '>', '/', '\\', '+', '-']

# Adjoint Mapping for Unitarity Check
CONJUGATE_MAP = {
    '^': 'v', 'v': '^', '<': '>', '>': '<',
    '/': '\\', '\\': '/', '+': '-', '-': '+'
}

class QuCalcSimulator:
    def __init__(self, light_cone_limit=12):
        self.limit = light_cone_limit

    def generate_next_folds(self, current_path):
        """
        Pauli-constrained expansion. 
        In QuCalc, a twist in one dimension generates possibilities 
        in orthogonal or local dimensions.
        """
        last = current_path[-1]
        if last in ['^', 'v']: return ['<', '>', '/', '\\', '+', '-']
        if last in ['<', '>']: return ['^', 'v', '/', '\\', '+', '-']
        if last in ['/', '\\']: return ['^', 'v', '<', '>', '+', '-']
        return TWISTS # Temporal twists (+/-) allow universal branching

    def evaluate_zfa(self, history):
        """
        Tests for Zero Free Action: 
        Does the topological twist-count net to zero across all axes?
        """
        net_v = history.count('^') - history.count('v')
        net_h = history.count('<') - history.count('>')
        net_d = history.count('/') - history.count('\\')
        net_l = history.count('+') - history.count('-')
        
        return all(axis == 0 for axis in [net_v, net_h, net_d, net_l])

    def simulate(self, seed):
        """
        The Core Engine: Traces all possibilities concurrently.
        Returns all stable history strings (resolved particles/events).
        """
        print(f"--- QuCalc Simulation Started: Seed '{seed}' ---")
        stable_histories = []
        queue = collections.deque([seed])

        while queue:
            path = queue.popleft()

            # 1. Check for Resolution (Zero Free Action)
            # Minimum length of 4 required for a closed 2D loop
            if len(path) >= 4 and self.evaluate_zfa(path):
                stable_histories.append(path)
                continue # Path resolved; it is now a stable "Event"

            # 2. Check for Dissipation (Light Cone Limit)
            if len(path) >= self.limit:
                continue # Information lost to background radiation

            # 3. Expand Possibilities
            for next_twist in self.generate_next_folds(path):
                queue.append(path + next_twist)

        return stable_histories

# --- Sample Execution ---
if __name__ == "__main__":
    sim = QuCalcSimulator(light_cone_limit=8)
    
    # Starting with a horizontal twist seed
    results = sim.simulate(">")
    
    print(f"\nFound {len(results)} stable ZFA history strings:")
    for r in results[:5]: # Show first 5 discovered events
        print(f" -> Event: {r}")
