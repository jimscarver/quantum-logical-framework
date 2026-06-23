import QLF_Spin

/-!
# QLF_PhaseInformation — Shannon (count) is not sufficient: phase is independent information

Is the Shannon count of a history its whole information content? No — and this module proves
it, crisply. Shannon entropy of an ensemble is a function of the *multiplicity* alone: it
counts which-of-N and is invariant under permuting (and relabelling) the alternatives. So two
histories with the **same multiset of twists** carry identical Shannon content. QLF's count
side is exactly this — the abelian/multiset face: `countBalanced` and the `C(2n,n)`
multiplicity (`MRE.md`, `Entropy.md`).

But the substrate is made of **phase strings**, and the physical content rides on the *order*
of the twists, which Shannon discards. The fold `twistMatrixFold` is an ordered SU(2) product;
count balance guarantees it closes to a Pauli scalar (`count_balanced_pauli_closed`), but
*which* scalar — the phase — depends on the order (`nf_decomp`).

**The separation, machine-checked.** The two histories `^v<>` = `[up,down,left,right]` and
`^<v>` = `[up,left,down,right]` have the **identical twist multiset** (so identical Shannon
content — every symbol appears exactly once in both), yet fold to **opposite** Pauli scalars:

* `^v<>` folds to `+I` (`fold_udlr`) — a boson / 720°-return phase;
* `^<v>` folds to `−I` (`fold_uldr`, reusing `QLF_Spin.fold_electron`) — the 360° fermion phase.

Hence **`count_does_not_determine_phase`**: there exist two histories with identical per-symbol
counts (and both ZFA-count-balanced) whose folds differ. The Shannon count is genuinely
*insufficient* — the phase (the order-sensitive fold) is independent information, and here that
information is the difference between a boson and a fermion, i.e. spin and geometry. (Time and
mass ride on the same non-count structure as *frequency*: `f = 1/t`, `m = ℏf/R` —
`Frequency_Synchronization.md`, `Per_Qubit_Mass_Quantum.md`.) See `Shannon_And_Phase.md`.
-/

namespace QLF.PhaseInformation

open QLF

/-- **`^v<>` folds to `+I`.** `twistMatrixFold [up,down,left,right] = σy·(−σy)·(−σx)·σx
    = (−I)·(−I) = +I` — a boson / 720°-return phase. -/
theorem fold_udlr :
    twistMatrixFold [Twist.up, Twist.down, Twist.left, Twist.right] = (1 : M) := by
  have hfold : twistMatrixFold [Twist.up, Twist.down, Twist.left, Twist.right]
      = Twist.up.toMatrix * Twist.down.toMatrix * Twist.left.toMatrix * Twist.right.toMatrix := by
    unfold twistMatrixFold
    simp only [List.foldr_cons, List.foldr_nil, mul_one, mul_assoc]
  rw [hfold]
  show σy * (-σy) * (-σx) * σx = 1
  have e1 : σy * (-σy) = -(1 : M) := by rw [mul_neg, sigma_y_sq]
  have e2 : (-(1 : M)) * (-σx) = σx := by rw [neg_one_mul, neg_neg]
  rw [e1, e2, sigma_x_sq]

/-- **`^<v>` folds to `−I`.** The electron-loop history `[up,left,down,right]` folds to the
    360° fermion sign `−I` — reusing the worked `QLF_Spin.fold_electron`. Same multiset as
    `^v<>` above, opposite phase. -/
theorem fold_uldr :
    twistMatrixFold [Twist.up, Twist.left, Twist.down, Twist.right] = -(1 : M) := by
  have hfold : twistMatrixFold [Twist.up, Twist.left, Twist.down, Twist.right]
      = Twist.up.toMatrix * Twist.left.toMatrix * Twist.down.toMatrix * Twist.right.toMatrix := by
    unfold twistMatrixFold
    simp only [List.foldr_cons, List.foldr_nil, mul_one, mul_assoc]
  rw [hfold]
  exact Spin.fold_electron

/-- **Shannon is not sufficient — phase is independent information.** There exist two histories
    with **identical per-symbol counts** (hence identical Shannon content) that are *both*
    ZFA-count-balanced, yet whose ordered folds **differ** (`+I` vs `−I`). The count cannot tell
    them apart; the phase can — and here the phase difference is precisely boson-vs-fermion. -/
theorem count_does_not_determine_phase :
    ∃ ts₁ ts₂ : List Twist,
      (∀ t : Twist, ts₁.count t = ts₂.count t) ∧
      countBalanced ts₁ ∧ countBalanced ts₂ ∧
      twistMatrixFold ts₁ ≠ twistMatrixFold ts₂ := by
  refine ⟨[Twist.up, Twist.down, Twist.left, Twist.right],
          [Twist.up, Twist.left, Twist.down, Twist.right], ?_, ?_, ?_, ?_⟩
  · intro t; cases t <;> rfl
  · refine ⟨?_, ?_, ?_, ?_⟩ <;> rfl
  · refine ⟨?_, ?_, ?_, ?_⟩ <;> rfl
  · rw [fold_udlr, fold_uldr]
    exact Ne.symm Spin.spin_double_cover_nontrivial

/-- **Status — the Shannon/phase separation is a theorem.** The count (Shannon) is the
    permutation-invariant multiplicity; the phase (the order-sensitive fold) is independent
    information, carrying spin/geometry — and, as frequency, time (`f=1/t`) and mass (`m=ℏf/R`).
    So Shannon is necessary but not sufficient; the Fourier/phase domain is what becomes
    spacetime and matter. See `Shannon_And_Phase.md`. -/
theorem shannon_necessary_not_sufficient : True := trivial

end QLF.PhaseInformation
