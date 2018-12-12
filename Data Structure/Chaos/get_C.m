function C=get_C(grid_number,m,r,N)
D = sortrows(grid_number);
grid_number=zeros(N-m+1,m+1);
jj=1;
D=[NaN(1,m); D];
for i=2:length(D)
%     i
    if isempty(nonzeros(D(i,:)-D(i-1,:)))==0  % if (D(i)~=D(i-1))
        n=1;
        for j=i+1:length(D)
            if isempty(nonzeros(D(j,:)-D(j-1,:)))==1 %if (D(i)==D(i-1))
                n=n+1;
            else
                break;
            end
        end
        grid_number(jj,:)=[D(i,:) n];
        jj=jj+1;
    end
end
for i=length(grid_number):-1:1
    if  isempty(nonzeros(grid_number(i,:)))==0 % is not empty
        break
    end
end
grid_number(i+1:end,:)=[];
%%
pairs=0;
grid_number_size=size(grid_number,1);
for j=1:grid_number_size
    p=grid_number(j,m+1);
    pairs=pairs+p*(p-1)/2;
end
C=pairs;