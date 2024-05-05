function [dist] = cp_abst(cp)
%!------------------------------------!
% calculate cutpoint distance

dist(1) = sqrt((cp(1,1) - cp(2,1))^2 + (cp(1,2) - cp(2,2))^2);
dist(2) = sqrt((cp(3,1) - cp(4,1))^2 + (cp(3,2) - cp(4,2))^2);
dist(3) = sqrt((cp(5,1) - cp(6,1))^2 + (cp(5,2) - cp(6,2))^2);

end

