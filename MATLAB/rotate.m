function [pout] = rotate(p,grad)

%
% clockwise rotation of point p by angle grad

% Drehmatrix
dm=[cosd(-grad) -sind(-grad); sind(-grad) cosd(-grad)];

% Punkte drehen

pout = dm * p';
end