%**************VALUES OBTAINED FROM SYNTHESIS**********

A=[3.3;5.6];
B=[5.4;4.5];

L2 = 4.8;
L3 = 4;
L4 = 5.6;
L1=sqrt((B(1,1)-A(1,1))*(B(1,1)-A(1,1)) + (B(2,1)-A(2,1))*(B(2,1)-A(2,1)))
phiaxis=abs(atand((A(2,1)-B(2,1))/(A(1,1)-B(1,1))))

ldown=2;
lup=4;

k1=L1/L4;
k2=L1/L2;
k3=(L4*L4-L3*L3+L2*L2+L1*L1)/(2*L4*L2);
k4=L1/L3;
k5=(L4*L4-L1*L1-L2*L2-L3*L3)/(2*L2*L3);

phi1=360-110; %RANGE OF ANGLE ROTAION OF LINK 2 
phi2=136;
n=0;

end1=[];
end2=[];
mid=[];
thetadoor=[];
%*****************SIMULATION**************************
for theta=phi1:-2:phi2
  
  D=[A(1,1)+L2*cosd(theta-phiaxis);A(2,1)+L2*sind(theta-phiaxis)]; %OBTAINING D COORDINATE
  
  a=cosd(theta)-k1-k2*cosd(theta)+k3;  %CO-EFFECIENT OF FRUDIENSTIEN EQUATION
  b=-2*sind(theta);
  c=k1-(k2+1)*cosd(theta) + k3;
  
  theta4=2*atand((-b-sqrt(b*b-4*a*c))/(2*a));
 
  C= [B(1,1)+L4*cosd(theta4-phiaxis);B(2,1)+L4*sind(theta4-phiaxis)];
  main=[A , B , C , D, A];
  x=main(1,[1:5]);
  y=main(2,[1:5]);

  theta3=atand((C(2,1)-D(2,1))/(C(1,1)-D(1,1)));
  E=[D(1,1)- ldown*cosd(theta3);D(2,1)-ldown*sind(theta3)];
  F=[C(1,1)+ lup*cosd(theta3);C(2,1)+lup*sind(theta3)];

  thetadoor=[thetadoor theta3];
  end1 = [end1 E];
  end2 = [end2 F];
  mid=[mid (E+F)/2];
 %********************PLOTTING*************************** 
  plot(x,y, 'LineWidth', 5);
  hold on;
  plot(x,y,'.', "markersize", 35);
  
  x1=[E(1,1) F(1,1)];
  y1=[E(2,1) F(2,1)];
  plot(x1,y1,'LineWidth',3);
  axis([-10 11 0 11])
  daspect([1 1 1])
  n=n+1;

  pause(0.1);
  hold off;
endfor