







h2=histogram(haha1,100,'Normalization','probability','BinLimits',[0,60],'FaceAlpha',0.3);
binEdge=h2.BinEdges(1:end-1)+h2.BinWidth;
binValue=h2.Values;
xq2=linspace(binEdge(1),binEdge(end),2000);
vq2 = interp1(binEdge,binValue,xq2,'spline');

hold on;
h2=histogram(haha2,100,'Normalization','probability','BinLimits',[0,60],'FaceAlpha',0.3);
binEdge=h2.BinEdges(1:end-1)+h2.BinWidth;
binValue=h2.Values;
xq2=linspace(binEdge(1),binEdge(end),2000);
vq2 = interp1(binEdge,binValue,xq2,'spline');
% hold off;
% plot(xq1,vq1);
% hold on;
% plot(xq2,vq2);
xlabel('time of light peak interval (seconds)')
ylabel('probability');
legend("5978 particles, first120s", "5978 particle end 120s")