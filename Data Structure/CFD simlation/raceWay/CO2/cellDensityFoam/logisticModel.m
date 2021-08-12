parameters0=[6.617202905444628e-04,0.412014908214803];
options = optimset('PlotFcns','optimplotfval','TolX',1e-7);
x = fminsearch(@getdiff,parameters0,options)
data=[0,0.0664580000000000;1284,0.113740000000000;2743,0.221511000000000;4150,0.311774500000000;5548,0.360983500000000;7070,0.392943500000000;11369,0.339868593000000];
span=[0:1:11369.00];
umax=x(1);
K=x(2); 
N0=0.066;
[t,N] = ode15s(@ode1, span, N0,[],umax,K);

plot(data(:,1),data(:,2),'*-');
hold on;
plot(t,N,'o-') 

growthRate = diff(N(:))./diff(t(:));
plot(N(1:end-1),growthRate);

% growthRate = diff(data(:,2))./diff(data(:,1));
% plot(growthRate);
% x = 0.9533    0.4119


function difference=getdiff(parameters)
data=[0,0.0664580000000000;1284,0.113740000000000;2743,0.221511000000000;4150,0.311774500000000;5548,0.360983500000000;7070,0.392943500000000;11369,0.339868593000000];
span=[0 :1: 11369.00];
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
