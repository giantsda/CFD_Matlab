store_domains=cell(1,4);
for e=1:1:number
% e=randi([1 number_m]);
matrixsize=size(particle{e});
matrixsize=matrixsize(1);
if matrixsize ~=0
time=particle{e}(:,1);
xp=100*particle{e}(:,3);
yp=100*particle{e}(:,4);
zp=100*particle{e}(:,5);
%% generate subdomain
% there are 4 subdomains in a raceway pond system. I call them l1, l2, l3,
% l4. They are paddle domain, first turn, laminar domain, and second turn,
% repectfully.
k1=find(xp>-72 & xp<72 & zp<0);
l1=diff(k1);
l1=find(l1>5);
k2=find(xp>60);
l2=diff(k2);
l2=find(l2>5);
k3=find(xp>-72 & xp<72 & zp>0);
l3=diff(k3);
l3=find(l3>5);
k4=find(xp<-72);
l4=diff(k4);
l4=find(l4>5);
%%
store_size=cell(1,4); %initialize store_size, which contain the size of ls it is for the iterations
store_size{1}=size(l1);
store_size{1}=store_size{1}(1);
store_size{2}=size(l2);
store_size{2}=store_size{2}(1);
store_size{3}=size(l3);
store_size{3}=store_size{3}(1);
store_size{4}=size(l4);
store_size{4}=store_size{4}(1);
store=cell(1,4);
yposition_store=cell(1,4);
    if (store_size{1}~=0 && store_size{2}~=0 && store_size{3}~=0 && store_size{4}~=0 )
        for i=1:1:store_size{1}-1
            store{1}(i,1)=k1(l1(i)+1);      
            store{1}(i,2)=k1(l1(i+1)); 
        end  
        for i=1:1:store_size{2}-1
            store{2}(i,1)=k2(l2(i)+1);      
            store{2}(i,2)=k2(l2(i+1)); 
        end  
        for i=1:1:store_size{3}-1
        store{3}(i,1)=k3(l3(i)+1);      
        store{3}(i,2)=k3(l3(i+1)); 
        end 
        for i=1:1:store_size{4}-1
        store{4}(i,1)=k4(l4(i)+1);      
        store{4}(i,2)=k4(l4(i+1)); 
        end  
        for i=1:1:4
             if (isempty(store{1})==0 && isempty(store{2})==0 && isempty(store{3})==0 && isempty(store{4})==0 )
            yposition_store{i}(:,1)=yp(store{i}(:,1));
            yposition_store{i}(:,2)=yp(store{i}(:,2));
            yposition_store{i}(:,3)=yposition_store{i}(:,2)-yposition_store{i}(:,1);
            yposition_store{i}(:,4)=time(store{i}(:,2))-time(store{i}(:,1));
            yposition_store{i}(:,5)=e;
            store_domains{i}=[store_domains{i}; yposition_store{i}];
             else
                 continue;
             end
        end     
    else
       continue; 
    end
end
end
figure;
set(gcf,'outerposition',get(0,'screensize'));
subplot(2,4,1)
hist(store_domains{1}(:,3),300)
xlabel('vertical difference (cm)')
xlim([-20 20])
% title('distribution of ypos change of domain 1')
subplot(2,4,2)
hist(store_domains{1}(:,4),300)
xlim([0 20])
xlabel('time (seconds)')
% title('distribution of time span  of domain 1')
subplot(2,4,3)
hist(store_domains{2}(:,3),300)
xlim([-20 20])
xlabel('vertical difference (cm)')
% title('distribution of ypos change of domain 2')
subplot(2,4,4)
hist(store_domains{2}(:,4),300)
xlim([0 20])
xlabel('time (seconds)')
% title('distribution of time span  of domain 2')
subplot(2,4,5)
hist(store_domains{3}(:,3),300)
xlim([-20 20])
xlabel('vertical difference (cm)')
% title('distribution of ypos change of domain 3')
subplot(2,4,6)
hist(store_domains{3}(:,4),300)
xlim([0 20])
xlabel('time (seconds)')
% title('distribution of time span  of domain 3')
subplot(2,4,7)
hist(store_domains{4}(:,3),300)
xlim([-20 20])
xlabel('vertical difference (cm)')
% title('distribution of ypos change of domain 4')
subplot(2,4,8)
hist(store_domains{4}(:,4),300)
xlim([0 20])
xlabel('time (seconds)')
% title('distribution of time span  of domain 4')
% saveas(gcf,['E:\desktop\temp\'  '101.jpg']);