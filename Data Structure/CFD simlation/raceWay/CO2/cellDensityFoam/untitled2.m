
for caseI=27:56
    caseI
    load(['/home/chen/Desktop/project/242/particle_' num2str(caseI) '.mat']);

for i=1:51
    p=particle{i};
    plot3(p(:,3),p(:,5),p(:,4));
    hold on;
    pause(0)
end
axis equal;

pause(0.01)
clf
end

% for i=1:56
%         fprintf("cd %d \n openClean \n cd .. \n",i);
% end


% for i=1:56
%         fprintf("mpirun -np 35 ./mpiMapFields.py ./%d ../%d \n",i ,i+62);
% end


% for i=1:56
%         fprintf("/lustre/eaglefs/projects/co2cfd/running/icoUncoupledKinematicParcelFoam/icoUncoupledKinematicParcelFoam -case /lustre/eaglefs/projects/co2cfd/running/130/242/%d \n",i );
% end

% 
% for i=1:56
%         fprintf("cp -r 1/0 %d/200 \n",i );
% end
% 
% 
