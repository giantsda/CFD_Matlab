% %% Very kike light_pattern_3, it calculates the distribution of light duration and
% %% light intervals for each particle so that we can confirm that after a long time
% %% of particle tracking the particles trajectoreies show a very similar pattern.
% clear all;
% load ('/home/chen/Desktop/project/172/1/particle.mat')
% number=length(particle);
% timeStepSize=0.2; % seconds
% intervalS=cell(1,number);
% DurationS=cell(1,number);
% criticalLightIntensity=1000;
% %% determine the surface hieght by defining it as 98% of the mean(max(verticalPos))
% for e=1:number
%     y_pos=particle{e}(:,5);
%     surfaceHeightS(e)=max(y_pos);
% end
% surfaceHeight=mean(surfaceHeightS)*0.98
%
%
%
% for e=1:number
%     %     if e==2126
%     %         e
%     %     end
%     fprintf('calculating %0.2f %% \n', e/number*100);
%     y_pos=particle{e}(:,5);
%     y_pos=surfaceHeight-y_pos;
%     %     max(y_pos)
%     time=particle{e}(:,1);
%
%     light_history=1./exp(40*(y_pos)) *2000;
%
%     time=double(time);
%
%     [pks,locs] = findpeaks(light_history,'MinPeakHeight',criticalLightIntensity,'MinPeakProminence',200);
%
%     %     plot(light_history);
%     %     plot(time,light_history);
%     %     hold on;
%     %     plot(time(locs),light_history(locs),'o')
%     %     t1=xlabel('time(second)')
%     %     t2=ylabel('light intensity (\mumoles/m2/s)')
%     %     set(t1,'FontSize',32);
%     %     set(t2,'FontSize',32);
%     %     hold off ;
%
%     peak_time =time(locs);
%     peak_time_interval=diff(peak_time);
%     intervalS{e}=peak_time_interval;
%     %% light duration
%     above=find(light_history>=criticalLightIntensity);
%
%     out=zeros(length(above),7);
%
%     if ~isempty(out)
%         j=1;
%         for i=2:length(above)
%             if above(i,1)-above(i-1,1)~=1
%                 out(j,1)=i;
%                 j=j+1;
%             end
%         end
%         out(j:end,:)=[];
%         out(:,2)= [(out(2:end,1)-1); length(above)];
%         out(:,3:4)=above(out(:,1:2));
%         out(:,5:6)=time(out(:,3:4));
%         out(:,7)=out(:,6)-out(:,5)+timeStepSize;
%         %         out(:,8)= [diff(out(:,5)); NaN]-out(:,7);
%         DurationS{e}=out(:,7);
%     else
%         DurationS{e}=[];
%     end
% end
%
% %% calculate averaged light duration and interval distribution
% intervalSCombine=vertcat(intervalS{:});
% DurationSCombine=vertcat(DurationS{:});
% intervalSCombine(intervalSCombine>60)=[]; %% filter very small contributin of abnormal high values.
% DurationSCombine(DurationSCombine>6)=[];



close all

h1=histogram(DurationSCombine,100,'Normalization','probability','BinLimits',[0,6],'FaceAlpha',0.3);
binEdge=h1.BinEdges(1:end-1)+h1.BinWidth;
binValue=h1.Values;
xq1=linspace(binEdge(1),binEdge(end),2000);
vq1 = interp1(binEdge,binValue,xq1,'spline');
haha1=binValue;

intervalS=cell(1,number);
DurationS=cell(1,number);
for e=1:number
    
    fprintf('calculating %0.2f %% \n', e/number*100);
    y_pos=particle{e}(1:301,5);
    y_pos=surfaceHeight-y_pos;
    %     max(y_pos)
    time=particle{e}(1:301,1);
    
    light_history=1./exp(40*(y_pos)) *2000;
    
    time=double(time);
    
    [pks,locs] = findpeaks(light_history,'MinPeakHeight',criticalLightIntensity,'MinPeakProminence',200);
    
    peak_time =time(locs);
    peak_time_interval=diff(peak_time);
    intervalS{e}=peak_time_interval;
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
        out(:,5:6)=time(out(:,3:4));
        out(:,7)=out(:,6)-out(:,5)+timeStepSize;
        %         out(:,8)= [diff(out(:,5)); NaN]-out(:,7);
        DurationS{e}=out(:,7);
    else
        DurationS{e}=[];
    end
end


intervalSCombine2=vertcat(intervalS{:});
DurationSCombine2=vertcat(DurationS{:});
intervalSCombine2(intervalSCombine2>60)=[]; %% filter very small contributin of abnormal high values.
DurationSCombine2(DurationSCombine2>6)=[];



hold on;
h2=histogram(DurationSCombine2,100,'Normalization','probability','BinLimits',[0,6],'FaceAlpha',0.3);
binEdge=h2.BinEdges(1:end-1)+h2.BinWidth;
binValue=h2.Values;
xq2=linspace(binEdge(1),binEdge(end),2000);
vq2 = interp1(binEdge,binValue,xq2,'spline');
% hold off;
% plot(xq1,vq1);
% hold on;
% plot(xq2,vq2);
xlabel('time of light peak duration (seconds)')
ylabel('probability');
legend("5978 particles, 2000s", "5978 particle 60s")










