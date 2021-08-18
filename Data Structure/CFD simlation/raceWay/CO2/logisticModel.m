parameters0=[3.5,3];
options = optimset('PlotFcns','optimplotfval','TolX',1e-7);
x = fminsearch(@getdiff,parameters0,options)
data=[0,0.0664580000000000;0.890000000000000,0.113740000000000;1.90000000000000,0.221511000000000;2.88000000000000,0.311774500000000;3.85000000000000,0.360983500000000;4.91000000000000,0.392943500000000;7.90000000000000,0.339868593000000];

span=[0:0.1:8];
umax=x(1);
K=x(2); 
N0=0.066;
[t,N] = ode15s(@ode1, span, N0,[],umax,K);

plot(data(:,1),data(:,2),'*-');
hold on;
plot(t,N,'o-') 

growthRate = diff(N(:))./diff(t(:));
plot(growthRate);

% growthRate = diff(data(:,2))./diff(data(:,1));
% plot(growthRate);



function difference=getdiff(parameters)
data=[0,0.0664580000000000;0.890000000000000,0.113740000000000;1.90000000000000,0.221511000000000;2.88000000000000,0.311774500000000;3.85000000000000,0.360983500000000;4.91000000000000,0.392943500000000;7.90000000000000,0.339868593000000];
span=[0 8];
umax=parameters(1);
K=parameters(2);
N0=0.066;
[t,N] = ode15s(@ode1, span, N0,[],umax,K);
vq = interp1(t,N,data(1:end-1,1),'spline');
difference=sum(abs(vq-data(1:end-1,2)));
end

function r=ode1(t,N,umax,K)
r=umax*(K-N)/K*N;
end
