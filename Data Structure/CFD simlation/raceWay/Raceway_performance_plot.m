%% this file generate the mixing performance of subdomains
%1: generate position pairs of each zone and store into A and B
%2: for each particle collect data in each subdomain
%3: for each subdomains region_index store all first final position
%4: for each particle std_sub{i} store all the std values in sub i
%5: calculate the average of stds and use this to denote colour to plot

%% generate A and B contain the position of each subdomain
divide_number=300;
S_total=pi*( 56*56-2*2)+2*54*198;
S_sub=S_total/divide_number;
A=[];
B=[];
haha=[];  
A(1,1:2)=[-99 -2];
B(1,1:2)=[-99 -56];
for i=1:divide_number
a=A(i,1);
b=A(i,2);
c=B(i,1);
d=B(i,2);
delt=S_sub/54;    
a=a+delt;
c=c+delt;
        if a<99
        A=[A; a b];
        B=[B; c d];
            else
                break;    
            end  
end    
a=A(end,1);
sita=pi-(S_sub-(99-a)*54)/(pi*(56*56-2*2))*2*pi;
for i=1:divide_number
    a=99+2*sin(sita);
    b=2*cos(sita);
    c=56*sin(sita)+99;
    d=56*cos(sita);
        sita=sita-S_sub/(pi*(56*56-2-2))*2*pi;
    if  sita>=-0.00001
        A=[A; a b];
        B=[B; c d];
    else
        break;    
    end     
end   
A=[A;-A;A(1,1:2)];
B=[B;-B;B(1,1:2)];
%             for i=1:divide_number   %plot to debug
%             plot([A(i,1),B(i,1)],[A(i,2),B(i,2)]);
%             axis equal;
%             xlim([-180 180])
%             hold on;
%             end
store_total=cell(divide_number,1);
std_sub=cell(divide_number,1);
std_ave=[];
%%
  time=particle{1}(:,1);
for e=1:1:30
%         e=asas(e);
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
%% collect data into each subdomain
            for i=1:divide_number
            xp1=A(i,1); %p for prior
            yp1=A(i,2);
            xp2=B(i,1);
            yp2=B(i,2);
            xb1=A(i+1,1); % b for back
            yb1=A(i+1,2);
            xb2=B(i+1,1);
            yb2=B(i+1,2);
                if A(i,1)==B(i,1) &&  A(i+1,1)==B(i+1,1) % prior straight && back is straight
                    if B(i,2)<0
                    haha=find(xp>=A(i,1)& xp<A(i+1)&zp<0);
                    else
                        haha=find(xp<=A(i,1)& xp>A(i+1)&zp>0);
                    end
                end
                if A(i,1)==B(i,1) &&  A(i+1,1)~=B(i+1,1) % prior straight && back is not straight
                    if A(i,1)>0
                    haha=find(xp>=A(i,1)& zp<0& zp<(yb1-yb2)/(xb1-xb2)*xp+yb1-(yb1-yb2)/(xb1-xb2)*xb1);
                    else
                        haha=find(xp<=A(i,1)&zp>0& zp>(yb1-yb2)/(xb1-xb2)*xp+yb1-(yb1-yb2)/(xb1-xb2)*xb1);
                    end
                end
                if A(i,1)~=B(i,1) &&  A(i+1,1)~=B(i+1,1) % prior is not straight && back is not straight
                    if A(i,1)>0
                    haha=find(xp>0& zp>=(yp1-yp2)/(xp1-xp2)*xp+yp1-(yp1-yp2)/(xp1-xp2)*xp1 &zp<(yb1-yb2)/(xb1-xb2)*xp+yb1-(yb1-yb2)/(xb1-xb2)*xb1);
                    else
                        haha=find(xp<0& zp<=(yp1-yp2)/(xp1-xp2)*xp+yp1-(yp1-yp2)/(xp1-xp2)*xp1 &zp>(yb1-yb2)/(xb1-xb2)*xp+yb1-(yb1-yb2)/(xb1-xb2)*xb1);
                    end
                end
                if A(i,1)~=B(i,1) &&  A(i+1,1)==B(i+1,1) % prior is not straight && back is straight
                    if A(i,1)>0
                    haha=find( zp>=(yp1-yp2)/(xp1-xp2)*xp+yp1-(yp1-yp2)/(xp1-xp2)*xp1 & xp>B(i+1,1));
                    else
                        haha=find(zp<(yp1-yp2)/(xp1-xp2)*xp+yp1-(yp1-yp2)/(xp1-xp2)*xp1 & xp<B(i+1,1));
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
%                             std_sub_i= sum(abs(diff(yp(a:b))));                            
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
for i=1:divide_number
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
x=[A(i,1) B(i,1) B(i+1,1) A(i+1,1)];
y=[A(i,2) B(i,2) B(i+1,2) A(i+1,2)];
% fill(x,y,std_ave(i))
fill(x,y,std_ave(i),'edgecolor', 'none')
% fill(x,y,std_ave(i),'LineStyle', ':')
colormap jet
hold on;
end
axis equal
colorbar
view(180,-90);
