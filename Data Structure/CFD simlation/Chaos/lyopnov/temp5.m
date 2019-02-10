data=zeros(1,length(particle{1})*200);
j=1;
for i=1:100
    e=randi([1 number]);
    if length(particle{e})~=0
        yp=particle{e}(:,4);
       l=length(yp); 
       data(j:j+l-1)=yp;
       j=j+l;   
    end
end
for i=length(data):-1:1
    if data(i)~=0
        break;
    end
end
data(i+1:end)=[];


