PHData=[0,1,2,3,4,4.500,5,5.500,6,6.370,6.500,7,7.500,7.600,8,8.380,8.500,9,9.050,9.500,10,10.30,10.50,11,11.50,12,13,14];
HCO3mData=[0,0,0,0,0,0.02000,0.05000,0.1350,0.3000,0.5000,0.6000,0.8100,0.9300,0.9500,0.9700,0.9760,0.9700,0.9630,0.9620,0.8900,0.6700,0.5000,0.4000,0.1800,0.05000,0,0,0];
CO2Data=[1,1,1,1,1,0.9800,0.9500,0.8650,0.7000,0.5000,0.4000,0.1900,0.07000,0.05000,0.02000,0.01200,0.01000,0.002000,0,0,0,0,0,0,0,0,0,0];
CO32mData=[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.01000,0.01200,0.02000,0.03500,0.03800,0.1100,0.3300,0.5000,0.6000,0.8200,0.9500,1,1,1];
% plot(PHData,HCO3mData);
% hold on;
% plot(PHData,CO2Data);
% plot(PHData,CO32mData);
% legend('HCO3mData','CO2Data','CO32mData');
SSPH=8;
SStotalC=30/1000;%mmol/L to mol/L;
SSproton=10^(-SSPH);
addProton=4.9192e-06; %  mol/s
addTotalC=4.9192e-06; %  mol/s
Area=0.4868; %m2
depth=0.1; %m
V=Area*depth*1000; %m3 to L
%% if:
flowRateArray=[5:10:1000];
result=[];
for i=1:length(flowRateArray)
    flowRate=flowRateArray(i)/1000; % ml/s to L/s
    inletPH=-log10((SSproton+addProton)/flowRate);
    inletTotalC=(SStotalC+addTotalC)/flowRate;
    HCO3mFraction=  interp1(PHData,HCO3mData,inletPH);
    CO2Fraction= interp1(PHData,CO2Data,inletPH);
    CO32mFraction= interp1(PHData,CO32mData,inletPH);
    HCO3mConceration=inletTotalC*HCO3mFraction;
    CO2Conceration=inletTotalC*CO2Fraction;
    CO32mConceration=inletTotalC*CO32mFraction;
    result(i,:)=[inletPH HCO3mConceration, CO2Conceration, CO32mConceration];
end


plot(flowRateArray,result(:,1));
hold on;
plot(flowRateArray,result(:,2));
plot(flowRateArray,result(:,3));
plot(flowRateArray,result(:,4));
legend('PH','HCO3mConceration','CO2Conceration','CO32mConceration');
xlabel('recirculation flow rate (ml/s)')




