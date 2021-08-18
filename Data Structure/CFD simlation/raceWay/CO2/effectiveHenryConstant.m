% Kc1=4.498e-7;
% Kc2=4.79e-11;
% HCO2=3.428e-2;
% Pco2=3.87e-4;

Kc1=16.11e-7; % T=30+273 and Salinity=0.0035
Kc2=13.34e-10; % T=30+273 and Salinity=0.0035
HCO2=0.0299; % mol/kg/bar at T=30+273 
Pco2=0.00039212775; %bar

% Kc1=12.36e-7; % T=30+273 and Salinity=0.0035
% Kc2=7.534e-10; % T=30+273 and Salinity=0.0035
% HCO2=0.0299; % mol/kg/bar at T=30+273 
% Pco2=0.00039212775; %bar

PH=2:0.05:14;
PH=9
H=10.^(-PH);
EffctiveHenryConstant=HCO2*(1+Kc1./H+Kc1*Kc2./H./H);
% plot(PH,EffctiveHenryConstant);
% xlabel('PH');
% ylabel('EffctiveHenryConstant');
% 
CTotal=EffctiveHenryConstant*Pco2;
plot(PH,CTotal);
% CTotal=1;
HCO3=H.*Kc1./(H.*H+H.*Kc1+Kc1*Kc2).*CTotal;
H2CO3=H.*H./(H.*H+H.*Kc1+Kc1*Kc2).*CTotal;
CO3=Kc1*Kc2./(H.*H+H.*Kc1+Kc1*Kc2).*CTotal;
H2CO3=H2CO3;
 
% plot(PH,HCO3);
% hold on;
% plot(PH,H2CO3);
% plot(PH,CO3);