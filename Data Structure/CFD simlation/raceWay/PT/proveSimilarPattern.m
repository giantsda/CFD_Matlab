%% Very kike light_pattern_3, it calculates the distribution of light duration and
%% light intervals for each particle so that we can confirm that after a long time
%% of particle tracking the particles trajectoreies show a very similar pattern.
clear all;
load ('/home/chen/Desktop/project/172/1/particle.mat')
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



for e=1:number
    %     if e==2126
    %         e
    %     end
    fprintf('calculating %0.2f %% \n', e/number*100);
    y_pos=particle{e}(:,5);
    y_pos=surfaceHeight-y_pos;
    %     max(y_pos)
    time=particle{e}(:,1);
    
    light_history=1./exp(40*(y_pos)) *2000;
    
    time=double(time);
    
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
    
    peak_time =time(locs);
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
        out(:,5:6)=time(out(:,3:4));
        out(:,7)=out(:,6)-out(:,5)+timeStepSize;
        %         out(:,8)= [diff(out(:,5)); NaN]-out(:,7);
        DurationS{e}=out(:,7);
    else
        DurationS{e}=[];
    end
end

%% calculate averaged light duration and interval distribution
intervalSCombine=vertcat(intervalS{:});
DurationSCombine=vertcat(DurationS{:});
peakSCombine=vertcat(peakS{:});
intervalSCombine(intervalSCombine>60)=[]; %% filter very small contributin of abnormal high values.
DurationSCombine(DurationSCombine>6)=[];

%% prove the trajectories have similar pattern
close all;

sampleN=floor(length(particle)*0.01);
sampleindex=randi(length(particle),1,sampleN);
intervalSSampleCombine=[];
DurationSampleCombine=[];
%% contruct sample
for i=1:sampleN
    intervalSSampleCombine=[intervalSSampleCombine;intervalS{sampleindex(i)}];
    DurationSampleCombine=[DurationSampleCombine;DurationS{sampleindex(i)}];
end

intervalSSampleCombine(intervalSSampleCombine>60)=[]; %% filter very small contributin of abnormal high values.
DurationSampleCombine(DurationSampleCombine>6)=[];

h1=histogram(intervalSCombine,500,'Normalization','probability','FaceAlpha',0.3);
hold on;
h2=histogram(intervalSSampleCombine,50,'Normalization','probability','FaceAlpha',0.3);

xlabel('time of light peak interval (seconds)')
ylabel('probability');
legend('all sample', '1% of total sample');
figure;
histogram(DurationSCombine,50,'Normalization','probability','FaceAlpha',0.3);
hold on;
histogram(DurationSampleCombine,50,'Normalization','probability','FaceAlpha',0.3);
xlabel('time of DurationSCombine in light zone(seconds)')
ylabel('probability');
legend('all sample', '1% of total sample');

 