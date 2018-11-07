filename1 = 'C:\CFD_second_HHD\HOOD\08302018\22\PT_9e-6.his';
disp(filename1);
delimiterIn = '\t'; %read txt file
headerlinesIn = 13;
data_m = importdata(filename1,delimiterIn,headerlinesIn);
disp('read done');
data=data_m.data;
data=single(data);
 
xposition=data(:, 3); %store data into column vecter;
yposition=data(:, 4);
zposition=data(:, 5);
particleid=data(:, 2);
particletime=data(:, 1);

ber=size(particleid);%find how manys rows do I have ; ber is a vecter
rownumber=ber(1);
number=1; %number of different particle
for i=1:1:rownumber-1
    if particleid(i) ~= particleid(i+1)
        number=number+1;
    end
end
particle=cell(1,number);  %create number matrixs to store my data,called particle{1}, particle{2}...particle{number}
j=1; %calculate times of jth particle repeating
repeat=ones(1,number); %k is a 1*number vector used to record repeat times
for i=1:1:rownumber-1
    if particleid(i)== particleid(i+1)
        repeat(j)=repeat(j)+1;
    else
        j=j+1;
    end
end
c=1;
for a=1:1:number  %for ath partocle
    particle{a}(:,1)=particletime(c : c-1+repeat(a));
    particle{a}(:,2)=particleid(c : c-1+repeat(a));
    particle{a}(:,3)=xposition(c : c-1+repeat(a));
    particle{a}(:,4)=yposition(c : c-1+repeat(a));
    particle{a}(:,5)=zposition(c : c-1+repeat(a));
    %                             particle{a}(:,6)=particle_tempeture(c : c-1+repeat(a));
    c=c+repeat(a);
end
disp('writting all data to particle.............. \n');
% clearvars -except particle number folder_path
 


