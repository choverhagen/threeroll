function [konturneu] = screwdown(konturalt,dr1,dr2,dr3)
%!------------------------------------!
%
%   Apply screwdown change to a threeroll-groove
%

    konturneu=konturalt;

    % Apply screwdown to each roll separately
    konturneu.walze1xy(:,2)=konturalt.walze1xy(:,2)-dr1;

    konturneu.walze2xy(:,1)=konturalt.walze2xy(:,1)+dr2*cosd(30);
    konturneu.walze2xy(:,2)=konturalt.walze2xy(:,2)+dr2*sind(30);

    konturneu.walze3xy(:,1)=konturalt.walze3xy(:,1)-dr3*cosd(30);
    konturneu.walze3xy(:,2)=konturalt.walze3xy(:,2)+dr3*sind(30);

    % reassemble the groove

    walze1_x_neu = konturneu.walze1xy(:,1);
    walze1_y_neu = konturneu.walze1xy(:,2);

    walze2_x_neu = konturneu.walze2xy(:,1);
    walze2_y_neu = konturneu.walze2xy(:,2);

    walze3_x_neu = konturneu.walze3xy(:,1);
    walze3_y_neu = konturneu.walze3xy(:,2);


%--- resort points
%npunkte=size(walze1_x_neu,1) + size(walze2_x_neu,1) + size(walze3_x_neu,1);
    n2 = size(walze2_x_neu,1);
    p1x = (walze2_x_neu(n2) + walze3_x_neu(1))/2;
    p1y = (walze2_y_neu(n2) + walze3_y_neu(1))/2;
    hilf1=[p1x p1y; flip(walze2_x_neu) flip(walze2_y_neu)];
    hilf2=[flip(walze1_x_neu) flip(walze1_y_neu)];
    hilf3=[flip(walze3_x_neu) flip(walze3_y_neu); p1x p1y];
    konturneu.xy=[hilf1;hilf2;hilf3];

end

