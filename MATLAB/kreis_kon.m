function [x,y] = kreis_kon(m,p1,p2,r,schritt)

% x y coordinates of arc segment

 tan1=[p1.x p1.y];
 tan2=[p2.x p2.y];

[k_] = kreisneu(m.x,m.y,r,tan1,tan2,schritt);

x=k_(:,1)';
y=k_(:,2)';

end

