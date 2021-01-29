cellDensity = 60;  % mg/L 
maxLightIntensity=1500;
lightDepth=linspace(0,0.2,1000);
I1=1./ exp(250 .*(lightDepth)) .*maxLightIntensity;
I2=1./ exp(25.*(lightDepth)) .*maxLightIntensity;
plot(lightDepth,I1);
hold on;
plot(lightDepth,I2);
plot(lightDepth,ones(length(lightDepth))*1500*0.05)
legend("lightIntensityDecayConstant=250","lightIntensityDecayConstant=25","5 Percent line");

s1=find(I1<maxLightIntensity*0.05);
s2=find(I2<maxLightIntensity*0.05);
lightDepth(s1(1))
lightDepth(s2(1))





% growthRate  =[ 0, 210, 290, 350, 400, 420, 450, 460, 460, 460 ];
% lightIntensity  =[ 0, 250, 375, 500, 625, 750, 1000, 1250, 1500, 2000 ];
% reactionRate=interp1(lightIntensity,growthRate,I)/460*5.0505e-08*132;
% % reactionRate(:)=1;
% trapz(lightDepth,reactionRate)
