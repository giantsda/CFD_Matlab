
 for resolution=
subplot(3,1,1);
h1=histogram(intervalSCombine,200,'Normalization','probability','FaceAlpha',0.3);
xlabel('time of light peak interval (seconds)')
ylabel('probability');
legend('all sample');

subplot(3,1,2);
h2=histogram(DurationSCombine,200,'Normalization','probability','FaceAlpha',0.3);
xlabel('time of light peak Duration (seconds)')
ylabel('probability');
legend('all sample');

subplot(3,1,3);
h3=histogram(peakSCombine,200,'Normalization','probability','FaceAlpha',0.3);
xlabel('light peak intensity  ')
ylabel('probability');
legend('all sample');
 
  
 
binEdge1=h1.BinEdges(1:end-1)+h1.BinWidth/2;
binValue1=h1.Values;
binEdge2=h2.BinEdges(1:end-1)+h2.BinWidth/2;
binValue2=h2.Values;
binEdge3=h3.BinEdges(1:end-1)+h3.BinWidth/2;
binValue3=h3.Values;