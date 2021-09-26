% %% This file will convert particles vertical position to light intesity, and statistial
% %% result will be calculated form the light intensity history.
% I believe it first introduce a light intensity function and then use
% findpeaks to find all local peaks with that meets some requirements.
oPath=pwd();
path='D:\CFD_second_HHD\07162021\242\242'
cd(path);
 
% load('D:\CFD_second_HHD\07162021\242\242\allParticles.mat');

result={};

for caseI=1:56
    
    load(['particle_' num2str(caseI) '.mat']);
    particle=Data.paritlce;
    number=Data.number;
    waterDepth=Data.waterDepth;
    
    interval=zeros(1,2000000);
    i=1;
    
    %% get maxY for liquid depth
    p = randi([0,number],20,1);
    posZ=[];
    for i=1:length(p)
        posZ=[posZ;particle{i}(:,5)];
    end
    [counts,centers] = hist(posZ,200);
    counts=counts/sum(counts);
    
    for e=1:number
        %         e
        
        if ~isempty (particle{e})
            
            y_pos=particle{e}(:,5);
            y_pos=waterDepth-y_pos;
            time=particle{e}(:,1);
            
            time=double(time);
            timeInterpolate=[min(time):0.01:max(time)].';
            y_posInterpolate = interp1(time,y_pos,timeInterpolate,'spline');
            y_posInterpolate(y_posInterpolate<0)=0;
            %
            light_history=1./exp(40*(y_posInterpolate)) *500;
            %             light_history=1./exp(40*(y_pos)) *500;
            [pks,locs] = findpeaks(light_history,'MinPeakHeight',100,'MinPeakProminence',80);
            %         if (length(pks)==0)
            %
            %             plot(light_history);
            %             plot(time,light_history);
            %             hold on;
            %             plot3(particle{e}(:,3),particle{e}(:,4),particle{e}(:,5));
            %             axis equal;
            %             plot(time(locs),light_history(locs),'o')
            %             t1=xlabel('time(second)')
            %             t2=ylabel('light intensity (\mumoles/m2/s)')
            %             set(t1,'FontSize',32);
            %             set(t2,'FontSize',32);
            %             hold off ;
            %         end
            
            peak_time =timeInterpolate(locs);
            peak_time=[timeInterpolate(1); peak_time; timeInterpolate(end)];
            
            %             peak_time =time(locs);
            %             peak_time=[time(1); peak_time; time(end)];
            
            peak_time_interval=diff(peak_time);
            interval(i:i+length(peak_time_interval)-1)=peak_time_interval;
            i=i+length(peak_time_interval);
            %     interval=[interval; peak_time_interval];
            %     pause(0.001)
        end
    end
    
    for i=length(interval):-1:1
        if interval(i)~=0
            break
        end
    end
    interval(i:end)=[];
    
    for i=1:length(interval)
        if interval(i)>198 || interval(i)==0
            interval(i)=NaN;
        end
    end
    
    
    % for i=400:500
    %     i
    %     hist(interval,i)
    %     pause();
    % end
    
    [counts,centers] = hist(interval,200);
    counts=counts/sum(counts);
    bar(centers,counts);
    t2=xlabel('time of light peak interval (seconds)');
    t1=ylabel('percentage');
    set(t2,'FontSize',32);
    set(t1,'FontSize',32);
    set(gca,'FontSize',20);
    
    interval(isnan(interval))=[];
    mean(interval)
    result{caseI}.interval=double(interval);
    
end

cd (oPath)