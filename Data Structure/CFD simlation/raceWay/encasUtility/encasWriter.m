path='D:\CFD_second_HHD\06102019\78\timeAccumulated\';
% index=[];
% threshold=0.1;
% index=zeros(length(Data{1}),1);
% for i=1:length(Data)
%     vof=Data{i}(:,2);
%     magU=Data{i}(:,3);
%     air=find(vof<0.5);
%     magU(air)=0;
% %     uZ=abs(uZ);
%     index=index+(magU<0.1);
% end
  
 

block=[];
block(1,1)=1;
block(1,2)=1+N(1)-1;
for i=2:length(N)
    block(i,1)= block(i-1,2)+1;
    block(i,2)= block(i,1)+N(i)-1;    
end
filename1='binary.scl1';
filename2='binary.scl10';
fid1=fopen([path filename1]);
fid2=fopen([path filename2],'w');

%% write Binary
fprintf('writing %s       ',filename2);
A=fread(fid1,80*2,'uint8');% fixed length head
fwrite(fid2,A);
for i=1:length(block)
    fwrite(fid2,fread(fid1,82*2,'uint8'));
    fread(fid1,N(i),'*single');
    fwrite(fid2,index(block(i,1):block(i,2)),'single');
%     break;
end
fwrite(fid2,fread(fid1,40*2,'uint8'));
fclose(fid1);
fclose(fid2);
fprintf('Done.\n',filename2);

%% write  ASCII            
% fprintf(fid2,'IndexVz\n');
% for block=1:length(index)   
%     fgetl(fid1);
%     for i=1:3
%         fprintf(fid2,'%s\n', fgetl(fid1));
%     end
%     fscanf(fid1,'%e', length(index{block}));
%     fprintf(fid2,'%f\n',index{block});
% end
% fclose(fid1);
% fclose(fid2);


 