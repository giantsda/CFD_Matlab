%% Very kike light_pattern_3, it calculates the distribution of light duration and
%% light intervals for each particle so that we can confirm that after a long time
%% of particle tracking the particles trajectoreies show a very similar pattern.
% clear all;
% load ('D:\CFD_second_HHD\01272021\172\1\particle.mat')


close all;
number=length(particle);
timeStepSize=0.2; % seconds
intervalS=cell(1,number);
DurationS=cell(1,number);
peakS=cell(1,number);
criticalLightIntensity=1000;
%% determine the surface hieght by defining it as 98% of the mean(max(verticalPos))
for e=1:number
    y_pos=particle{e}(:,5);
    surfaceHeightS(e)=max(y_pos);
end
surfaceHeight=mean(surfaceHeightS)*0.98

exaimeparticleN=10;
pIDs=zeros(1,exaimeparticleN);

figure;
set(gcf, 'Position', get(0, 'Screensize'));

for points=500:500:9985
    for e=1:exaimeparticleN
        pIDs(1,e)=randi(number);
    end
    for e=pIDs
        %     if e==2126
        %         e
        %     end
        %     fprintf('calculating %0.2f %% \n', e/number*100);
        y_pos=particle{e}(1:points,5);
        y_pos=surfaceHeight-y_pos;
        
        time=particle{e}(1:points,1);
        time=double(time);
        timeInterpolate=[min(time):0.01:max(time)].';
        y_posInterpolate = interp1(time,y_pos,timeInterpolate,'spline');
        y_posInterpolate(y_posInterpolate<0)=0;
        
        light_history=1./exp(40*(y_posInterpolate)) *2000;
        
        %     histogram(light_history,100,'Normalization','probability','FaceAlpha',0.3);
        [pks,locs] = findpeaks(light_history,'MinPeakHeight',criticalLightIntensity,'MinPeakProminence',200);
        
        %     plot(light_history);
        %     plot(time,light_history);
        %     hold on;
        %     plot(time(locs),light_history(locs),'o')
        %     t1=xlabel('time(second)')
        %     t2=ylabel('light intensity (\mumoles/m2/s)')
        %     set(t1,'FontSize',32);
        %     set(t2,'FontSize',32);
        %     hold off ;
        
        peak_time =timeInterpolate(locs);
        peak_time_interval=diff(peak_time);
        intervalS{e}=peak_time_interval;
        peakS{e}=pks;
        %% light duration
        above=find(light_history>=criticalLightIntensity);
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
            out(:,7)=out(:,6)-out(:,5)+timeStepSize;
            %         out(:,8)= [diff(out(:,5)); NaN]-out(:,7);
            DurationS{e}=out(:,7);
        else
            DurationS{e}=[];
        end
    end
    
    %% calculate averaged light duration and interval distribution
    
    
    subplot(3,1,1);
    for e=1:exaimeparticleN
        [N,edges] = histcounts(intervalS{pIDs(e)},100,'Normalization','probability');
        plot(edges(2:end),N);
        hold on;
    end
    xlabel('time of light peak interval (seconds)')
    ylabel('probability');
    legend('10 random particles');
    
    subplot(3,1,2);
    for e=1:exaimeparticleN
        [N,edges] = histcounts(DurationS{pIDs(e)},100,'Normalization','probability');
        plot(edges(2:end),N);
        hold on;
    end
    
    xlabel('time of light peak Duration (seconds)')
    ylabel('probability');
    legend('10 random particles');
    
    subplot(3,1,3);
    for e=1:exaimeparticleN
        [N,edges] = histcounts(peakS{pIDs(e)},100,'Normalization','probability');
        plot(edges(2:end),N);
        hold on;
    end
    
    xlabel('light peak intensity  ')
    ylabel('probability');
    legend('10 random particles');
    sgtitle (['examined time= ' num2str(time(end)-time(1)) 'seconds'])
    pause()
    clf
end

