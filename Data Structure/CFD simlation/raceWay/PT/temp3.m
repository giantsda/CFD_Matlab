% % intervalSCombine(intervalSCombine>50)=[];
% h1 = histogram(intervalSCombine,'Normalization','probability');
% for e=1:number
%     interval=intervalS{e};
%     lightDuration=DurationS{e};
%     h1 = histogram(intervalSCombine,50,'Normalization','probability');
% %     h1.BinWidth = 0.25;
%     hold on
%     h2 = histogram(interval,50,'Normalization','probability');
% %     h1.BinWidth = 0.25;
%     hold off;
%     pause();
% end
 
close all;
intervalSCombine=vertcat(intervalS{:});
DurationSCombine=vertcat(DurationS{:});
sampleN=floor(length(particle)*0.01);
sampleindex=randi(length(particle),1,sampleN);
intervalSSampleCombine=[];
DurationSampleCombine=[];
%% contruct sample
for i=1:sampleN
    intervalSSampleCombine=[intervalSSampleCombine;intervalS{sampleindex(i)}];
    DurationSampleCombine=[DurationSampleCombine;DurationS{sampleindex(i)}];
end
intervalSCombine(intervalSCombine>60)=[];
intervalSSampleCombine(intervalSSampleCombine>60)=[];
DurationSCombine(DurationSCombine>6)=[];
DurationSampleCombine(DurationSampleCombine>6)=[];

h1=histogram(intervalSCombine,50,'Normalization','probability','FaceAlpha',0.3);
hold on;
h2=histogram(intervalSSampleCombine,50,'Normalization','probability','FaceAlpha',0.3);

figure;
histogram(DurationSCombine,50,'Normalization','probability','FaceAlpha',0.3);
hold on;
histogram(DurationSampleCombine,50,'Normalization','probability','FaceAlpha',0.3);


