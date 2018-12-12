%**************************************************************************
% Name : run_for_different_NO3_2.m
% Fu n c t i o n : f run for different value of NO3_2 to determine the best NO3_2
%value
% Author : Chen.Shen 2015
%**************************************************************************
xx=[];%initialize 
fvall=[];%initialize 
ress=[];%initialize 
x0=[120;2.1*10^6;6.1*10^5;1.4*10^5;2.2;128.1;0.29];% give a initial guess
sitax=15; % set the value of sitax, determine the best value of NO3_2
for NO3_2= 5: 0.1 :15%solve for a certion range of NO3_2
    NO3_2
    [x,fval]=fsolve(@combined_ca_ni_den,x0,[],sitax,NO3_2); %solve the equation systems, x is  the solution
    BOD_l1=x(1); % extract the value of BOD_l1
    x_temp=[sitax; x];% x_temp is a temp variable, used for storing the result, easy for plotting
    xx=[xx x_temp]; % store the data into xx,easy for plotting
    fvall=[fvall fval];% store the resident into fvall, for debugging 
                   [resu]=nitrification(sitax,BOD_l1);% get the results for a given value of sitax and BOD_l1
                    ress=[ress resu];% store the data into ress,easy for plotting
end
%%
NO3_2= 5: 0.1 :15;
sitax=xx(1,:);% extract the results
BOD_l1=xx(2,:);% extract the results
R2=xx(6,:);% extract the results
plot(NO3_2, R2)% plot the figure
ylim([0 6]);
title ('value of R2 for different NO3_2 value');
xlabel('concentration of NO3_2 (mg/L)');
ylabel('R2');