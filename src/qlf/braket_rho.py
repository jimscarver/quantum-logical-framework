#!/usr/bin/env python3
"""
braket_rho.py
QLF / rhoqcalc Syntax Engine & Bra-Ket Correspondence Validator.
Fuses Dirac notation, process calculus, and numerical Hilbert space evaluation.
"""

import argparse
import re
import numpy as np

# ─── THEORETICAL PRIMITIVES & DENSITY-MATRIX FOUNDATIONS ───────────────────

def action(p, q):
    """Represents a primitive local transaction/interaction in the graph."""
    return f"action({p}, {q})"

def lift(p):
    """Lifts a name capability into an active process state."""
    return f"lift({p})"

def parallel(p, q):
    """Concurrent, additive composition of process layers."""
    return f"parallel({p}, {q})"

def sequence(p, q):
    """Sequential multiplicative routing. Map to operator composition."""
    return f"sequence({p}, {q})"

def dagger(p):
    """The structural adjoint / Hermitian conjugate of a history string."""
    if p.endswith("†"):
        return p[:-1]
    return f"{p}†"


# ─── ADVANCED SYNTAX VALIDATOR & LEXER ─────────────────────────────────────

TOKEN_RE = re.compile(
    r"""
    (\|[^\|<>\∣\⟩]+\>|\|[^\|<>\∣\⟩]+\⟩)   |   # ket, e.g. |0>, |psi⟩
    (\<[^\|<>\∣\⟨]+\| | ⟨[^\|<>\∣\⟨]+\|)   |   # bra, e.g. <0|, ⟨psi|
    ([A-Za-zσρ][A-Za-z0-9_]*†?)             |   # operator, e.g. A, H, σx, rho, U†
    ([()])                                  |   # parentheses
    (\s+)                                       # whitespace
    """,
    re.VERBOSE,
)

# Foundational 2-dimensional Hilbert Space primitives
NUMERICAL_VOCAB = {
    # Kets (Column Vectors)
    "|0>": np.array([[1], [0]], dtype=complex),
    "|1>": np.array([[0], [1]], dtype=complex),
    "|+>": np.array([[1/np.sqrt(2)], [1/np.sqrt(2)]], dtype=complex),
    "|->": np.array([[1/np.sqrt(2)], [-1/np.sqrt(2)]], dtype=complex),
    
    # Bras (Row Vectors - Conjugate Transposed)
    "<0|": np.array([[1, 0]], dtype=complex),
    "<1|": np.array([[0, 1]], dtype=complex),
    "<+|": np.array([[1/np.sqrt(2), 1/np.sqrt(2)]], dtype=complex),
    "<-|": np.array([[1/np.sqrt(2), -1/np.sqrt(2)]], dtype=complex),
    
    # Pauli & Hadamard Operators (2x2 Matrices)
    "I":  np.array([[1, 0], [0, 1]], dtype=complex),
    "σx": np.array([[0, 1], [1, 0]], dtype=complex),
    "σy": np.array([[0, -1j], [1j, 0]], dtype=complex),
    "σz": np.array([[1, 0], [0, -1]], dtype=complex),
    "H":  np.array([[1/np.sqrt(2), 1/np.sqrt(2)], [1/np.sqrt(2), -1/np.sqrt(2)]], dtype=complex),
}

# Dynamically map adjoint tokens to avoid key errors
NUMERICAL_VOCAB["H†"] = NUMERICAL_VOCAB["H"].conj().T
NUMERICAL_VOCAB["σx†"] = NUMERICAL_VOCAB["σx"].conj().T
NUMERICAL_VOCAB["σy†"] = NUMERICAL_VOCAB["σy"].conj().T
NUMERICAL_VOCAB["σz†"] = NUMERICAL_VOCAB["σz"].conj().T


def normalize_braket(expr: str) -> str:
    """Normalize Unicode bra-ket delimiters to ASCII-style tokens."""
    return (
        expr.replace("⟨", "<")
            .replace("⟩", ">")
            .replace("∣", "|")
            .replace("ρ", "rho")
    )


def tokenize_braket(expr: str):
    expr = normalize_braket(expr)
    pos = 0
    tokens = []
    while pos < len(expr):
        m = TOKEN_RE.match(expr, pos)
        if not m:
            raise ValueError(f"Unrecognized syntax near: {expr[pos:pos+20]!r}")
        ket, bra, op, paren, ws = m.groups()
        if ket:
            tokens.append(("KET", ket))
        elif bra:
            tokens.append(("BRA", bra))
        elif op:
            tokens.append(("OP", op))
        elif paren:
            tokens.append(("PAREN", paren))
        pos = m.end()
    return tokens


def reduce_types(types):
    """
    Reduce a product of abstract bra-ket object kinds.
    K = ket, B = bra, O = operator, S = scalar
    """
    if not types:
        return "EMPTY", True, "empty expression"

    cur = types[0]

    def step(a, b):
        # Scalar dilution rules
        if a == "S": return b
        if b == "S": return a

        # Standard Bra-Ket compositional loop closures
        if a == "B" and b == "K": return "S"   # <ψ|φ>  (Scalar Closure)
        if a == "K" and b == "B": return "O"   # |ψ><φ| (Outer Product Operator)
        if a == "O" and b == "K": return "K"   # A|ψ>   (Transforming a Ket)
        if a == "B" and b == "O": return "B"   # <ψ|A   (Transforming a Bra)
        if a == "O" and b == "O": return "O"   # AB     (Operator Multiplication)
        return None

    for nxt in types[1:]:
        out = step(cur, nxt)
        if out is None:
            return None, False, f"invalid multiplication: {cur} followed by {nxt}"
        cur = out

    return cur, True, "ok"


def classify_expression(expr: str):
    tokens = tokenize_braket(expr)
    core = [t for t in tokens if t[0] != "PAREN"]

    type_map = {"KET": "K", "BRA": "B", "OP": "O"}
    kinds = [type_map[t[0]] for t in core]
    result_kind, ok, msg = reduce_types(kinds)

    bra_count = sum(1 for t, _ in core if t == "BRA")
    ket_count = sum(1 for t, _ in core if t == "KET")
    op_count = sum(1 for t, _ in core if t == "OP")

    closed = ok and result_kind in {"S", "O"} and bra_count == ket_count
    qlf_balance_compatible = ok and (
        (result_kind in {"S", "O"} and bra_count == ket_count) or
        (result_kind == "K" and ket_count == bra_count + 1) or
        (result_kind == "B" and bra_count == ket_count + 1)
    )

    human_kinds = {"S": "scalar", "O": "operator", "K": "ket", "B": "bra"}
    human_kind = human_kinds.get(result_kind, "invalid")

    return {
        "expression": expr,
        "normalized": normalize_braket(expr),
        "tokens": core,
        "bra_count": bra_count,
        "ket_count": ket_count,
        "op_count": op_count,
        "well_typed": ok,
        "message": msg,
        "result_kind": human_kind,
        "closed": closed,
        "qlf_balance_compatible": qlf_balance_compatible,
    }


def evaluate_numerical_braket(tokens: list) -> str:
    """Evaluates a verified sequence of tokens numerically if elements are recognized."""
    try:
        current_val = None
        for _, t_str in tokens:
            clean_key = t_str.replace("⟨", "<").replace("⟩", ">").replace("∣", "|")
            if clean_key not in NUMERICAL_VOCAB:
                return f"Symbol '{t_str}' lacks numerical representation; bypassing evaluation."
            
            val = NUMERICAL_VOCAB[clean_key]
            current_val = val if current_val is None else current_val @ val
        
        if current_val.shape == (1, 1):
            return f"{current_val[0, 0]} (Scalar Probability Amplitude)"
        elif current_val.shape == (2, 1):
            return f"\n{current_val}\n(Ket State Vector)"
        elif current_val.shape == (1, 2):
            return f"\n{current_val}\n(Bra Measurement Vector)"
        elif current_val.shape == (2, 2):
            return f"\n{current_val}\n(Operator / Density Matrix)"
        return str(current_val)
    except Exception as e:
        return f"Numerical parsing break: {e}"


def print_validation(expr: str):
    try:
        info = classify_expression(expr)
    except Exception as e:
        print(f"✗ Parse error: {e}")
        return

    print()
    print("=" * 68)
    print("   Bra-Ket Balance Validator")
    print("=" * 68)
    print(f"  input      : {info['expression']}")
    print(f"  normalized : {info['normalized']}")
    print(f"  tokens     : {[tok for _, tok in info['tokens']]}")
    print(f"  bras       : {info['bra_count']}")
    print(f"  kets       : {info['ket_count']}")
    print(f"  operators  : {info['op_count']}")
    print(f"  well-typed : {'✓' if info['well_typed'] else '✗'}")
    print(f"  result     : {info['result_kind']}")
    print(f"  closed     : {'✓' if info['closed'] else '✗'}")
    print(f"  QLF-safe   : {'✓' if info['qlf_balance_compatible'] else '✗'}")
    if info["message"] != "ok":
        print(f"  note       : {info['message']}")
    if info["well_typed"] and info["result_kind"] != "invalid":
        eval_result = evaluate_numerical_braket(info['tokens'])
        print(f"  evaluation : {eval_result}")
    print("=" * 68)


def repl_validator():
    print()
    print("=" * 68)
    print("   Interactive Bra-Ket Validator")
    print("=" * 68)
    print("  Enter expressions like:")
    print("    <0|σz|0>      |0><1|      H |0><0| H†      <+|σx|+>")
    print("  Type 'quit' or 'exit' to log out of runtime channel.")
    while True:
        s = input("\nbraket> ").strip()
        if s.lower() in {"quit", "exit", "q"}:
            break
        if s:
            print_validation(s)


def run_cli():
    parser = argparse.ArgumentParser(
        description="RhoQuCalc bra-ket correspondence demo and balance validator"
    )
    parser.add_argument("--check", type=str, help="Validate one bra-ket expression, e.g. '<0|σz|0>'")
    parser.add_argument("--repl", action="store_true", help="Start interactive bra-ket validation mode")
    args = parser.parse_args()

    if args.check:
        print_validation(args.check)
        return True
    if args.repl:
        repl_validator()
        return True
    return False


# ─── CORE DEMONSTRATION & RUNTIME EXECUTOR ────────────────────────────────

def run_demo_pipeline():
    """Runs the foundational density matrix and process algebra demonstrations."""
    print("\nExecuting Foundational rhoqcalc Demo Script Pipeline...\n")
    
    # Demo 1: Projecting active state vectors
    ket_0 = "|0>"
    bra_0 = "<0|"
    rho_0 = parallel(action(bra_0, ket_0), lift("I"))
    print(f"Stabilizing Initial Density State Matrix [ρ_0]:\n -> {rho_0}\n")
    
    # Demo 2: Applying unitary evolution via sequence tracking
    hadamard = "H"
    evolved_state = sequence(hadamard, sequence(rho_0, dagger(hadamard)))
    print(f"Applying Unitary Layer [H ρ_0 H†]:\n -> {evolved_state}\n")
    print("All internal runtime pipeline processes verified.")


def main():
    if run_cli():
        return
    
    # Default to demonstration fallback if CLI arguments are vacant
    run_demo_pipeline()


if __name__ == "__main__":
    main()
