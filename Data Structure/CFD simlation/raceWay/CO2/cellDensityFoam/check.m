plot(a(:,2) ,a(:,3),'o')


plot([0.1137 0.3137 0.414 0.514 0.6],[1.13e-6 1.319e-6 1.33e-6 1.37e-6 1.40e-6],'*-')

B=[0.1:0.1:0.5]
for i=1:length(B) 
    
DecayConstant=147.45.*B(i)-6.3909;
I = 1./ exp(DecayConstant.*(depth)) *maxLightIntensity; 
plot(depth,I);
hold on;
end
title(' 0.1 0.2 0.3 0.4 0.5 (g/L) Biomass')
xlabel('Depth(m)')
ylabel('Light intensity umol photons m-2 s-1')


maxLightIntensity = 1500;
depth=linspace(0,0.15,10000); %m
Biomass=linspace(0.05,1,10000);

rate=[];

for i=1:length(Biomass)
DecayConstant=147.45.*Biomass(i)-6.3909;
I = 1./ exp(DecayConstant.*(depth)) *maxLightIntensity; 
r=trapz(depth,I)*Biomass(i);
rate(i)=r*9e-8;
% plot(depth,I);
% ylim([0,1500]);
% title(['biomass= ' num2str(Biomass(i))])
% pause(0.001);
end
plot(Biomass,rate)
xlabel('Biomass (g/L)')
ylabel('growth rate')
% hold on;
% plot(a(:,2),a(:,3)/(max(a(:,3))/max(rate)))



