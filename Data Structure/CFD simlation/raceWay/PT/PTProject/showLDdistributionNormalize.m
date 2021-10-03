close all
figure;
set(gcf, 'Position', get(0, 'Screensize'));

path='D:\CFD_second_HHD\07162021\242\242\800s'
cd(path);


result={};

for caseI=[1:40 49:56]
    
    caseI
    load(['..\Figs\plot_' num2str(caseI) '.mat']);
    dx=X(1,2)-X(1,1);
    
    hist(D)
    
    
    D=D/activeNumber*100;
    %     D(D>10)=10;
    pcolor(X,Y,D.');
    shading interp;
    axis equal
    colormap jet
    colorbar
    axis equal;
    title(num2str(caseI));
    caxis([0 1]);
    
%     pause()
    print(gcf,['..\Figs\plot_' num2str(caseI) '.png'],'-dpng','-r400');
end

