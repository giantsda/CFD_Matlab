  %% convert scatter plot to grid plot
    D=[];
    for i=1:length(xMesh)
        i/length(xMesh)*100
        xx=xMesh(i);
        for j=1:length(yMesh)
            yy=yMesh(j);
%             E=Data.mesh(:,1:2);
            C=abs(Data.unoverlapedMesh-[xx yy]);
            C(:,3)=sqrt(C(:,1).^2+C(:,2).^2);
            minDistance=min(C(:,3));
            if minDistance<=critcal
                D(i,j)=100;
            end
            C=abs(B(:,1:2)-[xx yy]);
            C(:,3)=sqrt(C(:,1).^2+C(:,2).^2);
            minDistance=min(C(:,3));
            if minDistance<=critcal
                D(i,j)=255;
            end
        end
    end
    
    [Boun,L,N] = bwboundaries(D);
    stats=  regionprops(L, 'Centroid', 'Area', 'Perimeter');
    Area = cat(1,stats.Area);
    Centroid = cat(1, stats.Centroid);
    Perimeter = cat(1,stats.Perimeter);
    [~, n]=max(Area);
    
    surf(x,y,rot90(D)/max(max(D)),'edgecolor','none');
    axis equal;
    colorbar;
    view(0,-90);
 
%      imshow(rot90(1-D))
    hold on;
    criticalDistance=xMesh(max(Boun{n,1}(:,1)))-xmin;
    plot(Boun{n}(:,1), size(D,2)-Boun{n}(:,2)+1, 'r', 'LineWidth', 1)
    hold off;
    title(['criticalDistance=' num2str(criticalDistance)]);