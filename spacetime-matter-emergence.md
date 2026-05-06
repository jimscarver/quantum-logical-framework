# Spacetime and Matter Emergence

A demonstration of how **space, time, and matter** emerge from logical twist histories.

## Core Concept
Physical properties emerge from strings of 8 basic twists. The balance between spatial free action and local free action generates space, time, and the character of matter. All entanglement is internal.

## Systems

### 1. Electron
```python
from spacetime_dynamics import SpacetimeGenerator
gen = SpacetimeGenerator("^>v<^+/-")
print(gen)
```
- Space (x): 1.0  
- Time (t): 2.0  
- Clock Frequency: 0.5

### 2. Antimuon
```python
from spacetime_dynamics import SpacetimeGenerator
gen = SpacetimeGenerator("^^>>vv<<//\\")
print(gen)
```
- Space (x): 2.0  
- Time (t): ∞  
- Clock Frequency: 0.0

### 3. Hydrogen Atom
```python
from spacetime_dynamics import SpacetimeGenerator
gen = SpacetimeGenerator("^>v<^>v<//\\+-")
print(gen)
```
- Space (x): 0.0  
- Time (t): 2.0  
- Clock Frequency: 0.5

### 4. Neutrino
```python
from spacetime_dynamics import SpacetimeGenerator
gen = SpacetimeGenerator("^-v+")
print(gen)
```
- Space (x): 0.0  
- Time (t): ∞  
- Clock Frequency: 0.0

### 5. Light (Photon)
```python
from spacetime_dynamics import SpacetimeGenerator
gen = SpacetimeGenerator("^^^^<<<<////")
print(gen)
```
- Space (x): 3.0  
- Time (t): ∞  
- Clock Frequency: 0.0

## Visual Overview
```mermaid
flowchart TD
    Twists --> Calc Calc --> Split Split --> Results
    Results --> Electron["Electron<br/>x=1.0  t=2.0" "Antimuon<br/>x=2.0  t=∞"]
    Results --> Hydrogen Results --> Neutrino Results --> Light["Light<br/>x=3.0  t=∞"]
```

**Summary:** Space, time, and matter properties all emerge directly from the internal twist dynamics of each sy
