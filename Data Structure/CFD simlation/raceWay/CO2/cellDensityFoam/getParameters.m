% this function reads growth experiment data and predict uMax and K
% it can also read CFD consumption files and predict the
% normalizationFactor

global data umax K N0 results span;

data=[0,0.0664580000000000;1284,0.113740000000000;2743,0.221511000000000;4150,0.311774500000000;5548,0.360983500000000;7070,0.392943500000000;11369,0.339868593000000];
span=linspace(0,11369,1000);

parameters0=[6.617127007498877e-4,0.412181217307836];
options = optimset('PlotFcns','optimplotfval','TolX',1e-7);
x = fminsearch(@getdiff,parameters0,options)

umax=x(1);
K=x(2) ;
N0=0.066;

%% predict NormalizationFactor
oPath=pwd;
MainPath='/home/chen/Desktop/project/231';
data=[0,0.0664580000000000;1284,0.113740000000000;2743,0.221511000000000;4150,0.311774500000000;5548,0.360983500000000;7070,0.392943500000000;11369,0.339868593000000];

cd (MainPath);
files=dir('.');
times=[];
for i=4:length(files)
    file=files(i).name;
    if (~isempty(regexp(file(1) ,'[0-9]')) && isdir(file))
        %         if (str2num(file)>78)
        times=[times convertCharsToStrings(file)];
        %         end
    end
end

celldensity=[];
consumptionRate=[];
durationTime=[];
for time=times
    cd(time);
    fid=fopen("result.txt",'r');
    str=fscanf(fid,"cellDensity=%f; totalConsumptionRate=%e; durationTime=%f;");
    celldensity=[celldensity str(1)];
    consumptionRate=[consumptionRate str(2)];
    durationTime=[durationTime str(3)];
    fclose(fid);
    cd(MainPath)
end
cd (oPath);
% global results;
results=[celldensity ;consumptionRate*1e3];
parameters0=[1.252819519042969];
options = optimset('PlotFcns','optimplotfval','TolX',1e-7);
normalizationFactor = fminsearch(@getdiff2,parameters0,options);
[t,N] = ode15s(@ode2, span, N0,[],K,results,normalizationFactor);
plot(data(:,1),data(:,2),'*-');
hold on;
plot(t,N,'o-')
 
% umax=6.617127007498877e-4;
% K =0.412181217307836;
% normalizationFactor=1.252819519042969;

 

function difference=getdiff(parameters)
global data span;
umax=parameters(1);
K=parameters(2);
N0=0.066;
[t,N] = ode15s(@ode1, span, N0,[],umax,K);
vq = interp1(t,N,data(1:end-1,1),'spline');
difference=sum(abs(vq-data(1:end-1,2)));
end

function difference=getdiff2(parameters)
global K data span results;
 
normalizationFactor=parameters;
N0=0.066;
[t,N] = ode15s(@ode2, span, N0,[],K,results,normalizationFactor);
vq = interp1(t,N,data(1:end-1,1),'spline');
difference=sum(abs(vq-data(1:end-1,2)));
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

