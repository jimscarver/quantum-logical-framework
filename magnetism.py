from __future__ import annotations

"""
magnetism.py

QuCalc demonstration of how magnetism appears as the *difference* between
expansion and contraction branches, and how the residual bias images as
magnetic and electric behavior in our observed 3D world.

Core idea
---------
1. QuCalc supplies two canonical magnetic interval primitives:
      '^>' with '^>'  -> +1 signed interval unit  (expansion)
      'v>' with '^>'  -> -1 signed interval unit  (contraction)
2. A one-meter photon supplies the physical carrier scale:
      wavelength = 1 m
      momentum per cycle = h / lambda
      cycle time = lambda / c
3. In ordinary matter the two branches mostly cancel. What we observe as a
   magnetic field is the *small net percentage imbalance* between them.
4. The magnetic image is the net signed interval bias.
5. The electric image is the corresponding momentum exchange along the carrier
   axis.

This file stays honest:
- it uses twist_core.py for the QuCalc sign logic
- it does not claim a full derivation of SI electromagnetism
- it does show how observed field-like behavior emerges as a residual bias
  between expansion and contraction in QuCalc.
"""

from dataclasses import dataclass
from typing import Dict, List

from twist_core import magnetic_interval_audit, signed_spatial_interval_units

# Exact SI constants.
H = 6.626_070_15e-34      # J s
C = 299_792_458.0         # m / s

# Demonstration defaults.
DEFAULT_WAVELENGTH_M = 1.0
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


@dataclass(frozen=True)
class DomainImage:
    scenario: DomainScenario
    wavelength_m: float
    aperture_m2: float
    thread_count: float
    expansion_fraction: float
    contraction_fraction: float
    net_bias_fraction: float
    net_magnetism_percent: float
    expansion_distance_image_m_per_cycle: float
    contraction_distance_image_m_per_cycle: float
    net_distance_image_m_per_cycle: float
    expansion_force_image_n: float
    contraction_force_image_n: float
    net_force_image_n: float
    qucalc_flux_threads: float
    qucalc_flux_density_threads_per_m2: float


def _bar(percent: float, width: int = 30) -> str:
    filled = max(0, min(width, round(width * percent / 100.0)))
    return "█" * filled + "·" * (width - filled)


def _branch_label(units: int) -> str:
    if units > 0:
        return "expansion"
    if units < 0:
        return "contraction"
    return "neutral"


def _polarity_label(value: float) -> str:
    if value > 0:
        return "+ transverse bias / outward electric image"
    if value < 0:
        return "- transverse bias / inward electric image"
    return "balanced / no net image"


def branch_physics(signed_interval_units: int, wavelength_m: float) -> BranchPhysics:
    if wavelength_m <= 0.0:
        raise ValueError("wavelength_m must be positive")

    frequency_hz = C / wavelength_m
    period_s = 1.0 / frequency_hz
    momentum_per_cycle = H / wavelength_m

    return BranchPhysics(
        wavelength_m=wavelength_m,
        frequency_hz=frequency_hz,
        period_s=period_s,
        signed_interval_units=signed_interval_units,
        signed_distance_change_m_per_cycle=signed_interval_units * wavelength_m,
        signed_momentum_exchange_per_cycle=signed_interval_units * momentum_per_cycle,
        signed_force_n=signed_interval_units * (H * C / (wavelength_m * wavelength_m)),
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
    wavelength_m: float,
    aperture_m2: float = DEFAULT_APERTURE_M2,
    thread_density_per_square_wavelength: float = DEFAULT_THREAD_DENSITY,
) -> DomainImage:
    expansion_fraction = scenario.expansion_percent / 100.0
    contraction_fraction = scenario.contraction_percent / 100.0
    total = expansion_fraction + contraction_fraction
    if total <= 0.0:
        raise ValueError("scenario must contain a positive total percentage")

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
    unit_force = H * C / (wavelength_m * wavelength_m)

    expansion_distance = expansion_fraction * thread_count * unit_distance
    contraction_distance = contraction_fraction * thread_count * unit_distance
    net_distance = net_bias * thread_count * unit_distance

    expansion_force = expansion_fraction * thread_count * unit_force
    contraction_force = contraction_fraction * thread_count * unit_force
    net_force = net_bias * thread_count * unit_force

    return DomainImage(
        scenario=scenario,
        wavelength_m=wavelength_m,
        aperture_m2=aperture_m2,
        thread_count=thread_count,
        expansion_fraction=expansion_fraction,
        contraction_fraction=contraction_fraction,
        net_bias_fraction=net_bias,
        net_magnetism_percent=100.0 * net_bias,
        expansion_distance_image_m_per_cycle=expansion_distance,
        contraction_distance_image_m_per_cycle=contraction_distance,
        net_distance_image_m_per_cycle=net_distance,
        expansion_force_image_n=expansion_force,
        contraction_force_image_n=contraction_force,
        net_force_image_n=net_force,
        qucalc_flux_threads=net_bias * thread_count,
        qucalc_flux_density_threads_per_m2=(net_bias * thread_count / aperture_m2),
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
        f"3D reading                           : {_polarity_label(float(p.signed_interval_units))}",
        "meaning                              : this is one pure branch before the two branches are mixed in matter.",
    ])


def format_domain(image: DomainImage) -> str:
    s = image.scenario
    exp_pct = 100.0 * image.expansion_fraction
    con_pct = 100.0 * image.contraction_fraction
    return "\n".join([
        f"[{s.name}]",
        f"expansion branch                     : {exp_pct:8.4f}%  {_bar(exp_pct)}",
        f"contraction branch                   : {con_pct:8.4f}%  {_bar(con_pct)}",
        f"net magnetism                        : {image.net_magnetism_percent:+8.4f}%",
        f"QuCalc flux through aperture         : {image.qucalc_flux_threads:+.6g} net threads/cycle",
        f"QuCalc flux density                  : {image.qucalc_flux_density_threads_per_m2:+.6g} net threads/(m^2 cycle)",
        f"expansion distance image             : {image.expansion_distance_image_m_per_cycle:+.6g} m/cycle",
        f"contraction distance image           : {image.contraction_distance_image_m_per_cycle:+.6g} m/cycle",
        f"net observed distance image          : {image.net_distance_image_m_per_cycle:+.6g} m/cycle",
        f"expansion force image                : {image.expansion_force_image_n:+.6g} N",
        f"contraction force image              : {image.contraction_force_image_n:+.6g} N",
        f"net observed force image             : {image.net_force_image_n:+.6g} N",
        f"3D interpretation                    : {_polarity_label(image.net_bias_fraction)}",
    ])


def explain_output() -> str:
    return "\n".join([
        "Meaning of the output",
        "---------------------",
        "1. The two pure QuCalc branches are shown separately first.",
        "   '^>' with '^>' is pure interval expansion.",
        "   'v>' with '^>' is pure interval contraction.",
        "2. In matter, observed magnetism is usually not a pure branch. It is a small",
        "   excess of one branch over the other. That excess is reported as net magnetism.",
        "3. The expansion and contraction percentages are therefore the natural QuCalc",
        "   reading of magnetic domain balance.",
        "4. QuCalc flux is the net number of carrier-threads crossing the chosen aperture",
        "   after expansion and contraction have cancelled as much as they can.",
        "5. What we observe in 3D is the residual image of that cancellation failure:",
        "   - residual transverse interval bias -> magnetic field image",
        "   - residual carrier momentum exchange -> electric force image",
        "6. Zero net magnetism means expansion and contraction cancel exactly.",
        "   Nonzero magnetism means one branch wins by a small percentage.",
    ])


def demonstrate(
    wavelength_m: float = DEFAULT_WAVELENGTH_M,
    aperture_m2: float = DEFAULT_APERTURE_M2,
) -> str:
    like = analyze_branch(MagneticCase("pure expansion branch", "^>", "^>"), wavelength_m)
    mixed = analyze_branch(MagneticCase("pure contraction branch", "v>", "^>"), wavelength_m)

    scenarios: List[DomainScenario] = [
        DomainScenario("balanced domain", 50.0, 50.0),
        DomainScenario("weak magnet", 50.1, 49.9),
        DomainScenario("moderate magnet", 51.0, 49.0),
        DomainScenario("strong magnet", 55.0, 45.0),
    ]
    images = [image_domain(s, wavelength_m, aperture_m2) for s in scenarios]

    lines = [
        "QuCalc magnetism demonstration",
        "===============================",
        "",
        "Carrier chosen for the bridge",
        "-----------------------------",
        f"wavelength                           : {wavelength_m} m",
        f"frequency c/lambda                   : {C / wavelength_m:.6g} Hz",
        f"period lambda/c                      : {wavelength_m / C:.6g} s",
        f"action per cycle                     : {H:.16g} J s",
        f"momentum per cycle h/lambda          : {H / wavelength_m:.6g} kg m/s",
        f"force scale hc/lambda^2              : {H * C / (wavelength_m * wavelength_m):.6g} N",
        f"aperture for flux image              : {aperture_m2} m^2",
        "",
        "Pure QuCalc branches",
        "--------------------",
        format_branch(like),
        "",
        format_branch(mixed),
        "",
        explain_output(),
        "",
        "Realistic magnetic ranges",
        "-------------------------",
        "These percentages show how a small residual imbalance between expansion and",
        "contraction becomes the weak or strong magnetic field we observe.",
        "",
    ]

    for image in images:
        lines.append(format_domain(image))
        lines.append("")

    lines.extend([
        "Observation statement",
        "---------------------",
        "What we observe in 3D is the image of QuCalc cancellation balance.",
        "When expansion and contraction are equal, the world looks magnetically quiet.",
        "When expansion exceeds contraction, we see one magnetic polarity.",
        "When contraction exceeds expansion, we see the opposite polarity.",
        "The electric image is the corresponding residual momentum exchange on the carrier axis.",
    ])

    return "\n".join(lines)


def main() -> None:
    print(demonstrate())


if __name__ == "__main__":
    main()
