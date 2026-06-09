#!/usr/bin/env python3
"""
gravity_emergence_demo.py — G's structural emergence, and the hierarchy as a
blanket-depth (frequency) distribution.

Honest scope (matches Gravity_From_Delay.md §8 and Experimental_Consistency.md §8):
  - QLF derives the *form* of Newton's law and the structural identity
    G = L_Planck² c³ / ℏ from the primordial-blanket holographic event count.
  - It does NOT predict G's absolute SI value from nothing: in the substrate-
    first ontology L_Planck/τ_Planck are primitives, so G's SI number is the
    calibration of the substrate event quantum, not a free-parameter prediction.
  - The genuinely open piece — why the proton sits ~10¹⁹ Planck-depths down —
    is the residual hierarchy problem, anchored at the proton mass (Hadronic
    Depth). This demo shows that the *hierarchy* (gravity's weakness) IS the
    proton's Markov-blanket depth squared, scaled by the substrate-derived α.

Pure Python (no deps). CODATA constants.
"""
import math

# ---- CODATA / SI constants ----
c     = 299792458.0
hbar  = 1.054571817e-34
G     = 6.67430e-11
L_P   = 1.616255e-35           # Planck length
e     = 1.602176634e-19
eps0  = 8.8541878128e-12
m_p   = 1.67262192369e-27
m_e   = 9.1093837015e-31
alpha = 1 / 137.035999084      # CODATA (QLF substrate derivation: 1/137.000, 0.026%)
kB    = 1.380649e-23

print("== Part A — Newton's law + G's form from the primordial Markov blanket ==")
print("   Holographic chain (Gravity_From_Delay.md / QLF_GravityFromDelay.lean):")
print("     boundary event count  N = 4πR²/L_P²   (Fuller geodesic-sphere faces)")
print("     per-event entropy     log 2           ⇒  S = (4πR²/L_P²)·k_B·log 2")
print("     equipartition T + Bekenstein dS/dx  ⇒  F = T·dS/dx = G M m / r²")
G_struct = L_P**2 * c**3 / hbar
print(f"   ⇒ G = L_P²·c³/ℏ = {G_struct:.5e}   (CODATA G = {G:.5e},  ratio {G_struct/G:.6f})")
F_demo = G_struct * 1.0 * 1.0 / 1.0**2
print(f"   sample: two 1 kg masses at 1 m → F = {F_demo:.5e} N  (= G, as it must)")
print("   HONEST: G's SI value is the calibration of the substrate event quantum")
print("   (L_P a primitive), NOT a from-nothing prediction. The *form* is derived.")

print("\n== Part B — The hierarchy IS the blanket-depth (frequency) distribution ==")
m_Planck = math.sqrt(hbar * c / G)
R_e = m_Planck / m_e          # blanket depth in Planck units = inverse frequency
R_p = m_Planck / m_p
H0  = 2.184e-18               # s^-1  (H0 ≈ 67.4 km/s/Mpc)
R_cosmic = (c / H0) / L_P     # Hubble radius in Planck lengths
print(f"   mass m  ↔  blanket depth R = m_Planck/m = E_Planck/(mc²) = 1/frequency:")
print(f"     electron   R_e      ≈ {R_e:.3e}")
print(f"     proton     R_p      ≈ {R_p:.3e}")
print(f"     cosmos     R_cosmic ≈ {R_cosmic:.3e}   (deepest blanket = lowest frequency)")
print("   Lighter particle ⇒ deeper blanket ⇒ lower frequency. The mass spectrum")
print("   is a frequency/depth distribution spanning Planck (R=1) to cosmos (~10⁶¹).")

print("\n   Punchline — gravity's weakness = (proton depth)⁻², scaled by α:")
ratio_direct = (G * m_p**2) / (e**2 / (4*math.pi*eps0))   # F_grav/F_EM, two protons
ratio_depth  = 1.0 / (alpha * R_p**2)                      # = (1/α)·(m_p/m_Planck)²
print(f"     F_grav/F_EM (two protons), direct  G m_p²/(e²/4πε₀) = {ratio_direct:.4e}")
print(f"     (1/α)·(1/R_p²)                                       = {ratio_depth:.4e}")
print(f"     ratio                                                = {ratio_direct/ratio_depth:.6f}")
print("   ⇒ gravity is weak BECAUSE the proton sits ~10¹⁹ Planck-depths down.")
print("     The hierarchy IS the blanket-depth (frequency) ratio; α (substrate-")
print("     derived) is the only constant. Matches the textbook ~8×10⁻³⁷.")

print("\n   HONEST: R_p (the proton's depth) is the input here — anchored at the")
print("   proton mass, a hydrogen-scale observable (Hadronic Depth). Deriving R_p")
print("   from below — why the proton is that deep — is the residual hierarchy")
print("   problem, and remains open. The frequency distribution recasts it; it")
print("   does not yet close it.")
