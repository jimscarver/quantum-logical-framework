# `twist_core.py`

`twist_core.py` is the canonical twist-action engine for the Quantum Logical Framework.

It defines the basic 8-twist alphabet, validates twist histories, computes signed action vectors, detects zero-free-action closure, generates candidate histories, and supplies Hermitian-adjoint closure helpers used by higher-level modules such as `topology_resolver.py`.

The module is intentionally small. It should remain the stable algebraic core on which the rest of the repository builds.

---

## Core idea

In QLF, a history is represented as a string of elementary twist symbols.

Each symbol contributes one unit of logical action along one signed axis. A history is **zero-free-action** when all signed components cancel.

A stable event is therefore not merely a sequence of twists. It is a balanced logical closure.

The canonical twist basis is:

```python
TWISTS = ['^', 'v', '<', '>', '/', '\\', '+', '-']
```

These are interpreted as four complementary pairs:

| Pair | Meaning |
|---|---|
| `^` / `v` | vertical opposition |
| `<` / `>` | horizontal opposition |
| `/` / `\` | diagonal opposition |
| `+` / `-` | gauge or local rotational opposition |

The action vector is returned as:

```python
(v, h, d, l)
```

where:

| Component | Definition |
|---|---|
| `v` | count(`^`) - count(`v`) |
| `h` | count(`>`) - count(`<`) |
| `d` | count(`/`) - count(`\`) |
| `l` | count(`+`) - count(`-`) |

A history is zero-free-action when:

```python
(v, h, d, l) == (0, 0, 0, 0)
```

**Implication:** zero-free-action means that no signed logical direction remains unresolved. The history closes as a balanced relation rather than persisting as free imbalance.

---

## Main functions

### `validate_history(history)`

Checks whether a history is a non-empty string containing only canonical twist symbols.

Raises `ValueError` if the history is invalid.

Example:

```python
validate_history("^<v>")
```

No output is returned if the history is valid.

**Implication:** valid syntax is the first filter. A history cannot be physically or logically evaluated unless it is built only from the canonical twist alphabet.

---

### `calculate_action(history)`

Returns the signed action vector of a twist history.

Example:

```python
calculate_action("^<v>")
```

Output:

```python
(0, 0, 0, 0)
```

**Implication:** `^<v>` is balanced across the vertical and horizontal directions. It has no residual diagonal or gauge imbalance. This makes it a candidate zero-free-action history.

---

### `total_logical_action(history)`

Returns the number of twist symbols in the history.

Example:

```python
total_logical_action("^<v>")
```

Output:

```python
4
```

**Implication:** the history contains four elementary logical actions. This is the raw action count before cancellation is considered.

---

### `spatial_free_action(history)`

Returns the uncancelled spatial action:

```python
abs(v) + abs(h) + abs(d)
```

Example:

```python
spatial_free_action("^^<<")
```

Output:

```python
4
```

**Implication:** `^^<<` contains four units of unresolved spatial bias. It does not close as a local zero-free-action event.

---

### `local_free_action(history)`

Returns the uncancelled local/gauge action:

```python
abs(l)
```

Example:

```python
local_free_action("++-")
```

Output:

```python
1
```

**Implication:** one gauge or local rotational unit remains uncancelled. The history is not fully closed because `+` exceeds `-` by one.

---

### `bound_action_estimate(history)`

Returns a simple estimate of bound action:

```python
total_logical_action(history) - free_action
```

where free action is the sum of spatial and local free action.

Example:

```python
bound_action_estimate("^<v>")
```

Output:

```python
4
```

**Implication:** all four twists are bound into closure. None remain as free action.

---

### `is_zfa(history, min_length=4)`

Returns `True` when a history has zero free action and is at least `min_length` symbols long.

Example:

```python
is_zfa("^<v>")
```

Output:

```python
True
```

**Implication:** `^<v>` satisfies the minimum event length and has a zero action vector. It qualifies as a zero-free-action history.

Example:

```python
is_zfa("^v", min_length=4)
```

Output:

```python
False
```

**Implication:** `^v` is balanced, but too short under the default stability rule. In this model, cancellation alone is not enough; a stable event requires a minimum logical structure.

---

### `get_successor_twists(last_twist)`

Returns allowed next twists after a given final twist.

The current rule avoids immediate Hermitian reversal.

Example:

```python
get_successor_twists("^")
```

Output:

```python
['^', '<', '>', '/', '\\', '+', '-']
```

**Implication:** `v` is excluded because it immediately reverses `^`. This prevents trivial backtracking and encourages histories to develop through nontrivial logical continuation.

---

### `generate_histories(seed, causal_horizon=12, require_zfa=False, min_length=4)`

Generates possible histories from a seed using breadth-first expansion.

When `require_zfa=True`, only zero-free-action histories are returned.

Example:

```python
generate_histories("^<", causal_horizon=6, require_zfa=True)
```

Example output:

```python
[
    '^<v>',
    '^<^>vv',
    '^<vv>^',
    '^<v/>\\',
    '^<v\\>/',
    '^<v+>-',
    '^<v->+',
    '^<<v>>',
    '^</v>\\',
    '^</v\\>'
]
```

**Implication:** many different histories can close to zero free action. This supports the QLF idea that stable events are selected from a larger space of possible logical continuations.

---

### `adjoint_history(history)`

Returns the Hermitian adjoint of a history.

The adjoint is formed by:

1. reversing the order of the history,
2. replacing each twist with its complementary opposite.

Example:

```python
adjoint_history("^<v>")
```

Output:

```python
"<^>v"
```

**Implication:** the adjoint is the complementary reverse of the original history. It represents the equal-and-opposite logical partner required for closure.

The full adjoint closure cycle is:

```python
"^<v>" + "<^>v"
```

Output:

```python
"^<v><^>v"
```

**Implication:** the original history and its adjoint form a closed cycle. In QLF terms, this expresses zero free action as a relation between a history and its Hermitian complement.

---

### `is_admissible_history(history)`

Returns `True` when a history is syntactically admissible.

At present, admissibility means only that the history uses valid canonical twist symbols.

Example:

```python
is_admissible_history("^<v>")
```

Output:

```python
True
```

**Implication:** this history is made entirely from canonical twist symbols and can be evaluated by the QLF algebra.

Example:

```python
is_admissible_history("^xv")
```

Output:

```python
False
```

**Implication:** `x` is not part of the canonical twist basis. The history is rejected before any action calculation is attempted.

---

### `closure_with_adjoint(history)`

Audits whether a history closes with its Hermitian adjoint.

Example:

```python
closure_with_adjoint("^<v>")
```

Output:

```python
{
    'history': '^<v>',
    'adjoint': '<^>v',
    'cycle': '^<v><^>v',
    'history_action': (0, 0, 0, 0),
    'adjoint_action': (0, 0, 0, 0),
    'cycle_action': (0, 0, 0, 0),
    'history_is_admissible': True,
    'adjoint_is_admissible': True,
    'cycle_is_zfa': True
}
```

**Implication:** the history, its adjoint, and the combined cycle all close to zero free action. This is the strongest local confirmation that the candidate history behaves as a stable QLF event.

---

## Example usage

Create a file named `example_twist_core_usage.py`:

```python
from twist_core import (
    calculate_action,
    is_zfa,
    adjoint_history,
    closure_with_adjoint,
    generate_histories,
)

history = "^<v>"

print("History:")
print(f"  {history}")

print("\nAction vector:")
print(f"  {calculate_action(history)}")

print("\nIs zero-free-action?")
print(f"  {is_zfa(history)}")

print("\nHermitian adjoint:")
print(f"  {adjoint_history(history)}")

print("\nAdjoint closure audit:")
audit = closure_with_adjoint(history)
for key, value in audit.items():
    print(f"  {key}: {value}")

print("\nGenerated ZFA histories from seed '^<':")
samples = generate_histories("^<", causal_horizon=6, require_zfa=True)
for sample in samples[:10]:
    print(f"  {sample}")
```

Run it:

```bash
python example_twist_core_usage.py
```

Expected output:

```text
History:
  ^<v>

Action vector:
  (0, 0, 0, 0)

Is zero-free-action?
  True

Hermitian adjoint:
  <^>v

Adjoint closure audit:
  history: ^<v>
  adjoint: <^>v
  cycle: ^<v><^>v
  history_action: (0, 0, 0, 0)
  adjoint_action: (0, 0, 0, 0)
  cycle_action: (0, 0, 0, 0)
  history_is_admissible: True
  adjoint_is_admissible: True
  cycle_is_zfa: True

Generated ZFA histories from seed '^<':
  ^<v>
  ^<^>vv
  ^<vv>^
  ^<v/>\
  ^<v\>/
  ^<v+>-
  ^<v->+
  ^<<v>>
  ^</v>\
  ^</v\>
```

Brief implications:

- `History: ^<v>` shows the selected candidate history.
- `Action vector: (0, 0, 0, 0)` shows exact cancellation of signed logical action.
- `Is zero-free-action? True` shows that the history passes the ZFA test.
- `Hermitian adjoint: <^>v` shows the complementary reverse history.
- `cycle: ^<v><^>v` shows the original history closed with its adjoint.
- `cycle_is_zfa: True` confirms that the complete adjoint cycle has no free action.
- The generated histories show that multiple non-identical paths can satisfy the same zero-free-action closure rule.

Overall implication:

```text
The example demonstrates that stable histories are selected by admissibility, zero action, and adjoint closure.
```

---

## Built-in self-test

`twist_core.py` can also be run directly:

```bash
python twist_core.py
```

Expected output:

```text
=== TWIST_CORE SELF-TEST ===

History: ^^^^<<<<////
Action vector (v,h,d,l): (4, -4, 4, 0)
Spatial free action: 12
Local free action : 0
Bound action est. : 0.0
Is ZFA?           : False

Generating sample histories from '^<' ...
  ^<v> → ZFA: True
  ^<^>vv → ZFA: True
  ^<vv>^ → ZFA: True
  ^<v/>\ → ZFA: True
  ^<v\>/ → ZFA: True

✅ twist_core.py loaded and consistent with repo usage.
```

Brief implications:

- `^^^^<<<<////` is valid syntax but not balanced.
- `(4, -4, 4, 0)` shows strong unresolved spatial bias.
- `Spatial free action: 12` shows that the history contains twelve uncancelled spatial units.
- `Local free action: 0` shows that there is no unresolved gauge/local rotational component.
- `Bound action est.: 0.0` shows that this history is entirely free imbalance rather than bound closure.
- `Is ZFA?: False` shows that valid histories are not automatically stable histories.
- The generated examples from `^<` show that the generator can discover nearby zero-free-action continuations.

Overall implication:

```text
The self-test contrasts an unbalanced history with generated histories that do close to zero free action.
```

---

## Integration with `topology_resolver.py`

`topology_resolver.py` depends on these functions from `twist_core.py`:

```python
calculate_action
closure_with_adjoint
is_admissible_history
is_zfa
```

With the current adjoint-closure helpers present, running:

```bash
python topology_resolver.py
```

produces:

```text
Stable events:
  ^<v>
  ^^vv<<>>

Audit summary:
  dissipated_paths: 1
  topological_contradictions: 2
  inadmissible_histories: 0
```

Brief implications:

- `^<v>` is a minimal stable zero-free-action event.
- `^^vv<<>>` is a longer stable zero-free-action event.
- `dissipated_paths: 1` means one candidate exceeded the light-cone limit and was not locally resolvable.
- `topological_contradictions: 2` means two valid histories failed the zero-free-action or adjoint-closure test.
- `inadmissible_histories: 0` means every candidate used valid twist symbols.

Overall implication:

```text
Only admissible histories that achieve zero-free-action adjoint closure are counted as stable events.
```

In physical language, the script models persistence as logical closure. What fails to close does not become a stable observable.

---

## Design rule

`twist_core.py` should remain the canonical place for:

- twist validation,
- action-vector calculation,
- zero-free-action detection,
- Hermitian adjoint construction,
- adjoint closure auditing,
- simple history generation.

Higher-level files should import these primitives rather than redefining them.

This keeps the repository organized around a single canonical QLF algebra.
