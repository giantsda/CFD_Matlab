% h=8739;
% T=15.04-0.00649*h+273;
% P0=101325;
% m=1.66e-27*28.84;
% g=9.81;
% k=1.38e-23;
% P=P0*exp(-m*g*h/k/T);
% sigma=0.43e-18;
% lamda=k*T/(sqrt(2)*sigma*P)
% z=(16/(pi*m*k*T))^0.5*sigma*P

% clear;
% Cp=22.5;
% R=8.314;
% Na=6.0221409e+23;
% Cvm=Cp-R;
% T=371;
% m=77.9/1000;
% sigma=0.48e-18;
% k=2*Cvm/3/sigma/Na*(R*T/pi/m)^0.5*1000

clear;
dz=21/100;
Cp=23.4;
R=8.314;
Na=6.0221409e+23;
Cvm=Cp-R;
T=392;
m=19.1/1000;
sigma=0.53e-18;
k=2*Cvm/3/sigma/Na*(R*T/pi/m)^0.5*1000
dTdx=10/dz;
A=dz*dz;
E=k*dTdx*A

















