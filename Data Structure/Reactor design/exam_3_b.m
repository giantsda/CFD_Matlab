function  exam_3_b
x0=[0.1536  ;404];
tspan=[1 :0.5: 100];
[t,x] = ode45(@solve_thiis,tspan,x0,[]);
subplot(3,2,1)
plot(t, x  )
%%
x0=[0.1536  ;405];
[t,x] = ode45(@solve_thiis,tspan,x0,[]);
subplot(3,2,2)
plot(t,x)
%%
x0=[1.9768  ;299];
[t,x] = ode45(@solve_thiis,tspan,x0,[]);
subplot(3,2,3)
plot(t,x)
%%
x0=[1.9768  ;300];
[t,x] = ode45(@solve_thiis,tspan,x0,[]);
subplot(3,2,4)
plot(t,x)
%%
x0=[0.8562  ;364];
[t,x] = ode45(@solve_thiis,tspan,x0,[]);
subplot(3,2,5)
plot(t,x)
%%
x0=[0.8562  ;365];
[t,x] = ode45(@solve_thiis,tspan,x0,[]);
subplot(3,2,6)
plot(t,x)
%%
end
function [dydt]= solve_thiis(t,y)
Tf=298;
UAh_over_Vr=120;
T0=298;
Tc=300;
Cp=4.0;
Caf=2.0;
k0=0.001;
Ea_over_R=8000;
ro=1000;
delt_Hr=-3*10^5;
tao=10;
Ca=y(1);
T=y(2);
k=k0*exp(-Ea_over_R*(1/T-1/T0));
dcadt=(Caf-Ca)/tao-k*Ca;
dTdt=-delt_Hr*k*Ca/ro/Cp+(Tf-T)/tao-UAh_over_Vr*(T-Tc)/(ro*Cp);
dydt=[dcadt;dTdt];
end