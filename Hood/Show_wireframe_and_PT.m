close all;
time_step_size=0.01;  % need it to convert funny time to its closet flow time.

%% Read wall mesh
filename1 = 'filter_wall';
disp(filename1);
delimiterIn = ','; %read txt file
headerlinesIn = 1;
data_m = importdata(filename1,delimiterIn,headerlinesIn);
data=data_m.data;
shp = alphaShape(data(:,2),data(:,3),data(:,4),0.002);


%% recover all data from particle;
total_row=0;
for e=1:length(particle)
    total_row=total_row+size(particle{e},1);
end
all=zeros(total_row,size(particle{1},2));
line=1;
for e=1:length(particle)
    all(line:line+size(particle{e},1)-1,:)=particle{e};
    line=line+size(particle{e},1);
end

initial_position=zeros(number,6);
for e=1:length(particle)
    initial_position(e,:)=particle{e}(1,:);
end

initial_position=all;
initial_position(:,1)=round(initial_position(:,1)/time_step_size)*time_step_size; % delete wrong particle time
initial_position=sortrows(initial_position,1);
d=[diff(initial_position(:,1)); 0];
repeat=find(d>=time_step_size/20);
repeat(:,2)=repeat(:,1);
for i=2:length(repeat)+1
    repeat(i,1)=repeat(i-1,2)+1;
end
repeat(1)=1;
repeat(end)=length(initial_position);

figure;
set(gcf,'outerposition',get(0,'screensize'));


for i=1:length(repeat)
    plot(shp,'FaceColor','none')
    view(-180,-70);
    axis tight
    axis square;
    xlabel('x');
    ylabel('y');
    zlabel('z');
        zoom(1)
%         campan(0,2)
    hold on;
    id=initial_position(repeat(i,1):repeat(i,2),2);
    xp=initial_position(repeat(i,1):repeat(i,2),3);
    yp=initial_position(repeat(i,1):repeat(i,2),4);
    zp=initial_position(repeat(i,1):repeat(i,2),5);
    
    scatter3(xp,yp,zp,10,id,'filled');
    title(num2str(initial_position(repeat(i,1),1),'%1.5f'))
    hold off;
    pause(  )
end