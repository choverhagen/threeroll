function [g] = gpw(p1x,p1y,alfa)
%!------------------------------------!
%
%  define analytical form of line given by 1 point and angle (to the
%  vertical)
%   

  alf = alfa/180*pi;
  p2x = p1x - sin(alf);
  p2y = p1y + cos(alf);
  g=gpp(p1x,p1y,p2x,p2y);
  
end
