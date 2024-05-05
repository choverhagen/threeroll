function [x,y] = gerade_kon(p1,p2,schritt)
%
%   calculate x y coordinates of line segment
%
    abstand = dist_pkte(p1,p2);
    N = ceil(abstand/schritt);   

    sv = linspace(0,1,N);

    sv(1)=[];
    ux = p2.x - p1.x;
    uy = p2.y - p1.y;

    x = p1.x + sv.*ux;  
    y = p1.y + sv.*uy;
end

