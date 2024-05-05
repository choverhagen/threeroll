function [kout] = rotate_contour(k1,grad)
%!------------------------------------!
%!                                    ! 
%!    PIREF Walzmodell für 3RP        !
%!                                    !
%!                                    ! 
%! Created:   12.03.2018   cov/UDE    !
%! Updated:   12.03.2018   cov/UDE    !
%!                                    !
%! Drehe Kontur um den Winkel Grad    !  
%! im Uhrzeigersinn                   !
%!                                    !
%!------------------------------------!

kout=k1;
n1=k1.anz_punkte;

% Drehmatrix
dm=[cosd(-grad) -sind(-grad); sind(-grad) cosd(-grad)];

% Punkte drehen
kout.xy=(dm * k1.xy')';

a=0;
i=0;

yneu=kout.xy(:,2);
xneu=kout.xy(:,1);
absx=abs(xneu);
for i=1:n1
  if (yneu(i)<0) 
      absx(i)=1e10;
  end
end

[minx,mini]=min(absx);

if (xneu(mini)>0)
    mini=mini-1;
end

x2=xneu(mini:mini+1);
y2=yneu(mini:mini+1);
yp=interp1(x2,y2,0);

%kout.xy(mini+1,1)=0;
%kout.xy(mini+1,2)=yp;

% Neu sortieren
%xyneu=[kout.xy(mini+1:n1,:); kout.xy(1:mini,:)]; 
xyneu=[0 yp; kout.xy(mini+2:n1,:); kout.xy(1:mini,:)];
kout.xy=xyneu;
kout.anz_punkte=size(kout.xy,1);
%figure(1)
%plot(k1.xy(:,1), k1.xy(:,2), 'r-')
%axis equal
%hold on
%grid on
%plot(k1.xy(1,1), k1.xy(1,2), 'ro')
%plot(kout.xy(:,1), kout.xy(:,2), 'b-.')
%plot(kout.xy(mini+1,1), kout.xy(mini+1,2), 'bo')
 
end