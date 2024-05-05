function [residual] = design_singleradius_opened(x)

    % entry contour as global variable
    global kentry
    global a_reference fillgrade_reference
    global plotme
    global dnom
    global the_real_a  the_real_fg
    global kexit kgroove
    global ecc_groove
    %global alpha_groove

    alpha = x(2);
    ir = x(1);

    r1 = ecc_groove*ir;    

    s = ir/10;
    r2 = s;
    
    % generate groove from given parameters
    kgroove = groove_threeroll_singleradius_opened(ir,r1,r2,alpha,s);
    wof = kgroove.wof;

    % area of the entry section
    A0 = area(kentry);

    kentry_original = kentry;
    kgroove_original = kgroove;

    % calculate lendl data
    [A0L,A1L,h0L,h1L,ddarb] = lendl_3rp(kentry,kgroove);
    darb = dnom - ddarb;

    % Calculate spread
    [h0,b0] = prof_geom(kentry,kgroove);
    b1 = spread_3rp(h0L,h1L,b0,darb);
    db=b1-b0;

    kentry = kentry_original;
    kgroove = kgroove_original;

    % Calculate exit section
    kexit=auskont(kentry,kgroove,db);
    A1 = area(kexit);   

    % calculate filling ratio
    fg = b1/wof;
    
    realepsa = (A0-A1)/A0;

    fehlera = (A1-a_reference)/a_reference;
    fehler_fg = (fg-fillgrade_reference)/fillgrade_reference;

    residual = sqrt(fehlera^2 + fehler_fg^2);

    the_real_a = A1;
    the_real_fg = fg;

    fprintf('IR = %8.3f mm     R1 = %8.3f mm      alpha = %8.3f deg    fillf = %8.6f    epsa = %8.6f      resid = %8.3f \n',[ir,r1,alpha,fg,realepsa,residual]);

    if (plotme)
          plot_stich(kentry,kgroove,kexit,kgroove,1);
    end

end