function [result]=carbon_oxidation(sitax_C )
sitax_C=10;
BOD_l0=500;
S0=BOD_l0;
TKN=60; %define
Xi0=25; %define
Xi0_nit=20;
V_C=100; %m3  %define
V_nit=200;
Q=500;  %m3/d   %define
sita=132/500;
T=15;  %define
%%
q=10; %define
K=10;%define
Y=0.45;%define
b=0.1;%define
fd=0.8;%define
%%
S_C=K*(1+b*sitax_C)/(Y*q*sitax_C-(1+b*sitax_C));
dXvdt_C=Q*(S0-S_C)*Y*(1+(1-fd)*b*sitax_C)/(1+b*sitax_C);% calculate t he value of dXvdt_C
dXiodt=Q*Xi0; % calculate the value of dXiodt
dXvdt_total=dXvdt_C+dXiodt;
O2_input_C=Q*(S0+Xi0*1.42);% calculate the value of O2_input
O2_output_C=Q*S_C+1.42*dXvdt_total;% calculate the value of O2_output_soluble
O2_requirement_C=O2_input_C-O2_output_C;% calculate the value of O2_requirement
Xv=dXvdt_total*sitax_C/V_C;
R1=Xv/(10000-Xv);
Qw_C=Xv*V_C/(sitax_C*10000);
result_C=[sitax_C;R1;Xv;O2_requirement_C;S_C;Qw_C]
result=result_C;






