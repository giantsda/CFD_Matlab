% % %% This file will convert particles vertical position to light intesity, and statistial
% % %% result will be calculated form the light intensity history.
% % I believe it first introduce a light intensity function and then use
% % findpeaks to find all local peaks with that meets some requirements.
oPath=pwd();
path=' D:\CFD_second_HHD\07162021\242\242\800s'
cd(path);
close all;
figure;
set(gcf, 'Position', get(0, 'Screensize'));

result={};

globalUpper=0;
for caseI=[1:56]
    globalUpper=0.7559
    cd(path);
    caseI
    
    load(['particle_' num2str(caseI) '.mat']);
    particle=Data.particle;
    number=Data.number;
    waterDepth=Data.waterDepth;
    
    for e=1:number
        if isempty(particle{e})
            break;
        end
    end
    number=e;
    time=particle{1}(end,1)-particle{1}(1,1);
    load(['../Figs/plot_' num2str(caseI) '.mat'])
    
    D=D/time/number*1e5;
    
    [f,xi] = ksdensity(reshape(D,[],1),linspace(0,2,300));
    upRethohold=xi(max(find(f>=0.1)));
    D(D>upRethohold)=upRethohold;
    if caseI==1
        globalUpper=upRethohold;
    end
    surf(X,Y,D.','edgecolor', 'none')
    colormap jet
    colorbar
    axis equal;
    caxis([0 globalUpper])
    view(0,90)
    print(gcf,['../Figs/plot_' num2str(caseI) '.png'],'-dpng','-r400');
 
end
 