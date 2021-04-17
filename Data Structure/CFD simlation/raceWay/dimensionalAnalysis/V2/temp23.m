% disp('store UcriticalStore to MainPath.............. \n');
%
%
%



for i=1.01:0.02:1.5
    MeanmagU(57:62)=MeanmagUS(57:62)/i;
    MeanmagU(57:62)=MeanmagUS(57:62)/i;
    MeanmagUSorted=MeanmagU(results.Index);
    MeanUxSorted=MeanUx(results.Index);
    plot(MeanmagUSorted);
    hold on;
    plot(MeanUxSorted);
    title(num2str(i))
    pause();
    clf;
end