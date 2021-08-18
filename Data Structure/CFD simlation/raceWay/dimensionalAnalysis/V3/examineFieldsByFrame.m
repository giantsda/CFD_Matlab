close all;
figure;
set(gcf,'outerposition',get(0,'screensize'));

MainPath='D:\CFD_second_HHD\02212020\130\Data\';
cd (MainPath);
UcriticalS(1:94)=[0.188842773 0.028442383 0.040405273 0.089477539 0.13659668 0.157104492 0.21496582 0.252807617 0.284545898 0.032592773 0.07409668 0.14440918 0.20300293 0.195678711 0.289428711 0.334594727 0.311889648 0.051879883 0.08190918 0.16394043 0.24621582 0.32800293 0.34777832 0.385864258 0.24206543 0.03137207 0.05480957 0.115112305 0.147338867 0.18737793 0.265991211 0.277954102 0.24987793 0.019165039 0.040649414 0.098266602 0.14831543 0.181518555 0.234741211 0.284057617 0.153930664 0.006958008 0.043823242 0.059204102 0.088745117 0.137329102 0.18737793 0.18737793 0.24987793 0.00378418 0.003295898 0.04284668 0.068237305 0.102416992 0.132202148 0.14831543 0.190136719 0.299902344 0.249902344 0.260253906 0.199511719 0.165332031 0.196655273 0.01940918 0.038208008 0.083129883 0.13269043 0.178100586 0.231811523 0.31237793 0.49597168 0.024291992 0.05090332 0.11706543 0.17175293 0.21862793 0.291137695 0.482299805 0.231323242 0.025268555 0.039916992 0.094360352 0.14855957 0.18347168 0.26550293 0.29699707 0.169555664 0.169555664 0.026000977 0.026000977 0.083618164 0.112426758 0.17956543 0.210083008 ];

for caseN=[101 103:107]
    caseN
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
 pause();
end



