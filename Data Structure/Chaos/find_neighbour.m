function grid_number_new=find_neighbour2(m,grid_number)
% clearvars -except data_embed m grid_number
N=length(grid_number);
grid_number_new=zeros(N,m+1);
bi=dec2bin(0:2^m-1);
[column,row]=size(bi);
h=zeros(column,row);
for ii=1:column
    for jj=1:row
        h(ii,jj)=str2num(bi(ii,jj));
    end
end
w=1;
for i=1:N
    if mod(i,1000)==0
        i
    end
    group=zeros(column,row);
    for j=1:m
        if mod(grid_number(i,j),2)==1;
            origin=grid_number(i,j);
        else
            origin=grid_number(i,j)-1;
        end
        group(:,j)=origin+h(:,j);
    end
    n=0;
    for k=1:2^m
        position=bisearch (grid_number,group(k,:),m);
% position=find(grid_number(:,1)==group(k,1)&grid_number(:,2)==group(k,2)&grid_number(:,3)==group(k,3)&grid_number(:,4)==group(k,4)&grid_number(:,5)==group(k,5));
        if isempty(position)~=1
            n=n+grid_number(position,m+1);
        end
    end
    if n~=0
        grid_number_new(w,:)=[(group(1,:)+1)/2,n];
        w=w+1;
    end
end
for i=length(grid_number_new):-1:1
    if  isempty(nonzeros(grid_number_new(i,:)))==0 % is not empty
        break
    end
end
if i<length(grid_number_new)
    grid_number_new(i:end,:)=[];
end
grid_number_new = unique(grid_number_new,'rows');
grid_number_new = sortrows(grid_number_new,[1:m]);

 