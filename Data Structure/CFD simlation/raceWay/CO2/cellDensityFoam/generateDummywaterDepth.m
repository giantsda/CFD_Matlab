%The length of the straight channel does not significantly change the critical velocity,
%thus the critical vertical velocity is redefined as the 20 percent of the vertical velocity
%in the box that is defined as a rectangle of radius and 2*radius.

MainPath='/home/chen/Desktop/project/temp/241/2';



Data={};
cd (MainPath);


%% Read mesh, do not need if only interested in data files.
filename='centeriod.txt';
fid1=fopen(filename,'r');
numberOfCells = fscanf(fid1, '%d',1);
dec2hex(fread(fid1,1,'*int8'))
meshStore=fread(fid1,numberOfCells*3,'*double');
meshStore=reshape(meshStore,3,[]).';
fclose(fid1);

files=dir('.');
times=[];
for i=4:length(files)
    file=files(i).name;
    if (~isempty(regexp(file(1:2) ,'[0-9][0-9]')) && isdir(file))
        if (str2num(file)<200)
            times=[times convertCharsToStrings(file)];
        end
    end
end
 
fprintf("total %d data files detected.\n",length(times));
%     N=2; %debug
 
% times=["102.487"];
%% reading U Field
for n=1:length(times)
    U=[];
    time=char(times(n));

    Data.time{n}=time;
    fprintf("reading data %s of case  \n",time );
    fpid = fopen([time '/U'], 'r');
    for i=1:20
        fgetl(fpid);
    end
    numberOfPoints = fscanf(fpid, '%d',1);
    dec2hex(fread(fpid,2,'*int8'));
    U =fread(fpid,numberOfPoints*3,'*double');
    U=reshape(U,3,[]).';

    fclose(fpid);
    %% reading only the first VOF Field

    fpid = fopen([time '/waterDepth'], 'r');
    for i=1:20
        fgetl(fpid);
    end
    numberOfPoints = fscanf(fpid, '%d',1);
    dec2hex(fread(fpid,2,'*int8'));
    waterDepth= fread(fpid,numberOfPoints,'*double');
    fclose(fpid);
    waterDepth(find(waterDepth<0),:)=[];
    Data.waterDepth{n}=waterDepth;

%     hist(waterDepth,100);
%     pause();

%     fpid = fopen([time '/consumptionRate'], 'r');
%     for i=1:20
%         fgetl(fpid);
%     end
%     numberOfPoints = fscanf(fpid, '%d',1);
%     dec2hex(fread(fpid,2,'*int8'));
%     consumptionRate= fread(fpid,numberOfPoints,'*double');
%     fclose(fpid);
%     Data{n}.consumptionRate=consumptionRate;

%     fpid = fopen([time '/H'], 'r');
%     for i=1:20
%         fgetl(fpid);
%     end
%     numberOfPoints = fscanf(fpid, '%d',1);
%     dec2hex(fread(fpid,2,'*int8'));
%     H= fread(fpid,numberOfPoints,'*double');
%     fclose(fpid);
%     Data{n}.H=H;
% 
%     fpid = fopen([time '/HCO3'], 'r');
%     for i=1:20
%         fgetl(fpid);
%     end
%     numberOfPoints = fscanf(fpid, '%d',1);
%     dec2hex(fread(fpid,2,'*int8'));
%     HCO3= fread(fpid,numberOfPoints,'*double');
%     fclose(fpid);
%     Data{n}.HCO3=HCO3;
% 
%     fpid = fopen([time '/CO2'], 'r');
%     for i=1:20
%         fgetl(fpid);
%     end
%     numberOfPoints = fscanf(fpid, '%d',1);
%     dec2hex(fread(fpid,2,'*int8'));
%     CO2= fread(fpid,numberOfPoints,'*double');
%     fclose(fpid);
%     Data{n}.CO2=CO2;
% 
%     fpid = fopen([time '/CO32m'], 'r');
%     for i=1:20
%         fgetl(fpid);
%     end
%     numberOfPoints = fscanf(fpid, '%d',1);
%     dec2hex(fread(fpid,2,'*int8'));
%     CO32m= fread(fpid,numberOfPoints,'*double');
%     fclose(fpid);
%     Data{n}.CO32m=CO32m;



end

waterDepthS=vertcat(Data.waterDepth{:});
[N,edges] = histcounts(waterDepthS,2000);
centers=edges(2:end)-(edges(2)-edges(1))/2;

waterDepthDummy=[];
for i=1:length(centers)
    n=round(N(i)/1000);
    for j=1:n
        waterDepthDummy=[waterDepthDummy; centers(i)];
    end
end
 

cellDensity=0.4
lightIntensityDecayConstant=cellDensity * 133.4;
maxLightIntensity=1500;
lightDepth=waterDepth;
I = 1./exp( lightIntensityDecayConstant*(lightDepth)) *maxLightIntensity;
uMax = 0.00121113810513555;
uRes = 0.000294216828226870;
reactionRate = (tanh(I/505.3)*1*1*uMax-uRes)*cellDensity;
mean(reactionRate)

