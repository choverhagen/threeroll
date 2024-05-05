function [kontur] = groove_threeroll_singleradius_opened(ir, r1, r2, alpha, s)
%.
%. construct the threeroll singleradius opened groove
%.
%. ir: inner radius
%. r1: main radius (r1=d/2 for circular round)
%. r2: transition radius roll barrel-roll gap
%. alpha: groove angle for r1
%. s: roll gap
%.
%. by Christian Overhagen <christian.overhagen@uni-due.de>

max_punkte=500;

% eccentricity and diameter
ecc = r1 - ir;
d=2*ir;

sl = 2*s+r2;   % roll gap length

mitte.x = 0;
mitte.y = ecc;


g1 = gpp(0,0,0,1);
g2 = gpw(mitte.x, 0, 60);
g3 = gpw(mitte.x, 0, -60);

g4 = gpw(mitte.x, mitte.y, alpha/2);
g5 = gpw(mitte.x, mitte.y, -alpha/2);

pkt(4).x = mitte.x + r1 * cosd(-90+alpha/2);
pkt(4).y = mitte.y + r1 * sind(-90+alpha/2);
pkt(5).x = mitte.x + r1 * cosd(-90-alpha/2);
pkt(5).y = mitte.y + r1 * sind(-90-alpha/2);

g6 = gpw(pkt(4).x, pkt(4).y, alpha/2+90);
g7 = gpw(pkt(5).x, pkt(5).y, -alpha/2-90);

k1(1) = mitte.x;
k1(2) = mitte.y;
k1(3) = r1;

[pkt(3).x,pkt(3).y] = schnittg(g6,g2);

pkt(3).x = pkt(3).x - s/2*cosd(60);
pkt(3).y = pkt(3).y - s/2*sind(60);

g8 = gpw(pkt(3).x, pkt(3).y, 60);

[pkt(3).x,pkt(3).y] = schnittg(g8,g6);

pkt(2).x = pkt(3).x + sl*cosd(30);
pkt(2).y = pkt(3).y - sl*sind(30);

[pkt(10),pkt(11),pkt(12)]=spgkg(g8,g6,r2,'a',0);


% Precalculate the circumference of the contour
dist = dist_pkte(pkt(2),pkt(11));
umfang=dist+pi*r2;

dist = dist_pkte(pkt(12),pkt(4));
umfang=umfang+dist+pi*r1*alpha/360;

umfang=umfang+s/2;
umfang=umfang*6;

%calcualte stepwidth
schritt_l = umfang / (max_punkte*0.8);

% mirror the points

pkt(5).x = -pkt(4).x;
pkt(5).y =  pkt(4).y;

pkt(6).x = -pkt(3).x;
pkt(6).y =  pkt(3).y;

pkt(7).x = -pkt(2).x;
pkt(7).y =  pkt(2).y;

pkt(13).x = -pkt(10).x;
pkt(13).y =  pkt(10).y;

pkt(14).x = -pkt(11).x;
pkt(14).y =  pkt(11).y;

pkt(15).x = -pkt(12).x;
pkt(15).y =  pkt(12).y;

kontur.xy=[];

% build contour

kontur.anz_punkte = 1;
kontur.xy(1,1) = pkt(7).x;
kontur.xy(1,2) = pkt(7).y;


[x,y] = gerade_kon(pkt(7),pkt(14),schritt_l);
kontur.xy = [kontur.xy; [x' y']];

[x,y] = kreis_kon(pkt(13),pkt(14),pkt(15),r2,schritt_l);
kontur.xy = [kontur.xy; [x' y']];

[x,y] = gerade_kon(pkt(15),pkt(5),schritt_l);
kontur.xy = [kontur.xy; [x' y']];

[x,y] = kreis_kon(mitte,pkt(5),pkt(4),r1,schritt_l);
kontur.xy = [kontur.xy; [x' y']];

[x,y] = gerade_kon(pkt(4),pkt(12),schritt_l);
kontur.xy = [kontur.xy; [x' y']];

[x,y] = kreis_kon(pkt(10),pkt(12),pkt(11),r2,schritt_l);
kontur.xy = [kontur.xy; [x' y']];

[x,y] = gerade_kon(pkt(11),pkt(2),schritt_l);
kontur.xy = [kontur.xy; [x' y']];


kontur.anz_punkte = size(kontur.xy,1);

kontur.anz_punkte = kontur.anz_punkte + 1;
kontur.xy(kontur.anz_punkte,1) = pkt(2).x;
kontur.xy(kontur.anz_punkte,2) = pkt(2).y;

% bottom roll contour is finished here

i1 = kontur.anz_punkte;    % end of the bottom roll

walze1_x_neu = kontur.xy(1:kontur.anz_punkte,1);
walze1_y_neu = kontur.xy(1:kontur.anz_punkte,2);


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

%npunkte=size(walze1_x_neu,1) + size(walze2_x_neu,1) + size(walze3_x_neu,1);

n2 = size(walze2_x_neu,1);

p1x = (walze2_x_neu(n2) + walze3_x_neu(1))/2;
p1y = (walze2_y_neu(n2) + walze3_y_neu(1))/2;
hilf1=[p1x p1y; flip(walze2_x_neu) flip(walze2_y_neu)];
hilf2=[flip(walze1_x_neu) flip(walze1_y_neu)];
hilf3=[flip(walze3_x_neu) flip(walze3_y_neu); p1x p1y];

xy=[hilf1;hilf2;hilf3];

npunkte=size(xy,1);

gamma = 30+alpha/2;

% width on face (sorry for the typo in the paper)
wof = 0.5*(ir-r1)+r1*sind(gamma)+ tand(90-gamma)*(sqrt(3)/2*(ir-r1)+r1*cosd(gamma)-s/2);

kontur.wof = wof;
kontur.anz_punkte=npunkte;
kontur.typus = 16;
kontur.durchmesser=2*ir;
kontur.breite=0;
kontur.hoehe=0;
kontur.radius1=r1;
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
%plot(kontur.walze1xy(:,1), kontur.walze1xy(:,2), '.-')
%hold on
%plot(kontur.walze2xy(:,1), kontur.walze2xy(:,2), '.-')
%plot(kontur.walze3xy(:,1), kontur.walze3xy(:,2), '.-')

%axis equal

%figure(2)
%plot(kontur.xy(:,1), kontur.xy(:,2), '-')
%hold on
%axis equal

end