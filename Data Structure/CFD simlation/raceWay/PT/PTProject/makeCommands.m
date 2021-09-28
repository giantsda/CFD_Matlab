% for i=1:56
%     fprintf("cp constant/kinematicCloudProperties ../%d/constant/\n",i);
% end



% for i=2:56
%     fprintf("  cp -r 1/200 %d/200   \n",i);
% end


% for i=1:56
%     fprintf("/lustre/eaglefs/projects/co2cfd/running/icoUncoupledKinematicParcelFoam/icoUncoupledKinematicParcelFoam -case /lustre/eaglefs/projects/co2cfd/running/130/242/%d\n",i);
% end
%
%
% for i=2:56
%     fprintf("cp  1/system/controlDict %d/system/\n",i);
% end

for i=[1:40 49:56]
    fprintf("cp LDdistribution2D_1.m LDdistribution2D_%d.m\n",i);
    fprintf("sed -i 's/for caseI=1/for caseI=%d/g' .\\LDdistribution2D_%d.m  \n",i,i);
end



% for i=[1:40 49:56]
%     fprintf("cp getParticle_1.m getParticle_%d.m\n",i);
%     fprintf("sed -i 's/for caseI=1/for caseI=%d/g' .\\getParticle_%d.m  \n",i,i);
% end


% for i=[1:40 49:56]
%     fprintf("matlab -singleCompThread -nodisplay -nosplash  -r ""run('./getParticle/getParticle_%d.m');exit;"" <foo.txt   > /dev/null &    \n",i);
% end



for i=[1:40 49:56]
    fprintf("matlab -singleCompThread -nodisplay -nosplash  -r ""run('./getParticle/LDdistribution2D_%d.m');exit;"" <foo.txt   > /dev/null &    \n",i);
end


