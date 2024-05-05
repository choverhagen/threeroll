function pass_sequence(d0,de,N,Z)

    global a_reference fillgrade_reference
    global kentry kgroove kexit  dnom

    %.................................
    % d0: entry diameter
    % de: final diameter
    % N:  number of passes
    % Z:  degression parameter
    %.................................

    ff=0.95;
    dnom=400;

    % generate entry section
    kentry = anstich_rund(d0,100);
    A0 = flaecheninhalt(kentry);
    
    % calculate cross
    Ae = pi/4*de^2;

    lambda_total = A0/Ae;

    lambda_m = lambda_total^(1/N);

    for i=1:N
        y = (N+1)/2-i;
        lambda = Z^y * lambda_m;
        
        if (i==1)
            A_(i) = A0/lambda;
        else
            A_(i) = A_(i-1)/lambda;
        end
    end

    winkel = 0;

    initialpoly = polyshape(kentry.xy(:,1), kentry.xy(:,2));

    % calculate single-radius grooves based on area and filling criteria 
    for i=1:N

        if (winkel>0)
            kentry = drehen(kentry,winkel);
        end

        a_reference=A_(i);
        fillgrade_reference=ff;

        if (i==1)
            initial_ir = d0/2*0.8;
            old_ir = d0/2;
        else
            old_ir = initial_ir;
            initial_ir = initial_ir * 0.9;
        end

        initial_r1 = initial_ir*5;
        initial_ecc = initial_r1/initial_ir;
        x0=[initial_ir,initial_ecc];
       
        % set the bounds     
        LB = [old_ir*0.7 1];
        UB = [old_ir*1.1 -inf];

        x = fminsearchbnd(@design_singleradius,x0,LB,UB);
        clc

        % plot the pass graphical output
        plot_stich(kentry,kgroove,kexit,kexit,100+i);

        % save final groove
        kgrooves(i) = kgroove;
   
                 

        % rotate back
        if (winkel>0)
            kexit=drehen(kexit,-winkel);
        end

        exitpoly(i) = polyshape(kexit.xy(:,1), kexit.xy(:,2));

        % for the next pass
        kentry=kexit;

        % toggle the angle
        winkel = abs(winkel-180);

    end

    figure(200)
    plot(initialpoly)
    hold on

    for i=1:N
        plot(exitpoly(i))
    end
    
    for i=1:N
     ecc_(i) = kgrooves(i).radius1 / kgrooves(i).innenradius;
    end

    axis equal

    figure(300)
    plot(ecc_)
     

end