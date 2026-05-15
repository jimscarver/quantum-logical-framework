-- SpacetimeDynamics.lean
-- Formalizing the emergence of Time and Gravity from QLF ZFA Latency

namespace QLF

/-- Represents a localized context within the QuCalc generative tree. -/
structure EventContext where
  w_zfa : Nat
  h_realizable : w_zfa > 0

/-- TimeLatency represents the delay (1 / w_zfa). 
    We define it as a dedicated structure to completely bypass Mathlib's Rat macro issues. -/
structure TimeLatency where
  denominator : Nat

/-- The fundamental time delay required to synthesize the logic bit. -/
def time_latency (e : EventContext) : TimeLatency :=
  ⟨e.w_zfa⟩

/-- Since TimeLatency represents an inverse (1/x), t1 < t2 if and only if t1.denominator > t2.denominator. -/
def TimeLatency.lt (t1 t2 : TimeLatency) : Prop :=
  t1.denominator > t2.denominator

-- Register our custom Less-Than logic so we can use standard < and > symbols
instance : LT TimeLatency := ⟨TimeLatency.lt⟩

/-- Time Dilation Theorem: 
    If a region is heavily constrained (lower W_ZFA) due to nearby Markov blankets,
    the logical latency is mathematically strictly greater. -/
theorem time_dilation_in_constrained_space (e1 e2 : EventContext) 
    (h_constraint : e1.w_zfa < e2.w_zfa) : 
    time_latency e1 > time_latency e2 := by
  -- By our inverted TimeLatency definition, time_latency e1 > time_latency e2 
  -- resolves directly to e2.w_zfa > e1.w_zfa, which is exactly h_constraint.
  exact h_constraint

/-- The Possibilist Gradient (Gravity):
    Particles probabilistically drift toward contexts that require fewer 
    local cycles (lower w_zfa) to resolve their histories. -/
def is_gravitationally_attractive (source target : EventContext) : Prop :=
  target.w_zfa < source.w_zfa

/-- A shift in gravitational gradient strictly implies a shift in time dilation. -/
theorem gravity_is_time_dilation (source target : EventContext) 
    (h_gravity : is_gravitationally_attractive source target) :
    time_latency target > time_latency source := by
  -- This flows directly from the core time dilation relation.
  exact h_gravity

end QLF
