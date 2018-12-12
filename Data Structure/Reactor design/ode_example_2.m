function [ ca, cb, cc, cd, ce]=ode_example_2(k1,km1,k2,km2,k3)
tspan= linspace (0,20,5000);
y0=[1,0,0,0,0];
% parm=[k1,km1,k2,km2,k3];
parm=[1,1,1,1,1];
[tsoln,csoln]=ode45(@hahaha, tspan, y0,[],parm);
plotsolu(tsoln,csoln)
end
 function [dydt]=hahaha(t,y,parm)
k1=parm(1);km1=parm(2);k2=parm(3);km2=parm(4);k3=parm(5);
ca=y(1);cb=y(2);cc=y(3);cd=y(4);ce=y(5);
dcadt=(km1*cb-k1*ca*ca)*2;
dcbdt=k1*ca*ca-km1*cb+km2*cc*cd-k2*cb-k3*cb;
dccdt=k2*cb-k2*cc*cd+k3*cb;
dcddt=k2*cb-km2*cc*cd;
dcedt=k3*cb;
dydt=[dcadt;dcbdt;dccdt;dcddt;dcedt]
end
 function plotsolu (t,d)
ca=d(:,1);
cb=d(:,2);
cc=d(:,3);
cd=d(:,4);
ce=d(:,5);
subplot (1,2,1)
plot(t,ca,'-b',t,cb,'-g',t,cc,'-k',t,cd,'--',t,ce,':')
legend('ca','cb','cc','cd','ce')
grid on
xlabel('time')
ylabel('concentration')
title('Full Model')
end


