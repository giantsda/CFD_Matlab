data=Data{end};
data(find(data(:,3)<0.9),:)=[]; % remove air
data(:,2)=data(:,2)*1000; % change m3 to liters
volume=sum(data(:,2));
data(:,4)=data(:,1).*data(:,2)*0.01; % rate*dt*volume;
Consumption=sum(data(:,4))