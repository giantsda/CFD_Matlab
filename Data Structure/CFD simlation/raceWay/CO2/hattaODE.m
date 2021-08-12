DCO2=1.91e-9; %m2/s
kL=0.000036; %m/s
thickness=DCO2/kL/100;
k1=0.5681;
 
 
span=[0 thickness];
y0=[1.3332e-5,-22.2];
[t,y] = ode15s(@Hatta, span, y0);
plot(t,y(:,1))
DCO2*-y(end,2)*1000-k1*y(end,1)*0.2*1000

function r=Hatta(t,Y)
Ha=4; 
k1=0.5681;
DCO2=1.91e-9; %m2/s
Y1=Y(1);
Y2=Y(2);
r(1,1)=Y2;
r(2,1)=k1/DCO2*Y1;
end






