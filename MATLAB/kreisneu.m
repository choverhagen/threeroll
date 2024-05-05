function [k_] = kreisneu(x,y,r,tan1,tan2,schritt)
x_=[tan1(1)];
y_=[tan1(2)];
th1 = atan2(tan1(2)-y,tan1(1)-x);
th2 = atan2(tan2(2)-y,tan2(1)-x);
th= abs(th1)-abs(th2);
%if (th1 < 0)
%    th1 = 2*pi-abs(th1);
%end

%if (th2 < 0)
%    th2 = 2*pi-abs(th2);
%end


n = ceil(r*abs(abs(th2)-abs(th1))/schritt);
%n=20;
thv = linspace(th1,th2,n);

pxv = zeros(1,n);
pyv = zeros(1,n);

if th1 < 0 && th2 >= pi/2
    thv = linspace(th1,pi*(-1)+(pi-th2),n);
else
end

for i=1:n
  pxv(i) = x + r*cos(thv(i));
  pyv(i) = y + r*sin(thv(i));
end

k_=[pxv'  pyv'];
%h_=plot(pxv, pyv, '-');

end

