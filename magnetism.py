from __future__ import annotations

"""
rewritten_magnetism_with_derivation.py

QuCalc demonstration of magnetism and electricity emerging from QuCalc.

NOW WITH EXPLICIT DERIVATION of the force image hc/λ²:

QuCalc supplies pure signed interval units:
   +1 → expansion branch (^> with ^>)
   -1 → contraction branch (v> with ^>)

One-meter wave (λ = 1 m) supplies the carrier scale.

Per logical thread (per cycle):
   • momentum exchange = h / λ               (QuCalc interval unit × photon momentum)
   • cycle duration  = λ / c                 (time for one full wave)

Therefore force image per cycle = momentum / time:
   F = (h / λ) / (λ / c) = h c / λ²

This is **not** an arbitrary constant — it is the direct time-rate of QuCalc-signed momentum exchange.
Magnetism = net signed bias across threads.
Electricity = transverse polarity image of that bias.
Energy = h × total logical bits (as requested).

Demonstrates 100 %, 75 %, and 50 % constructive vs destructive events for a 1 m wave travelling exactly 100 m (100 full cycles).
"""

from dataclasses import dataclass
from typing import Dict

# QuCalc core (assumed available from the framework)
from twist_core import magnetic_interval_audit, signed_spatial_interval_units

# Exact SI constants
H = 6.626_070_15e-34      # J s
C = 299_792_458.0         # m / s

# Demonstration parameters
DEFAULT_WAVELENGTH_M = 1.0
DEFAULT_TRAVEL_DISTANCE_M = 100.0
DEFAULT_APERTURE_M2 = 1.0
DEFAULT_THREAD_DENSITY = 1.0  # one carrier-thread per square wavelength


@dataclass(frozen=True)
class MagneticCase:
    name: str
    left_seed: str
    right_seed: str


@dataclass(frozen=True)
class BranchPhysics:
    wavelength_m: float
    frequency_hz: float
    period_s: float
    signed_interval_units: int
    signed_distance_change_m_per_cycle: float
    signed_momentum_exchange_per_cycle: float
    signed_force_n: float
    force_derivation_note: str


@dataclass(frozen=True)
class BranchReport:
    case: MagneticCase
    audit: Dict[str, object]
    physics: BranchPhysics


@dataclass(frozen=True)
class DomainScenario:
    name: str
    expansion_percent: float
    contraction_percent: float
    is_constructive: bool


@dataclass(frozen=True)
class DomainImage:
    scenario: DomainScenario
    wavelength_m: float
    travel_distance_m: float
    num_cycles: float
    aperture_m2: float
    thread_count: float
    expansion_fraction: float
    contraction_fraction: float
    net_bias_fraction: float
    net_magnetism_percent: float
    net_distance_image_m_per_cycle: float
    net_force_image_n_per_cycle: float
    total_net_distance_m: float
    total_net_force_n: float
    qucalc_flux_threads: float
    qucalc_flux_density_threads_per_m2: float
    num_bits_total: float
    total_energy_j: float


def _bar(percent: float, width: int = 30) -> str:
    filled = max(0, min(width, round(width * percent / 100.0)))
    return "█" * filled + "·" * (width - filled)


def _branch_label(units: int) -> str:
    if units > 0:
        return "EXPANSION (+ logical twist)"
    if units < 0:
        return "CONTRACTION (- logical twist)"
    return "NEUTRAL"


def _polarity_label(value: float) -> str:
    if value > 0:
        return "+ transverse bias → outward ELECTRIC image"
    if value < 0:
        return "- transverse bias → inward ELECTRIC image"
    return "balanced → NO net electric image"


def branch_physics(signed_interval_units: int, wavelength_m: float) -> BranchPhysics:
    if wavelength_m <= 0.0:
        raise ValueError("wavelength_m must be positive")

    frequency_hz = C / wavelength_m
    period_s = 1.0 / frequency_hz

    # QuCalc → photon momentum
    momentum_per_cycle = H / wavelength_m

    # EXPLICIT DERIVATION OF FORCE IMAGE hc/λ²
    # Force = rate of momentum exchange per cycle
    #       = (signed_interval_units × h / λ) / (λ / c)
    #       = signed_interval_units × h c / λ²
    force_per_cycle = signed_interval_units * (H * C / (wavelength_m * wavelength_m))

    return BranchPhysics(
        wavelength_m=wavelength_m,
        frequency_hz=frequency_hz,
        period_s=period_s,
        signed_interval_units=signed_interval_units,
        signed_distance_change_m_per_cycle=signed_interval_units * wavelength_m,
        signed_momentum_exchange_per_cycle=signed_interval_units * momentum_per_cycle,
        signed_force_n=force_per_cycle,
        force_derivation_note=(
            f"DERIVATION: momentum/cycle = h/λ\n"
            f"            period = λ/c\n"
            f"            → force = (h/λ) / (λ/c) = hc/λ²"
        ),
    )


def analyze_branch(case: MagneticCase, wavelength_m: float) -> BranchReport:
    audit = magnetic_interval_audit(case.left_seed, case.right_seed)
    units = int(signed_spatial_interval_units(case.left_seed, case.right_seed))
    return BranchReport(
        case=case,
        audit=audit,
        physics=branch_physics(units, wavelength_m),
    )


def image_domain(
    scenario: DomainScenario,
    wavelength_m: float = DEFAULT_WAVELENGTH_M,
    travel_distance_m: float = DEFAULT_TRAVEL_DISTANCE_M,
    aperture_m2: float = DEFAULT_APERTURE_M2,
    thread_density_per_square_wavelength: float = DEFAULT_THREAD_DENSITY,
) -> DomainImage:
    expansion_fraction = scenario.expansion_percent / 100.0
    contraction_fraction = scenario.contraction_percent / 100.0
    total = expansion_fraction + contraction_fraction
    if total <= 0.0:
        raise ValueError("scenario must contain positive total percentage")

    expansion_fraction /= total
    contraction_fraction /= total

    square_wavelength_area = wavelength_m * wavelength_m
    thread_count = (
        thread_density_per_square_wavelength
        * aperture_m2
        / square_wavelength_area
    )

    net_bias = expansion_fraction - contraction_fraction

    unit_distance = wavelength_m
    unit_force = H * C / (wavelength_m * wavelength_m)   # now explicitly derived above

    net_distance_per_cycle = net_bias * thread_count * unit_distance
    net_force_per_cycle = net_bias * thread_count * unit_force

    num_cycles = travel_distance_m / wavelength_m

    total_net_distance = net_distance_per_cycle * num_cycles
    total_net_force = net_force_per_cycle * num_cycles

    qucalc_flux_threads_per_cycle = net_bias * thread_count
    total_qucalc_flux_threads = qucalc_flux_threads_per_cycle * num_cycles

    # Energy emerges directly from QuCalc: E = h × total logical bits
    num_bits_total = abs(total_qucalc_flux_threads)
    total_energy_j = H * num_bits_total

    return DomainImage(
        scenario=scenario,
        wavelength_m=wavelength_m,
        travel_distance_m=travel_distance_m,
        num_cycles=num_cycles,
        aperture_m2=aperture_m2,
        thread_count=thread_count,
        expansion_fraction=expansion_fraction,
        contraction_fraction=contraction_fraction,
        net_bias_fraction=net_bias,
        net_magnetism_percent=100.0 * net_bias,
        net_distance_image_m_per_cycle=net_distance_per_cycle,
        net_force_image_n_per_cycle=net_force_per_cycle,
        total_net_distance_m=total_net_distance,
        total_net_force_n=total_net_force,
        qucalc_flux_threads=qucalc_flux_threads_per_cycle,
        qucalc_flux_density_threads_per_m2=(qucalc_flux_threads_per_cycle / aperture_m2),
        num_bits_total=num_bits_total,
        total_energy_j=total_energy_j,
    )


def format_branch(report: BranchReport) -> str:
    a = report.audit
    p = report.physics
    return "\n".join([
        f"[{report.case.name}]",
        f"pair                                 : {report.case.left_seed} with {report.case.right_seed}",
        f"joint_seed                           : {a['joint_seed']}",
        f"joint_action (V,H,D,L)               : {a['joint_action']}",
        f"joint_projection_xy                  : {a['joint_projection_xy']}",
        f"magnetic_correlation                 : {a['magnetic_correlation']:+d}",
        f"QuCalc branch                        : {_branch_label(p.signed_interval_units)}",
        f"distance change per cycle            : {p.signed_distance_change_m_per_cycle:+.6g} m",
        f"momentum exchange per cycle          : {p.signed_momentum_exchange_per_cycle:+.6g} kg m/s",
        f"force image per cycle                : {p.signed_force_n:+.6g} N",
        f"force derivation                     : {p.force_derivation_note}",
        f"3D reading                           : {_polarity_label(float(p.signed_interval_units))}",
        "meaning                              : pure QuCalc branch before mixing in matter.",
    ])


def format_domain(image: DomainImage) -> str:
    s = image.scenario
    event_type = "CONSTRUCTIVE (reinforces net bias)" if s.is_constructive else "DESTRUCTIVE (cancels net bias)"
    exp_pct = 100.0 * image.expansion_fraction
    con_pct = 100.0 * image.contraction_fraction
    return "\n".join([
        f"[{s.name}] — {event_type}",
        f"expansion / contraction %             : {exp_pct:.1f}% / {con_pct:.1f}%",
        f"net magnetism % (emergent from QuCalc): {image.net_magnetism_percent:+.1f}%",
        f"net bias fraction                     : {image.net_bias_fraction:+.3f}",
        f"qucalc flux threads per cycle         : {image.qucalc_flux_threads:+.3g}",
        f"flux density (threads/m²)             : {image.qucalc_flux_density_threads_per_m2:+.3g}",
        f"net distance image per cycle          : {image.net_distance_image_m_per_cycle:+.3g} m",
        f"net force image per cycle             : {image.net_force_image_n_per_cycle:+.3g} N",
        f"--- OVER 100 m TRAVEL (100 cycles) ---",
        f"total net distance traversed          : {image.total_net_distance_m:+.3g} m",
        f"total net force image                 : {image.total_net_force_n:+.3g} N",
        f"total QuCalc logical bits             : {image.num_bits_total:.3g}",
        f"total energy (E = h × bits)           : {image.total_energy_j:.6g} J",
        f"emergence                            : Magnetism = net signed bias; Electricity = transverse polarity.",
        f"                                     Pure QuCalc logical folds → observed EM behavior.",
        f"                                     Force image hc/λ² derived from momentum rate.",
    ])


if __name__ == "__main__":
    print("=" * 80)
    print("QuCalc MAGNETISM & ELECTRICITY DEMONSTRATION")
    print("1 m wave travelling 100 m (100 cycles)")
    print("Energy = h × total QuCalc logical bits (SI units)")
    print("FORCE IMAGE hc/λ² NOW EXPLICITLY DERIVED")
    print("=" * 80)
    print()

    wavelength = DEFAULT_WAVELENGTH_M
    travel_m = DEFAULT_TRAVEL_DISTANCE_M

    print("PURE QuCalc BRANCHES (foundation of all emergence):")
    cases = [
        MagneticCase("EXPANSION", "^>", "^>"),
        MagneticCase("CONTRACTION", "v>", "^>"),
    ]
    for case in cases:
        report = analyze_branch(case, wavelength)
        print(format_branch(report))
        print("-" * 80)

    print("\nDOMAIN SCENARIOS — 100%, 75%, 50% CONSTRUCTIVE vs DESTRUCTIVE EVENTS")
    print("(1 m wave, 100 m travel)\n")

    scenarios = [
        DomainScenario("100% CONSTRUCTIVE", 100.0, 0.0, True),
        DomainScenario("100% DESTRUCTIVE", 0.0, 100.0, False),
        DomainScenario("75% CONSTRUCTIVE", 87.5, 12.5, True),
        DomainScenario("75% DESTRUCTIVE", 12.5, 87.5, False),
        DomainScenario("50% CONSTRUCTIVE", 75.0, 25.0, True),
        DomainScenario("50% DESTRUCTIVE", 25.0, 75.0, False),
    ]

    for scenario in scenarios:
        image = image_domain(scenario, wavelength_m=wavelength, travel_distance_m=travel_m)
        print(format_domain(image))
        print("=" * 80)
        print()

    print("Demonstration complete.")
    print("Magnetism and electricity emerge purely as residual signed bias")
    print("between QuCalc expansion/contraction branches.")
    print("Force image hc/λ² is now fully derived from momentum/time.")
    print("Energy is accounted directly from total logical bits traversed.")
