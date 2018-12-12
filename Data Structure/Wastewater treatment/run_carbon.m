clc
clear
iter=1000;
%                                     iter=1;
S0= 26.2174;
V=1.7/2*1000000*0.00378541;  %m3
Q= 11/2*1000000*0.00378541;  %m3/d
sita=V/Q;
anss=[];
sitaxx= linspace (0.5,50,iter);
%                                   sitaxx=15;
for i=1:1:iter
    sitax=sitaxx(i);
    BOD_l1=25.38422;
    x0=[0.2,5000,1000,0.5];
%     options=optimset('Algorithm','levenberg-marquardt','maxfunevals',50000,'maxiter',20000,'TolFun',1e-20 );
    [x,fval]=fsolve(@carbon_oxidation,x0,[],sitax,BOD_l1);
    y=x.';
    y=[sitax;y];
    anss=[anss y];
end
sitax=anss(1,:);
Qw=anss(2,:);
Xa=anss(3,:);
Xi=anss(4,:);
S=anss(5,:);
Xv=Xa+Xi;
UAPs=[];
BAPs=[];
for i=1:1:iter
     Xai=Xa(i);
     UAP=-0.5*(1.8*Xai*sita+100+0.12*-3754*sita)+0.5* sqrt((1.8*Xai*sita+100+0.12*-3754*sita)^2-4*100*0.12*-3754*sita);
     BAP=-0.5*(85+(0.1-0.09)*Xai*sita)+0.5*sqrt((85+(0.1-0.09)*Xai*sita)^2+4*85*0.09*Xai*sita);
     UAPs=[UAPs UAP];
     BAPs=[BAPs BAP];
end
SMPs=UAPs+BAPs;
COD=S+15*1.42+SMPs;
O2input=Q*S0+Q*1.42*0;
O2output=Q*S+Q*SMPs+1.42*Qw*10000;
O2uptake=O2input-O2output;
% figure
subplot(2,2,1);
plot(sitax,Xv);
title('sitax,Xv');
subplot(2,2,2);
plot(sitax,Qw);
title('sitax,Qw');
subplot(2,2,3);
plot(sitax,O2uptake);
title('sitax,O2uptake');
subplot(2,2,4);
plot(sitax,S); 
title('sitax,S');
% hold on;
% plot(Qw,Xv);                                                          