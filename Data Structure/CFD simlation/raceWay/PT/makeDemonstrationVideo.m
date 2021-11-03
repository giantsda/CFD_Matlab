close all
figure('DefaultAxesFontSize',16)
set(gcf, 'Position', get(0, 'Screensize'));


path='D:\CFD_second_HHD\Plot\Flow';
frame_files = dir([ path '/*.png']);

 
%% this file combine figs to generate a Movie by writeVideo
v = VideoWriter('C:\Users\Chen\Desktop\Light.mp4','MPEG-4');
v.FrameRate=6.5;
v.Quality = 100;
open(v)
begin=1;
middle=1;
 
 
particle=data;
e=23;
DecayConstant=147.45*DryWeight-6.3909;


surface=0.18;
n=1477;
y_pos=particle{e}(412:n,4);
y_pos(y_pos>surface)=surface;
depth=surface-y_pos;
depth(depth<0)=0;

time=particle{e}(412:n,1);
time=double(time)-time(1);

light_history1=1./exp(52.59*(depth)) *500;
light_history2=1./exp(8.3541*(depth)) *500;
for i=1:2: (987)
    subplot(2,2,1);
    plot(time,y_pos);
    hold on;
    plot(time(i),y_pos(i),'r.','MarkerSize',20);
    hold off;
    ylim([0,0.18]);
    xlim([0,60]);
    xticks([0:10:60]);
    ylabel('Vertical position from bottom (m)');
    xlabel('Time (seconds)');
    subtitle('High media density (0.4 mg/L)');
    subplot(2,2,2);
    rectangle('Position',[0,0,5,10],'FaceColor',[1 1 1]*light_history1(i)/500,'EdgeColor','none','LineWidth',3)
    subtitle('Light environment');
    %%
    
    subplot(2,2,3);
    plot(time,y_pos);
    hold on;
    plot(time(i),y_pos(i),'r.','MarkerSize',20);
    hold off;
    ylim([0,0.18])
    xlim([0,60]);
    xticks([0:10:60]);
    ylabel('Vertical position from bottom (m)');
    xlabel('Time (seconds)');
    subtitle('Low media density(0.1 mg/L)');
    subplot(2,2,4);
    rectangle('Position',[0,0,5,10],'FaceColor',[1 1 1]*light_history2(i)/500,'EdgeColor','none','LineWidth',3)
    subtitle('Light environment');
    pause(0)
    frame = getframe(gcf);
    writeVideo(v, frame);
    fprintf('%0.2f %%\n',i/length(time)*100);
end

close(v)
