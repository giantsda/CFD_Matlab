path='E:\desktop\CFD\Raceway_pond_and_Peers_PBR_03132016--\11052016\30\data';
files = dir([ path '\1h*']); 
power_i=[]; %initialize
time_i=[];
Torque_sum=[];
mu=0.001003; %kg/m-s
for i=1:length(files)   % sort the file name for reading and plot
name=files(i).name;
index=find(name(:)=='-'); % index is the position of the cha '-'
time=name(index+1:end);
time_i(i,:)=[i str2num(time)];
end   
time_i=sortrows(time_i,2);
last_name=files(time_i(end,1)).name; 
%%
 for i =1:1:length(time_i)
        i=time_i(i,1);
        time=time_i(i,2);
        sita=1.428*time;
    for k=1:8 %k denotes for the blades 1 is blade_1_high etc.
    switch k
        case 1
        files = dir([ path '\1h*']);  
        normal_vector=[-cos(sita) -sin(sita) 0];
        disp([files(i).name '   /    ' last_name]);
        case 2
        files = dir([ path '\1l*']);  
        normal_vector=[-cos(sita+pi) -sin(sita+pi) 0];
        case 3
        files = dir([ path '\2h*']);  
        normal_vector=[-cos(sita+pi/2) -sin(sita+pi/2) 0];
        case 4
        files = dir([ path '\2l*']);  
        normal_vector=[-cos(sita+3/2*pi) -sin(sita+3/2*pi) 0];
        case 5
        files = dir([ path '\3h*']);  
        normal_vector=[-cos(sita+pi) -sin(sita+pi) 0];
        case 6
        files = dir([ path '\3l*']);  
        normal_vector=[-cos(sita) -sin(sita) 0];
        case 7
        files = dir([ path '\4h*']);  
        normal_vector=[-cos(sita+3/2*pi) -sin(sita+3/2*pi) 0];
        case 8
        files = dir([ path '\4l*']);  
        normal_vector=[-cos(sita+pi/2) -sin(sita+pi/2) 0];
    end
    Torque_i=[];
    blade_info = importdata([path '\' files(i).name],',');
    header=blade_info.textdata;
    blade_info=blade_info.data;
        for  j=1:length(blade_info)
            x_vof=blade_info(j,23);
            if x_vof>=0.05
            xp=blade_info(j,2);
            yp=blade_info(j,3);
            zp=blade_info(j,4);
            P=blade_info(j,5);
            face_area=blade_info(j,13);
            dxdx=blade_info(j,14);
            dydx=blade_info(j,15);
            dzdx=blade_info(j,16);
            dxdy=blade_info(j,17);
            dydy=blade_info(j,18);
            dzdy=blade_info(j,19);
            dxdz=blade_info(j,20);
            dydz=blade_info(j,21);
            dzdz=blade_info(j,22);    
            T=[-P+2*mu*dxdx mu*(dxdy+dydx) mu*(dxdz+dzdx);
            mu*(dxdy+dydx) -P+2*mu*dydy  mu*(dydz+dzdy);
            mu*(dxdz+dzdx)  mu*(dydz+dzdy) -P+2*mu*dzdz];
            stress_vector=normal_vector*T;
            r=[xp yp-0.3735 0];
            dTorque=cross(r,stress_vector);
            dTorque=dTorque(3)*face_area;
            Torque_i=[Torque_i dTorque];
            end
        end
            Torque=sum(Torque_i);
            Torque_sum(i,k)=Torque;
    end
 end
 for i=1:length(Torque_sum)
Torque_sum(i,9)=sum(Torque_sum(i,1:8));
end
ttime=time_i(:,2);
figure;
plot(ttime,Torque_sum(:,9))