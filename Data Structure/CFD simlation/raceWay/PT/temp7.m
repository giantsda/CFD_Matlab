%% Very kike light_pattern_3, it calculates the distribution of light duration and
%% light intervals for each particle so that we can confirm that after a long time
%% of particle tracking the particles trajectoreies show a very similar pattern.
% clear all;
% load ('/home/chen/Desktop/project/172/1/particle.mat')
 
timeStepSize=0.2; % seconds
 
criticalLightIntensity=1000;
 



e=1;
 
 
timeInterpolate=ligntHistory(:,1);

light_history=ligntHistory(:,2);


[pks,locs] = findpeaks(light_history,'MinPeakHeight',criticalLightIntensity,'MinPeakProminence',200);
 

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
    DurationS{e} =out(:,7);
else
    DurationS{e} =[];
end


%% calculate averaged light duration and interval distribution
intervalSCombine=vertcat(intervalS{:});
DurationSCombine=vertcat(DurationS{:});
peakSCombine=vertcat(peakS{:});
intervalSCombine(intervalSCombine>20)=[]; %% filter very small contributin of abnormal high values.
DurationSCombine(DurationSCombine>3)=[];


subplot(3,1,1);
h1=histogram(intervalSCombine,100,'Normalization','probability','FaceAlpha',0.3);
xlabel('time of light peak interval (seconds)')
ylabel('probability');
legend('all sample');

subplot(3,1,2);
h2=histogram(DurationSCombine,100,'Normalization','probability','FaceAlpha',0.3);
xlabel('time of light peak Duration (seconds)')
ylabel('probability');
legend('all sample');

subplot(3,1,3);
h3=histogram(peakSCombine,100,'Normalization','probability','FaceAlpha',0.3);
xlabel('light peak intensity  ')
ylabel('probability');
legend('all sample');



binEdge1=h1.BinEdges(1:end-1)+h1.BinWidth/2;
binValue1=h1.Values;
binEdge2=h2.BinEdges(1:end-1)+h2.BinWidth/2;
binValue2=h2.Values;
binEdge3=h3.BinEdges(1:end-1)+h3.BinWidth/2;
binValue3=h3.Values;


