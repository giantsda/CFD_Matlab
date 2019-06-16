path='C:\CFD_second_HHD\racewayOpenfoam\06102019\78\Test\';
index=[];
threshold=0.1;
for i=1:size(Data,1)
    index{i,1}=Data{i,1}*0;
end

for j=1:size(Data,2)
    for i=1:size(Data,1)
        haha=abs(Data{i,j})>threshold;
        index{i}= index{i}+single(haha);
%         index{i}= index{i}+Data{i,1};
    end
end

filename1='Binary.scl1';
filename2='Binary.scl8';
fID1=fopen([path filename1]);
fID2=fopen([path filename2],'w');

%% write Binary
A=fread(fID1,80*2,'uint8');% fixed length head
fwrite(fID2,A);
for block=1:length(index)
    fwrite(fID2,fread(fID1,82*2,'uint8'));
    fread(fID1,length(index{block}),'*single');
    fwrite(fID2,index{block},'single');
%     break;
end
 fwrite(fID2,fread(fID1,40*2,'uint8'));
fclose(fID1);
fclose(fID2);

% %% write  ASCII            
% fprintf(fID2,'IndexVz\n');
% for block=1:length(index)   
%     fgetl(fID1);
%     for i=1:3
%         fprintf(fID2,'%s\n', fgetl(fID1));
%     end
%     fscanf(fID1,'%e', length(index{block}));
%     fprintf(fID2,'%f\n',index{block});
% end
% fclose(fID1);
% fclose(fID2);


 