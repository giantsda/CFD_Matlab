% load('D:\CFD_second_HHD\02212020\130\results.mat');
close all;

U=results.U;
UCritical3=results.UCritical3;
criticalLength=results.criticalLength;
Re=results.Re;
De=results.De;
AR=results.AR;
meanMagU=results.meanMagU;
meanUx=results.meanUx;


 
plot(UCritical3(1:8));
hold on;
plot(UCritical3(9:17));
plot(UCritical3(27:35));
plot(UCritical3(36:44));
plot(UCritical3(45:53));
plot(UCritical3(54:62));

legend('1:8','9:17','27:35','36:44','45:53','54:62');
xlabel('U');
ylabel('UCritical3');



% plot(meanMagU);
% hold on;
% plot(MeanmagU);
% hold on;

% legend('meanMagU','MeanmagU');
% hold on;
% plot(U);
% plot(UCritical3);
% 
% legend('meanMagU','U','UCritical3');
% figure;
% plot(meanMagU./UCritical3);



% plot(meanMagU(1:8),'*-');
% hold on;
% plot(meanMagU(9:17),'*-');
% plot(meanMagU(18:26),'*-');
% plot(meanMagU(27:35),'*-');
% plot(meanMagU(36:44),'*-');
% plot(meanMagU(45:53),'*-');
% plot(meanMagU(54:62),'*-');
% 
% legend('1:8','9:17','18:26','27:35','36:44','45:53','54:62');
 
 