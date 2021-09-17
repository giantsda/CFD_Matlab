[Boun,L,N] = bwboundaries(D);
stats=  regionprops(L, 'Centroid', 'Area', 'Perimeter');
Area = cat(1,stats.Area);
Centroid = cat(1, stats.Centroid);
Perimeter = cat(1,stats.Perimeter);
%% sort Area
[Area,I]=sort(Area,'descend')
Centroid=Centroid(I,:);
Perimeter=Perimeter(I);
Boun=Boun(I);

I=find(Area>2000)
Area=Area(I);
Centroid=Centroid(I,:);
Perimeter=Perimeter(I);
Boun=Boun(I);

I=find(Centroid(:,2)>435);



E([1 end],:)=255;
E(:,[1 end])=255;
imshow(rot90(1-E),[]);
axis equal;
hold on;
for i=1:length(I)
    n=I(i);
    BounI=[Boun{n}(:,1), size(D,2)-Boun{n}(:,2)+1];
    plot(BounI(:,1),BounI(:,2), 'r', 'LineWidth', 1)
end
A=zeros(size(rot90(1-E)));
[row,col] =find(A==0);
in=inpolygon(col,row,BounI(:,1),BounI(:,2)); % determine if points in boundry
A=rot90(1-E);
A(A~=-254)=0;
A(A==-254)=-1;
A((in==0))=0; % remove points not in boundry

r=size(A,1);
percentageS=zeros(1,size(A,2));
for i=r:size(A,2)
    percentage=length(find(A(:,i)==-1))/r;
    percentageS(i)=percentage;
    %     if percentage<0.4
    %         break;
    %     end
end
above=find(percentageS>=0.2);
if isempty(above)
    i=1;
else
    i=above(end);
end
switch caseN
    case 213
        turnerEnd=2.35; %location of the outlet
    case 214
        turnerEnd=2.45;
    case 215
        turnerEnd=2.23; %location of the outlet
    case 216
        turnerEnd=2.28;
    case 217
        turnerEnd=2.33; %location of the outlet
    case 218
        turnerEnd=2.38;
    otherwise
        turnerEnd=0.16;
end

[~,index]=min(abs(xMesh-turnerEnd));
plot([index; i] ,[floor(r/2); floor(r/2)],'b','LineWidth',2);
plot([index;index],[0;r],'b','LineWidth',2);
criticalDistance=(xMesh(i)-xMesh(index))/radius;

%% persistence length of paddle wheel
I=find(Centroid(:,2)<435);
if length(I)>1
    error("Look at Line 80")
end

 
n=I 
BounI=[Boun{n}(:,1), size(D,2)-Boun{n}(:,2)+1];
% plot(BounI(:,1),BounI(:,2), 'r', 'LineWidth', 1)
 
A=zeros(size(rot90(1-E)));
[row,col] =find(A==0);
in=inpolygon(col,row,BounI(:,1),BounI(:,2)); % determine if points in boundry
A=rot90(1-E);
A(A~=-254)=0;
A(A==-254)=-1;
A((in==0))=0; % remove points not in boundry

r=size(A,1);
percentageS=zeros(1,size(A,2));
for i=r:size(A,2)
    percentage=length(find(A(:,i)==-1))/r;
    percentageS(i)=percentage;
    %     if percentage<0.4
    %         break;
    %     end
end
above=find(percentageS>=0.2);
if isempty(above)
    i=1;
else
    i=above(end);
end


[ index]= min(BounI(:,1))
plot([index; i] ,[floor(r/2); floor(r/2)],'-','LineWidth',2,'Color',[0.4660 0.6740 0.1880]);
plot([index;index],[0;r],'-','LineWidth',2,'Color',[0.4660 0.6740 0.1880]);
criticalDistance=(xMesh(i)-xMesh(index))/radius;





hold off;
title(['Ucritical=' num2str(Ucritical) 'criticalDistance=' num2str(criticalDistance,'%10.2f') '*Radius']);

criticalLength{caseN}(ii,1)=Ucritical;
criticalLength{caseN}(ii,2)=criticalDistance;
print(gcf,['D:\CFD_second_HHD\06232021\204\Data\Case_' num2str(caseN) '_Ucritical=' num2str(Ucritical) '.png'],'-dpng','-r800');
%         saveas(gcf,['D:\CFD_second_HHD\06232021\204\Data\Case_' num2str(caseN) '_Ucritical=' num2str(Ucritical) '.png'])
ii=ii+1;

