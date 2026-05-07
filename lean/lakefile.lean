name «quantum-logical-framework»
version "0.1.0"

require mathlib from git
  "https://github.com/leanprover-community/mathlib4.git"

@[default_target]
lean_lib «QLFAxioms» {
  srcDir := "lean"
}
lean_lib «QLFQuCalc» {
  srcDir := "lean"
}
lean_lib «QLFRiemann» {
  srcDir := "lean"
}
