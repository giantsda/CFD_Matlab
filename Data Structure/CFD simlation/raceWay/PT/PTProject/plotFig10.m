% % %% This file will convert particles vertical position to light intesity, and statistial
% % %% result will be calculated form the light intensity history.
% % I believe it first introduce a light intensity function and then use
% % findpeaks to find all local peaks with that meets some requirements.
% oPath=pwd();
% path='D:\CFD_second_HHD\07162021\242\242\800s'
% cd(path);
%
%
% result={};
%
%
% caseI=1
% load(['particle_' num2str(caseI) '.mat']);
% particle=Data.particle;
% number=Data.number;
% waterDepth=Data.waterDepth;
%
% interval=zeros(1,2000000);
% i=1;
fileName="C:\Users\chenshen.ETS01297\Desktop\temp\plot\PT\fig10.csv";
close all
write=[];

for e=4
    
    y_pos1=particle{e}(:,5);
    
    time=particle{e}(:,1);
    y_pos1=y_pos1*1.11;
    time=double(time);
    timeInterpolate=[min(time):0.01:max(time)].';
    y_posInterpolate = interp1(time,y_pos1,timeInterpolate,'spline');
    y_pos=0.2-y_posInterpolate;
    y_pos(y_pos<0)=0;
    
    light_history=1./exp(40*(y_pos)) *500;
    
    [pks,locs] = findpeaks(light_history,'MinPeakHeight',100,'MinPeakProminence',80);
    
    
    time=timeInterpolate(1:10000);
    yp=y_posInterpolate(1:10000);
    write=[write time yp]
    plot(time,yp)
    xlim([200,300])
    figure;
    L=light_history(1:10000);
    plot(time,L)
    write=[write L];
    xlim([200,300])
    
    
    %% light duration
    above=find(L>=100);
    out=zeros(length(above),7);
    
    if ~isempty(out)
        j=1;
        for i=2:length(above)
            if above(i,1)-above(i-1,1)~=1
                out(j,1)=i;
                j=j+1;
            end
        end
        out(j:end,:)=[];
        out(:,2)= [(out(2:end,1)-1); length(above)];
        out(:,3:4)=above(out(:,1:2));
        out(:,5:6)=timeInterpolate(out(:,3:4));
%         out(:,7)=out(:,6)-out(:,5)+timeStepSize;
        %         out(:,8)= [diff(out(:,5)); NaN]-out(:,7);
        DurationS{e}=out(:,7);
    else
        DurationS{e}=[];
    end
    
    haha=[out(:,3);out(:,4)].'
    
    
end
