MainPath='D:\CFD_second_HHD\02212020\130';
close all;
cd (MainPath);
cd (num2str(13));

load('Data.mat');


meanmagU=[];
for i=1:length(Data.U)
    Us=Data.U{i};
    meanmagU(i)=mean(sqrt(Us(:,1).^2+Us(:,2).^2+Us(:,3).^2));
end
ii=find(Data.time<100); 
Data.time(ii)=[];
meanmagU(ii)=[];
plot(Data.time,meanmagU,'*-')

hold on;

radius=(max(Data.mesh(:,2))-min(Data.mesh(:,2)));
leftPoint=min(Data.mesh(:,1));
box=find(Data.mesh(:,1)<leftPoint+3*radius);
Data.mesh=Data.mesh(box,:);
Data.vof=Data.vof(box,:);
for n=1:length(Data.U)
    Data.U{n}=abs(Data.U{n}(box,3));
end
Uc3=[];

for i=1:length(Data.U)
    Us=sort(Data.U{i});
    Uc3(i)=Us(floor(length(Us)*(1-0.03)));
end

Uc3(ii)=[];
plot(Data.time,Uc3,'o-')
