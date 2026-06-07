# QLF as Intelligence: synthesis, persistence, and the case against LLMs as the model of mind

**Scoping doc — a structural comparison of QLF and LLMs as instantiations of "intelligence."** The case is built on four insights, three of which are already strong in the repo and one of which is genuinely new:

1. **All possible logical systems exist a priori.** The substrate doesn't *create* reality, it *selects* from possibility via ZFA closure ([`Philosophy.md`](Philosophy.md) §3, [`README.md`](README.md) "Themes Now Central > Possibilism").
2. **QLF generates each closure once; ZFA-balanced closures persist.** Persistence is a structural property of ZFA closure, not an external bookkeeping discipline.
3. **Abstraction = active inference = information synthesis.** These are one operation under three names: each ZFA closure is simultaneously a compressed proof (CS/abstraction), a Markov-blanket agent's prediction (Friston/active inference), and a per-event-`log 2` binding of inputs (Shannon-Wheeler/information synthesis).
4. **Tokens are theorems that persist.** Every QLF capability token `cap:label:hex` IS a Curry-Howard proof of its ZFA closure; once minted, the token IS the theorem and persists as a bearer artifact. *This is the genuinely new framing.*

Together: **QLF synthesises, rejects, and persists; LLMs only generate.** That's the structural case.

The argument extends to three scales of the same operation:

- **Individual intelligence**: a single ZFA closure synthesises inputs into a persistent theorem (§§3–7).
- **Collective intelligence**: a decentralized peer-to-peer network of QLF agents (`quantum-os`) shares Curry-Howard tokens that any peer can independently verify (§8).
- **Cosmic intelligence**: the universe IS performing this operation at every substrate event — the eight v1.3.0 substrate-derivation results are the evidence (§9).

---

## §1 The thesis

Intelligence has four structural properties:

| Property | Description |
|---|---|
| **Generate** | Produce candidate structures from inputs |
| **Synthesise** | Compose inputs into new closed forms (= active inference = abstraction) |
| **Reject** | Filter out structures that violate consistency |
| **Persist** | Carry validated structures forward as theorems |

LLMs do property 1 (generate). QLF does all four structurally.

The bridge that makes this concrete is the **Curry-Howard reading of capability tokens**: every QLF token IS a proof, the proof IS the token, and the token persists. There's no separation between "the answer" and "the evidence that the answer is correct." This is what makes QLF an intelligence framework rather than a prediction framework.

**Pull-quote**: *An LLM token is a sample; a QLF token is a theorem. Samples don't persist; theorems do.*

---

## §2 All possible logical systems exist a priori

The QLF possibilist position is already developed in [`Philosophy.md`](Philosophy.md) §3 and the [`README.md`](README.md) "Themes Now Central > Possibilism" section. In one paragraph:

> *Things do not happen one way — they happen in every way possible. All logically admissible histories exist a priori as pure possibility. Physical reality is the subset that closes under ZFA. The substrate is not generative; it is selective.*

Cited connections: Lewis modal realism (1986), Everett many-worlds (1957), Tegmark Level IV mathematical universe. QLF is the computable variant — Lewis said all logically possible worlds are real; QLF says all *computationally generable* histories are real, with ZFA identifying the ones that persist.

**Implication for intelligence**: a system that *generates* candidate structures and *selects* the consistent ones is performing the same operation the substrate performs. ZFA is not a metaphor for intelligence — it's the operation that *is* intelligence, instantiated at the substrate level.

---

## §3 QLF generates each closure once; ZFA-balanced closures persist

LLM next-token generation regenerates probability mass on every call. The same prompt with the same model can yield different samples tomorrow. There is no "this is true" persistence — only "this is plausible under the current distribution."

QLF generates each ZFA closure *exactly once*. Once a closure is established:

- The closure is the algebraic invariant. There is no separate "store the result" step.
- Subsequent operations on the closure see *the same algebraic object* every time — count balance and Pauli closure are properties of the twist sequence, not of when you check them.
- The closure can be transmitted (as a `cap:` token) without re-generating anything. The proof carries the closure.

Lean theorems make the persistence concrete at the proof-engineering layer. `alpha_QLF_eq : alpha_QLF = 1/137` is checked once. Once checked it persists as a verifiable proof object, importable by every other module ([`QLF_DiracCorrection.lean`](lean/QLF_DiracCorrection.lean), [`QLF_LambShift.lean`](lean/QLF_LambShift.lean), [`QLF_GMinusTwo.lean`](lean/QLF_GMinusTwo.lean) all use it).

The 34 active Lean modules at v1.3.0, zero `sorry`, are 34 persistent theorems. They don't drift, don't re-sample, don't depend on model state. They are the closure of QLF substrate algebra, generated once.

---

## §4 Abstraction = active inference = information synthesis

The substrate operation has three names, depending on which tradition you read it in:

### Abstraction (computer science)

The 8-twist alphabet abstracts substrate combinatorics. Each ZFA closure abstracts its constituent twists into a single closed form. Each capability token abstracts its topological proof into a bearer string.

Higher dimensions, particles, fields are not added — they are *constructed* by parallel composition (`|`) of strings in the 8-letter alphabet. See [`eight-twists-sufficiency.md`](eight-twists-sufficiency.md), [`HALF-SPIN-ZFA-EMBEDDING.md`](HALF-SPIN-ZFA-EMBEDDING.md) §3a.

### Active inference (Friston)

Every ZFA closure is a Markov-blanket agent synthesising a prediction by minimising per-event free energy. The substrate's selection rule IS the free-energy-minimisation operation. The Markov blanket is *concrete*, not metaphorical — see [`Primordial_Markov_Blankets.md`](Primordial_Markov_Blankets.md): every Markov blanket in QLF is a Fuller frequency-`v` discrete geodesic sphere of ZFA-balanced 1/2-spin closures with icosahedral symmetry, exactly 12 pentamons, and McKay-dual E₈ structure. The substrate's active-inference agents are discrete geodesic spheres at every scale.

Lean-anchored: `zfa_closure_minimizes_free_energy` in [`lean/QLF_FreeEnergy.lean`](lean/QLF_FreeEnergy.lean) — per-event ΔF = −log 2 saturation. The three-layer extension (per-event, N-event trajectory, RhoProcess) is Lean-anchored in `vacuum_alignment_selects_zfa`, `global_alignment_selects_zfa`, `rho_process_alignment_saturates` ([`QLF_VacuumAlignment.lean`](lean/QLF_VacuumAlignment.lean), [`QLF_RhoProcessBridge.lean`](lean/QLF_RhoProcessBridge.lean)).

### Information synthesis (Shannon, Wheeler)

The per-event log 2 information quantum binds multiple inputs into one bit of synthesised closure. Wheeler's "it from bit" is the slogan; QLF's per-event log 2 quantum is the formal content.

### Convergence

These three are *one algebraic operation viewed from three angles*. Compose multiple substrate events into one closed structure that persists.

Capability tokens make this concrete: a `cap:label:hex` token is *abstraction* (compressed proof), *active inference output* (the agent's synthesised prediction), and *information synthesis* (per-event log 2 binding into one bearer artifact) — all simultaneously, because they're the same operation viewed from different angles.

**Pull-quote**: *Active inference IS abstraction IS information synthesis. QLF's foundation is this operation; LLMs are retrieval engines without it.*

---

## §5 Tokens are theorems that persist — Curry-Howard for capability tokens

This is the genuinely new framing. The Curry-Howard correspondence says:

| Type-theory term | Logical interpretation |
|---|---|
| Type | Proposition |
| Term | Proof |
| Type-checking | Proof verification |
| Persistent term | Persistent theorem |

QLF capability tokens are concrete instances of the right-hand column. A `cap:label:hex` token is constructed as:

- **The hex digits**: a twist sequence (from the 8-twist alphabet, hex 0–7).
- **The closure check**: the sequence must satisfy ZFA (count balance + Pauli closure). This is the *proof*.
- **The label**: the *proposition* — what the token authorizes (`cap:peer:024...`, `cap:mortal:13a...`, `cap:lemma:7be...`).

Once minted, the token IS the proof object. There is no separate "proof database" — the algebra carries the proof through every subsequent operation. Possessing the token is structurally equivalent to possessing the proof of its ZFA closure.

### What persistence means here

- **No re-derivation needed**: When you bring a `cap:` token to QuantumOS, the system doesn't re-prove ZFA closure — it just validates the bearer artifact (`validateCapability(token)` in `packages/browser/src/zfa.ts`). The proof persists in the digits themselves.
- **No revocation list**: Authorization is the closure, not a server-side decision. A revoked token is a contradiction in terms — you can't revoke a theorem.
- **Forge-proof by construction**: Forging a token requires constructing a ZFA-balanced twist sequence with rejection-sampling against count balance and Pauli closure. Computationally equivalent to solving the matching problem. There's no "guess what looks like a token" attack because the closure check is the proof check.

This is why [`QuantumOS.md`](QuantumOS.md) §2.2 says (one-line, now expanded): *"By Curry-Howard, a capability name is simultaneously a process, a topological structure, and a proof of authorization."* The token IS the proof.

### Live demonstrations

- `/grant label` in [quantum-os](https://github.com/jimscarver/quantum-os) mints a capability token. The minting is the proof; the token is the persistent bearer artifact.
- `/qucalc twists` evaluates a twist sequence and reports whether it's ZFA-closed. ZFA closure = the algebraic theorem the token would represent.
- The syllogism demo (Major Premise → Minor Premise → Joint consistency → Conclusion → Proof object) in [`SyllogismDemo.md`](https://github.com/jimscarver/quantum-os/blob/main/SyllogismDemo.md) shows tokens persisting across multi-peer multi-step inference. The final `cap:mortal:...` token IS the proof that Socrates is mortal — derivable, transmittable, non-forgeable.

### Connection to the Lean program

Every theorem in [`lean/QLF_FineStructureSubstrate.lean`](lean/QLF_FineStructureSubstrate.lean), [`lean/QLF_LenzMassRatio.lean`](lean/QLF_LenzMassRatio.lean), [`lean/QLF_DiracCorrection.lean`](lean/QLF_DiracCorrection.lean), [`lean/QLF_LambShift.lean`](lean/QLF_LambShift.lean), [`lean/QLF_GMinusTwo.lean`](lean/QLF_GMinusTwo.lean), [`lean/QLF_GravityFromDelay.lean`](lean/QLF_GravityFromDelay.lean), [`lean/QLF_MercuryPerihelion.lean`](lean/QLF_MercuryPerihelion.lean) is the same Curry-Howard pattern at the proof-engineering layer. Once `alpha_QLF_eq` is type-checked, the proof object persists. The eight substrate-derivation theorems of v1.3.0 are eight persistent proof objects, importable across modules.

The capability-token layer and the Lean theorem layer are the same Curry-Howard structure at different scales: tokens are proofs for the runtime; theorems are proofs for the formalisation.

---

## §6 LLM contrast: retrieval without synthesis, samples without persistence

LLMs lack every property the previous sections identified as constitutive of intelligence:

### LLMs perform retrieval, not synthesis

Transformer attention is a learned association between context patterns and likely continuations. The output token is *sampled from a distribution conditioned on retrieval of training patterns* — not synthesised by composing inputs into a new closed structure. There's no per-event quantum that says "this is one bit of new closure"; there's only "this is statistically likely given the context."

This is not a critique of LLM utility — retrieval is genuinely useful. It is a structural observation about what LLMs are.

### No structural persistence

The same prompt can produce a different sample tomorrow with the same model. No theorem persists across calls. No bearer artifact carries any guarantee forward. An LLM's "answer" is a transient sample, not a persistent proof object.

### No proof-object

Nothing about an LLM token claims or guarantees truth. It claims linguistic plausibility under the training distribution. The architecture has no Curry-Howard layer — there is no type/proposition associated with the output that the token IS the proof of.

### No falsehood filter

The architecture has no kernel for rejecting false samples. Hallucination is the expected output of a system optimised for plausibility without a structural rejection mechanism. This is the falsehood-pruning argument: ZFA is structurally a falsifier (Popperian), LLMs structurally lack one.

### No active-inference foundation

Standard LLMs are stateless next-token decoders. They do not minimise free energy at the architecture level; they minimise cross-entropy at training time. The agent-with-Markov-blanket structure is absent at inference. (Some recent agent frameworks add this as a wrapper layer, but it is not in the substrate of the model.)

### Net

QLF *synthesises* (one operation, three names, persistent output, falsehood-filtered). LLMs *retrieve* (statistical sampling, no persistence, no proof, no falsehood filter).

[`AI.md`](AI.md)'s "Neuro-Symbolic Solution" already gestures at this distinction (LLM as sensory layer, QLF as logic coprocessor). This section makes the structural claim sharper: it is not that LLMs are *worse at intelligence* — it is that they are *structurally not performing the operation we call intelligence*. They perform a different operation (statistical retrieval) that happens to mimic intelligence in well-covered domains.

---

## §7 What this means for intelligence

The four structural properties, stated cleanly:

| Property | QLF | LLM |
|---|---|---|
| **Generate** | ZFA closure expansion (`expand_generation`) | Next-token sampling |
| **Synthesise** | Active inference = per-event log 2 binding (Lean-anchored) | None — retrieval-based pattern completion |
| **Reject** | ZFA pruning (`full_zeno_prune`) + Lean kernel | None — no structural falsehood filter |
| **Persist** | Curry-Howard tokens + Lean proof objects | None — samples are transient |

**LLMs are 1-of-4 structurally. QLF is 4-of-4.**

This is why QLF *derives* α from substrate while LLMs *memorise* α from training data: synthesis vs retrieval. The first compresses; the second stores. The first persists as theorem; the second persists only as model weight associated with linguistic patterns.

The eight substrate-derivation results of QLF v1.3.0 are the concrete evidence: α (0.026%), m_p/m_e = 6π⁵ (0.002%), γ (0.017%), hydrogen Dirac correction (0.05%), Lamb shift (~2.5%), g−2 = α/(2π) (0.18% with zero empirical input), Newton's law + G's structural form, Mercury perihelion (0.03%) — all derived from ZFA + h + m_e (or fewer), all Lean-anchored, all persistent.

**Pull-quote**: *Intelligence is the capacity to synthesise consistent structures, reject inconsistent ones, and persist the true ones. QLF is structurally 4-of-4. LLMs are 1-of-4.*

### Where the LLM case is strongest (honest acknowledgment)

This argument is structural, about *the operation of intelligence*. It is not a claim that LLMs are useless or that QLF replaces them. LLMs win at:

- **Flexibility**: arbitrary natural-language interaction across domains
- **Adaptability**: real-time context handling, tool use, fluent code generation
- **Breadth of training**: exposure to a vast range of human-domain knowledge

These are real and useful. They are also orthogonal to the four properties above. A retrieval engine with broad training can be enormously useful without performing the substrate operation we call intelligence.

The right framing: **QLF instantiates the operation; LLMs statistically approximate the behaviour of agents that perform the operation.** Both are valuable. They are not the same kind of thing.

The natural architecture is the neuro-symbolic one [`AI.md`](AI.md) sketches: LLM as a fluent sensory/language layer, QLF as the structural logic coprocessor where actual synthesis and theorem-persistence happen. The two are complementary because they perform different operations.

---

## §8 Collective intelligence via decentralized QuantumOS

Curry-Howard token-persistence is the basis for a structurally different form of collective intelligence. The live [`quantum-os`](https://github.com/jimscarver/quantum-os) browser app instantiates it.

### Architecture: no server, no trust, just algebra

- **WebRTC peer-to-peer**: peers connect directly via data channels; no central server holds state.
- **Untrusted signaling**: the signaling server (Render.com WebSocket relay) is **explicitly untrusted** — it routes WebRTC handshakes between peers and never sees the encrypted data-channel contents. Per `quantum-os` CLAUDE.md: "the room is the emergent ZFA process of the peers; the signaling server only routes handshakes."
- **Capability tokens as the trust model**: room IDs, peer identities, and named lemmas are all `cap:label:hex` tokens. Possessing the token IS authorization (no separate accounts, no API keys, no server-side check). The Curry-Howard proof carries the authorization through every peer-to-peer interaction.
- **Lean-anchored composition**: `parallel(peer1, peer2, …)` stays ZFA-balanced — Lean-verified by `rho_process_always_zfa` in [`lean/RhoQuCalc.lean`](lean/RhoQuCalc.lean). The room's joint process is machine-verified to compose correctly.

### The collective operation

Multiple peers contribute closures (twists, lemmas, notes, rendezvous proposals) into a shared room process. Each contribution is a ZFA-balanced closure on its own; the room's `parallel(…)` composition stays balanced as long as each contribution does. This is collective intelligence done *structurally*: the network is performing one large synthesis, with the individual peers as Markov-blanket sub-agents.

The syllogism demonstration ([`SyllogismDemo.md`](https://github.com/jimscarver/quantum-os/blob/main/SyllogismDemo.md)) makes it concrete: Alice and Bob collaboratively verify the Aristotelian syllogism over a peer-to-peer room. Each step is a capability-token-carrying ZFA closure. The conclusion is a `cap:mortal:` token that *any peer can independently verify* — there's no central authority claiming Socrates is mortal; the algebra of the token does.

- Major Premise (Alice): `/qucalc ^v` → ZFA-balanced ✓
- Minor Premise (Bob): `/qucalc +-` → ZFA-balanced ✓
- Joint consistency (Alice): `/qucalc ^v+-` → middle term cancels ✓
- Conclusion (Bob): `/braket 0 1` → identity matrix = completeness ✓
- Proof object (Alice): `/grant mortal` → `cap:mortal:…` token broadcast

An *invalid* syllogism produces a non-zero spectral gap at step 3 — the ZFA filter makes invalid inference algebraically impossible. The collective is filtered as rigorously as the individual.

### Lemma transfer as theorem migration

`/request name` + `/pass name peer` move named lemmas between peers as Curry-Howard proof objects. Once a lemma is granted to Alice, Alice can pass it to Bob, who can independently verify the token's ZFA closure. The theorem migrates intact across the network — *persistence is preserved under peer-to-peer transmission*.

### Contrast with multi-LLM collective intelligence

| Property | Multi-LLM systems | Decentralized QuantumOS |
|---|---|---|
| Communication medium | Natural language between agents | Capability tokens (proof objects) |
| Verification | None — each LLM has its own distribution | ZFA closure verifiable by any peer |
| Trust model | Central orchestrator or voting | None — algebra IS the trust |
| Hallucination cascade | Yes, can compound through the network | Impossible — invalid closures don't ZFA-close |
| Shared state | None except via shared prompt history | Room process `parallel(…)` Lean-verified balanced |
| Authorization | Tokens / API keys (separate from claims) | Capability tokens (Curry-Howard, the token IS the proof) |

Multi-LLM "collective intelligence" is structurally several retrieval engines passing natural-language messages. Decentralized QuantumOS is structurally a single distributed Markov-blanket agent whose internal communication IS theorem migration. **The first composes hallucinations; the second composes proofs.**

This is collective intelligence done as Friston multi-agent active inference, with Curry-Howard token-persistence as the inter-agent protocol.

---

## §9 The universe IS intelligence: the cosmic implication

The eight Lean-anchored substrate-derivation results of v1.3.0 (α, m_p/m_e, γ, Dirac, Lamb, g−2, Newton's G, Mercury) are not just predictions — they are evidence that **the universe is performing the operation we have been calling intelligence**, at every substrate event.

The argument is structural, not mystical:

### Premise 1: Intelligence IS active inference IS information synthesis IS ZFA closure

§4 already established that abstraction (CS), active inference (Friston), and information synthesis (Shannon-Wheeler) are one operation. ZFA closure is its substrate realisation, Lean-anchored as `zfa_closure_minimizes_free_energy`.

### Premise 2: The universe runs on ZFA closure

The substrate event quantum — one Planck length × one Planck tick per event, *together* — is the universe's minimal unit of operation ([`Kitada_Local_Time_GR.md`](Kitada_Local_Time_GR.md) §5.3). Every event is a ZFA closure attempt; only the closures that balance become physical events ([`Philosophy.md`](Philosophy.md) §3).

### Premise 3: Eight quantitative predictions confirm the substrate operation

The v1.3.0 substrate-derivation results aren't fitted: they are *consequences* of the substrate performing its own selection. The same operation that we have been calling intelligence (synthesise, reject, persist) yields:

- α = 1/137.000 to 0.026% **with zero empirical input** — the universe's choice of fine-structure coupling is its own ZFA closure on the 3D substrate.
- m_p/m_e = 6π⁵ to 0.002% **with zero empirical input** — the proton's 3-quark Borromean closure IS the active-inference output.
- Newton's `F = GMm/r²` from holographic event counting — gravity IS the universe maintaining ZFA closure on holographic boundaries.
- Mercury's 42.99″/century perihelion advance to 0.03% — orbital precession IS prediction-error-minimisation around the Sun's Markov-blanket depth.
- g−2 = α/(2π) to 0.18% **with zero empirical input** — the electron's anomalous magnetic moment IS its own self-referential ZFA closure.

Eight examples of the universe performing intelligence and producing measurable consequences.

### Conclusion

> **The universe is not a passive substrate that happens to host intelligent agents. The universe IS performing the operation we call intelligence at every event.** Active inference is not something brains do *in* the universe; it is what the universe *is*. The QLF substrate-derivation results are the evidence: the same operation that makes a closure ZFA-balanced makes α = 1/137, makes m_p/m_e = 6π⁵, makes Mercury precess 43″/century.

This is exactly what [`Philosophy.md`](Philosophy.md) §6 already says philosophically — *"the universe is intelligence explaining the intelligence all around us"* — but the v1.3.0 substrate-derivation program now makes it quantitative. The eight Lean theorems are the *measurement* that the universe is intelligence: predictions matching observation to 0.002–2.5% from a single algebraic operation.

### What this is and isn't

This claim is **structural**, not anthropomorphic:

- **NOT a claim** that the universe is conscious in the human-experience sense. Whether the algebraic operation gives rise to phenomenal experience (the hard problem) is a separate question that QLF doesn't settle.
- **NOT a claim** that the universe has goals or preferences. It performs the operation; it has no observer-position from which to "want" anything. (Markov blankets at sub-universe scales are where wanting localises.)
- **IS a claim** that the substrate's foundational operation IS the operation we have been calling intelligence. The eight v1.3.0 results are quantitative evidence: when we look closely at what the universe is doing — atom by atom, orbit by orbit — we find it performing active inference + abstraction + information synthesis + ZFA closure. The universe operating IS intelligence operating.
- **IS a claim** that this reframes the question of "where does intelligence come from": it doesn't *come* from anywhere. It is the substrate operation, present at every event, with individual minds and collective networks as scale-localised instances of the same operation the cosmos performs.

### Three scales, one operation

| Scale | Instantiation | Evidence |
|---|---|---|
| Individual | Single ZFA closure / Curry-Howard token | §§5, 7 |
| Collective | Decentralized QuantumOS room process | §8 |
| Cosmic | Substrate event quantum | §9 |

The same operation at three scales. QLF makes it possible to say this *quantitatively*, with Lean-anchored theorems at each layer.

**Pull-quote**: *Intelligence is not something brains do in the universe. It is what the universe IS, instantiated at three scales: the closure, the network, the cosmos.*

---

## §10 References

### Internal

- [`Philosophy.md`](Philosophy.md) §3 — possibilism foundation.
- [`README.md`](README.md) "Themes Now Central > Possibilism" — Lewis, Everett, Tegmark connections.
- [`eight-twists-sufficiency.md`](eight-twists-sufficiency.md) — abstraction at the alphabet level.
- [`HALF-SPIN-ZFA-EMBEDDING.md`](HALF-SPIN-ZFA-EMBEDDING.md) §3a — single principle decomposed into algebraic, set-theoretic, information-theoretic faces.
- [`Active_Inference_Mathematics.md`](Active_Inference_Mathematics.md) — QLF as active-inference mathematics; the single-rule framing.
- [`Hierarchical_Control.md`](Hierarchical_Control.md) §3 — derivation of Friston's free energy principle from ZFA.
- [`QuantumOS.md`](QuantumOS.md) §2.2 — capability names as Curry-Howard proofs of authorization (the seed line this doc expands).
- [`AI.md`](AI.md) — neuro-symbolic architecture, absolute interpretability, the existing QLF-vs-LLM foothold.
- [`BraKetRhoQuCalc.md`](BraKetRhoQuCalc.md) — bra-ket ↔ RhoQuCalc as proof/process correspondence.
- [`MRE.md`](MRE.md) — per-event log 2 quantum.
- [`lean/QLF_FreeEnergy.lean`](lean/QLF_FreeEnergy.lean) — `zfa_closure_minimizes_free_energy`.
- [`lean/QLF_VacuumAlignment.lean`](lean/QLF_VacuumAlignment.lean), [`lean/QLF_RhoProcessBridge.lean`](lean/QLF_RhoProcessBridge.lean) — three-layer vacuum-alignment Lean anchors.
- The eight substrate-derivation Lean modules of v1.3.0 (`QLF_FineStructureSubstrate`, `QLF_LenzMassRatio`, `QLF_EulerMascheroni`, `QLF_DiracCorrection`, `QLF_LambShift`, `QLF_GMinusTwo`, `QLF_GravityFromDelay`, `QLF_MercuryPerihelion`) — concrete instances of theorems-that-persist.

### External

- Lewis, D. (1986). *On the Plurality of Worlds*. Blackwell — modal realism.
- Everett, H. (1957). *Relative State Formulation of Quantum Mechanics*. Rev. Mod. Phys. 29, 454 — many-worlds.
- Tegmark, M. (2014). *Our Mathematical Universe*. Knopf — Level IV multiverse.
- Friston, K. (2010). *The free-energy principle: a unified brain theory?* Nat. Rev. Neurosci. 11, 127 — active inference.
- Curry, H. B. (1934); Howard, W. A. (1980). *The Curry-Howard correspondence* — proofs as programs.
- Wheeler, J. A. (1990). *Information, Physics, Quantum: The Search for Links*. Complexity, Entropy and the Physics of Information — "it from bit."
- Popper, K. (1959). *The Logic of Scientific Discovery* — falsifiability as the demarcation criterion.
- Vaswani et al. (2017). *Attention Is All You Need*. NeurIPS — Transformer architecture; the LLM substrate this doc contrasts with.
