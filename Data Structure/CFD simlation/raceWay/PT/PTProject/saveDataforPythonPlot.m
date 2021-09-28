 



 

fid = fopen("try.csv", 'wt');
% Write headers
fprintf(fid, '"case","value"\n');
% Write data.
for caseI=[1:8] 
    caseI
    interval=result{caseI}.interval;
    interval((interval==0))=[];
    interval=double(interval);
    [counts,centers] = hist(interval,200);
    counts=counts/sum(counts);
    for i=1:500
        fprintf(fid, """AR=%d"",%f\n", caseI, interval(i));
    end
    
end
fclose(fid);
 