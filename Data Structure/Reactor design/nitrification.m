% function [result]=nitrification(sitax_C,sitax_nit )
sitax_C=22;
sitax_nit=20;
BOD_l0=500;
S0=BOD_l0;
TKN=60; %define
Xi0=25; %define
Xi0_nit=20;
V_C=100; %m3  %define
V_nit=200;
Q=500;  %m3/d   %define
T=15;  %define
%%
q=10; %define
K=10;%define
Y=0.45;%define
b=0.1;%define
fd=0.8;%define
%%
K_NH3=0.57;%define
q_NH3=1.7;%define
Y_NH3=0.33;%define
b_NH3=0.082;%define
%%
K_NO2=0.62;%define
q_NO2=7.3;%define
Y_NO2=0.083;%define
b_NO2=0.082;%define
%%
% S_C=K*(1+b*sitax_C)/(Y*q*sitax_C-(1+b*sitax_C));
S_NH4=K_NH3*(1+b_NH3*sitax_nit)/(Y_NH3*q_NH3*sitax_nit-(1+b_NH3*sitax_nit));% calculate the value of S_NH4
S_NO2=K_NO2*(1+b_NO2*sitax_nit)/(Y_NO2*q_NO2*sitax_nit-(1+b_NO2*sitax_nit));% calculate the value of S_NO2
%%
S_C=K*(1+b*sitax_C)/(Y*q*sitax_C-(1+b*sitax_C));
dXvdt_C=Q*(S0-S_C)*Y*(1+(1-fd)*b*sitax_C)/(1+b*sitax_C); % calculate t he value of dXvdt_C
%%
%nitrification
dXi0dt_nit=0.2*Xi0_nit*Q;
dXa0dt_nit=0.8*Xi0_nit*Q;
dXadt_res=dXa0dt_nit/(1+b*sitax_nit);
dXidt_inc=0.2*(dXa0dt_nit-dXadt_res);
dXvdt_res=dXi0dt_nit+dXadt_res+dXidt_inc;
dN1dt_inc=0.124*(dXa0dt_nit-dXadt_res-dXidt_inc);
N1_0=TKN-dXvdt_C*0.124/Q+dN1dt_inc/Q;% calculate the value of N1_0
dXvdt_NH3=Q*(N1_0-S_NH4)*Y_NH3*(1+(1-fd)*b_NH3*sitax_nit)/(1+b_NH3*sitax_nit);% calculate the value of dXvdt_NH3
N2_0=N1_0-dXvdt_NH3*0.124/Q;% calculate the value of N2_0
dXvdt_NO2=Q*(N2_0-S_NO2)*Y_NO2*(1+(1-fd)*b_NO2*sitax_nit)/(1+b_NO2*sitax_nit);% calculate the value of dXvdt_NO2
dXvdt_nit_total=dXvdt_res+dXvdt_NH3+dXvdt_NO2;
 O2_input_nit=Q*(4.57*N1_0+1.42*0.2*Xi0_nit+1.98*0.8*Xi0_nit );% calculate the value of O2_input
 O2_output_soluble_nit=Q*(S_NH4*4.57+S_NO2*1.14);% calculate the value of O2_output_soluble
O2_output_solid_nit=(dXi0dt_nit*1.42+1.98*(dXadt_res+dXidt_inc+dXvdt_NH3+dXvdt_NO2));% calculate the value of O2_output_solid
O2_requirement_nit=O2_input_nit-O2_output_soluble_nit-O2_output_solid_nit;% calculate the value of O2_requirement
Xv_nit=dXvdt_nit_total*sitax_nit/V_nit;
R2=Xv_nit/(5000-Xv_nit);
Qw_nit=Xv_nit*V_nit/(sitax_nit*10000);
Total_effluent_TKN=S_NH4/18*14+S_NO2/(14+32)*14+8; % calculate the value of  Total_effluent_TKN
result_nit=[sitax_nit;R2;Xv_nit;O2_requirement_nit;Total_effluent_TKN;Qw_nit];
result=result_nit;

















