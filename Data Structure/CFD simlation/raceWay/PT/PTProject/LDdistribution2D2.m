% % %% This file will convert particles vertical position to light intesity, and statistial
% % %% result will be calculated form the light intensity history.
% % I believe it first introduce a light intensity function and then use
% % findpeaks to find all local peaks with that meets some requirements.
oPath=pwd();
path='D:\CFD_second_HHD\07162021\242\242\safe'
cd(path);

figure;
set(gcf, 'Position', get(0, 'Screensize'));


result={};

for caseI=33:40
    load(['particle_' num2str(caseI) '.mat']);
    particle=Data.paritlce;
    number=Data.number;
    waterDepth=Data.waterDepth;
    
    xMax=-Inf;
    xMin=Inf;
    yMax=-Inf;
    yMin=Inf;
    %% determine boundary of mesh
    for i=1:60
        xMaxI=max(particle{i}(:,3));
        xMinI=min(particle{i}(:,3));
        yMaxI=max(particle{i}(:,4));
        yMinI=min(particle{i}(:,4));
        
        if (xMaxI>xMax)
            xMax=xMaxI;
        end
        
        if (xMinI<xMin)
            xMin=xMinI;
        end
        if (yMaxI>yMax)
            yMax=yMaxI;
        end
        if (yMinI<yMin)
            yMin=yMinI;
        end
        
    end
    yresolution=120;
    yMesh=linspace(yMin,yMax,yresolution);
    dy=(yMax-yMin)/yresolution;
    xMesh= xMin:dy:xMax;
    
    LDLocation=[];
    for e=1:number
        if ~isempty(particle{e})
            x_pos=particle{e}(:,3);
            y_pos=particle{e}(:,4);
            z_pos=particle{e}(:,5);
            z_pos=waterDepth-z_pos;
            time=particle{e}(:,1);
            
            light_history=1./exp(40*(z_pos)) *500;
            
            [pks,locs] = findpeaks(light_history,'MinPeakHeight',100,'MinPeakProminence',80);
            
            
            above=find(light_history>=100);
            out=zeros(length(above),7);
            
            if ~isempty(out)
                
                plot(light_history)
                j=1;
                for i=2:length(above)
                    if above(i,1)-above(i-1,1)~=1
                        out(j,1)=i;
                        j=j+1;
                    end
                end
                out(j:end,:)=[];
                out(:,2)= [(out(2:end,1)-1); length(above)];
                out(:,3:4)=above(out(:,1:2));
                LDLocation=[LDLocation;[x_pos(out(:,3)) y_pos(out(:,3))]];
                
            end
        end
    end
    %     scatter(LDLocation(:,1),LDLocation(:,2),3);
    D=zeros(length(xMesh),length(yMesh));
    
    
    for i=1:length(xMesh)
        i/length(xMesh)*100
        xx=xMesh(i);
        for j=1:length(yMesh)
            yy=yMesh(j);
            C=abs(LDLocation(:,1:2)-[xx yy]);
            C(:,3)=sqrt(C(:,1).^2+C(:,2).^2);
            %             find(C(:,3)<dy/2)
            D(i,j)=D(i,j)+length(find(C(:,3)<dy/2));
            
            
        end
    end
    
    [X,Y] = meshgrid(xMesh,yMesh);
    [counts,centers] = hist(D,20);
    %  D(D>floor(centers(end/2)))=floor(centers(end/2));
    
    clearvars -except X Y D caseI
    save(['..\Figs\plot_' num2str(caseI) '.mat'], '-v7.3');
    
    D(D>10)=10;
    surf(X,Y,D.','edgecolor', 'none')
    
    colormap jet
    colorbar
    axis equal;
    view(0,90)
    print(gcf,['..\Figs\plot_' num2str(caseI) '.png'],'-dpng','-r400');
    
    
end
%
% cd (oPath)