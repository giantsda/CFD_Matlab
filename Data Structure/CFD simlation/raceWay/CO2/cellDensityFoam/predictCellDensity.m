% run getParameters.m first to get parameters first
K =0.412181217307836;
normalizationFactor=1.252819519042969;
span=linspace(0,11369,1000);


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
global results;
results=[celldensity ;consumptionRate*1e3*0.82];
results(2,:)=results(2,:);
N0=0.066;
[t1,N1] = ode15s(@ode2, span, N0,[],K,results,normalizationFactor);
plot(data(:,1),data(:,2),'*-');
hold on;
plot(t1,N1)
xlabel('time(min)');
ylabel('Biomass (g/L)')


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










