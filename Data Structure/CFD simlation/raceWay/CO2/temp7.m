% a=[];
plot(a(:,2),a(:,3));
hold on;
plot(a(:,2),a(:,9));
plot(a(:,2),a(:,15));
title ('121420 nanno ponds dataset')
legend('PH1', 'PH2', 'PH3')
xlabel('days')
ylabel('PH')
mean(a(121:185,[3 9 15]))