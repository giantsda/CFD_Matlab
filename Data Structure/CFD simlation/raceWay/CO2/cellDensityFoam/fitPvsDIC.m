a=[0,20,30,50,80,125,250,500,1000,2000,8000;0.296139000000000,0.301309090909091,0.355872727272728,0.365048484848486,0.387412121212121,0.389563636363636,0.409351515151516,0.461399999999999,0.441575757575758,0.447418181818182,0.483757575757575];
a(1,:)=a(1,:)/1000000;

plot(a(1,:),a(2,:),'r*-');
hold on;
xlabel('DIC (mol/L)');
ylabel('P rate(umol O2 L-1 ug chl a-1 s-1)');
title('P-DIC curve')
x=linspace(0,0.015,1000);
%     y=0.4587.*(1-exp(-0.0085.*x));
y2=0.4508.*x./(x+1.034e-5);
%  plot(x,y,'b')
plot(x,y2,'b')

Data121410=[84.3766666666666,87.16,115.9,180.6,283.666666666667,377.866666666667]/1000/12;
P121410=0.4508.*Data121410./(Data121410+1.034e-5);
plot(Data121410,P121410,'ko','markerSize',10,'MarkerFaceColor','k')


RacewayMediaControl=67*1000/1000000/12;
RacewayMediaControl_CO2=173*1000/1000000/12;
RacewayMediaAir=57*1000/1000000/12;

plot(RacewayMediaControl,0.4508.*RacewayMediaControl./(RacewayMediaControl+1.034e-5),'ro','markerSize',10,'MarkerFaceColor','r')
plot(RacewayMediaControl_CO2,0.4508.*RacewayMediaControl_CO2./(RacewayMediaControl_CO2+1.034e-5),'bo','markerSize',10,'MarkerFaceColor','b')
plot(RacewayMediaAir,0.4508.*RacewayMediaAir./(RacewayMediaAir+1.034e-5),'go','markerSize',10,'MarkerFaceColor','g')


legend('experimental','0.4508.*x./(x+1.034e-5)','Data121410','RacewayMediaControl','RacewayMediaControl CO2','RacewayMediaAir');

 

%  cftool(a(1,:),a(2,:))
%
%
% PH=linspace(4,11,1000);
% p=(-1.61 + 0.47 * PH - 0.03 .* PH .* PH) / 0.2308333333;
% plot(PH,p);
% xlabel("PH");
% ylabel("P rate")
%
%
