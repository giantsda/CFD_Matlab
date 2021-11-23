% this function reads growth experiment data and integrate the biomass
% density
global data   K N0 results span IC03;

data=[0,0.0664580000000000;1284,0.113740000000000;2743,0.221511000000000;4150,0.311774500000000;5548,0.360983500000000;7070,0.392943500000000;11369,0.392943500000];
data=[data;14000 0.3929 ;15000 0.3929 ;18000 0.3929];

span=linspace(0,21000,5000);
 
N0=0.1137;
 
% parameters0=[1 [0.000391889356451739]];
% options = optimset('PlotFcns','optimplotfval','TolX',1e-7);
% x = fminsearch(@getdiff,parameters0,options)

 
respiration=0.00039188935;

[t,N] = ode15s(@ode2, span, N0,[],0.9225,respiration);
% plot(data(2:end,1)-1284,data(2:end,2),'*-');
hold on;
plot(t,N,'o-')
 


function difference=getdiff(parameters)
global data span N0;
umax=parameters(1);
respiration=parameters(2);
[t,N] = ode15s(@ode2, span, N0,[],umax,respiration);
vq = interp1(t,N,data(1:end-1,1),'spline');
difference=sum(abs(vq-data(1:end-1,2)));

% 
% plot(data(2:end,1)-1284,data(2:end,2),'*-');
% hold on;
% plot(t,N,'o-')

end
 
 

function r=ode2(t,N,k,respiration)
global K data span results IC03;
r=interp1(IC03(:,1),IC03(:,2),N);
r=r*k-respiration*N;
end
 