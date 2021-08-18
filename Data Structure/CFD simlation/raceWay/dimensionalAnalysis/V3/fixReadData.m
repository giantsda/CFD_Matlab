% the criticalU4 is define as the critical vertical velocity so that the
% critical length is 4*R

oPath=pwd();
MainPath='D:\CFD_second_HHD\02212020\130\Data';
cd (MainPath);

criticalU4=[];
for i=[103]
    caseN=i
    Data={};
    cd (MainPath);
    load(['Data_' num2str(caseN) '.mat']);
    fprintf("Done with reading data.\n");
    
    %% fix
    i=find(Data.mesh(:,3)>0.1); % remove the nodes that is adjcent to air. Data here will have close to 1 vof but huge velocity.                                                            
                                                                                                                                                                                     
    Data.mesh(i,:)=[];                                                                                                                                                                        
    Data.vof(i,:)=[];                                                                                                                                                                        
    for n=1:length(Data.U)                                                                                                                                                                                   
        Data.U{n}(i,:)=[];                                                                                                                                                                      
    end          
    
    save([MainPath '\Data_' num2str(caseN) '.mat'],'Data', '-v7.3');
    fprintf("Writtern data.\n");
end



   