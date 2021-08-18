figure;
set(gcf,'outerposition',get(0,'screensize'));
caseN=18;
Ucritical=UcriticalStore{caseN}.percent3;
 for haha=1:length(Data.U)
    index=zeros(size(Data.vof));
    for j=1:haha
        index(abs(Data.U{j})>Ucritical)=1;
    end
    ii=find(index==1);
    scatter3(Data.mesh(ii,1),Data.mesh(ii,2),Data.mesh(ii,3),6,Data.U{j}(ii,1),'filled')
    axis equal;
    view(0,90);
    title(['case=' num2str(caseN) '  Ucritical=' num2str(Ucritical)])
    colormap jet;
    colorbar;
    pause(0.5);
 end