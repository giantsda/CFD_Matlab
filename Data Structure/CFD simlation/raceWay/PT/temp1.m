%  
% for e=220:3:600
% 
% h2=histogram(DurationSCombine,e,'Normalization','probability','FaceAlpha',0.3);
% title(e);
% pause();
% end



 
h1=histogram(intervalSCombine,10,'Normalization','probability','FaceAlpha',0.3);
 
binEdge=h1.BinEdges(1:end-1)+h1.BinWidth/2;
binValue=h1.Values;

