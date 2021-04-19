weight=10;
torque2=[];
for x=2:99
  dely=mid(2,x)-mid(2,x-1);
  deltheta=2;
  torque2=[torque2 dely*weight*9.8/deltheta];
endfor
