function [pout] = rotate(p,grad)

%
% clockwise rotation of point p by angle grad

    dm=[cosd(-grad) -sind(-grad); sind(-grad) cosd(-grad)];

    pout = dm * p';
end