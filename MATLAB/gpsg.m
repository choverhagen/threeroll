function [g2] = gpsg(g1, mitt)
  if (g1(2) == 0)
      alpha=90;
  else
      alpha=atand(-g1(1)/g1(2));
  end
  

  p1x =mitt(1);
  p1y =mitt(2);
  
  p2x = p1x - sind(alpha);
  p2y = p1y + cosd(alpha);
  
  g2 = gpp(p1x, p1y, p2x, p2y);
end

