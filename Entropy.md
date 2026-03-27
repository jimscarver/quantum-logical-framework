**Entropy in the Quantum Logical Framework**  
**Relation to Black-Hole Entropy and the Arrow of Time**

### 1. Entropy = Logical Information Outside the Local Light Cone

In this framework entropy is **never fundamental**. It is purely the **logical information residing outside any observer’s local light-cone perspective** — the alternating values of variables in the full set of zero-action histories that the observer cannot resolve.

- The complete Hilbert space \(\mathcal{H} = (\mathbb{C}^2)^{\otimes N}\) contains **all possible quantum-logical systems**.
- Every microscopic history is a sequence of **zero-free-action Pauli folds** (balanced distinctions created by the primitive creation operator).
- An observer’s light cone selects **only one consistent slicing** of the distinction network (the emergent stationary path).

All other histories, with their alternating logical outcomes, are traced out. The resulting mixed state \(\rho\) carries the von Neumann entropy

\[
S = -\operatorname{Tr}(\rho \ln \rho)
\]

This \(S\) quantifies exactly the **missing logical distinctions** beyond the observer’s causal horizon.

### 2. Numerical Realization in `path_integral.py`

The module computes this directly:

```python
def compute_light_cone_entropy(final_states):
    rho = np.zeros((dim, dim), dtype=complex)
    for psi in final_states:
        rho += np.outer(psi, psi.conj())
    rho /= N_paths                     # average over all sampled zero-action paths
    eigvals = np.real(np.linalg.eigvalsh(rho))
    eigvals = eigvals[eigvals > 1e-12]
    S = -np.sum(eigvals * np.log(eigvals))
    return S
```

Running the simulation yields a concrete number of nats that equals the logical information the observer cannot access from their local viewpoint.

### 3. Direct Link to Black-Hole Entropy (Bekenstein–Hawking)

The holographic principle is built into the framework: because spin-1 (gauge fields, gravity) is **emergent** from spin-1/2 distinctions, the bulk path integral projects onto a lower-dimensional boundary.

- For a black hole, the **event horizon** is precisely the observer’s causal light cone boundary.
- All distinctions inside the horizon lie **outside** the exterior observer’s light cone.
- The entropy of the black hole is therefore the count of those hidden logical distinctions on the holographic screen.
- This reproduces the area law exactly:

\[
S_{\text{BH}} = \frac{A}{4 \ell_{\text{P}}^2}
\]

where each “pixel” on the screen is an irreducible spin-1/2 distinction (one bit of logical information).  
The framework thus derives the Bekenstein–Hawking formula from the same zero-action logic that generates ordinary entropy: **missing distinctions beyond the light cone**.

### 4. The Arrow of Time as Progressive Coarse-Graining

Time itself is **emergent** — it is the relational ordering of resolved distinctions.

- At the fundamental level every fold has **zero free action**; all histories are equally real and perfectly balanced.
- As the observer’s light cone advances, more distinctions are traced out (coarse-grained).
- The number of accessible histories decreases while the number of **hidden alternating distinctions** increases.
- Consequently the coarse-grained entropy \(S\) **increases** in the direction the observer labels “future”.

This gives a purely relational, information-theoretic arrow of time:

- No fundamental \(T\)-violation is needed.
- The second law \(\frac{dS}{dt} > 0\) is the statement that the observer’s causal cone continually encloses **more unresolved logical information**.
- In the path-integral module the red classical trajectory (stationary path) is the experienced “now”; everything else is the growing reservoir of entropy behind the advancing light-cone horizon.

### 5. Unified Picture

| Concept                  | Origin in the Framework                          | Manifestation                          |
|--------------------------|--------------------------------------------------|----------------------------------------|
| Ordinary thermodynamic entropy | Missing distinctions outside local light cone   | von Neumann \(S = -\operatorname{Tr}(\rho \ln \rho)\) |
| Black-hole entropy       | Missing distinctions on the holographic screen  | Bekenstein–Hawking area law            |
| Arrow of time            | Progressive coarse-graining of distinctions     | \(dS > 0\) along observer’s relational ordering |

All three phenomena arise from the **same mechanism**: the gap between the complete zero-action Hilbert-space ecology and the single consistent history any local observer can resolve.

**In short**:  
Entropy — whether in a cup of coffee, a black-hole horizon, or the expanding universe — is the logical information that lies **outside the observer’s current light cone**. The framework makes this precise, programmable, and holographically consistent, with the arrow of time emerging automatically as the observer’s cone sweeps through the relational web of distinctions.
