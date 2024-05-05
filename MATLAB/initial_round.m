function [kontur] = anstich_rund(d,n)
%!------------------------------------!
%
% Generate circle as initial section

t=linspace(2*pi,0,n);
r=d/2;

xv=r.*cos(t);
yv=r.*sin(t);

% rotate points by 90 degrees
xy=[xv; yv];
xyneu=([0 -1; 1 0]*xy)';


kontur.anz_punkte=n;
kontur.typus = 1;
kontur.durchmesser=d;
kontur.breite=0;
kontur.hoehe=0;
kontur.radius1=0;
kontur.radius2=0;
kontur.radius3=0;
kontur.radius4=0;
kontur.gamma1=0;
kontur.gamma2=0;
kontur.spalt=0;
kontur.alpha=0;
kontur.bombierung=0;
kontur.slweite=0;
kontur.innenradius=0;
kontur.winkel=0;
kontur.xy=[xyneu];

end

