% dataS=data;
close all;
haha=dataS(1).data;
waterCell=dataI(find(dataI(:,6)>=0.5),:);
data=waterCell(:,5);
data=data(data<0.0005);
[counts,centers] = hist(data,1000);
counts=counts/length(waterCell)*100;
bar(centers,counts);
figure;
mostPoint=counts>0.05;
counts=counts(mostPoint);
centers=centers(mostPoint);
bar(centers,counts);
 


