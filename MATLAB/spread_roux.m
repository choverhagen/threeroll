function [b1] = spread_roux(h0,h1,b0,dw)

%
% Roux spread calculation for the 2RP

  dh = h0-h1;
  bzh = b0/h0;
  r = dw/2;
  rzh=r/h0;
  B=(bzh-1)*bzh^(2/3);
  A=(1+5*(0.35-dh./h0).^2).*sqrt(h0./dh-1);
  b1=b0+dh.*bzh./((1+0.57.*B).*(1-dh./h0+3.*A./(2.*rzh).^(3/4)));
end

