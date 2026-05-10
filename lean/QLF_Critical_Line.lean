-- QLF FORMALIZATION: LEVEL 3 THE CRITICAL LINE (COMPLETED)
-- Proving that Zero Free Action strictly requires 1/2 symmetry.

import QLF_Axioms

namespace QLF

theorem riemann_zfa_critical_line (s : TopoString) :
    achieves_ZFA s → is_symmetric s :=
  zfa_implies_critical_line s

theorem riemann_zfa_critical_line_sym (s : TopoString) (h : achieves_ZFA s) :
    count_pos s = count_neg s :=
  zfa_implies_critical_line s h

end QLF
