%**************VALUES OBTAINED FROM SYNTHESIS**********

A1=[2.35;6.7;0];
B1=[6.3;5.35;0];

A2=[2.35;6.7;10];
B2=[6.3;5.35;10];

L2=5.3
L3=6
L4=6.9
L1=sqrt((B1(1,1)-A1(1,1))*(B1(1,1)-A1(1,1)) + (B1(2,1)-A1(2,1))*(B1(2,1)-A1(2,1)))
phiaxis=abs(atand((A1(2,1)-B1(2,1))/(A1(1,1)-B1(1,1))))

ldown=2;
lup=2;

k1=L1/L4;
k2=L1/L2;
k3=(L4*L4-L3*L3+L2*L2+L1*L1)/(2*L4*L2);
k4=L1/L3;
k5=(L4*L4-L1*L1-L2*L2-L3*L3)/(2*L2*L3);

phi1=360-105; %RANGE OF ANGLE ROTAION OF LINK 2 
phi2=110;

end1=[];
end2=[];
thetadoor[];
%*****************SIMULATION**************************
for theta=phi1:-2:phi2
  
  D1=[A1(1,1)+L2*cosd(theta-phiaxis);A1(2,1)+L2*sind(theta-phiaxis);0]; %OBTAINING D COORDINATE
  D2=[A1(1,1)+L2*cosd(theta-phiaxis);A1(2,1)+L2*sind(theta-phiaxis);10];
  
  a=cosd(theta)-k1-k2*cosd(theta)+k3;  %CO-EFFECIENT OF FRUDIENSTIEN EQUATION
  b=-2*sind(theta);
  c=k1-(k2+1)*cosd(theta) + k3;
  
  theta4=2*atand((-b-sqrt(b*b-4*a*c))/(2*a));
 
  C1= [B1(1,1)+L4*cosd(theta4-phiaxis);B1(2,1)+L4*sind(theta4-phiaxis);0];
  C2= [B1(1,1)+L4*cosd(theta4-phiaxis);B1(2,1)+L4*sind(theta4-phiaxis);10];
  
  main=[A1 , B1 , C1 , D1, A1];
  x=main(1,[1:5]);
  y=main(2,[1:5]);
  z=main(3,[1:5]);
  theta3=atand((C1(2,1)-D1(2,1))/(C1(1,1)-D1(1,1)));

  E1=[D1(1,1)- ldown*cosd(theta3);D1(2,1)-ldown*sind(theta3);0];
  F1=[C1(1,1)+ lup*cosd(theta3);C1(2,1)+lup*sind(theta3);0];

  E2=[D2(1,1)- ldown*cosd(theta3);D2(2,1)-ldown*sind(theta3);10];
  F2=[C2(1,1)+ lup*cosd(theta3);C2(2,1)+lup*sind(theta3);10];
  end1 = [end1 E1];
  end2 = [end2 F1];
  
 %********************PLOTTING*************************** 
  plot3(z,x,y, 'LineWidth', 5);
  hold on;
  plot3(z,x,y,'.', "markersize", 35);
  
  main=[A2 , B2 , C2 , D2, A2];
  x=main(1,[1:5]);
  y=main(2,[1:5]);
  z=main(3,[1:5]);
  plot3(z,x,y, 'LineWidth', 5);
  plot3(z,x,y,'.', "markersize", 35);
  
  x1=[E1(1,1) F1(1,1)];
  y1=[E1(2,1) F1(2,1)];
  z1=[0 0];
  plot3(z1,x1,y1,'LineWidth',3);
  
  z1=[10 10];
  plot3(z1,x1,y1,'LineWidth',3);
  
  patch([E1(3,1) F1(3,1) F2(3,1) E2(3,1)], [E1(1,1) F1(1,1) F2(1,1) E2(1,1)],[E1(2,1) F1(2,1) F2(2,1) E2(2,1)],53);
  axis([-1 12 -5 12 0 14])
  daspect([1 1 1])
  view(-60,15)


  pause(0.1);
  hold off;
endfor