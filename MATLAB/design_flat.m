function [residual] = design_flat(x)

    % entry contour as global variable
    global kentry
    global a_reference fillgrade_reference
    global plotme
    global dnom
    global the_real_a  the_real_fg
    global kexit kgroove
    global alfa0

    ir = x(1);
    s = ir/10;       % standard roll gap to lower the amount of input data
    r2 = s;
    
    % generate groove from given parameters
    kgroove = groove_threeroll_flat(ir,r2,s);
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

    residual = abs(fehlera);

    the_real_a = A1;
    the_real_fg = fg;

    fprintf('IR = %8.3f mm     fillf = %8.6f    epsa = %8.6f      resid = %8.3f \n',[ir,fg,realepsa,residual]);

    % if plotme is set, output groove after each iteration (reduces
    % performance!)
    if (plotme)
          plot_stich(kentry,kgroove,kexit,kgroove,1);
    end


end