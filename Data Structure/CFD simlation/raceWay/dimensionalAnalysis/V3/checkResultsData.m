close all;
figure;
set(gcf,'outerposition',get(0,'screensize'));

MainPath='D:\CFD_second_HHD\02212020\130\Data\';
cd (MainPath);
UcriticalS=[0.15982686 0.021875553 0.035083402 0.069241576 0.090255074 0.1342044 0.17206132 0.1954238 0.23307045 0.060019508 0.081056289 0.16703509 0.16152388 0.1836872 0.27659169 0.31369507 0.22162931 0.056153558 0.090827145 0.17766155 0.24768509 0.30259502 0.2453223 0.3134717 0.20899226 0.042618934 0.066329412 0.086191766 0.14823247 0.19028176 0.21204141 0.2358487 0.21391533 0.026776388 0.054853324 0.092745572 0.13448086 0.18338189 0.25685465 0.26840153 0.18124717 0.012697313 0.044251263 0.070433758 0.10674879 0.14460506 0.18461382 0.17244379 0.14420456 0.008107703 0.023346731 0.062064294 0.094408602 0.13564876 0.15026182 0.16658473 0.12812221 0.22739895 0.19239019 0.20565921 0.16105893 0.1468277 0.16077138 0.02309612 0.038599014 0.079608373 0.10114942 0.12276831 0.18051322 0.20917681 0.23201425 0.034479011 0.055890974 0.11619208 0.1632947 0.18448351 0.26420853 0.28087541 0.21066901 0.026004681 0.047410924 0.094322078 0.13318343 0.18693569 0.22431476 0.24525672 0.17398728 0.023330752 0.035286114 0.074738726 0.09453617 0.13383006 0.20765072 0.24004298 0.28348914 0.047428746 0.078945003 0.15506744 0.21109447 0.2516568 0.31028715 0.35226589 0.41724575 0.062129267 0.13281399 0.24802612 0.3220841 0.35403571 0.43643045 0.34817237];
for i=[103]
    caseN=i
    load(['Data_' num2str(caseN) '.mat']);
    Ucritical=UcriticalS(caseN);
    
    for timeIndex=1:5:length(Data.U)
        index=zeros(size(Data.vof));
        for j=1:timeIndex
            index(abs(Data.U{j}(:,3))>Ucritical)=index(abs(Data.U{j}(:,3))>Ucritical)+1;
        end
        ii=find(index>=1);
        scatter3(Data.mesh(ii,1),Data.mesh(ii,2),Data.mesh(ii,3),18,Data.vof(ii),'filled')
        axis equal;
        view(0,0);
        title(['case=' num2str(caseN) '  Ucritical=' num2str(Ucritical) ' time=' num2str(Data.time(timeIndex))])
        colormap jet;
        colorbar; 
    end
    saveas(gcf,['D:\CFD_second_HHD\02212020\130\Data\checkCase_' num2str(caseN) '.png'])
    pause();
end
load handel.mat;
soundsc(y, 2*Fs);

