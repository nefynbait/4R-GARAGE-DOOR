figure
hold on
velocity2=[];
t2=[];
for x=2:99
  velocity2 = [velocity2 -thetadoor(1,x)+thetadoor(1,x-1)];
  t2=[t2 x-1];
endfor

