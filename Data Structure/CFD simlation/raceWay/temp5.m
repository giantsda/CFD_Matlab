% % lightIntensity = [ 0,250,375,500,625,750,1000,1250,1500,2000 ];
% % growthRate= [0,210,290,350,400,420,450,460,460,460];
% % 
%  
PH= linspace(6.5,8.5,41);
y=normpdf(PH,7.5,0.2)/2;
% plot(PH,y,'*-')
y(1)=0;
y(end)=0;
% PH=[0 PH 100];
% y=[0 y 0];

plot(PH,y,'*-')

xlabel ("PH")
ylabel ("photosynthesis reaction efficiency")
% lightDepth=linspace(0,0.1,100);
% I = 1./ exp(250 .*(lightDepth)) .*1500;
% 
% plot(lightDepth,I)


% 1.215125568*161410.7742/148108.4985


%%
PH=linspace(3,14,200000);
Y=-755029+216883*PH-13958.*PH.*PH;
G=(-1.61+0.47*PH-0.03*PH.^2)/0.2308333333;
G(G<0)=0.;
% maxG=0.2308333333;
plot(PH,G)
xlabel("PH")
ylabel('consumption efficiency ');


