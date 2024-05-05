function calc_single_groove(d0,epsa,dnom,ff)
%
% three roll design model
%
%  design a single-radius groove for a round entry
%  at a given pass reduction and filling ratio
%
%   d0:     Initial diameter in mm
%   epsa:   Relative Reduction   epsa=(A0-A1)/A0
%   dnom:   Nominal Roll Diameter
%   ff:     Groove filling ratio
%
%   by Christian Overhagen <christian.overhagen@uni-due.de>
%

    global kentry dnom
    global a_reference fillgrade_reference
    global plotme
    %global the_real_a  the_real_fg
    global kexit kgroove
    global alfa0

    % generate the entry section
    kentry = initial_round(d0,100);
    A0 = area(kentry);
    
    plotme=0;

    lambda=1/(1-epsa);
    A1 = A0/lambda;
 
    a_reference=A1;
    fillgrade_reference=ff;

    % guess initial conditions for the groove
    initial_ir = d0/2*0.8;
    initial_r1 = initial_ir*5;
    initial_ecc = initial_r1/initial_ir;
    x0=[initial_ir,initial_ecc];
   
    % set the bounds of the parameters    
    LB = [-inf 1];      % lower bound
    UB = [d0/2 -inf];   % upper bound
    x = fminsearchbnd(@design_singleradius,x0,LB,UB);    
   
    % x(1): inner radius, x(2): eccentricity

    % find contact contour and bite angle
    [kcontact,a,alfa0] = kontakt(kentry,kgroove);

    % plot the resulting contours
    plot_stich(kentry,kgroove,kexit,kcontact,2)
    ax= gca;
    ax.FontSize = 16;
    
end