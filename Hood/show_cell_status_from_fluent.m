% %% this code reads files, stores datat to sample.mat, read it and plot
% 
% folder='E:\desktop\temp\why\'
% files=dir([folder 'scalar-*.*']);
% scalar=[];
% w=1;
% change_tag=1;
% fliter_layer=0;
% for f=1:length(files)
%     filename=[folder files(f).name];
%     disp(['Reading ' filename]);
%     delimiterIn = ','; %read txt file
%     headerlinesIn=1;
%     data_m = importdata(filename,delimiterIn,headerlinesIn);
%     A=data_m.data;
%     if change_tag
%         A=sortrows(A,5);
%         if A(end,5)~=0
%             table=tabulate(A(end-2:end,3));
%             [value,loc]=max(table(:,2));
%             fliter_layer=table(loc,1)
%             change_tag=0;
%             f_start=f;
%             break;
%         end
%     end
% end
% 
% scalar=cell(1,length(files));
% filename_store=cell(1,length(files));  %  store the file name for time
% parfor f=f_start:1:length(files)
%     filename=[folder files(f).name];
%     disp(['Reading ' filename]);
%     filename_store{f}=filename;
%     delimiterIn = ','; %read txt file
%     headerlinesIn=1;
%     data_m = importdata(filename,delimiterIn,headerlinesIn);
%     A=data_m.data;
%     B=[];
%     for i=1:length(A)
%         if  abs(A(i,3)-fliter_layer)<1e-5
%             B=[B;A(i,:)];
%         end
%     end
%     scalar{f}=B;
% end
% disp('writting all data to scalar.............. \n');
% clearvars -except scalar fliter_layer  folder filename_store
% save([folder 'scalar.mat'], '-v7.3');
% disp('store all data to scalar.............. \n');


%% plot

close all;
clear all;
load ('C:\CFD_second_HHD\HOOD\08182018\19\data\scalar.mat')
figure;
% set(gcf,'outerposition',get(0,'screensize'));
N=250;
for e=1:length(scalar)
    if ~isempty(scalar{e})
%         e=30;
        x=scalar{e}(:,2);
        y=scalar{e}(:,4);
        value=scalar{e}(:,5);
        [v l]=sort(value);
        value(l(end-4:end))=0;
        x_mesh=linspace(min(x),max(x),N);
        y_mesh=linspace(min(y),max(y),N);
        [x1,y1]=meshgrid(x_mesh,y_mesh);
        value_i=griddata(x,y,value,x1,y1);
        h=pcolor(x1,y1,value_i);
        set(h, 'EdgeColor', 'none');
        shading interp;
%         caxis([0 300]);
%         surf(x1,y1,value_i,'edgecolor', 'none');
%         view(-20,82);
        colormap jet;
        colorbar;
        title(filename_store{e})
        pause(0)
    end
end


