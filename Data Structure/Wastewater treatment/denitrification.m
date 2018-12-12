function [F, BOD_l1]= denitrification (R2)
% solve for R2
%define premeters
% R2=5.37;%%%%%%%%%%%%
% sitax=15;
BOD_l0=300;
TKN_0=42.4;
V=1.7/2*1000000*0.00378541;  %m3
Q= 11/2*1000000*0.00378541;  %m3/d
R1=0.867;% will change? confirm.
NO3_2=5;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
p=fitted_Table_10_3;
fs_nit=polyval(p(2,:),sitax);
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
% calculate fs_ and Yn_
fs_aer=fs0_aer*(1+(1-fd_aer)*b_aer*sitax)/(1+b_aer*sitax);
fs_nit=fs0_nit*(1+(1-fd_nit)*b_nit*sitax)/(1+b_nit*sitax);
fs_den=fs0_den*(1+(1-fd_den)*b_den*sitax)/(1+b_den*sitax);
Yn_aer=0.706*fs_aer;
Yn_nit=8.07*fs_nit/(2.5+fs_nit);
Yn_den=Yn_Vss_BODl;
%calcuate dXdt and BOD_l1
BOD_l1=(BOD_l0-(R2+R1)*NO3_2*BODl_NO3)/(1+R2+R1);
dXdt_aer=Yn_aer*Q*(1+R1+R2)*BOD_l1;
dXdt_den=Yn_den*Q*(BOD_l0-BOD_l1*(1+R1+R2));
dXdt_nit=Yn_nit*(Q*TKN_0-0.124*(dXdt_aer+dXdt_den));
NO3_2_cal=1/(Q+R1*Q+R2*Q)*(Q*TKN_0-0.124*(dXdt_aer+dXdt_den+dXdt_nit));
F=NO3_2_cal-NO3_2;
% end
