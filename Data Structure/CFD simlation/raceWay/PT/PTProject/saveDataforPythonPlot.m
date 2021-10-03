


fileName="C:\Users\chenshen.ETS01297\Desktop\temp\plot\PT\fig2.csv";
x=linspace(0,30,1000).';
write=[x];
for caseI=1:8
    caseI
interval=result{caseI}.interval;
[f,xi] = ksdensity((interval),x,'Support','positive','Bandwidth',0.2);
plot(xi,f);
hold on;
write=[write  f];
end
xlim([0,30])
% csvwrite(fileName,write);






%%


% filepath='C:\Users\chenshen.ETS01297\Desktop\temp\plot\PT\Fig';
% x=linspace(-3,100,1000).';
% write=[];
% for caseI=1:8
%     caseI
%     fileName=[filepath num2str(caseI) '.csv']
%     interval=result{caseI}.interval;
%     csvwrite(fileName,interval.');
%     
% end

%%

% fid = fopen("try.csv", 'wt');
% % Write headers
% fprintf(fid, '"case","value"\n');
% % Write data.
% for caseI=[1:8]
%     caseI
%     interval=result{caseI}.interval;
%     interval((interval==0))=[];
%     interval=double(interval);
%     [counts,centers] = hist(interval,200);
%     counts=counts/sum(counts);
%     for i=1:500
%         fprintf(fid, """AR=%d"",%f\n", caseI, interval(i));
%     end
%
% end
% fclose(fid);
