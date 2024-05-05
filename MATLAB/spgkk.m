function [mitt,tan1,tan2] = spgkk(g1,k,r,lage,richtung,tausch)




[gp] = parger(g1,r,lage,0);


rp=r;
if(lage=='i')
    rp = -1*rp;
end

kp(3)=k(3)+rp;
kp(2)=k(2);
kp(1)=k(1);

mitt=spkg(gp,kp,richtung);

m(1) = mitt.x;
m(2) = mitt.y;

gps=gpsg(gp,m);

[tan1.x,tan1.y]=schnittg(gps,g1);  

gks=gpp(mitt.x,mitt.y,k(1),k(2));


tan2=spkg(gks,k,richtung);

end

