% % Kc1=4.498e-7;
% % Kc2=4.79e-11;
% % HCO2=3.428e-2;
% % Pco2=3.87e-4;
% 
% Kc1=16.11e-7; % T=30+273 and Salinity=0.0035
% Kc2=13.34e-10; % T=30+273 and Salinity=0.0035
% HCO2=0.0299; % mol/kg/bar at T=30+273 
% Pco2=0.00039212775; %bar
% 
% % Kc1=12.36e-7; % T=30+273 and Salinity=0.0035
% % Kc2=7.534e-10; % T=30+273 and Salinity=0.0035
% % HCO2=0.0299; % mol/kg/bar at T=30+273 
% % Pco2=0.00039212775; %bar
% 
% PH=8:0.05:10;
% PH=9
% H=10.^(-PH);
% EffctiveHenryConstant=HCO2*(1+Kc1./H+Kc1*Kc2./H./H);
% % plot(PH,EffctiveHenryConstant);
% % xlabel('PH');
% % ylabel('EffctiveHenryConstant');
% % 
% CTotal=EffctiveHenryConstant*Pco2;
% plot(PH,CTotal);
% % CTotal=1;
% HCO3=H.*Kc1./(H.*H+H.*Kc1+Kc1*Kc2).*CTotal;
% H2CO3=H.*H./(H.*H+H.*Kc1+Kc1*Kc2).*CTotal;
% CO3=Kc1*Kc2./(H.*H+H.*Kc1+Kc1*Kc2).*CTotal;
% H2CO3=H2CO3;
%  
% % plot(PH,HCO3);
% % hold on;
% % plot(PH,H2CO3);
% % plot(PH,CO3);













%%
close all;
T=273+30;
S=35;
% Kc1=16.11e-7; % T=30+273 and Salinity=0.0035
% Kc2=13.34e-10; % T=30+273 and Salinity=0.0035
pK1=-43.6977-0.0129037*S+1.364*10^-4*S*S+2885.378/T+7.04515*log(T)
Kc1=10^-pK1
pK2=-452.0940+13.142162*S-8.101*10^-4*S*S+21263.61/T+68.483143*log(T)+(-581.4428*S+0.259601*S*S)/T-1.967035*S*log(T)
Kc2=10^-pK2
KH=0.034;%Henry's law constant for solubility in water at 298.15 K (mol/(kg*bar))   https://webbook.nist.gov/cgi/cbook.cgi?ID=C124389&Mask=10#Solubility
temperatureDependenceConstant=2400;
HCO2=KH*exp(temperatureDependenceConstant*(1/T - 1/298.15));% mol/kg/bar at T=30+273 
Pco2=0.00039212775; %bar
PH=5:0.05:9;
H=10.^(-PH);
EffctiveHenryConstant=HCO2*(1+Kc1./H+Kc1*Kc2./H./H);
CTotal=EffctiveHenryConstant*Pco2*1000; % mol/L to mmol/L

plot(PH,CTotal);
xlabel('PH');
ylabel('Ctotal (mmol/L)')
HCO3=H.*Kc1./(H.*H+H.*Kc1+Kc1*Kc2).*CTotal;
H2CO3=H.*H./(H.*H+H.*Kc1+Kc1*Kc2).*CTotal;
CO3=Kc1*Kc2./(H.*H+H.*Kc1+Kc1*Kc2).*CTotal;
figure;
plot(PH,HCO3./CTotal);
hold on;
plot(PH,H2CO3./CTotal);
plot(PH,CO3./CTotal);


 
 






