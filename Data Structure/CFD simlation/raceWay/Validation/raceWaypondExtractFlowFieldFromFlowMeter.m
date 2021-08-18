close all;

Caliration=[0.00100051078850230	0.0301863015082328;
    0.000998257129028534	0.0296510635717292;
    0.00100061048014776	0.0282036218985373;
    0.000986641900693   0.051101900619225;
    0.00100438979767638	0.0408383032671176;
    0.00100217629084751	0.0534231690709292;
    0.001025496455292  0.018356439161767;
    ];

path='E:\desktop\temp\racewayMeasurements\RPM=13.6\Calibration7\';
C=Caliration(7,:);
files=dir([path 'Region=2*']);
x=-85;



fileNameMatrix=[];
value_s=[];
for i=1:length(files)
    filename=files(i).name;
    fileNameMatrix(i,:)=sscanf(files(i).name,'Region=%*dx=%fy=%fz=%f').';
end

y_mesh=fliplr([ 5    10    15    20    25    30    35    40    45  48]);
z_mesh=fliplr(linspace(2,17,11));

[y1,z1]=meshgrid(y_mesh,z_mesh);
for i=1:length(z_mesh)
    for j=1:length(y_mesh)
        k=find(fileNameMatrix(:,1)==x&fileNameMatrix(:,2)==y_mesh(j)&fileNameMatrix(:,3)==z_mesh(i));
        filename=[path files(k).name]
        
        fid = fopen(filename);
        if fid==-1
            value_s(i,j)=NaN;
            continue;
        end
        line=0;
        A=[];
        while  ~feof(fid)
            l = fgetl(fid);
            line=line+1;
            if ~isempty(l)
                if strcmp(l(1:5),'Time_')
                    a = sscanf(l,'Time_:%f  RPM_1s:%*f  averagedRPM:%f');
                    A=[A; a.'];
                end
            end
        end
        %         RPM=trapz(A(:,1),A(:,2))/(A(end,1)-A(1,1))
        RPM=A(end,2);
        value_s(i,j)=RPM;
        fclose(fid);
    end
end
if x==85;
    value_s=fliplr(value_s);
end
velocity=value_s*C(1)+C(2);
velocity(isnan(velocity))=0;

% y1=56-y1;
figure;
pcolor(y1,z1,fliplr(velocity));
shading interp;
axis equal
colormap jet
colorbar;
hold on;
scatter(reshape(y1,1,[]),reshape(z1,1,[]),'*')



