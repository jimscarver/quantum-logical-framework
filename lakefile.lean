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
    `QLF_Spectral,
    `QLF_Riemann,
    `SpacetimeDynamics,
    `RhoQuCalc,
    `ZFAEventDynamics,
    `AgeOfUniverse,
    `ER_EPR_QLF,
    `PauliExclusion,
    `StringTheoryQLF,
    `MTheoryQLF
  ]
