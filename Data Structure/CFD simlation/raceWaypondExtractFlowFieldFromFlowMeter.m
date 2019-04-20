Caliration=[0.00100051078850230	0.0301863015082328;
    0.000998257129028534	0.0296510635717292;
    0.00100061048014776	0.0282036218985373;
    0.000986641900693   0.051101900619225;
    0.00100438979767638	0.0408383032671176;
    ];


path='E:\desktop\temp\racewayMeasurements\RPM=13.6\Calibration3\';
C=Caliration(3,:);
files=dir([path 'Region=1*']);
x=55;



fileNameMatrix=[];
value_s=[];
for i=1:length(files)
    filename=files(i).name;
    fileNameMatrix(i,:)=sscanf(files(i).name,'Region=%*dx=%fy=%fz=%f').';
end

y_mesh=[ 5    10    15    20    25    30    35    40    45  48];
z_mesh=[0.0500    0.1000    0.1500];

[y1,z1]=meshgrid(y_mesh,z_mesh*100);
for i=1:length(z_mesh)
    for j=1:length(y_mesh)
        k=find(fileNameMatrix(:,1)==x&fileNameMatrix(:,2)==y_mesh(j)&fileNameMatrix(:,3)==z_mesh(i));
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
        value_s(i,j)=a;
    end
end

value_s=value_s*C(1)+C(2);
% y1=56-y1;
figure;

pcolor(y1,z1,value_s);
shading interp;
axis equal
colormap jet
colorbar