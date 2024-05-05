function [u] = circumference(kontur)
%!------------------------------------!
%
% calculate circumference of contour

n=kontur.anz_punkte;
u=0;
for i=1:n-1
    % distance to next point
    abst = sqrt((kontur.xy(i,1) - kontur.xy(i+1,1))^2 + (kontur.xy(i,2) - kontur.xy(i+1,2))^2);
    u=u+abst;
end
abst = sqrt((kontur.xy(n,1) - kontur.xy(1,1))^2 + (kontur.xy(n,2) - kontur.xy(1,2))^2);
u=u+abst;
end

