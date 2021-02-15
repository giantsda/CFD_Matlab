 
peakTime=[];
peakTime{1}=[0 randPeakIntensity(1)];

for i=2:length(randInterval)
    peakTime{i}=[sum(randInterval(1:i-1)) randPeakIntensity(i)];
end

%% add peak duration as cells
for i=1:length(randPeakDuration)
    peakTime{i}=[[peakTime{i}(1,1)-0.5*randPeakDuration(i) 1000]; peakTime{i};[peakTime{i}(1,1)+0.5*randPeakDuration(i) 1000]];
end

%% background lightHistory
e=1;
y_pos=particle{e}(:,5);
y_pos=surfaceHeight-y_pos;

time=particle{e}(:,1);
time=double(time);
timeInterpolate=[min(time):0.01:max(time)].';
y_posInterpolate = interp1(time,y_pos,timeInterpolate,'spline');
y_posInterpolate(y_posInterpolate<0)=0;

light_history=1./exp(40*(y_posInterpolate)) *2000;
light_history=light_history(timeInterpolate<timeInterpolate(1)+peakTime{end}(end,1));
timeInterpolate=timeInterpolate(timeInterpolate<timeInterpolate(1)+peakTime{end}(end,1))-timeInterpolate(1);

timeInterpolate(light_history>1000)=[];

light_history(light_history>1000)=[];
ligntHistory=[timeInterpolate  light_history];


%% enrich each peak
for i=1:length(randPeakDuration)
    time=[peakTime{i}(1,1):0.01:peakTime{i}(3,1)];
    I=interp1(peakTime{i}(:,1),peakTime{i}(:,2),time,'spline');
    peakTime{i}=[time.' I.'];
end

%% treatment for overlapping
for i=2:length(peakTime)
    if(~isempty(peakTime{i-1}))
        if (peakTime{i}(1,1)<peakTime{i-1}(end,1))
            i
            I=find(peakTime{i}(:,1)<peakTime{i-1}(end,1));
            peakTime{i}(I,:)=[];
        end
    end
end




peakTimeS=vertcat(peakTime{:});
plot(peakTimeS(:,1),peakTimeS(:,2),'*-')


%% prepare for connection
for i=1:length(peakTime)
    if(~isempty(peakTime{i}))
        ligntHistory(ligntHistory(:,1)>peakTime{i}(1,1)&ligntHistory(:,1)<peakTime{i}(end,1),:)=[];
    end
end
plot(ligntHistory(:,1),ligntHistory(:,2),'*-')

%% construct ligntHistory
ligntHistory=[ligntHistory; peakTimeS];
ligntHistory=sortrows(ligntHistory,1);
plot(ligntHistory(:,1),ligntHistory(:,2));

% disp('writting all data to particle.............. \n');
% clearvars -except ligntHistory binEdge1 binEdge2 binEdge3 binValue1 binValue2 binValue3  
% save('TimeWindow', '-v7.3');
% disp('store all data to particle.............. \n');
