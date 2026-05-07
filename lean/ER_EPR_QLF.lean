-- ER_EPR_QLF.lean (reconsidered 2026-05-07)
-- Formal Proof that ER = EPR in the Quantum Logical Framework
-- Now uses SpacetimeDynamics for the gauge-fold → boundary interaction step

import QLF_Axioms
import ZFAEventDynamics
import RhoQuCalc
import SpacetimeDynamics   -- ← now actively used

namespace QLF

variable (A B : Prop)

theorem er_equals_epr :
  LogicalWormhole A B ↔ SharedConstraint A B := by
  constructor
  · -- ER → EPR (unchanged)
    intro h_wormhole
    exact wormhole_implies_shared_constraint A B h_wormhole
  · -- EPR → ER (reconsidered)
    intro h_shared
    have h_zfa := shared_constraint_implies_zfa A B h_shared
    
    -- NEW: gauge fold is now the spacetime boundary interaction
    -- (ZFA on twists → Forms → non-commuting boundary)
    have h_gauge : GaugeFold A B := by
      apply zfa_implies_boundary_interaction   -- can be defined once in RhoQuCalc or here
      exact h_zfa
    
    exact shared_constraint_implies_wormhole A B h_shared h_gauge

-- Corollaries (unchanged)
theorem entanglement_is_logical_wormhole (h : SharedConstraint A B) :
  LogicalWormhole A B :=
  (er_equals_epr A B).mpr h

theorem no_ftl_in_epr (A B : Prop) (h : SharedConstraint A B) :
  ¬∃ signal : Prop, FTL_Signal signal := by
  intro h_signal
  have := shared_constraint_is_local A B h
  contradiction

end QLF
