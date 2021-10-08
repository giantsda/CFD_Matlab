% the criticalU4 is define as the critical vertical velocity so that the
% critical length is 4*R

MainPath='D:\CFD_second_HHD\06232021\204\Data';
opath=pwd();
cd (MainPath);
criticalU4=[];

for i=[213:215]
    ii=1;
    caseN=i
%     Data={};
    cd (MainPath);
%     load(['Data_' num2str(caseN) '.mat']);
    fprintf("Done with reading data.\n");
    critcal=0.01074674;
     
    leftPoint=min(Data.mesh(:,1));
    xMaxI=max(Data.mesh(:,1));
    xMinI=min(Data.mesh(:,1));
    yMaxI=max(Data.mesh(:,2));
    yMinI=min(Data.mesh(:,2));
    %% get Data.count
 scatter(Data.mesh(:,1),Data.mesh(:,2))
end
cd (opath)


