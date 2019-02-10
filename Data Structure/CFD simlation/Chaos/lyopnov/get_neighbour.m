function boxs=get_neighbour(oldp,box_index,box_neighbour,box_finder)
oldp_index=box_index(oldp,1:end-1);
dim=3;
boxs=[];
bi=dec2base(0:3^dim-1,3);
[column,row]=size(bi);
h=zeros(column,row);
for ii=1:column
    for jj=1:row
        h(ii,jj)=str2double(bi(ii,jj));
    end
end
h=h-1;
for i=1:length(oldp_index)
    h(:,i)=h(:,i)+oldp_index(i);
end
for i=1:length(h)
    R=bisearch(box_finder,h(i,:));
    boxs=[boxs box_neighbour{R}];
end
 