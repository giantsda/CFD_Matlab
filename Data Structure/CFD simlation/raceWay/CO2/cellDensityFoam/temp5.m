% data=[];
% depth=data(:,1)/100
% Light=mean(data(:,2:3),2)
% plot(depth,Light)
% cftool(depth,Light)
% celldensity=[0.045919 0.108476 0.2342245 0.4107565 0.4203445 ];
% decay=

cellDensity=[0 0.045919 0.108476 0.2342245 0.4107565 0.4203445 ];
decayConstant=[0 7.382 8.662 28.7 56.19 56.04 ];
cftool(cellDensity,decayConstant)

