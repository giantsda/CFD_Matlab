path='D:\CFD_second_HHD\07162021\242\242\Figs'
cd(path);
for caseI=[1:8   49:56]
    caseI
    filename=['plot_' num2str(caseI) '.png'];
    I=imread(filename);
%         imshow(I);
    if  ismember(caseI,[1:8])
        I=I(1249:2801,1041:7240,:);
        %         imshow(I)
        imwrite(I,['.\corp\' filename])
    end
    
    if  ismember(caseI,[49:56])
        I=I(826:2898,1041:7240,:);
        imwrite(I,['.\corp\' filename])
    end
end