
function temp1
close all;
initialContion=[0];
[T,Y] = ode45(@myfun,[0:5000],initialContion,[]);
figure;
plot (T,Y);






function dy=myfun(t,x,input)
D=1.72e-5;
%% subtract parameters

dydt=D*(100-x)^2;

dy= [dydt];

