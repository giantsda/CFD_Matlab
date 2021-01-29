
%  This file read data from PT files and generate the 3D distribution
% it is 3D because it plots left positon, right position, and probablility
% step1 read data and store to particle ;
% step2 detact the region of each line and denote it at the 6 column;
% step3 for each particle, color=particle{e}(:,6); find the position that
% the 6 column is 1 2 3 and 4;
% step4 generate region_index to store pairs of region 1;
% step5 convert  to region_po  whcih stores all the in and out position;
% step6 collect datas and generate distribution
% step7 generate zz and Interpolate scattered data by griddata
%%
region_po=[];
for e=1:5000
    %     e=112;
    disp(['particleID = ' num2str(e)])
    matrixsize=size(particle{e});
    matrixsize=matrixsize(1);
    if matrixsize ~=0
        time=particle{e}(:,1);
        xp=100*particle{e}(:,3);
        yp=100*particle{e}(:,4);
        zp=100*particle{e}(:,5);
        % add particle(:,6) to denote the region of this data
        for ii=1:matrixsize
            if xp(ii)>=-72 && xp(ii)<=72  && zp(ii)<0
                particle{e}(ii,6)=1;
            else if xp(ii)>72;
                    particle{e}(ii,6)=2;
                else if xp(ii)>=-72  && xp(ii)<=72  && zp(ii)>0
                        particle{e}(ii,6)=3;
                    else if xp(ii)<-72
                            particle{e}(ii,6)=4;
                        end
                    end
                end
            end
        end
        color=particle{e}(:,6);
        k1=find(color(:,1)==1);
        k2=find(color(:,1)==2);
        k3=find(color(:,1)==3);
        k4=find(color(:,1)==4);
        if isempty(k1)==0 && isempty(k2)==0 &&isempty(k3)==0 &&isempty(k4)==0
            region_index=k1(1);
            for ii=1:size(k1)-1
                if k1(ii+1)-k1 (ii)~=1
                    region_index=[region_index k1(ii) k1(ii+1 )];
                end
            end
            % store all the i/o pairs in that region in order to plot the distribution
            region_index_size=size(region_index);
            region_index_size=region_index_size(2);
            if   region_index_size >5;   % this may cause problem!!!
                if particle{e}(1,6)~=1
                    region_index(end)=[];
                else
                    region_index(end)=[];
                    region_index(1:2)=[];
                end
                region_position_i=reshape(region_index,2,[]);
                region_position_i=region_position_i.';
                region_position_i=yp(region_position_i);
                region_po=[region_po; region_position_i];
            end
        end
    end
end

% region_po_save=[region_po_save; region_po];
% end
%  region_po=region_po_save;

%% collect data
divide_number=40;
data_sub=cell(divide_number,1);
for ii=1:divide_number
    haha=find(region_po(:,1)>=20/50*(ii-1) & region_po(:,1)<=20/50*(ii));
    data_sub{ii}=haha;
end
xbin=[0.5:0.3:22.5];
zz=[];
for ii=1:divide_number
    data_sub_size=size(data_sub{ii}); %%to normolize it since ther may have different numbers
    data_sub_size=data_sub_size(1);
    haha=region_po(data_sub{ii},2);
    [counts,centers] = hist(haha,xbin );
    counts=counts.'/data_sub_size;
    zz=[zz counts];
    % hist(haha,xbin)
    % plot(counts);
    % pause()
    % ii
end
xx=(1:divide_number)/divide_number*20;
for i=1:2
    xx(end)=[];
    zz(:,end)=[];
end
yy=centers;
[Xq,Yq] = meshgrid(0:0.05:22);
Vq = griddata(xx,yy,zz,Xq,Yq,'cubic');
Vq=Vq/max(max(Vq));
[row,column]=size(Vq);
for k=1:column
    for i=1:row
        if isnan(Vq(i,k))==1
            Vq(i,k)=0;
        end
    end
end
%%
figure;
set(gcf,'outerposition',get(0,'screensize'));
surf(Xq,Yq,Vq,'edgecolor', 'none');
colormap jet
colorbar
xlabel('initial position')
ylabel('left position')
zlabel('probability')
% shading interp