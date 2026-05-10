import Lake
open Lake DSL

package QuantumLogicalFramework where

@[default_target]
lean_lib QLF where
  srcDir := "lean"
  roots := #[
    `QLF_Axioms,
    `QLF_QuCalc,
    `QLF_Universality,
    `QLF_Critical_Line,
    `QLF_Riemann,
    `SpacetimeDynamics,
    `RhoQuCalc
  ]
