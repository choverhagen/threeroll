function [kontur] = groove_threeroll_flat(ir, r2, s)
%.
%. construct the threeroll flat groove
%.
%. ir: inner radius
%. r2: transition radius roll barrel-roll gap
%. s: roll gap
%.
%. by Christian Overhagen <christian.overhagen@uni-due.de>

% max. number of points (for stepwidth calculation)
max_punkte=500;

% assign some points 
pkt(1).x = -(1.73205*ir+1.41506*s);
pkt(1).y = -(ir+0.81699*s);

pkt(2).x=-(1.73205*ir+1.16506*s);   
pkt(2).y=-(ir+1.25*s);
   
pkt(3).x=-(1.73205*ir-s);
pkt(3).y=-ir;

pkt(4).x=-pkt(3).x;
pkt(4).y=pkt(3).y;

pkt(5).x=-pkt(2).x;
pkt(5).y=pkt(2).y;

pkt(6).x=-pkt(1).x;
pkt(6).y=pkt(1).y;

% create straight lines from points
g1 = gpp(pkt(2).x,pkt(2).y,pkt(3).x,pkt(3).y);
g2 = gpp(pkt(3).x,pkt(3).y,pkt(4).x,pkt(4).y);
g3 = gpp(pkt(4).x,pkt(4).y,pkt(5).x,pkt(5).y);


%. construct center and tangent points of the r2 radius
[pkt(8),pkt(9),pkt(10)]=spgkg(g1,g2,r2,'a',0);
[pkt(11),pkt(12),pkt(13)]=spgkg(g2,g3,r2,'a',0);

% Precalculate the circumference of the contour
dist = dist_pkte(pkt(1),pkt(2));
umfang=dist;
dist = dist_pkte(pkt(2),pkt(9));
umfang=umfang+dist;
dist = dist_pkte(pkt(9),pkt(10));
umfang=umfang+dist+0.5*pi*r2;
dist = dist_pkte(pkt(10),pkt(12));
umfang=umfang+dist;
dist = dist_pkte(pkt(12),pkt(13));
umfang=umfang+dist+0.5*pi*r2;
dist = dist_pkte(pkt(13),pkt(5));
umfang=umfang+dist;
dist = dist_pkte(pkt(5),pkt(6));
umfang=umfang+dist;
umfang=4.5*umfang;

%calcualte stepwidth
schritt_l = umfang / (max_punkte*0.8);

kontur.xy=[];
%. assemble contour
kontur.anz_punkte = 1;
kontur.xy(1,1) = pkt(2).x;
kontur.xy(1,2) = pkt(2).y;

pkt(7).x=0;
pkt(7).y=0;

%. draw the geometric elements into the contour x and y vectors (lines and arcs)
[x,y] = gerade_kon(pkt(2),pkt(9),schritt_l);
kontur.xy = [kontur.xy; [x' y']];

[x,y] = kreis_kon(pkt(8),pkt(9),pkt(10),r2,schritt_l);
kontur.xy = [kontur.xy; [x' y']];

[x,y] = gerade_kon(pkt(10),pkt(12),schritt_l);
kontur.xy = [kontur.xy; [x' y']];

[x,y] = kreis_kon(pkt(11),pkt(12),pkt(13),r2,schritt_l);
kontur.xy = [kontur.xy; [x' y']];

[x,y] = gerade_kon(pkt(13),pkt(5),schritt_l);
kontur.xy = [kontur.xy; [x' y']];

kontur.anz_punkte = size(kontur.xy,1);

kontur.anz_punkte = kontur.anz_punkte + 1;
kontur.xy(kontur.anz_punkte,1) = pkt(5).x;
kontur.xy(kontur.anz_punkte,2) = pkt(5).y;

% bottom roll contour is finished here

i1 = kontur.anz_punkte;    % end of the bottom roll

walze1_x_neu = kontur.xy(1:kontur.anz_punkte,1);
walze1_y_neu = kontur.xy(1:kontur.anz_punkte,2);

% repeat the points for the other two rolls by suitable rotation
dummy2 = kontur.anz_punkte;
for i=1:kontur.anz_punkte
    h.x = kontur.xy(i,1);
    h.y = kontur.xy(i,2);
    hv=rotate([h.x h.y],-120);
    h.x = hv(1);
    h.y = hv(2);
    kontur.anz_punkte = kontur.anz_punkte + 1;
    kontur.xy(kontur.anz_punkte,:) = [h.x h.y];
end

walze2_x_neu = kontur.xy(dummy2+1:kontur.anz_punkte,1);
walze2_y_neu = kontur.xy(dummy2+1:kontur.anz_punkte,2);

i2 = kontur.anz_punkte;    % end of the right roll

for i=1:dummy2
    h.x = kontur.xy(i,1);
    h.y = kontur.xy(i,2);
    hv=rotate([h.x h.y],-240);
    h.x = hv(1);
    h.y = hv(2);
    kontur.anz_punkte = kontur.anz_punkte + 1;
    kontur.xy(kontur.anz_punkte,:) = [h.x h.y];
end

walze3_x_neu = kontur.xy(i2+1:kontur.anz_punkte,1);
walze3_y_neu = kontur.xy(i2+1:kontur.anz_punkte,2);

npunkte=size(walze1_x_neu,1) + size(walze2_x_neu,1) + size(walze3_x_neu,1);

n2 = size(walze2_x_neu,1);

p1x = (walze2_x_neu(n2) + walze3_x_neu(1))/2;
p1y = (walze2_y_neu(n2) + walze3_y_neu(1))/2;
hilf1=[p1x p1y; flip(walze2_x_neu) flip(walze2_y_neu)];
hilf2=[flip(walze1_x_neu) flip(walze1_y_neu)];
hilf3=[flip(walze3_x_neu) flip(walze3_y_neu); p1x p1y];

xy=[hilf1;hilf2;hilf3];

npunkte=size(xy,1);
wof = 2*ir-sqrt(3)/2*s;

% assign the groove parameters to the kontur structure
kontur.anz_punkte=npunkte;
kontur.wof = wof;
kontur.typus = 16;
kontur.durchmesser=2*ir;
kontur.breite=0;
kontur.hoehe=0;
kontur.radius1=0;
kontur.radius2=r2;
kontur.radius3=0;
kontur.radius4=0;
kontur.gamma1=0;
kontur.gamma2=0;
kontur.spalt=s;
kontur.alpha=0;
kontur.bombierung=0;
kontur.slweite=0;
kontur.innenradius=ir;
kontur.winkel=0;
kontur.walze1xy=[walze1_x_neu walze1_y_neu];
kontur.walze2xy=[walze2_x_neu walze2_y_neu];
kontur.walze3xy=[walze3_x_neu walze3_y_neu];
kontur.xy=xy;


% if you need a sample plot of the groove, uncomment the following commands
%
% figure 1 shows all 3 rolls seperately
% figure 2 shows all rolls in one contour

%figure(1)
%plot(kontur.walze1xy(:,1), kontur.walze1xy(:,2), '.')
%hold on
%plot(kontur.walze2xy(:,1), kontur.walze2xy(:,2), '.')
%plot(kontur.walze3xy(:,1), kontur.walze3xy(:,2), '.')

%axis equal

%figure(2)
%plot(kontur.xy(:,1), kontur.xy(:,2), '.')
%axis equal

end