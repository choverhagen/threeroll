# threeroll
Numerical calculation of roll pass designs for three-roll rolling mills
-----------------------------------------------------------------------

Presented at AISTech 2024, Columbus/OH, USA
by Christian Overhagen
University of Duisburg-Essen
Chair of Metallurgy and Metal Forming



The most important scripts are:

A) The groove generation scripts
--------------------------------
function [kontur] = groove_threeroll_flat(ir, r2, s)
---
This function generates an xy-contour of the threeroll flat groove with the given parameters inner radius ir, transition radius r2 and roll gap s

function [kontur] = groove_threeroll_singleradius(d, r1, r2, s)
---
This function generates an xy-contour of the threeroll non-opened single radius groove with the given parameters inner radius ir, transition radius r2 and roll gap s

function [kontur] = groove_threeroll_singleradius(d, r1, r2, s)
---
This function generates an xy-contour of the threeroll non-opened single radius groove with the given parameters inner diameter d, main radius r1, transition radius r2 and roll gap s

function [kontur] = groove_threeroll_singleradius_opened(ir, r1, r2, alpha, s)
---
This function generates an xy-contour of the threeroll opened single radius groove with the given parameters inner radius ir, main radius r1, transition radius r2, groove angle alpha, and roll gap s


B) Calculation of single grooves
----------------------------------

function calc_single_groove(d0,epsa,dnom,ff)
---
Calculates a single radius non-opened groove for the entry diameter d0, the cross-sectionsl reduction epsa, the nominal roll diameter dnom and the filling ratio ff

function calc_single_groove_opened(d0,epsa,dnom,ff,ecc)
---
Calculates a single radius opened groove for the entry diameter d0, the cross-sectionsl reduction epsa, the nominal roll diameter dnom, the filling ratio ff and the eccentricity ratio ecc

function calc_single_groove_flat(d0,epsa,dnom)
---
Calculates a flat groove for the entry diameter d0, the cross-sectionsl reduction epsa and the nominal roll diameter dnom. Note that not both filling ratio AND area redution can be controlled as this simple groove type does not provide sufficient degrees of freedom.

C) Calculation of groove sequences
----------------------------------
function pass_sequence(d0,de,N,Z)
Calculates a pass sequence with non-opened single radius grooves from the initial diameter d0, final diameter de number of passes N and degression factor Z


D) Supplementary routines
-------------------------

The remaining routines are supplements for the geomtry calculation and the numerical treatment.
The code uses fminsearchbnd to minimize the groove filling error while the geometrical groove parameters remain constrained to given boundaries.

Spreading Behaviour:
function [b1] = spread_3rp(h0,h1,b0,dw)

This function returns the final width b1 of a three-roll at given heights h0, h1, initial width and nominal roll diameter. Replace the contents of this function to include your own spread calculation.

