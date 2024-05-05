function [b1] = spread_3rp(h0,h1,b0,dw)
%
%  spread calculation for 3RP
%
%  replace this code to include your own spreading model
%

  R = dw/2;
  bk0 = 2/sqrt(3)*(2*b0-h0);  
  b1_roux = spread_roux(2*h0,2*h1,b0,2*R);
  db=2/3*(b1_roux-b0);  % width change
  b1=b0+db;             % contact width

end

