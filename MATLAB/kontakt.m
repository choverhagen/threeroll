function [k4,a,alfa0] = kontakt(k1,k2)

%
%  Find contact contour
%

global dnom

cp=cutpoints(k1,k2);

% Height reduction vector

x3=cp(3,1);
x4=cp(4,1);
xneu=linspace(x3,x4,20);

xalt_profil = k1.xy(cp(3,3):cp(4,3)+1,1);
xalt_kal    = k2.xy(cp(3,4):cp(4,4)+1,1);

yalt_profil = k1.xy(cp(3,3):cp(4,3)+1,2);   
yalt_kal    = k2.xy(cp(3,4):cp(4,4)+1,2);   

yneu_profil=interp1(xalt_profil,yalt_profil,xneu);
yneu_kal = interp1(xalt_kal,yalt_kal,xneu);

% calculate local roll diameter
d = dnom+2*yneu_kal;

% calculate local height reduction
dh = abs(yneu_kal-yneu_profil);

% calculate local bite angle and maximum bite angle
alfa0v = acos(1-2*dh./d) *180/pi;
alfa0 = max(alfa0v);

a=max(dh);
k4=screwdown(k2,a,a,a);


end