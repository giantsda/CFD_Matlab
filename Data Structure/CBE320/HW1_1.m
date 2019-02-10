
function HW1_1
close all;
input=[0.02 0 1 .2;.00004 .0002 .06 1.00002;.0001 .0002 .0006 .0003;.04 .02 .06 .04];
initialContion=[500;200];
for i=1:4
    [T,Y] = ode45(@myfun,[0:500],initialContion,[],input(:,i));
    figure;
    plot (T,Y);
end
 


function dy=myfun(t,x,input)
M=x(1);
C=x(2);
%% subtract parameters
k1=input(1);
k2=input(2);
k3=input(3);
k4=input(4);

dMdt=k1*M-k2*M*C;
dCdt=k3*M*C-k4*C;
dy= [dMdt;dCdt];

 