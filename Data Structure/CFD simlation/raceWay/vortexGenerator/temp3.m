% the criticalU4 is define as the critical vertical velocity so that the
% critical length is 4*R

MainPath='D:\CFD_second_HHD\06232021\204\Data';
opath=pwd();
cd (MainPath);
criticalU4=[];

for i=[214]
    ii=1;
    caseN=i
%     Data={};
%     cd (MainPath);
%     load(['Data_' num2str(caseN) '.mat']);
    fprintf("Done with reading data.\n");
    
    %% determin critical distance between mesh points
    %     [A, index] = sortrows(Data.mesh(:,1:2),[1 2]); % removing overlapping points
    %     B=A(1,:);
    %     for i=2:length(A)
    %         if  A(i,1)-A(i-1,1)<=0.001&&A(i,2)-A(i-1,2)<=0.001
    %
    %         else
    %             B=[B;A(i,:)];
    %         end
    %     end
    %
    %     B=sortrows(B,[1 2]);
    %     C=B(1:200,:);% exaime a the first 100 poins.since they are sorted, they are at close region.
    %     D=[];
    %     E=[];
    %     for i=1:200
    %         for j=1:200
    %             D(j)=norm(B(i,1:2)-B(j,1:2));
    %         end
    %         D(find(D==0))=[];
    %         E(i)=min(D);
    %     end
    %     meanMeshDistance=mean(E);
    %     critcal=meanMeshDistance*1.5;
    
    critcal=0.01074674;
    radius=(max(Data.mesh(:,2))-min(Data.mesh(:,2)));
    leftPoint=min(Data.mesh(:,1));
    %% get Data.count
    UcriticalS=0.18;
    
    for Ucritical= UcriticalS
        cd (MainPath);
        Ucritical
        Data.count=zeros(length(Data.vof),1);
        for c=1:length(Data.U)
            Data.count(abs(Data.U{c}(:,3))>Ucritical)=1;
        end
        
        if size(Data.mesh,2)==3
            Data.mesh(:,3)=[]; % project to XY plane
        end
        
        i=find(Data.count==1);
        Data.mesh(:,3)=Data.count;
         
        xmin=min(Data.mesh(:,1));
        xmax=max(Data.mesh(:,1));
        ymin=min(Data.mesh(:,2));
        ymax=max(Data.mesh(:,2));
        scatter([xmin xmax],[ymin ymax],18,[1 1],'filled')
        ii=find(Data.count>=1);
        hold on;
        scatter(Data.mesh(ii,1),Data.mesh(ii,2),18,'filled')
        axis equal;
 
        
    end
end
cd (opath)


