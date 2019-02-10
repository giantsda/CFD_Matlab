% % clearvars -except data_embed
m=17; % m=dimension
l=64; % l is the length on each dimension
r=max(data_embed)/l;
N=length(data_embed);
grid_number=zeros(N-m+1,m);
for i=1:N-m+1
    temp=[data_embed(i:i+m-1)];
    grid_number(i,:)=[ceil(temp/r) ];
end
D = sortrows(grid_number,[1:m]); % sort grid_number so that we can shrink it 
grid_number=zeros(N-m+1,m+1);
jj=1;
for i=2:length(D)-1
    if isempty(nonzeros(D(i,:)-D(i-1,:)))==0 % if (D(i)~=D(i-1))
        n=1;
        for j=i+1:length(D)-1
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
grid_number(i:end,:)=[];
%  grid_number=grid_number(1:10000,:);
%%
pairs=0;
for j=1:length(grid_number)
    p=grid_number(j,m+1);
    pairs=pairs+p*(p-1)/2;
end
r_s=[r; pairs];
for i=1:10
    i
    grid_number=find_neighbour2(m,grid_number);
    if length(grid_number)<=2*m
        break;
    end
    pairs=0;
    for j=1:length(grid_number)
        p=grid_number(j,m+1);
        pairs=pairs+p*(p-1)/2;
    end
    r=r*2;
    r_s=[r_s [r;pairs]];
end
cc=log(r_s);
p=polyfit(cc(1,:),cc(2,:),1);
plot(cc(1,:),cc(2,:),'o',cc(1,:),polyval(p,cc(1,:)))


