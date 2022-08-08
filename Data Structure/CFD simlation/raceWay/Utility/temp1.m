% lamba=1;
% W=linspace(0,1,1000);
% E=0.8;
% yn0=0.3;
% Yn_1=0.2;
% ynStar=0.325;
% yn=exp(E*lamba.*W)*(yn0-Yn_1)+Yn_1;
% eg=linspace(0,1,10000);
% NG=-2.3*log10(1-eg);
% plot(eg,NG)

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
ylabel('CO2 solubility (mmol/L)')
HCO3=H.*Kc1./(H.*H+H.*Kc1+Kc1*Kc2).*CTotal;
H2CO3=H.*H./(H.*H+H.*Kc1+Kc1*Kc2).*CTotal;
CO3=Kc1*Kc2./(H.*H+H.*Kc1+Kc1*Kc2).*CTotal;
figure;
plot(PH,HCO3./CTotal);
hold on;
plot(PH,H2CO3./CTotal);
plot(PH,CO3./CTotal);
xlabel('PH');
legend('Bicarbonate','CO2*H2O','Carbonate')
