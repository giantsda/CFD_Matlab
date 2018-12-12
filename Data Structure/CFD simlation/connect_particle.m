%% 
% It is assumed that the velocity of the current time step is the postion
% of this time step minus the position of last time step and divided by the
% differende of time step size.
%% generate velocitypart for particle_pos_generator
% number=length(particle);
% for e=1:number
%     particle{e}(19:end,:)=[];  % Change this every time!!!!!!!!
% end
% folder_path='E:\desktop\CFD\Raceway_pond_and_Peers_PBR_03132016--\connect study\Connect procedure';
% velocitypart=zeros(number+2,12);
% for e=1:number
%     particle_current=particle{e};
%     vx=(particle_current(end,3)-particle_current(end-1,3))/(particle_current(end,1)-particle_current(end-1,1));
%     vy=(particle_current(end,4)-particle_current(end-1,4))/(particle_current(end,1)-particle_current(end-1,1));
%     vz=(particle_current(end,5)-particle_current(end-1,5))/(particle_current(end,1)-particle_current(end-1,1));
% % %                  particle_current(end+1,7:9)=[vx, vy, vz];
%     velocitypart(e+2,1:3)=particle_current(end,3:5);
%     velocitypart(e+2,4:6)=[vx vy vz];
% end
% clearvars -except number folder_path velocitypart particle
% save([folder_path '\velocitypart.mat']);
% disp( [folder_path '\velocitypart.mat generated............. \n']);

%% Connect two particle files


%% Read data
this code reads three files : .inj, before, connect, after
folder_path='E:\desktop\CFD\Raceway_pond_and_Peers_PBR_03132016--\connect study\Connect procedure';
filename = '8004_for connect.inj';
filename=[folder_path '\' filename];
disp(['reading  ' filename]);
data = importdata(filename);
injection=[]; % Read .inj file and store in injection
for i=3:length(data)
line=data{i};
line(1:2)=[];
line(end-2:end)=[];
injection(i,:)=str2num(line);
end

file_name1 = 'before';
file_name1=[folder_path '\' file_name1];
load(file_name1);
particle_before=particle;
clear particle;
disp(['reading  ' file_name1]);

file_name2 = 'connect';
file_name2=[folder_path '\' file_name2];
load(file_name2);
particle_connect=particle;
clear particle;
disp(['reading  ' file_name2]);

file_name3 = 'after';
file_name3=[folder_path '\' file_name3];
load(file_name3);
particle_after=particle;
clear particle;
disp(['reading  ' file_name3]);
clearvars -except particle_before particle_connect particle_after folder_path injection


%% Connect
cut_time=59.2929;
i=find(abs((particle_before{1}(:,1)-cut_time))<=1e-4);
j=find(abs((particle_before{5}(:,1)-cut_time))<=1e-4);
if i-j~=0
    disp('You are in trouble.\n')
else
    disp([ 'particles has consistent time.  it is' num2str(particle_before{1}(i,1)) ]);
end

for e=1:length(particle_before)
    particle_before{e}(i:end,:)=[];
end

if (length(particle_before)==length(particle_connect)) && (length(particle_connect)==length(particle_after))
    disp('No particle is lost') % check and connect simplely
    wrong=0;
      for e=1:length(particle_after)
        if particle_after{e}(1,:)==particle_connect{e}(1,:)
            particle_after{e}(:,6)=particle_connect{e}(1,6);
        else
            fprintf('particle %d is lost \n', e);
            wrong=wrong+1;
        end
      end
    
        if wrong==0
            for e=1:length(particle_before)
                    particle_before{e}=[particle_before{e};particle_after{e}];
            end
        end
    
else
    disp('Some particles are lost, this is going to be tedious')
    for e=1:length(particle_before)
        particle_before{e}(:,6)=e+9000000-1;  %% This is because how .inj files are generated. The first particle always has temperature of 9000000.
    end
    
    for e=1:length(particle_after)
        if particle_after{e}(1,:)==particle_connect{e}(1,:)
            particle_after{e}(:,6)=particle_connect{e}(1,6);
        else
            fprintf('particle %d is lost \n', e);
            i==e;
        end
    end
end
 


