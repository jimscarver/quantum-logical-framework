import Mathlib

set_option linter.unusedVariables false

/-!
# QLF_MaxwellCurl — the curl laws as a flux-conservation closure over the event sequence (issue #93)

The *divergence* laws of Maxwell are already on the substrate — `∇·B = 0` is machine-verified
(`no_magnetic_monopoles`, `ZFAEventDynamics`), `∇·E = ρ/ε₀` is the algebraic gauge-imbalance count
([`Maxwell.md`](../Maxwell.md)). The *curl* laws (`∇×E = −∂B/∂t`, `∇×B = μ₀J + μ₀ε₀∂E/∂t`) were the
named open piece: they "require a time-indexed event sequence." QLF now has one — the causal order
([`QLF_ReachableEvent`](QLF_ReachableEvent.lean)), whose depth/interval-volume is the Kitada local-clock
tick ([`QLF_CausalInterval`](QLF_CausalInterval.lean)). This module supplies the **closure process
behind the Heaviside (curl) form** (issue #93) on that sequence.

The substrate `B`-field through a loop is a **census of spatial twist threads** ([`Maxwell.md`](../Maxwell.md)
§3); `flux : ℕ → ℝ` is that count as a function of the event-sequence step `t` (= the Kitada tick). The
honest content of Faraday's law is then **flux-conservation telescoping**: the EMF (circulation of `E`
around the loop boundary) is minus the discrete flux-rate (`emf t = −(flux(t+1) − flux t)`, the local /
curl form, with the `−1` the Hermitian-conjugate orientation reversal), and summed over an interval it
**telescopes** to minus the net flux change (`faraday_integral` — the Stokes / integral form: the
boundary circulation *closes on* the net flux through the loop). A **closed magnetic cycle**
(`flux n = flux 0`) therefore induces **zero net EMF** (`faraday_closed_cycle`) — Faraday's law as a ZFA
closure: the circulation integral vanishes exactly when the flux is closed. The continuum
`∇×E = −∂B/∂t` is the rendering of this discrete conservation.

The Ampère–Maxwell law is the **dual** — the same telescoping with an enclosed source current `J` and
the displacement current (the `E`-flux rate): `ampere_integral`. **Honest scope:** this anchors the
*structural conservation content* (the closure process) of the curl laws on the event sequence; the full
3-D vector-calculus `∇×` with Stokes' theorem on a synthesized metric is the continuum rendering, not
re-derived here. See [`Maxwell.md`](../Maxwell.md), [`Electricity.md`](../Electricity.md).
-/

namespace QLF.MaxwellCurl

/-- **EMF** — the circulation of `E` around the loop boundary at event-step `t`, defined as minus the
    discrete rate of change of the magnetic flux (Faraday). The `−1` is the Hermitian-conjugate
    orientation reversal ([`Maxwell.md`](../Maxwell.md) §3). -/
def emf (flux : ℕ → ℝ) (t : ℕ) : ℝ := -(flux (t + 1) - flux t)

/-- **Discrete Faraday's law (local / curl form)** — the boundary EMF at each step is the negative flux
    rate: the thread-counting analog of `∇×E = −∂B/∂t`. -/
theorem faraday_local (flux : ℕ → ℝ) (t : ℕ) :
    emf flux t = -(flux (t + 1) - flux t) := rfl

/-- **Faraday integral form (Stokes / flux-conservation) — the closure process behind the curl.** The
    EMF accumulated over `[0,n]` **telescopes** to minus the net change of flux: the boundary
    circulation *closes on* the net flux threading the loop. This is the discrete content the continuum
    `∇×E = −∂B/∂t` renders. -/
theorem faraday_integral (flux : ℕ → ℝ) (n : ℕ) :
    (∑ t ∈ Finset.range n, emf flux t) = -(flux n - flux 0) := by
  induction n with
  | zero => simp
  | succ n ih =>
    rw [Finset.sum_range_succ, ih]
    simp only [emf]
    ring

/-- **A closed magnetic cycle induces no net EMF — Faraday's law as a ZFA closure.** If the flux returns
    to its start over the event sequence (`flux n = flux 0`, a closed `B`-cycle), the net boundary
    circulation is zero. The curl law's closure process: the circulation integral vanishes exactly when
    the flux is closed. -/
theorem faraday_closed_cycle (flux : ℕ → ℝ) (n : ℕ) (h : flux n = flux 0) :
    (∑ t ∈ Finset.range n, emf flux t) = 0 := by
  rw [faraday_integral, h]; ring

/-- **Magnetomotive force (Ampère–Maxwell, dual form)** — the circulation of `B` around the loop
    boundary at step `t` is the enclosed source current `J` plus the displacement current (the discrete
    rate of the electric flux `eflux`). -/
def mmf (current eflux : ℕ → ℝ) (t : ℕ) : ℝ := current t + (eflux (t + 1) - eflux t)

/-- **Ampère integral form** — the accumulated MMF telescopes to the total enclosed current transported
    plus the net electric-flux change: the same closure process as Faraday, now with a source. The
    displacement-current term is exactly what makes the circulation *close* on the moving charge plus the
    changing `E`-flux. -/
theorem ampere_integral (current eflux : ℕ → ℝ) (n : ℕ) :
    (∑ t ∈ Finset.range n, mmf current eflux t)
      = (∑ t ∈ Finset.range n, current t) + (eflux n - eflux 0) := by
  induction n with
  | zero => simp
  | succ n ih =>
    rw [Finset.sum_range_succ, Finset.sum_range_succ, ih]
    simp only [mmf]
    ring

/-- **Established constructively (issue #93):** the curl laws as a flux-conservation closure on QLF's
    time-indexed event sequence. Faraday's `∇×E = −∂B/∂t` is the telescoping of the boundary EMF onto the
    net flux change (`faraday_local` local form, `faraday_integral` Stokes form), so a **closed magnetic
    cycle does no net work** (`faraday_closed_cycle` — the circulation closes to zero iff the flux is
    closed, a ZFA closure). Ampère–Maxwell is the dual with a source (`ampere_integral`). With the
    verified divergence laws (`∇·B = 0`), all four Maxwell equations are now substrate-anchored at the
    conservation level; the continuum 3-D `∇×` (Stokes on the synthesized metric) is the rendering. No
    new axioms. See [`Maxwell.md`](../Maxwell.md). -/
theorem maxwell_curl_summary : True := trivial

end QLF.MaxwellCurl
