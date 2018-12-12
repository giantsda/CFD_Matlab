%**************************************************************************
% Name : run_carbon
% Fu n c t i o n : only run the carbon oxidation system for different value
% of sita_C in order to study the impact on the performance
% Author : Chen.Shen 2015
%**************************************************************************
function run_carbon
res=[];
for sitax_C=2.5:0.01:15
    [result]=ca_ni_rea(sitax_C,20 );
    res=[res result];
end
        sitax_C=res(1,:);
        R1=res(2,:);
        Xv=res(3,:);
        O2_requirement_C=res(4,:);
        S_C=res(5,:);
        Rw_C=res(8,:);
subplot(2,2,1)
plot(sitax_C,R1);
xlabel('\theta_x_c (day)');
ylabel('Value of R1 ');
title('Value of R1');
        subplot(2,3,2)
        plot(sitax_C,Xv);
        xlabel('\theta_x_c (day)');
        ylabel('Xv (mg/L)');
        title('\theta_x vs Xv');    
subplot(2,2,2)
plot(sitax_C,O2_requirement_C/1000);
xlabel('\theta_x_c (day)');
ylabel('O2 reqirement (kg)');
title(' O2 reqirement');
        subplot(2,2,3)
        plot(sitax_C,S_C);
        xlabel('\theta_x_c (day)');
        ylabel('Concentration of substrate (mg/L)');
        title('Concentration of substrate');
subplot(2,2,4)
plot(sitax_C,Rw_C);
xlabel('\theta_x_c (day)');
ylabel('Rw_C');
title('Rw_C ');
end