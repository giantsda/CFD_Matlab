times=length(Data);
index=zeros(length(Data{1}),1);
for i=1:length(Data)
    vof=Data{i}(:,2);
    uZ=Data{i}(:,3);
    air=find(vof<0.5);
    uZ(air)=0;
    uZ=abs(uZ);
    index=index+(uZ>0.1);
end
 
