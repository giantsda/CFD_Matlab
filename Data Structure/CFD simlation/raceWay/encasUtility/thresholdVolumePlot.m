index=[];
threshold=0.1;
for i=1:size(Data,1)
    index{i,1}=Data{i,1}*0;
end
highVZ=[];
totalV=[];
for j=1:size(Data,2)
    j
    highVZ(j)=0;
    totalV(j)=0;
    for i=1:size(Data,1)
        data=Data{i,j};
        lengthI=length(data);
        water=data(find(data(:,2)>0.9),:);
        highVZ(j)=highVZ(j)+length(find(abs(water(:,1))<threshold));
        totalV(j)=totalV(j)+length(water);
    end
end
plot(linspace(1.00218e+02,1.72218e+02,481),highVZ./totalV,'k*-')
   
title('volume percentage of abs(Vz)>0.1')
xlabel('flow time (s)');
ylabel('%');


