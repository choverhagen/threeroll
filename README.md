# threeroll
Numerical calculation of roll pass designs for three-roll rolling mills
-----------------------------------------------------------------------

Presented at AISTech 2024, Columbus/OH, USA


by Christian Overhagen

University of Duisburg-Essen

Chair of Metallurgy and Metal Forming




A) The groove generation scripts
--------------------------------

The following functions generate the groove or initial section geometries and return a `kontur`structure. This data structure contains the xy coordinates of the polygonal contour, and also the descriptive parametric data of the groove or initial section.

`function [kontur] = groove_threeroll_flat(ir, r2, s)`

Generates a threeroll flat groove with the given parameters inner radius `ir`, transition radius `r2` and roll gap `s`.


`function [kontur] = groove_threeroll_singleradius(d, r1, r2, s)`

Generates a non-opened single radius groove with the given parameters inner radius `ir`, main radius `r1`, transition radius `r2` and roll gap `s`.


`function [kontur] = groove_threeroll_singleradius_opened(ir, r1, r2, alpha, s)`

Generates an opened single radius groove with the given parameters inner radius `ir`, main radius `r1`, transition radius `r2`, groove angle `alpha`, and roll gap `s`.



B) Calculation of single grooves
----------------------------------

These functions carry out numerical optimization to find a groove of one of the three types introduced above for a single pass with a nominal round entry section. The groove is optimized as to generate an exit section with a given cross sectional reduction `epsa = (A0-A1)/A0` at a nominal roll diameter of `dnom` and a filling ratio `ff`. `ff=1` means the groove will be fully filled. Setting `ff` to smaller values will result in lower groove filling as given by the user. 


`function calc_single_groove(d0,epsa,dnom,ff)`

Calculates a single radius non-opened groove for the entry diameter `d0`, the cross-sectional reduction `epsa`, the nominal roll diameter `dnom` and the filling ratio `ff`. The pass geometry with the entry, exit and groove sections are plotted in a figure window.


`function calc_single_groove_opened(d0,epsa,dnom,ff,ecc)`

Calculates a single radius opened groove for the entry diameter `d0`, the cross-sectionsl reduction `epsa`, the nominal roll diameter `dnom`, the filling ratio `ff` and the eccentricity ratio `ecc = R1/IR`. 

`function calc_single_groove_flat(d0,epsa,dnom)`

Calculates a flat groove for the entry diameter `d0`, the cross-sectional reduction `epsa` and the nominal roll diameter `dnom`. Note that not both filling ratio AND area reduction can be controlled as this simple groove type does not provide sufficient degrees of freedom. The function should be easy to modify to accept the filling ratio instead of the redution ratio.


C) Calculation of groove sequences
----------------------------------

Examplarily, the groove sequence design algorithm is included for non-opened single-radius grooves.

`function pass_sequence(d0,de,N,Z)`
Calculates a pass sequence with non-opened single radius grooves from the initial diameter `d0`, final diameter `de` , number of passes `N` and degression factor `Z`



D) Supplementary routines
-------------------------

The remaining routines are supplements for the geometry calculation and the numerical treatment.
The code uses fminsearchbnd to minimize the groove filling error while the geometrical groove parameters remain constrained to given boundaries.

It might be interesting to replace the included spreading model, based in Roux's spread equation by different approaches. This can be done by replacing the function:

`function [b1] = spread_3rp(h0,h1,b0,dw)`

This function returns the final width `b1` of a three-roll pass at given heights `h0`, `h1`, initial width `b0` and nominal roll diameter `dw`. Replace the contents of this function to include your own spread model.
