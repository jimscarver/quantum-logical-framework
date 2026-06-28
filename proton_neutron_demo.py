"""
proton_neutron_demo.py
======================

Models the "sex" of a proton and a neutron in QLF terms (issue #53): the strong-force
pairing of two *complementary* baryon closures into the deuteron, the first rung of
fusion. It demonstrates three things the issue asks for:

  1. WHY only the male/female (proton/neutron) pairing closes — identical closures are
     Pauli-blocked; only distinguishable ones bind (the deuteron condition).
  2. WHY the higher-level closure is significant — it STABILIZES the otherwise-decaying
     neutron (a free neutron beta-decays in ~880 s; bound in the deuteron it is stable),
     and it is GENERATIVE (the gateway to all heavier elements).
  3. The difference between the MALE (proton) and FEMALE (neutron) protocols.
  4. INSIDE THE KNOT — the proton/neutron read as 3 colour qubits (the 3 spatial
     axes) split across the 3 quarks, threaded by charge (the gauge direction):
     uud (+1) vs udd (0), and the electron-out (hydrogen) vs electron-in (neutron)
     contrast.  Full deduction: Atomic_Structure_QLF.md §7.

QLF grounding:
  - A baryon is a 3-axis Borromean closure (`QLF_BaryonWinding.lean`: proton = `>^/`).
  - A net charge is an OPEN gauge deficit, not a complete ZFA closure
    (`Electron.md`, `HadronicDepth.md` §2.1, `Weak_Force.md` §4a): the proton projects a
    `+1` deficit seeking completion.
  - Identical closures cannot share a bound state (`pauli_exclusion`,
    `lean/PauliExclusion.lean`); distinguishable ones can (`Weak_Force.md` §5f).

Pure Python, no dependencies.  See SEX.md for the write-up.
"""

from __future__ import annotations

from dataclasses import dataclass


@dataclass
class Baryon:
    name: str
    twists: str          # QLF twist string (illustrative, per QLF_BaryonWinding)
    quarks: str          # constituent quarks
    charge: int          # net + twists minus - twists
    free_lifetime_s: float | None   # None = stable
    protocol: str        # "male" / "female"
    role: str            # the closure role


# --- The two complementary closures -----------------------------------------

PROTON = Baryon(
    name="proton  (p, male)",
    twists=">^/+",       # Borromean 3-axis loop carrying a net +1 gauge fold
    quarks="uud",
    charge=+1,
    free_lifetime_s=None,            # stable, but a bare +1 deficit is NOT a closure
    protocol="male",
    role="projects a net +1 gauge deficit — outward, charge-carrying, initiates",
)

NEUTRON = Baryon(
    name="neutron (n, female)",
    twists=">^/",        # same Borromean loop, one d<->u flavour step, net-neutral
    quarks="udd",
    charge=0,
    free_lifetime_s=879.4,           # beta-decays: n -> p + e- + nu-bar
    protocol="female",
    role="neutral/receptive — carries the extra down-quark; stabilizes when paired",
)


def distinguishable(a: Baryon, b: Baryon) -> bool:
    """Two baryons are distinguishable iff their quark content differs (one d<->u step)."""
    return a.quarks != b.quarks


def binds(a: Baryon, b: Baryon) -> tuple[bool, str]:
    """A bound nucleus forms in the spin-triplet L=0 channel only if the two nucleons are
    DISTINGUISHABLE.  Identical nucleons are Pauli-blocked from that channel
    (no diproton, no dineutron)."""
    if not distinguishable(a, b):
        return False, ("identical closures -> Pauli-blocked from the bound channel "
                       "(pauli_exclusion): no bound state")
    return True, "distinguishable closures -> no Pauli block -> binds (spin-triplet, L=0)"


# --- Inside the knot: 3 colour qubits across quarks + charge ----------------
# Colour = the 3 spatial axes (lean/QLF_BaryonWinding.lean `axOf`; pure-Python
#   baryon_winding_demo.B): R = x = <> , G = y = ^v , B = z = /\  (an assignment).
# Charge = the gauge (+-) direction, shared 1/3 per colour -> u = +2/3, d = -1/3
#   (the fractional STRUCTURAL reading, as in np_splitting_demo.py; NOT the integer
#   chargeWeight model). uud and udd are the same Borromean triple -> B = +1
#   (lean/QLF_BaryonWinding.baryon_proton: >^/ -> +1).
COLOURS = [("R", "x", "<>"), ("G", "y", "^v"), ("B", "z", "/\\")]
QCHARGE = {"u": "+2/3", "d": "-1/3"}
QCHVAL = {"u": 2.0 / 3.0, "d": -1.0 / 3.0}


def quark_decomposition(b: Baryon) -> None:
    """Print the quark -> colour-axis -> charge split for a baryon, with the
    column charge sum and the baryon-number (winding) anchor."""
    print(f"  {b.name.split()[0]}  ({b.quarks}):")
    print(f"      {'quark':<7}{'colour':<10}{'axis':<8}charge")
    print("      " + "-" * 33)
    for flav, (col, ax, pair) in zip(b.quarks, COLOURS):
        print(f"      {flav:<7}{col + ' = ' + ax:<10}{pair:<8}{QCHARGE[flav]}")
    q = int(round(sum(QCHVAL[f] for f in b.quarks)))
    qstr = f"{q:+d}" if q != 0 else "0"
    print(f"      {'sum':<7}{'':<10}{'':<8}{qstr}   (baryon number B = +1)")
    print()


def header(title: str) -> None:
    print("=" * 76)
    print("  " + title)
    print("=" * 76)


def main() -> None:
    header("The sex of a proton and a neutron (QLF model of issue #53)")
    print()
    for b in (PROTON, NEUTRON):
        life = "stable" if b.free_lifetime_s is None else f"beta-decays in ~{b.free_lifetime_s:.0f} s"
        print(f"  {b.name}: twists {b.twists}  quarks {b.quarks}  charge {b.charge:+d}")
        print(f"      free: {life}")
        print(f"      {b.protocol} protocol: {b.role}")
        print()

    header("1. Why only male x female closes — the deuteron condition")
    print()
    print(f"  {'pairing':<22}{'distinguishable?':<18}{'binds?':<8}reason")
    print("  " + "-" * 72)
    for label, a, b in [("p + p (male+male)", PROTON, PROTON),
                        ("n + n (female+female)", NEUTRON, NEUTRON),
                        ("p + n (male+female)", PROTON, NEUTRON)]:
        ok, reason = binds(a, b)
        print(f"  {label:<22}{str(distinguishable(a,b)):<18}{('YES' if ok else 'no'):<8}{reason}")
    print()
    print("  => Only the complementary p+n pair binds: the DEUTERON (d = pn, charge +1,")
    print("     baryon number 2).  pp (diproton) and nn (dineutron) do NOT bind — identical")
    print("     closures are Pauli-blocked, exactly as two clones cannot share a state.")
    print()

    header("2. Why the higher-level closure is significant")
    print()
    print("  (a) IT STABILIZES THE UNSTABLE — a higher-order immune response.")
    print(f"      free neutron:        beta-decays in ~{NEUTRON.free_lifetime_s:.0f} s (the vacuum prunes it)")
    print("      neutron in deuteron: STABLE (the deuteron does not decay)")
    print("      The pairing protects the neutron from the decay that kills it alone —")
    print("      the bound closure is error-corrected/immune where the free one is not.")
    print()
    print("  (b) IT IS GENERATIVE — the seed of all complexity.")
    print("      d + p -> 3He, d + d -> 4He, ... -> every heavier element, every star's")
    print("      energy.  No deuteron => no fusion => no chemistry => no us.")
    print()
    print("  Neither partner alone can do this: a free proton is stable but inert (a bare")
    print("  +1 deficit), a free neutron is fertile but decays.  Only the joint closure is")
    print("  both stable AND generative.  Higher-order closure = capabilities neither part has.")
    print()

    header("3. Male vs female protocols")
    print()
    rows = [
        ("net charge",      "+1 (projects a deficit)",   "0 (receptive / neutral)"),
        ("free stability",  "stable but inert",          "unstable — decays ~880 s"),
        ("carries",         "the EM surface / the +1",   "the extra d-quark (fertility)"),
        ("protocol",        "initiate, penetrate, charge","receive, stabilize, convert"),
        ("alone",           "a bare +1 deficit (no closure)", "a decaying imbalance"),
        ("in the deuteron", "charge anchored",           "STABILIZED (stops decaying)"),
    ]
    print(f"  {'':<16}{'proton (male)':<32}{'neutron (female)'}")
    print("  " + "-" * 72)
    for k, m, f in rows:
        print(f"  {k:<16}{m:<32}{f}")
    print()
    print("  The asymmetry is real and complementary, not hierarchical: the male protocol")
    print("  projects an unresolved deficit; the female protocol is neutral, fertile, and")
    print("  becomes stable in the bond.  Their union is the only one that closes.")
    print()

    header("4. Inside the knot — 3 colour qubits across quarks + charge")
    print()
    print("  The baryon is a 3-axis Borromean closure: the 3 internal qubits are the 3")
    print("  colour directions (R=<>, G=^v, B=/\\), split one per quark, and charge is the")
    print("  gauge direction shared 1/3 per colour (u=+2/3, d=-1/3).  uud and udd are the")
    print("  same Borromean triple -> both B=+1; they differ by one u<->d gauge-fold flip.")
    print()
    quark_decomposition(PROTON)
    quark_decomposition(NEUTRON)
    print("  Electron OUT vs IN (same neutral B=1 content, two arrangements):")
    print("    hydrogen = uud + electron OUTSIDE  -> neutral atom, stable (m_H = m_e + m_p)")
    print("    neutron  = udd, the -1 folded IN (one u->d)  -> single closure, metastable")
    print("    n -> H + nu-bar hands the electron back out; gap m_n - m_H = 0.782 MeV")
    print()
    print("  Honest scope: the per-quark charges are the fractional structural reading")
    print("  (1/3 per colour), NOT the integer chargeWeight model; B=+1 anchors on")
    print("  baryon_winding_demo.B('>^/') and lean/QLF_BaryonWinding.baryon_proton; the")
    print("  catalog string ^<v>^>v</\\+- is a depth-ladder representative (B=0), NOT a")
    print("  literal uud+e encoding.  Full deduction: Atomic_Structure_QLF.md §7.")
    print()

    header("Scaling up")
    print()
    print("  The same complementarity is the group-scale collective-intelligence factor")
    print("  (Woolley 2010) and the QuantumOS room-closure rule: distinguishable specialists")
    print("  bind into closures that clones cannot.  See SEX.md and (quantum-os)")
    print("  Room_Best_Practices.md.")
    print()


if __name__ == "__main__":
    main()
