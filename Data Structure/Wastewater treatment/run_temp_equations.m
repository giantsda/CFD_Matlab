%**************************************************************************
% Name : run_combined_ca_ni_den
% Fu n c t i o n : Solve t h e equation system by fsolve for different sitax.
% Author : Chen.Shen 2015
%**************************************************************************
clc
clear
xx=[]; %initialize 
fvall=[];%initialize 
ress=[];%initialize 
x0=[120;2.1*10^6;6.1*10^5;1.4*10^5;8;128.1;0.29]; % give a initial guess
Q= 11.133/2*1000000*0.00378541;  %m3/d
sitax= 5; %solve for a certion range of sitax
    sitax
    [x,fval]=fsolve(@temp_equ,x0,[],sitax); %solve the equation systems, x is  the solution
    BOD_l1=x(1); % get the value of BOD_l1
    x_temp=[sitax; x];  % x_temp is a temp variable, used for storing the result, easy for plotting
         [ress]=nitrification(sitax,BOD_l1);% get the results for a given value of sitax and BOD_l1

%
sitax=x(1,:); % extract the results
Qw=x(6,:); % extract the results

%% 
R1=ress(1,:); % extract the results
S_C=ress(4,:); % extract the results
S_NH4=ress(5,:); % extract the results
S_NO2=ress(6,:); % extract the results
Total_effluent_TIN=S_NH4+S_NO2+x(5); % calculate the value of  Total_effluent_TKN
powe_reqire=ress(11,:);% extract the results
P=ress(12,:);% extract the results
ret=[R1 [NaN] Qw/Q  Total_effluent_TIN powe_reqire P]

