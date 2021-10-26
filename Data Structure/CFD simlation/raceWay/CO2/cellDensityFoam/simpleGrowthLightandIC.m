global data umax K N0 results span lightAbsorb Biomass;
 
data=[0,0.0664580000000000;1284,0.113740000000000;2743,0.221511000000000;4150,0.311774500000000;5548,0.360983500000000;7070,0.392943500000000;11369,0.339868593000000];
maxLightIntensity=500;
Biomass=linspace(0,1,10000);
lightAbsorb=maxLightIntensity/133.4./Biomass-maxLightIntensity*exp(-133.4.*0.15.*Biomass)./133.4./Biomass; % analytical solution
% plot(Biomass,lightAbsorb)
% xlabel('Biomass g/L')
% ylabel('lightAbsorb (integration of I over depth)')
 
lightAbsorb=lightAbsorb*9e-5;
 
% X0=[0.0665; 0.06];
span=linspace(0,21000,10000);
% 
% [t,X] = ode15s(@growthLightandN, span, X0);
% plot(data(1:end,1),data(1:end,2),'*-');
% hold on;
% plot(t,X(:,1),'ro-');
% plot(t,X(:,2),'bo-');

data=[data;14000 0.3929 ;15000 0.3929 ;18000 0.3929]
parameters0=[30.3021,0.0378,-4.4741e-05];
options = optimset('PlotFcns','optimplotfval','TolX',1e-7);

x = fminsearch(@getdiff,parameters0,options)

%%
X0=[0.0665;  0.0107];
 
k1=x(1)
k2=x(2)
k3=x(3)
k1=30.3021 ;
k2=0.0378;
k3=-4.4741e-05;


[t,X] = ode15s(@growthLightandN, span, X0,[],k1,k2,k3);

 
close all;

plot(data(1:end,1),data(1:end,2),'*-');
hold on;
plot(t,X(:,1),'ro-');
figure;
plot(t,X(:,2),'bo-');

 


function difference=getdiff(parameters)
global data span;
k1=parameters(1);
k2=parameters(2);
k3=parameters(3);
X0=[0.0665;  0.0107];
[t,X] = ode15s(@growthLightandN, span, X0,[],k1,k2,k3);

B=X(:,1);
N=X(:,2);

% plot(data(1:end,1),data(1:end,2),'*-');
% hold on;
% plot(t,X(:,1),'ro-');
% plot(t,X(:,2),'bo-');



vq = interp1(t,B,data(1:end-1,1),'spline');
difference=sum(abs(vq-data(1:end-1,2)));
end



function r=growthLightandN(t,X,k1,k2,k3)
 
global   results lightAbsorb Biomass;
B=X(1);
C=X(2);
% k3=0;
dB=(interp1(Biomass,lightAbsorb,B)*C*k1-k3)*B;
dC=-k2*dB;
r=[dB;dC];
end
 