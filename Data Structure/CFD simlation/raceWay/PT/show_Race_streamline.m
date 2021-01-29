%%  This file read particle to plot pathline and y position history
figure;
set(gcf,'outerposition',get(0,'screensize'));
clear M;
timelimitfactor=1;
timevector=[];
for d=1:1:number         % calcuate the avarage time period
    matrixsize=size(particle{d});
      matrixsize=matrixsize(1);
     if matrixsize ~=0
            time=particle{d}(:,1);
            time=time(end); 
            timevector=[timevector time];
            d=d+1;
     end
end
mediumtime=median(timevector);
timelimit=timelimitfactor*mediumtime;
del=0;% how many particles I have deleted
% for d=1:1:number % calcuate the avarage time period
%      matrixsize=size(particle{d});
%       matrixsize=matrixsize(1);
%      if matrixsize ~=0
%         time=particle{d}(:,1);
%         time=time(end);
%             if time <timelimit
%                 particle{d}=[];   %delete  the particle if the time period is less than 0.8*average
%                 del=del+1;
%             end
%      end
% end
%%
i=1;
for e=1:1:500
%     e=121
matrixsize=size(particle{e});
matrixsize=matrixsize(1);
if matrixsize ~=0
time=particle{e}(:,1);
xp=100*particle{e}(:,3);
yp=100*particle{e}(:,4);
zp=100*particle{e}(:,5);
%% plot
subplot(2,1,1)
hold on;
k1=find(xp>-72 & xp<72 & zp<0);  %k1 is the location that meet the criteria
k2=find(xp>72);
k3=find(xp>-72 & xp<72 & zp>0);
k4=find(xp<-72);
    l1=diff(k1); %l1is the difference of the location, l1 is 1 length shorter than k1
    l2=find(l1>20);
    l3=k1(l2+1);   
    % if  k1(1)~=1
    %     l2=[k1(1) ; l2];
    % end
    num_round=size(l3);
    num_round=num_round(1);
plot3(zp(k1), xp(k1), yp(k1),'r.','LineWidth',0.2)
plot3(zp(k2), xp(k2), yp(k2),'k.','LineWidth',0.2)
plot3(zp(k3), xp(k3), yp(k3),'b.','LineWidth',0.2)
plot3(zp(k4), xp(k4), yp(k4),'m.','LineWidth',0.2)
    xlabel('x')
    ylabel('z')
    zlabel('y')
    axis equal
xlim([-60 60])
ylim([-160 160])
zlim([0 25])
hold off;
view(-50,10);
% view(-90,0);
%%
subplot(2,1,2)
xlabel('time(s)')
ylabel('yposition')
ylim([0 22])
hold on;
plot(time(k1),yp(k1),'r.','MarkerSize',5);
plot(time(k2),yp(k2),'k.','MarkerSize',5);
plot(time(k3),yp(k3),'b.','MarkerSize',5);
plot(time(k4),yp(k4),'m.','MarkerSize',5);
plot(time(l3),yp(l3),'go','MarkerFaceColor','g');
% xlim([0 100])
hold off;
suptitle(['This the history of Particle ID=' num2str(e) 'roundnumber= ' num2str(num_round) ]);
%%
pause(  );      
end
%  M(i)=getframe(gcf);
 i=i+1
end
% movie2avi(M,'E:\desktop\temp\1.avi','FPS',10,'quality',100)
