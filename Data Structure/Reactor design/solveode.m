function [ll] = solveode( )
m0 = [0.1, 500];% initial condition
caf=2;
tspan = linspace(0,200);
[tsoln, sisoln] = ode45(@myode, tspan,m0);
X=(caf-sisoln(:,1))/caf;
subplot(2,2,1);
plot(tsoln,sisoln(:,2));
xlabel('time')
ylabel('Temperature')
title('initial condtion is [0.1, 500]')
subplot(2,2,2);
plot(tsoln,X)
xlabel('time')
ylabel('Convention')
title('initial condtion is [0.1, 500]')
m0 = [1.5, 290]; %initial conditon
[tsoln, sisoln] = ode45(@myode, tspan,m0);
X=(caf-sisoln(:,1))/caf;
subplot(2,2,3);
plot(tsoln,sisoln(:,2));
xlabel('time')
ylabel('Temperature')
title('initial condtion is [1.5, 290]')
subplot(2,2,4);
plot(tsoln,X)
xlabel('time')
ylabel('Convention')
title('initial condtion is [1.5, 290]')
end
function [xp] = myode(tf,y)
ca=y(1); t=y(2);
km = 4.56*10^8;
E  = 8000;
caf = 2;
cp  = 4;
tf =  298;
ta  = tf;
DeltaH_R = -3e5;
U  = 0;
tao=10;
k = km*exp(-E/t);
dcadt = 1/tao*(caf-ca)-k*ca;
dsidt =-k*ca*DeltaH_R/1000/cp+1/tao*(tf-t);
xp=[dcadt; dsidt];
end
