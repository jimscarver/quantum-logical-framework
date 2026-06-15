import QLF_Riemann

set_option linter.unusedVariables false

/-!
# QLF_PhysicalPi — a π-convergent closure census (issues #86, #89)

Allen's challenge ([`fundamentalPi.md`](https://github.com/lightrock/CharacteristicImpedancePython/blob/main/docs/references/fundamentalPi.md),
issue #86): **stop treating `π` as a stored primitive; find the *machine* that generates it.** His
strongest "π machine" is the **path-counting return walk**: for a discrete 2-D walk the return
probability is `P₂ₙ(0) = (C(2n,n)/4ⁿ)²`, and since `C(2n,n) ~ 4ⁿ/√(πn)` (Wallis/Stirling),
`n·P₂ₙ(0) → 1/π`, so `π = lim 1/(n · P₂ₙ(0))` — a `Real.pi`-free finite census converging to `π`.

This is QLF-native, because the count is the substrate's **own closure census**: the number of
ZFA-balanced stable closures of length `2n` is exactly `C(2n,n)` (`find_stable_states_length_even`,
[`QLF_Riemann`](QLF_Riemann.lean)) — the same `C(2n,n)` behind the Born statistics
(`find_stable_states`), the P-vs-NP verify-filter (`realized_count_eq_central_binomial`), and the
Riemann gap-zero density. So:

* **`closure_census`** — the ZFA closure census of length `2n` is `C(2n,n)`, the *return count* of the
  closure walk. **(theorem)**
* **`returnDensity`** — the 2-D closure-walk return density `P₂ₙ(0) = (C(2n,n)/4ⁿ)²` is a finite,
  computable **rational** (no `Real.pi`): the census's moving part.
* **`returnDensity_eq_census`** — that moving part is literally built from the closure count. **(theorem)**

## Honest scope (corrected per Allen's #89 review)

What is **proven here** is exactly the *count* and the *rational return density* built from it. What is
**not** proven — and the verbs are corrected accordingly:

* The **convergence** `n·returnDensity → 1/π` is the central-binomial Wallis/Stirling asymptotic — a
  settled theorem *in Mathlib*, but **not yet imported/discharged** in this module
  (`physical_pi_in_progress` is a marker, not the proof). Verb: the census *converges to* `π` (cited),
  not "QLF proves it converges."
* The 2-D **squaring** presupposes a Pólya **random-walk model** (two independent equal-weight axis
  walks); QLF has not yet built that probability space from ZFA dynamics. These two are genuine,
  *discrete* QLF work-items.

What is **declined as a target** (Allen #89's headline demand): "recover the continuum geometric `π`
(`C/2r`, `A/r²`) from isotropy with no circle premise." That asks QLF to reconstruct the **continuum
circle** — which QLF holds to be a *rendering*, the very ultraviolet catastrophe it retires, not a real
object underneath the census ([`Continuum_Choice_Fallacy.md`](../Continuum_Choice_Fallacy.md)). The
discrete census's limit **is** what `π` means; there is no continuum value it must "match." So `Real.pi`
is not eliminated from Mathlib — it is *reframed* as the limit of these discrete machines. See
[`Physical_Pi.md`](../Physical_Pi.md) (the full two-ledger scope), [`TheContinuum.md`](../TheContinuum.md),
[`lean/QLF_LoopClosure.lean`](QLF_LoopClosure.lean) (`2π` is a *chosen* rendering of `% N`, not recovered).
-/

namespace QLF.PhysicalPi

/-- **π's generator is the substrate's own closure census.** The number of ZFA-balanced stable
    closures of length `2n` is the central binomial `C(2n,n)` — the *return count* of the closure
    walk. (Reuses `find_stable_states_length_even`.) -/
theorem closure_census (n : ℕ) :
    (find_stable_states (2 * n)).length = Nat.choose (2 * n) n :=
  find_stable_states_length_even n

/-- **The closure return density** `P₂ₙ(0) = (C(2n,n)/4ⁿ)²` — a finite, computable **rational** (no
    `Real.pi`): the probability the 2-D closure walk of `2n` steps returns to its start, the moving
    part of the π-machine. -/
def returnDensity (n : ℕ) : ℚ := (Nat.choose (2 * n) n : ℚ) ^ 2 / (4 : ℚ) ^ (2 * n)

/-- The return density is built **from the closure count itself** — the substrate's own machine part. -/
theorem returnDensity_eq_census (n : ℕ) :
    returnDensity n = ((find_stable_states (2 * n)).length : ℚ) ^ 2 / (4 : ℚ) ^ (2 * n) := by
  rw [returnDensity, closure_census]

/-- **Marker (not a proof about `π`).** What is proven in this module is the *count* and the *rational
    return density*: the census of stable ZFA closures of length `2n` is `C(2n,n)` (`closure_census`),
    and the 2-D return density `(C(2n,n)/4ⁿ)²` is a finite computable rational built from it
    (`returnDensity`, `returnDensity_eq_census`). The census *converges to* `π` via the cited
    central-binomial Wallis/Stirling asymptotic (`n·P₂ₙ(0) → 1/π`), but that convergence is **not yet
    wired in** here, so this is a `π`-convergent *candidate*, not a QLF-proven generation of `π`.
    **Open (discrete QLF work-items):** import/discharge the convergence; build the random-walk
    probability space behind the squaring. **Declined (continuum premise):** "recover the continuum
    geometric `π` with no circle" — QLF holds the continuum circle to be a rendering, not a target
    (`Continuum_Choice_Fallacy.md`). See `Physical_Pi.md` §5. -/
theorem physical_pi_in_progress : True := trivial

end QLF.PhysicalPi
