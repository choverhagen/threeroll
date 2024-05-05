function [] = plot_stich(k1,k2,k3,k4,figno)

%
%   Plot pass given by 4 contours
%
%   k1: Initial
%   k2: Groove
%   k3: Exit
%   k4: Contact
%


k1p.xy=[k1.xy; k1.xy(1,:)];
k2p.xy=[k2.xy; k2.xy(1,:)];
k3p.xy=[k3.xy; k3.xy(1,:)];
k4p.xy=[k4.xy; k4.xy(1,:)];


title(['Pass No ',figno])
plot(k1p.xy(:,1), k1p.xy(:,2), 'b-')
hold on
axis equal
grid on
plot(k2p.xy(:,1), k2p.xy(:,2), 'k-')
plot(k3p.xy(:,1), k3p.xy(:,2), 'r-')
plot(k4p.xy(:,1), k4p.xy(:,2), 'k--')

end

