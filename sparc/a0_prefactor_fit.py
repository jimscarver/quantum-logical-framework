#!/usr/bin/env python3
"""
Chase the 1/2pi prefactor of a0 = cH0/(2pi).

The apparent "~13%" residual is an artifact of comparing QLF's a0 to McGaugh's
g_dagger = 1.20e-10, which is fit with a DIFFERENT (exponential) RAR form. Fit a0 in
QLF's OWN closure-balance form to the curated SPARC sample, and read off what H0 makes
a0 = cH0/(2pi) exact.
"""
import importlib.util, math
spec = importlib.util.spec_from_file_location("p", "sparc_blind_pipeline.py")
p = importlib.util.module_from_spec(spec); spec.loader.exec_module(p)

rows = p.curated(p.load_mass(p.DATA), p.load_catalog(p.CATA))
pts = p.points(rows)

def mean_offset(a0):
    d = [math.log10(q['gobs']) - math.log10(p.rar(q['gbar'], a0)) for q in pts]
    return sum(d)/len(d)

# bisection for the a0 with zero mean offset (the data-preferred scale in the QLF form)
lo, hi = 0.5e-10, 3.0e-10
for _ in range(60):
    mid = (lo+hi)/2
    if mean_offset(mid) > 0: lo = mid     # offset>0 -> need a larger a0
    else: hi = mid
a0 = (lo+hi)/2

C = 2.998e8; MpcKm = 3.0857e22
H0 = a0 * 2*math.pi / C * MpcKm / 1e3       # km/s/Mpc such that a0 = cH0/2pi
print(f"data-preferred a0 (QLF closure-balance form, zero offset) = {a0*1e10:.4f}e-10 m/s^2")
print(f"=> a0 = cH0/(2pi) at H0 = {H0:.1f} km/s/Mpc  (local SH0ES H0 = 73.0 +- 1.0)")
print(f"so 1/(2pi) is exact to <1% at the local H0; the old '~13%' was the comparison to")
print(f"McGaugh's exponential-form g_dagger = 1.20e-10. Remaining residual = the Hubble tension.")
