import Mathlib

/-!
# QLF_CensusShannon — information composes as counts multiply (item 1, the composition law)

The multiplicative half of "the census *is* Shannon counting" (issue #115 item 1), stated
**multiplicatively on ℕ** — *information composes as counts multiply* — with **no log and no `Real`
import**. That design is itself an instance of the QLF thesis: **entropy is the count; the log is the
rendering.** The substrate object is the integer multiplicity (configuration count); Shannon's
`H = log W` is what you get by rendering the multiplicative composition additively.

* **`independent_join_multiplies`** — the composition law: the joint multiplicity of two *independent*
  systems is the **product** of their multiplicities (`Fintype.card (α × β) = card α · card β`). This is
  Boltzmann's `W₁·W₂`, the multiplicative dual of the additive log-measure.
* **`trivial_multiplicity`** — the system with no alternatives carries multiplicity `1` (the
  multiplicative unit = the "no information" state).
* **`bit_multiplicity`** / **`nbit_multiplicity`** — one binary distinction has multiplicity `2`; `n`
  independent distinctions have `2^n` — the closure census as a configuration count.

**The Shannon bridge** (prose, since it needs the log = rendering): additivity *forces* the measure to
be `|s|·c` ([`QLF_EntropyUniqueness`](QLF_EntropyUniqueness.lean), `additive_uniform_eq_length_mul`),
and with `c = log 2` that is `log 2^{|s|} = log W` — Boltzmann–Shannon exactly, the additive rendering
of the multiplicative multiplicity proved here. **Honest scope:** the composition law is stock finite
combinatorics; the full **Faddeev uniqueness** (that `log` is the *unique* rendering turning the product
into a sum, via the Cauchy functional equation / Erdős 1946) is deferred to #115. No `Real`, no axioms.
-/

namespace QLF.CensusShannon

/-- **The composition law — counts multiply on independent ledgers.** The multiplicity (microstate
    count) of the independent join of two finite systems is the *product* of their multiplicities.
    Boltzmann's `W₁·W₂`; the multiplicative statement of which the additive entropy is the log. -/
theorem independent_join_multiplies (α β : Type*) [Fintype α] [Fintype β] :
    Fintype.card (α × β) = Fintype.card α * Fintype.card β :=
  Fintype.card_prod α β

/-- The system with a single configuration carries multiplicity `1` — the multiplicative unit,
    the "no distinction / no information" state (`log 1 = 0`). -/
theorem trivial_multiplicity : Fintype.card PUnit = 1 :=
  Fintype.card_punit

/-- One binary distinction (a closure / a bit) has multiplicity `2`. -/
theorem bit_multiplicity : Fintype.card Bool = 2 :=
  Fintype.card_bool

/-- `n` independent binary distinctions have multiplicity `2^n` — the configuration count whose log
    is `n · log 2`, the census read as Shannon content. -/
theorem nbit_multiplicity (n : ℕ) : Fintype.card (Fin n → Bool) = 2 ^ n := by
  simp [Fintype.card_fun]

/-- Consistency of the two laws: the multiplicity of `n` independent bits factors through the
    composition law — `2^(m+n) = 2^m · 2^n` — the integer identity the additive log renders as
    `(m+n)·log 2 = m·log 2 + n·log 2`. -/
theorem multiplicity_composes (m n : ℕ) :
    Fintype.card (Fin (m + n) → Bool) =
      Fintype.card (Fin m → Bool) * Fintype.card (Fin n → Bool) := by
  rw [nbit_multiplicity, nbit_multiplicity, nbit_multiplicity, pow_add]

/-- Summary: information composes as counts multiply (`independent_join_multiplies`), with the census
    `2^n` a configuration count; the log that renders this product as a sum is Shannon entropy, forced
    linear by additivity (`QLF_EntropyUniqueness`). Entropy is the count; log is the rendering. The
    Faddeev uniqueness of the log rendering is the residual (#115). -/
theorem census_shannon_summary : True := trivial

end QLF.CensusShannon
