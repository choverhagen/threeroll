function [sp] = spkg(g,k,lage)


if (g(1)==0)                     % Line is horizontal
    sp.y=-1 * g(3) / g(2);
   if (((k(2)+k(3)) < sp.y) || ((k(2)-k(3)) > sp.y))
    end


   A=1;
   B= -2 * k(1);  
   C=k(1)^2+(g(3)/g(2))^2+2*(g(3)/g(2))*k(2)+k(2)^2-k(3)^2;   
   if (lage=='j' || lage=='J')
       sp.x=-B/2 + sqrt(B^2/4 - C);
   else
       sp.x=-B/2 - sqrt(B^2/4 - C); 
   end

elseif (g(2)==0)
    sp.x= -1 * g(3) / g(1);
    if (((k(1)+k(3)) < sp.x) || ((k(1)-k(3)) > sp.x))
    end
       A = 1;
	   B = -2 * k(2);
	   C = k(2)^2+(g(3)/g(1))^2+2*(g(3)/g(1))*k(1)+k(1)^2-k(3)^2; 
     if ((lage=='j') || (lage == 'J'))
             sp.y = -B/2 + sqrt(B^2/4 - C);
         else
             sp.y = -B/2 - sqrt(B^2/4 - C);
     end
         
else
      dummy = -g(1)/g(2)*k(1) - g(3)/g(2);
      if (((k(2)+k(3)) < dummy) || ((k(2)-k(3)) >= dummy))
  
      end
       A = (g(1)/g(2))^2 + 1;
	   B = 2*( g(1)/g(2)*(g(3)/g(2)+k(2)) - k(1) );
	   C = (g(3)/g(2)+k(2))^2 - k(3)^2 + k(1)^2;
	   if (A ~= 0)
            if ((lage == 'j') || (lage == 'J')) 
               sp.x = -B/(A*2) + sqrt((B/A)^2/4-C/A);
  	        else
	         sp.x = -B/(A*2) - sqrt((B/A)^2/4-C/A);		     
            end
          sp.y = -g(1)/g(2)*sp.x - g(3)/g(2);
       end 
    
 end
          
           
           
           
             
             
    
    
        
        

