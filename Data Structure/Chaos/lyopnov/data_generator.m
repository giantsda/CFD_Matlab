function  [embed,box_finder,box_neighbour,box_index] =data_generator(data,t,dim,dismax)
data=data-min(data);
data_max=max(data);
l=dismax*2;
embed=zeros(length(data)-(dim-1)*t,dim);
m=0:t:(dim-1)*t;
for i=1:length(data)-(dim-1)*t
    j=i+m;
    embed(i,:)=data(j).';
end
% plot3(embed(:,1),embed(:,2),embed(:,3),'.', 'MarkerSize', 3)
box_index=zeros(length(embed),dim+1);
for i=1:length(embed)
    box_index(i,:)=[floor(embed(i,:)/l) i];
end
D= sortrows(box_index,[1:dim]);
for i=1:length(D)
    if isempty(nonzeros(D(i,1:dim)))==0
        break;
    end
end
D(1:i,:)=[];
D=[NaN(1,dim+1) ;D];
box_finder=zeros(length(D),dim);
i_box=1;
box_neighbour=[];
for i=2:length(D)
    if isempty(nonzeros(D(i,1:dim)-D(i-1,1:dim)))==0  % if (D(i)~=D(i-1))
        box_neighbour{i_box}=D(i,dim+1);
        box_finder(i_box,:)=[D(i,1:dim)];
        for j=i+1:length(D)
            if isempty(nonzeros(D(j,1:dim)-D(j-1,1:dim)))==1 %if (D(i)==D(i-1))
                box_neighbour{i_box}=[box_neighbour{i_box} D(j,dim+1)];
            else
                break;
            end
        end
        i_box=i_box+1;
    end
end
for i=length(box_finder):-1:1
    if  isempty(nonzeros(box_finder(i,:)))==0 % is not empty
        break
    end
end
box_finder(i+1:end,:)=[];