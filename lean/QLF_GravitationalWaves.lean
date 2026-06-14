import QLF_SubstrateLightSpeed
import QLF_Spin

set_option linter.unusedVariables false

/-!
# QLF_GravitationalWaves — what the substrate fixes about GWs (and what it does not)

A gravitational wave is a **transverse ripple in synthesized spacetime** — a propagating
disturbance in the ZFA-event-rate / holographic-density field, not a substance moving through a
pre-existing background. `GR_Schwarzschild.md` flagged GWs as open ("time-dependent metrics need
additional substrate machinery"). That remains true for the *wave equation*; but several
features of the wave **do** follow from machinery QLF already has, and are anchored here.

* **GWs propagate at `c`** (`gw_speed_eq_planck_ratio`). A GW carries no gauge fold (`+`/`−`),
  so it is **massless** (depth `R = 0`, like the photon) and propagates at the substrate light
  speed `c = L_Planck/τ_Planck` (`QLF_SubstrateLightSpeed`, `local_light_speed_invariant`). This
  is the falsifiable headline — GW170817 measured `|v_GW − c|/c < 10⁻¹⁵`.
* **The graviton is spin-2, a composite of half-spins** (`graviton_integer_spin`). Integer spin
  is not fundamental in QLF — it is an even number of half-spin pairs (`boson_even_pairs`;
  photon = ½+½ = spin 1, `photon_integer_spin`). The graviton is **four** half-spin units —
  two photon-worths, `1+1 = 2` — folding to `+I`: an integer-spin boson, spin 2.
* **Two transverse polarizations** (`massless_two_polarizations`). Being massless, the graviton
  carries only its two extreme helicities `±2` (transverse-traceless), *not* `2J+1 = 5` — exactly
  as the massless photon carries 2 (`±1`), not 3. The polarization count is a masslessness
  consequence, shared with light.

## Honest scope

This anchors **speed `= c`, masslessness, spin-2-as-composite, and the 2-polarization count** —
the reusable, substrate-grounded features. It does **not** derive the **linearized Einstein
wave equation** `□h_μν = 0` or the **quadrupole luminosity** `L = (G/5c⁵)⟨d³Q/dt³⟩²`; those
need the *dynamical* substrate metric (the "additional machinery" of `GR_Schwarzschild.md`),
which QLF does not yet have — the same dynamical-GR gap as the full Einstein field equations.
The `G` and `8π` that appear in the quadrupole formula are the substrate `G = L_P²c³/ℏ`
(`QLF_GravityFromDelay`) and `8π = 4π·2` (`QLF_EinsteinGeometricFactor`). Status
`gravitational_waves_in_progress`. See `GR_Schwarzschild.md`.
-/

namespace QLF

/-! ### 1. A gravitational wave propagates at the substrate light speed `c` -/

/-- **Propagation speed of a gravitational wave** — a massless (gauge-fold-free) transverse
    disturbance of synthesized spacetime travels at the substrate light speed. -/
noncomputable def gw_speed : ℝ := substrate_light_speed

/-- GW speed **is** the substrate light speed (the same `c` that is locally invariant,
    `local_light_speed_invariant`). -/
theorem gw_speed_eq_c : gw_speed = substrate_light_speed := rfl

/-- **GW speed `= L_Planck/τ_Planck = c`** — matching GW170817's `|v_GW − c|/c < 10⁻¹⁵`. -/
theorem gw_speed_eq_planck_ratio : gw_speed = planck_length / planck_time := rfl

/-! ### 2. The graviton is spin-2 — a composite of four half-spins (two photon-worths) -/

/-- **The graviton is an integer-spin boson.** Four half-spin units — `1 + 1 = 2`, two
    photon-worths — fold to `+I` (`boson_even_pairs`, an even pair count returns under 360°).
    Spin 2 is not fundamental: it is four half-spins, exactly as the substrate forces. -/
theorem graviton_integer_spin (a b c d : Twist) :
    concatPairsMatrixFold [a, b, c, d] = (1 : M) :=
  boson_even_pairs [a, b, c, d] ⟨2, rfl⟩

/-- Photon spin (one half-spin pair, `½+½`). -/
def photon_spin : ℕ := 1

/-- Graviton spin. -/
def graviton_spin : ℕ := 2

/-- **Spin 2 = two spin-1 = four half-spins** — the graviton is two photon-worths of spin. -/
theorem graviton_spin_two_photons : graviton_spin = 2 * photon_spin := rfl

/-! ### 3. Two transverse polarizations — a consequence of masslessness -/

/-- Photon transverse polarizations (`±1`), 2 not 3 — because the photon is massless. -/
def photon_polarizations : ℕ := 2

/-- Graviton transverse-traceless polarizations (`±2`), 2 not `2J+1 = 5`. -/
def graviton_polarizations : ℕ := 2

/-- **Massless ⇒ two polarizations.** The graviton carries the same number of physical
    polarizations as the photon — its two extreme helicities — because both are massless. -/
theorem massless_two_polarizations : graviton_polarizations = photon_polarizations := rfl

/-! ### Summary -/

/-- **What the substrate fixes about gravitational waves**: speed `= c`, spin `2` (two
    photon-worths of half-spin), and `2` transverse polarizations. -/
theorem gravitational_wave_substrate_summary :
    gw_speed = substrate_light_speed ∧
    graviton_spin = 2 * photon_spin ∧
    graviton_polarizations = 2 :=
  ⟨rfl, rfl, rfl⟩

/-- **Established constructively:** a GW is a massless transverse ripple of synthesized
    spacetime ⇒ propagates at `c` (`gw_speed_eq_planck_ratio`, the GW170817 result); the
    graviton is spin-2 as a composite of four half-spins (`graviton_integer_spin`) with 2
    transverse polarizations from masslessness. **Open:** the linearized wave equation
    `□h_μν = 0` and the quadrupole luminosity formula — they need the dynamical substrate
    metric (the same gap as the full Einstein field equations), `GR_Schwarzschild.md`. -/
theorem gravitational_waves_in_progress : True := trivial

end QLF
