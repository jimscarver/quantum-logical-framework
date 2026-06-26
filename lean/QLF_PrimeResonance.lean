import QLF_Consciousness
import QLF_FreeEnergy
import QLF_PrimordialMarkovBlanket
import QLF_BetaFunction
import Mathlib

set_option linter.unusedVariables false

/-!
# QLF_PrimeResonance — prime frequencies are the irreducible modes; the half-spin prime-3 keystone

The geometry of inner and outer space is one closure-resonance substrate (`Geometry_Of_Space.md`):
the same icosahedral geodesic-blanket geometry at every Fuller frequency `v`, with **higher
frequencies dominating** the rendering and **prime frequencies** the irreducible dominant modes. This
module is the **first Lean anchor for prime topology stability** (`Prime_Topology_Stability.md`, until
now prose), plus the frequency-dominance ordering and Jim's **half-spin prime-3 keystone**.

* **Prime frequencies are irreducible (the topological lock).** A closure whose period `R` is prime has
  **no** nontrivial sub-closure repeat — the only divisors are `1` and `R` (`prime_freq_irreducible`).
  So the vacuum cannot factor it into a whole-number repeat of a shorter stable closure: the prime-`3`
  proton's lock. A composite period factors and is decomposable (`composite_freq_factors`).
* **Higher frequencies dominate.** Of two co-present resonant closures the shorter-period one has the
  higher frequency and dominates the rendering (`higher_freq_dominates`, reusing `QLF_Consciousness`'s
  `freq R = 1/R`, `freq_lt_of_lt`) — inner: the conscious content; outer: the finest structure.
* **The half-spin is the prime-3 keystone — "balanced and prime" (Jim).** The fermion closes only at
  **720°** (two 360° turns; `rotation_720_eq_id`, one turn gives only `−I`). Reading each turn as **3
  steps of 120°** (the Koide three-phase / 3 axes / `S₃`), the half-spin is **3 forward + 3 back**
  (`half_spin_balanced_steps` = 6 = the double-cover return): **balanced** (forward + its Hermitian-
  conjugate reverse) **and prime** (`half_spin_prime`: `3` is prime, so `half_spin_irreducible` — the
  same vacuum-proof lock as the proton `n=3`, now at the fundamental fermion). So prime-`3` is the
  keystone of *all* stable matter, fermion and proton alike.

**Honest scope:** the irreducibility is the clean `Nat.Prime` fact; "the vacuum can't prune a prime
without a paradox" and "half-spin = 3-forward-3-back" are the QLF *readings* — the verified
`fold_electron` (`QLF_Spin`) is the 4-twist 2-D cut of the 720° object; the 3-axis/120° (3-D) cut is a
deeper model these step-count facts anchor, not a proof of it. Reuses `QLF_Consciousness` + Mathlib
`Nat.Prime`; no new axioms. See `Geometry_Of_Space.md`, `Prime_Topology_Stability.md`.
-/

namespace QLF.PrimeResonance

open QLF.Consciousness
open QLF

/-- **Prime frequencies are irreducible — the topological lock.** A closure whose period `R` is prime
    has NO nontrivial sub-closure repeat: the only `d ∣ R` are `1` and `R`, so the vacuum cannot factor
    it into a whole-number repeat of a shorter stable closure (the prime-`3` proton lock). -/
theorem prime_freq_irreducible {R : ℕ} (h : R.Prime) :
    ∀ d, d ∣ R → d = 1 ∨ d = R :=
  fun d hd => h.eq_one_or_self_of_dvd d hd

/-- **Composite frequencies factor — decomposable / prunable.** A composite period is a nontrivial
    product (its closure is a whole-number repeat of a shorter one): `4 = 2·2`, and `4` is not prime. -/
theorem composite_freq_factors : (4 : ℕ) = 2 * 2 ∧ ¬ Nat.Prime 4 := by
  refine ⟨rfl, ?_⟩
  norm_num

/-- **Higher frequencies dominate.** Of two co-present resonant closures, the shorter-period one has the
    higher frequency, and that is the one that dominates the rendering (conscious content inner, finest
    structure outer). Reuses `QLF_Consciousness.freq_lt_of_lt`. -/
theorem higher_freq_dominates {a b : ℕ} (ha : 0 < a) (hab : a < b) : freq b < freq a :=
  freq_lt_of_lt ha hab

-- ## The half-spin prime-3 keystone

/-- The number of 120° steps in one 360° turn of a half-spin closure — the Koide three-phase / 3-axis /
    `S₃` count. -/
def halfSpinSteps : ℕ := 3

/-- **The half-spin step count is prime.** -/
theorem half_spin_prime : Nat.Prime halfSpinSteps := by
  unfold halfSpinSteps; norm_num

/-- **Balanced.** A half-spin closure is `3` steps forward + `3` steps back = `6` total — the 720°
    double-cover return (`rotation_720_eq_id`: two 360° turns). Forward + its Hermitian-conjugate reverse
    is the ZFA balance. -/
theorem half_spin_balanced_steps : halfSpinSteps + halfSpinSteps = 6 := by decide

/-- **Irreducible — the lock at the fermion scale.** Because `3` is prime, the forward turn has no
    nontrivial sub-repeat: the same vacuum-proof prime-lock as the proton `n=3`, at the fundamental
    fermion. So the half-spin is *balanced and prime*. -/
theorem half_spin_irreducible : ∀ d, d ∣ halfSpinSteps → d = 1 ∨ d = halfSpinSteps :=
  prime_freq_irreducible half_spin_prime

/-! ## Orthogonality is one bit; the prime ladder (2, 3, 5, 7, …)

The one-bit/orthogonality point is general (Jim): orthogonality is the *coarse* resolution of the
rendered 3-D perspective, and the **prime arrangements** — not the 5-fold alone — are the substrate's
irreducible structure. Each prime is a closure lock (`prime_freq_irreducible`); composites factor. The
rungs play *different kinds* of role: **2/3/5** are geometric prime symmetries, **7** is a derived count
(QCD `b₀`), higher primes are open. See `Geometry_Of_Space.md` §3c. -/

/-- **Orthogonality is one bit.** A binary / orthogonal distinction — the Hermitian-conjugate pair
    `(t, t†)`, the two orderings of a half-spin ZFA closure — carries exactly `log 2` nats = **one bit**
    (reuse `zfa_closure_minimizes_free_energy`, `QLF_FreeEnergy`). The 3 mutually-orthogonal spatial axes
    are 3 one-bit distinctions: the rendered 3-D perspective *is* the geometry at 1-bit-per-axis
    resolution. Orthogonality is the coarse floor; the finer structure is the prime ladder. -/
theorem orthogonal_distinction_is_one_bit : -binary_kl 1 (1 / 2) = -Real.log 2 :=
  zfa_closure_minimizes_free_energy

/-- **The ladder rungs are prime.** `2, 3, 5, 7` are the small primes — each an irreducible closure lock
    (`prime_freq_irreducible`). -/
theorem small_primes_prime : Nat.Prime 2 ∧ Nat.Prime 3 ∧ Nat.Prime 5 ∧ Nat.Prime 7 := by
  refine ⟨?_, ?_, ?_, ?_⟩ <;> decide

/-- **Prime-5 — the icosahedral lock.** `5` is irreducible (no nontrivial sub-closure repeat, reuse
    `prime_freq_irreducible`): the 5-valent pentamon / icosahedral 5-fold closure, the geometric sibling
    of the prime-3 proton (`half_spin_irreducible`). -/
theorem prime_five_irreducible : ∀ d, d ∣ 5 → d = 1 ∨ d = 5 :=
  prime_freq_irreducible (by decide : Nat.Prime 5)

/-- **Prime-5 sits inside the icosahedral closure group.** `5 ∣ |2I| = 120` (reuse
    `binary_icosahedral_order_eq`) — the 5-fold lives in the binary icosahedral group `2I` (and `A₅`),
    the substrate's closure symmetry that McKay sends to `E₈`. The d-subshell (`ℓ=2`, `2ℓ+1=5`) is the
    5-dim irrep of `A₅` — the *same* representation as that "5D atomic structure" (cited group theory;
    a shared representation, not a derivation of atomic structure). See `Geometry_Of_Space.md` §3c. -/
theorem five_divides_icosahedral : 5 ∣ binary_icosahedral_order := by
  rw [binary_icosahedral_order_eq]; decide

/-- **Prime-7 — a derived count, not a 7-fold symmetry.** `7` enters QLF as the QCD one-loop coefficient
    `b₀ = 11·3/3 − 2·6/3 = 7` (reuse `beta_coefficient_eq_seven`, `QLF_BetaFunction`), fixing the
    `14π = 2π·7` mass hierarchy. It is a *count* in the coupling sector — there is **no** heptagonal
    substrate symmetry. The ladder's geometric rungs are `2, 3, 5`; `7` is a counting prime. -/
theorem prime_seven_is_qcd_b0 : beta_coefficient 3 6 = 7 :=
  beta_coefficient_eq_seven

/-! ### The next rungs — 11 and 13 pair with 7 and 5 by sector

The ladder is not random: the primes pair by sector. **5 and 13 are the icosahedral pair** (fold
symmetry / centered cluster); **7 and 11 are the QCD-coupling pair** (net `b₀` / gluon antiscreening).
More speculative than 2/3/5/7, but each anchored by reuse; higher primes (17, 19, …) stay open. -/

/-- **Prime-13 — the centered icosahedron (the icosahedral partner of 5).** A *centered* icosahedron is
    `1` centre `+ 12` shell vertices `= 13` (`primordial_blanket_vertex_count 1 = 12`, `base_icosahedron`)
    — the first **Mackay icosahedral magic number** (13, 55, 147, …), the densest small cluster. So `5`
    (the 5-fold symmetry) and `13` (the centered-cluster count) are the **icosahedral pair**, both built
    on the same icosahedron's 12 pentamons. -/
theorem centered_icosahedron_is_thirteen : 1 + primordial_blanket_vertex_count 1 = 13 := by decide

/-- `13` is irreducible (reuse `prime_freq_irreducible`): an irreducible cluster lock, like the proton's
    prime-3 and the icosahedral prime-5. -/
theorem thirteen_irreducible : ∀ d, d ∣ 13 → d = 1 ∨ d = 13 :=
  prime_freq_irreducible (by decide : Nat.Prime 13)

/-- **Prime-11 — the gluon antiscreening (the QCD partner of 7).** The pure-gauge (`n_f = 0`) one-loop
    coefficient is the gluon antiscreening `b₀ = 11·N_c/3 = 11` (reuse `beta_coefficient`). So `7` (the
    net `b₀` after quark screening, `beta_coefficient 3 6 = 7`) and `11` (the bare antiscreening) are the
    **QCD-coupling pair**. Like `7`, prime-`11` is a **derived count in the coupling sector — NOT an
    11-fold symmetry** (the alternative reading, M-theory's 11 dimensions, is dimensional/structural, not
    anchored here as a lock). -/
theorem gluon_antiscreening_is_eleven : beta_coefficient 3 0 = 11 := by
  unfold beta_coefficient; norm_num

/-- The next two rungs are prime. -/
theorem eleven_thirteen_prime : Nat.Prime 11 ∧ Nat.Prime 13 := by
  refine ⟨?_, ?_⟩ <;> decide

/-- **Established (the prime-ladder generalization, `Geometry_Of_Space.md` §3c):** orthogonality is the
    1-bit resolution of the rendered perspective (`orthogonal_distinction_is_one_bit`); the prime
    arrangements are the irreducible structure (`prime_freq_irreducible`; rungs prime,
    `small_primes_prime`). Anchored homes — **2** the bit/spin, **3** the axes/proton
    (`half_spin_irreducible`), **5** the icosahedral lock (`prime_five_irreducible`,
    `five_divides_icosahedral`), **7** the *derived count* QCD `b₀` (`prime_seven_is_qcd_b0`), not a
    7-fold symmetry. **The primes pair by sector:** `5 & 13` the **icosahedral pair** (fold symmetry /
    centered cluster, `centered_icosahedron_is_thirteen` = `1+12`, `thirteen_irreducible`); `7 & 11` the
    **QCD-coupling pair** (net `b₀` / gluon antiscreening, `gluon_antiscreening_is_eleven` = `b₀(n_f=0)`);
    higher primes (17, 19, …) open. Honest scope: 2/3/5/13 are geometric prime locks, 7/11 counting
    primes in the coupling sector (not 7-/11-fold symmetries); 11/13 are more speculative than 2/3/5/7;
    the d-orbital ↔ 5-dim `A₅` irrep is cited group theory, not a derivation of atomic structure. Reuses
    `QLF_FreeEnergy` + `QLF_PrimordialMarkovBlanket` + `QLF_BetaFunction`; no new axioms. -/
theorem prime_ladder_summary : True := trivial

/-- **Established (the synthesis, `Geometry_Of_Space.md`):** prime frequencies are the irreducible
    resonant modes (`prime_freq_irreducible`; composites factor, `composite_freq_factors`); higher
    frequencies dominate the rendering (`higher_freq_dominates`); and the half-spin fermion is the
    **prime-3 keystone** — balanced (3 forward + 3 back = the 720° return, `half_spin_balanced_steps`)
    and prime (`half_spin_prime`, `half_spin_irreducible`), the same lock as the proton `n=3`. Honest
    scope: the `Nat.Prime` irreducibility is exact; the vacuum-pruning gloss and the 3-axis/120° cut of
    the 720° object are the QLF readings. Reuses `QLF_Consciousness`; no new axioms. -/
theorem prime_resonance_summary : True := trivial

end QLF.PrimeResonance
