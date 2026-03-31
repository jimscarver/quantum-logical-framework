"""
QUCALC ENGINE: The Generative Heart of the Possibilist Universe.
This engine implements the 8-axis directional logic and Pauli-constrained 
possibility branching. It generates history strings and filters for 
Zero Free Action (ZFA).
"""

import collections

class QuCalcEngine:
    # 8-Axis Alphabet: ^v (Vertical), <> (Horizontal), /\ (Depth), +- (Local)
    AXES = {
        'VERTICAL':   ['^', 'v'],
        'HORIZONTAL': ['<', '>'],
        'DEPTH':      ['/', '\\'],
        'LOCAL':      ['+', '-']
    }
    
    ALL_TWISTS = [t for axis in AXES.values() for t in axis]

    def __init__(self, causal_horizon=10):
        """
        The causal_horizon (Light Cone) prevents infinite recursion by 
        pruning strings that fail to close within a set length.
        """
        self.causal_horizon = causal_horizon

    def get_orthogonal_axes(self, last_twist):
        """
        Implements Pauli Exclusion Logic: A twist in one dimension 
        constrains the next fold to orthogonal or local dimensions.
        """
        if last_twist in self.AXES['VERTICAL']:
            return self.AXES['HORIZONTAL'] + self.AXES['DEPTH'] + self.AXES['LOCAL']
        if last_twist in self.AXES['HORIZONTAL']:
            return self.AXES['VERTICAL'] + self.AXES['DEPTH'] + self.AXES['LOCAL']
        if last_twist in self.AXES['DEPTH']:
            return self.AXES['VERTICAL'] + self.AXES['HORIZONTAL'] + self.AXES['LOCAL']
        # Local/Temporal twists (+/-) allow universal branching
        return self.ALL_TWISTS

    def calculate_action(self, history):
        """
        Computes the net topological action. 
        Zero Free Action (ZFA) is achieved when all axes sum to zero.
        """
        v = history.count('^') - history.count('v')
        h = history.count('<') - history.count('>')
        d = history.count('/') - history.count('\\')
        l = history.count('+') - history.count('-')
        return (v, h, d, l)

    def is_zfa(self, history):
        """Returns True if the history string represents a closed logical loop."""
        return all(net == 0 for net in self.calculate_action(history))

    def generate_possibilities(self, seed_twist):
        """
        The core 'Sum Over Histories' simulation. 
        Explores the manifold for stable, non-contradictory events.
        """
        stable_events = []
        # Queue stores (current_string)
        queue = collections.deque([seed_twist])

        print(f"--- Generating Possibilities for Seed: {seed_twist} ---")

        while queue:
            current_path = queue.popleft()

            # 1. Success Condition: Zero Free Action Found
            # We require a minimum length of 4 for a 2D boundary loop
            if len(current_path) >= 4 and self.is_zfa(current_path):
                stable_events.append(current_path)
                continue 

            # 2. Failure Condition: Causal Horizon (Light Cone) reached
            if len(current_path) >= self.causal_horizon:
                continue

            # 3. Branching: Generate next Pauli-constrained folds
            last_twist = current_path[-1]
            for next_fold in self.get_orthogonal_axes(last_twist):
                queue.append(current_path + next_fold)

        return stable_events

# --- Self-Evident Example Execution ---
if __name__ == "__main__":
    engine = QuCalcEngine(causal_horizon=6)
    
    # Starting the universe with a single 'Up' twist
    results = engine.generate_possibilities("^")
    
    print(f"\nDiscovered {len(results)} Stable History Strings (Events):")
    for event in results:
        action = engine.calculate_action(event)
        print(f" -> {event} | Action Balance: {action} (ZFA)")
