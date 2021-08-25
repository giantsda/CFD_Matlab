subplot(3,1,1);
%% Monod
umax=2.29/24;
Ks=0.36;
S=linspace(0,2,500);
u=umax*(S./(Ks+S));
plot(S,u);
title('monod')
xlabel('S');
ylabel('u');
hold on;
%% Andrews
Ki=0.31 ;
Ks=0.00048;
umax=0.12;
u=umax*(S./(Ks+S+S.*S./Ki));
plot(S,u);
%% Martínez Sancho
um1=0.0466;
um2=0.0256;
Ks=0.2;
u=(um1*S+um2*Ks)./(Ks+S);
plot(S,u);
%% Martínez et al. [67]
um1=0.0471;
um2=0.035;
um3=0.0272;
Ks=0.25;
Ki=0.955;
u=(um1*S+um2*Ks+um3*S.*S./Ki)./(Ks+S+S.*S./Ki);
plot(S,u);
%% Droop [26] 
Qmin=0.033 ;
Q=linspace(Qmin,1,100);
umax=0.26;
u=umax*(1-Qmin./Q);
plot(Q,u)
%% Light
subplot(3,1,2);
%% Tamiya et al. [110]
umax=2.0/24;
Ki=9.2*1000;
I=linspace(0,15000,100);
u=umax*I./(Ki+I);
plot(I,u);
hold on;
%% van Oorschot
umax=2.0/24;
KI=708;
u=umax*(1-exp(-I./KI));
plot(I,u);
%% Chalker [16]
u=umax*tanh(I./KI);
plot(I,u);

%% multiplicative VS  threshold models
close all;
umax=1;
Ksp=0.36;
Sp=linspace(0,2,50);
KSCO2=0.12;
SCO2=linspace(0,1,50);

[X,Y] = meshgrid(Sp,SCO2);
for i=1:size(X,1)
    for j=1:size(X,2)
        p=X(i,j);
        co2=Y(i,j);
        Umultiplicative(i,j)=umax*(p./(Ksp+p))*(co2./(KSCO2+co2));
        Uthreshold(i,j)=umax*min([p./(Ksp+p) co2./(KSCO2+co2)] );
    end
end
% surf(X,Y,Umultiplicative)
% xlabel('P');
% ylabel('C');
% zlabel('u');

surf(X,Y,Uthreshold)
 xlabel('P');
ylabel('C');
zlabel('u');

 

% plot(Sp,u)





