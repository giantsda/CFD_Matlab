global data umax K N0 results span lightAbsorb Biomass;

data=[0,0.0664580000000000;1284,0.113740000000000;2743,0.221511000000000;4150,0.311774500000000;5548,0.360983500000000;7070,0.392943500000000;11369,0.339868593000000];
span=linspace(0,11369,100000);
  
% results=[celldensity ;consumptionRate*1e3];
results=[0.00400000000000000,0.00800000000000000,0.0120000000000000,0.0160000000000000,0.0200000000000000,0.0240000000000000,0.0280000000000000,0.0320000000000000,0.0360000000000000,0.0400000000000000,0.0440000000000000,0.0480000000000000,0.0520000000000000,0.0560000000000000,0.0600000000000000,0.0640000000000000,0.0680000000000000,0.0720000000000000,0.0760000000000000,0.0800000000000000,0.0840000000000000,0.0880000000000000,0.0920000000000000,0.0960000000000000,0.100000000000000,0.104000000000000,0.108000000000000,0.112000000000000,0.116000000000000,0.120000000000000,0.124000000000000,0.128000000000000,0.132000000000000,0.136000000000000,0.140000000000000,0.144000000000000,0.148000000000000,0.152000000000000,0.156000000000000,0.160000000000000,0.164000000000000,0.168000000000000,0.172000000000000,0.176000000000000,0.180000000000000,0.184000000000000,0.188000000000000,0.192000000000000,0.196000000000000,0.200000000000000,0.204000000000000,0.208000000000000,0.212000000000000,0.216000000000000,0.220000000000000,0.224000000000000,0.228000000000000,0.232000000000000,0.236000000000000,0.240000000000000,0.244000000000000,0.248000000000000,0.252000000000000,0.256000000000000,0.260000000000000,0.264000000000000,0.268000000000000,0.272000000000000,0.276000000000000,0.280000000000000,0.284000000000000,0.288000000000000,0.292000000000000,0.296000000000000,0.300000000000000,0.304000000000000,0.308000000000000,0.312000000000000,0.316000000000000,0.320000000000000,0.324000000000000,0.328000000000000,0.332000000000000,0.336000000000000,0.340000000000000,0.344000000000000,0.348000000000000,0.352000000000000,0.356000000000000,0.360000000000000,0.364000000000000,0.368000000000000,0.372000000000000,0.376000000000000,0.380000000000000,0.384000000000000,0.388000000000000,0.392000000000000,0.396000000000000;0.000713971000000000,0.000713971000000000,0.000713971000000000,0.000713971000000000,0.000713971000000000,0.000713971000000000,0.000713971000000000,0.000713971000000000,0.000713971000000000,0.000713971000000000,0.000713971000000000,0.000713971000000000,0.000713967200000000,0.000713033300000000,0.000711259100000000,0.000709040300000000,0.000705652600000000,0.000701456100000000,0.000696844700000000,0.000691895900000000,0.000686619300000000,0.000680547400000000,0.000673353500000000,0.000665266500000000,0.000656457100000000,0.000647033100000000,0.000637327100000000,0.000627389500000000,0.000616974900000000,0.000606322100000000,0.000595626400000000,0.000585022400000000,0.000574055600000000,0.000563261800000000,0.000552240100000000,0.000541383400000000,0.000530747500000000,0.000520205000000000,0.000509678200000000,0.000499661100000000,0.000489593900000000,0.000479882700000000,0.000470293600000000,0.000460972300000000,0.000451921900000000,0.000443182400000000,0.000434785400000000,0.000426715100000000,0.000418601100000000,0.000410663300000000,0.000403014600000000,0.000395718600000000,0.000388736200000000,0.000381784700000000,0.000375067100000000,0.000368644500000000,0.000362504900000000,0.000356447600000000,0.000350441200000000,0.000344602700000000,0.000338863400000000,0.000333350900000000,0.000328062600000000,0.000322987900000000,0.000318116100000000,0.000313334500000000,0.000308712100000000,0.000304269800000000,0.000299999700000000,0.000295811800000000,0.000291691600000000,0.000287721800000000,0.000283863000000000,0.000280014700000000,0.000276211800000000,0.000272509600000000,0.000268935500000000,0.000265484500000000,0.000262152100000000,0.000258933400000000,0.000255823600000000,0.000252818100000000,0.000249913000000000,0.000247103600000000,0.000244326000000000,0.000241582300000000,0.000238914300000000,0.000236252700000000,0.000233647000000000,0.000231093900000000,0.000228616000000000,0.000226212400000000,0.000223880800000000,0.000221618200000000,0.000219422300000000,0.000217290400000000,0.000215217000000000,0.000213179000000000,0.000211195100000000];
 
% celldensity=results(1,:);
% consumptionRate=results(2,:).*celldensity;
% plot(celldensity,consumptionRate)



maxLightIntensity = 1500;
depth=linspace(0,0.15,100000); %m


Biomass=1;

DecayConstant=133.4.*Biomass+0.008346;
I = 1./ exp(DecayConstant.*(depth)) *maxLightIntensity; 
lightAbsorb=trapz(depth,I)*Biomass;
plot(depth,I)
lightAbsorb
Biomass=linspace(0,1,10000);
lightAbsorb=maxLightIntensity/133.4./Biomass-maxLightIntensity*exp(-133.4.*0.15.*Biomass)./133.4./Biomass; % analytical solution
plot(Biomass,lightAbsorb.*Biomass)
xlabel('Biomass g/L')
ylabel('lightAbsorb (integration of I over depth)')
 
r=lightAbsorb*9e-8;
 
N0=0.0665;
[t,N] = ode15s(@growth, span, N0);
plot(data(1:end,1),data(1:end,2),'*-');
hold on;
plot(t,N,'o-')


function r=growth(t,N)
global   results lightAbsorb Biomass;
r=interp1(Biomass,lightAbsorb,N);
r=r*0.55*1e-5*N;
end




 