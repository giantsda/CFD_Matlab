Pco2=3.87e-4;
Kc1=4.498e-7;
Kc2=4.79e-11;
HCO2=3.428e-2;
PH=2:0.05:10;
H=10.^(-PH);
EffctiveHenryConstant=HCO2*(1+Kc1./H+Kc1*Kc2./H./H);
plot(PH,EffctiveHenryConstant);
xlabel('PH');
ylabel('EffctiveHenryConstant');
 
CTotal=EffctiveHenryConstant*Pco2;
CTotal=1;
HCO3=H.*Kc1./(H.*H+H.*Kc1+Kc1*Kc2).*CTotal;
H2CO3=H.*H./(H.*H+H.*Kc1+Kc1*Kc2).*CTotal;
CO3=Kc1*Kc2./(H.*H+H.*Kc1+Kc1*Kc2).*CTotal;
H2CO3=H2CO3;
 
% plot(PH,HCO3);
% hold on;
% plot(PH,H2CO3);
% plot(PH,CO3);


% plot(PH,H2CO3);
