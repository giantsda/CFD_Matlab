 
oPath=pwd();

path='D:\CFD_second_HHD\07162021\242\242\800s'
cd(path);
Data=[];
for caseI=1:56
    load(['particle_' num2str(caseI) '.mat']);  
    ['particle_' num2str(caseI) '.mat']
    interval=zeros(1,2000000);
    number=length(particle);
    %% get maxY for liquid depth
    p = randi([1,number],50,1);
    posZ=[];
    for i=1:length(p)
        posZ=[posZ;particle{i}(:,5)];
    end
    [counts,centers] = hist(posZ,200);
    counts=counts/sum(counts);
    waterDepth=centers(max(find(counts>=mean(counts))));  

    Data.particle=particle;
    Data.number=number;
    Data.waterDepth=waterDepth;

    save(['particle_' num2str(caseI) '.mat'],'Data','-v7.3');
end

 
% clearvars -except particles   path
% save([path '\allParticles.mat'], '-v7.3');
% disp('store all data to allParticles.............. \n');



