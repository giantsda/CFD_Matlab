% biomassS=linspace(0.04,0.4,1000);
% depth=linspace(0,0.2,1000);
% 
% rate=[];
% for i=1:length(biomassS)
%     biomass=biomassS(i);
%     DecayConstant=biomass * 147.45 - 6.3909
%     I= 1./ exp( DecayConstant.*(depth)) .*1500;
%     IntegrationI=trapz(depth,I);
%     
%     rate(i)=IntegrationI*biomass;
%     
%     
% end
plot(biomassS,rate);
hold on;
plot(a(:,2),a(:,3)*mean(rate)/mean(a(:,3)))