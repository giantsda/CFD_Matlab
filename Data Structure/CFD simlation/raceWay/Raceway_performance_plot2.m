% shows the mixing performance of a raceway pond based on analusing 
% std(verticalPos)


divide_number=100;
n=6;
S_total=pi*( 56*56-2*2)+2*54*198;
S_sub=S_total/divide_number;
A=[];
B=[];
haha=[];
add_i=1;
zuoshang=[-99 -2];
for i=1:divide_number
    delt=S_sub/54;
    for j=1:1:n
        youshang=[zuoshang(1)+delt zuoshang(2)];
        zuoxia=[zuoshang(1) -2-54/n*j];
        youxia=[youshang(1) -2-54/n*j];
        if youshang(1)<99
            A(add_i,1:8)=[zuoshang youshang zuoxia youxia];
        else
            break;
        end
        zuoshang=zuoxia;
        add_i=add_i+1;
    end
    zuoshang=[zuoshang(1)+delt -2];
end
zuoshang=[A(end,7) -2];
sita1=pi-(S_sub-(99-zuoshang(1))*54)/(pi*(56*56-2*2))*2*pi;
for j=1:1:n
    youshang=[99+(2+(j-1)*54/n)*sin(sita1) (2+(j-1)*54/n)*cos(sita1)];
    zuoxia=[zuoshang(1) -2-54/n*j];
    youxia=[99+(2+54/n*j)*sin(sita1) (2+54/n*j)*cos(sita1)];
    A(add_i,1:8)=[zuoshang youshang zuoxia youxia];
    zuoshang(2)=-2-54/n*j;
    add_i=add_i+1;
end
zuoshang=[99+2*sin(sita1) 2*cos(sita1)];
sita2=sita1-S_sub/(pi*(56*56-2-2))*2*pi;
for i=1:divide_number
    for j=1:1:n
        zuoshang=[99+(2+(j-1)*54/n)*sin(sita1) (2+(j-1)*54/n)*cos(sita1)];
        youshang=[99+(2+(j-1)*54/n)*sin(sita2) (2+(j-1)*54/n)*cos(sita2)];
        zuoxia=[99+(2+j*54/n)*sin(sita1) (2+j*54/n)*cos(sita1)];
        youxia=[99+(2+j*54/n)*sin(sita2) (2+j*54/n)*cos(sita2)];
        if  sita2>=-0.00001
            A(add_i,1:8)=[zuoshang youshang zuoxia youxia];
        else
            break;
        end
        add_i=add_i+1;
    end
    sita1=sita2;
    sita2=sita2-S_sub/(pi*(56*56-2-2))*2*pi;
end
A=[A;-A;A(1,:)];
%%
A_size=size(A);
A_size=A_size(1);
for i=1:A_size   %plot to debug
    i
    plot([A(i,1),A(i,5)],[A(i,2),A(i,6)]);
    hold on;
    plot([A(i,3),A(i,7)],[A(i,4),A(i,8)]);
    hold on;
    plot([A(i,1),A(i,3)],[A(i,2),A(i,4)]);
    hold on;
    plot([A(i,5),A(i,7)],[A(i,6),A(i,8)]);
    axis equal;
    xlim([-180 180])
end
%%
store_total=cell(divide_number*n,1);
std_sub=cell(divide_number*n,1);
std_ave=[];
%%
time=particle{1}(:,1);
for e=1:1:50%length(particle)
    %        e=randi([1 number_m]);
    disp(['Particle ID= ' num2str(e)]);
    matrixsize=size(particle{e});
    matrixsize=matrixsize(1);
    if matrixsize ~=0
        xp=100*particle{e}(:,3);
        yp=100*particle{e}(:,4);
        zp=100*particle{e}(:,5);
        time_new=[0:0.001 :200];
        a=interp1(time,[xp yp zp],time_new,'spline');
        xp=a(:,1);
        yp=a(:,2);
        zp=a(:,3);
        particle_id=particle{e}(:,2);
        % collect data into each subdomain
        for i=1:divide_number*n
            xp1=A(i,1);
            yp1=A(i,2);
            xp2=A(i,5);
            yp2=A(i,6);
            xb1=A(i,3);
            yb1=A(i,4);
            xb2=A(i,7);
            yb2=A(i,8);
            if xp1==xp2 && xb1==xb2 % prior straight && back is straight
                if yp1<0
                    haha=find(xp>=xp1& xp<xb1&zp<=yp1&zp>yp2);
                else
                    haha=find(xp<=xp1& xp>xb1&zp>=yp1&zp<yp2);
                end
            end
            if xp1==xp2 &&  xb1~=xb2 % prior straight && back is not straight
                if xp1>0
                    haha=find(xp>=xp1&zp<(yb1-yb2)/(xb1-xb2)*xp+yb1-(yb1-yb2)/(xb1-xb2)*xb1 & zp<(yp1-yb1)/(xp1-xb1)*xp+yp1-(yp1-yb1)/(xp1-xb1)*xp1 & zp>(yp2-yb2)/(xp2-xb2)*xp+yp2-(yp2-yb2)/(xp2-xb2)*xp2) ;
                else
                    haha=find(xp<=xp1&zp>(yb1-yb2)/(xb1-xb2)*xp+yb1-(yb1-yb2)/(xb1-xb2)*xb1 & zp>(yp1-yb1)/(xp1-xb1)*xp+yp1-(yp1-yb1)/(xp1-xb1)*xp1 & zp<(yp2-yb2)/(xp2-xb2)*xp+yp2-(yp2-yb2)/(xp2-xb2)*xp2) ;
                end
            end
            if xp1~=xp2 &&  xb1~=xb2 % prior is not straight && back is not straight
                if xp1>0
                    haha=find(zp>=(yp1-yp2)/(xp1-xp2)*xp+yp1-(yp1-yp2)/(xp1-xp2)*xp1 &zp<(yb1-yb2)/(xb1-xb2)*xp+yb1-(yb1-yb2)/(xb1-xb2)*xb1 & xp.^2+zp.^2>xp1.^2+yp1.^2  & xp.^2+zp.^2<xp2.^2+yp2.^2);
                else
                    haha=find(zp<=(yp1-yp2)/(xp1-xp2)*xp+yp1-(yp1-yp2)/(xp1-xp2)*xp1 &zp>(yb1-yb2)/(xb1-xb2)*xp+yb1-(yb1-yb2)/(xb1-xb2)*xb1  & xp.^2+zp.^2>xp1.^2+yp1.^2  & xp.^2+zp.^2<xp2.^2+yp2.^2);
                end
            end
            if xp1~=xp2 &&  xb1==xb2 % prior is not straight && back is straight
                if xp1>0
                    haha=find(zp>=(yp1-yp2)/(xp1-xp2)*xp+yp1-(yp1-yp2)/(xp1-xp2)*xp1 &zp>xb1 & xp.^2+zp.^2>xp1.^2+yp1.^2  & xp.^2+zp.^2<xp2.^2+yp2.^2);
                else
                    haha=find(zp<=(yp1-yp2)/(xp1-xp2)*xp+yp1-(yp1-yp2)/(xp1-xp2)*xp1 &zp<xb1 & xp.^2+zp.^2>xp1.^2+yp1.^2  & xp.^2+zp.^2<xp2.^2+yp2.^2);
                end
            end
            %%
            region_index=[];
            for j=1:size(haha)-1
                if haha(j+1)-haha (j)~=1
                    region_index=[region_index haha(j) haha(j+1)];
                end
            end
            region_index_size=size(region_index);
            region_index_size=region_index_size(2);
            if region_index_size >5;
                region_index(1)=[];
                region_index(end)=[];
                region_index=reshape(region_index,2,[]);
                region_index=region_index.';
                for j=1:(region_index_size-2)/2
                    a=region_index(j,1);
                    b=region_index(j,2);
                    if b-a>=10 %&& b-a<=50
                        std_sub_i=std(yp(a:b));%/(time(b)-time(a));
                        std_sub{i}=[std_sub{i} std_sub_i];
                        mm=ones(b-a+1,1)*e;
                        store_total{i}{e}= [xp(a:b) yp(a:b) zp(a:b) mm];
                    end
                end
            end
            %        store_total{i}=[store_total{i}; xp(haha) yp(haha) zp(haha)];
        end
    end
end
for i=1:divide_number*n
    sub_size=size(std_sub{i});
    sub_size=sub_size(2);
    std_ave(i,1)=sum(std_sub{i})/sub_size;
end
%%
A_size=size(A);
A_size=A_size(1);
figure;
set(gcf,'outerposition',get(0,'screensize'));
for i=1:A_size-1
    x=[A(i,1) A(i,3) A(i,7) A(i,5)];
    y=[A(i,2) A(i,4) A(i,8) A(i,6)];
    % fill(x,y,std_ave(i))
    fill(x,y,std_ave(i),'edgecolor', 'none')
    % fill(x,y,std_ave(i),'LineStyle', ':')
    colormap jet
    hold on;
end
axis equal
colorbar
view(180,-90);

