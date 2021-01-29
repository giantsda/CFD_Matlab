divide_number=100;
connect_size=5000;
first_catagory=[];
end_catagory=[];
first_position=[];
end_position=[];
connectid=[];
first_end=[];
connected_particle=[];
for e=1:1:number
matrixsize=size(particle{e});
matrixsize=matrixsize(1);
    if matrixsize ~=0
    time=particle{e}(:,1);
    xp=100*particle{e}(:,3);
    yp=100*particle{e}(:,4);
    zp=100*particle{e}(:,5);
    cut=find(xp>-50 & xp<-48 & zp>0);
        if isempty(cut)==1
            partilce{e}=[];
           fprintf([num2str(e) ' is empty\n']);
        else
        first_position=[first_position; particle{e}(cut(1),3:5)*100 particle{e}(1,2)];
        end_position=[end_position; particle{e}(cut(end),3:5)*100 particle{e}(end,2)];
        particle{e}(cut(end):end,:)=[];    
        particle{e}(1:cut(1),:)=[];
        end
    end
end
% plot3(first_position(:,3),first_position(:,1),first_position(:,2),'o');
% plot3(end_position(:,3),end_position(:,1),end_position(:,2),'o');
% axis equal
% xlim([-60 60])
% ylim([-160 160])
% zlim([0 25])
max1=max(first_position(:,2));
max2=max(end_position(:,2));
if max1<=max2
    max1=max2;
end
divide_v=linspace(0,max1,divide_number+1);
for i=1:1:divide_number
k1=find(first_position(:,2)>=divide_v(i) & first_position(:,2)<divide_v(i+1));
first_catagory{i}=k1;
k2=find(end_position(:,2)>=divide_v(i) & end_position(:,2)<divide_v(i+1));
end_catagory{i}=k2;
end
for i=1:1:number
    for j=1:1:divide_number
        k=find(first_catagory{j}==i);
        if isempty(k)==0
            first_end(i,1)=j;
        end
    end
    for j=1:1:divide_number
        k=find(end_catagory{j}==i);
        if isempty(k)==0
            first_end(i,2)=j;
        end
    end
end
connect_id(1)=1;
first=first_end(connect_id(1),1);
last=first_end(connect_id(1),2);
for i=1:1:connect_size
v_size=size(first_catagory{last});
v_size=v_size(1);
connect_id(i)=first_catagory{last}(randi([1 v_size]));
first=first_end(connect_id(i),1);
last=first_end(connect_id(i),2);
end
%%
for i=1:1:5000
    if rem(i,100)==0
        i
    end
    size_connected_particle=size(connected_particle);
    size_connected_particle=size_connected_particle(1);
    size_add=size(particle{connect_id(i)});
    size_add=size_add(1);
    connected_particle(size_connected_particle+1:size_connected_particle+size_add,1)=particle{connect_id(i)}(:,4)*100;   
end
size_connected_particle=size(connected_particle);
size_connected_particle=size_connected_particle(1);
connected_particle(:,2)=[0:0.02:0.02*(size_connected_particle-1)];


