-- QLF FORMALIZATION: LEVEL 2 COMBINATORICS
-- Defining Multiplicity and the Search for Zero Free Action

import QLF_QuCalc

-- 1. THE COMPLETE PHASE ALPHABET
-- The 2 fundamental phase elements of the QLF (+ and - only; gauge is implicit).
def all_phase_elements : List TopoElement :=
  [TopoElement.phase LogicPhase.pos, TopoElement.phase LogicPhase.neg]

-- 2. THE COMBINATORIC EXPANSION AXIOM
-- A single open string branches into 2 new parallel strings.
def expand_string (s : TopoString) : List TopoString :=
  all_phase_elements.map (fun e => s ++ [e])

-- 3. THE GENERATIONAL MULTIPLICITY (list-based, complements Nat-indexed expand_generation)
-- Generation 1 = 2 states. Generation 2 = 4 states. Generation n = 2^n states.
def expand_generation_list (gen : List TopoString) : List TopoString :=
  gen.flatMap expand_string

-- 4. THE ZETA FILTER (Environmental Pressure)
-- Filters the generation, returning only strings that achieve Zero Free Action.
def find_stable_states_list (gen : List TopoString) : List TopoString :=
  gen.filter achieves_ZFA_bool

-- 5. RESONANCE DETECTION
-- A generation is resonant if any ZFA-achieving strings survive.
def is_resonant_generation_list (gen : List TopoString) : Bool :=
  !(find_stable_states_list gen).isEmpty
