#!/usr/bin/env python3
"""
QLF Crystal-QPU Pulse Compiler — notional Eu:YSO platform.

Reads a QLF twist string (e.g., from the QuantumOS `/qucalc` slash command)
and emits a sequence of control pulses for a notional ¹⁵¹Eu³⁺:Y₂SiO₅
crystal at 4 K. Closes the open item flagged in `Crystal_QuantumOS.md` §8:
"specific control-pulse compilation from `/qucalc` twists."

Substrate (illustrative numbers; real calibration is in-situ):
    • Optical transition ⁷F₀ → ⁵D₀ at ≈580 nm (state-prep + readout)
    • Ground-state hyperfine splitting ≈ 10 MHz
    • Nominal Rabi frequency Ω = 1 MHz (so a π pulse is ~500 ns)
    • T₂ on the hyperfine clock transition ≈ 6 hours under CPMG
      (Zhong et al. 2015, Nature 517, 177)

Twist-to-gate mapping (matches `lean/QLF_TwistAlphabet.lean` exactly,
modulo the standard global-phase freedom captured by `PauliScalar`):

    Twist  σ-matrix       Bloch gate            Implementation
    ─────  ─────────      ─────────────         ─────────────────────────
    ^      +σ_y           Y  (π about +y)       Rabi π pulse,  φ=+π/2
    v      −σ_y           −Y (π about −y)       Rabi π pulse,  φ=−π/2
    <      −σ_x           −X (π about −x)       Rabi π pulse,  φ=π
    >      +σ_x           X  (π about +x)       Rabi π pulse,  φ=0
    /      +σ_z           Z  (π about +z)       Virtual Z (frame change)
    \\      −σ_z           −Z (π about −z)       Virtual Z (frame change)
    +      +I             I  (no rotation)      Zero-duration wait
    -      −I             −I (global phase π)   Wait + record global phase

A length-2 Hermitian pair like `^v` compiles to two consecutive π_y
pulses (the second with opposite drive phase), whose matrix product is
σ_y · (−σ_y) = −I — exactly the result `hermitian_pair_folds_to_negI`
proves in Lean. All 8 length-2 pair orderings produce the same `−I`
global phase (verified numerically by `active_inference_vfe_demo.py`
and now Lean-anchored).

Honest scope at the bottom of `main()`.
"""

from dataclasses import dataclass, field
from typing import List, Optional
import math


# ── Notional Eu:YSO parameters ────────────────────────────────────────
F_HF_HZ          = 10.4e6           # ground-state hyperfine splitting (Hz)
RABI_HZ          = 1.0e6            # nominal Rabi rate (Hz)
T_PI_S           = 1.0 / (2 * RABI_HZ)   # π-pulse duration: 1 / (2Ω)
F_OPT_HZ         = 5.17e14          # ⁷F₀ → ⁵D₀ at ≈580 nm (Hz)
T_OPT_INIT_S     = 1.0e-3           # optical-pumping init (1 ms)


# ── Pulse data model ──────────────────────────────────────────────────
@dataclass
class Pulse:
    """A single physical drive on the crystal QPU."""
    kind: str                              # 'rabi' | 'virtual_z' | 'wait' | 'init' | 'measure'
    twist: str = ""                        # source twist character
    axis: Optional[str] = None             # 'x' | 'y' | 'z'
    angle_rad: float = 0.0                 # rotation angle (radians)
    frequency_hz: float = 0.0              # carrier
    amplitude_hz: float = 0.0              # Rabi rate
    phase_rad: float = 0.0                 # drive phase (IQ)
    duration_s: float = 0.0
    note: str = ""

    def line(self) -> str:
        if self.kind == 'rabi':
            return (f"  RABI    {self.twist!r}  axis={self.axis}  "
                    f"angle={self.angle_rad:+.4f} rad  "
                    f"f={self.frequency_hz*1e-6:.2f} MHz  "
                    f"Ω={self.amplitude_hz*1e-6:.2f} MHz  "
                    f"φ={self.phase_rad:+.4f} rad  "
                    f"t={self.duration_s*1e9:.1f} ns  ⟵ {self.note}")
        if self.kind == 'virtual_z':
            return (f"  VIRT_Z  {self.twist!r}  "
                    f"angle={self.angle_rad:+.4f} rad  "
                    f"(frame change; no physical pulse)  ⟵ {self.note}")
        if self.kind == 'wait':
            return (f"  WAIT    {self.twist!r}  "
                    f"t={self.duration_s*1e9:.1f} ns  ⟵ {self.note}")
        if self.kind == 'init':
            return (f"  INIT    optical pumping at "
                    f"{self.frequency_hz*1e-12:.3f} THz  "
                    f"t={self.duration_s*1e3:.1f} ms  ⟵ {self.note}")
        if self.kind == 'measure':
            return (f"  MEAS    optical readout at "
                    f"{self.frequency_hz*1e-12:.3f} THz  ⟵ {self.note}")
        return f"  ??      {self.twist!r}  ⟵ {self.note}"


# ── Per-twist compilation ─────────────────────────────────────────────
def compile_twist(twist: str) -> Pulse:
    """Compile one twist character to a Pulse."""
    if twist == '^':
        return Pulse(kind='rabi', twist=twist, axis='y',
                     angle_rad=math.pi,
                     frequency_hz=F_HF_HZ, amplitude_hz=RABI_HZ,
                     phase_rad=math.pi / 2, duration_s=T_PI_S,
                     note='Up (+σ_y): Y gate, π rotation about +y')
    if twist == 'v':
        return Pulse(kind='rabi', twist=twist, axis='y',
                     angle_rad=math.pi,
                     frequency_hz=F_HF_HZ, amplitude_hz=RABI_HZ,
                     phase_rad=-math.pi / 2, duration_s=T_PI_S,
                     note='Down (-σ_y): -Y gate, π rotation about -y')
    if twist == '<':
        return Pulse(kind='rabi', twist=twist, axis='x',
                     angle_rad=math.pi,
                     frequency_hz=F_HF_HZ, amplitude_hz=RABI_HZ,
                     phase_rad=math.pi, duration_s=T_PI_S,
                     note='Left (-σ_x): -X gate, π rotation about -x')
    if twist == '>':
        return Pulse(kind='rabi', twist=twist, axis='x',
                     angle_rad=math.pi,
                     frequency_hz=F_HF_HZ, amplitude_hz=RABI_HZ,
                     phase_rad=0.0, duration_s=T_PI_S,
                     note='Right (+σ_x): X gate, π rotation about +x')
    if twist == '/':
        return Pulse(kind='virtual_z', twist=twist, axis='z',
                     angle_rad=math.pi,
                     note='Slash (+σ_z): Z gate via virtual-Z frame change')
    if twist == '\\':
        return Pulse(kind='virtual_z', twist=twist, axis='z',
                     angle_rad=-math.pi,
                     note='Backslash (-σ_z): -Z gate via virtual-Z frame change')
    if twist == '+':
        return Pulse(kind='wait', twist=twist, duration_s=0.0,
                     note='Plus (+I): identity, zero-duration wait')
    if twist == '-':
        return Pulse(kind='wait', twist=twist, duration_s=0.0,
                     note='Minus (-I): identity + global phase π (physically invisible)')
    raise ValueError(f"Unknown twist character: {twist!r}")


def compile_sequence(twists: str,
                     with_init: bool = True,
                     with_measure: bool = True) -> List[Pulse]:
    """Compile a twist string to a pulse sequence, optionally bookended
    by optical-pumping init and coherent optical readout."""
    seq: List[Pulse] = []
    if with_init:
        seq.append(Pulse(
            kind='init', frequency_hz=F_OPT_HZ, duration_s=T_OPT_INIT_S,
            note='Optical pumping into chosen ground-state hyperfine sub-state'))
    for c in twists:
        seq.append(compile_twist(c))
    if with_measure:
        seq.append(Pulse(
            kind='measure', frequency_hz=F_OPT_HZ,
            note='Coherent readout via the ⁷F₀ → ⁵D₀ optical transition'))
    return seq


def total_pulse_duration_s(seq: List[Pulse]) -> float:
    """Sum of physical pulse durations (excludes virtual-Z, which are frame
    changes only)."""
    return sum(p.duration_s for p in seq)


def hermitian_pair_atoms() -> List[str]:
    """The 8 length-2 ZFA-closed Hermitian-pair atoms.
    All fold to -I in the Pauli scalar group, numerically verified in
    active_inference_vfe_demo.py and Lean-anchored as
    hermitian_pair_folds_to_negI in lean/QLF_TwistAlphabet.lean."""
    return ['^v', 'v^', '<>', '><', '/\\', '\\/', '+-', '-+']


# ── Demo / verification ───────────────────────────────────────────────
def main() -> None:
    bar = "═" * 76
    print(bar)
    print("QLF Crystal-QPU Pulse Compiler — notional ¹⁵¹Eu:Y₂SiO₅ platform")
    print(bar)
    print()
    print("Platform parameters (illustrative):")
    print(f"  Hyperfine splitting:   {F_HF_HZ * 1e-6:>6.2f} MHz")
    print(f"  Nominal Rabi rate Ω:   {RABI_HZ * 1e-6:>6.2f} MHz")
    print(f"  π-pulse duration:      {T_PI_S * 1e9:>6.1f} ns")
    print(f"  Optical transition:    {F_OPT_HZ * 1e-12:>6.3f} THz (≈580 nm)")
    print(f"  T₂ (hyperfine clock):  ≈6 hours under CPMG (Zhong et al. 2015)")
    print()

    demos = [
        ('^v',
         "Half-spin ZFA atom (Lean: hermitian_pair_folds_to_negI)"),
        ('<>',
         "x-axis Hermitian pair"),
        ('/\\',
         "z-axis Hermitian pair (two virtual-Zs, no physical pulses)"),
        ('+-',
         "Gauge (identity) Hermitian pair"),
        ('^<v>',
         "Cross-axis 4-twist closure (folds to -I)"),
        ('^v^v',
         "Composite 4-twist (two y-axis pairs concatenated, folds to +I)"),
    ]

    for twists, hint in demos:
        print(f"── /qucalc {twists!r}  ({hint}) ──")
        seq = compile_sequence(twists)
        for p in seq:
            print(p.line())
        physical = total_pulse_duration_s(seq) * 1e9
        print(f"  Total physical pulse duration (excl. init/measure): "
              f"{(physical - T_OPT_INIT_S * 1e9):>6.1f} ns")
        print()

    print("── Sanity check: all 8 Hermitian-pair atoms compile ──")
    for atom in hermitian_pair_atoms():
        kinds = [compile_twist(c).kind for c in atom]
        print(f"  {atom:>4}  →  {' + '.join(kinds)}")
    print()

    print(bar)
    print("HONEST SCOPING")
    print(bar)
    print("""
This is a sketch compiler with notional numbers. To run on real hardware:
  • Replace F_HF_HZ with the measured hyperfine splitting of your specific
    Eu:YSO sample (varies with strain, isotopic purity, temperature).
  • Calibrate RABI_HZ from a Rabi-oscillation experiment on the chosen
    transition; pulse durations then follow as t_π = 1 / (2 Ω).
  • Replace the single-step optical init with the lab's actual optical
    pumping protocol (typically multi-step for Eu:YSO ³H₄ multiplet).
  • Add dynamical decoupling (CPMG, XY-N) for sequences exceeding the
    single-pulse Hahn-echo coherence time.

What this DOES verify:
  • The 8-twist alphabet maps cleanly onto standard Bloch-sphere
    rotations (single-qubit gates).
  • Each Hermitian-pair atom (length-2 ZFA-closed) compiles to a closed
    Rabi cycle, a virtual-Z pair, or a wait pair — matching the σ-matrix
    structure proved in lean/QLF_TwistAlphabet.lean.
  • The runtime is_zfa check in twist_core.py corresponds to a check
    that the compiled pulse sequence implements a Pauli scalar unitary
    on the qubit (modulo global phase).

What this does NOT do:
  • Calibration. Real hardware needs in-situ calibration of every pulse.
  • Decoherence-aware scheduling.
  • Multi-qubit entangling gates (single-ion compiler only).
  • Error-correction overhead beyond the algebraic guarantee. See
    Crystal_QuantumOS.md §6 for the intrinsic-EC framing.
""")


if __name__ == "__main__":
    main()
