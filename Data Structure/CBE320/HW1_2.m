
function HW1_2
close all;
tspan = [0:1:1.4e4];
initialContion=[0 1];
for i=1:2
    [T,Y] = ode45(@myfun,tspan,initialContion(i),[]);
    plot(T,Y)
    hold on;
end



function dy=myfun(t,x)
Vr=50*1000;
Ca=x;
Qf=7;
Caf = 1;
k=0.02/60;
tau=Vr/Qf;
%% subtract parameters
dCadt=(Caf-Ca)/tau-k*Ca;
dy= [dCadt];

