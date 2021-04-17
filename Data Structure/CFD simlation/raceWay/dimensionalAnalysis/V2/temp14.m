folder_path='C:\Users\chenshen.ETS01297\Desktop\temp' ;
file_name='111.csv';
data=[];
filename1 = [folder_path '\' file_name  ] ;
disp(filename1);
delimiterIn = ','; %read txt file

headerlinesIn = 1;

data_m = importdata(filename1,delimiterIn,headerlinesIn);
data_m.data(end,:)=[];
data=[data; data_m.data];
data=single(data);


xposition=data(:, 13); %store data into column vecter;
yposition=data(:, 14);
zposition=data(:, 15);
particleid=data(:, 12);
particletime=data(:,10);
%                     particle_tempeture=data(:, 5);
%                     particletime=data(:, 6);
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

for i=1:length(particle)
    for j=1:size(particle{i},1)
        if particle{i}(j,5)>0.28
            particle{i}=[];
            break;
        end
    end
end



for i=1:length(particle)
     if ~isempty(particle{i})
         time=particle{i}(:,1);
         zp=particle{i}(:,5);
         plot(time,zp);
         pause(0.02);
     end
end
