function [kontur] = groove_threeroll_singleradius(d, r1, r2, s)
%.
%. construct the threeroll singleradius non-opened groove
%.
%. d: groove diameter
%. r1: main radius (r1=d/2 for circular round)
%. r2: transition radius roll barrel-roll gap
%. s: roll gap
%.
%. by Christian Overhagen <christian.overhagen@uni-due.de>

max_punkte=500;

% eccentricity and diameter
ecc = r1 - d/2;
ir = d/2;

% some lines from point and angle
g1 = gpw(0,0,-60);       % left groove symmetry line
g2 = gpp(0,0,0,-ir);     % vertical
g3 = gpw(0,0,60);        % roll gap center line right
g4 = gpw(0,-s/sqrt(3),-60);

% gap length
sl=5;

% the r1 circle with centerpoint and radius
k1(1)=0;
k1(2)=ecc;
k1(3)=r1;
mittr1.x = 0;
mittr1.y = ecc;


p = spkg(g1,k1,'n');
q = spkg(g4,k1,'n');

e.x = q.x - sl*cosd(30);
e.y = q.y - sl*sind(30);

[mitt,tan1,tan2] = spgkk(g4,k1,r2,'a',-1,0);

tan2_.x = -tan2.x;
tan2_.y = tan2.y;
tan1_.x = -tan1.x;
tan1_.y = tan1.y;
mitt_.x = -mitt.x;
mitt_.y = mitt.y;
q_.x = -q.x;
q_.y = q.y;
p_.x = -p.x;
p_.y = p.y;
e_.x = -e.x;
e_.y = e.y;

mm.x = 0;
mm.y = -ir;


% Precalculate the circumference of the contour
dist = dist_pkte(e, tan1);
umfang=dist+pi*r2 + dist_pkte(tan2,mm);
umfang=umfang*6;

%calcualte stepwidth
schritt_l = umfang / (max_punkte*0.8);

% mirror the points

kontur.xy=[];
% setze kontur zusammen
kontur.anz_punkte = 1;
kontur.xy(1,1) = e.x;
kontur.xy(1,2) = e.y;


[x,y] = gerade_kon(e,tan1,schritt_l);
kontur.xy = [kontur.xy; [x' y']];


[x,y] = kreis_kon(mitt,tan1,tan2,r2,schritt_l);
kontur.xy = [kontur.xy; [x' y']];



[x,y] = kreis_kon(mittr1,tan2,tan2_,r1,schritt_l);
kontur.xy = [kontur.xy; [x' y']];


[x,y] = kreis_kon(mitt_,tan2_,tan1_,r2,schritt_l);
kontur.xy = [kontur.xy; [x' y']];


[x,y] = gerade_kon(tan1_,e_,schritt_l);     % KREIS
kontur.xy = [kontur.xy; [x' y']];

kontur.anz_punkte = size(kontur.xy,1);

kontur.anz_punkte = kontur.anz_punkte + 1;
kontur.xy(kontur.anz_punkte,1) = e_.x;
kontur.xy(kontur.anz_punkte,2) = e_.y;

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

n2 = size(walze2_x_neu,1);


p1x = (walze2_x_neu(n2) + walze3_x_neu(1))/2;
p1y = (walze2_y_neu(n2) + walze3_y_neu(1))/2;
hilf1=[p1x p1y; flip(walze2_x_neu) flip(walze2_y_neu)];
hilf2=[flip(walze1_x_neu) flip(walze1_y_neu)];
hilf3=[flip(walze3_x_neu) flip(walze3_y_neu); p1x p1y];

xy=[hilf1;hilf2;hilf3];

npunkte=size(xy,1);

breite = sqrt(r1^2-3/4*(r1-ir)^2)+ir/2-r1/2;
wof = sqrt(r1^2-(sqrt(3)/2*(r1-ir)+s/2)^2)+ir/2-r1/2;

kontur.anz_punkte=npunkte;
kontur.typus = 16;
kontur.durchmesser=2*ir;
kontur.wof = wof;                 % width on face
kontur.breite=breite;             % theoretical groove width
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
%plot(kontur.xy(:,1), kontur.xy(:,2), '.-')
%axis equal

end