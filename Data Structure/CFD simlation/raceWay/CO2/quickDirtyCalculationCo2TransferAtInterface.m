 %"The pond data suggest CO2 to be about 100ug/h/mg biomass, it divides slower in ponds than in ideal conditions.
% The biomass conc ranges from 30-40 to 150mg/L, they are usually diluted before they reach that.\
% Hope it helps Remember they are just quick calculations, to give you a range only"
ConsumptionRate=100e-6; % g/h/mg biomass
bioMass=80; % mg/L
waterDepthMini=0.15; %m
SMini=0.5; % m2 Surface area, which is for mini ponds;
waterDepthRW20=0.20; %m
SRW20=20; % m2 Surface area, which is for RW20;
waterDepthRW200=0.60; %m
SRW200=200; % m2 Surface area, which is for RW20;
ConsumptionRateIC=ConsumptionRate*bioMass/44; % mole of IC/L/H
PercentageFromAir=0.8; % how much IC is supplied from absorbtion from the air phase.


VMiniPonds=waterDepthMini*SMini*1000; % L Volume;
VRW20=waterDepthRW20*SRW20*1000; % L Volume;
VRW200=waterDepthRW200*SRW200*1000; % L Volume;

CO2MassTransferRate=3.6e-5; % m/s https://folk.ntnu.no/skoge/prost/proceedings/aiche-2004/pdffiles/papers/381f.pdf  3.6e-5 m/s suggested by <<Calculation of the Mass Transfer Coefficient for the Dissolution of Multiple Carbon Dioxide Bubbles in Sea Water under Varying Conditions>>
% Henry's tells us that the amount of dissolved gas in a liquid is proportional to its partial pressure above the liquid. 
henryConstantCO2=0.034; %mol/kg*bar from https://webbook.nist.gov/cgi/inchi?ID=C124389&Mask=10
CO2AirPartialPressure=0.00039212775; % bar equvilent to 3.87e-4 atm  from https://www.aqion.de/site/99
equilibriumCO2WaterConcentration=henryConstantCO2*CO2AirPartialPressure;% get mol/Kg, assume the density of water is 1KG/L, this has the units of mol/L;
%% for RW0.5
% how much IC to consume per hour;
CO2ConsumptionRateRWMini=ConsumptionRateIC*VMiniPonds;
MaxCO2AbsorbtionFromAirRWMini=CO2MassTransferRate*equilibriumCO2WaterConcentration*1000*SMini*3600; %% if the interface CO2 was 0, how much CO2 can we absorbe from air.
MaxCO2AbsorbtionFromAirRWMini/CO2ConsumptionRateRWMini*100
%% for RW20
% how much IC to consume per hour;
CO2ConsumptionRateRW20=ConsumptionRateIC*VRW20;
MaxCO2AbsorbtionFromAirRW20=CO2MassTransferRate*equilibriumCO2WaterConcentration*1000*SRW20*3600; %% if the interface CO2 was 0, how much CO2 can we absorbe from air.
 
MaxCO2AbsorbtionFromAirRW20/CO2ConsumptionRateRW20*100
%% for RW200
% how much IC to consume per hour;
CO2ConsumptionRateRW200=ConsumptionRateIC*VRW200;
MaxCO2AbsorbtionFromAirRW200=CO2MassTransferRate*equilibriumCO2WaterConcentration*1000*SRW200*3600; %% if the interface CO2 was 0, how much CO2 can we absorbe from air.

MaxCO2AbsorbtionFromAirRW200/CO2ConsumptionRateRW200*100
