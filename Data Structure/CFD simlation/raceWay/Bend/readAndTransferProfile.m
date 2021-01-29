% this program read Boundary profile and transform it and store it to a
% new on so that we can speciy the inlet velocityBC in Fluent simulations
folder='C:\CFD_second_HHD\racewayOpenfoam\08022019\87\'
filename='keBCprofile.prof';
outFile='C:\CFD_second_HHD\racewayOpenfoam\08022019\91\inletBCProfile.prof';
waterLevel=0.2;
%% read profile
fprintf('reading Geometry file ...      ');
fid = fopen([folder filename]);
l=fgetl(fid); % read one line
N=sscanf(l,'%*s %*s %d)');
fgetl(fid);  
x = fscanf(fid,'%f\n',N);
 fgetl(fid);  
 fgetl(fid);  
y = fscanf(fid,'%f\n',N);
 fgetl(fid);  
 fgetl(fid);
 z = fscanf(fid,'%f\n',N);
 fgetl(fid);  
 fgetl(fid)
Vx = fscanf(fid,'%f\n',N);
 fgetl(fid);  
 fgetl(fid);  
Vy= fscanf(fid,'%f\n',N);
 fgetl(fid);  
 fgetl(fid);  
Vz= fscanf(fid,'%f\n',N);
fclose(fid);
fprintf('Done. \n');

 
%%
% quiver3(x,y,z,Vx,Vy,Vz,10)

%% filter paddle wheel
delete=find(y<0);
x(delete)=[];
y(delete)=[];
z(delete)=[];
Vx(delete)=[];
Vy(delete)=[];
Vz(delete)=[];


%% filter air
delete=find(z>waterLevel);
% x(delete)=[];
% y(delete)=[];
% z(delete)=[];
% Vx(delete)=[];
% Vy(delete)=[];
% Vz(delete)=[];

Vx(delete)=0;
Vy(delete)=0;
Vz(delete)=0;

%% transform
x(:)=0.8;
% yOld1=0.02;
% yOld2=0.54;
% yNew1=0.02;
% yNew2=1.08;
y=y*2;

%% polt
quiver3(x,y,z,Vx,Vy,Vz,10)
xlabel('x');
ylabel('y');
zlabel('z');
axis equal;
%%
% Vx=1/2*Vx;

%% write to file
N=length(x);
fid = fopen(outFile,'w');
fprintf(fid,'((BC point %d)\n',N);
fprintf(fid,'(x\n');
fprintf(fid,'%f\n',x);
fprintf(fid,')\n(y\n');
fprintf(fid,'%f\n',y);
fprintf(fid,')\n(z\n');
fprintf(fid,'%f\n',z);
fprintf(fid,')\n(x-velocity\n');
fprintf(fid,'%f\n',Vx);
fprintf(fid,')\n(y-velocity\n');
fprintf(fid,'%f\n',Vy);
fprintf(fid,')\n(z-velocity\n');
fprintf(fid,'%f\n',Vz);
fprintf(fid,')\n)\n');

fclose(fid);


