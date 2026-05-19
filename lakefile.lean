import Lake
open Lake DSL

package «QuantumLogicalFramework»

require mathlib from git
  "https://github.com/leanprover-community/mathlib4.git"

@[default_target]
lean_lib QLF where
  srcDir := "lean"
  roots := #[
    `QLF_Axioms,
    `QLF_Combinatorics,
    `QLF_QuCalc,
    `QLF_Universality,
    `QLF_Critical_Line,
    `QLF_Riemann,
    `SpacetimeDynamics,
    `RhoQuCalc,
    `ZFAEventDynamics,
    `PauliExclusion,
    `AgeOfUniverse,
    `ER_EPR_QLF,
    `StringTheoryQLF,
    `MTheoryQLF
  ]
