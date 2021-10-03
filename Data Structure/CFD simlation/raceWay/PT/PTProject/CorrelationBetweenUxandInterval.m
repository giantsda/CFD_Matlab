lamda=[26.761,114.45,85.432,56.822,36.454,29.272,25.484,21.397];

x=linspace(0,30,1000).';
mus=[];
sigs=[];
maxS=[];
for caseI=1:8
    caseI
    interval=result{caseI}.interval;
    pd = fitdist(interval.','Lognormal');
    pdfEst = pdf(pd,x);
    
    [maxI i]=max(pdfEst);
    maxS(caseI)=x(i);
    
    
    
    
    mus(caseI)=pd.mu;
    sigs(caseI)=pd.sigma;
 
 
end

index=[2 3 4 5 6 1 7 8];
plot(lamda(index),maxS(index),'*-')
