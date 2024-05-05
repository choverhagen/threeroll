function calc_single_groove_opened(d0,epsa,dnom,ff,ecc)
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
    global the_real_a  the_real_fg
    global kexit kgroove
    global alfa0
    global ecc_groove
    %global alpha_groove

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
    initial_r1 = initial_ir*5;
    %initial_ecc = initial_r1/initial_ir;
    initial_alpha = 60;

    % set the initial conditions for the iteration
    x0=[initial_ir,initial_alpha];
   
    % set the bounds of the parameters    
    LB = [0 10];      % lower bound
    UB = [d0/2 90];   % upper bound

    % do the iteration
    x = fminsearchbnd(@design_singleradius_opened,x0,LB,UB);

    % find contact contour and bite angle
    [kcontact,a,alfa0] = kontakt(kentry,kgroove);

    plot_stich(kentry,kgroove,kexit,kcontact,2)
    ax= gca;
    ax.FontSize = 16
    
end