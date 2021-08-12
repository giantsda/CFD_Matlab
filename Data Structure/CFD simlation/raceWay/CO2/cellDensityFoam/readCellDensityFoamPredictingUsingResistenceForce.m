%The length of the straight channel does not significantly change the critical velocity,
%thus the critical vertical velocity is redefined as the 20 percent of the vertical velocity
%in the box that is defined as a rectangle of radius and 2*radius.

%% read data
oPath=pwd;
MainPath='/home/chen/Desktop/project/231';

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
plot(celldensity,consumptionRate,'*-')
cd (oPath);
global results;
results=[celldensity ;consumptionRate*1e7];
results(2,:)=results(2,:);
%% Done with read file data. Now optimaze the parameters
span =[0:0.01:9];
K=0.4119;
N0=0.066;
[t,N] = ode15s(@ode1, span, N0,[],K,results);

plot(data(:,1),data(:,2),'*-');
hold on;
plot(t,N,'o-')
 
 

function r=ode1(t,N,K,result) % it needs results to interpolate growth rate
rInterp=interp1(result(1,:),result(2,:),N,'spline','extrap');
rInterp=rInterp*N/8.3790;
if N>K/2
    resistence=(N-K/2)^2*2.367;
else
    resistence=0;
end
r=rInterp-resistence;
end
