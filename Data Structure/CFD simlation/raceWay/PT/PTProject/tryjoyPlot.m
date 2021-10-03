close all;



% data = zeros(N,n);
% medians = zeros(1,n);
% % Create the distributions and the data with changing shape and scale.
% % Save the median for later use
% x=linspace(-3,100,1000).';
% da=[];
% for caseI=[2 3 4 5 6 1 7 8]
% interval=result{caseI}.interval;
%  
% [f,xi] = ksdensity((interval),x);
% da=[da f];
% % plot(xi,f);
% % hold on;
% % write=[write  f];
% end
% 
% 
% % figure
% % Set overlapMethod to 'variable' and reverse to 'true'.
% joyPlot(da,x,0.2,'variable',true,'FaceColor',mean(da,1),'StrokeColor','w')
% % Some axes settings
% set(gca,'Color',[0.93 0.93 0.93])
% set(gca,'XGrid','on')
% colormap(spring)
% colorbar 




x=linspace(-3,100,1000).';
da=[];
for caseI=[2 3 4 5 6 1 7 8]
interval=result{caseI}.interval;
 
    pd = fitdist(interval.','Lognormal');
    pdfEst = pdf(pd,x);
    [m index]=max(pdfEst);
    sig(caseI)=x(index);
    da=[da pdfEst];
% plot(xi,f);
% hold on;
% write=[write  f];
end


% figure
% Set overlapMethod to 'variable' and reverse to 'true'.
joyPlot(da,x,0.5,'variable',false,'FaceColor',sig,'VLines',sig,'StrokeColor','w')
% Some axes settings
set(gca,'Color',[0.93 0.93 0.93])
set(gca,'XGrid','on')
colormap(jet)
colorbar 
xlim([0 60])

