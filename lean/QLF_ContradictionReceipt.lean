import QLF_Axioms

/-!
# QLF_ContradictionReceipt — a contradiction receives no receipt (Grade-1 item 4)

Machine-checked backing for two prose claims elsewhere in the repo:

* the **anti-dialetheist thesis** ([`Philosophy.md`](../Philosophy.md) §9): contradiction is
  *never realized*; only its cancellation is. QLF is structurally anti-dialetheist, and here that
  is a theorem, not an argument.
* the **dissolution of the Bar-Hillel–Carnap paradox** ([`Related_Frameworks.md`](../Related_Frameworks.md)
  Part II §5): the classical paradox is that a contradiction carries *maximal* semantic information.
  On the substrate, realized information is **receipt-counted** — and a contradiction carries **zero**
  realized information, because it never closes.

A **contradiction** is an unbalanced ledger (`count_pos ≠ count_neg`: a distinction and its negation
both asserted without cancelling). The core is a one-line contrapositive of the existing
`zfa_implies_critical_line` (`achieves_ZFA ⟹ is_symmetric`, i.e. balanced): an unbalanced ledger
admits no ZFA closure, hence no receipt. Reuses `QLF_Axioms`; no new axioms.
-/

namespace QLF.ContradictionReceipt

/-- A **contradiction** is an unbalanced ledger: its positive and negative distinctions do not
    match (`count_pos ≠ count_neg`) — a claim and its negation both asserted without cancelling. -/
def IsContradiction (s : TopoString) : Prop := ¬ is_symmetric s

/-- **A contradiction receives no receipt.** An unbalanced ledger admits no ZFA closure — the
    contrapositive of `zfa_implies_critical_line` (closure ⟹ balanced). So a contradiction carries
    **zero** realized information (no receipt), dissolving the Bar-Hillel–Carnap paradox and proving
    the anti-dialetheist point: contradiction is never realized. -/
theorem contradiction_no_receipt (s : TopoString) (h : IsContradiction s) :
    ¬ achieves_ZFA s :=
  fun hz => h (zfa_implies_critical_line s hz)

/-- Equivalently: **every ZFA receipt is balanced** — no realized closure is a contradiction. -/
theorem receipt_is_balanced (s : TopoString) (h : achieves_ZFA s) : ¬ IsContradiction s :=
  fun hc => hc (zfa_implies_critical_line s h)

/-- Summary: realized information is receipt-counted; a contradiction (unbalanced ledger) is
    receiptless (`contradiction_no_receipt`), and every receipt is balanced (`receipt_is_balanced`).
    Contradiction lives only in the possibilist layer, never in the actual. -/
theorem contradiction_receipt_summary : True := trivial

end QLF.ContradictionReceipt
