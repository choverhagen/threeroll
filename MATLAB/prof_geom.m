function [h,b] = prof_geom(k1,k2)
%!------------------------------------!
%
% get height and width of a three-roll section k1 with help of the roll
% contour k2
%

cp = cutpoints(k1,k2);

xy=[cp(3,1:2);...
    k1.xy(cp(3,3)+1:cp(4,3),1:2);...
    cp(4,1:2)];

xv=xy(:,1);
yv=xy(:,2);
p=polyfit(xv,yv,5);
h=abs(polyval(p,0));


n1=k1.anz_punkte;

xy=[cp(6,1:2);...
    k1.xy(cp(6,3)+1:n1,1:2);...
    k1.xy(1:cp(1,3),1:2);...
    cp(3,1:2)];

xv=xy(:,1);
yv=xy(:,2);
p=polyfit(xv,yv,5);
b=abs(polyval(p,0));

end

