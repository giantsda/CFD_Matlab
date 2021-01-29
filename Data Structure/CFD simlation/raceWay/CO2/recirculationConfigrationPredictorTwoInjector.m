PHData=[0,1,2,3,4,4.500,5,5.500,6,6.370,6.500,7,7.500,7.600,8,8.380,8.500,9,9.050,9.500,10,10.30,10.50,11,11.50,12,13,14];
HCO3mData=[0,0,0,0,0,0.02000,0.05000,0.1350,0.3000,0.5000,0.6000,0.8100,0.9300,0.9500,0.9700,0.9760,0.9700,0.9630,0.9620,0.8900,0.6700,0.5000,0.4000,0.1800,0.05000,0,0,0];
CO2Data=[1,1,1,1,1,0.9800,0.9500,0.8650,0.7000,0.5000,0.4000,0.1900,0.07000,0.05000,0.02000,0.01200,0.01000,0.002000,0,0,0,0,0,0,0,0,0,0];
CO32mData=[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.01000,0.01200,0.02000,0.03500,0.03800,0.1100,0.3300,0.5000,0.6000,0.8200,0.9500,1,1,1];
% plot(PHData,HCO3mData);
% hold on;
% plot(PHData,CO2Data);
% plot(PHData,CO32mData);
% legend('HCO3mData','CO2Data','CO32mData');
Kw=1e-14;%water self ionization constant
Area=0.4868; %m2
depth=0.1; %m
V=Area*depth*1000; %m3 to L
SSPH=8;
SStotalC=30/1000;%mmol/L to mol/L;
SSH=10^(-SSPH);% concentration of proton
SSOH=Kw/SSH;% concentration of OH
comsumptionRate=5.0505e-08; % mol/L/s
addProton=comsumptionRate*V; %  mol/s
addTotalC=addProton; %  mol/s
%% if:
protonInjectorflowRate=100/1000; % ml/s to L/s
speciesInjectorflowRate=[5:200:10000]; % ml/s
speciesInjectorflowRatePH=7.5;
HCO3mFraction=  interp1(PHData,HCO3mData,speciesInjectorflowRatePH);
CO2Fraction= interp1(PHData,CO2Data,speciesInjectorflowRatePH);
CO32mFraction= interp1(PHData,CO32mData,speciesInjectorflowRatePH);
result=[];
for i=1:length(flowRateArray)
    flowRate=flowRateArray(i)/1000; % ml/s to L/s
    inletTotalC=(SStotalC*flowRate+addTotalC)/flowRate;  %mol/L
    HCO3mConceration=inletTotalC*HCO3mFraction;
    CO2Conceration=inletTotalC*CO2Fraction;
    CO32mConceration=inletTotalC*CO32mFraction;
    totalHInPond=SSH*(V-flowRate)+flowRate*10^(-speciesInjectorflowRatePH)-comsumptionRate*V;
    totalOHInPond=SSH*(V-flowRate)+flowRate*Kw/10^(-speciesInjectorflowRatePH);
    
    %% water re-equilibrate step or very dilute liquid will be alkaline
    PH=4.7;
    H=totalHInPond+10^(-PH)*protonInjectorflowRate-protonInjectorflowRate*totalHInPond/V;
    OH=totalOHInPond+Kw/(10^(-PH))*protonInjectorflowRate-protonInjectorflowRate*totalHInPond/V;
    a=1;
    b=H+OH;
    c=H*OH-Kw;
    
    x1=(-b+sqrt(b*b-4*a*c))/2/a;
    x2=(-b-sqrt(b*b-4*a*c))/2/a;
    if(H+x1>0)
        x=x1;
    else
        x=x2;
    end
    H=H+x;
    OH=OH+x;
    inletPH=-log10(H)

    result(i,:)=[flowRate inletPH HCO3mConceration, CO2Conceration, CO32mConceration];
end

plot(flowRateArray,result(:,2));
hold on;
plot(flowRateArray,result(:,3));
plot(flowRateArray,result(:,4));
plot(flowRateArray,result(:,5));
legend('PH','HCO3mConceration','CO2Conceration','CO32mConceration');
xlabel('recirculation flow rate (ml/s)')

 