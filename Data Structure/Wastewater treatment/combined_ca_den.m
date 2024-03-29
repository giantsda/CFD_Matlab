function [f] =combined_ca_den(x,sitax)
NO3_2=5;
V=1.7/2*1000000*0.00378541;  %m3
Q= 11/2*1000000*0.00378541;  %m3/d
        sita=V/Q;
        Xi0=20;
        q=20;
        K=5;
        Y=0.45;
        b=0.15;
        fd=0.8;
        T=323; 
 Xvr=10000;
BOD_l0=300;
TKN_0=42.4;
%%
p=fitted_Table_10_3;
% fs_nit=polyval(p(2,:),sitax);
fe=polyval(p(3,:),sitax);
Yn_Vss_BODl=polyval(p(4,:),sitax);
NO3_BODl=polyval(p(5,:),sitax);
BODl_NO3=polyval(p(6,:),sitax);
N2_BODl=polyval(p(7,:),sitax);
NH4_BODl=polyval(p(8,:),sitax);
fs0_aer=0.6;
fs0_nit=0.11;
fs0_den=0.5;
    b_aer=0.15;
    b_nit=0.1;
    b_den=0.15; % confirm it.
        fd_aer=0.8; % confirm it.
        fd_nit=0.8; % confirm it.
        fd_den=0.8; % confirm it.
%% calculate fs_ and Yn_
fs_aer=fs0_aer*(1+(1-fd_aer)*b_aer*sitax)/(1+b_aer*sitax);
fs_nit=fs0_nit*(1+(1-fd_nit)*b_nit*sitax)/(1+b_nit*sitax);
fs_den=fs0_den*(1+(1-fd_den)*b_den*sitax)/(1+b_den*sitax);
Yn_aer=0.706*fs_aer;
Yn_nit=8.07*fs_nit/(2.5+fs_nit);
Yn_den=Yn_Vss_BODl;
%% Solve for these 10 unknowns
BOD_l1=x(1);
dXdt_aer=x(2);
dXdt_den=x(3);
dXdt_nit=x(4);
R1=x(5);
R2=x(6);
Qw=x(7);
Xa=x(8);
Xi=x(9);
S=x(10);
%%
% 10 governing eqas 
% BOD_l1=(BOD_l0-(R2+R1)*NO3_2*BODl_NO3)/(1+R2+R1);
% dXdt_aer=Yn_aer*Q*(1+R1+R2)*BOD_l1;
% dXdt_den=Yn_den*Q*(BOD_l0-BOD_l1*(1+R1+R2));
% dXdt_nit=Yn_nit*(Q*TKN_0-0.124*(dXdt_aer+dXdt_den));
% F=1/(Q+R1*Q+R2*Q)*(Q*TKN_0-0.124*(dXdt_aer+dXdt_den+dXdt_nit))-NO3_2;
% R1=(Xa+Xi)/(Xv_r-(Xa+Xi));
% f(1)=V*(Xi+Xa)-Qw*Xvr*sitax;
% f(2)=sitax*Y*(BOD_l1-S)/(1+b*sitax)-sita*Xa;
% f(3)= sitax*(Xi0+Xa*(1-fd)*b*sita)-sita*Xi;
% f(4)=K*(1+b*sitax)-(sitax*(Y*q-b)-1)*S;
f(1)=(BOD_l0-(R2+R1)*NO3_2*BODl_NO3)/(1+R2+R1)-BOD_l1;
f(2)=Yn_aer*Q*(1+R1+R2)*BOD_l1-dXdt_aer;
f(3)=Yn_den*Q*(BOD_l0-BOD_l1*(1+R1+R2))-dXdt_den;
f(4)=Yn_nit*(Q*TKN_0-0.124*(dXdt_aer+dXdt_den))-dXdt_nit;
f(5)=(Xa+Xi)/(Xvr-(Xa+Xi))-R1;
f(6)=1/(Q+R1*Q+R2*Q)*(Q*TKN_0-0.124*(dXdt_aer+dXdt_den+dXdt_nit))-NO3_2;
f(7)=V*(Xi+Xa)-Qw*Xvr*sitax;
f(8)=sitax*Y*(BOD_l1-S)/(1+b*sitax)-sita*Xa;
f(9)=sitax*(Xi0+Xa*(1-fd)*b*sita)-sita*Xi;
f(10)=K*(1+b*sitax)-(sitax*(Y*q-b)-1)*S;
f=[f(1);f(2);f(3);f(4);f(5);f(6);f(7);f(8);f(9);f(10)];
