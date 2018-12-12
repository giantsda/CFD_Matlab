function [x]= exam_3_a
clc
clear
x=[];
fval=[];
options=optimset('MaxFunEvals',1000,'MaxIter',1000);
for i=1:1:500
% x0=[Ca_ini(i);T_ini(i)];
Ca_ini=2*rand;
T_ini=200+500*rand;
x0=[Ca_ini ;T_ini ];
[xx,fvall] = fsolve(@solve_this,x0,options);
conversion=(2-xx(1))/2;
xx(1)=conversion;
x=[x xx]; 
fval=[fval fvall];
end
hist(x(2,:))
title('Histogram plot');
xlabel('Temputrure')
end
function [y]= solve_this(x)
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
Ca=x(1);
T=x(2);
k=k0*exp(-Ea_over_R*(1/T-1/T0));
y(1)=(Caf-Ca)/tao-k*Ca;
y(2)=-delt_Hr*k*Ca/ro/Cp+(Tf-T)/tao-UAh_over_Vr*(T-Tc)/(ro*Cp);
end
