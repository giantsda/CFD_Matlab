path='/home/chen/Desktop/racewayMeasurements/RPM=13.6/Calibration5/';
files=dir([path 'Region=2*']);
fileNameMatrix=[];
for i=1:length(files)
    filename=files(i).name;
    fileNameMatrix(i,:)=sscanf(files(i).name,'Region=2x=%fy=%fz=%f').';
end
 
x_mesh=[ 5    10    15    20    25    30    35    40    45    48];
y_mesh=[0.0500    0.1000    0.1500];

[x1,y1]=meshgrid(x_mesh,y_mesh*100);
for i=1:length(y_mesh)
    for j=1:length(x_mesh)
        k=find(fileNameMatrix(:,2)==x_mesh(j)&fileNameMatrix(:,3)==y_mesh(i));
        filename=[path files(k).name]
        
        fid = fopen(filename);
    line=0;
    while  ~feof(fid)
        l = fgetl(fid);
        line=line+1;
        if ~isempty(l)
            if strcmp(l(1:6),'Time_:')
                a = sscanf(l,'Time_:%*f  RPM_1s:%*f  averagedRPM:%f');
            end
        end
    end
    a
    value_s(i,j)=a;
    end
end 

value_s=value_s*0.00100438979767638+	0.0408383032671176;
x1=56-x1;
pcolor(x1,y1,value_s);
shading interp;
axis equal
colormap jet
colorbar