N=400; 
time=linspace(p1(1,1),p1(end,1),N);
groupSize=20;

v=  interp1(p1(:,1),p1(:,2),time,'spline');
mean1=[];
for i=1:length(v)
    if i<=groupSize
    mean1(i)=mean(v(1:i));
    else if i>=N-groupSize
            mean1(i)=mean(v(i:end));
        else
            mean1(i)=mean(v(i-groupSize:i+groupSize));
        end
    end
end
plot(time,v,'k-')
hold on;
plot(time,mean1,'kd')

v=  interp1(p2(:,1),p2(:,2),time,'spline');
mean1=[];
for i=1:length(v)
    if i<=groupSize
    mean1(i)=mean(v(1:i));
    else if i>=N-groupSize
            mean1(i)=mean(v(i:end));
        else
            mean1(i)=mean(v(i-groupSize:i+groupSize));
        end
    end
end
plot(time,v,'k:')
hold on;
plot(time,mean1,'k^')

v=  interp1(p3(:,1),p3(:,2),time,'spline');
mean1=[];
for i=1:length(v)
    if i<=groupSize
    mean1(i)=mean(v(1:i));
    else if i>=N-groupSize
            mean1(i)=mean(v(i:end));
        else
            mean1(i)=mean(v(i-groupSize:i+groupSize));
        end
    end
end
plot(time,v,'k--')
hold on;
plot(time,mean1,'k*')
 
xlabel('time (s)')
ylabel('abs(Velocity) m/s')
legend('point 1','local <point 1>','point 2','local <point 2>','point 3','local <point 3>')

