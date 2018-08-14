figure;
set(gcf,'outerposition',get(0,'screensize'));
critical_distance=10;
time_interval=[];
light_integral=[];
for e=1:1:number
    e
    length_particle=length(particle{e});
    if length_particle ~=0
        periods=[];
        periods_new=[];
        length_particle=length(particle{e});
        time=particle{e}(:,1 );
        xp=100*particle{e}(:,3);
        yp=100*particle{e}(:,4);
        yp=double(yp);
        zp=100*particle{e}(:,5);
        light_integral_i=trapz(time,yp)/390.95/20*2;
        light_integral=[light_integral light_integral_i];
        different=diff(yp);
        length_different=length(different);
        for i=1:length_different-1
            if sign(different(i))~=sign(different(i+1))
                periods=[periods  i+1 i+1];
            end
        end
        periods=[1 periods length_particle];
        periods=reshape(periods,2,[]);
        periods=periods.';
        length_periods=length(periods);
        a=periods(end,1);
        periods=[periods; a a; a a];
        for i=1:length_periods
            if  abs(yp(periods(i,2))-yp(periods(i,1)))>critical_distance
                periods_new=[periods_new;periods(i,:)];
            else
                if  abs(yp(periods(i+2,2))-yp(periods(i,1)))>critical_distance ...
                        &&  abs(yp(periods(i+1,2))-yp(periods(i+1,1)))<critical_distance ...
                        && abs(yp(periods(i+2,2))-yp(periods(i+2,1)))<critical_distance
                    periods_new=[periods_new;periods(i,1) periods(i+2,2)];
                end
            end
        end
        length_periods_new=length(periods_new);
        %%
%             for i=1:length_periods_new
%                     scatter3(zp(periods_new(:,1)),xp(periods_new(:,1))...
%                     ,yp(periods_new(:,1)),15,yp(periods_new(:,1)),'filled');
%                     plot3(zp(periods_new(i,1):periods_new(i,2)),xp(periods_new(i,1):...
%                     periods_new(i,2)),yp(periods_new(i,1):periods_new(i,2)));
%                         axis equal
%                         colormap jet;
%                         colorbar;
%                         xlim([-60 60])
%                         ylim([-160 160])
%                         zlim([0 25])
%                         hold off;
%                         view(-90,90);
%                         hold on;
%             end
        %%
                plot(time,yp);
                for i=1:length_periods_new
                        hold on;
                        plot(time(periods_new(i,1):periods_new(i,2)),...
                        yp(periods_new(i,1):periods_new(i,2)),'LineWidth',2);
        %             xlim([0 200])
                end
                hold off;
        %%
        if isempty(periods_new)==0
            haha=diff(time(periods_new(:,1)));
            % hist(haha,30)
            % xlim ([0 30])
            time_interval=[time_interval;haha];
        end
    end
    pause(0)
end
%             xlabel('x')
%             ylabel('z')
%             zlabel('y')
%             axis equal
%             xlim([-60 60])
%             ylim([-160 160])
%             zlim([0 25])
figure;
% hist(light_integral,1000)
hist(time_interval,1000)