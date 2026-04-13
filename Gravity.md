# Emergent Gravity in QLF:
# Prime-Frequency Mass, Light-Cone Entropy, and Native Coupling

In the Quantum Logical Framework (QLF), gravity is not a fundamental force and
space is not a pre-existing container. Gravity is the large-scale effect of how
stable logical closures deform the network of admissible histories.

This file replaces the older language of "algorithmic lag" and dramatic
simulation narrative with a native QLF statement:

- mass = bound irreducible prime-frequency content
- curvature = closure-network angular deficit
- entropy = prime-weighted hidden continuation count at the light-cone frontier
- gravitational coupling = stable curvature-to-entropy-density ratio

The aim is not to imitate continuum general relativity term-for-term. The aim is
to define gravity in native QuCalc language and only later construct laboratory
bridges to familiar spacetime descriptions.

---

## 1. Primitive basis

QLF begins from the canonical 8-twist alphabet:

```text
^ v   < >   / \   + -
````

A history is physically admissible only when it respects the canonical QuCalc
branching law. A stable event is an admissible history whose net action closes
to Zero Free Action (ZFA).

Write the action of a history `H` as:

`A(H) = (v, h, d, l)`

where:

* `v` = net vertical action
* `h` = net horizontal action
* `d` = net depth action
* `l` = net local / gauge action

A stable closure satisfies:

`A(H) = (0, 0, 0, 0)`

These stable admissible closures are the basic objects of native QLF geometry.

---

## 2. Prime frequencies are irreducible

The key native idea is simple:

> Prime number frequencies are not decomposable.

In QLF, a stable closure may exhibit a primitive repeat period. If that period is
prime, it cannot be reduced into smaller independent closure periods. Such modes
are therefore irreducible logical frequencies.

These irreducible prime modes are the correct native candidates for the bound
content that persists as mass.

So QLF defines mass conceptually as:

`mass = bound irreducible prime-frequency content`

This is not a continuum density imported from outside the framework.
It is the amount of logically trapped, non-decomposable periodic structure.

---

## 3. Primitive period and reduced period

For a stable history `H`, define its primitive period `P(H)` as the smallest
repeat length that generates the closure pattern. If the history is not a strict
repeat of a shorter block, then `P(H)` is just the full closure length.

QLF also factors out the universal spinorial factor `2` when present:

`P_red(H) = P(H) / 2` if `P(H)` is even, otherwise `P_red(H) = P(H)`

The reduced period isolates the irreducible prime-frequency content after
removing the universal double-cover background.

Factor the reduced period into primes:

`P_red(H) = product over p of p^(nu_p(H))`

where `nu_p(H)` is the multiplicity of prime `p`.

---

## 4. Native bound prime mass

Define the native bound prime mass of `H` by:

`m_Q(H) = sum over p of nu_p(H) * log(p)`

This has the intended meaning:

* if a closure has little or no irreducible prime content, it has little or no
  bound prime mass
* if a closure contains larger or more numerous prime factors, it carries more
  trapped irreducible structure
* the logarithm keeps the contribution additive without exploding in scale

This is the native source quantity for gravity.

---

## 5. Gravity is closure-network curvature

A single stable history is not yet geometry. Geometry emerges from the network
of nearby stable closures.

Two stable closures are treated as neighbors when they are related by a minimal
admissible deformation. In the current implementation, this is approximated by:

* exact adjoint relation
* small Hamming deformation at fixed length
* or same reduced period with strong shared prefix

This produces a graph of stable closures.

Gravity is then defined not as "pull" but as the local deformation of that graph
caused by bound prime content.

Each neighbor contributes an angular share determined by its reduced period.
Define the total angle load around `H` by:

`Theta(H) = sum over K in N(H) of 2*pi / P_red(K)`

where `N(H)` is the neighbor set of `H`.

Then define the local combinatorial curvature by angular deficit:

`kappa_Q(H) = 2*pi - Theta(H)`

This is a purely combinatorial curvature.
It is native to QLF because it depends only on stable closures, reduced periods,
and adjacency relations.

---

## 6. Local mass density

The corresponding local mass density is the average bound prime mass in the
neighborhood:

`rho_Q(H) = ( m_Q(H) + sum over K in N(H) of m_Q(K) ) / V_Q(H)`

where `V_Q(H)` is the combinatorial neighborhood volume, taken in the simplest
case to be:

`V_Q(H) = 1 + |N(H)|`

This density is not continuum matter density.
It is closure density of irreducible bound prime content.

---

## 7. Light-cone entropy

Mass alone is not yet enough. In QLF, gravity is more naturally tied to the
entropy of the light cone.

For a closure `H`, consider its admissible continuations beyond the currently
resolved local closure. At a fixed continuation depth `n`, the frontier consists
of all admissible histories reached after exactly `n` extension steps.

Call this frontier:

`F_Q(H, n)`

Its combinatorial boundary area is simply the number of frontier states:

`A_Q(H, n) = |F_Q(H, n)|`

Each continuation `C` in the frontier carries its own prime-frequency weight.
Define:

`w(C) = m_Q(C)`

that is, the prime mass associated with the continuation's reduced primitive
period.

Now define the prime-weighted light-cone entropy:

`S_Q(H, n) = log( sum over C in F_Q(H, n) of exp(w(C)) )`

This is the native entropy of the hidden admissible possibilities just outside
the currently resolved local closure.

---

## 8. Boundary entropy density

The relevant gravitational source is not raw entropy alone, but boundary entropy
density.

Define:

`sigma_Q(H, n) = S_Q(H, n) / A_Q(H, n)`

This is the light-cone boundary entropy density.

It has the right interpretation:

* if many hidden admissible possibilities exist but are spread thinly over a
  large frontier, the density is moderate
* if hidden irreducible possibilities are concentrated at the frontier, the
  density is high
* gravity should respond to this concentration, not to uniform hidden complexity

So `sigma_Q` is the native entropic source term.

---

## 9. Native gravitational coupling

QLF now defines a local entropy-based gravitational coupling by:

`g_Q(H) = |kappa_Q(H)| / sigma_Q(H, n)`

The ensemble native coupling is:

`G_Q = average over stable closures H of g_Q(H)`

This `G_Q` is the native quantity to be measured first.

Only after it stabilizes across scale, seed choice, frontier depth, and closure
ensemble should one attempt a bridge from `G_Q` to the laboratory constant `G`.

So the correct scientific order is:

1. derive native `G_Q`
2. test whether it is stable
3. only then map it to familiar physical units

---

## 10. Mass-based comparison coupling

The implementation also computes a comparison quantity using local mass density
instead of entropy density:

`g_Q_mass(H) = |kappa_Q(H)| / rho_Q(H)`

and its ensemble average.

This is not the preferred native definition, but it is useful for checking
whether mass density and light-cone entropy density are converging toward the
same underlying source concept.

The long-term expectation of QLF is that:

* bound prime mass
* hidden prime-weighted light-cone entropy
* and curvature source strength

are three views of the same underlying logical structure.

---

## 11. Why this is more native than the old gravity model

The earlier gravity language mixed together:

* entropy analogies
* claims about Bekenstein-Hawking area
* algorithmic lag
* and a "tensor" simulation that was really only a transition-count matrix

The native QLF version is cleaner because it uses only:

* admissible QuCalc closures
* primitive and reduced periods
* prime irreducibility
* closure-neighborhood adjacency
* combinatorial curvature
* light-cone frontier size
* prime-weighted hidden continuation entropy
* boundary entropy density

That is exactly the right level of commitment for the current framework.

---

## 12. What is already claimed

This native rewrite supports the following claims:

* gravity is not fundamental force exchange
* mass is bound irreducible logical frequency content
* curvature is a network property of stable closures
* the light-cone frontier carries a native entropy
* the gravitational coupling is a curvature-to-entropy-density ratio

These claims are native to QLF.

---

## 13. What is not yet claimed

This rewrite does not yet claim:

* a full derivation of Einstein field equations
* a derivation of the Bekenstein-Hawking factor `1/4`
* a final mapping from `G_Q` to CODATA `G`
* a continuum metric limit for arbitrary macroscopic spacetime

Those remain future bridges.

---

## 14. Computational realization

The companion file `gravitational_tensor.py` now implements a native gravity
prototype based on:

* QuCalc-generated stable histories
* primitive period detection
* reduced periods
* prime-factor mass
* closure-neighborhood graph construction
* combinatorial curvature
* exact frontier continuation generation
* prime-weighted light-cone entropy
* boundary entropy density
* ensemble estimate of native `G_Q`

This is the correct starting point for making gravity fully native inside QLF.

---

## 15. Conclusion

QLF does not need to import gravity as a primitive interaction.

Once stable closures exist, and once prime frequencies are recognized as the
irreducible bound content of those closures, geometry follows from the structure
of the closure network itself. Once the light cone is recognized as a frontier
of hidden admissible continuations, entropy also becomes native.

So the native QLF statement is:

> Gravity is the curvature of the stable-closure network induced by bound
> irreducible prime-frequency content, measured against the prime-weighted
> entropy density of the light-cone boundary.

That is the framework in its simplest and most native form.

One more improvement would help the repo: add a short sample output block from `gravitational_tensor.py` under a “Sample Run” section, so the markdown and code visibly agree.

