function [g11] = parger(g1,l,lage,tausch)

% move line parallel by l


% Horizontal
if (g1(1)==0)
    g11(1)=g1(1);
    g11(2)=1;
    help=-1*g1(3)/g1(2);
    if (help>0)
        if (lage=='i')
            g11(3)=-1*(help-l);
        else
            g11(3)=-1*(help+l);
        end
    else
        if (lage=='i')
            g11(3)=-1*(help+l);
        else
            g11(3)=-1*(help-l);
        end
    end
    %Vertikal
elseif  (g1(2)==0)
    g11(1)=1;
    g11(2)=g1(2);
    help=-1*g1(3)/g1(1);
 if (help>0)
     if (lage=='i')
        g11(3)=-1*(help-l);
    else
        g11(3)=-1*(help+l);
    end
else
    if (lage=='i')
        g11(3)=-1*(help+l);
    else
        g11(3)=-1*(help-l);
    end
end
%Schief
else
    b=-1*g1(3)/g1(2);
    m=-1*g1(1)/g1(2);
    alpha=atand (m);
    bl=l/cosd(alpha);
    g11(1)=-1*m;
    g11(2)=1;
    help=1;
    
    if (b>0)
        help=-1;
    end
    help2=-1;  
        
        %Getauscht
    if (tausch)
        if (lage=='a')
            help2=-1;
        end
        else
            if (lage=='i')
                help2=1;
            end
    end
            g11(3)=-1*(b+help*help2*bl);
end
end
    
        
        
            
    
    



