%The length of the straight channel does not significantly change the critical velocity,
%thus the critical vertical velocity is redefined as the 20 percent of the vertical velocity
%in the box that is defined as a rectangle of radius and 2*radius.

MainPath='D:\CFD_second_HHD\02212020\130';
cd (MainPath);
inspectLocationRaduis=0.05;
 
 
MeanmagU=zeros(1,62);
MeanUx=zeros(1,62);
for i=[1:62]
    caseN=i
    Data={};
    cd (MainPath);
    cd (num2str(i));
    load('Data.mat');
    if i>=1 && i<=8 
        inspectLocation=[0.876325,0.250614,0.1];
    elseif i<=16 || i==57
        inspectLocation=[0.415441,0.102496,0.1];
    elseif i<=24|| i==58
        inspectLocation=[0.364387,0.0870837,0.1];
    elseif i<=32|| i==59
        inspectLocation=[0.513157,0.138519,0.1];
    elseif i<=40|| i==60
        inspectLocation=[0.620733,0.180767,0.1];
    elseif i<=48|| i==61
        inspectLocation=[1.16492,0.516,0.1];
    elseif i<=56|| i==62
        inspectLocation=[1.94195,0.67542,0.1];
    end
    
    
    %% Find the examine box.
    box=find(Data.mesh(:,1)>=inspectLocation(1)-inspectLocationRaduis & Data.mesh(:,1)<=inspectLocation(1)+inspectLocationRaduis ...
        & Data.mesh(:,2)>=inspectLocation(2)-inspectLocationRaduis & Data.mesh(:,2)<=inspectLocation(2)+inspectLocationRaduis ...
        & Data.mesh(:,3)>=inspectLocation(3)-inspectLocationRaduis & Data.mesh(:,3)<=inspectLocation(3)+inspectLocationRaduis);
    
    
    Data.mesh=Data.mesh(box,:);
    Data.vof=Data.vof(box,:);
    for n=1:length(Data.U)
        Data.U{n}=Data.U{n}(box,:);
    end
    fprintf("Done with reading data.\n");
    
    Us=vertcat(Data.U{:});
    magU=sqrt(Us(:,1).^2+Us(:,2).^2+Us(:,3).^2);
    MeanmagU(caseN)=mean(magU);
    MeanUx(caseN)=mean(abs(Us(:,1)));
    
%     load handel
%     sound(y/5,Fs)
end

% clearvars -except MeanmagU MeanUx MainPath
% save([MainPath '/MeanVekocity.mat'], '-v7.3');
disp('store UcriticalStore to MainPath.............. \n');

MeanmagUSorted=MeanmagU(results.Index);
MeanUxSorted=MeanUx(results.Index);
plot(MeanmagUSorted);
hold on;
plot(MeanUxSorted);



