function [a] = area(kontur)
%!------------------------------------!
% calculate area of contour

n=kontur.anz_punkte;
a=0;
for i=1:n-1
    a=a+(kontur.xy(i,1)*kontur.xy(i+1,2)-kontur.xy(i,2)*kontur.xy(i+1,1));
end
a=a+(kontur.xy(n,1)*kontur.xy(1,2)-kontur.xy(n,2)*kontur.xy(1,1));
a=abs(a)/2;
end

