for i=1:length(p1)
    mean1(i)=mean(p1(1:i,2));
end

for i=1:length(p2)
    mean2(i)=mean(p2(1:i,2));
end

for i=1:length(p3)
    mean3(i)=mean(p3(1:i,2));
end

plot(p1(:,1),p1(:,2))
hold on;
plot(p1(:,1),mean1)
plot(p2(:,1),p2(:,2))
hold on;
plot(p2(:,1),mean2)
plot(p3(:,1),p3(:,2))
hold on;
plot(p1(:,1),mean3)

xlabel('time (s)')
ylabel('abs(V) m/s')
legend('point 1','meanp1','point 2','meanp2','point 3','meanp3')





