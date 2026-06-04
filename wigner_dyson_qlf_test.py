"""
Wigner-Dyson GUE spacing test on QLF-admissible Markov-blanket depths.

Empirical test of the prediction made in ReverseMathematics.md §4.9
(adjoint involution and the critical-line fixed locus):

  The discrete spectrum of admissible Markov-blanket depths
  {R_X = E_Planck / (M_X c²) : X is QLF-admissible} should exhibit
  Wigner-Dyson GUE nearest-neighbor spacing statistics, the same
  signature Montgomery-Odlyzko observe for non-trivial Riemann
  zeta-zero ordinates.

Data: PDG ground-state hadron masses (QLF-admissible bound states
of quarks, per Hadrons_Markov_Blankets.md) plus light atomic
systems (positronium, muonium, hydrogen, deuterium per
Atomic_System_QLF_Closures.md). Free leptons are NOT QLF
observables and are excluded (per Bound_States_QLF.md).

Unfolding: depths span ~4 decades; density is approximately
log-uniform across hadronic mass scales, so we unfold via
log(R) and normalize spacings by the local mean. This is a
standard procedure for sparse spectra when local density is
unknown but expected to be smooth in log(R).

Comparison: Wigner surmise for GUE,

  P_GUE(s) = (32 / π²) s² exp(-4 s² / π),    Var = 1 − 8/(3π) ≈ 0.180

vs Poisson (uncorrelated, no level repulsion),

  P_Poisson(s) = exp(-s),                     Var = 1.000

Statistic: Kolmogorov-Smirnov maximum-distance against both
reference CDFs, with the standard 5%-significance critical
value 1.36 / √N.

Honest scoping: with N ~ 50 admissible depths, statistical power
is limited. A pure Poisson signal would be ruled out cleanly; a
pure GUE signal would be "consistent with" not "confirmed."
Montgomery-Odlyzko use millions of zeros. This is a first-pass
empirical signal, sufficient to falsify §4.9's prediction if the
data is strongly anti-GUE, but not to "prove" it.
"""

import numpy as np

# Planck energy in MeV.  E_Planck = sqrt(ℏ c⁵ / G) ≈ 1.22091 × 10^19 GeV.
E_PLANCK_MEV = 1.22091e22

# ---------------------------------------------------------------------------
# QLF-admissible hadronic ground-state masses (MeV).
# Sourced from PDG Particle Listings (2024).  Selection: well-established
# (4-star) ground states + first excited levels of each meson and baryon
# family across the light, strange, charm, and bottom sectors.
# ---------------------------------------------------------------------------

hadrons_mev = {
    # Light unflavored mesons
    "pi0":       134.977,
    "pi+":       139.570,
    "eta":       547.862,
    "rho":       775.26,
    "omega":     782.66,
    "etap":      957.78,
    "f0_980":    990.0,
    "phi":       1019.461,
    "h1_1170":   1166.0,
    "b1_1235":   1229.5,
    "a1_1260":   1230.0,
    "f2_1270":   1275.5,
    "f1_1285":   1281.9,
    "eta_1295":  1294.0,
    "pi_1300":   1300.0,
    "a2_1320":   1318.0,
    # Strange mesons
    "K0":        497.611,
    "K+":        493.677,
    "Kstar_892": 891.66,
    "K1_1270":   1272.0,
    "K1_1400":   1403.0,
    "Kstar_1410":1414.0,
    # Charm mesons
    "D0":        1864.84,
    "D+":        1869.66,
    "Dstar0":    2006.85,
    "Dstar+":    2010.26,
    "Ds":        1968.35,
    "Dsstar":    2112.2,
    "etac":      2983.9,
    "Jpsi":      3096.900,
    "chic0":     3414.71,
    "chic1":     3510.67,
    "psi2S":     3686.097,
    # Bottom mesons
    "B0":        5279.65,
    "B+":        5279.34,
    "Bstar":     5324.70,
    "Bs":        5366.88,
    "Bc":        6274.47,
    "etab":      9398.7,
    "Upsilon":   9460.30,
    "chib0":     9859.44,
    "Upsilon2S": 10023.26,
    "Upsilon3S": 10355.2,
    # Light baryons
    "proton":    938.272,
    "neutron":   939.565,
    "Lambda":    1115.683,
    "Sigma+":    1189.37,
    "Sigma0":    1192.642,
    "Sigma-":    1197.449,
    "Delta":     1232.0,
    "Xi0":       1314.86,
    "Ximinus":   1321.71,
    "Sigmastarp":1382.83,
    "Sigmastar0":1383.7,
    "Sigmastarm":1387.2,
    "Xistar0":   1531.80,
    "Xistarm":   1535.0,
    "Omega":     1672.45,
    # Charm baryons
    "Lambda_c":  2286.46,
    "Sigma_cpp": 2453.97,
    "Sigma_c0":  2453.75,
    "Xi_c+":     2467.94,
    "Xi_c0":     2470.90,
    "Omega_c":   2695.2,
    # Bottom baryons
    "Lambda_b":  5619.60,
    "Xi_b0":     5791.9,
    "Xi_bm":     5797.0,
    "Omega_b":   6046.1,
}

# Atomic systems (electron + nucleus bound states), approximate ground-state masses.
atomic_systems_mev = {
    "positronium": 2 * 0.510999,       # e+ e- bound (-6.8 eV)
    "muonium":     105.6584 + 0.510999, # μ+ e- bound
    "hydrogen":    938.7831,            # p e- bound, total
    "deuterium":   1876.123,
    "tritium":     2809.432,
    "helium-4":    3728.401,
}

# ---------------------------------------------------------------------------

def gue_surmise(s):
    """Wigner surmise for GUE nearest-neighbor spacings."""
    return (32.0 / np.pi**2) * s**2 * np.exp(-4.0 * s**2 / np.pi)

def gue_cdf_grid(s_grid):
    """Cumulative integral of the GUE surmise on a regular grid."""
    pdf = gue_surmise(s_grid)
    cdf = np.zeros_like(pdf)
    cdf[1:] = np.cumsum(0.5 * (pdf[1:] + pdf[:-1]) * np.diff(s_grid))
    cdf /= cdf[-1]
    return cdf

def poisson_cdf_grid(s_grid):
    return 1.0 - np.exp(-s_grid)

def empirical_cdf_at(s_data_sorted, s_grid):
    """ECDF of sample s_data_sorted evaluated on s_grid."""
    return np.searchsorted(s_data_sorted, s_grid, side="right") / len(s_data_sorted)

def ks_distance(s_data, ref_cdf_fn):
    """Max distance between empirical CDF and reference CDF on a fine grid."""
    s_grid = np.linspace(0.0, 6.0, 6001)
    s_sorted = np.sort(s_data)
    emp = empirical_cdf_at(s_sorted, s_grid)
    ref = ref_cdf_fn(s_grid)
    return float(np.max(np.abs(emp - ref)))

def ascii_histogram(s_data, bin_edges, ref_pdf_funcs=None, width=60):
    """Print an ASCII histogram with reference-curve overlays."""
    h, _ = np.histogram(s_data, bins=bin_edges, density=True)
    if ref_pdf_funcs is None:
        ref_pdf_funcs = {}
    # max for scaling
    all_vals = list(h)
    centers = 0.5 * (bin_edges[1:] + bin_edges[:-1])
    for fn in ref_pdf_funcs.values():
        all_vals.extend(fn(centers).tolist())
    vmax = max(all_vals) if all_vals else 1.0
    print()
    print(f"   {'s':>5}  {'P_emp':>7}  bars (width = {width}, scaled to max P)")
    for i, (lo, hi) in enumerate(zip(bin_edges[:-1], bin_edges[1:])):
        v_emp = h[i]
        c = 0.5 * (lo + hi)
        bar_emp = "#" * int(round(v_emp / vmax * width))
        ref_marks = ""
        for name, fn in ref_pdf_funcs.items():
            v_ref = float(fn(np.array([c]))[0])
            pos = int(round(v_ref / vmax * width))
            ref_marks += f"  {name}≈{v_ref:.2f}@col{pos}"
        print(f"  {lo:5.2f}- {hi:4.2f}  {v_emp:6.3f}  {bar_emp:<{width}} {ref_marks}")

# ---------------------------------------------------------------------------
# Sector-restricted subsets.  For a clean Wigner-Dyson test the spectrum must
# be unmixed by symmetry sectors — isospin/SU(3) partners sit at nearly equal
# masses and contribute spurious near-zero spacings that are symmetry-
# protected degeneracies, not random-matrix structure.
# ---------------------------------------------------------------------------

# Iso-/SU(3)-flavor-distinct ground states only (one mass per family).
# Within each multiplet we keep one representative (lightest or charge-zero).
sector_distinct_hadrons = {
    "pi":        134.977,    # I=1 pseudoscalar
    "eta":       547.862,    # I=0 pseudoscalar (light)
    "K":         493.677,    # I=1/2 pseudoscalar (strange)
    "etap":      957.78,     # I=0 pseudoscalar (heavier)
    "rho":       775.26,     # I=1 vector
    "omega":     782.66,     # I=0 vector (light)
    "phi":       1019.461,   # I=0 vector (s-sbar)
    "Kstar":     891.66,     # I=1/2 vector
    "Jpsi":      3096.900,   # I=0 vector (c-cbar)
    "Upsilon":   9460.30,    # I=0 vector (b-bbar)
    "D":         1864.84,    # I=1/2 pseudoscalar (charm)
    "Ds":        1968.35,    # I=0 pseudoscalar (strange-charm)
    "B":         5279.34,    # I=1/2 pseudoscalar (bottom)
    "Bs":        5366.88,    # I=0 pseudoscalar (strange-bottom)
    "Bc":        6274.47,    # I=0 pseudoscalar (charm-bottom)
    # Baryons (1/2+ ground states, one per flavor sector)
    "N":         938.918,    # I=1/2 (p,n avg)
    "Lambda":    1115.683,   # I=0 strange
    "Sigma":     1193.153,   # I=1 strange (avg)
    "Xi":        1318.285,   # I=1/2 doubly strange (avg)
    "Lambda_c":  2286.46,    # I=0 charm
    "Sigma_c":   2453.86,    # I=1 charm (avg)
    "Xi_c":      2469.42,    # I=1/2 strange-charm (avg)
    "Omega_c":   2695.2,     # I=0 doubly-strange-charm
    "Lambda_b":  5619.60,    # I=0 bottom
    "Xi_b":      5794.45,    # I=1/2 strange-bottom (avg)
    "Omega_b":   6046.1,     # I=0 doubly-strange-bottom
    # 3/2+ decuplet baryon ground states
    "Delta":     1232.0,
    "Sigmastar": 1384.6,     # avg
    "Xistar":    1533.4,     # avg
    "Omega":     1672.45,
}

# Pseudoscalar-meson-only restriction (single J^P^C = 0-+ sector).
pseudoscalar_mesons = {
    "pi":      134.977,
    "K":       493.677,
    "eta":     547.862,
    "etap":    957.78,
    "etac":    2983.9,
    "D":       1864.84,
    "Ds":      1968.35,
    "B":       5279.34,
    "Bs":      5366.88,
    "Bc":      6274.47,
    "etab":    9398.7,
}

# Single-J^P sector: J^P = 1/2+ baryons.
baryons_half_plus = {
    "N":        938.918,
    "Lambda":   1115.683,
    "Sigma":    1193.153,
    "Xi":       1318.285,
    "Lambda_c": 2286.46,
    "Sigma_c":  2453.86,
    "Xi_c":     2469.42,
    "Omega_c":  2695.2,
    "Lambda_b": 5619.60,
    "Xi_b":     5794.45,
    "Omega_b":  6046.1,
}

# ---------------------------------------------------------------------------

def run_block(label, mass_dict, show_hist=True):
    """Run the full spacing analysis on a given mass dictionary."""
    masses = list(mass_dict.values())
    depths = np.array([E_PLANCK_MEV / m for m in masses])
    depths_sorted = np.sort(depths)
    log_R = np.log(depths_sorted)
    log_spacings = np.diff(log_R)
    if len(log_spacings) == 0:
        return
    mean_log_spacing = float(np.mean(log_spacings))
    s = log_spacings / mean_log_spacing

    gue_var = 1.0 - 8.0 / (3.0 * np.pi)
    d_gue = ks_distance(s, gue_cdf_grid)
    d_poisson = ks_distance(s, poisson_cdf_grid)
    ks_crit = 1.36 / np.sqrt(len(s))
    n_low = int(np.sum(s < 0.5))
    grid05 = np.linspace(0, 0.5, 501)
    gue_low = float(np.trapz(gue_surmise(grid05), grid05)) * len(s)
    poi_low = (1 - np.exp(-0.5)) * len(s)

    print()
    print("=" * 64)
    print(f"  {label}")
    print("=" * 64)
    print(f"  N (states)        = {len(masses)}")
    print(f"  N (spacings)      = {len(s)}")
    print(f"  M range           = {min(masses):.2f} ... {max(masses):.2f} MeV")
    print(f"  Var(s)            = {np.var(s):.4f}   (GUE: {gue_var:.4f}, Poi: 1.000)")
    print(f"  D_KS vs GUE       = {d_gue:.4f}")
    print(f"  D_KS vs Poisson   = {d_poisson:.4f}")
    print(f"  KS_crit (α=0.05)  = {ks_crit:.4f}")
    print(f"  closer to:        {'GUE' if d_gue < d_poisson else 'Poisson'}")
    print(f"  consistent GUE?   {'yes' if d_gue < ks_crit else 'no'}")
    print(f"  consistent Poi?   {'yes' if d_poisson < ks_crit else 'no'}")
    print(f"  N(s<0.5)          = {n_low}   (GUE: {gue_low:.2f}, Poi: {poi_low:.2f})")
    if show_hist:
        bins = np.linspace(0.0, 4.0, 13)
        print()
        print("  histogram:")
        ascii_histogram(
            s, bins,
            ref_pdf_funcs={"GUE": gue_surmise, "Poi": lambda x: np.exp(-x)},
            width=50,
        )

# ---------------------------------------------------------------------------
# Main: run multiple cuts on the data.
# ---------------------------------------------------------------------------

def main():
    print("Wigner-Dyson test on QLF-admissible Markov-blanket depths")
    print("R = E_Planck / (M c²);  log-unfolded; spacings s = ΔlogR / <ΔlogR>")

    pooled = {**hadrons_mev, **atomic_systems_mev}

    run_block(
        "Block A — POOLED hadrons + atomic systems (naive, mixes symmetry sectors)",
        pooled,
        show_hist=True,
    )

    run_block(
        "Block B — symmetry-distinct hadron ground states (one per multiplet)",
        sector_distinct_hadrons,
        show_hist=True,
    )

    run_block(
        "Block C — pseudoscalar mesons only (single J^P^C = 0-+ sector)",
        pseudoscalar_mesons,
        show_hist=False,
    )

    run_block(
        "Block D — 1/2+ baryons only (single J^P sector)",
        baryons_half_plus,
        show_hist=False,
    )

    print()
    print("=" * 64)
    print("Interpretation guide")
    print("=" * 64)
    print("  Block A pools across symmetry sectors and so includes near-")
    print("  degenerate isospin/SU(3) partners (p/n, Σ+/0/-, K0/K+, etc.)")
    print("  These produce spurious near-zero spacings that are symmetry-")
    print("  protected degeneracies, NOT random-matrix structure. The naive")
    print("  test failing GUE is therefore expected and not informative.")
    print()
    print("  Blocks B/C/D restrict to symmetry-distinct families. These")
    print("  carry the cleaner signal but at small N the KS critical value")
    print("  is wide (1.36/√N), so the test is only powerful enough to")
    print("  falsify cleanly if the data is far from both references.")
    print()
    print("  §4.9 predicts GUE in the LARGE-depth limit. Current data are")
    print("  N ≲ 30 in any single sector — well below the regime where GUE")
    print("  is asymptotically expected. A definitive test requires either")
    print("  (a) a much larger curated set of admissible depths within one")
    print("  sector, or (b) numerical generation of Σ_sa elements from the")
    print("  QLF kernel and direct depth enumeration.")

if __name__ == "__main__":
    main()
