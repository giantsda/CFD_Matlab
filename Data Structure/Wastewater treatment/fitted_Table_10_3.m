%**************************************************************************
% Name : fitted_Table_10_3
% Fu n c t i o n : fit the Table_10_3 so I can get the value for any sitax
% Author : Chen.Shen 2015
%**************************************************************************
function [p new]=fitted_Table_10_3
% this funtion will give me the premeter vector of polynomial curve fitting
% of Table_10_3 use polyval(p(i,:),sitax); to Call the fitted values
Table_10_3=.....       % read the data
[5 0.44 0.56 0.31 0.20 5.07 0.20 -0.003;
10 0.38 0.62 0.27 0.22 4.62 0.22 0.002;
12 0.36 0.64 0.26 0.22 4.49 0.22 0.003;
14 0.35 0.65 0.25 0.23 4.39 0.23 0.004;
16 0.34 0.66 0.24 0.23 4.30 0.23 0.006;
20 0.31 0.69 0.22 0.24 4.15 0.24 0.008;
25 0.29 0.71 0.20 0.25 4.02 0.25 0.010;
30 0.27 0.73 0.19 0.26 3.92 0.26 0.011;
40 0.24 0.76 0.17 0.27 3.77 0.27 0.014;
50 0.22 0.78 0.16 0.27 3.68 0.27 0.016;
100 0.17 0.83 0.12 0.29 3.46 0.29 0.020;
];
p=[]; % initialize
new=[]; % initialize
sitax = linspace(0,100,500); 
for i=1:1:7
    p(i+1,:) = polyfit(Table_10_3(:,1),Table_10_3(:,i+1),4); % fit for every curve, get the premeter
    new(:,i+1) = polyval(p(i+1,:),sitax);
end
% subplot(3,3,1)
% plot(Table_10_3(:,1),Table_10_3(:,2),'*',sitax,new(:,2));
% xlabel ('\theta x');
% xlim([0 50])
% ylabel ('f_s');
% legend('original data','fitted curve')
%         subplot(3,3,2)
%         plot(Table_10_3(:,1),Table_10_3(:,3),'*',sitax,new(:,3));
%         xlabel ('\theta x');
%         xlim([0 50])
%         ylabel ('f_e');
%         legend('original data','fitted curve')
% subplot(3,3,3)
% plot(Table_10_3(:,1),Table_10_3(:,4),'*',sitax,new(:,4));
% xlabel ('\theta x');
% xlim([0 50])
% ylabel ('Y_n_(_d_e_n_)');
% legend('original data','fitted curve')
%         subplot(3,3,4)
%         plot(Table_10_3(:,1),Table_10_3(:,5),'*',sitax,new(:,5));
%         xlabel ('\theta x');
%         xlim([0 50])
%         ylabel ('NO3- over BODl');
%         legend('original data','fitted curve')
% subplot(3,3,5)
% plot(Table_10_3(:,1),Table_10_3(:,6),'*',sitax,new(:,6));
% xlabel ('\theta x');
% xlim([0 50])
% ylabel ('BODl over NO3-');
% legend('original data','fitted curve')
%         subplot(3,3,6)
%         plot(Table_10_3(:,1),Table_10_3(:,7),'*',sitax,new(:,7));
%         xlabel ('\theta x');
%         xlim([0 50])
%         ylabel ('N2 over BODl');
%         legend('original data','fitted curve')
% subplot(3,3,7)
% plot(Table_10_3(:,1),Table_10_3(:,8),'*',sitax,new(:,8));
% xlabel ('\theta x');
% xlim([0 50])
% ylabel ('NH4+ over BODl');
% legend('original data','fitted curve')
% suptitle('fitted data vs original data')
new(:,1)=sitax.';
