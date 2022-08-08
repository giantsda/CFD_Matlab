% this function reads growth experiment data and predict uMax and K
% it can also read CFD consumption files and predict the
% normalizationFactor
global data umax K N0 results span waterDepth DIC DICEfficiency;
waterDepth=waterDepthDummy;
data=[0,0.0664580000000000;1284,0.113740000000000;2743,0.221511000000000;4150,0.311774500000000;5548,0.360983500000000;7070,0.392943500000000;11369,0.3929;15000,0.3929;20000,0.3929];
DIC=[0	0.00703138888888888;1281.60000000000	0.00726333333333333;2736.00000000000	0.00965833333333333;4147.20000000000	0.0150500000000000;5544	0.0236388888888889; 7070.40000000000	0.0314888888888889;20000 0.0315;30000 0.0315];
DICEfficiency=[0, 0.0003537, 0.00099678, 0.0019614, 0.0079743, 0.01395498, 0.021929,0.029871, 0.037878, 1; 0    0.7360    0.7949    0.8296    0.8718    0.9110    0.9201    0.9623    1.0000    1.0000].';
span=linspace(0,21369,100000);
options = optimset('PlotFcns','optimplotfval','TolX',1e-7);

parameters0=[0.00196953726649683,0.000509894773555901];
 
% parameters0 = fminsearch(@getdiff,parameters0,options);
uMax=parameters0(1);
uRes=parameters0(2);
N0=0.066;
[t,N] = ode15s(@ode1, span, N0,[],uMax,uRes);
plot(data(:,1),data(:,2),'*-');
hold on;
% plot(t,N)
plot(A(:,1),A(:,2),'o-')
rate=diff(N)./diff(t);


function difference=getdiff(parameters)
global K data span results waterDepth;

uMax=parameters(1);
uRes=parameters(2);
N0=0.066;
[t,N] = ode15s(@ode1, span, N0,[],uMax,uRes);
vq = interp1(t,N,data(1:end-1,1),'spline');
difference=sum(abs(vq-data(1:end-1,2)));
% plot(data(:,1),data(:,2),'*-');
% hold on;
% plot(t,N)
end


function r=ode1(t,B,uMax,uRes)
global waterDepth DIC DICEfficiency;
if t>15000
    a=1;
end
V=73.02; %L
H=0.14; %Depth= 0.15m;
rateS=[];
dS=[];
lightIntensityDecayConstant = B * 133.4;
maxLightIntensity = 1500;
DICi=interp1(DIC(:,1),DIC(:,2),t);
DICEfficiencyi=interp1(DICEfficiency(:,1),DICEfficiency(:,2),DICi);

I=1./exp( lightIntensityDecayConstant*(waterDepth)) *maxLightIntensity;
Pefficiency=1;
reactionRate = tanh(I/505.3)*Pefficiency*DICEfficiencyi*uMax*B-uRes*B;

r=mean(reactionRate);
% r
% plot(dS,rateS)
end








