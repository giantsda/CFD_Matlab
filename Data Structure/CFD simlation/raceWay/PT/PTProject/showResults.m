figure;
global counts centers;

meanInterva=[];
mu=[];
sigma=[];
for caseI=[40:87]+8*0
    caseI
    interval=result{caseI}.interval;
    interval((interval==0))=[];
    interval=double(interval);
    
    [counts,centers] = hist(interval,200);
    counts=counts/sum(counts);
%     bar(centers,counts);
%     xlim([0 80]) 
    %     t2=xlabel('time of light peak interval (seconds)');
    %     t1=ylabel('percentage');
    %     set(t2,'FontSize',32);
    %     set(t1,'FontSize',32);
    %     set(gca,'FontSize',20);
    %     title(['case ' num2str(caseI)])
    %     pause(0.1)
    % plot(centers,counts,'.');
    % hold on;
    
%     [f,xi] = ksdensity(interval,linspace(0,80,1000));
%     plot(xi,f);
%     hold on;
    
    
%     [f,xi] = ksdensity(log(interval),linspace(-3,10,1000));
%     plot(xi,f);
%     hold on;
    
    
 
%     pd = fitdist(interval.','Lognormal');
%     pdfEst = pdf(pd,linspace(0,80,1000));
%     plot(linspace(0,80,1000),pdfEst)

%     pd = fitdist(log(interval.'),'Normal');
%     mu(caseI)=pd.mu;
%     sigma(caseI)=pd.sigma;
%     pdfEst = pdf(pd,linspace(-3,10,1000));
%     plot(linspace(-3,10,1000),pdfEst)
       
%     hold on
        
        
        
%     hist(interval,200);
%     xlabel("intevel(s)")
%     ylabel("instances")
    aa=log(interval);
    hist(aa,200);
    xlabel("log(intevel(s))")
    ylabel("instances")
%  
    title(['case ' num2str(caseI)])
    hold off;
    pause( )

    meanInterva(caseI)=mean(interval);
end

