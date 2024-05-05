function [A0L,A1L,h0L,h1L,ddarb] = lendl_3rp(k1,k2)
%
%   Find equivalent lendl data of a three-roll pass
%

cp=cutpoints(k1,k2);
blv=cp_abst(cp);

% Für die untere Walze (1)

g(1,:) = gpw(0,0,0);    % Oberer Walzspalt
g(2,:) = gpw(0,0,-120);  % Rechter Walzspalt
g(3,:) = gpw(0,0,120); % Linker Walzspalt
g(4,:) = g(1,:);

cpi=[1 2; 3 4; 5 6];
wi=[120; 0; -120];
A0L=0;
A1L=0;

for iw = 1:3

g4 = gpw(cp(cpi(iw,1),1),cp(cpi(iw,1),2),wi(iw));
g5 = gpw(cp(cpi(iw,2),1),cp(cpi(iw,2),2),wi(iw));

[px,py] = schnittg(g(iw,:),g4);
[qx,qy] = schnittg(g(iw+1,:),g5);

kl = k1;
kl1 = k1;
kl.xy=[0 0; px py; cp(cpi(iw,1),1:2);...
          k1.xy(cp(cpi(iw,1),3)+1:cp(cpi(iw,2),3),1:2);...
          cp(cpi(iw,2),1:2);...
          qx qy;
          0 0];
      
kl.anz_punkte=size(kl.xy,1);

kl1.xy=[0 0; px py; cp(cpi(iw,1),1:2);...
          k2.xy(cp(cpi(iw,1),4)+1:cp(cpi(iw,2),4),1:2);...
          cp(cpi(iw,2),1:2);...
          qx qy;
          0 0];

kl1.anz_punkte=size(kl1.xy,1);

A0L=A0L+area(kl);
A1L=A1L+area(kl1);

end

bL=mean(blv);

h0L = (A0L/3+bL^2*sqrt(3)/12)/bL;
h1L = (A1L/3+bL^2*sqrt(3)/12)/bL;
      

% Arbeitender Walzendurchmesser
% Dazu Umformraumhöhe

humf = -max(k2.walze1xy(:,2));
ddarb = 2*humf-h1L;
end

