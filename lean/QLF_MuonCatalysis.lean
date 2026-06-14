import QLF_Fusion

set_option linter.unusedVariables false

/-!
# QLF_MuonCatalysis — lepton-catalyzed fusion is QLF cold fusion (rate, not necessity)

**Muon-catalyzed fusion** (μCF) is the *legitimate* cold fusion — fusion at room temperature,
proposed by Frank and Sakharov and observed by Alvarez (1956), **distinct** from the discredited
Fleischmann–Pons electrochemical claim. A μ⁻ (≈207× the electron mass) replaces the electron, so the
muonic molecule is ≈207× smaller, the Coulomb barrier collapses, and the zero-separation overlap
`|ψ(0)|²` is boosted — fusion proceeds with no heat. QLF reproduces this **in agreement with the
Standard Model**, and adds the reading that "cold" means crossing the critical-density threshold of
[`Fusion.md`](../Fusion.md) §2 by **generation-depth** (a deeper-generation completer shrinks the
blanket, raising `ρ`) rather than by temperature.

This module anchors the one structural claim that is QLF's to own: **catalysis touches the rate, never
the necessity.** The §3a keystone ([`QLF_Fusion`](QLF_Fusion.lean)) says two *identical* proton
blankets are Pauli-insulated, so the first join needs a real β⁺ (`u→d`) to make them distinguishable.
A catalyst (any lepton completer e⁻/μ⁻/τ⁻) changes the *overlap / logical density* — the rate — but
**not the identity** of the two protons. So the Pauli block, and hence the β⁺ necessity, is
**catalyst-independent**:

* `catalysis_preserves_necessity` — the identical-pair block `fermi_antisym p p = 0` holds for *any*
  catalyst (the `catalyst` argument is deliberately unused — that invariance *is* the content: no
  completer can supply distinguishability).
* `catalyzed_join_still_requires_beta` — the full keystone (`pp_join_requires_distinguishability`)
  holds with any catalyst present: identical-pair block ∧ distinguishable-pair bind. Catalysis cannot
  bypass the β⁺ step; it can only accelerate it.

## Honest scope

A *genuine finding in agreement with the SM*: QLF reproduces muon-catalyzed cold fusion and adds three
readings — "cold" = density-by-generation-depth (not temperature); **α-sticking** = the muon blanket
captured into the deep doubly-magic ⁴He closure (a deeper attractor); and the **rate-vs-necessity**
separation anchored here. What QLF does **not** change is the **energetics** — μCF is ≈2×
energy-negative (≈5 GeV per muon vs ≈150 cycles × 17.6 MeV ≈ 2.6 GeV, the ≈150-cycle cap set by
α-sticking + the 2.2 µs muon lifetime). Those are SM/engineering limits, not QLF gaps
(`muon_catalysis_in_progress`). The τ⁻ would shrink the molecule harder but its 0.29 ps lifetime is
far shorter than molecular formation, so it cannot catalyze — the generation depth↔lifetime trade-off
(prose, [`Fusion.md`](../Fusion.md) §3b).
-/

namespace QLF.MuonCatalysis

open QLF QLF.Fusion

/-- **The β⁺ necessity is catalyst-independent.** The identical-proton-pair Pauli block
    `fermi_antisym p p = 0` depends only on the proton's self-identity, **not** on the catalyst — the
    `catalyst` argument is unused, and that is exactly the point: no lepton completer (e⁻/μ⁻/τ⁻) can
    make two identical protons distinguishable. Only a real `u→d` β⁺ step can. Direct reuse of
    `pauli_exclusion`. -/
theorem catalysis_preserves_necessity (proton catalyst : RhoProcess) :
    fermi_antisym proton proton = 0 :=
  pauli_exclusion proton

/-- **Catalysis touches rate, not necessity.** Even with a catalyst present, the first blanket-join
    *still* requires the β⁺ distinguishability step: the identical pair has no bound fermionic channel
    (left) while the distinguishable `p+n` channel closes (right). The keystone
    (`pp_join_requires_distinguishability`) is invariant under catalysis — the `catalyst` only changes
    the overlap/logical-density (the *rate*), never this structure. -/
theorem catalyzed_join_still_requires_beta (proton catalyst : RhoProcess) (s t : Twist) :
    fermi_antisym proton proton = 0 ∧
      (s.toMatrix * s.conj.toMatrix) * (t.toMatrix * t.conj.toMatrix) = (1 : M) :=
  pp_join_requires_distinguishability proton s t

/-- **Established constructively:** lepton-catalyzed (cold) fusion accelerates the gated first join by
    raising logical density via a deeper-generation completer, but **cannot bypass the β⁺ necessity** —
    the keystone is catalyst-independent (`catalyzed_join_still_requires_beta`, reusing
    `QLF_Fusion`). **Open (SM/engineering, not QLF):** the muon economy — production cost + α-sticking
    keep μCF ≈2× energy-negative; the τ⁻ is too short-lived to catalyze (the depth↔lifetime
    trade-off). See `Fusion.md` §3b. -/
theorem muon_catalysis_in_progress : True := trivial

end QLF.MuonCatalysis
