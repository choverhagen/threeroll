function [px,py] = schnittg(g1,g2)
%
%  Find intersection point of two lines given by their analytical
%  representations
% 
% 
    d = g1(1)*g2(2)-g2(1)*g1(2);
    if (d ~= 0) 
        px = (g2(3)*g1(2) - g1(3)*g2(2)) / d;
        py = (g1(3)*g2(1) - g2(3)*g1(1)) / d;
    end
 end
