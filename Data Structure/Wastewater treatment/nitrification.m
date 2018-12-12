%**************************************************************************
% Name : nitrification
% Fu n c t i o n : for a given value of sitax and BOF_l1, calcuate the
% value of R1, Xv, and other variables.
% Author : Chen.Shen 2015
%**************************************************************************
function [resu]=nitrification(sitax,BOD_l1 )
%                 sitax=4.2;  % used for degugging
S0=BOD_l1; %define
        TKN=50.9; %define
        P0=8.4; %define
Xi0=20; %define
V=850000*0.00378541; %m3  %define
Q= 11.133/2*1000000*0.00378541;  %m3/d   %define
T=10;  %define
sita=V/Q; %define
q=20; %define
q=q*(1.07)^(T-20); %convert q to 10C.
K=10;%define
Y=0.45;%define
b=0.15;%define
fd=0.8;%define
%%
K_NH3=0.32;%define
q_NH3=1.3;%define
Y_NH3=0.33;%define
b_NH3=0.06;%define
%%
K_NO2=0.30;%define
q_NO2=5.5;%define
Y_NO2=0.083;%define
b_NO2=0.060;%define
%%
S_C=K*(1+b*sitax)/(Y*q*sitax-(1+b*sitax)); % calculate the value of S_C
S_NH4=K_NH3*(1+b_NH3*sitax)/(Y_NH3*q_NH3*sitax-(1+b_NH3*sitax));% calculate the value of S_NH4
S_NO2=K_NO2*(1+b_NO2*sitax)/(Y_NO2*q_NO2*sitax-(1+b_NO2*sitax));% calculate the value of S_NO2
S_vector=[S_C; S_NH4;S_NO2]; % store results
%%
dXvdt_C=Q*(S0-S_C)*Y*(1+(1-fd)*b*sitax)/(1+b*sitax);% calculate the value of dXvdt_C
N1_0=TKN-dXvdt_C*0.124/Q;% calculate the value of N1_0
dXvdt_NH3=Q*(N1_0-S_NH4)*Y_NH3*(1+(1-fd)*b_NH3*sitax)/(1+b_NH3*sitax);% calculate the value of dXvdt_NH3
N2_0=N1_0-dXvdt_NH3*0.124/Q;% calculate the value of N2_0
dXvdt_NO2=Q*(N2_0-S_NO2)*Y_NO2*(1+(1-fd)*b_NO2*sitax)/(1+b_NO2*sitax);% calculate the value of dXvdt_NO2
dXiodt=Q*Xi0;% calculate the value of dXiodt
dXvdt_total=dXvdt_C+dXvdt_NH3+dXvdt_NO2+dXiodt;% calculate the value of dXvdt_total
DxvDtvector=[dXvdt_C ;dXvdt_NH3 ;dXvdt_NO2 ;dXvdt_total]; % store results
%%
O2_input=Q*(S0+TKN*4.57+Xi0*1.42);% calculate the value of O2_input
O2_output_soluble=Q*(S_C+S_NH4*4.57+S_NO2*1.14);% calculate the value of O2_output_soluble
O2_output_solid=(dXiodt*1.42+1.98*(dXvdt_C+dXvdt_NH3+dXvdt_NO2));% calculate the value of O2_output_solid
O2_requirement=O2_input-O2_output_soluble-O2_output_solid;% calculate the value of O2_requirement
powe_reqire=powerer(O2_requirement); % for any given O2_requirement, calculate the value of powee reqirement
%%
Xv=dXvdt_total*sitax/V;% calculate the value of Xv
R1=Xv/(10000-Xv);% % calculate the value of R1
%%
Xa=sitax/sita*(Y*(S0-S_C)/(1+b*sitax)+Y_NH3*(S0-S_C)/(1+b_NH3*sitax));% calculate the value of Xa
% UAP=-0.5*(1.8*Xa*sita+100+0.12*-3754*sita)+0.5* sqrt((1.8*Xa*sita+100+0.12*-3754*...
%     sita)^2-4*100*0.12*-3754*sita);% calculate the value of UAP
% BAP=-0.5*(85+(0.1-0.09)*Xa*sita)+0.5*sqrt((85+(0.1-0.09)*Xa*sita)^2+...
%     4*85*0.09*Xa*sita);% calculate the value of BAP
% SMP=UAP+BAP;% calculate the value of SMP
BOD_effluent=S_C;             %+15*fd*1.42+SMP;% calculate the value of BOD_effluent
%%
P=P0-3*0.0267*Y*(1+(1-fd)*b*sitax)*(BOD_l1-BOD_effluent)/(1+b*sitax);% calculate the value of P
    if   P<0      % if P is smaller than 0, means all the P is removed
        P=0;
    end
resu=[R1;Xv;sitax;S_vector; DxvDtvector; powe_reqire;P;BOD_effluent ]; %store results
