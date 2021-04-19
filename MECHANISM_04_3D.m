%**************VALUES OBTAINED FROM SYNTHESIS**********
A = [1.1; 5.5;0]
B = [1.5; 6.7;0]

A1 = [1.1; 5.5;10]
B1 = [1.5; 6.7;10]

L2 = 2.4
L3 = 1.6
L4 = 2.3
L1 = sqrt((B(1,1)-A(1,1))*(B(1,1)-A(1,1)) + (B(2,1)-A(2,1))*(B(2,1)-A(2,1)))
phiaxis = (atand((A(2,1)-B(2,1))/(A(1,1)-B(1,1))))

lc = 0.6
ld = 1.5

ldown = 3.3;
lup = 5.3;

k1 = L1/L4;
k2 = L1/L2;
k3 = (L4*L4-L3*L3+L2*L2+L1*L1)/(2*L4*L2);
k4 = L1/L3;
k5 = (L4*L4-L1*L1-L2*L2-L3*L3)/(2*L2*L3);

phi1 = 360-154;%RANGE OF ANGLE ROTAION OF LINK 2 
phi2 = 12;

end1=[];
end2=[];
n=0
%*****************SIMULATION**************************
for theta = phi1:-2:phi2
  theta
  D1 = [A(1,1)+L2*cosd(theta+phiaxis);A(2,1)+L2*sind(theta+phiaxis);0]; %OBTAINING D COORDINATE
  D2 = [A(1,1)+L2*cosd(theta+phiaxis);A(2,1)+L2*sind(theta+phiaxis);10];
  
  a = cosd(theta)-k1-k2*cosd(theta)+k3;
  b = -2*sind(theta);                                 %CO-EFFECIENT OF FRUDIENSTIEN EQUATION
  c = k1-(k2+1)*cosd(theta) + k3;
  
  theta4 = 2*atand((-b-sqrt(b*b-4*a*c))/(2*a));
 
  C1 = [B(1,1)+L4*cosd(theta4+phiaxis);B(2,1)+L4*sind(theta4+phiaxis);0];
  C2 = [B(1,1)+L4*cosd(theta4+phiaxis);B(2,1)+L4*sind(theta4+phiaxis);10];
  main = [A , B , C1 , D1, A];
  x = main(1,[1:5]);
  y = main(2,[1:5]);
  z = main(3,[1:5]);
  
  theta3 = atan2d((C1(2,1)-D1(2,1)),(C1(1,1)-D1(1,1)));
  if(n == 0)
    thetaper = theta3;
    n=n+1;
  endif
  Cdash = [C1(1,1)-lc*cosd(theta3-thetaper);C1(2,1)-lc*sind(theta3-thetaper);0];
  Ddash = [D1(1,1)-ld*cosd(theta3-thetaper);D1(2,1)-ld*sind(theta3-thetaper);0];
  
  Cdash1 = [C2(1,1)-lc*cosd(theta3-thetaper);C2(2,1)-lc*sind(theta3-thetaper);10];
  Ddash1 = [D2(1,1)-ld*cosd(theta3-thetaper);D2(2,1)-ld*sind(theta3-thetaper);10];
  theta3dash = atand((Cdash(2,1)-Ddash(2,1))/(Cdash(1,1)-Ddash(1,1)));
  
  E = [Ddash(1,1)- ldown*cosd(theta3dash);Ddash(2,1)-ldown*sind(theta3dash);0];
  F = [Cdash(1,1)+ lup*cosd(theta3dash);Cdash(2,1)+lup*sind(theta3dash);0];
  
  E1 = [Ddash(1,1)- ldown*cosd(theta3dash);Ddash(2,1)-ldown*sind(theta3dash);10];
  F1 = [Cdash(1,1)+ lup*cosd(theta3dash);Cdash(2,1)+lup*sind(theta3dash);10];
  end1=[end1 E];
  end2=[end2 F];
  
  %********************PLOTTING*************************** 
  plot3(z,x,y, 'LineWidth', 5);
  hold on;
  plot3(z,x,y, '.','markersize', 25);
  
  main = [A1 , B1 , C2 , D2, A1];
  x = main(1,[1:5]);
  y = main(2,[1:5]);
  z = main(3,[1:5]);
  plot3(z,x,y, 'LineWidth', 5);
  plot3(z,x,y, '.','markersize', 25);
  
  x1 = [E(1,1) F(1,1)];
  y1 = [E(2,1) F(2,1)];
  z1 = [0 0];
  plot3(z1,x1,y1,'g','LineWidth', 3);
  
  x1 = [E(1,1) F(1,1)];
  y1 = [E(2,1) F(2,1)];
  z1 = [10 10];
  plot3(z1,x1,y1,'g','LineWidth', 3);
  patch([C1(3,1) D1(3,1) Ddash(3,1) Cdash(3,1)],[C1(1,1) D1(1,1) Ddash(1,1) Cdash(1,1)],[C1(2,1) D1(2,1) Ddash(2,1) Cdash(2,1)],4)
  patch([C2(3,1) D2(3,1) Ddash1(3,1) Cdash1(3,1)],[C2(1,1) D2(1,1) Ddash1(1,1) Cdash1(1,1)],[C2(2,1) D2(2,1) Ddash1(2,1) Cdash1(2,1)],4)
  
  patch([E(3,1) F(3,1) F1(3,1) E1(3,1)],[E(1,1) F(1,1) F1(1,1) E1(1,1)],[E(2,1) F(2,1) F1(2,1) E1(2,1)],53)
  axis([-1 10 -5 12 0 10])
  daspect([1 1 1])
  view(-60,15)
  xlabel("x");
  ylabel("y");
  zlabel("z");
  pause(0.1);
  hold off;
endfor