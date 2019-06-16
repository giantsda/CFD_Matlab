%% this file is used to connect particle trajectories to get a long-time trajectories 
% histories. It will find a category of particles that has close start vertical position so that 
% the kink at the connected points will be reduced.
load('E:\desktop\CFD\Raceway_pond_and_Peers_PBR_03132016--\10022016\25\particle')
divide_number=100; % defines the number to slice int the vertical direction
connect_size=1000; % how many particle to be connected
first_catagory=[]; % the particleID of each slice
end_catagory=[];
first_position=[]; % defines the start vertical position of each particle The format is:
% [xp yp zp startPosition particleID]
end_position=[];
connectid=[]; % the connected particleID, once it is calculated, the yp can be connected easily
first_end=ones(number,2);    
connected_particle=[];
dt=(particle{1}(end,1)-particle{1}(1,1))/(length(particle{1})-1); % the time step of particle file, used to predic the time of long time file
for e=1:1:number
    particle{e}(:,2)=e; % rename Fluent particleID to 1 based;
    matrixsize=size(particle{e});
    matrixsize=matrixsize(1);
    if matrixsize ~=0
        time=particle{e}(:,1);
        xp=100*particle{e}(:,3);
        yp=100*particle{e}(:,4);
        zp=100*particle{e}(:,5);
        cut=find(xp>-0.05 & xp<0.05 & yp>0);
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
% xlim([-5 5])
% ylim([-5 5])
% zlim([0  30])
%%
maxVerticalPosition=max([max(first_position(:,2))  max(end_position(:,2))]);
divide_v=linspace(0,maxVerticalPosition,divide_number+1);
for i=1:1:divide_number
    k1=find(first_position(:,2)>=divide_v(i) & first_position(:,2)<divide_v(i+1));
    first_catagory{i}=first_position(k1,4); % it stores the particleID that starts in the ith slice
    first_end(first_catagory{i},1)=i;
    k2=find(end_position(:,2)>=divide_v(i) & end_position(:,2)<divide_v(i+1));
    end_catagory{i}=first_position(k2,4);
    first_end(end_catagory{i},2)=i;
end
  
%% calculate connect_id
connect_id(1)=1;
first=first_end(1,1);
last=first_end(1,2);
for i=1:1:connect_size
    v_size=length(first_catagory{last});
    connect_id(i)=first_catagory{last}(randi([1 v_size]));
    last=first_end(connect_id(i),2);
end

%% connect long time yp based on  connect_id
for i=1:1:connect_size
    if rem(i,100)==0
        i
    end
    size_connected_particle=length(connected_particle);
    size_add=length(particle{connect_id(i)});
    connected_particle(size_connected_particle+1:size_connected_particle+size_add,1)=particle{connect_id(i)}(:,4)*100;
end
size_connected_particle=size(connected_particle);
size_connected_particle=size_connected_particle(1);
connected_particle(:,2)=dt*(1:length(connected_particle));
% %% use spline interpolation so that the time step size is 1 second
% xq=[1:1: connected_particle(end,2)];
% interplatedParticle = interp1(connected_particle(:,2),connected_particle(:,1),xq,'spline');
% interplatedParticle(2,:)=xq;
% interplatedParticle=interplatedParticle.';
% % csvwrite('connected_particle.csv',interplatedParticle)
 
