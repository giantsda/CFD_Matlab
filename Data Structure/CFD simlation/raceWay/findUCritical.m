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
    fprintf(fid,"total %d data files detected.\n",length(times));
    for n=1:length(times)
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
        fpid = fopen([time '/alpha.water'], 'r');
        for i=1:20
            fgetl(fpid);
        end
        numberOfPoints = fscanf(fpid, '%d',1);
        dec2hex(fread(fpid,2,'*int8'));
        vof= fread(fpid,numberOfPoints,'*double');
        U(find(vof<0.9),:)=[];
        fclose(fpid);
        Data{n}.time=time;
        Data{n}.U=U;
        %     Data{n}.vof=vof;
    end
    
    fprintf("Done with reading data.\n");
    
    
    %     Ucritical=0.0065;
    %     Percentage=getP(Ucritical,Data,UcriticalPercentage)
    %     Un=linspace(0,0.2,10);
    %     Pn=[];
    %     for i=1:length(Un)
    %         Pn(i)= getP(Un(i),Data);
    %     end
    %     plot(Un,Pn);
    
    x0 = 0.06;
    Solution = fsolve(@getP,x0,[],Data,UcriticalPercentage)
    fprintf(fid,"Ucritical=%2.5f\n----------------------------\n",Solution);
    
end
fclose(fid);


function Percentage=getP(Ucritical,Data,UcriticalPercentage)
Ucritical;
for n=1:length(Data)
    U=Data{n}.U;
    P(n)=length(find(U>Ucritical))/length(U);
end
Percentage=(mean(P)-UcriticalPercentage)
end

