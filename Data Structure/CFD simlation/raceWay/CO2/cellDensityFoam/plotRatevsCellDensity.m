% run getParameters.m first

%% logistic model
celldensityArray=linspace(0,K,1000);
growthRateArray=umax*(K-celldensityArray)./K.*celldensityArray;
plot(celldensityArray,growthRateArray,'*-');
hold on;
%% useConcumptionRate
for i=1:length(celldensityArray)
    N=celldensityArray(i);
    consumptionRate(i)=getRate(N,normalizationFactor);
end
plot(celldensityArray,consumptionRate,'o-');
xlabel('cellDensity (g/L)');
ylabel('growthRate (g/Ls)')
legend('logistic model','using CFD')
figure;
data=[0,0.0664580000000000;1284,0.113740000000000;2743,0.221511000000000;4150,0.311774500000000;5548,0.360983500000000;7070,0.392943500000000;11369,0.339868593000000];
span=linspace(0,11369,1000);
[t,N] = ode15s(@ode1, span, N0,[],umax,K);
plot(data(:,1),data(:,2),'*-','MarkerSize',8);
hold on;
plot(t,N,'o-','MarkerSize',3);
[t,N] = ode15s(@ode2, span, N0,[],K,results,normalizationFactor);
plot(t,N,'>-','MarkerSize',3);
legend('expeerimental','logistic model','using CFD')







function r=getRate(N,normalizationFactor)
global results K;
rInterp=interp1(results(1,:),results(2,:),N,'spline','extrap');
rInterp=rInterp*N/normalizationFactor;
if N<K/2
    r=rInterp;
else
    rMiddle=interp1(results(1,:),results(2,:),K/2,'spline','extrap')*K/2/normalizationFactor;
    % model it by logisitc function that across (0,0);(K,0);(K/2,rMiddle)
    alpha=rMiddle/(K*K/4);
    r=alpha*N*(K-N);
end
end



function r=ode1(t,N,umax,K)
r=umax*(K-N)/K*N;
end

function r=ode2(t,N,K,results,normalizationFactor) % it needs results to interpolate growth rate

rInterp=interp1(results(1,:),results(2,:),N,'spline','extrap');
rInterp=rInterp*N/normalizationFactor;
if N<K/2
    r=rInterp;
else
    rMiddle=interp1(results(1,:),results(2,:),K/2,'spline','extrap')*K/2/normalizationFactor;
    % model it by logisitc function that across (0,0);(K,0);(K/2,rMiddle)
    alpha=rMiddle/(K*K/4);
    r=alpha*N*(K-N);
end

end

