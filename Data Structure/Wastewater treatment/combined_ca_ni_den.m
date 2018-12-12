%**************************************************************************
% Name : combined_ca_ni_den
% Fu n c t i o n : state the 7 equation system
% Author : Chen.Shen 2015
%**************************************************************************
function [f] =combined_ca_ni_den(x,sitax,NO3_2) 
% Solve this 7 governing eqas 
%  [Xv,R1 ]=nitrification(sitax,BOD_l1 )        
% BOD_l1=(BOD_l0-(R2+R1)*NO3_2*BODl_NO3)/(1+R2+R1);                                                                  1
% dXdt_aer=Yn_aer*Q*(1+R1+R2)*BOD_l1;                                                                                                   2
% dXdt_den=Yn_den*Q*(BOD_l0-BOD_l1*(1+R1+R2));                                                                                3
% dXdt_nit=Yn_nit*(Q*TKN_0-0.124*(dXdt_aer+dXdt_den));                                                                        4
% F=1/(Q+R1*Q+R2*Q)*(Q*TKN_0-0.124*(dXdt_aer+dXdt_den+dXdt_nit))-NO3_2;                              5
% f(1)=V*(Xi+Xa)-Qw*Xvr*sitax;                                                                                                                      6
% f(4)=K*(1+b*sitax)-(sitax*(Y*q-b)-1)*S;                                                                                                      7
% NO3_2=8 ;
V=850000*0.00378541; %m3
Q= 11.133/2*1000000*0.00378541;  %m3/d
sita=V/Q; %define
Xi0=20;  %define
 Xvr=10000; %define
BOD_l0=573.277643 ;  %define
        TKN_0=50.9;  %define
T=10; %define
q=20; %define
q=q*(1.07)^(T-20); %convert q to 10C.
K=5; %define
Y=0.45;%define
b=0.15;%define
fd=0.8;%define
%%
p=fitted_Table_10_3;  % call the function'fitted_Table_10_3' to get premeter p
% fs_nit=polyval(p(2,:),sitax);
fe=polyval(p(3,:),sitax); % for any given sitax, get the value of fe
Yn_Vss_BODl=polyval(p(4,:),sitax);% for any given sitax, get the value of Yn_Vss_BODl
NO3_BODl=polyval(p(5,:),sitax);% for any given sitax, get the value of NO3_BODl
BODl_NO3=polyval(p(6,:),sitax);% for any given sitax, get the value of BODl_NO3
N2_BODl=polyval(p(7,:),sitax);% for any given sitax, get the value of N2_BODl
NH4_BODl=polyval(p(8,:),sitax);% for any given sitax, get the value of NH4_BODl
fs0_aer=0.6;%define
fs0_nit=0.11;%define
fs0_den=0.5;%define
    b_aer=0.15;%define
    b_nit=0.1;%define
    b_den=0.15; % confirm it.
        fd_aer=0.8; % confirm it.
        fd_nit=0.8; % confirm it.
        fd_den=0.8; % confirm it.
%% calculate fs_ and Yn_
fs_aer=fs0_aer*(1+(1-fd_aer)*b_aer*sitax)/(1+b_aer*sitax); %calculate fs_aer
fs_nit=fs0_nit*(1+(1-fd_nit)*b_nit*sitax)/(1+b_nit*sitax);%calculate fs_nit
fs_den=fs0_den*(1+(1-fd_den)*b_den*sitax)/(1+b_den*sitax);%calculate fs_den
Yn_aer=0.706*fs_aer;%calculate Yn_aer
Yn_nit=8.07*fs_nit/(2.5+fs_nit);%calculate Yn_nit
Yn_den=Yn_Vss_BODl;%calculate Yn_den
%% Solve for these 7 unknowns
BOD_l1=x(1); % extract the value from x ; aspesific form when use folve
dXdt_aer=x(2);% extract the value from x
dXdt_den=x(3);% extract the value from x
dXdt_nit=x(4);% extract the value from x
R2=x(5);% extract the value from x
Qw=x(6);% extract the value from x
S=x(7);% extract the value from x
%%
 [resu]=nitrification(sitax,BOD_l1 );  
 R1=resu(1); % for any value of BOD_l1, calculate the value of R1;
 Xv=resu(2);% for any value of BOD_l1, calculate the value of Xv;
f(1)=(BOD_l0-(R2+R1)*NO3_2*BODl_NO3)/(1+R2+R1)-BOD_l1; % state the equatuin I want to solve
f(2)=Yn_aer*Q*(1+R1+R2)*BOD_l1-dXdt_aer;% state the equatuin I want to solve
f(3)=Yn_den*Q*(BOD_l0-BOD_l1*(1+R1+R2))-dXdt_den;% state the equatuin I want to solve
f(4)=Yn_nit*(Q*TKN_0-0.124*(dXdt_aer+dXdt_den))-dXdt_nit;% state the equatuin I want to solve
f(5)=1/(Q+R1*Q+R2*Q)*(Q*TKN_0-0.124*(dXdt_aer+dXdt_den+dXdt_nit))-NO3_2;% state the equatuin I want to solve
f(6)=V*(Xv)-Qw*Xvr*sitax;% state the equatuin I want to solve
f(7)=K*(1+b*sitax)-(sitax*(Y*q-b)-1)*S;% state the equatuin I want to solve
f=[f(1);f(2);f(3);f(4);f(5);f(6);f(7)]; % get the outputs
