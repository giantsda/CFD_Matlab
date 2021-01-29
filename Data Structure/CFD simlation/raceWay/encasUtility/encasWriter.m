path='C:\CFD_second_HHD\racewayOpenfoam\06102019\78\timeAccumulated\';
index=[];
threshold=0.1;
for i=1:size(Data,1)
    index{i,1}=Data{i,1}*0;
end

for j=1:size(Data,2)-1
    for i=1:size(Data,1)
        haha=abs(Data{i,j});%>threshold;
        index{i}= index{i}+single(haha);
%         index{i}= index{i}+Data{i,1};
    end
end
  
filename1='binary.scl1';
filename2='binary.scl11';
fid1=fopen([path filename1]);
fid2=fopen([path filename2],'w');

%% write Binary
fprintf('writing %s       ',filename2);
A=fread(fid1,80*2,'uint8');% fixed length head
fwrite(fid2,A);
for block=1:length(index)
    fwrite(fid2,fread(fid1,82*2,'uint8'));
    fread(fid1,length(index{block}),'*single');
    fwrite(fid2,index{block},'single');
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


 