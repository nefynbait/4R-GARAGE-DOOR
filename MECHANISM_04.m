%**************VALUES OBTAINED FROM SYNTHESIS**********
A = [1.1; 5.5]
B = [1.5; 6.7]

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

phi1 = 360-154; %RANGE OF ANGLE ROTAION OF LINK 2 
phi2 = 12;

end1=[];
end2=[];
n=0
thetadoor=[];
mid=[];
%*****************SIMULATION**************************
for theta = phi1:-2:phi2
  theta
  D = [A(1,1)+L2*cosd(theta+phiaxis);A(2,1)+L2*sind(theta+phiaxis)]; %OBTAINING D COORDINATE
  
  a = cosd(theta)-k1-k2*cosd(theta)+k3;
  b = -2*sind(theta);                                 %CO-EFFECIENT OF FRUDIENSTIEN EQUATION
  c = k1-(k2+1)*cosd(theta) + k3;
  
  theta4 = 2*atand((-b-sqrt(b*b-4*a*c))/(2*a))
 
  C = [B(1,1)+L4*cosd(theta4+phiaxis);B(2,1)+L4*sind(theta4+phiaxis)]
  main = [A , B , C , D, A];
  x = main(1,[1:5]);
  y = main(2,[1:5]);

  theta3 = atan2d((C(2,1)-D(2,1)),(C(1,1)-D(1,1)));
  if(n == 0)
    thetaper = theta3;
    n=n+1;
  endif
  Cdash = [C(1,1)-lc*cosd(theta3-thetaper);C(2,1)-lc*sind(theta3-thetaper)];
  Ddash = [D(1,1)-ld*cosd(theta3-thetaper);D(2,1)-ld*sind(theta3-thetaper)];
  theta3dash = atand((Cdash(2,1)-Ddash(2,1))/(Cdash(1,1)-Ddash(1,1)));
  thetadoor=[thetadoor theta3dash];
  E = [Ddash(1,1)- ldown*cosd(theta3dash);Ddash(2,1)-ldown*sind(theta3dash)]
  F = [Cdash(1,1)+ lup*cosd(theta3dash);Cdash(2,1)+lup*sind(theta3dash)]
  
  mid=[mid (E+F)/2];
  end1=[end1 E];
  end2=[end2 F];
  
  %********************PLOTTING*************************** 
  plot(x,y, 'LineWidth', 5);
  hold on;
  plot(x,y, '.','markersize', 25);
  x1 = [E(1,1) F(1,1)];
  y1 = [E(2,1) F(2,1)];
  plot(x1,y1,'g','LineWidth', 3);
  patch([C(1,1) D(1,1) Ddash(1,1) Cdash(1,1)],[C(2,1) D(2,1) Ddash(2,1) Cdash(2,1)],4)
  axis([-6 8 0 12])
  daspect([1 1 1])
  pause(0.1);
  hold off;
endfor