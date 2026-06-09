# Open Problems — QLF gap registry

A single map of what is **closed**, what is a **principled boundary**, and what is
genuinely **open**, with a pointer to the document that owns each item. This is an
*index*, not a re-derivation: the substance lives in the linked docs. It complements
[`Experimental_Consistency.md`](Experimental_Consistency.md) (which tracks per-result
precision) by collecting the *forward* work in one place.

**Why a registry.** Open items were scattered across ~25 documents, each with its own
"Open work" section. When a status changes, the claim can drift out of sync across docs
(as the Hadronic-Depth attribution did before its correction). This file is the
canonical status list; when an item moves, update it here and in its owning doc.

## Status legend

| Tag | Meaning |
|---|---|
| ✅ **Closed** | Derived / machine-verified; no longer open. |
| 🧱 **Boundary** | A *principled* limit (like an explicit axiom), not a gap to be closed by more work. The structural form is fixed; a number or bridge is inherited. |
| 🔵 **Open — quantitative** | Mechanism identified; a specific number is not yet derived from substrate. |
| 🟣 **Open — structural / Lean** | Result holds in prose/numerics; a clean theorem or Lean anchor is not yet written. |
| ⚪ **Future work** | Out of current scope by specification (not by doubt about the mechanism). |

---

## Recently changed (this is the live edge)

| Item | Status | Where |
|---|---|---|
| **Pauli closure** — count balance ⟹ Pauli scalar, all twist histories (incl. cross-axis interleaving) | ✅ **Closed** — `count_balanced_pauli_closed` | [`lean/QLF_TwistAlphabet.lean`](lean/QLF_TwistAlphabet.lean), [`Experimental_Consistency.md`](Experimental_Consistency.md) §2.1 |
| **Bethe constant `k(n,0)`** (Lamb shift) | 🧱 **Boundary** — continuum-dominated (`I_1S ≈ 19.77 Ry`, all bound `ΔE < 1 Ry`); free-electron sector above the RCA₀ floor | [`Lamb_Shift.md`](Lamb_Shift.md) §6.1, [`bethe_log_demo.py`](bethe_log_demo.py) |

---

## Principled boundaries (not gaps)

| Item | Why it is a boundary | Where |
|---|---|---|
| **Riemann critical line** | `spectral_hilbert_polya` is an explicit axiom marking the RCA₀ → WKL₀ boundary; RH is *conditional*, not proved | [`lean/QLF_Riemann.lean`](lean/QLF_Riemann.lean) |
| **Speed of light `c`** | The substrate event quantum (one Planck length × one Planck tick *together*) is the foundational postulate — no Tier-3 below it | [`Experimental_Consistency.md`](Experimental_Consistency.md) §3, [`Kitada_Local_Time_GR.md`](Kitada_Local_Time_GR.md) §5.3 |
| **Bethe `k(n,0)`** | Continuum-sector (see live edge above) | [`Lamb_Shift.md`](Lamb_Shift.md) §6.1 |

---

## Open — quantitative (the hard front)

| Item | Status | Where |
|---|---|---|
| **Cosmic depth `n` from first principles** | The geometric depth `n ≈ 6.7×10⁶⁰` is firm but defined via `R_H`; the proton cube `(m_P/m_p)³ ≈ 2.2×10⁵⁷` undershoots by ~3,000×. This *is* the hierarchy problem | [`HadronicDepth.md`](HadronicDepth.md) §2.1 |
| **`H₀` from substrate** | Reduces to deriving `n` (above); currently `H₀` enters as one observable. Would close the last cosmological empirical input | [`Cosmological_Constant.md`](Cosmological_Constant.md) §196 |
| **Hubble tension** | The residual 8.7% in Λ tracks the Planck-vs-SH0ES `H₀` discrepancy; not predicted | [`Cosmological_Constant.md`](Cosmological_Constant.md) §197 |
| **`G` SI value / Einstein `8π·G` coefficients** | Form `G = L_P²c³/ℏ` derived; absolute SI value is substrate-quantum calibration (~37% prediction residual); `8π = 4π·2` identified but the full coefficient calc is research-grade | [`Gravity_From_Delay.md`](Gravity_From_Delay.md), [`Experimental_Consistency.md`](Experimental_Consistency.md) §6.3 |
| **First-principles `R_e`** | `α R_e = m_e` identifies `R_e` with the measured electron; deriving `R_e` (hence `m_e`) from closure-multiplicity counts is open | [`Bound_States_QLF.md`](Bound_States_QLF.md) §6, [`Atomic_System_QLF_Closures.md`](Atomic_System_QLF_Closures.md) §10 |
| **Mass spectrum from multiplicity** | 3rd-generation masses; τ-decay-vertex closure topology not yet pinned | [`Standard_Model.md`](Standard_Model.md) §6 |
| **Constants program** (π, e, δ; α below the 0.026% floor) | Methods exist in `constants_mapper.py`; full CODATA agreement is the active research front | [`Experimental_Consistency.md`](Experimental_Consistency.md) §6.3, §11 |
| **Lamb shift radiative pieces** | AMM `+68 MHz` (Schwinger `α/2π` on the bound moment) and vacuum polarization (Uehling) `−27 MHz` taken as inputs | [`Lamb_Shift.md`](Lamb_Shift.md) §8 |

---

## Open — structural / Lean-anchoring

| Item | Status | Where |
|---|---|---|
| **Lamb prefactor `4/(3π n³)`** | Mostly resolved: `= 4·(2/3)·(1/(2π))·(1/n³)` (Lean `lamb_prefactor_loop_phase`); the π is the g-2-validated loop-phase primitive (0.2%), `1/n³`/`2/3` clean. Only the rational `4` (two-vertex/solid-angle) wants a cleaner origin | [`Lamb_Shift.md`](Lamb_Shift.md) §5 |
| **Dirac correction, per-mechanism Lean** | Kinematic / spin-orbit / Darwin α² pieces are doc-anchored, not yet individual Lean chains from `QLF_Pauli`/`QLF_TwistAlphabet` | [`Dirac_Correction.md`](Dirac_Correction.md) §6 |
| **Lorentz boost as a Lean theorem** | `lorentz_boost_from_zfa_frequencies` needs the Markov-blanket frequency structure in-kernel | [`Cross_Frequency_Lorentz.md`](Cross_Frequency_Lorentz.md) §7 |
| **Maxwell curl laws** (`∇×B=μ₀J`, `∇×E=−∂B/∂t`) | Stated structurally; await a time-indexed event-sequence Lean module (divergence laws already verified) | [`Maxwell.md`](Maxwell.md), [`Electricity.md`](Electricity.md) |
| **γ (Euler–Mascheroni) convergence** | Structural form Lean-anchored; `lim (H_N − ln N) = γ` convergence proof deferred (standard real analysis) | [`lean/QLF_EulerMascheroni.lean`](lean/QLF_EulerMascheroni.lean) |
| **Borromean 5-angle** | `chirality-mixing-per-pair = 2` not yet derived rigorously from `QLF_Pauli`'s scalar group | [`lean/QLF_BorromeanAngles.lean`](lean/QLF_BorromeanAngles.lean) |
| **Baryon-number conservation** | Topological-winding number present; clean Noether tie to an 8-twist symmetry open | [`Conservation.md`](Conservation.md) §9 |

---

## Future work (scope-limited by specification)

| Item | Where |
|---|---|
| Periodic table `Z ≥ 21` (d-shell synthesis; Cr/Cu/La anomalies) — current routing capped at neon | [`Magic_numbers.md`](Magic_numbers.md) |
| QuantumOS active-inference scheduler on QPU silicon (today: browser control plane) | [`Crystal_QuantumOS.md`](Crystal_QuantumOS.md) §7 |
| Quantitative delayed-choice visibility match (Kim et al. 1999) | [`Delayed_Choice_Eraser.md`](Delayed_Choice_Eraser.md) |
| Strong-field FLRW coupling for the cosmological constant | [`Cosmological_Constant.md`](Cosmological_Constant.md) |
| Material-specific carrier-scattering / `ρ(T)` / `T_c` | [`Electricity.md`](Electricity.md) |

---

## Notes

- **Tiers vs. this file.** `Experimental_Consistency.md` uses Tier-1/2/3 for *achieved precision*; this registry uses the status tags above for *forward work*. A "Tier-3 open" result there maps to 🔵/🟣 here, unless it is a 🧱 boundary.
- **Maintenance.** When an item closes or is reclassified, edit its row here **and** its owning doc in the same change, and (if it gains a theorem) the relevant `lean/` module and `lean/README.md` row.
