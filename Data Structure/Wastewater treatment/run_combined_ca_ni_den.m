%**************************************************************************
% Name : run_combined_ca_ni_den
% Fu n c t i o n : Solve t h e equation system by fsolve for different sitax.
% Author : Chen.Shen 2015
%**************************************************************************
xx=[]; %initialize 
fvall=[];%initialize 
ress=[];%initialize 
x0=[120;2.1*10^6;6.1*10^5;1.4*10^5;2.2;128.1;0.29]; % give a initial guess
Q= 11.133/2*1000000*0.00378541;  %m3/d
for sitax= 0:1:30 %solve for a certion range of sitax
    sitax
    [x,fval]=fsolve(@combined_ca_ni_den,x0,[],sitax,12); %solve the equation systems, x is  the solution
    BOD_l1=x(1); % get the value of BOD_l1
    x_temp=[sitax; x];  % x_temp is a temp variable, used for storing the result, easy for plotting
    xx=[xx x_temp]; % store the data into xx,easy for plotting
    fvall=[fvall fval]; % store the resident into fvall, for debugging 
                   [resu]=nitrification(sitax,BOD_l1);% get the results for a given value of sitax and BOD_l1
                    ress=[ress resu];% store the data into ress,easy for plotting
end
%
sitax=xx(1,:); % extract the results
R2=xx(6,:); % extract the results
Qw=xx(7,:); % extract the results
%% 
R1=ress(1,:); % extract the results
S_C=ress(4,:); % extract the results
S_NH4=ress(5,:); % extract the results
S_NO2=ress(6,:); % extract the results
Total_effluent_TIN=S_NH4+S_NO2+12; % calculate the value of  Total_effluent_TKN
powe_reqire=ress(11,:);% extract the results
P=ress(12,:);% extract the results
%%
% % plot figures
figure;
subplot(2,3,1);
plot(sitax,R1,sitax,R2);
xlabel('\theta_x (day)');
ylabel('Value of R1 and R2');
legend('R1','R2');
title('Value of R1 R2');
subplot(2,3,2);
plot(sitax,Qw/Q);
xlabel('\theta_x (day)');
ylabel('Value of Rw');
title('ratio of Waste flow ');
subplot(2,3,3);
plot(sitax,S_C);
xlabel('\theta_x (day)');
ylabel('Concentration of substrate (mg/L)');
title('Concentration of substrate');
subplot(2,3,4);
plot(sitax,Total_effluent_TIN);
xlabel('\theta_x (day)');
ylabel('Total effluent TIN (mg/L)');
title('Total effluent TIN');
subplot(2,3,5);
plot(sitax,powe_reqire);
xlabel('\theta_x (day)');
ylabel('powe reqirement (kw)');
title(' powe reqirement');
subplot(2,3,6);
plot(sitax,P);
title('Concentration of P');
xlabel('\theta_x (day)');
ylabel('Concentration of P (mg/L)');
suptitle ('Baseline  0% removal of NH4+ and 0% removal of P in centrate ')
%             figure
%             Xv=ress(2,:);
%             plot(sitax,Xv);
%             xlabel('\theta_x (day)');
%             ylabel('Xv (mg/L)');
%             title('\theta_x vs Xv');
%             ylim([0 9900])
