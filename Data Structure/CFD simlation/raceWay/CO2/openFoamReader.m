path='/home/chen/Desktop/project/co2/withManullyInjection/166/2/149.999/';
file='HCO3';
fid=fopen([path file]);
for i=1:20
    tline = fgets(fid);
end
tline = fgets(fid);
N=sscanf(tline,"%d");
fread(fid,1,'ubit8'); % read "("
HCO3= fread(fid,N,'*double');
fclose(fid)
file='alpha.water';
fid=fopen([path file]);
for i=1:20
    tline = fgets(fid);
end
tline = fgets(fid);
N=sscanf(tline,"%d");
fread(fid,1,'ubit8'); % read "("
vof= fread(fid,N,'*double');
fclose(fid)
air=find(vof<0.1);
HCO3(air)=[];
hist (HCO3,800)
 


