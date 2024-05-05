function [cp] = cutpoints(k1,k2)
  
%!----------------------------------------!
%
% Calculate cutpoints of two contours

n1=k1.anz_punkte;
n2=k2.anz_punkte;
u1=circumference(k1);

k=0;
di = u1/pi/20;

for i1=1:n1-1
    i2=i1+1;
    % line segment of K1
    vek1=[k1.xy(i2,1) - k1.xy(i1,1) k1.xy(i2,2) - k1.xy(i1,2)];   
    
    for j1=1:n2-1
       a1=abs(k1.xy(i1,1)-k2.xy(j1,1));
       a2=abs(k1.xy(i1,2)-k2.xy(j1,2));
       if ((a1<di) && (a2<di))
           j2=j1+1;
           vek2=[k2.xy(j2,1)-k2.xy(j1,1) k2.xy(j2,2)-k2.xy(j1,2)];
           d=vek1(2)*vek2(1)-vek1(1)*vek2(2);
           if (abs(d)>1e-10) % if line segments are not parallel
                vek3=[k2.xy(j1,1) - k1.xy(i1,1) k2.xy(j1,2)-k1.xy(i1,2)];
                cx = (vek3(2)*vek2(1)-vek3(1)*vek2(2))/d;
                cy = (vek1(1)*vek3(2)-vek1(2)*vek3(1))/d;
                if ((cx>0)&&(cx<=1)&&(cy>0)&&(cy<=1))
                    k=k+1;
                    cp(k,1) = k1.xy(i1,1)+cx*vek1(1);
                    cp(k,2) = k1.xy(i1,2)+cx*vek1(2);
                    cp(k,3) = i1;
                    cp(k,4) = j1;
                end
           end
       end
    end
end

% the error case: plot contours if no cutpoints are found for diagnosis
if (k==0)
    figure(5)
    plot(k1.xy(:,1), k1.xy(:,2),'.-')
    hold on
    plot(k2.xy(:,1), k2.xy(:,2),'.-')
    axis equal
    a=0;
end

end

