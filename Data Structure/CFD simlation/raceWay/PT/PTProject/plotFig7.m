lamda=[26.8784629908658	138.218444126117	102.715717370815	60.6479704084775	39.9066767880621	30.9887140568196	25.2325381827660	21.5581948107363	19.4142438809871	102.006438450403	62.8020018889853	30.9418876859255	24.6686876813951	24.9481697533888	16.7116213086790	15.6166415075447	19.9039182399745	73.0010199630444	57.8076203621269	31.5235217573614	21.6261570189204	17.3882451303477	17.5186447893716	15.2762563881570	22.2485781765067	128.478090458558	70.7656868234052	49.8495974698374	32.8004965617997	25.3018230517350	20.5694286161876	18.5412327622457	19.8882543229634	165.106377599435	89.0864521167893	45.2083438733915	31.2647745784802	23.3135630580884	16.6964079144406	15.0167877914462	0	0	0	0	0	0	0	0	32.8437856588794	795.133442257393	251.855463227861	75.9446295580696	50.5046344381296	36.1716041383621	30.6685537186913	27.3940473161511];
close all;
x=linspace(0,30,1000).';
mus=[];
sigs=[];
maxS=[];
for caseI=[1:40 49:56]
    caseI
    interval=result{caseI}.interval;
    [f,xi] = ksdensity( (interval),x);
    plot(xi,f);
    %     [maxI i]=max(counts);
%     maxS(caseI)=centers(i);
%     pd = fitdist(interval.','Lognormal');
%     pdfEst = pdf(pd,x);
%     plot(x,pdfEst)
     [maxI i]=max(f);
     maxS(caseI)=centers(i);
    
    hold on;

%  [counts,centers] = hist(interval,1200);
%  
%     [maxI i]=max(counts);
%     maxS(caseI)=centers(i);
    
    
    
    
%     mus(caseI)=pd.mu;
%     sigs(caseI)=pd.sigma;
 
 
end
% a=[2 3 4 5 6 1 7 8];
% index=[a a+8 a+8*2 a+8*3 a+8*4 a+8*5 a+8*6];
% plot(lamda(index),maxS(index),'*-')
