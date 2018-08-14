filename1 = 'E:\desktop\temp\export.csv';
disp(filename1);
delimiterIn = ','; %read txt file
headerlinesIn = 6;
data_m = importdata(filename1,delimiterIn,headerlinesIn);
data=data_m.data;
data=single(data);
 
xposition=data(:, 1); %store data into column vecter;
yposition=data(:, 2);
zposition=data(:, 3);
particleid=data(:, 4);
residence_time=data(:,5);
particletime=data(:, 6);

rownumber=length(particleid);%find how manys rows do I have ; ber is a vecter
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
    particle{a}(:,6)=residence_time(c : c-1+repeat(a));
    c=c+repeat(a);
end
disp('writting all data to particle.............. \n');
clearvars -except particle number folder_path
 


