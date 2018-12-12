clc
clear
iter=3000;
sitaxx=linspace (0,20,iter);%SCATTER   65:0.1:700
ress=[]; % store result in a matrix
for i=1:1:iter
    sitax=sitaxx(i);
    [resu]=nitrification(sitax,26 );
    ress=[ress resu];
end
sitax=ress(1,:);
S_C=ress(2,:);
S_NH4=ress(3,:);
S_NO2=ress(4,:);
dXvdt_C=ress(5,:);
dXvdt_NH3=ress(6,:);
dXvdt_NO2=ress(7,:);
dXvdt_total=ress(8,:);
O2_requirement=ress(9,:);
R=ress(10,:);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(3,3,1);
plot(sitaxx,S_C);
title('sitax,S\_C');
subplot(3,3,2);
plot(sitaxx,S_NH4);
title('sitax,S\_NH4');
subplot(3,3,3);
plot(sitaxx,S_NO2);
title('sitax,S\_NO2');
subplot(3,3,4);
plot(sitaxx,dXvdt_C);
title('sitax,dXvdt\_C');
subplot(3,3,5);
plot(sitaxx,dXvdt_NH3);
title('sitax,dXvdt\_NH3');
subplot(3,3,6);
plot(sitaxx,dXvdt_NO2);
title('sitax,dXvdt\_NO2');
subplot(3,3,7);
plot(sitaxx,dXvdt_total);
title('sitax,dXvdt\_total');
subplot(3,3,8);
plot(sitaxx,O2_requirement);
title('sitax,O2\_requirement');
subplot(3,3,9);
plot(sitax,R);
title('sitax,R');

