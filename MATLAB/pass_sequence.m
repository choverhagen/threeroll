function pass_sequence(d0,de,N,Z,dnom,ff)

    global a_reference fillgrade_reference
    global kentry kgroove kexit  dnom

    %.................................
    % d0: entry diameter
    % de: final diameter
    % N:  number of passes
    % Z:  degression parameter
    % dnom: nominal roll diameter for all passes
    % ff: filling ratio for all passes
    %.................................

    % generate entry section
    kentry = initial_round(d0,100);
    A0 = area(kentry);
    
    % calculate cross section on exit
    Ae = pi/4*de^2;

    % the total elongation
    lambda_total = A0/Ae;

    % the mean elongation per pass
    lambda_m = lambda_total^(1/N);

    % design the degressive elongation distribution
    for i=1:N
        y = (N+1)/2-i;
        lambda = Z^y * lambda_m;
        
        if (i==1)
            A_(i) = A0/lambda;
        else
            A_(i) = A_(i-1)/lambda;
        end
    end

    angle = 0;

    initialpoly = polyshape(kentry.xy(:,1), kentry.xy(:,2));

    % calculate single-radius grooves based on area and filling criteria 
    for i=1:N

        if (angle>0)
            kentry = rotate_contour(kentry,angle);
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
        if (angle>0)
            kexit=rotate_contour(kexit,-angle);
        end

        exitpoly(i) = polyshape(kexit.xy(:,1), kexit.xy(:,2));

        % for the next pass
        kentry=kexit;

        % toggle the angle
        angle = abs(angle-180);

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