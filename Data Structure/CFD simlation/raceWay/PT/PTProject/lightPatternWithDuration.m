%% Very kike light_pattern_3, it calculates the distribution of light duration and
%% light intervals for each particle so that we can confirm that after a long time
%% of particle tracking the particles trajectoreies show a very similar pattern.

oPath=pwd();

path='D:\CFD_second_HHD\07162021\242\242\800s'
cd(path);

results={};

for caseI=[1:40 49:56]
    load(['particle_' num2str(caseI) '.mat']);
    particle=Data.particle;
    number=Data.number;
    waterDepth=Data.waterDepth;
    
    
    
    timeStepSize=0.2; % seconds
    intervalS=cell(1,number);
    DurationS=cell(1,number);
    peakS=cell(1,number);
    criticalLightIntensity=100;
    %% determine the surface hieght by defining it as 98% of the mean(max(verticalPos))
    
    
    for e=1:number
        if mod(e,floor(number/100))==0
            fprintf("%d Percent\n",floor(e/floor(number/100)));
        end
        if ~ isempty(particle{e})
             
            y_pos=particle{e}(:,5);
            y_pos=waterDepth-y_pos;
            
            time=particle{e}(:,1);
            time=double(time);
            timeInterpolate=[min(time):0.01:max(time)].';
            y_posInterpolate = interp1(time,y_pos,timeInterpolate,'spline');
            y_posInterpolate(y_posInterpolate<0)=0;
            
            light_history=1./exp(40*(y_posInterpolate)) *500;
            
            
            [pks,locs] = findpeaks(light_history,'MinPeakHeight',criticalLightIntensity,'MinPeakProminence',80);
            
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
        intervalSCombine=vertcat(intervalS{:});
        DurationSCombine=vertcat(DurationS{:});
        peakSCombine=vertcat(peakS{:});
        
        results{caseI}.intervalSCombine=intervalSCombine;
        results{caseI}.DurationSCombine=DurationSCombine;
        results{caseI}.peakSCombine=peakSCombine;
    end
    %
    %     subplot(3,1,1);
    %     h1=histogram(intervalSCombine,100,'Normalization','probability','FaceAlpha',0.3);
    %     xlabel('time of light peak interval (seconds)')
    %     ylabel('probability');
    %     legend('all sample');
    %
    %     subplot(3,1,2);
    %     h2=histogram(DurationSCombine,100,'Normalization','probability','FaceAlpha',0.3);
    %     xlabel('time of light peak Duration (seconds)')
    %     ylabel('probability');
    %     legend('all sample');
    %
    %     subplot(3,1,3);
    %     h3=histogram(peakSCombine,100,'Normalization','probability','FaceAlpha',0.3);
    %     xlabel('light peak intensity  ')
    %     ylabel('probability');
    %     legend('all sample');
    
    
    
    %     binEdge1=h1.BinEdges(1:end-1)+h1.BinWidth/2;
    %     binValue1=h1.Values;
    %     binEdge2=h2.BinEdges(1:end-1)+h2.BinWidth/2;
    %     binValue2=h2.Values;
    %     binEdge3=h3.BinEdges(1:end-1)+h3.BinWidth/2;
    %     binValue3=h3.Values;
    
    
end