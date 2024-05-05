function calc_single_groove_flat(d0,epsa,dnom,ff)
%
% three roll design model
%
% calculate data for one combination
%
%
%   d0:     Initial diameter in mm
%   epsa:   Relative Reduction
%   dnom:   Nominal Roll Diameter
%   ff:     Groove filling ratio

    global kentry dnom
    global a_reference fillgrade_reference
    global plotme
    global kexit kgroove
    global alfa0


    % generate the entry section
    kentry = initial_round(d0,100);
    A0 = area(kentry);
    
    % do not plot each iterated groove
    plotme=0;

    lambda=1/(1-epsa);
    A1 = A0/lambda;
 
    a_reference=A1;
    
    fillgrade_reference=ff;

    % guess initial conditions for the groove
    initial_ir = d0/2*0.8;
    x0=[initial_ir];
   
    % set the bounds of the parameters   

    LB = [d0*0.3];      % lower bound (the smallest possible groove)
    UB = [d0*0.5];      % upper bound (the largest possible groove)

    x = fminsearchbnd(@design_flat,x0,LB,UB);
    % x here contains the inner radius of the groove that has been found

    % find contact contour and bite angle
    [kcontact,a,alfa0] = kontakt(kentry,kgroove);

    plot_stich(kentry,kgroove,kexit,kcontact,2)
    ax= gca;
    ax.FontSize = 16;
    
end