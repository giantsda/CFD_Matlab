function logistic_plot
N=10000;
us=linspace(3.9605,3.9616,N);
for i=1:length(us)
    if mod(i,1000)==0
        i
    end
    x=0.6132554;
    temp=zeros(1,3000);
    u=us(i);
    for j=1:3000
%         if x<=0.5
%             x=u*x;
%         else
%             x=u*(1-x);
%         end
        x=u*x*(1-x);
        temp(j)=x;
    end
    p=peroid(temp);
%     if p==4
%         u
%     end
    xx=ones(1,p+1)*u;
    plot(xx,temp(end-p:end),'k.','markersize',0.0005);
    hold on;
end
title('logistic map')

function p = peroid(temp)
p=0;
for j=1:1000
    if abs(temp(end)-temp(end-j))<=0.0001
        p=j;
        break;
    end
end
if p==0
    p=300;
end













