
oPath=pwd();

path='D:\CFD_second_HHD\07162021\242\242\200s'
cd(path);

for caseI=25
    load(['particle_' num2str(caseI) '.mat']);
    ['particle_' num2str(caseI) '.mat']
    for p=1:200
        Pos=Data.particle{p};
        plot3(Pos(:,3),Pos(:,4),Pos(:,5));
        hold on;
        axis equal;
        pause(0);
    end
    axis equal;
    title(['case ' num2str(caseI)])
    pause()
    clf;
end