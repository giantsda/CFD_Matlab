%The length of the straight channel does not significantly change the critical velocity,
%thus the critical vertical velocity is redefined as the 20 percent of the vertical velocity
%in the box that is defined as a rectangle of radius and 2*radius.

oPath=pwd();
MainPath='D:\CFD_second_HHD\02212020\130\Data';
cd (MainPath);
% fid=fopen('130UcriticalResultsV2.txt','a');
UcriticalStore={};
for i=[111:118]
    caseN=i
     Data={};
    cd (MainPath);
    load(['Data_' num2str(caseN) '.mat']);
    fprintf("Done with reading data.\n");
    
    %% Find the examine box.
    radius=(max(Data.mesh(:,2))-min(Data.mesh(:,2)));
    leftPoint=min(Data.mesh(:,1));
    box=find(Data.mesh(:,1)<leftPoint+2*radius);
    Data.mesh=Data.mesh(box,:);
    Data.vof=Data.vof(box,:);
    for n=1:length(Data.U)
        Data.U{n}=Data.U{n}(box,3);
    end
    fprintf("Done with reading data.\n");
    
    Us=abs(vertcat(Data.U{:}));
    Us=sort(Us);
    UcriticalStore{caseN}.percent2=Us(floor(length(Us)*(1-0.02)));
    UcriticalStore{caseN}.percent3=Us(floor(length(Us)*(1-0.03)));
    UcriticalStore{caseN}.percent4=Us(floor(length(Us)*(1-0.04)));
    UcriticalStore{caseN}.percent5=Us(floor(length(Us)*(1-0.05)));
    UcriticalStore{caseN}.percent6=Us(floor(length(Us)*(1-0.06)));
    
%         scatter3(Data.mesh(:,1),Data.mesh(:,2),Data.mesh(:,3),2,'b','filled')
%         axis equal;
%         view(0,90);
    
    %     tol=1e-6;
    %     Solution = bisection(@getP,0,1,tol,Data,UcriticalPercentage)
    %     fprintf(fid,"Ucritical=%2.5f\n----------------------------\n",Solution);
    
end

% clearvars -except UcriticalStore MainPath
% save([MainPath '/UcriticalStore.mat'], '-v7.3');
% disp('store UcriticalStore to MainPath.............. \n');

for i=1:length(UcriticalStore)
    if ~isempty(UcriticalStore{i})
    a(i)=UcriticalStore{i}.percent3;
    end
end
 
plot(a,'*-');
hold on;
% plot(results.U);
 
cd (oPath);

% plot (b)
% plot(results.UCritical3);
% legend('new','U','old')



% fclose(fid);

% function Percentage=getP(Ucritical,Data,UcriticalPercentage)
% for n=1:length(Data)
%     U=Data.U{n};
%     P(n)=length(find(U>Ucritical))/length(U);
% end
% Percentage=(mean(P)-UcriticalPercentage);
% % fprintf("Tried %0.8f and got %0.8f\n",Ucritical,Percentage);
% end
%
%
% function p = bisection(f,a,b,tol,varargin)
% % provide the equation you want to solve with R.H.S = 0 form.
% % Write the L.H.S by using inline function
% % Give initial guesses.
% % Solves it by method of bisection.
% % A very simple code. But may come handy
% if f(a,varargin{1},varargin{2})*f(b,varargin{1},varargin{2})>0
%     disp('Wrong choice bro')
% else
%     p = (a + b)/2;
%     err = abs(a-b);
%     while err > tol
%         if f(a,varargin{1},varargin{2})*f(p,varargin{1},varargin{2})<0
%             b = p;
%         else
%             a = p;
%         end
%         p = (a + b)/2;
%         err = abs(a-b);
%     end
% end
% end
