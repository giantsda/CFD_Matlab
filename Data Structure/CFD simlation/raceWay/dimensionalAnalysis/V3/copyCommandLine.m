for i=74:94
    fprintf("cp %d/constant/dynamicMeshDict %d/constant/dynamicMeshDict\n",i,i+72);
end


for i=121:174
    if  ismember(i,[119 127 143 151 159 167 136:143])
        continue;
    else
        fprintf(" cp 120/system/controlDict  %d/system/\n",i);
    end
end



for i=[119]
    fid=fopen([num2str(i) '.sh'],'w');
    fprintf(fid,"#!/bin/bash\n#SBATCH --account=co2cfd\n#SBATCH --time=7-00\n#SBATCH --job-name=%d\n#SBATCH --nodes=1\n#SBATCH --output=log%d\nsource ~/.bashrc\nmodule load openmpi/3.1.6/gcc-8.4.0\n\n",i,i);
    fprintf(fid,"mpirun -np 36 /lustre/eaglefs/projects/co2cfd/software/interFoamPisoOutLoopBreakResetFields/interFoam -parallel -case /lustre/eaglefs/projects/co2cfd/running/130/%d \ncp /lustre/eaglefs/projects/co2cfd/running/130/controlDict  /lustre/eaglefs/projects/co2cfd/running/130/%d/system \nmpirun -np 36 /lustre/eaglefs/projects/co2cfd/software/interFoamPisoOutLoopBreakResetFields/interFoam -parallel -case /lustre/eaglefs/projects/co2cfd/running/130/%d\n\n",i,i,i);
    fclose(fid);    
end

for i=[119:135 143:174]
    fprintf("sbatch %d.sh\n",i);
end
