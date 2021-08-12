%The length of the straight channel does not significantly change the critical velocity,
%thus the critical vertical velocity is redefined as the 20 percent of the vertical velocity
%in the box that is defined as a rectangle of radius and 2*radius.
umax=6.617202905444628e-04;
K=0.412014908214803;
%% read data
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
celldensity=results(1,:);
consumptionRate=results(2,:);
% plot(celldensity,consumptionRate.*celldensity/0.1149*0.09695)
celldensityArray=linspace(0,K,1000);
growthRateArray=umax*(K-celldensityArray)./K.*celldensityArray;
ConsumptionArray=interp1(celldensity,consumptionRate.*celldensity,celldensityArray,'spline');
plot(celldensityArray,growthRateArray,'o-');
hold on;
plot(celldensityArray,ConsumptionArray,'*-')
normalizationFactor=ConsumptionArray(end/2)/growthRateArray(end/2);
%% Done with read file data. Now optimaze the parameters
span=[0:1:11369.00];
N0=0.066;
[t,N] = ode15s(@ode1, span, N0,[],K,results,normalizationFactor);

plot(data(:,1),data(:,2),'*-');
hold on;
plot(t,N,'o-')



function r=ode1(t,N,K,result,normalizationFactor) % it needs results to interpolate growth rate
rInterp=interp1(result(1,:),result(2,:),N,'spline','extrap');
rInterp=rInterp*N/normalizationFactor;
if N<K/2
    r=rInterp;
else
    rMiddle=interp1(result(1,:),result(2,:),K/2,'spline','extrap')*K/2/normalizationFactor;
    % model it by logisitc function that across (0,0);(K,0);(K/2,rMiddle)
    alpha=rMiddle/(K*K/4);
    r=alpha*N*(K-N);
end

end
