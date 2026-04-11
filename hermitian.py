# QuCalc: Hermitian Conjugate and Zero Free Action Action correspondence test

# 1. Define the conjugate mapping for the 8-axis logic
CONJUGATE_MAP = {
    '^': 'v', 'v': '^',
    '<': '>', '>': '<',
    '/': '\\', '\\': '/',
    '+': '-', '-': '+'
}

def get_hermitian_conjugate(history_string):
    """
    Calculates the adjoint evolution (H_dagger) of a QuCalc history string.
    Rule: Reverse the sequence and invert each operator.
    """
    # Reverse the string
    reversed_sequence = history_string[::-1]
    # Invert each twist
    conjugate_sequence = "".join([CONJUGATE_MAP[twist] for twist in reversed_sequence])
    return conjugate_sequence

def is_zero_free_action(history_string):
    """
    Evaluates if a string inherently balances to zero free action.
    """
    vertical = history_string.count('^') - history_string.count('v')
    horizontal = history_string.count('<') - history_string.count('>')
    depth = history_string.count('/') - history_string.count('\\')
    local = history_string.count('+') - history_string.count('-')
    
    return (vertical == 0 and horizontal == 0 and depth == 0 and local == 0)

def test_hermitian_closure(candidate_event):
    """
    Tests if an event and its Hermitian conjugate close to Zero Free Action.
    """
    print(f"Testing Candidate Event (E): {candidate_event}")
    
    # Generate E_dagger
    e_dagger = get_hermitian_conjugate(candidate_event)
    print(f"Hermitian Conjugate (E_dagger): {e_dagger}")
    
    # The Full Adjoint Evolution: E * E_dagger
    evolution_cycle = candidate_event + e_dagger
    print(f"Evolution Cycle (E + E_dagger): {evolution_cycle}")
    
    # Test for exact closure (ZFA)
    if is_zero_free_action(evolution_cycle):
        print("RESULT: SUCCESS. The adjoint evolution closed perfectly (Zero Free Action = True).\n")
        return True
    else:
        print("RESULT: FAILURE. Topological contradiction detected.\n")
        return False

# --- Clean Demonstration ---
if __name__ == "__main__":
    print("=== Hermitian Closure Tests ===\n")
    
    # Test 1: Simple 2D fold
    test_hermitian_closure("^<")
    
    # Test 2: Minimal 3D/temporal candidate
    test_hermitian_closure("^v")
    
    # Test 3: A known good closed history
    test_hermitian_closure("^<v>")
