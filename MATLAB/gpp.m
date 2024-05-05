function [g] = gpp(p1x,p1y,p2x,p2y)
%
% define analytical form of line between two points

    g(1)=p2y-p1y;
    g(2)=p1x-p2x;
    g(3)=-g(1)*p1x-g(2)*p1y;

end
