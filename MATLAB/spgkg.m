function [mitt,tan1,tan2] = spgkg(g1,g2,r,lage,tausch)

    % center and tangent points of the arc with radius r2 connecting the
    % two lines g1 and g2

   g11 = parger(g1,r,lage,tausch);
   g22 = parger(g2,r,lage,tausch);
   
   [mitt.x,mitt.y] = schnittg(g11,g22);

   mittv(1) = mitt.x; mittv(2) = mitt.y;
   g11 = gpsg(g1,mittv);
   [tan1.x, tan1.y] = schnittg(g1,g11);
   
   g22 = gpsg(g2,mittv);
   [tan2.x, tan2.y] = schnittg(g2,g22);
   
end