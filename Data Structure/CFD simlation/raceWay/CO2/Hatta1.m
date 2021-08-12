PH=linspace(9,13,1000);
% PH=9;
H=10.^(-PH); % [H] mol/L
OH=1e-14./H; % [OH] mol/L
kL=3.6e-5;  %m/s liquid phase mass transfer coefficient
Cs=1.3322e-2; % mol/m3
DCO2=1.91e-9; %m2/s
T=30+273;
k=10^(13.635-(2895/T));% L/mol/s from <<THE KINETICS OF COMBINATION OF CARBON DIOXIDEWITH HYDROXIDE IONS>>
kPhoto=0.1319; % s-1
Hatta=sqrt((k.*OH+kPhoto)*DCO2)/kL;
JCO2=kL*Cs*Hatta.*coth(Hatta); %mol/m2/s
JCO2=JCO2*3600*12; % convert from mol/m2/s to gC/m2/hour
keff=k.*OH; % effective  reaction rate constant /s
% subplot(3,1,1)
plot(PH,JCO2);
xlabel('PH');
ylabel('CO2 flux gCO2/m2/hour')
% subplot(3,1,2)
% plot(PH,Hatta);
% xlabel('PH');
% ylabel('Hatta number')
% subplot(3,1,3)
% plot(PH,Hatta);
% xlabel('PH');
% ylabel('keff')