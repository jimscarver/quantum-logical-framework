import Lake
open Lake DSL

package «quantum_logical_framework»

require mathlib from git
  "https://github.com/leanprover-community/mathlib4.git"

@[default_target]
lean_lib «QLF_Axioms» where
  srcDir := "lean"

@[default_target]
lean_lib «QLF_QuCalc» where
  srcDir := "lean"

@[default_target]
lean_lib «QLF_Riemann» where
  srcDir := "lean"

@[default_target]
lean_lib «QLF_Universality» where
  srcDir := "lean"

@[default_target]
lean_lib «QLF_Critical_Line» where
  srcDir := "lean"
