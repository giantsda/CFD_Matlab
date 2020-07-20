MainPath='D:\CFD_second_HHD\02212020\130';
cd (MainPath);
fid=fopen('130UcriticalResults.txt','a');
UcriticalPercentage=0.15;
fprintf(fid,"Results of UCritical for Uz>UCritical will occupy %d percentage of the water volume. \n",UcriticalPercentage*100);
for i=1:56
    caseN=i;
    Data={};
    cd (MainPath);
    cd (num2str(i));
    fprintf(fid,"Case %s: ",num2str(i));
    
    if mod(i,8)==1
        %% Read mesh, do not need if only interested in data files.
        filename='centeriod.txt';
        fid1=fopen(filename,'r');
        numberOfCells = fscanf(fid1, '%d',1);
        dec2hex(fread(fid1,1,'*int8'))
        meshStore=fread(fid1,numberOfCells*3,'*double');
        meshStore=reshape(meshStore,3,[]).';
        fclose(fid1);
    end
    
    files=dir('.');
    times=[];
    for i=4:length(files)
        file=files(i).name;
        if (~isempty(regexp(file(1:2) ,'[0-9][0-9]')) && isdir(file))
            if (str2num(file)>38)
                times=[times convertCharsToStrings(file)];
            end
        end
    end
    N=length(times);
    fprintf(fid,"total %d data files detected.\n",N);
%     N=2; %debug
    for n=1:N
        %% reading U Field
        U=[];
        time=char(times(n));
        fprintf("reading data %s for case %d\n",time,caseN);
        fpid = fopen([time '/U'], 'r');
        for i=1:20
            fgetl(fpid);
        end
        numberOfPoints = fscanf(fpid, '%d',1);
        dec2hex(fread(fpid,2,'*int8'));
        U =fread(fpid,numberOfPoints*3,'*double');
        U=reshape(U,3,[]).';
        U=abs(U(:,3));
        fclose(fpid);
        %% reading VOF Field
        first=1;
        if (first)
            fpid = fopen([time '/alpha.water'], 'r');
            for i=1:20
                fgetl(fpid);
            end
            numberOfPoints = fscanf(fpid, '%d',1);
            dec2hex(fread(fpid,2,'*int8'));
            vof= fread(fpid,numberOfPoints,'*double');
            fclose(fpid);
            Data.vof=vof;
            first=0;
        end
        
        Data.time(n)=str2num(time);
        Data.U{n}=U;
        Data.vof=vof;
    end
    Data.mesh=meshStore;
    %% filter first straight channel,air,small vertical U region
    i=find(Data.vof<0.7);
    Data.mesh(i,:)=[];
    Data.vof(i,:)=[];
    for n=1:N
        Data.U{n}(i,:)=[];
    end
    
    i=find(Data.mesh(:,2)<0);
    Data.mesh(i,:)=[];
    Data.vof(i,:)=[];
    for n=1:N
        Data.U{n}(i,:)=[];
    end
    
    i=find(Data.mesh(:,3)>0.18); % remove the nodes that is adjcent to air. Data here will have close to 1 vof but hugh velocity.
    Data.mesh(i,:)=[];
    Data.vof(i,:)=[];
    for n=1:N
        Data.U{n}(i,:)=[];
    end
    
    
    fprintf("Done with reading data.\n");
    
    %     scatter3(Data.mesh(:,1),Data.mesh(:,2),Data.mesh(:,3),2,'b','filled')
    %     axis equal;
    
    %         Ucritical=0.0065;
    %         Percentage=getP(Ucritical,Data,UcriticalPercentage)
    %         Un=linspace(0.039,0.041,10000);
    %         Pn=[];
    %         for i=1:length(Un)
    %             Pn(i)= getP(Un(i),Data,UcriticalPercentage);
    %         end
    %         plot(Un,Pn);
    
    
    tol=1e-6;
    Solution = bisection(@getP,0,1,tol,Data,UcriticalPercentage)
    fprintf(fid,"Ucritical=%2.5f\n----------------------------\n",Solution);
    
end
fclose(fid);




function Percentage=getP(Ucritical,Data,UcriticalPercentage)
% Ucritical
for n=1:length(Data)
    U=Data.U{n};
    P(n)=length(find(U>Ucritical))/length(U);
end
Percentage=(mean(P)-UcriticalPercentage)
fprintf("Tried %0.8f and got %0.8f\n",Ucritical,Percentage);
end


function p = bisection(f,a,b,tol,varargin)
% provide the equation you want to solve with R.H.S = 0 form.
% Write the L.H.S by using inline function
% Give initial guesses.
% Solves it by method of bisection.
% A very simple code. But may come handy
if f(a,varargin{1},varargin{2})*f(b,varargin{1},varargin{2})>0
    disp('Wrong choice bro')
else
    p = (a + b)/2;
    err = abs(a-b);
    while err > tol
        if f(a,varargin{1},varargin{2})*f(p,varargin{1},varargin{2})<0
            b = p;
        else
            a = p;
        end
        p = (a + b)/2;
        err = abs(a-b);
    end
end
end
