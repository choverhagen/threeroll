function [k3] = auskont(k1,k2,db)
%
%   Calculate exit contour k3 from 
%   initial contour k1, roll contour k2 and
%   width change db
%

% Ontersection points of entry ang groove
cp=cutpoints(k1,k2);

n1=k1.anz_punkte;

% Find initial width
% From cutpoint range 6->1
yv=[cp(1,2); k1.xy(cp(6,3)+1:n1,2); k1.xy(1:cp(1,3),2); cp(6,2)];
b0=max(yv);

% expand the entry contour with the spread and find intersections
b1=b0+db;                                      
beta=b1/b0;
k1_with_spread = k1;
k1_with_spread.xy(:,:) = k1.xy(:,:)*beta;
cpbreit=cutpoints(k1_with_spread,k2);

% Assemble exit section
k3=k1;
k3.xy=[k1_with_spread.xy(1:cpbreit(1,3),:);...
       cpbreit(1,1:2);
       k2.xy(cpbreit(1,4)+1:cpbreit(2,4),:);...
       cpbreit(2,1:2);
       k1_with_spread.xy(cpbreit(2,3)+1:cpbreit(3,3),:);...
       cpbreit(3,1:2);
       k2.xy(cpbreit(3,4)+1:cpbreit(4,4),:);...
       cpbreit(4,1:2);
       k1_with_spread.xy(cpbreit(4,3)+1:cpbreit(5,3),:);...
       cpbreit(5,1:2);
       k2.xy(cpbreit(5,4)+1:cpbreit(6,4),:);...
       cpbreit(6,1:2);
       k1_with_spread.xy(cpbreit(6,3)+1:n1,:)];

k3.anz_punkte=size(k3.xy,1);   

end
